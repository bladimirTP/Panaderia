<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Venta extends Model
{
    use SoftDeletes;
    protected $table = 'venta';
    protected $primaryKey = 'idventa';
    protected $fillable = ['fecha_hora', 'total', 'fkidcliente', 'fkidusuario', 'fkidpedido', 'fkidsucursal'];
    protected $hidden = ['updated_at', 'deleted_at'];

    public function sucursalProducto()
    {
        return $this->belongsToMany(SucursalProducto::class, DetalleVenta::class, 'fkidventa', 'fkidsucursal_producto')
            ->withTimestamps()
            ->withPivot('cantidad');
    }

    public function cliente()
    {
        return $this->belongsTo('App\Cliente', 'fkidcliente');
    }

    public function detalle()
    {
        return $this->belongsToMany('App\SucursalProducto', 'detalle_venta', 'fkidventa', 'fkidsucursal_producto');
    }

    public function detalles()
    {
        return $this->hasMany('App\DetalleVenta', 'fkidventa');
    }

    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'fkidsucursal');
    }
}
