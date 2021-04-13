<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Personal extends Model
{
    use SoftDeletes;
    protected $table = "personal";
    public $timestamps = true;
    protected $fillable = ['idpersonal', 'nombre', 'ci', 'apellido', 'telefono_celular', 'direccion', 'fkidsucursal'];
    protected $primaryKey = 'idpersonal';

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'fkidsucursal');
    }

    public function detalle()
    {
        return $this->belongsToMany(Personal::class);
    }

    public function usuario()
    {
        return $this->hasOneThrough(User::class, Usuario::class, 'fkidpersonal', 'fkidusuario', 'idpersonal', 'idusuario');
    }

    public function user()
    {
      return $this->hasOne(Usuario::class, 'fkidpersonal');
    }
}
