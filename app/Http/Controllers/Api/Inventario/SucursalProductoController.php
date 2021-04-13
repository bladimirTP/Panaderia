<?php

namespace App\Http\Controllers\Api\Inventario;

use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use App\SucursalProducto;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class SucursalProductoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('sucursal_producto.listar'), 403);
        try {
            if (AuthController::currentUserHasRole('Administrador')) {
                $sucursalProducto = SucursalProducto::with(['producto.categoria'])->orderBy('idsucursal_producto', 'asc')->get();
            } else {
                $idsucursal = AuthController::getIdSucursalOfCurrentUser();
                $sucursalProducto = SucursalProducto::with(['sucursal', 'producto.categoria'])->where('fkidsucursal', $idsucursal)->orderBy('idsucursal_producto', 'asc')->get();
            }
            return response(["data" => $sucursalProducto, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('sucursal_producto.guardar'), 403);
        DB::beginTransaction();
        try {
            $idsucursal = AuthController::getIdSucursalOfCurrentUser();
            $request->request->add(['fkidsucursal' => $idsucursal]);
            if (SucursalProducto::where('fkidsucursal', $idsucursal)->where('fkidproducto', $request->fkidproducto)->count() > 0)
                return response(["data" => null, 'message' => MessageResponse::REPEAT_PRODUCT], Response::HTTP_INTERNAL_SERVER_ERROR);
            $sucursalProducto = SucursalProducto::create($request->all());
            DB::commit();
            return response(["data" => $sucursalProducto, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
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
      try {
        $sucursalProducto = SucursalProducto::with(['sucursal', 'producto', 'producto.categoria'])->where('fkidsucursal', $id)->orderBy('idsucursal_producto', 'asc')->get();
        return response(["data" => $sucursalProducto, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
      } catch (\Throwable $th) {
          return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
      }
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
        abort_unless(AuthController::currentUserHasPermission('sucursal_producto.actualizar'), 403);
        DB::beginTransaction();
        try {
            $sucursalProducto = SucursalProducto::find($id);
            $idsucursal = AuthController::getIdSucursalOfCurrentUser();
            $request->request->add(['fkidsucursal' => $idsucursal]);
            $sucursalProducto->update($request->all());
            DB::commit();
            return response(["data" => $sucursalProducto, 'message' => MessageResponse::UPDATE_OKEY], Response::HTTP_OK);
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
    public function destroy($id)
    {
        //
    }
}
