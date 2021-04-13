<?php

namespace App\Http\Controllers\Api\Produccion;

use App\Exceptions\MessageException;
use App\Http\Controllers\Controller;
use App\Http\Controllers\Auth\AuthController;
use Illuminate\Database\Eloquent\Builder;
use App\Http\Message\MessageResponse;
use Illuminate\Http\Request;
use App\Receta;
use App\RecetaInsumo;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class RecetaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {   abort_unless(AuthController::currentUserHasPermission('ficha_produccion.guardar'), 403);
        $receta = DB::table('receta as produc')
            ->join('producto as pro', 'pro.idproducto', '=', 'produc.fkidproducto')
            ->select('produc.idreceta', 'produc.bollos', 'produc.cantidad_producto', 'produc.costo_produccion', 'produc.peso', 'produc.total_masa', 'pro.nombre as producto')
            ->where('produc.deleted_at','=',null)
            ->get();
        return response()->json(['data' => $receta], 200);
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
    {  abort_unless(AuthController::currentUserHasPermission('ficha_produccion.guardar'), 403);

        try {
            DB::beginTransaction();
                    $receta = new Receta;
                    $receta->costo_produccion = $this->costo_produccion($request->get('insumos'));
                    $receta->fkidproducto = $request->get('producto');
                    $receta->total_masa = $this->cantidad_masa($request->get('insumos'));
                    $receta->peso = $request->get('peso');
                    $receta->bollos = (($this->cantidad_masa($request->get('insumos'))) / $request->get('peso'));
                    $receta->cantidad_producto = (($receta->bollos) * 30);

                    $receta->save();

                    $id_insumo = $request->get('insumos');
                    foreach ($id_insumo as $insumo) {
                        $receta_insumo = new RecetaInsumo;
                        $receta_insumo->fkidreceta = $receta->idreceta;
                        $receta_insumo->fkidinsumo = $insumo['idinsumo'];
                        $receta_insumo->cantidad = $insumo['cantidad'];
                        $receta_insumo->unidad_medida = $insumo['unidad'];
                        $receta_insumo->costo = ($insumo['cantidad']) * ($this->obtener_iteminsumo($insumo['idinsumo']));
                        $receta_insumo->save();
                    }
                    //$receta->costo_produccion = $request->get('costo_produccion');
             
            DB::commit();
            return response(["data" => $receta, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $e) {
           // dd($e);
            DB::rollback();
            return response(["data" => $e, "respuesta" => $e, "message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($receta)
    {
        abort_unless(AuthController::currentUserHasPermission('ficha_produccion.guardar'), 403);
        $fichaproduc = DB::table('receta_insumo as recet')
            ->select('recet.fkidinsumo','recet.cantidad','recet.unidad_medida','recet.fkidreceta')->where('fkidreceta','=',$receta)
            ->get();

            $recetas = DB::table('receta as produc')
            ->select('produc.idreceta','produc.peso','produc.fkidproducto')->where('produc.idreceta','=',$receta)
            ->get();

        return response()->json(['data' =>$recetas,'detalle'=>$fichaproduc], 200);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($receta)
    {
        
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id_receta)
    {
      
        try {
            DB::beginTransaction();
            if ($request->insumos) {
            $receta = Receta::findOrFail($id_receta);
            $receta->costo_produccion = $this->costo_produccion($request->get('insumos'));
            $receta->fkidproducto = $request->get('producto');
            $receta->total_masa = $this->cantidad_masa($request->get('insumos'));
            $receta->peso = $request->get('peso');
            $receta->bollos = (($this->cantidad_masa($request->get('insumos'))) / $request->get('peso'));
            $receta->cantidad_producto = (($receta->bollos) * 30);

            $receta->update();

            $id_insumo = $request->get('insumos');

            $id_detalle= DB::table('receta_insumo as insu')
            ->select('id_detalle')->where('fkidreceta','=',$id_receta)->get();
                $cont=1;
                $insumo[]=array();
                $cantidad[]=array();
                $unidad[]=array();
                
                    foreach ($id_insumo as $insu) {
                        $insumo[]=$insu['idinsumo'];
                        $cantidad[]=$insu['cantidad'];
                        $unidad[]=$insu['unidad'];
            
                    }
                    foreach ($id_detalle as $det) {
                        $receta_insumo = RecetaInsumo::findOrFail($det->id_detalle);
                            $receta_insumo->fkidreceta = $receta->idreceta;
                            $receta_insumo->fkidinsumo = $insumo[$cont];
                            $receta_insumo->cantidad = $cantidad[$cont];
                            $receta_insumo->unidad_medida = $unidad[$cont];
                            $receta_insumo->costo = ($cantidad[$cont]) * ($this->obtener_iteminsumo($insumo[$cont]));
        
                            $receta_insumo->update();
                         
                            $cont=$cont+1;
                    }
                }else{
                    return response(["respuesta" => "no hay insumos", "message" => "No esta mandando insumos"], Response::HTTP_INTERNAL_SERVER_ERROR);
                }
           
            DB::commit();
            return response(["data" => $receta_insumo, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $e) {
            dd($e);
            DB::rollback();
            return response(["respuesta" => $e, "message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($idreceta)
    {   
    
             Receta::destroy($idreceta);
           
    }


    public function costo_gramo($costo, $unidad_medida)
    {
        if ($unidad_medida == 'kg') {
            $result = ($costo / 1000);
            return $result;
        }
        if ($unidad_medida == 'qq25') {
            $result = (($costo / 25) / 1000);
            return $result;
        }
        if ($unidad_medida == 'qq50') {
            $result = (($costo / 50) / 1000);
            return $result;
        }
        if ($unidad_medida == 'qq46') {
            $result = (($costo / 46) / 1000);
            return $result;
        }
        if ($unidad_medida == 'g') {
            $result = $costo;
            return $result;
        }
        if ($unidad_medida == 'lts') {
            $result = ($costo / 1000);
            return $result;
        }
        if ($unidad_medida == 'ml') {
            $result = $costo;
            return $result;
        }
        if ($unidad_medida == 'ud.') {
            $result = $costo;
            return $result;
        }
    }

    public function obtener_iteminsumo($idinsumo)
    {
        $result = 0;
        $insumo = DB::table('insumo as insu')
            ->join('unidad_medida as unidad', 'insu.fkidunidad_medida', '=', 'unidad.idunidad_medida')
            ->select('insu.idinsumo', 'insu.costo', 'insu.nombre', 'unidad.abreviatura')
            ->where('insu.idinsumo', '=', $idinsumo)
            ->get();
        foreach ($insumo as $insu) {
            $result = $this->costo_gramo($insu->costo, $insu->abreviatura);
            return $result;
        }
    }
    public function costo_produccion($insumo)
    {
        $costo = 0;
        foreach ($insumo as $insu) {
            $costo = $costo + ($insu['cantidad']) * ($this->obtener_iteminsumo($insu['idinsumo']));
        }
        return $costo;
    }
    public function cantidad_masa($insumo)
    {
        $masa_total = 0;
        foreach ($insumo as $insu) {
            $masa_total = $masa_total + ($insu['cantidad']);
        }
        return $masa_total;
    }
}
