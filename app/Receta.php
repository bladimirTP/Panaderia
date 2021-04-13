<?php

namespace App;
use App\Producto;
use App\Insumo;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Receta extends Model
{
    use SoftDeletes;

    protected $table = 'receta';
    protected $primaryKey ='idreceta';
    protected $fillable = ['costo_produccion', 'total_masa', 'peso', 'bollos', 'cantidad_producto','fkidproducto'];
    public $timestamps = true;
    protected $hidden = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'fkidproducto');
    }
    
    public function insumos()
    {
        return $this->belongsToMany(Insumo::class, 'receta_insumo', 'fkidreceta', 'fkidinsumo');
    }
}
