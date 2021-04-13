<?php

namespace App\Http\Controllers\Api\Compra;

use App\Proveedor;
use App\Http\Controllers\Controller;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Message\MessageResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class ProveedorController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('proveedor.listar'), 403);
        try {
            $proveedores = Proveedor::orderBy('idproveedor', 'desc')->get();
            return response(["data"=> $proveedores, "message" => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('proveedor.guardar'), 403);
        try {
            $proveedor = Proveedor::create($request->all());
            return response(["data"=>$proveedor, "message" => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_SAVEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Proveedor  $proveedor
     * @return \Illuminate\Http\Response
     */
    public function show(Proveedor $proveedor)
    {
        abort_unless(AuthController::currentUserHasPermission('proveedor.visualizar'), 403);
        try {
            // $proveedor = Proveedor::find($proveedor);
            if (!$proveedor)
                return response(["data"=>$proveedor, "message" => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            return response(["data"=>$proveedor, "message" => MessageResponse::GET_OKEY]);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_GETDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Proveedor  $proveedor
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Proveedor $proveedor)
    {
        abort_unless(AuthController::currentUserHasPermission('proveedor.actualizar'), 403);
        try {
            if(!$proveedor)
              return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            $proveedor->update($request->all());
            return response(['data' => $proveedor, 'message' => MessageResponse::UPDATE_OKEY]);
        } catch (\Throwable $th) {
        return response(["message" => MessageException::DB_UPDATEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /****
     * Verifica si los proveedores estan en alguna compra
     * @param
     */

    public function verificar_tiene_compras($id_proveedores){
        $tiene_compras = false;
        $contador = 0;
        while ($contador < count($id_proveedores) && $tiene_compras == false) {
            $proveedor = Proveedor::find($id_proveedores[$contador]);
            if($proveedor->compras->isNotEmpty()){
                $tiene_compras = true;
                break;
            }
            $contador++;
        }
        return $tiene_compras;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Proveedor  $proveedor
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        abort_unless(AuthController::currentUserHasPermission('proveedor.eliminar'), 403);
        try {
            $id_proveedor = explode(',',$id);
            $tienen_compras = $this->verificar_tiene_compras($id_proveedor);
            if(!$tienen_compras){
                Proveedor::destroy($id_proveedor);
            }else{
                return response(["data" => null, 'message' => MessageResponse::FOREIGN_EXIST], Response::HTTP_BAD_REQUEST);
            }
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
