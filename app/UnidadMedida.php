<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UnidadMedida extends Model
{
    use SoftDeletes;
    protected $primaryKey = 'idunidad_medida';
    protected $table = 'unidad_medida';
    protected $hidden = [
        'updated_at'
    ];
    protected $fillable = [
        'nombre',
        'abreviatura'
    ];

    public function insumos(){
        return $this->hasMany('App\Insumo');
    }
}
