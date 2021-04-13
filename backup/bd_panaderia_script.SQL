CREATE SEQUENCE categoria_idcategoria_seq INCREMENT 1 START 1
;

CREATE TABLE categoria ( 
	idcategoria integer DEFAULT nextval(('categoria_idcategoria_seq'::text)::regclass) NOT NULL,
	nombre varchar(50) NULL
)
;

CREATE SEQUENCE cliente_idcliente_seq INCREMENT 1 START 1
;

CREATE TABLE cliente ( 
	idcliente integer DEFAULT nextval(('cliente_idcliente_seq'::text)::regclass) NOT NULL,
	ci varchar(50) NOT NULL,
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NOT NULL,
	telefono_celular varchar(50) NOT NULL,
	direccion varchar(50) NOT NULL
)
;

CREATE SEQUENCE compra_idcompra_seq INCREMENT 1 START 1
;

CREATE TABLE compra ( 
	idcompra integer DEFAULT nextval(('compra_idcompra_seq'::text)::regclass) NOT NULL,
	fecha_hora timestamp NOT NULL,
	total integer NOT NULL,
	fkidproveedor integer NOT NULL
)
;

CREATE TABLE detalle_compra ( 
	fkidinsumo integer NOT NULL,
	fkidcompra integer NOT NULL,
	cantidad integer NOT NULL,
	precio real NOT NULL
)
;

CREATE TABLE detalle_entrada ( 
	fkidorden_entrada integer NOT NULL,
	fkidinventario_producto integer NOT NULL,
	cantidad integer NULL
)
;

CREATE TABLE detalle_inventario ( 
	fkidinventario_inicial integer NOT NULL,
	fkidsucursal_producto integer NOT NULL,
	cantidad integer NOT NULL
)
;

CREATE TABLE detalle_produccion ( 
	fkidficha_produccion integer NOT NULL,
	fkidproducto integer NOT NULL,
	cantidad integer NOT NULL,
	costo integer NOT NULL
)
;

CREATE TABLE detalle_salida ( 
	fkidorden_salida integer NOT NULL,
	fkidinventario_producto integer NOT NULL,
	cantidad integer NOT NULL
)
;

CREATE TABLE detalle_venta ( 
	fkidalmacen_producto integer NOT NULL,
	fkidventa integer NOT NULL,
	cantidad integer NOT NULL,
	precio real NOT NULL
)
;

CREATE SEQUENCE ficha_produccion_idficha_produccion_seq INCREMENT 1 START 1
;

CREATE TABLE ficha_produccion ( 
	idficha_produccion integer DEFAULT nextval(('ficha_produccion_idficha_produccion_seq'::text)::regclass) NOT NULL,
	fecha_hora timestamp NOT NULL,
	cantidad integer NOT NULL,
	estado varchar(10) NOT NULL
)
;

CREATE SEQUENCE insumo_idinsumo_seq INCREMENT 1 START 1
;

CREATE TABLE insumo ( 
	idinsumo integer DEFAULT nextval(('insumo_idinsumo_seq'::text)::regclass) NOT NULL,
	nombre varchar(50) NOT NULL,
	costo decimal(10,2) NOT NULL,
	stock integer NOT NULL,
	stock_minimo integer NOT NULL,
	stock_maximo integer NOT NULL,
	fecha_vencimiento timestamp NOT NULL,
	fkidunidad_medida integer NOT NULL
)
;

CREATE SEQUENCE inventario_inicial_idinventario_inicial_seq INCREMENT 1 START 1
;

CREATE TABLE inventario_inicial ( 
	idinventario_inicial integer DEFAULT nextval(('inventario_inicial_idinventario_inicial_seq'::text)::regclass) NOT NULL,
	fecha timestamp NOT NULL,
	fkidsucursal integer NOT NULL
)
;

CREATE SEQUENCE inventario_producto_idinventario_producto_seq INCREMENT 1 START 1
;

CREATE TABLE inventario_producto ( 
	idinventario_producto integer DEFAULT nextval(('inventario_producto_idinventario_producto_seq'::text)::regclass) NOT NULL,
	stock integer NOT NULL,
	stock_minimo integer NOT NULL,
	stock_maximo integer NOT NULL,
	fkidproducto integer NOT NULL
)
;

