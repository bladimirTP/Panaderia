<?php
//header('Access-Control-Allow-Origin: *');
//header('Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE');
//header('Access-Control-Allow-Headers: Content-Type, X-Auth-Token, Origin, Authorization');

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
  return $request->user();
});



Route::get('test', 'TestController@testingMethod');

// estas rutas se pueden acceder sin proveer de un token válido.
Route::post('register', 'Auth\AuthController@register');
Route::post('login', 'Auth\AuthController@login');

Route::group(['prefix' => 'web', 'middleware' => ['auth.jwt']], function () {
  // estas rutas requiren de un token válido para poder accederse.
  Route::post('me', 'Auth\AuthController@getAuthUser');
  Route::post('logout', 'Auth\AuthController@logout');

  Route::apiResource('personal', 'Api\Administracion\PersonalController');
  Route::apiResource('permisos', 'Api\Administracion\PermisoApiController');
  Route::apiResource('roles', 'Api\Administracion\RolApiController');
  Route::apiResource('usuarios', 'Api\Administracion\UsuarioApiController');

  Route::apiResource('categoria', 'Api\Venta\CategoriaController');
  Route::apiResource('producto', 'Api\Venta\ProductoController');
  Route::apiResource('cliente', 'Api\Venta\ClienteController');
  Route::apiResource('venta', 'Api\Venta\VentaController');

  Route::apiResource('medidas', 'Api\Compra\UnidadMedidaController');
  Route::apiResource('insumos', 'Api\Compra\InsumoController');
  Route::apiResource('compras', 'Api\Compra\CompraController');
  Route::apiResource('proveedor', 'Api\Compra\ProveedorController');
  //Reporte de compras
  Route::post('compras_proveedor', 'Api\ReporteCompraController@compras_proveedor');

  Route::apiResource('tipo_entrega', 'Api\Pedido\TipoEntregaController');
  Route::apiResource('tipo_personal', 'Api\Administracion\TipoPersonalController');
  Route::apiResource('pedido', 'Api\Pedido\PedidoController');

  Route::apiResource('inv_inicial', 'Api\Inventario\InventarioInicialController');
  Route::apiResource('ord_salida', 'Api\Inventario\OrdenSalidaController');
  Route::apiResource('ord_entrada', 'Api\Inventario\OrdenEntradaController');
  Route::apiResource('sucursal_producto', 'Api\Inventario\SucursalProductoController');
  Route::apiResource('sucursal', 'Api\Inventario\SucursalController');

  // bladimitoco
  //post == http://localhost:8000/api/web/produccion/2/producto  -> para insetar una produccion le pasamos el producto a preparar

  Route::apiResource('inv_producto', 'Api\Produccion\InventarioProductoController');
  Route::apiResource('receta', 'Api\Produccion\RecetaController');
  Route::apiResource('produccions', 'Api\Produccion\FichaproduccionController');
  Route::apiResource('prod_detalle', 'Api\Produccion\DetalleproduccionController');
  Route::apiResource('rec_detalle', 'Api\Produccion\RecetaInsumoController');
  Route::apiResource('producto_produccion', 'Api\ProductoProduccionController');
  Route::post('reporteproduccion', 'Api\Produccion\ReporteProduccionController@getreporte');

  //facturacion
  Route::apiResource('nit', 'Api\NitController');
  Route::apiResource('dosificacion', 'Api\DosificacionController');
  Route::apiResource('factura', 'Api\FacturaController');

  //reporte venta
  Route::post('ventas_diarias', 'Api\ReporteVentaController@ventasDiarias');
  Route::get('personal_sucursal', 'Api\Pedido\AsignacionPedidoController@getPersonalBySucursal');
  Route::apiResource('asignacion_pedido', 'Api\Pedido\AsignacionPedidoController');
  Route::get('asignacion_empleado/{id}', 'Api\Pedido\AsignacionPedidoController@getByPedido');
  Route::post('update_token', 'Api\Venta\ClienteController@updateToken');
});

Route::group(['prefix' => 'movil'], function () {
  Route::post('register', 'Api\Venta\ClienteController@clientRegister');
  Route::post('login', 'Api\Venta\ClienteController@validateLogin');
  Route::apiResource('pedido', 'Api\Pedido\PedidoController');
  Route::get('pedido_cliente/{id}', 'Api\Pedido\PedidoController@getByCliente');
  Route::get('pedido_sucursal/{id}', 'Api\Pedido\PedidoController@getBySucursal');
  Route::get('pedido_entregado/{id}', 'Api\Pedido\PedidoController@setEstadoDisponible');
  Route::get('sucursal_producto/{id}', 'Api\Inventario\SucursalProductoController@show');
  Route::get('sucursal', 'Api\Inventario\SucursalController@getAll');
  Route::get('asignacion_pedido/{id}', 'Api\Pedido\AsignacionPedidoController@getByPersonal');
  Route::post('update_token', 'Api\Venta\ClienteController@updateToken');
  Route::get('usuario_personal/{id}', 'Api\Administracion\UsuarioApiController@getByPersonal');
  Route::put('update_perfil/{id}', 'Api\Venta\ClienteController@updateMovilPefil');
});
