<?php

namespace App;

use Illuminate\Database\Eloquent\Relations\Pivot;
use Illuminate\Database\Eloquent\SoftDeletes;

class DetalleVenta extends Pivot
{
  use SoftDeletes;
  public $incrementing = false;
  protected $table = 'detalle_venta';
  protected $primaryKey = ['fkidsucursal_producto', 'fkidventa'];
  protected $fillable = ['fkidventa', 'fkidsucursal_producto', 'cantidad', 'precio', 'subtotal'];
  protected $hidden = ['updated_at', 'deleted_at'];

  public function venta()
  {
      return $this->belongsTo(Venta::class, 'fkidventa');
  }

  public function sucursalProducto()
  {
      return $this->belongsTo(SucursalProducto::class, 'fkidsucursal_producto');
  }
}
