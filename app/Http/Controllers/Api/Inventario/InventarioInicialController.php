<?php

namespace App\Http\Controllers\Api\Inventario;

use App\DetalleInventario;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use App\InventarioInicial;
use App\SucursalProducto;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class InventarioInicialController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('inventario_inicial.listar'), 403);
        try {
            if (AuthController::currentUserHasRole('Administrador')) {
                $inventarioInicial = InventarioInicial::with(['sucursal'])->orderBy('idinventario_inicial', 'asc')->get();
            } else {
                $idsucursal = AuthController::getIdSucursalOfCurrentUser();
                $inventarioInicial = InventarioInicial::with(['sucursal'])->orderBy('idinventario_inicial', 'asc')->where('fkidsucursal', $idsucursal)->get();
            }
            return response(["data" => $inventarioInicial, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('inventario_inicial.guardar'), 403);
        DB::beginTransaction();
        try {
            $idsucursal = AuthController::getIdSucursalOfCurrentUser();
            $inventarioInicial = InventarioInicial::create([
                "fecha" => date("Y-m-d"),
                "fkidsucursal" => $idsucursal
            ]);

            $sucursalProductos = SucursalProducto::select('idsucursal_producto', 'stock')->where('fkidsucursal', $idsucursal)->get();
            foreach ($sucursalProductos as $value) {
                $inventarioInicial->detalleInventario()->attach($value->idsucursal_producto, ["cantidad" => $value->stock]);
            }
            DB::commit();
            return response(["data" => $inventarioInicial, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            DB::rollback();
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
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
            $detalle = DetalleInventario::with(['inventarioInicial.sucursal', 'productos.producto'])->where('fkidinventario_inicial', $id)->get();
            return response(["data" => $detalle, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        // DB::beginTransaction();
        // try {
        //     $inventarioInicial = InventarioInicial::find($id);
        //     $idsucursal = AuthController::getIdSucursalOfCurrentUser();
        //     $request->request->add(['fkidsucursal' => $idsucursal]);
        //     $inventarioInicial->
        //     DB::commit();
        //     return response(["data" => $sucursalProducto, 'message' => MessageResponse::UPDATE_OKEY], Response::HTTP_OK);
        // } catch (\Throwable $th) {
        //     DB::rollback();
        //     return response(["message" => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        // }
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
