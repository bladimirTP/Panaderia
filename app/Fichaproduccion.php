<?php

namespace App;

use App\DetalleProduccion;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class FichaProduccion extends Model
{
    use SoftDeletes;
    protected $table = 'ficha_produccion';
    protected $primaryKey = 'idficha_produccion';
    public $timestamps = true;
    protected $fillable = [
        'fecha_hora',
        'cantidad',
        'estado',
        'costo_total',
    ];

    protected $hidden = ['updated_at', 'deleted_at','created_at'];
    public function produccions()
    {
        return $this->belongsToMany('App\Producto', 'detalle_produccion', 'fkidficha_produccion','fkidproducto')->withPivot('fkidficha_produccion','fkidproducto','cantidad','costo');
    }

    public function detalles()
    {
        return $this->hasMany('App\Detalleproduccion', 'fkidficha_produccion');
    }
}
