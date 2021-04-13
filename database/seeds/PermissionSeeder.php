<?php

use App\User;
use App\Usuario;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class PermissionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::beginTransaction();
        try {
            $role = Role::create(['name' => 'Root']);
            $usuario = Usuario::create([
                'email' => 'team.edg@gmail.com',
                'password' => '123123',
            ]);

            $user = User::create([
                'name' => 'Team EDG',
                'email' => $usuario->email,
                'password' => $usuario->password,
                'fkidusuario' => $usuario->idusuario
            ]);

            //ADMINISTRACION
            Permission::create(['name' => 'modulo_administracion.acceso']);

            Permission::create(['name' => 'usuario.acceso']);

            Permission::create(['name' => 'usuario.listar']);
            Permission::create(['name' => 'usuario.guardar']);
            Permission::create(['name' => 'usuario.actualizar']);
            Permission::create(['name' => 'usuario.visualizar']);
            Permission::create(['name' => 'usuario.eliminar']);

            Permission::create(['name' => 'rol.acceso']);

            Permission::create(['name' => 'rol.listar']);
            Permission::create(['name' => 'rol.guardar']);
            Permission::create(['name' => 'rol.actualizar']);
            Permission::create(['name' => 'rol.visualizar']);
            Permission::create(['name' => 'rol.eliminar']);

            Permission::create(['name' => 'personal.acceso']);

            Permission::create(['name' => 'personal.listar']);
            Permission::create(['name' => 'personal.guardar']);
            Permission::create(['name' => 'personal.actualizar']);
            Permission::create(['name' => 'personal.visualizar']);
            Permission::create(['name' => 'personal.eliminar']);

            Permission::create(['name' => 'permiso.acceso']);

            Permission::create(['name' => 'permiso.listar']);
            Permission::create(['name' => 'permiso.guardar']);
            Permission::create(['name' => 'permiso.actualizar']);
            Permission::create(['name' => 'permiso.visualizar']);
            Permission::create(['name' => 'permiso.eliminar']);

            //PRODUCCION
            Permission::create(['name' => 'modulo_produccion.acceso']);

            Permission::create(['name' => 'ficha_produccion.acceso']);

            Permission::create(['name' => 'ficha_produccion.listar']);
            Permission::create(['name' => 'ficha_produccion.guardar']);
            Permission::create(['name' => 'ficha_produccion.actualizar']);
            Permission::create(['name' => 'ficha_produccion.visualizar']);
            Permission::create(['name' => 'ficha_produccion.eliminar']);

            Permission::create(['name' => 'insumo.acceso']);

            Permission::create(['name' => 'insumo.listar']);
            Permission::create(['name' => 'insumo.guardar']);
            Permission::create(['name' => 'insumo.actualizar']);
            Permission::create(['name' => 'insumo.visualizar']);
            Permission::create(['name' => 'insumo.eliminar']);

            Permission::create(['name' => 'receta.acceso']);

            Permission::create(['name' => 'receta.listar']);
            Permission::create(['name' => 'receta.guardar']);
            Permission::create(['name' => 'receta.actualizar']);
            Permission::create(['name' => 'receta.visualizar']);
            Permission::create(['name' => 'receta.eliminar']);

            Permission::create(['name' => 'inventario_producto.acceso']);

            Permission::create(['name' => 'inventario_producto.listar']);
            Permission::create(['name' => 'inventario_producto.guardar']);
            Permission::create(['name' => 'inventario_producto.actualizar']);
            Permission::create(['name' => 'inventario_producto.visualizar']);
            Permission::create(['name' => 'inventario_producto.eliminar']);

            //COMPRAS
            Permission::create(['name' => 'modulo_compra.acceso']);

            Permission::create(['name' => 'proveedor.acceso']);

            Permission::create(['name' => 'proveedor.listar']);
            Permission::create(['name' => 'proveedor.guardar']);
            Permission::create(['name' => 'proveedor.actualizar']);
            Permission::create(['name' => 'proveedor.visualizar']);
            Permission::create(['name' => 'proveedor.eliminar']);

            Permission::create(['name' => 'medidas.acceso']);

            Permission::create(['name' => 'medidas.listar']);
            Permission::create(['name' => 'medidas.guardar']);
            Permission::create(['name' => 'medidas.actualizar']);
            Permission::create(['name' => 'medidas.visualizar']);
            Permission::create(['name' => 'medidas.eliminar']);

            Permission::create(['name' => 'compra.acceso']);

            Permission::create(['name' => 'compra.listar']);
            Permission::create(['name' => 'compra.guardar']);
            Permission::create(['name' => 'compra.actualizar']);
            Permission::create(['name' => 'compra.visualizar']);
            Permission::create(['name' => 'compra.eliminar']);


            //VENTA
            Permission::create(['name' => 'modulo_venta.acceso']);

            Permission::create(['name' => 'cliente.acceso']);

            Permission::create(['name' => 'cliente.listar']);
            Permission::create(['name' => 'cliente.guardar']);
            Permission::create(['name' => 'cliente.actualizar']);
            Permission::create(['name' => 'cliente.visualizar']);
            Permission::create(['name' => 'cliente.eliminar']);

            Permission::create(['name' => 'categoria.acceso']);

            Permission::create(['name' => 'categoria.listar']);
            Permission::create(['name' => 'categoria.guardar']);
            Permission::create(['name' => 'categoria.actualizar']);
            Permission::create(['name' => 'categoria.visualizar']);
            Permission::create(['name' => 'categoria.eliminar']);

            Permission::create(['name' => 'producto.acceso']);

            Permission::create(['name' => 'producto.listar']);
            Permission::create(['name' => 'producto.guardar']);
            Permission::create(['name' => 'producto.actualizar']);
            Permission::create(['name' => 'producto.visualizar']);
            Permission::create(['name' => 'producto.eliminar']);

            Permission::create(['name' => 'venta.acceso']);

            Permission::create(['name' => 'venta.listar']);
            Permission::create(['name' => 'venta.guardar']);
            Permission::create(['name' => 'venta.actualizar']);
            Permission::create(['name' => 'venta.visualizar']);
            Permission::create(['name' => 'venta.eliminar']);

            Permission::create(['name' => 'pedido.acceso']);

            Permission::create(['name' => 'pedido.listar']);
            Permission::create(['name' => 'pedido.guardar']);
            Permission::create(['name' => 'pedido.actualizar']);
            Permission::create(['name' => 'pedido.visualizar']);
            Permission::create(['name' => 'pedido.eliminar']);

            //INVENTARIO
            Permission::create(['name' => 'modulo_inventario.acceso']);

            Permission::create(['name' => 'sucursal.acceso']);

            Permission::create(['name' => 'sucursal.listar']);
            Permission::create(['name' => 'sucursal.guardar']);
            Permission::create(['name' => 'sucursal.actualizar']);
            Permission::create(['name' => 'sucursal.visualizar']);
            Permission::create(['name' => 'sucursal.eliminar']);

            Permission::create(['name' => 'inventario_inicial.acceso']);

            Permission::create(['name' => 'inventario_inicial.listar']);
            Permission::create(['name' => 'inventario_inicial.guardar']);
            Permission::create(['name' => 'inventario_inicial.actualizar']);
            Permission::create(['name' => 'inventario_inicial.visualizar']);
            Permission::create(['name' => 'inventario_inicial.eliminar']);

            Permission::create(['name' => 'sucursal_producto.acceso']);

            Permission::create(['name' => 'sucursal_producto.listar']);
            Permission::create(['name' => 'sucursal_producto.guardar']);
            Permission::create(['name' => 'sucursal_producto.actualizar']);
            Permission::create(['name' => 'sucursal_producto.visualizar']);
            Permission::create(['name' => 'sucursal_producto.eliminar']);

            Permission::create(['name' => 'orden_salida.acceso']);

            Permission::create(['name' => 'orden_salida.listar']);
            Permission::create(['name' => 'orden_salida.guardar']);
            Permission::create(['name' => 'orden_salida.actualizar']);
            Permission::create(['name' => 'orden_salida.visualizar']);
            Permission::create(['name' => 'orden_salida.eliminar']);

            Permission::create(['name' => 'orden_entrada.acceso']);

            Permission::create(['name' => 'orden_entrada.listar']);
            Permission::create(['name' => 'orden_entrada.guardar']);
            Permission::create(['name' => 'orden_entrada.actualizar']);
            Permission::create(['name' => 'orden_entrada.visualizar']);
            Permission::create(['name' => 'orden_entrada.eliminar']);

            //ROLES

            $role = Role::where('name', 'Root')->first();
            $user->assignRole($role->name);
            $permisos = Permission::all();
            foreach ($permisos as $key => $permiso) {
                $role->givePermissionTo($permiso->name);
            }
            DB::commit();
        } catch (\Throwable $th) {
            DB::rollback();
            dd($th);
        }
    }
}
