<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class InventarioInicial extends Model
{
    use SoftDeletes;

    protected $table = "inventario_inicial";
    public $timestamps = true;
    protected $fillable = ['idinventario_inicial', 'fecha', 'fkidsucursal'];
    protected $primaryKey = 'idinventario_inicial';

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'fkidsucursal');
    }

    public function detalleInventario()
    {
        return $this->belongsToMany(SucursalProducto::class, 'detalle_inventario', 'fkidinventario_inicial', 'fkidsucursal_producto');
    }
}
