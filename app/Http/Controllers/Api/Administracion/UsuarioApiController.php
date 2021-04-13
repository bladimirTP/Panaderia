<?php

namespace App\Http\Controllers\Api\Administracion;

use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use App\Http\Resources\UserResource;
use App\Http\Resources\UsuarioGetResource;
use App\Personal;
use App\Usuario;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class UsuarioApiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
      abort_unless(AuthController::currentUserHasPermission('usuario.listar'), 403);
      try {
        $usuarios = Usuario::where('email', '!=', 'team.edg@gmail.com')->get();
        return response(['data' => UsuarioGetResource::collection($usuarios), 'message' => MessageResponse::GET_OKEY]);
      } catch (\Throwable $th) {
        return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
      }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public static function saveUsersWithRoles(Personal $personal, Request $request)
    {
        $usuario = Usuario::create([
            'email' => $request->usuario['email'],
            'password' => $request->usuario['password'],
            'fkidpersonal' => $personal->idpersonal
        ]);

        $user = UserController::store($usuario, $request);

        return $user::with('usuario');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $usuario
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        abort_unless(AuthController::currentUserHasPermission('usuario.visualizar'), 403);
        try {
            $usuario = Usuario::find($id);
            $usuario->name = $usuario->user->name;
            $usuario->roles = $usuario->user->getRoleNames()[0];
            $usuario->permissions = $usuario->user->getAllPermissions();
            return response(["data" => new UserResource($usuario), 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $usuario
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Usuario $usuario)
    {
        return $usuario->update($request->all());
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $usuario
     * @return \Illuminate\Http\Response
     */
    public function destroy(Usuario $usuario)
    {
        return $usuario->delete();
    }

    public function getByPersonal($id){
      try {
        $personales = Usuario::where('fkidpersonal', '<>', null)->get();
        $newPersonales = [];
        foreach ($personales as $personal) {
          if($personal->user->hasPermissionTo('pedido.listar') && $personal->personal->fkidsucursal == $id)
            array_push($newPersonales, $personal);
        }
        return response(["data" => $personales, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
      } catch (\Throwable $th) {
        return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
      }
    }
}
