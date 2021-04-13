<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Nit extends Model
{
    //
    use SoftDeletes;

    protected $table = "nit";
    protected $primaryKey = 'idnit';
    protected $fillable = ['idnit', 'nit','razon_social'];
    protected $hidden = ['updated_at', 'deleted_at'];

    public function sucursal()
    {
        //return $this->hasMany(Producto::class, 'fkidcategoria', 'idcategoria');
        return $this->hasMany(Sucursal::class,'fkidnit','idnit');
    }
}
