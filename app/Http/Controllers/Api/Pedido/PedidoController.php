<?php

namespace App\Http\Controllers\Api\Pedido;

use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use App\Http\Resources\PedidoResource;
use App\Pedido;
use App\SucursalProducto;
use App\Venta;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class PedidoController extends Controller
{
  const CODE_STOCK_VALIDATE = 23514;
  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */
  public function index(Request $request)
  {
    $estado = $request->query('estado');
    $query = $estado?[['estado', '=', $estado]]: [];
    try {
      if (AuthController::currentUserHasRole('Administrador')) {
        $pedidos = Pedido::where($query)->orderBy('idpedido', 'desc')->get();
      }else {
        $idsucursal = AuthController::getIdSucursalOfCurrentUser();
        $pedidos = Pedido::where($query)->wherehas('venta', function (Builder $query) use ($idsucursal) {
          return $query->where('fkidsucursal', $idsucursal);
        })
          ->orderBy('idpedido', 'desc')->get();
      }
      return response(["data" => PedidoResource::collection($pedidos), 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
    DB::beginTransaction();
    try {
      $pedido = Pedido::create($request->all());
      $data = $request->all();
      $data['fkidpedido'] = $pedido->idpedido;
      $venta = Venta::create($data);
      $detalles = $request->detalles;
      foreach ($detalles as $value) {
        $venta->detalle()->attach($value['idsucursal_producto'], [
          'cantidad' => $value['cantidad'],
          'precio' => $value['precio'],
        ]);
        $sucursalProducto = SucursalProducto::find($value['idsucursal_producto']);
        $sucursalProducto->update(['stock' => $sucursalProducto->stock - $value['cantidad']]);
      }
      DB::commit();
      return response(['data' => $pedido, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
    } catch (\Throwable $th) {
      DB::rollBack();
      if ($th->getCode() == self::CODE_STOCK_VALIDATE) {
        return response(["message" => MessageException::DB_STOCK_VALIDATE_PEDIDO], Response::HTTP_INTERNAL_SERVER_ERROR);
      }
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
      $pedido = Pedido::find($id);;
      if (!$pedido)
        return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
      return response(['data' => new PedidoResource($pedido), 'message' => MessageResponse::GET_OKEY]);
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
    DB::beginTransaction();
    try {
      $pedido = Pedido::find($id);
      if (!$pedido)
        return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
      if($request->estado == 'anulado'){
        $detalles = $pedido->venta->detalles;
        foreach ($detalles as $value) {
          $sucursalProducto = $value->sucursalProducto;
          $sucursalProducto->update(['stock' => $sucursalProducto->stock + $value->cantidad]);
        }
      }
      $pedido->update($request->all());
      DB::commit();
      return response(['data' => $pedido, 'message' => MessageResponse::UPDATE_OKEY]);
    } catch (\Throwable $th) {
      DB::rollBack();
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
    DB::beginTransaction();
    try {
      $pedido = Pedido::find($id);
      if (!$pedido)
        return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
        $detalles = $pedido->venta->detalles;
        foreach ($detalles as $value) {
          $sucursalProducto = $value->sucursalProducto;
          $sucursalProducto->update(['stock' => $sucursalProducto->stock + $value->cantidad]);
        }
      $pedido->update(['estado' => 'anulado']);
      DB::commit();
      return response(['data' => $pedido, 'message' => MessageResponse::DELETE_OKEY]);
    } catch (\Throwable $th) {
      DB::rollBack();
      return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
    }
  }

  public function getByCliente($id)
  {
    try {
      $pedidos = Pedido::with('venta')->whereHas('venta', function (Builder $query) use ($id) {
        $query->where('fkidcliente', $id);
      })->orderBy('idpedido', 'desc')->get();
      return response(['data' => PedidoResource::collection($pedidos), 'message' => MessageResponse::GET_OKEY]);
    } catch (\Throwable $th) {
      return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
    }
  }

  public function getBySucursal($id)
  {
    try {
      $pedidos = Pedido::with('venta')->whereHas('venta', function (Builder $query) use ($id) {
        $query->where('fkidsucursal', $id);
      })->orderBy('idpedido', 'desc')->get();
      return response(["data" => PedidoResource::collection($pedidos), 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
    } catch (\Throwable $th) {
      return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
    }
  }

  public function setEstadoDisponible($id)
  {
    try {
      $pedido = Pedido::find($id);
      if (!$pedido)
        return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
      $pedido->update(['estado' => 'entregado']);
      return response(['data' => $pedido, 'message' => MessageResponse::UPDATE_OKEY]);
    } catch (\Throwable $th) {
      return response(["message" => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
    }
  }
}
