<?php

namespace App;

use Illuminate\Database\Eloquent\Relations\Pivot;
use Illuminate\Database\Eloquent\SoftDeletes;

class DetalleInventario extends Pivot
{
    use SoftDeletes;

    protected $table = "detalle_inventario";
    public $timestamps = true;
    protected $fillable = ['fkidinventario_inicial', 'fkidsucursal_producto', 'cantidad'];
    protected $primaryKey = ['fkidinventario_inicial','fkidsucursal_producto'];

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function inventarioInicial()
    {
        return $this->belongsTo(InventarioInicial::class, 'fkidinventario_inicial');
    }

    public function productos()
    {
        return $this->belongsTo(SucursalProducto::class, 'fkidsucursal_producto');
    }
}
