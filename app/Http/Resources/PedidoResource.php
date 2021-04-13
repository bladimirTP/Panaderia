<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class PedidoResource extends JsonResource
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
          'idpedido' => $this->idpedido,
          "fecha" => $this->fecha,
          "hora" => $this->hora,
          "fecha_full" => $this->fecha.' '.$this->hora,
          "coordenada" => $this->coordenada,
          "tipo_entrega" => $this->tipoEntrega->nombre,
          "observacion" => $this->observacion,
          "direccion" => $this->direccion,
          "referencia" => $this->referencia,
          "estado" => $this->estado,
          'fecha_hora' =>$this->venta->fecha_hora,
          'total' =>$this->venta->total,
          "created_at" => $this->created_at,
          "cliente" => [
            "idcliente" => $this->venta->cliente->idcliente,
            "nombre" => $this->venta->cliente->nombre,
            "apellido" => $this->venta->cliente->apellido,
            "telefono_celular" => $this->venta->cliente->telefono_celular,
            "direccion" => $this->venta->cliente->direccion,
            "token" => $this->venta->cliente->usuario?$this->venta->cliente->usuario->token: null,
          ],
          'detalles' => DetalleVentaResource::collection($this->venta->detalles),
        ];
    }
}
