<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class UsuarioGetResource extends JsonResource
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
        'idusuario' => $this->idusuario,
        'nombre' => $this->fkidcliente? $this->cliente->nombre: $this->personal->nombre,
        'apellido' => $this->fkidcliente? $this->cliente->apellido: $this->personal->apellido,
        'tipo' =>  $this->fkidcliente? 'cliente': 'personal',
        'email' => $this->email,
        'created_at' => $this->created_at
      ];
    }
}
