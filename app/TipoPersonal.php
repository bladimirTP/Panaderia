<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class TipoPersonal extends Model
{
    protected $table = "tipo_personal";
    public $timestamps= true;
    protected $fillable = ['idtipo_personal','nombre'];
    protected $primaryKey = 'idtipo_personal';

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];
}
