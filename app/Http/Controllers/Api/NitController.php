<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Message\MessageResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Nit;

class NitController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        try{
            $nits= Nit::orderBy('idnit', 'desc')->get();
            return response(["data" =>  $nits, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        //
        try {
            $nits = Nit::create($request->all());
            return response(['data' => $nits, 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
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
        //
        try {
            $nit = Nit::find($id);
            if (!$nit)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            return response(['data' => $nit, 'message' => MessageResponse::GET_OKEY]);
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
        //
        try {
            $nit = Nit::find($id);
            if (!$nit)
                return response(['message' => MessageException::DB_NOT_FOUND], Response::HTTP_BAD_REQUEST);
            $nit->update($request->all());
            return response(['data' => $nit, 'message' => MessageResponse::UPDATE_OKEY]);
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
        try {
            $idsDelete = explode(",", $ids);
            foreach ($idsDelete as $id) {
                $nit = Nit::find($id);
                if ($nit != null && $nit->sucursal->count() > 0) {
                    $nit->delete();
                } else {
                    return response(["message" => sprintf(MessageException::DB_CASCADE_DELETE, 'nit', 'sucursal')], Response::HTTP_OK);
                }
            }
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
