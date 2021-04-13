<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Message\MessageResponse;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class ReporteVentaController extends Controller
{
    //
    public function ventasDiarias(Request $request)
    {
        
        try {
            $where = $this->datosInWhere($request);
            $orderBy = $request->orden ?  $request->orden : 'ASC';
            $ventas = DB::table('venta')
                ->join('cliente', 'venta.fkidcliente', '=', 'cliente.idcliente')
                ->join('usuario', 'venta.fkidusuario', '=', 'usuario.idusuario')
                ->join('personal', 'usuario.fkidpersonal', '=', 'personal.idpersonal')
                ->join('sucursal', 'venta.fkidsucursal', '=', 'sucursal.idsucursal')
                ->select('venta.idventa', 'venta.fecha_hora', 'venta.total', DB::raw("CONCAT(cliente.nombre,' ',cliente.apellido) as cliente"), DB::raw("CONCAT(personal.nombre,' ',personal.apellido) as vendedor"), 'sucursal.nombre as sucursal')
                ->whereDate('venta.fecha_hora', $request->fecha)
                ->where($where)
                ->orderBy('venta.fecha_hora', $orderBy)
                ->get();
            return response(["data" => $ventas, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["data"=> $th, "message" => $th], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function datosInWhere($request)
    {
        $where = [];
        if ($request->sucursal) {
            array_push($where, ["venta.fkidsucursal", '=', $request->sucursal]);
        }
        return $where;
    }
}
