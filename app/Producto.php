<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Producto extends Model
{
    use SoftDeletes;

    protected $table = 'producto';
    protected $primaryKey = 'idproducto';
    protected $fillable = ['nombre', 'descripcion', 'precio', 'foto', 'fkidcategoria'];
    protected $hidden = ['updated_at', 'deleted_at'];

    public function categoria()
    {
        return $this->belongsTo('App\Categoria', 'fkidcategoria');
    }

    public function detalleProduccion()
    {
        return $this->belongsToMany('App\Fichaproduccion', 'detalle_produccion')->withPivot('fkidficha_produccion','fkidproducto','cantidad','costo');
    }
}
