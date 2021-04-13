<?php

namespace App\Http\Controllers\Api\Venta;

use App\Http\Controllers\Controller;
use App\Cliente;
use App\Exceptions\MessageException;
use App\Http\Message\MessageResponse;
use App\Personal;
use App\Usuario;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class ClienteController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        try {
            $clientes = Cliente::orderBy('idcliente', 'asc')->get();
            return response(["data" => $clientes, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        try {
            $cliente = cliente::create($request->all());
            return response(['data' => $cliente, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
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
        try {
            $cliente = Cliente::find($id);
            if (!$cliente)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            return response(['data' => $cliente, 'message' => MessageResponse::GET_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
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
        try {
            $cliente = Cliente::find($id);
            if (!$cliente)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            $cliente->update($request->all());
            return response(['data' => $cliente, 'message' => MessageResponse::UPDATE_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($idsDelete)
    {
        try {
            $ids = explode(",", $idsDelete);
            Cliente::destroy($ids);
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function clientRegister(Request $request)
    {
        DB::beginTransaction();
        try {
            $cliente = Cliente::create($request->all());
            Usuario::create([
                'email' => $request->email,
                'password' => $request->password,
                'token' => $request->token,
                'fkidcliente' => $cliente->idcliente
            ]);
            DB::commit();
            return response(["data" => $cliente, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            DB::rollback();
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function validateLogin(Request $request)
    {
        try {
            $usuario = Usuario::where('email', $request->email)->first();
            if ($this->validateUsers($usuario, $request)) {
                if ((bool) $usuario->fkidcliente) {
                    $cliente = Cliente::find($usuario->fkidcliente);
                    $cliente['id'] = $usuario->fkidcliente;
                    $cliente['rol'] = 'cliente';
                    $cliente['email'] = $usuario->email;
                    return response(["data" => $cliente, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
                } else if ((bool) $usuario->fkidpersonal) {
                    $personal = Personal::find($usuario->fkidpersonal);
                    $personal['id'] = $usuario->fkidpersonal;
                    $personal['rol'] = 'administrativo';
                    $personal['email'] = $usuario->email;
                    return response(["data" => $personal, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
                } else {
                  return response(['message' => "No existe el usuario"], Response::HTTP_BAD_REQUEST);
                }
            } else {
                return response(['message' => "Email o Contraseña invalida"], Response::HTTP_BAD_REQUEST);
            }
        } catch (\Throwable $th) {
            dd($th);
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    private function validateUsers($usuario, Request $request)
    {
        return  (bool) $usuario
            && Hash::check($request->password, $usuario->password);
    }

    public function updateToken(Request $request){
      try {
        $usuario =  Usuario::where('email', $request->email)->first();
        if (!$usuario)
            return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
        Usuario::where('token', $request->token)->where('email', '<>', $request->email)->update(['token' => null]);
        $usuario->update($request->all(['token']));
        return response(['data' => $usuario, 'message' => MessageResponse::UPDATE_OKEY]);
      } catch (\Throwable $th) {
          return response(["message" => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
      }
    }

    public function updateMovilPefil(Request $request, $id)
    {
        try {
          if($request->rol == 'cliente'){
            $cliente = Cliente::find($id)->update($request->all());
            return response(['data' => $cliente, 'message' => MessageResponse::UPDATE_OKEY]);
          }else{
            $personal = Personal::find($id)->update($request->all());
            return response(['data' => $personal, 'message' => MessageResponse::UPDATE_OKEY]);
          }
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
