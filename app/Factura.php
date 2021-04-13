<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

use Illuminate\Database\Eloquent\SoftDeletes;

class Factura extends Model
{
    //
    use SoftDeletes;

    protected $table = "factura";
    protected $primaryKey = 'idfactura';
    protected $fillable = ['idfactura', 'numero', 'debito_fiscal', 'codigo_control', 'estado', 'fkidventa', 'fkiddosificacion'];
    protected $hidden = ['updated_at', 'deleted_at'];
}
