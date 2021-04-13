<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Message\MessageResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Response;
class ProductoProduccionController extends Controller
{
    
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('ficha_produccion.listar'), 403);
        try {
            $producto= DB::table('producto as product')
            ->join('receta as recet','product.idproducto','=','recet.fkidproducto')
            ->select('product.idproducto','product.nombre')
            ->get();
            return response(["data" => $producto, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            dd($th);
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
