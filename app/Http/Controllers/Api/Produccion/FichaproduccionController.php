<?php

namespace App\Http\Controllers\Api\Produccion;

use App\Http\Controllers\Controller;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use App\Fichaproduccion;
use App\Insumo;
use App\Detalleproduccion;
use App\InventarioProducto;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Message\MessageResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Response;
use App\Http\Util\Conversion;

class FichaproduccionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('ficha_produccion.listar'), 403);
        try {
            $detalles = Fichaproduccion::all();
            return response(["data" => $detalles, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        abort_unless(AuthController::currentUserHasPermission('ficha_produccion.guardar'), 403);
        try {
            DB::beginTransaction();
            $dateToday =  date("Y-m-d H:i:s");
            $ficha_produccion = new Fichaproduccion();
            $ficha_produccion->fecha_hora = $dateToday;
            $ficha_produccion->estado = $request->get('estado');
            $ficha_produccion->costo_total = $this->costototaldeproduccion($request->get('productos')); // not problem
            $ficha_produccion->save();
            $producto = $request->get('productos');
           
            foreach ($producto as $produ) {
                $detalle_produccion = new Detalleproduccion();
                $detalle_produccion->fkidficha_produccion = $ficha_produccion->idficha_produccion;
                $detalle_produccion->fkidproducto = $produ['idproducto'];
                $detalle_produccion->cantidad = $produ['cantidad'];
                $detalle_produccion->costo = $this->costoFinal($produ['idproducto'], $produ['cantidad']);
                $detalle_produccion->save();
            }
           
            DB::commit();
            return response(["data" => $ficha_produccion, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $e) {
            //dd($e);
            DB::rollback();
            //return response(["data"=> $e, 'message' => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
            return response(
                [
                    "message" => $e->getMessage(),
                    "code" => $e->getCode(),
                    "file" => $e->getFile(),
                    "line" => $e->getLine(),
                    "trace" => $e->getTraceAsString(),
                    "message1" => MessageException::DB_GETDATA
                ],
                Response::HTTP_INTERNAL_SERVER_ERROR
            );
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        abort_unless(AuthController::currentUserHasPermission('ficha_produccion.visualizar'), 403);
        try {
            $detalle = DetalleProduccion::with(['producto', 'fichaproduccion'])->where('fkidficha_produccion', $id)->get();
            return response(["data" => $detalle, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $idfichaproduccion)
    {
        abort_unless(AuthController::currentUserHasPermission('ficha_produccion.actualizar'), 403);
        try {
            DB::beginTransaction();
            if ($request->estado=='completado'){
                    $ficha_produccion = FichaProduccion::findOrFail($idfichaproduccion);
                    if ($ficha_produccion->estado == 'completado') {
                        return response(["data" => $ficha_produccion->estado, 'message' => MessageResponse::ERROR_PRODUCCION], Response::HTTP_INTERNAL_SERVER_ERROR);
                    }
                    $ficha_produccion->estado = $request->get('estado');
                    $ficha_produccion->update();
                    $itemficha = $this->itemdetalleproduccion($idfichaproduccion);
                    foreach ($itemficha as $ficha) {
                        if ($this->getidiventario($ficha->idproducto) > 0) {
                            $inventario_producto = InventarioProducto::findOrFail($this->getidiventario($ficha->idproducto));
                            $inventario_producto->stock = $this->actulizarineventarioproducto($ficha->idproducto) + $ficha->cantidad;
                            $inventario_producto->update();
                        } else {
                            return response(["data" => $ficha->idproducto, 'message' => MessageResponse::ERROR_INVENTARIO], Response::HTTP_INTERNAL_SERVER_ERROR);
                        }
                    }
                    foreach ($itemficha as $ficha) {
                        $itemreceta = $this->itemdetallereceta($ficha->idproducto);
                        $coeficiente = $this->coeficienteclave($ficha->idproducto, $ficha->cantidad);
                        foreach ($itemreceta as $receta) {
                                    $insumostock = Insumo::findOrFail($receta->insumo);
                                    $cantidadfinal = ($receta->cantidad * $coeficiente);   
                                if ($receta->unidad==$receta->abreviatura) {                    
                                    $insumostock->stock = ($receta->stock - $cantidadfinal);  
                                }else{
                                    $stock_descuento= Conversion::convert($cantidadfinal, $receta->unidad)->to($receta->abreviatura)->format(3,'.',',');
                                    }            
                            $insumostock->update(['stock' => $receta->stock - $stock_descuento]);    
                            //dd($insumostock->stock);
                        }               
                    }
                }else{
                    $ficha_produccion = Fichaproduccion::findOrFail($idfichaproduccion);
                    if ($ficha_produccion->estado == 'completado') {
                        return response(["data" => $ficha_produccion->estado, 'message' => MessageResponse::ERROR_PRODUCCION], Response::HTTP_INTERNAL_SERVER_ERROR);
                    }
                    if (!$request->productos) {
                        return response(["data" => $ficha_produccion->estado, 'message' =>"no esta mandando productos"], Response::HTTP_INTERNAL_SERVER_ERROR);
                    }
                            $id_detalle= DB::table('detalle_produccion as deta')
                            ->select('id_detalle')->where('fkidficha_produccion','=',$idfichaproduccion)->get();

                              $producto = $request->get('productos');
                                $cont=1;
                                $canti[]=array();
                                $product[]=array();
                            foreach ($producto as $pro) {
                                $canti[]=$pro['cantidad'];
                                $product[]=$pro['idproducto'];
                    
                            }
                            foreach ($id_detalle as $det) {
                                $detalle = DetalleProduccion::findOrFail($det->id_detalle);
                                $detalle->cantidad=$canti[$cont];
                                $detalle->costo= $this->costoFinal($product[$cont], $canti[$cont]);
                                $detalle->fkidproducto=$product[$cont];
                                $detalle->update();
                                $cont=$cont+1;
                            }
                            //$ficha_produccion = Fichaproduccion::findOrFail($idfichaproduccion);
                         ///  $ficha_produccion->detProduccion()->attach($idfichaproduccion,['fkidproducto'=>$pro[$cont], 'cantidad'=>$canti[$cont],'costo'=>$this->costoFinal($pro[$cont], $canti[$cont])]);  
                }
            DB::commit();
            return response(["data" => $ficha_produccion, 'message' => MessageResponse::UPDATE_OKEY], Response::HTTP_OK);  
        } catch (\Throwable $e) {
            DB::rollback();
            dd($e);
            return response(['message' => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($idfichaproduccion)
    {
     try {
            $ficha_produccion= Fichaproduccion::findOrFail($idfichaproduccion);
            if($ficha_produccion->estado=='completado'){
                return response(["data" => $ficha_produccion->estado, 'message' => MessageResponse::DELETE_PRODUCCION], Response::HTTP_INTERNAL_SERVER_ERROR);
            }else{
                $ficha_produccion->delete();
            }
            return response(["data" => $ficha_produccion->estado, 'message' => MessageResponse::DELETE_OKEY], Response::HTTP_INTERNAL_SERVER_ERROR);
     } catch (\Throwable $th) {
        return response(['message' => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
     }
        
    }

    public function costoFinal($idproducto, $cantidadfinal)
    {
        $costo_final = 0;
        $itemreceta = DB::table('receta as recet')
            ->join('producto as pro', 'recet.fkidproducto', '=', 'pro.idproducto')
            ->select('recet.costo_produccion as costo', 'recet.cantidad_producto as cantidad')
            ->where('recet.fkidproducto', '=', $idproducto)
            ->get();
        foreach ($itemreceta as $receta) {
            $costo_final = (($cantidadfinal / $receta->cantidad) * $receta->costo);
        }
        return $costo_final;
    }

    public function costototaldeproduccion($id_producto)
    {
        $cont = 0;
        $costo_total = 0;
        foreach ($id_producto as $product) {
            $costo_total = $costo_total + $this->costoFinal($product['idproducto'], $product['cantidad']);
        }
        return $costo_total;
    }
    public function actulizarineventarioproducto($idproducto)
    {
        $stock_inventario = DB::table('producto as pro')
            ->join('inventario_producto as inventario', 'inventario.fkidproducto', '=', 'pro.idproducto')
            ->select('inventario.stock')
            ->where('inventario.fkidproducto', '=', $idproducto)
            ->get();
        foreach ($stock_inventario as $inventario) {
            $stock = $inventario->stock;
        }
        return $stock;
    }
    public function getidiventario($idproducto)
    {
        $idinventario = 0;
        $stock_inventario = DB::table('producto as pro')
            ->join('inventario_producto as inventario', 'inventario.fkidproducto', '=', 'pro.idproducto')
            ->select('inventario.idinventario_producto')
            ->where('inventario.fkidproducto', '=', $idproducto)
            ->get();
        foreach ($stock_inventario as $inventario) {
            $idinventario = $inventario->idinventario_producto;
        }
        return $idinventario;
    }
    // creo que aqui
    public function itemdetallereceta($idproducto)
    {
        $cantidad = 0;
        $itemreceta = DB::table('receta_insumo as rec_insumo')
            ->join('receta as recet', 'recet.idreceta', '=', 'rec_insumo.fkidreceta')
            ->join('producto as pro', 'pro.idproducto', '=', 'recet.fkidproducto')
            ->join('insumo as insu', 'insu.idinsumo', '=', 'rec_insumo.fkidinsumo')
            ->join('unidad_medida as unidad', 'insu.fkidunidad_medida', '=', 'unidad.idunidad_medida')
            ->select('rec_insumo.cantidad as cantidad', 'insu.idinsumo as insumo', 'insu.stock as stock', 'unidad.abreviatura as abreviatura', 'rec_insumo.unidad_medida as unidad')
            ->where('recet.fkidproducto', '=', $idproducto)
            ->get();
        return $itemreceta;
    }
    public function coeficienteclave($idproducto, $cantidadfinal)
    {
        $costo_final = 0;
        $coefiente = 0;
        $itemreceta = DB::table('receta as recet')
            ->join('producto as pro', 'recet.fkidproducto', '=', 'pro.idproducto')
            ->select('recet.costo_produccion as costo', 'recet.cantidad_producto as cantidad')
            ->where('recet.fkidproducto', '=', $idproducto)
            ->get();
        foreach ($itemreceta as $receta) {
            $coefiente = ($cantidadfinal / $receta->cantidad);
        }
        return round($coefiente, 2);
    }

    public function itemdetalleproduccion($idfichaproduccion)
    {
        $itemdetalleficha = DB::table('ficha_produccion as ficha')
            ->join('detalle_produccion as detalle', 'ficha.idficha_produccion', '=', 'detalle.fkidficha_produccion')
            ->join('producto as pro', 'detalle.fkidproducto', 'pro.idproducto')
            ->select('pro.idproducto', 'detalle.cantidad as cantidad')
            ->where('detalle.fkidficha_produccion', '=', $idfichaproduccion)
            ->get();
        return $itemdetalleficha;
    }

  public function ActualizarProduccion($request,$idfichaproduccion){
    try {
        DB::beginTransaction();
        $dateToday =  date("Y-m-d H:i:s");
        $ficha_produccion = Fichaproduccion::findOrFail($idfichaproduccion);
        $ficha_produccion->fecha_hora = $dateToday;
        $ficha_produccion->estado = $request->get('estado');
        $ficha_produccion->costo_total = $this->costototaldeproduccion($request->get('productos')); // not problem
        $ficha_produccion->update();

        $producto = $request->get('productos');
        foreach ($producto as $produ) {
            $detalle_produccion = DetalleProduccion::findOrFail($idfichaproduccion);
           // $detalle_produccion->fkidficha_produccion = $ficha_produccion->idficha_produccion;
            $detalle_produccion->fkidproducto = $produ['idproducto'];
            $detalle_produccion->cantidad = $produ['cantidad'];
            $detalle_produccion->costo = $this->costoFinal($produ['idproducto'], $produ['cantidad']);
            $detalle_produccion->update();
        }
        DB::commit();
        return response(["data" => $detalle_produccion, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
    } catch (\Throwable $e) {
        DB::rollback();
        return response(['message' => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
    }
  }

    
}
