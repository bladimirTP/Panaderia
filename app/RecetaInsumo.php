<?php

namespace App;
use App\Receta;
use App\Insumo;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class RecetaInsumo extends Model
{
    use SoftDeletes;

    protected $table = 'receta_insumo';
    public $timestamps = true;
    protected $primaryKey ='fkidreceta';
    protected $fillable = ['fkidreceta', 'fkidinsumo', 'cantidad', 'costo',];
  

    protected $hidden = ['updated_at', 'deleted_at','created_at'];
    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];
}