CREATE SEQUENCE orden_entrada_idorden_entrada_seq INCREMENT 1 START 1
;

CREATE TABLE orden_entrada ( 
	idorden_entrada integer DEFAULT nextval(('orden_entrada_idorden_entrada_seq'::text)::regclass) NOT NULL,
	numero_orden integer NOT NULL,
	fecha_hora timestamp NOT NULL,
	nota varchar(200) NOT NULL,
	fkidsucursal integer NOT NULL
)
;

CREATE SEQUENCE orden_salida_idorden_salida_seq INCREMENT 1 START 1
;

CREATE TABLE orden_salida ( 
	idorden_salida integer DEFAULT nextval(('orden_salida_idorden_salida_seq'::text)::regclass) NOT NULL,
	numero_orden integer NOT NULL,
	fecha_hora timestamp NOT NULL,
	nota varchar(200) NULL,
	fkidsucursal integer NOT NULL
)
;

CREATE SEQUENCE pedido_idpedido_seq INCREMENT 1 START 1
;

CREATE TABLE pedido ( 
	idpedido integer DEFAULT nextval(('pedido_idpedido_seq'::text)::regclass) NOT NULL,
	fecha timestamp NOT NULL,
	hora timestamp NOT NULL,
	coordenada varchar(100) NOT NULL,
	observacion varchar(100) NULL,
	direccion varchar(100) NOT NULL,
	estado varchar(10) NULL,
	referencia varchar(200) NOT NULL,
	fkidtipo_entrega integer NOT NULL
)
;

CREATE SEQUENCE personal_idpersonal_seq INCREMENT 1 START 1
;

CREATE TABLE personal ( 
	idpersonal integer DEFAULT nextval(('personal_idpersonal_seq'::text)::regclass) NOT NULL,
	nombre varchar(50) NOT NULL,
	ci varchar(50) NOT NULL,
	apellido varchar(50) NOT NULL,
	telefono_celular varchar(50) NOT NULL,
	direccion varchar(50) NOT NULL,
	fkidtipo_personal integer NOT NULL
)
;

CREATE TABLE produccion_personal ( 
	fkidficha_produccion integer NOT NULL,
	fkidpersonal integer NOT NULL,
	fecha timestamp NOT NULL
)
;

CREATE SEQUENCE producto_idproducto_seq INCREMENT 1 START 1
;

CREATE TABLE producto ( 
	idproducto integer DEFAULT nextval(('producto_idproducto_seq'::text)::regclass) NOT NULL,
	nombre varchar(50) NOT NULL,
	descripcion varchar(50) NOT NULL,
	precio numeric(10,2) NOT NULL,
	foto varchar(200) NULL,
	fkidcategoria integer NOT NULL
)
;

CREATE SEQUENCE proveedor_idproveedor_seq INCREMENT 1 START 1
;

CREATE TABLE proveedor ( 
	idproveedor integer DEFAULT nextval(('proveedor_idproveedor_seq'::text)::regclass) NOT NULL,
	empresa varchar(50) NOT NULL,
	ci_nit varchar(50) NOT NULL,
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NOT NULL,
	telefono_celular varchar(50) NOT NULL,
	email varchar(50) NOT NULL
)
;

CREATE SEQUENCE receta_idreceta_seq INCREMENT 1 START 1
;

CREATE TABLE receta ( 
	idreceta integer DEFAULT nextval(('receta_idreceta_seq'::text)::regclass) NOT NULL,
	costo_produccion integer NOT NULL,
	tiempo_produccion timestamp NOT NULL,
	fkidproducto integer NOT NULL,
	total_masa integer NOT NULL,
	peso integer NOT NULL,
	bollos numeric(10,2) NOT NULL,
	cantidad_producto numeric(10,2) NOT NULL
)
;

CREATE TABLE receta_insumo ( 
	fkidreceta integer NOT NULL,
	fkidinsumo integer NOT NULL,
	cantidad integer NOT NULL,
	costo integer NOT NULL
)
;

CREATE SEQUENCE sucursal_idsucursal_seq INCREMENT 1 START 1
;

