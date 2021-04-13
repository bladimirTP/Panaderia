<?php

namespace App\Http\Controllers\Api\Inventario;

use App\DetalleEntrada;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use App\OrdenEntrada;
use App\OrdenSalida;
use App\SucursalProducto;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class OrdenEntradaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('orden_entrada.listar'), 403);
        try {
            if (AuthController::currentUserHasRole('Administrador')) {
                $ordenEntrada = OrdenEntrada::with(['sucursal'])->orderBy('idorden_entrada', 'desc')->get();
            } else {
                $idsucursal = AuthController::getIdSucursalOfCurrentUser();
                $ordenEntrada = OrdenEntrada::with(['sucursal'])->where('fkidsucursal', $idsucursal)->orderBy('idorden_entrada', 'desc')->get();
            }
            return response(["data" => $ordenEntrada, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('orden_entrada.guardar'), 403);
        DB::beginTransaction();
        try {
            $ordenEntrada = OrdenEntrada::create([
                "fecha_hora" => date("Y-m-d H:i:s"),
                "nota" => $request->nota,
                "fkidsucursal" => AuthController::getIdSucursalOfCurrentUser()
            ]);

            $productos = $request->productos;
            foreach ($productos as $value) {
                $ordenEntrada->inventarioProducto()->attach($value['fkidproducto'], ["cantidad" => $value['cantidad']]);
            };

            $ordenNueva = OrdenEntrada::find($ordenEntrada->idorden_entrada);

            $ordenSalida = OrdenSalida::create([
                "numero_orden" => $ordenNueva->numero_orden,
                "fecha_hora" => $ordenEntrada->fecha_hora,
                "nota" => $ordenEntrada->nota,
                "fkidsucursal" => $ordenEntrada->fkidsucursal,
            ]);

            $productos = $request->productos;
            foreach ($productos as $value) {
                $ordenSalida->inventarioProducto()->attach($value['fkidproducto'], ["cantidad" => $value['cantidad']]);
            };

            DB::commit();
            return response(["data" => $ordenEntrada, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            DB::rollback();
            return response(["data" => $th, "message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
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
            $detalle = DetalleEntrada::with(['detalle.producto', 'ordenEntrada'])->where('fkidorden_entrada', $id)->get();
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
        abort_unless(AuthController::currentUserHasPermission('orden_entrada.actualizar'), 403);
        DB::beginTransaction();
        try {
            $sucursal = AuthController::getIdSucursalOfCurrentUser();
            $ordenEntrada = OrdenEntrada::find($id);
            $ordenSalida = OrdenSalida::where('numero_orden', $ordenEntrada->numero_orden)->first();
            if ($request->estado == 1 && $ordenEntrada->estado != 1 && $ordenSalida->estado == 0) {
                $productos = $ordenSalida->inventarioProducto()->get();
                foreach ($productos as $value) {
                    $item = SucursalProducto::where('fkidsucursal', $sucursal)->where('fkidproducto', $value->pivot->fkidinventario_producto)->first();
                    $item->update(['stock' => $item->stock + $value->pivot->cantidad]);
                }
                $ordenEntrada->update(['estado' => $request->estado]);
                DB::commit();
                return response(["data" => $ordenEntrada, 'message' => MessageResponse::UPDATE_OKEY], Response::HTTP_OK);
            } else {
                return response(["data" => $ordenEntrada, 'message' => "La orden de salida no ha sido procesada aun."], Response::HTTP_OK);
            }
        } catch (\Throwable $th) {
            DB::rollback();
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
