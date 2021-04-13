<?php

namespace App\Http\Controllers\Api\Produccion;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class DetalleproduccionController extends Controller
{
    public function show($fichaproduccion)
    {
        $fichaproduc = DB::table('ficha_produccion as produc')
            ->join('detalle_produccion as deta', 'produc.idficha_produccion', '=', 'deta.fkidficha_produccion')
            ->join('producto as pro', 'deta.fkidproducto', '=', 'pro.idproducto')
            ->select('produc.fecha_hora', 'pro.nombre', 'deta.cantidad', 'deta.costo')
            ->where('produc.idficha_produccion', '=', $fichaproduccion)
            ->get();
        return response(['data' => $fichaproduc]);
    }
}
