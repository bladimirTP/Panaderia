<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class AsignacionPedidoResource extends JsonResource
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
        'idpedido' => $this->pedido->idpedido,
        "fecha" => $this->pedido->fecha,
        "hora" => $this->pedido->hora,
        "coordenada" => $this->pedido->coordenada,
        "tipo_entrega" => $this->pedido->tipoEntrega->nombre,
        "observacion" => $this->pedido->observacion,
        "direccion" => $this->pedido->direccion,
        "referencia" => $this->pedido->referencia,
        "estado" => $this->pedido->estado,
        'fecha_hora' =>$this->pedido->venta->fecha_hora,
        'total' =>$this->pedido->venta->total,
        "created_at" => $this->pedido->created_at,
        "cliente" => [
          "idcliente" => $this->pedido->venta->cliente->idcliente,
          "nombre" => $this->pedido->venta->cliente->nombre,
          "apellido" => $this->pedido->venta->cliente->apellido,
          "telefono_celular" => $this->pedido->venta->cliente->telefono_celular,
          "direccion" => $this->pedido->venta->cliente->direccion,
          "token" => $this->pedido->venta->cliente->usuario?$this->pedido->venta->cliente->usuario->token: null,
        ],
        'detalles' => DetalleVentaResource::collection($this->pedido->venta->detalles),
      ];
    }
}