CREATE TABLE sucursal ( 
	idsucursal integer DEFAULT nextval(('sucursal_idsucursal_seq'::text)::regclass) NOT NULL,
	nombre varchar(50) NOT NULL,
	direccion varchar(100) NOT NULL,
	telefono varchar(10) NOT NULL
)
;

CREATE SEQUENCE sucursal_producto_idsucursal_producto_seq INCREMENT 1 START 1
;

CREATE TABLE sucursal_producto ( 
	idsucursal_producto integer DEFAULT nextval(('sucursal_producto_idsucursal_producto_seq'::text)::regclass) NOT NULL,
	stock integer NOT NULL,
	stock_minimo integer NOT NULL,
	stock_maximo integer NOT NULL,
	fkidsucursal integer NOT NULL,
	fkidproducto integer NOT NULL
)
;

CREATE SEQUENCE tipo_entrega_idtipo_entrega_seq INCREMENT 1 START 1
;

CREATE TABLE tipo_entrega ( 
	idtipo_entrega integer DEFAULT nextval(('tipo_entrega_idtipo_entrega_seq'::text)::regclass) NOT NULL,
	nombre varchar(50) NOT NULL
)
;

CREATE SEQUENCE tipo_personal_idtipo_personal_seq INCREMENT 1 START 1
;

CREATE TABLE tipo_personal ( 
	idtipo_personal integer DEFAULT nextval(('tipo_personal_idtipo_personal_seq'::text)::regclass) NOT NULL,
	nombre varchar(50) NOT NULL
)
;

CREATE SEQUENCE unidad_medida_idunidad_medida_seq INCREMENT 1 START 1
;

CREATE TABLE unidad_medida ( 
	idunidad_medida integer DEFAULT nextval(('unidad_medida_idunidad_medida_seq'::text)::regclass) NOT NULL,
	nombre varchar(50) NOT NULL,
	abreviatura varchar(50) NOT NULL
)
;

CREATE SEQUENCE usuario_idusuario_seq INCREMENT 1 START 1
;

CREATE TABLE usuario ( 
	idusuario integer DEFAULT nextval(('usuario_idusuario_seq'::text)::regclass) NOT NULL,
	email varchar(50) NOT NULL,
	password varchar(200) NOT NULL,
	fkidcliente integer NULL,
	fkidpersonal integer NULL,
	token varchar(255) NULL
)
;

CREATE SEQUENCE venta_idventa_seq INCREMENT 1 START 1
;

CREATE TABLE venta ( 
	idventa integer DEFAULT nextval(('venta_idventa_seq'::text)::regclass) NOT NULL,
	fecha_hora timestamp NOT NULL,
	total integer NOT NULL,
	fkidcliente integer NOT NULL,
	fkidusuario integer NOT NULL,
	fkidpedido integer NULL
)
;


ALTER TABLE categoria ADD CONSTRAINT PK_categoria 
	PRIMARY KEY (idcategoria)
;


ALTER TABLE cliente ADD CONSTRAINT PK_cliente 
	PRIMARY KEY (idcliente)
;


ALTER TABLE compra ADD CONSTRAINT PK_compra 
	PRIMARY KEY (idcompra)
;


ALTER TABLE detalle_compra ADD CONSTRAINT PK_detalle_compra 
	PRIMARY KEY (fkidinsumo, fkidcompra)
;


ALTER TABLE detalle_entrada ADD CONSTRAINT PK_detalle_entrada 
	PRIMARY KEY (fkidorden_entrada, fkidinventario_producto)
;


ALTER TABLE detalle_inventario ADD CONSTRAINT PK_detalle_inventario 
	PRIMARY KEY (fkidinventario_inicial, fkidsucursal_producto)
;


ALTER TABLE detalle_produccion ADD CONSTRAINT PK_detalle_produccion 
	PRIMARY KEY (fkidficha_produccion, fkidproducto)
;


ALTER TABLE detalle_salida ADD CONSTRAINT PK_detalle_salida 
	PRIMARY KEY (fkidorden_salida, fkidinventario_producto)
;


