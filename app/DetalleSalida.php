<?php

namespace App;

use Illuminate\Database\Eloquent\Relations\Pivot;
use Illuminate\Database\Eloquent\SoftDeletes;

class DetalleSalida extends Pivot
{
    use SoftDeletes;

    protected $table = "detalle_salida";
    public $timestamps = true;
    protected $fillable = ['fkidorden_salida', 'fkidinventario_producto', 'cantidad'];
    protected $primaryKey = ['fkidinventario_producto', 'fkidorden_salida'];

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function detalle()
    {
        return $this->belongsTo(InventarioProducto::class, 'fkidinventario_producto');
    }

    public function ordenSalida()
    {
        return $this->belongsTo(OrdenSalida::class, 'fkidorden_salida');
    }
}
