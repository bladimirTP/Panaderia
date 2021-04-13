<?php

namespace App\Http\Controllers\Api\Inventario;

use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use App\Sucursal;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class SucursalController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('sucursal.listar'), 403);
        try {
            $sucursal = Sucursal::orderBy('idsucursal', 'asc')->get();
            return response(["data" => $sucursal, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('sucursal.guardar'), 403);
        DB::beginTransaction();
        try {
            $sucursal = Sucursal::create($request->all());
            DB::commit();
            return response(["data" => $sucursal, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            DB::rollback();
            return response(["message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
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
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        abort_unless(AuthController::currentUserHasPermission('sucursal.actualizar'), 403);
        DB::beginTransaction();
        try {
            $sucursal = Sucursal::find($id);
            $sucursal->update($request->all());
            DB::commit();
            return response(["data" => $sucursal, 'message' => MessageResponse::UPDATE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            DB::rollback();
            return response(["message" => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($idsDelete)
    {
        abort_unless(AuthController::currentUserHasPermission('sucursal.eliminar'), 403);
        try {
            $ids = explode(",", $idsDelete);
            Sucursal::destroy($ids);
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
          } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
          }
    }

    public function getAll()
    {
        try {
            $sucursal = Sucursal::orderBy('idsucursal', 'asc')->get();
            return response(["data" => $sucursal, 'message' => MessageResponse::GET_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
