<?php

namespace App\Http\Controllers\Api\Administracion;

use App\Exceptions\MessageException;
use App\Http\Controllers\Api\Administracion\UsuarioApiController;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use App\Personal;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Response;

class PersonalController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('personal.listar'), 403);

        try {
            $personales = Personal::all();

            foreach ($personales as $value) {
                $user = $value->usuario;
                $value->rol = $user->getRoleNames()[0];
            }

            return response(["data" => $personales, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
    public function store(Request $request)
    {
        abort_unless(AuthController::currentUserHasPermission('personal.guardar'), 403);
        DB::beginTransaction();
        try {
            $personal = Personal::create([
                'nombre' => $request->personal['nombre'],
                'apellido' => $request->personal['apellido'],
                'ci' => $request->personal['ci'],
                'telefono_celular' => $request->personal['telefono'],
                'direccion' => $request->personal['direccion'],
                'fkidsucursal' => $request->personal['fkidsucursal']
            ]);

            if ($request->acceso_sistema) {
                UsuarioApiController::saveUsersWithRoles($personal, $request);
            }

            DB::commit();
            return response(["data" => $personal, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            DB::rollback();
            return response(["data" => $th, "message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        abort_unless(AuthController::currentUserHasPermission('personal.visualizar'), 403);
        try {
            $personal = Personal::with(['usuario', 'sucursal'])->where('idpersonal', $id)->first();
            return response(["data" => $personal, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
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
        abort_unless(AuthController::currentUserHasPermission('personal.actualizar'), 403);
        try {
            $personal = Personal::find($id);
            if (!$personal)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            $personal->update([
                'nombre' => $request->personal['nombre'],
                'apellido' => $request->personal['apellido'],
                'ci' => $request->personal['ci'],
                'telefono_celular' => $request->personal['telefono'],
                'direccion' => $request->personal['direccion'],
                'fkidtipo_personal' => $request->personal['tipo_personal']
            ]);
            return response(['data' => $personal, 'message' => MessageResponse::UPDATE_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($ids)
    {
        abort_unless(AuthController::currentUserHasPermission('personal.eliminar'), 403);
        try {
            $idsDelete = explode(",", $ids);
            foreach ($idsDelete as $id) {
                $personal = Personal::find($id);
                if ($personal != null) {
                    $personal->user->user->delete();
                    $personal->user->delete();
                    $personal->delete();
                }
            }
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function trashed()
    {
        $data = Personal::onlyTrashed()->get();
        return response(["data" => $data, "message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
    }
}
