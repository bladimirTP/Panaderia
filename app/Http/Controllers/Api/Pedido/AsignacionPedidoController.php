<?php

namespace App\Http\Controllers\Api\Pedido;

use App\AsignacionPedido;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use App\Http\Resources\AsignacionPedidoResource;
use App\Personal;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class AsignacionPedidoController extends Controller
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
    public function store(Request $request)
    {
        try {
            $asignancion = AsignacionPedido::create($request->all());
            return response(['data' => $asignancion, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => $th], Response::HTTP_INTERNAL_SERVER_ERROR);
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
        //
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
            $asignacion = AsignacionPedido::find($id);
            if (!$asignacion)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            $asignacion->update($request->all());
            return response(['data' => $asignacion, 'message' => MessageResponse::UPDATE_OKEY]);
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
    public function destroy($id)
    {
        //
    }

    public function getByPersonal(Request $request, $id)
    {
      $estado = $request->query('estado');
      $where = $estado?[['estado', '=', $estado]]: [];
        try {
            $pedidos = AsignacionPedido::where('fkidpersonal', $id)
            ->wherehas('pedido', function (Builder $query) use ($where) {
              return $query->where($where);
            })
            ->orderBy('updated_at', 'desc')->get();
            return response(['data' => AsignacionPedidoResource::collection($pedidos), 'message' => MessageResponse::GET_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function getByPedido($id)
    {
        try {
            $pedidos = AsignacionPedido::with(['personal', 'personal.user'])->where('fkidpedido', $id)->first();
            return response(['data' => $pedidos, 'message' => MessageResponse::GET_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function getPersonalBySucursal()
    {
        try {
            $idsucursal = AuthController::getIdSucursalOfCurrentUser();
            $personales = Personal::with(['user'])->where('fkidsucursal', $idsucursal)->orderBy('idpersonal', 'asc')->get();

            $newPersonales = [];
            foreach ($personales as $personal) {
                if ($personal->usuario->hasRole('repartidor'))
                    array_push($newPersonales, $personal);
            }

            return response(["data" => $newPersonales, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