ALTER TABLE detalle_venta ADD CONSTRAINT PK_detalle_venta 
	PRIMARY KEY (fkidalmacen_producto, fkidventa)
;


ALTER TABLE ficha_produccion ADD CONSTRAINT PK_ficha_produccion 
	PRIMARY KEY (idficha_produccion)
;


ALTER TABLE insumo ADD CONSTRAINT PK_insumo 
	PRIMARY KEY (idinsumo)
;


ALTER TABLE inventario_inicial ADD CONSTRAINT PK_inventario_inicial 
	PRIMARY KEY (idinventario_inicial)
;


ALTER TABLE inventario_producto ADD CONSTRAINT PK_inventario_producto 
	PRIMARY KEY (idinventario_producto)
;


ALTER TABLE orden_entrada ADD CONSTRAINT PK_orden_entrada 
	PRIMARY KEY (idorden_entrada)
;


ALTER TABLE orden_salida ADD CONSTRAINT PK_orden_salida 
	PRIMARY KEY (idorden_salida)
;


ALTER TABLE pedido ADD CONSTRAINT PK_pedido 
	PRIMARY KEY (idpedido)
;


ALTER TABLE personal ADD CONSTRAINT PK_personal 
	PRIMARY KEY (idpersonal)
;


ALTER TABLE produccion_personal ADD CONSTRAINT PK_produccion_personal 
	PRIMARY KEY (fkidficha_produccion, fkidpersonal)
;


ALTER TABLE producto ADD CONSTRAINT PK_producto 
	PRIMARY KEY (idproducto)
;


ALTER TABLE proveedor ADD CONSTRAINT PK_proveedor 
	PRIMARY KEY (idproveedor)
;


ALTER TABLE receta ADD CONSTRAINT PK_Receta 
	PRIMARY KEY (idreceta)
;


ALTER TABLE receta_insumo ADD CONSTRAINT PK_receta_insumo 
	PRIMARY KEY (fkidreceta, fkidinsumo)
;


ALTER TABLE sucursal ADD CONSTRAINT PK_Sucursal 
	PRIMARY KEY (idsucursal)
;


ALTER TABLE sucursal_producto ADD CONSTRAINT PK_almacen_producto 
	PRIMARY KEY (idsucursal_producto)
;


ALTER TABLE tipo_entrega ADD CONSTRAINT PK_tipo_entrega 
	PRIMARY KEY (idtipo_entrega)
;


ALTER TABLE tipo_personal ADD CONSTRAINT PK_tipo_personal 
	PRIMARY KEY (idtipo_personal)
;


ALTER TABLE unidad_medida ADD CONSTRAINT PK_unidad_medida 
	PRIMARY KEY (idunidad_medida)
;


ALTER TABLE usuario ADD CONSTRAINT PK_usuario 
	PRIMARY KEY (idusuario)
;


ALTER TABLE venta ADD CONSTRAINT PK_venta 
	PRIMARY KEY (idventa)
;




ALTER TABLE compra ADD CONSTRAINT FK_compra_proveedor 
	FOREIGN KEY (fkidproveedor) REFERENCES proveedor (idproveedor)
;

ALTER TABLE detalle_compra ADD CONSTRAINT FK_detalle_compra_compra 
	FOREIGN KEY (fkidcompra) REFERENCES compra (idcompra)
;

ALTER TABLE detalle_compra ADD CONSTRAINT FK_detalle_compra_insumo 
	FOREIGN KEY (fkidinsumo) REFERENCES insumo (idinsumo)
;

ALTER TABLE detalle_entrada ADD CONSTRAINT FK_detalle_entrada_inventario_producto 
	FOREIGN KEY (fkidinventario_producto) REFERENCES inventario_producto (idinventario_producto)
;

ALTER TABLE detalle_entrada ADD CONSTRAINT FK_detalle_entrada_orden_entrada 
	FOREIGN KEY (fkidorden_entrada) REFERENCES orden_entrada (idorden_entrada)
;

ALTER TABLE detalle_inventario ADD CONSTRAINT FK_detalle_inventario_inventario_inicial 
	FOREIGN KEY (fkidinventario_inicial) REFERENCES inventario_inicial (idinventario_inicial)
