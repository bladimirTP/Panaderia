<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class DetalleVentaResource extends JsonResource
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
          'sucursal_producto' => [
            "idsucursal_producto" => $this->sucursalProducto->idsucursal_producto,
            "stock" => $this->sucursalProducto->stock,
            "stock_minimo" => $this->sucursalProducto->stock_minimo,
            "stock_maximo" => $this->sucursalProducto->stock_maximo,
            'producto' => [
              'idproducto' => $this->sucursalProducto->producto->idproducto,
              'nombre'=> $this->sucursalProducto->producto->nombre,
              'descripcion'=> $this->sucursalProducto->producto->descripcion,
              'precio'=> $this->sucursalProducto->producto->precio,
              'foto'=> $this->sucursalProducto->producto->foto,
              'created_at'=> $this->sucursalProducto->producto->created_at,
              'categoria' => [
                'idcategoria' => $this->sucursalProducto->producto->categoria->idcategoria,
                'nombre' => $this->sucursalProducto->producto->categoria->nombre,
              ],
            ],
            "sucursal" => [
              "idsucursal" => $this->sucursalProducto->sucursal->idsucursal,
              "nombre" => $this->sucursalProducto->sucursal->nombre,
              "direccion" => $this->sucursalProducto->sucursal->direccion,
            ]
          ],
          'cantidad' => $this->cantidad,
          'precio' => $this->precio,
        ];
    }
}
