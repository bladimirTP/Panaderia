<?php

namespace App\Exceptions;

class MessageException
{
    const DB_CONECTION = "¡Woops! Error de conexión a la base de datos";
    const DB_GETDATA = "No se ha podido recuperar los datos, si el error persiste, por favor contacte con los administradores";
    const DB_SAVEDATA = "¡Woops! No se ha podido registrar los datos, si el error persiste, por favor contacte con los administradores";
    const DB_UPDATEDATA = "¡Woops! No se ha podido editar los datos, si el error persiste, por favor contacte con los administradores";
    const DB_DELETEDATA = "¡Woops! No se ha podido eliminar los datos, si el error persiste, por favor contacte con los administradores";
    const DB_DEPENDENCE = '!No se puede eliminar uno de los registros, esto puede ocacionar problemas en el funcionamiento, si desea eliminarlo por favor contacte con los administradores';
    const DB_NOT_FOUND = 'No existe el registro';
    const DB_LOGIN = 'Credenciales Inválidos, por favor intente de nuevo.';
    const DB_STOCK_VALIDATE = "¡Woops! no hay stock suficiente para efectuar la venta.";
    const DB_STOCK_VALIDATE_PEDIDO = "¡Woops! no hay stock suficiente para efectuar el pedido.";

    const DB_CASCADE_DELETE = 'Existe un %2$s asociado a la %1$s. Por favor, primero eliminar el %2$s asociado a la %1$s';
}
