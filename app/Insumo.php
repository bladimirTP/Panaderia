<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
class Insumo extends Model
{
    use SoftDeletes;

    protected $primaryKey = 'idinsumo';
    protected $table = 'insumo';
    public $timestamps = true;
    protected $fillable = [
        'nombre',
        'costo',
        'stock',
        'stock_minimo',
        'stock_maximo',
        'fecha_vencimiento',
        'fkidunidad_medida'
    ];
    protected $hidden = ['updated_at', 'deleted_at'];

    public function unidad_medida(){
        return $this->belongsTo('App\UnidadMedida','fkidunidad_medida','idunidad_medida');
    }

    // Un insumo esta en muchas compras
    public function compras(){
        return $this->belongsToMany('App\Compra','detalle_compra','fkidinsumo','fkidcompra');
    }

    public function detalle(){
        return $this->belongsToMany(Insumo::class);
    }

    public function recetas()
    {
        return $this->belongsToMany(Receta::class, 'receta_insumo', 'fkidinsumo', 'fkidreceta');
    }


}
