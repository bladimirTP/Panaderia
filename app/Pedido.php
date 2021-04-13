<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Pedido extends Model
{
  use SoftDeletes;

  protected $table = "pedido";
  protected $primaryKey = 'idpedido';
  protected $fillable = ['fecha', 'hora', 'coordenada', 'observacion', 'direccion', 'referencia', 'estado', 'fkidtipo_entrega'];
  protected $hidden = ['updated_at', 'deleted_at'];

  public function venta()
  {
      return $this->hasOne('App\Venta', 'fkidpedido');
  }

  public function tipoEntrega()
  {
      return $this->belongsTo('App\TipoEntrega', 'fkidtipo_entrega');
  }
}
