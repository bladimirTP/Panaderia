<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\Pivot;
use Illuminate\Database\Eloquent\SoftDeletes;

class DetalleEntrada extends Pivot
{
    use SoftDeletes;

    protected $table = "detalle_entrada";
    public $timestamps = true;
    protected $fillable = ['fkidorden_entrada', 'fkidinventario_producto', 'cantidad'];
    protected $primaryKey = ['fkidinventario_producto', 'fkidorden_entrada'];

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function detalle()
    {
        return $this->belongsTo(InventarioProducto::class, 'fkidinventario_producto');
    }

    public function ordenEntrada()
    {
        return $this->belongsTo(OrdenEntrada::class, 'fkidorden_entrada');
    }
}
