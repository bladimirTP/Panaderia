<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class InventarioProducto extends Model
{
    use SoftDeletes;

    protected $table = "inventario_producto";
    public $timestamps = true;
    protected $fillable = ['idinventario_producto', 'stock', 'stock_minimo', 'stock_maximo', 'fkidproducto'];
    protected $primaryKey = 'idinventario_producto';

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'fkidproducto');
    }

    public function ordenEntrada()
    {
        return $this->belongsToMany(OrdenEntrada::class, 'detalle_entrada', 'fkidinventario_producto', 'fkidorden_entrada')
            ->withTimestamps()
            ->withPivot('cantidad');
    }

    public function ordenSalida()
    {
        return $this->belongsToMany(OrdenSalida::class, 'detalle_entrada', 'fkidinventario_producto', 'fkidorden_salida')
            ->withTimestamps()
            ->withPivot('cantidad');
    }
}
