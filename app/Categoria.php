<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Categoria extends Model
{
    use SoftDeletes;

    protected $table = "categoria";
    protected $primaryKey = 'idcategoria';
    protected $fillable = ['idcategoria', 'nombre'];
    protected $hidden = ['updated_at', 'deleted_at'];

    public function producto()
    {
        return $this->hasMany(Producto::class, 'fkidcategoria', 'idcategoria');
    }
}
