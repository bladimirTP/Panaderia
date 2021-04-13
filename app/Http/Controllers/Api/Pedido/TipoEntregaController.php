<?php

namespace App\Http\Controllers\Api\Pedido;

use App\Exceptions\MessageException;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use App\TipoEntrega;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class TipoEntregaController extends Controller
{
   /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
      try {
        $tipoEntregas = TipoEntrega::orderBy('idtipo_entrega', 'asc')->get();
        return response(["data"=> $tipoEntregas, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        $tipoEntrega = TipoEntrega::create($request->all());
        return response(['data' => $tipoEntrega, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
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
        $tipoEntrega = TipoEntrega::find($id);
        if(!$tipoEntrega)
          return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
        return response(['data' => $tipoEntrega, 'message' => MessageResponse::GET_OKEY]);
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
        $tipoEntrega = TipoEntrega::find($id);
        if(!$tipoEntrega)
          return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
        $tipoEntrega->update($request->all());
        return response(['data' => $tipoEntrega, 'message' => MessageResponse::UPDATE_OKEY]);
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
        tipoEntrega::destroy($ids);
        return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
      } catch (\Throwable $th) {
        return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
      }
    }
}
