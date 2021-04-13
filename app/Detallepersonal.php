<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Detallepersonal extends Model
{

    public $timestamps=true;

    protected $table= 'produccion_personal';
    protected $primaryKey = ['fkidficha_produccion','fkidpersonal'];
    protected $hidden = ['updated_at', 'deleted_at'];
    protected $fillable=[
        'fkidficha_produccion',
        'fkidpersonal',
        'fecha'
   ];

    public function personal(){
        return $this->belongsToMany('App\Personal','fkidpersonal','idpersonal');
    }
    public function fichaproduccion(){

      return $this->belongsToMany('App\Fichaproduccion','fkidficha_produccion','idficha_produccion');
    }
}
