<?php

namespace App\Http\Controllers\Api\Compra;

use App\Http\Controllers\Controller;
use App\Insumo;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Message\MessageResponse;
use Illuminate\Http\Response;
use Illuminate\Http\Request;

class InsumoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('insumo.listar'), 403);
        try {
            $insumos = Insumo::with(['unidad_medida'])->orderBy('idinsumo', 'desc')->get();
            return response(["data" => $insumos, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
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
        abort_unless(AuthController::currentUserHasPermission('insumo.guardar'), 403);
        try {

            $insumo = Insumo::create($request->all());
            return response(['data' => $insumo, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Insumo  $insumo
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        abort_unless(AuthController::currentUserHasPermission('insumo.visualizar'), 403);
        try {
            $insumo = Insumo::with(['unidad_medida'])->find($id);
            if (!$insumo)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            return response(['data' => $insumo, 'message' => MessageResponse::GET_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Insumo  $insumo
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Insumo $insumo)
    {
        abort_unless(AuthController::currentUserHasPermission('insumo.actualizar'), 403);
        try {
            //$producto = Producto::find($id);
            if (!$insumo)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            $insumo->update($request->all());
            return response(['data' => $insumo, 'message' => MessageResponse::UPDATE_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

     /****
     * Verifica si los insumos estan en alguna compra
     * @param
     */

    public function verificar_insumo_en_compras($id_insumos){
        $insumos_en_compras = false;
        $contador = 0;

        while ($contador < count($id_insumos) && $insumos_en_compras == false) {
            $insumos = Insumo::find($id_insumos[$contador]);
            if($insumos->compras->isNotEmpty()){
                $insumos_en_compras = true;
                break;
            }
            $contador++;
        }
        return $insumos_en_compras;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Insumo  $insumo
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        abort_unless(AuthController::currentUserHasPermission('insumo.eliminar'), 403);
        try {
            $id_insumos = explode(',',$id);
            $insumo_en_compra = $this->verificar_insumo_en_compras($id_insumos);
            if(!$insumo_en_compra){
                Insumo::destroy($id_insumos);
            }else{
                return response(["data" => null, 'message' => MessageResponse::FOREIGN_EXIST], Response::HTTP_BAD_REQUEST);
            }
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
