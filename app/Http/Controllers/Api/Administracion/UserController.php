<?php

namespace App\Http\Controllers\Api\Administracion;

use App\Http\Controllers\Controller;
use App\Personal;
use Spatie\Permission\Models\Role;
use App\User;
use App\Usuario;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public static function store(Usuario $usuario, Request $request)
    {
        $user = User::create([
            'name' => $request->personal['nombre'] . ' ' . $request->personal['apellido'],
            'email' => $request->usuario['email'],
            'password' => $usuario->password,
            'fkidusuario' => $usuario->idusuario
        ]);

        $roleName = Role::find($request->usuario['rol']);
        if ($roleName) {
            $user->assignRole($roleName->name);
        } else {
            return null;
        }

        return $user;
    }

    public static function registerAdminUser(Request $request)
    {
        $personal = Personal::create([
            'nombre' => 'Gerardo',
            'ci' => '645445',
            'apellido' => 'Sayaverde',
            'telefono_celular' => '76652710',
            'direccion' => 'Av. 2 de agosto',
            'fkidtipo_personal' => 1,
            'fkidsucursal' => 1
        ]);

        $usuario = Usuario::create([
            'email' => $request->email,
            'password' => $request->password,
            'fkidpersonal' => $personal->idpersonal
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $usuario->email,
            'password' => $usuario->password,
            'fkidusuario' => $usuario->idusuario
        ]);

        $role = Role::findByName('Administrador');
        $user->assignRole($role);

        return $user;
    }
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
