<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Compra extends Model
{
    use SoftDeletes;
    protected $primaryKey = "idcompra";
    protected $table = "compra";
    protected $fillable =[
        'fecha_hora',
        'total',
        'fkidproveedor'
    ];
    protected $hidden = ['updated_at', 'deleted_at'];

    //En una compra esta un proveedor
    public function proveedor(){
        return $this->belongsTo('App\Proveedor','fkidproveedor','idproveedor');
    }

    // En una compra tiene muchos insumos
    public function insumos(){
        return $this->belongsToMany('App\Insumo','detalle_compra','fkidcompra','fkidinsumo')
                    ->withPivot('precio','cantidad','subtotal','unidad_medida');
    }
}
