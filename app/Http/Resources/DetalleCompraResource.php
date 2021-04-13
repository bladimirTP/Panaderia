<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class DetalleCompraResource extends JsonResource
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
            "idinsumo" =>$this->idinsumo,
            "nombre" => $this->nombre,
            "precio" => $this->pivot->precio,
            "cantidad" => $this->pivot->cantidad,
            "subtotal" => $this->pivot->subtotal,
            "unidad_medida"=> $this->pivot->unidad_medida
        ];
    }
}
