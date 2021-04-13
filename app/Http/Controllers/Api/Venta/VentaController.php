<?php

namespace App\Http\Controllers\Api\Venta;

use App\DetalleVenta;
use App\Exceptions\MessageException;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Api\CodigoControlController;
use App\Http\Controllers\Controller;
use App\Http\Message\MessageResponse;
use App\SucursalProducto;
use App\Venta;
use App\Dosificacion;
use App\Nit;
use App\Factura;
use App\Sucursal;
use Error;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class VentaController extends Controller
{
    const CODE_STOCK_VALIDATE = 23514;
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_unless(AuthController::currentUserHasPermission('venta.listar'), 403);
        try {
            if (AuthController::currentUserHasRole('Administrador')) {
                $ventas = Venta::with('cliente')->orderBy('idventa', 'desc')->get();
            } else {
                $idsucursal = AuthController::getIdSucursalOfCurrentUser();
                $ventas = Venta::with('cliente')->orderBy('idventa', 'desc')->where('fkidsucursal', $idsucursal)->get();
            }
            return response(["data" => $ventas, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
        abort_unless(AuthController::currentUserHasPermission('venta.guardar'), 403);
        DB::beginTransaction();
        try {
            $venta = Venta::create([
                'fecha_hora' => date('Y-m-d H:i:s'),
                'total' => $request->total,
                'fkidcliente' => $request->fkidcliente,
                'fkidusuario' => auth()->user()->usuario->idusuario,
                'fkidsucursal' => AuthController::getIdSucursalOfCurrentUser()
            ]);

            $detalles = $request->detalles;
            foreach ($detalles as $value) {
                $venta->sucursalProducto()->attach($value['fkidsucursal_producto'], [
                    'cantidad' => $value['cantidad'],
                    'precio' => $value['precio'],
                    'subtotal' => $value['subtotal'],
                ]);

                $sucursalProducto = SucursalProducto::find($value['fkidsucursal_producto']);
                $sucursalProducto->update(['stock' => $sucursalProducto->stock - $value['cantidad']]);
            }
            //datos necesarios para factura
            $rsp = $this->obtenerDatosParaFacturar($venta, $request);
            //create factura
            $saveFactura = Factura::create([
                'numero' => $rsp->factura->numero,
                'debito_fiscal' => $rsp->factura->debito_fiscal,
                'codigo_control' => $rsp->factura->codigo_control,
                'estado' => $rsp->factura->estado,
                'fkiddosificacion' => $rsp->factura->fkiddosificacion,
                'fkidventa' => $rsp->factura->fkidventa
            ]);
            //fecha limite
            $fecha_array = explode('-', $rsp->dosificacion->fecha_limite);
            $fecha_limite = $fecha_array[2] . "/" . $fecha_array[1] . "/" . $fecha_array[0];
            //fecha de emision
            $fecha_array_datetime = explode(' ', $venta->fecha_hora);
            $fecha_array_fecha = explode('-', $fecha_array_datetime[0]);
            $fecha_emision = $fecha_array_fecha[2] . "/" . $fecha_array_fecha[1] . "/" . $fecha_array_fecha[0];
            //codigo qr data
            $codigoQr = [
                $rsp->nitEmpresa->nit,
                $rsp->factura->numero,
                $rsp->dosificacion->numero_autorizacion,
                $fecha_emision,
                $venta->total,
                $venta->total,
                $rsp->factura->codigo_control,
                $request->ci,
                0,
                0,
                0,
                0
            ];

            $respuesta = [
                "codigoQr" => $codigoQr, "venta" => $venta,
                "sucursal" => $rsp->sucursal, "fechaLimite" => $fecha_limite
            ];
            DB::commit();
            return response(['data' => response()->json($respuesta), 'message' => MessageResponse::SAVE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            DB::rollBack();
            if ($th->getCode() == self::CODE_STOCK_VALIDATE) {
                return response(["message" => MessageException::DB_STOCK_VALIDATE], Response::HTTP_INTERNAL_SERVER_ERROR);
            }
            return response(
                [
                    "message" => $th->getMessage(),
                    "code" => $th->getCode(),
                    "file" => $th->getFile(),
                    "line" => $th->getLine(),
                    "trace" => $th->getTraceAsString(),
                    "message1" => MessageException::DB_GETDATA
                ],
                Response::HTTP_INTERNAL_SERVER_ERROR
            );
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
        abort_unless(AuthController::currentUserHasPermission('venta.visualizar'), 403);
        try {
            $detalle = DetalleVenta::with(['venta.sucursal', 'sucursalProducto.producto'])->where('fkidventa', $id)->get();
            return response(["data" => $detalle, 'message' => MessageResponse::GET_OKEY], Response::HTTP_OK);
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
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($idsDelete)
    {
        abort_unless(AuthController::currentUserHasPermission('venta.eliminar'), 403);
        try {
            $ids = explode(",", $idsDelete);
            Venta::destroy($ids);
            return response(["message" => MessageResponse::DELETE_OKEY], Response::HTTP_OK);
        } catch (\Throwable $th) {
            return response(["message" => MessageException::DB_DELETEDATA], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    ///factura [METODOS]
    public function obtenerDatosParaFacturar(Venta $venta, Request $dataRequest)
    {
        $idsucursal =   AuthController::getIdSucursalOfCurrentUser();
        //obtener dosificacion
        $dosificacion = Dosificacion::with('sucursal')->where('fkidsucursal', $idsucursal)->first();
        $idnit = $dosificacion->sucursal;
        //obtener nit
        $nit = Nit::find($idnit['fkidnit']);
        //obtener sucursal
        $sucursal = Sucursal::find($idsucursal);
        //nro factura
        $numero_inicial = $dosificacion->numero_inicial;
        //cantidad de factura (count tabla factura)
        $facturaCount = Factura::where('fkiddosificacion', $dosificacion->iddosificacion)->count();
        $numero_factura = $facturaCount + $numero_inicial;
        //numero que le sigue a la ultima factura de la tabla factura
        $facturaUltimo = Factura::where('fkiddosificacion', $dosificacion->iddosificacion)->orderBy('idfactura', 'desc')->first();
        $lastNumeroFactura = $facturaUltimo ? $facturaUltimo->numero : 0;
        //validacion si el numero de factura es correcto[COMPARANDO]
        if ($numero_factura !== $lastNumeroFactura + 1) {
            return response()->json(["data" => false])->getData();
        }
        $codControl = new CodigoControlController();
        //fecha de creacion
        $fecha_array_datetime = explode(' ', $venta->fecha_hora);
        $fecha_array_fecha = explode('-', $fecha_array_datetime[0]);
        $fecha_created = $fecha_array_fecha[0] . "/" . $fecha_array_fecha[1] . "/" . $fecha_array_fecha[2];

        //generacion de codigo de control
        $codigo = $codControl->generar($dosificacion->numero_autorizacion, $numero_factura, $dataRequest->ci, $fecha_created, $venta->total, $dosificacion->llave);

        //creando objeto factura
        $facturaNew = new Factura();
        $facturaNew->fkidventa = $venta->idventa;
        $facturaNew->fkiddosificacion = $dosificacion->iddosificacion;
        $facturaNew->numero = $numero_factura;
        $facturaNew->debito_fiscal = $venta->total * 0.13;
        $facturaNew->codigo_control = $codigo;
        $facturaNew->estado = 'V';

        //respuesta
        $rsp = response()->json(["factura" => $facturaNew, "dosificacion" => $dosificacion, "nitEmpresa" => $nit, "sucursal" => $sucursal]);
        return $rsp->getData();
    }
}
