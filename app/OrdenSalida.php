<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class OrdenSalida extends Model
{
    use SoftDeletes;

    protected $table = "orden_salida";
    public $timestamps = true;
    protected $fillable = ['idorden_salida', 'numero_orden', 'fecha_hora', 'nota', 'estado', 'fkidsucursal'];
    protected $primaryKey = 'idorden_salida';

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
        return $this->belongsToMany(InventarioProducto::class, DetalleSalida::class, 'fkidorden_salida', 'fkidinventario_producto')
            ->withTimestamps()
            ->withPivot('cantidad');
    }
}
