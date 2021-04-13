<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Sucursal extends Model
{
    use SoftDeletes;

    protected $table = "sucursal";
    public $timestamps = true;
    protected $fillable = ['idsucursal', 'nombre', 'direccion', 'telefono','fkidnit'];
    protected $primaryKey = 'idsucursal';

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function sucursal()
    {
        return $this->belongsTo('App\Sucursal', 'fkidnit');
    }

    public function dosificacion()
    {
        //return $this->hasMany(Producto::class, 'fkidcategoria', 'idcategoria');
        return $this->hasMany(Dosificacion::class,'fkidsucursal','idsucursal');
    }
    public function nit(){
        
        return $this->belongsTo('App\Nit','idnit','fkidnit');
    }
}
