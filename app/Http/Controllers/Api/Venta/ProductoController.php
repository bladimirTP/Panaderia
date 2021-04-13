<?php

namespace App\Http\Controllers\Api\Venta;

use App\Http\Controllers\Controller;

use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Message\MessageResponse;
use App\InventarioProducto;
use App\Producto;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ProductoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('producto.listar'), 403);
        try {
            $productos = Producto::with(['categoria'])->orderBy('idproducto', 'asc')->get();
            return response(["data" => $productos, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('producto.guardar'), 403);
        DB::beginTransaction();
        try {
            $path = Storage::disk('public')->put('images', $request->file('foto'));
            $data = $request->all();
            $data['foto'] = $path;
            $producto = Producto::create($data);
            InventarioProducto::create([
                'fkidproducto' => $producto->idproducto
            ]);
            DB::commit();
            return response(['data' => $producto, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('producto.visualizar'), 403);
        try {
            $producto = Producto::with(['categoria'])->find($id);
            if (!$producto)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            return response(['data' => $producto, 'message' => MessageResponse::GET_OKEY]);
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
        abort_unless(AuthController::currentUserHasPermission('producto.actualizar'), 403);
        try {
            $producto = Producto::find($id);
            if (!$producto)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            $producto->update($request->all());
            return response(['data' => $producto, 'message' => MessageResponse::UPDATE_OKEY]);
        } catch (\Throwable $th) {
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
        abort_unless(AuthController::currentUserHasPermission('producto.eliminar'), 403);
        try {
            $ids = explode(",", $idsDelete);
            Producto::destroy($ids);
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
