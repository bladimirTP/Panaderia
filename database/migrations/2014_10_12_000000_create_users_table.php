<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->rememberToken();
            $table->timestamps();
            $table->softDeletes();
            $table->unsignedBigInteger('fkidusuario');
            $table->foreign('fkidusuario')->references('idusuario')->on('usuario');
        });


        Schema::table('detalle_compra', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('detalle_produccion', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('detalle_venta', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('detalle_salida', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('detalle_entrada', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('receta', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('receta_insumo', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('detalle_inventario', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('inventario_producto', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('inventario_inicial', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('sucursal', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('orden_salida', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('orden_entrada', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('usuario', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('categoria', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('cliente', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('compra', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('insumo', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('ficha_produccion', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('pedido', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('personal', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('producto', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('sucursal_producto', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('proveedor', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('tipo_entrega', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('tipo_personal', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('unidad_medida', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('venta', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::table('produccion_personal', function (Blueprint $table) {
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
