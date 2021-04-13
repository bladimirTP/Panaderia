<?php
namespace App\Http\Message;

class MessageResponse {
    const GET_OKEY = "Se ha recuperado la información correctamente.";
    const SAVE_OKEY = "Se ha registrado la información correctamente.";
    const UPDATE_OKEY = "Se ha editado la información correctamente.";
    const DELETE_OKEY = "Se ha elminado la información correctamente.";
    const LOGIN_OK = "Ha iniciado sesión exitósamente.";
    const LOGOUT_OK = "Ha cerrado sesión exitosamente.";

    const REPEAT_PRODUCT = "El producto ya existe en esta sucursal.";
    const ERROR_MEDIDA = "Error, Verifique las medidas correspondiente de los insumos";
    const FOREIGN_EXIST = "No se ha podido eliminar. El/Los item(s) seleccionado existe en otra relacion.";
    const ITEM_NO_EXIST_DELETE = "No existe el item seleccionado para eliminar";

    const ERROR_iNVENTARIO = "No existe el producto en la tabla inventario";
    const ERROR_PRODUCCION = "La produccion ya fue Completada";
    const DELETE_PRODUCCION = "No puede eliminar una produccion, ya completada";
}
