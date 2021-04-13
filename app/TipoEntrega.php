<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class TipoEntrega extends Model
{
  use SoftDeletes;

  protected $table = "tipo_entrega";
  protected $primaryKey = 'idtipo_entrega';
  protected $fillable = ['nombre'];
  protected $hidden = ['updated_at', 'deleted_at'];
}
