<?php

namespace App\Http\Controllers\Api\Produccion;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use Illuminate\Database\Eloquent\Builder;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Message\MessageResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Response;

class ReportProduccionController extends Controller
{
    public function index($fechainicio, $fechafin)
    {
       // abort_unless(AuthController::currentUserHasPermission('ficha_produccion.listar'), 403);
       
        $produccion=DB::table('detalle_produccion as produc')
        ->join('producto as product','product.idproducto','=','produc.fkidproducto')
        ->select('product.nombre','produc.costo','produc.cantidad')
        ->whereBetween('produc.created_at', array($fechainicio, $fechafin))
        ->get();

        hecho("hola mund");
        // return response(["data" => $produccion, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
    }
}
