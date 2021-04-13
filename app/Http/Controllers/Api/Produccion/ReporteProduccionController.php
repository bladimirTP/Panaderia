<?php

namespace App\Http\Controllers\Api\Produccion;

use App\Http\Controllers\Controller;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Message\MessageResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Response;
class ReporteProduccionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    
   
     public function getreporte(Request $request)
    {
     abort_unless(AuthController::currentUserHasPermission('ficha_produccion.listar'), 403);
       try {
            $produccion=DB::table('detalle_produccion as produc')
            ->join('producto as product','product.idproducto','=','produc.fkidproducto')
            ->join('ficha_produccion','ficha_produccion.idficha_produccion','=','produc.fkidficha_produccion')
            ->select('product.nombre','produc.costo','produc.cantidad','produc.created_at as fecha','product.precio')
            ->where('ficha_produccion.estado','=','completado')
            ->whereBetween('produc.created_at', array($request->fecha, $request->sucursal))
            ->get();
             return response(["data" => $produccion, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
       } catch (\Throwable $th) {
           
            return response(["message" => "Fecha fuera de rango"], Response::HTTP_INTERNAL_SERVER_ERROR);
       }
        
    }
}
