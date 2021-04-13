<?php

namespace App\Http\Controllers\Api\Compra;

use App\Compra;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Message\MessageResponse;
use App\Http\Resources\CompraResource;
use App\Insumo;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Http\Util\Conversion;

class CompraController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('compra.listar'), 403);
        try {
            $compra = Compra::with(['proveedor'])->orderBy('idcompra', 'desc')->get();
            return response(["data" => $compra, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function verificar_multiplo_medida($medida_entrada, $medida_salida)
    {
        $multiplos_masa = ['kg', 'g', 'mg', 'qq46', 'qq50', 'qq25', 'oz', 'lb'];
        $multiplos_volumen = ['lts', 'ml'];
        if (in_array($medida_entrada, $multiplos_masa) && in_array($medida_salida, $multiplos_masa)) {
            return true;
        } elseif (in_array($medida_entrada, $multiplos_volumen) && in_array($medida_salida, $multiplos_volumen)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        abort_unless(AuthController::currentUserHasPermission('compra.guardar'), 403);
        DB::beginTransaction();
        try {
            $compra = Compra::create($request->all());
            //insumos: es el array que llega desde el frontend
            $insumos = $request->get('insumos');
            $cantidad = 0;
            foreach ($insumos as $key => $value) {
                $insumo = Insumo::find($value['id']);
                $medida_entrada = strtolower($value['unidad_medida']);
                $medida_salida = strtolower($value['unidad_salida']);
                // verifico si esta en la misma unidad de medida que en insumo
                if ($medida_entrada != $medida_salida) {
                    // verifico si ambas medidas, pertenece al mismo multiplo de masa o volumes
                    if ($this->verificar_multiplo_medida($medida_entrada, $medida_salida)) {
                        // Realizo la conversion de unidades
                        $cantidad = Conversion::convert($value['cantidad'], $medida_entrada)->to($medida_salida)->format(3, '.', ',');
                    } else {
                        // si no son multiplos, retorno un error de unidad de medida
                        return response(["data" => null, 'message' => MessageResponse::ERROR_MEDIDA], Response::HTTP_BAD_REQUEST);
                    }
                } else {
                    // si las medidas son iguales, asigno la cantidad correspondiente
                    $cantidad = $value['cantidad'];
                }
                $compra->insumos()->attach(
                    $value['id'],
                    [
                        'cantidad' => $value['cantidad'],
                        'precio' => $value['precio'],
                        'subtotal' => $value['subtotal'],
                        'unidad_medida' => $value['unidad_medida']
                    ]
                );
                $stock = $insumo->stock + $cantidad;
                $insumo->update(['stock' => $stock]);
            }
            DB::commit();
            return response(['data' => $compra, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            DB::rollBack();
            return response(["data" => $th, "message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Compra  $compra
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {
            // $compra = DetalleCompra::with('compra.proveedor','insumos.unidad_medida')->where('fkidcompra',$id)->get();
            $compra = Compra::find($id);
            return response(["data" => new CompraResource($compra), 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Compra  $compra
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Compra $compra)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Compra  $compra
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        abort_unless(AuthController::currentUserHasPermission('compra.eliminar'), 403);
        try {
            $id_compra = explode(',', $id);
            for ($i = 0; $i < count($id_compra); $i++) {
                $compra = Compra::find($id_compra[$i]);
                $compra->insumos()->detach();
                $compra->delete();
            }
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
