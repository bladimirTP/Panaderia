<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Dosificacion extends Model
{
    //
    use SoftDeletes;

    protected $table = "dosificacion";
    protected $primaryKey = 'iddosificacion';
    protected $fillable = ['iddosificacion', 'numero_autorizacion','numero_inicial','llave','fecha_limite','actividad_economica','leyenda','fkidsucursal'];
    protected $hidden = ['updated_at', 'deleted_at'];

    public function dosificacion()
    {
        return $this->belongsTo('App\Dosificacion', 'fkidsucursal');
    }

    public function sucursal()
    {
        return $this->belongsTo('App\Sucursal', 'fkidsucursal');
    }
}
