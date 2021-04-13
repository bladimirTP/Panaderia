<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Message\MessageResponse;
use Illuminate\Http\Response;

class ReporteCompraController extends Controller
{
    public function compras_proveedor(Request $request)
    {
        // abort_unless(AuthController::currentUserHasPermission('insumo.listar'), 403);
        try {
            // $where = $this->datosInWhere($request);
            $orderBy = $request->orden ?  $request->orden : 'ASC';
            $ventas = DB::table('proveedor')
                ->join('compra', 'compra.fkidproveedor', '=', 'proveedor.idproveedor')
                ->join('detalle_compra', 'detalle_compra.fkidcompra', '=', 'compra.idcompra')
                ->join('insumo', 'insumo.idinsumo', '=', 'detalle_compra.fkidinsumo')
                ->select(
                    'compra.idcompra',
                    'compra.fecha_hora',
                    'compra.total',
                    DB::raw("CONCAT(proveedor.nombre,' ',proveedor.apellido) as proveedor"),
                    'proveedor.empresa as empresa',
                    'proveedor.telefono_celular',
                    'insumo.nombre as insumo',
                    'detalle_compra.cantidad',
                    'detalle_compra.precio',
                    'detalle_compra.unidad_medida',
                    'detalle_compra.subtotal'
                )
                ->whereDate('compra.fecha_hora', $request->fecha)
                ->where('proveedor.idproveedor', '=', $request->proveedor)
                ->orderBy('compra.fecha_hora', $orderBy)
                ->get();

            return response(["data" => $ventas, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => $th], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    // public function datosInWhere($request)
    // {
    //     $where = [];
    //     if ($request->sucursal) {
    //         array_push($where, ["venta.fkidsucursal", '=', $request->sucursal]);
    //     }
    //     return $where;
    // }
}
