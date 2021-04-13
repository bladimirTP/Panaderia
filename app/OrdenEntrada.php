<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class OrdenEntrada extends Model
{
    use SoftDeletes;

    protected $table = "orden_entrada";
    public $timestamps = true;
    protected $fillable = ['idorden_entrada', 'fecha_hora', 'nota', 'estado', 'numero_orden', 'fkidsucursal'];
    protected $primaryKey = 'idorden_entrada';

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'fkidsucursal');
    }

    public function inventarioProducto()
    {
        return $this->belongsToMany(InventarioProducto::class, DetalleEntrada::class, 'fkidorden_entrada', 'fkidinventario_producto')
            ->withTimestamps()
            ->withPivot('cantidad');
    }
}
