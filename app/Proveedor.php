<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Proveedor extends Model
{
    use SoftDeletes;
    protected $primaryKey = 'idproveedor';
    protected $table = 'proveedor';
    protected $hidden = [
        'updated_at'
    ];
    protected $fillable = [
        'empresa',
        'ci_nit',
        'nombre',
        'apellido',
        'telefono_celular',
        'email'
    ];

    public function compras(){
        return $this->hasMany('App\Compra','fkidproveedor','idproveedor');
    }


}
