<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class UsuarioResource extends JsonResource
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
            'name' => $this->name,
            'sucursal' => $this->getSucursal(),
            'email' => $this->email,
            'role_name' => $this->roles[0]->name,
            'permisos' => PermisoResource::collection($this->roles[0]->permissions)
        ];
    }

    public function getSucursal()
    {
        return $this->usuario->personal->sucursal ?? null;
    }
}
