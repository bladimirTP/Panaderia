<?php

namespace App;

use Illuminate\Database\Eloquent\Relations\Pivot;
use Illuminate\Database\Eloquent\SoftDeletes;

class DetalleCompra extends Pivot
{
    use SoftDeletes;

    protected $table = "detalle_compra";
    public $timestamps = true;
    protected $fillable = ['fkidcompra', 'fkidinsumo', 'cantidad', 'precio'];
    protected $primaryKey = ['fkidcompra', 'fkidinsumo'];

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function compra()
    {
        return $this->belongsTo(Compra::class, 'fkidcompra');
    }

    public function insumos()
    {
        return $this->belongsTo(Insumo::class, 'fkidinsumo');
    }
}
