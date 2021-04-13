<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SucursalProducto extends Model
{
    use SoftDeletes;

    protected $table = "sucursal_producto";
    public $timestamps = true;
    protected $fillable = ['idsucursal_producto', 'stock', 'stock_minimo', 'stock_maximo', 'fkidproducto', 'fkidsucursal'];
    protected $primaryKey = 'idsucursal_producto';

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'fkidproducto');
    }

    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'fkidsucursal');
    }
}
