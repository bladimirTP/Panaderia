<?php

namespace App\Http\Resources;

use App\DetalleCompra;
use Illuminate\Http\Resources\Json\JsonResource;

class CompraResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return [
            "idcompra" => $this->idcompra,
            "fecha_hora" => $this->fecha_hora,
            "total" => $this->total,
            "insumos" => DetalleCompraResource::collection($this->insumos)
        ];
    }
}
