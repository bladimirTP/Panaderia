<?php

namespace App;

use App\Producto;
use App\FichaProduccion;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\Pivot;

class DetalleProduccion extends Model
{
    public $timestamps = true;
    protected $table = 'detalle_produccion';
    protected $primaryKey = 'id_detalle';
    protected $hidden = ['updated_at', 'deleted_at', 'created_at'];
    protected $fillable = [
       
        'fkidficha_produccion',
        'fkidproducto',
        'cantidad',
        'costo',
    ];

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'fkidproducto');
    }
    public function fichaproduccion()
    {

        return $this->belongsTo(FichaProduccion::class, 'fkidficha_produccion');
    }
}
