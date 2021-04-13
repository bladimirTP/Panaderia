<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Cliente extends Model
{
  use SoftDeletes;

  protected $table = 'cliente';
  protected $primaryKey = 'idcliente';
  protected $fillable = ['ci', 'nombre', 'apellido', 'telefono_celular', 'direccion'];
  protected $hidden = ['updated_at', 'deleted_at'];

  public function usuario()
  {
      return $this->hasOne('App\Usuario', 'fkidcliente');
  }

}
