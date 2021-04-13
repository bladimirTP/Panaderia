<?php

namespace App\Http\Controllers\Api\Compra;

use App\Http\Controllers\Controller;
use App\UnidadMedida;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Message\MessageResponse;
use Illuminate\Http\Response;
use Illuminate\Http\Request;

class UnidadMedidaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('medidas.listar'), 403);
        try {
            $unidad_medida = UnidadMedida::orderBy('idunidad_medida', 'desc')->get();
            return response(["data" => $unidad_medida, "message" => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('medidas.guardar'), 403);
        try {
            $unidad_medida = UnidadMedida::create([
                'nombre' => strtolower($request->nombre),
                'abreviatura' => strtolower($request->abreviatura)
            ]);
            return response(["data" => $unidad_medida, "message" => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\UnidadMedida  $unidadMedida
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        abort_unless(AuthController::currentUserHasPermission('medidas.visualizar'), 403);
        try {
            $unidad = UnidadMedida::find($id);
            if (!$unidad)
                return response(["data" => $unidad, "message" => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            return response(["data" => $unidad, "message" => MessageResponse::GET_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\UnidadMedida  $unidadMedida
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, UnidadMedida $unidadMedida)
    {
        abort_unless(AuthController::currentUserHasPermission('medidas.actualizar'), 403);
        try {
            if (!$unidadMedida)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            $unidadMedida->update($request->all());
            return response(['data' => $unidadMedida, 'message' => MessageResponse::UPDATE_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\UnidadMedida  $unidadMedida
     * @return \Illuminate\Http\Response
     */
    public function destroy(UnidadMedida $unidadMedida)
    {
        abort_unless(AuthController::currentUserHasPermission('medidas.eliminar'), 403);
        try {
            $unidadMedida->delete();
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
