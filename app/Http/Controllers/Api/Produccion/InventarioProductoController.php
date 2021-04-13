<?php

namespace App\Http\Controllers\Api\Produccion;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Http\Message\MessageResponse;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\InventarioProducto;
use Illuminate\Support\Facades\DB;

class InventarioProductoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('inventario_producto.listar'), 403);
        try {
            $inventarioProducto = InventarioProducto::with(['producto'])->orderBy('idinventario_producto', 'asc')->get();
            return response(["data" => $inventarioProducto, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('inventario_producto.guardar'), 403);
        DB::beginTransaction();
        try {
            $inventarioProducto = InventarioProducto::create($request->all());
            DB::commit();
            return response(["data" => $inventarioProducto, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('inventario_producto.visualizar'), 403);
        try {
            $inventarioProducto = InventarioProducto::with('producto')->where('idinventario_producto', $id)->get();
            return response(["data" => $inventarioProducto, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
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
        //
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
