<?php

namespace App\Http\Controllers\Auth;

use App\Exceptions\MessageException;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Http\Resources\UsuarioResource;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        DB::beginTransaction();
        try {
            $user = UserController::registerAdminUser($request);
            DB::commit();
            return  response()->json(['message' => MessageResponse::GET_OKEY, 'data' => $user], Response::HTTP_OK);
        } catch (\Throwable $th) {
            DB::rollback();
            return response(["message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function login(Request $request)
    {
        $input = $request->only('email', 'password');
        $jwtToken = null;
        if (!$jwtToken = JWTAuth::attempt($input)) {
            return  response()->json([
                'status' => 'Credenciales inválidos',
                'message' => MessageException::DB_LOGIN
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }

        $user = auth()->user();
        $user->getAllPermissions();

        return  response()->json(['user'=> new UsuarioResource($user) ,'message' => MessageResponse::LOGIN_OK, 'token' => $jwtToken], Response::HTTP_OK)->header('access_token', 'Bearer ' . $jwtToken);
    }

    public function logout(Request $request)
    {
        $this->validate($request, [
            'token' => 'required'
        ]);

        try {
            JWTAuth::invalidate($request->token);
            return response()->json([
                'status' => Response::HTTP_OK,
                'message' => 'Cierre de sesión exitoso.'
            ]);
        } catch (JWTException  $exception) {
            return response()->json([
                'status' => 'unknown_error',
                'message' => 'Al usuario no se le pudo cerrar la sesión.'
            ], 500);
        }
    }

    public function getAuthUser(Request $request)
    {
        $this->validate($request, [
            'token' => 'required'
        ]);

        $user = JWTAuth::authenticate($request->token);
        return response()->json(['user' => $user]);
    }

    public static function getIdSucursalOfCurrentUser()
    {
        return JWTAuth::toUser()->usuario->personal->fkidsucursal;
    }

    public static function currentUserHasRole($role)
    {
        return JWTAuth::toUser()->hasRole($role);
    }

    public static function currentUserHasPermission($permission)
    {
        try {
            return JWTAuth::toUser()->hasPermissionTo($permission);
        } catch (\Throwable $th) {
            return false;
        }
    }
}
