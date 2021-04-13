<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AsignacionPedido extends Model
{
  use SoftDeletes;

  protected $table = "asignacion_pedido";
  protected $primaryKey = 'idasignacion_pedido';
  protected $fillable = ['fkidpedido', 'fkidpersonal'];
  protected $hidden = ['updated_at', 'deleted_at'];

  public function pedido()
  {
      return $this->belongsTo('App\Pedido', 'fkidpedido');
  }

  public function personal()
  {
      return $this->belongsTo('App\Personal', 'fkidpersonal');
  }
}
