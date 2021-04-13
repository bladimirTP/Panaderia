<?php

namespace App\Http\Controllers\Api\Inventario;

use App\DetalleSalida;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use App\InventarioProducto;
use App\OrdenSalida;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class OrdenSalidaController extends Controller
{
    const CODE_STOCK_VALIDATE = 23514;
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('orden_salida.listar'), 403);
        try {
            $ordenSalida = OrdenSalida::with(['sucursal'])->orderBy('idorden_salida', 'desc')->get();
            return response(["data" => $ordenSalida, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        //abort_unless(AuthController::currentUserHasPermission('orden_salida.guardar'), 403);
        // DB::beginTransaction();
        // try {
        //     $ordenSalida = OrdenSalida::create([
        //         "numero_orden" => $request->numero_orden,
        //         "fecha" => date("Y-m-d"),
        //         "nota" => $request->nota,
        //         "fkidsucursal" => auth()->user()->usuario->personal->sucursal->idsucursal
        //     ]);

        //     $productos = $request->inv_producto;
        //     foreach ($productos as $value) {
        //         $ordenSalida->invProducto()->attach($value['fkidinv_producto'], ["cantidad" => $value['cantidad']]);
        //     };
        //     DB::commit();
        //     return response(["data" => $ordenSalida, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        // } catch (\Throwable $th) {
        //     DB::rollback();
        //     return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        // }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        abort_unless(AuthController::currentUserHasPermission('orden_salida.visualizar'), 403);
        try {
            $detalle = DetalleSalida::with(['detalle.producto', 'ordenSalida'])->where('fkidorden_salida', $id)->get();
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
        abort_unless(AuthController::currentUserHasPermission('orden_salida.actualizar'), 403);
        DB::beginTransaction();
        try {
            $ordenSalida = OrdenSalida::find($id);
            if ($request->estado == 0 && $ordenSalida->estado != 0) {
                $productos = $request->productos;
                $ordenSalida->update(['estado' => $request->estado]);
                $ordenSalida->inventarioProducto()->detach();
                foreach ($productos as $value) {
                    $ordenSalida->inventarioProducto()->attach($value['fkidinventario_producto'], ['cantidad' => $value['cantidad']]);
                    $inventarioProducto = InventarioProducto::where('fkidproducto', $value['fkidinventario_producto'])->first();
                    if ($inventarioProducto != null) {
                        $inventarioProducto->update(['stock' => $inventarioProducto->stock - $value['cantidad']]);
                    } else {
                        throw new Exception("NO existe el producto");
                    }
                }
                DB::commit();
                return response(["data" => $ordenSalida, 'message' => MessageResponse::UPDATE_OKEY], Response::HTTP_OK);
            }
            return response(['message' => "La orden ya ha sido enviada."], Response::HTTP_BAD_REQUEST);
        } catch (\Throwable $th) {
            DB::rollback();
            if ($th->getCode() == self::CODE_STOCK_VALIDATE) {
                return response(["message" => MessageException::DB_STOCK_VALIDATE], Response::HTTP_INTERNAL_SERVER_ERROR);
            }
            return response(["data" => $th, "message" => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
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