;

ALTER TABLE detalle_inventario ADD CONSTRAINT FK_detalle_inventario_sucursal_producto 
	FOREIGN KEY (fkidsucursal_producto) REFERENCES sucursal_producto (idsucursal_producto)
;

ALTER TABLE detalle_produccion ADD CONSTRAINT FK_detalle_produccion_ficha_produccion 
	FOREIGN KEY (fkidficha_produccion) REFERENCES ficha_produccion (idficha_produccion)
;

ALTER TABLE detalle_produccion ADD CONSTRAINT FK_detalle_produccion_producto 
	FOREIGN KEY (fkidproducto) REFERENCES producto (idproducto)
;

ALTER TABLE detalle_salida ADD CONSTRAINT FK_detalle_salida_inventario_producto 
	FOREIGN KEY (fkidinventario_producto) REFERENCES inventario_producto (idinventario_producto)
;

ALTER TABLE detalle_salida ADD CONSTRAINT FK_detalle_salida_orden_salida 
	FOREIGN KEY (fkidorden_salida) REFERENCES orden_salida (idorden_salida)
;

ALTER TABLE detalle_venta ADD CONSTRAINT FK_detalle_venta_almacen_producto 
	FOREIGN KEY (fkidalmacen_producto) REFERENCES sucursal_producto (idsucursal_producto)
;

ALTER TABLE detalle_venta ADD CONSTRAINT FK_detalle_venta_venta 
	FOREIGN KEY (fkidventa) REFERENCES venta (idventa)
;

ALTER TABLE insumo ADD CONSTRAINT FK_insumo_unidad_medida 
	FOREIGN KEY (fkidunidad_medida) REFERENCES unidad_medida (idunidad_medida)
;

ALTER TABLE inventario_inicial ADD CONSTRAINT FK_inventario_inicial_sucursal 
	FOREIGN KEY (fkidsucursal) REFERENCES sucursal (idsucursal)
;

ALTER TABLE inventario_producto ADD CONSTRAINT FK_inventario_producto_producto 
	FOREIGN KEY (fkidproducto) REFERENCES producto (idproducto)
;

ALTER TABLE orden_salida ADD CONSTRAINT FK_orden_salida_sucursal 
	FOREIGN KEY (fkidsucursal) REFERENCES sucursal (idsucursal)
;

ALTER TABLE personal ADD CONSTRAINT FK_personal_tipo_personal 
	FOREIGN KEY (fkidtipo_personal) REFERENCES tipo_personal (idtipo_personal)
;

ALTER TABLE producto ADD CONSTRAINT FK_producto_categoria 
	FOREIGN KEY (fkidcategoria) REFERENCES categoria (idcategoria)
;

ALTER TABLE receta_insumo ADD CONSTRAINT FK_receta_insumo_insumo 
	FOREIGN KEY (fkidinsumo) REFERENCES insumo (idinsumo)
;

ALTER TABLE sucursal_producto ADD CONSTRAINT FK_almacen_producto_producto 
	FOREIGN KEY (fkidproducto) REFERENCES producto (idproducto)
;

ALTER TABLE sucursal_producto ADD CONSTRAINT FK_almacen_producto_sucursal 
	FOREIGN KEY (fkidsucursal) REFERENCES sucursal (idsucursal)
;

ALTER TABLE usuario ADD CONSTRAINT FK_usuario_cliente 
	FOREIGN KEY (fkidcliente) REFERENCES cliente (idcliente)
;

ALTER TABLE usuario ADD CONSTRAINT FK_usuario_personal 
	FOREIGN KEY (fkidpersonal) REFERENCES personal (idpersonal)
;

ALTER TABLE venta ADD CONSTRAINT FK_venta_cliente 
	FOREIGN KEY (fkidcliente) REFERENCES cliente (idcliente)
;

ALTER TABLE venta ADD CONSTRAINT FK_venta_pedido 
	FOREIGN KEY (fkidpedido) REFERENCES pedido (idpedido)
;

ALTER TABLE venta ADD CONSTRAINT FK_venta_usuario 
	FOREIGN KEY (fkidusuario) REFERENCES usuario (idusuario)
;
