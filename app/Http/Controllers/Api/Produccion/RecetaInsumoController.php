<?php

namespace App\Http\Controllers\Api\Produccion;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class RecetaInsumoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function show($receta)
    {
        $fichaproduc = DB::table('receta as produc')
            ->join('producto as pro', 'produc.fkidproducto', '=', 'pro.idproducto')
            ->join('receta_insumo as det', 'produc.idreceta', '=', 'det.fkidreceta')
            ->join('insumo as insu', 'insu.idinsumo', '=', 'det.fkidinsumo')
            ->select('insu.idinsumo', 'insu.nombre as insumos', 'det.cantidad', 'det.costo', 'det.unidad_medida as medida')
            ->where('produc.idreceta', '=', $receta)
            ->get();

        return response()->json(['data' => $fichaproduc], 200);
        // $recetaInsum= $receta->insumos()->pluck('nombre','costo');
        // return response()->json(['data' => $recetaInsum], 200);
    }
}
