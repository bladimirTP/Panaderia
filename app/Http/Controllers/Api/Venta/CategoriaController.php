<?php

namespace App\Http\Controllers\Api\Venta;

use App\Http\Controllers\Controller;
use App\Categoria;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Message\MessageResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class CategoriaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('categoria.listar'), 403);
        try {
            $categorias = Categoria::orderBy('idcategoria', 'desc')->get();
            return response(["data" => $categorias, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('categoria.guardar'), 403);
        try {
            $categoria = Categoria::create($request->all());
            return response(['data' => $categoria, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('categoria.visualizar'), 403);
        try {
            $categoria = Categoria::find($id);
            if (!$categoria)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            return response(['data' => $categoria, 'message' => MessageResponse::GET_OKEY]);
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
        abort_unless(AuthController::currentUserHasPermission('categoria.actualizar'), 403);
        try {
            $categoria = Categoria::find($id);
            if (!$categoria)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            $categoria->update($request->all());
            return response(['data' => $categoria, 'message' => MessageResponse::UPDATE_OKEY]);
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
    public function destroy($ids)
    {
        abort_unless(AuthController::currentUserHasPermission('categoria.eliminar'), 403);
        try {
            $idsDelete = explode(",", $ids);
            foreach ($idsDelete as $id) {
                $categoria = Categoria::find($id);
                if ($categoria != null && $categoria->producto->count() > 0) {
                    $categoria->delete();
                } else {
                    return response(["message" => sprintf(MessageException::DB_CASCADE_DELETE, 'categoria', 'producto')], Response::HTTP_OK);
                }
            }
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
