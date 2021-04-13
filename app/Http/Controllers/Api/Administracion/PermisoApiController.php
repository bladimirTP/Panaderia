<?php

namespace App\Http\Controllers\Api\Administracion;

use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Permission;

class PermisoApiController extends Controller
{

    const PERMISO_ACCESO = 20;
    const PERMISO_LISTAR = 21;
    const PERMISO_GUARDAR = 22;
    const PERMISO_ACTUALIZAR = 23;
    const PERMISO_VISUALIZAR = 24;
    const PERMISO_ELIMINAR = 25;

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('permiso.listar'), 403);
        try {
            if (AuthController::currentUserHasRole('Root')) {
                $permisos = Permission::orderBy('id', 'asc')->get();
            } else {
                $permisos = Permission::whereNotIn(
                    'id',
                    [
                        self::PERMISO_ACCESO,
                        self::PERMISO_LISTAR,
                        self::PERMISO_GUARDAR,
                        self::PERMISO_ACTUALIZAR,
                        self::PERMISO_VISUALIZAR,
                        self::PERMISO_ELIMINAR
                    ]
                )->get();
            }
            return response(["data" => $permisos, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('permiso.guardar'), 403);
        DB::beginTransaction();
        try {
            $permission = Permission::create($request->all());
            DB::commit();
            return response(["data" => $permission, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            DB::rollback();
            return response(["message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
        return Permission::create($request->all());
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Permission $permisos)
    {
        return $permisos;
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
        abort_unless(AuthController::currentUserHasPermission('permiso.actualizar'), 403);
        try {
            $permiso = Permission::find($id);
            if (!$permiso)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            $permiso->update($request->all());
            return response(['data' => $permiso, 'message' => MessageResponse::UPDATE_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $permisos
     * @return \Illuminate\Http\Response
     */
    public function destroy($idPermisos)
    {
        abort_unless(AuthController::currentUserHasPermission('permiso.eliminar'), 403);
        try {
            $ids = explode(",", $idPermisos);
            Permission::destroy($ids);
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
