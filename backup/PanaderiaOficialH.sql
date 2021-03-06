PGDMP     '            	    
    x            d4frqgtd4eshsi     12.4 (Ubuntu 12.4-1.pgdg16.04+1)    12.3 ?    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    5785088    d4frqgtd4eshsi    DATABASE     ?   CREATE DATABASE d4frqgtd4eshsi WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE d4frqgtd4eshsi;
                eypzbnbznnepmq    false            ?           0    0    DATABASE d4frqgtd4eshsi    ACL     A   REVOKE CONNECT,TEMPORARY ON DATABASE d4frqgtd4eshsi FROM PUBLIC;
                   eypzbnbznnepmq    false    4271            ?           0    0    LANGUAGE plpgsql    ACL     1   GRANT ALL ON LANGUAGE plpgsql TO eypzbnbznnepmq;
                   postgres    false    840                       1259    9097725    asignacion_pedido    TABLE       CREATE TABLE public.asignacion_pedido (
    idasignacion_pedido integer NOT NULL,
    fkidpersonal integer NOT NULL,
    fkidpedido integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);
 %   DROP TABLE public.asignacion_pedido;
       public         heap    eypzbnbznnepmq    false                       1259    9097723 )   asignacion_pedido_idasignacion_pedido_seq    SEQUENCE     ?   CREATE SEQUENCE public.asignacion_pedido_idasignacion_pedido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public.asignacion_pedido_idasignacion_pedido_seq;
       public          eypzbnbznnepmq    false    268            ?           0    0 )   asignacion_pedido_idasignacion_pedido_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE public.asignacion_pedido_idasignacion_pedido_seq OWNED BY public.asignacion_pedido.idasignacion_pedido;
          public          eypzbnbznnepmq    false    267            ?            1259    7050203 	   categoria    TABLE     2  CREATE TABLE public.categoria (
    idcategoria integer DEFAULT nextval(('categoria_idcategoria_seq'::text)::regclass) NOT NULL,
    nombre character varying(50),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.categoria;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050201    categoria_idcategoria_seq    SEQUENCE     ?   CREATE SEQUENCE public.categoria_idcategoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.categoria_idcategoria_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050209    cliente    TABLE       CREATE TABLE public.cliente (
    idcliente integer DEFAULT nextval(('cliente_idcliente_seq'::text)::regclass) NOT NULL,
    ci character varying(50) NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    telefono_celular character varying(50) NOT NULL,
    direccion character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    token character varying(255)
);
    DROP TABLE public.cliente;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050207    cliente_idcliente_seq    SEQUENCE     ~   CREATE SEQUENCE public.cliente_idcliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.cliente_idcliente_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050215    compra    TABLE     y  CREATE TABLE public.compra (
    idcompra integer DEFAULT nextval(('compra_idcompra_seq'::text)::regclass) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    total integer NOT NULL,
    fkidproveedor integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.compra;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050213    compra_idcompra_seq    SEQUENCE     |   CREATE SEQUENCE public.compra_idcompra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.compra_idcompra_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050219    detalle_compra    TABLE     B  CREATE TABLE public.detalle_compra (
    fkidinsumo integer NOT NULL,
    fkidcompra integer NOT NULL,
    cantidad integer NOT NULL,
    precio real NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    subtotal real
);
 "   DROP TABLE public.detalle_compra;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050222    detalle_entrada    TABLE     *  CREATE TABLE public.detalle_entrada (
    fkidorden_entrada integer NOT NULL,
    fkidinventario_producto integer NOT NULL,
    cantidad integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 #   DROP TABLE public.detalle_entrada;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050225    detalle_inventario    TABLE     0  CREATE TABLE public.detalle_inventario (
    fkidinventario_inicial integer NOT NULL,
    fkidsucursal_producto integer NOT NULL,
    cantidad integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 &   DROP TABLE public.detalle_inventario;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050228    detalle_produccion    TABLE     G  CREATE TABLE public.detalle_produccion (
    fkidficha_produccion integer NOT NULL,
    fkidproducto integer NOT NULL,
    cantidad integer NOT NULL,
    costo numeric(10,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 &   DROP TABLE public.detalle_produccion;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050231    detalle_salida    TABLE       CREATE TABLE public.detalle_salida (
    fkidorden_salida integer NOT NULL,
    fkidinventario_producto integer NOT NULL,
    cantidad integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 "   DROP TABLE public.detalle_salida;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050234    detalle_venta    TABLE     ]  CREATE TABLE public.detalle_venta (
    fkidsucursal_producto integer NOT NULL,
    fkidventa integer NOT NULL,
    cantidad integer NOT NULL,
    precio numeric(10,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    subtotal numeric(10,2)
);
 !   DROP TABLE public.detalle_venta;
       public         heap    eypzbnbznnepmq    false                       1259    7050646    failed_jobs    TABLE     ?   CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.failed_jobs;
       public         heap    eypzbnbznnepmq    false                       1259    7050644    failed_jobs_id_seq    SEQUENCE     {   CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.failed_jobs_id_seq;
       public          eypzbnbznnepmq    false    258            ?           0    0    failed_jobs_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;
          public          eypzbnbznnepmq    false    257            ?            1259    7050239    ficha_produccion    TABLE     ?  CREATE TABLE public.ficha_produccion (
    idficha_produccion integer DEFAULT nextval(('ficha_produccion_idficha_produccion_seq'::text)::regclass) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    estado character varying(10) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    costo_total real
);
 $   DROP TABLE public.ficha_produccion;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050237 '   ficha_produccion_idficha_produccion_seq    SEQUENCE     ?   CREATE SEQUENCE public.ficha_produccion_idficha_produccion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.ficha_produccion_idficha_produccion_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050245    insumo    TABLE     ?  CREATE TABLE public.insumo (
    idinsumo integer DEFAULT nextval(('insumo_idinsumo_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    costo real NOT NULL,
    stock integer NOT NULL,
    stock_minimo integer NOT NULL,
    stock_maximo integer NOT NULL,
    fecha_vencimiento date NOT NULL,
    fkidunidad_medida integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.insumo;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050243    insumo_idinsumo_seq    SEQUENCE     |   CREATE SEQUENCE public.insumo_idinsumo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.insumo_idinsumo_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050251    inventario_inicial    TABLE     ?  CREATE TABLE public.inventario_inicial (
    idinventario_inicial integer DEFAULT nextval(('inventario_inicial_idinventario_inicial_seq'::text)::regclass) NOT NULL,
    fecha timestamp without time zone NOT NULL,
    fkidsucursal integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 &   DROP TABLE public.inventario_inicial;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050249 +   inventario_inicial_idinventario_inicial_seq    SEQUENCE     ?   CREATE SEQUENCE public.inventario_inicial_idinventario_inicial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.inventario_inicial_idinventario_inicial_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050257    inventario_producto    TABLE     ?  CREATE TABLE public.inventario_producto (
    idinventario_producto integer DEFAULT nextval(('inventario_producto_idinventario_producto_seq'::text)::regclass) NOT NULL,
    stock integer NOT NULL,
    stock_minimo integer NOT NULL,
    stock_maximo integer NOT NULL,
    fkidproducto integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 '   DROP TABLE public.inventario_producto;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050255 -   inventario_producto_idinventario_producto_seq    SEQUENCE     ?   CREATE SEQUENCE public.inventario_producto_idinventario_producto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE public.inventario_producto_idinventario_producto_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050603 
   migrations    TABLE     ?   CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);
    DROP TABLE public.migrations;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050601    migrations_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public          eypzbnbznnepmq    false    253            ?           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public          eypzbnbznnepmq    false    252                       1259    7050678    model_has_permissions    TABLE     ?   CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);
 )   DROP TABLE public.model_has_permissions;
       public         heap    eypzbnbznnepmq    false                       1259    7050689    model_has_roles    TABLE     ?   CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);
 #   DROP TABLE public.model_has_roles;
       public         heap    eypzbnbznnepmq    false            
           1259    8567607    numero_orden_seq    SEQUENCE     ~   CREATE SEQUENCE public.numero_orden_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.numero_orden_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050263    orden_entrada    TABLE     *  CREATE TABLE public.orden_entrada (
    idorden_entrada integer DEFAULT nextval(('orden_entrada_idorden_entrada_seq'::text)::regclass) NOT NULL,
    numero_orden integer DEFAULT nextval(('numero_orden_seq'::text)::regclass) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    nota character varying(200) NOT NULL,
    fkidsucursal integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    estado bit(1) DEFAULT '0'::"bit" NOT NULL
);
 !   DROP TABLE public.orden_entrada;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050261 !   orden_entrada_idorden_entrada_seq    SEQUENCE     ?   CREATE SEQUENCE public.orden_entrada_idorden_entrada_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.orden_entrada_idorden_entrada_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050269    orden_salida    TABLE     ?  CREATE TABLE public.orden_salida (
    idorden_salida integer DEFAULT nextval(('orden_salida_idorden_salida_seq'::text)::regclass) NOT NULL,
    numero_orden integer NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    nota character varying(200),
    fkidsucursal integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    estado bit(1) DEFAULT '1'::"bit"
);
     DROP TABLE public.orden_salida;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050267    orden_salida_idorden_salida_seq    SEQUENCE     ?   CREATE SEQUENCE public.orden_salida_idorden_salida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.orden_salida_idorden_salida_seq;
       public          eypzbnbznnepmq    false                        1259    7050637    password_resets    TABLE     ?   CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);
 #   DROP TABLE public.password_resets;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050275    pedido    TABLE     5  CREATE TABLE public.pedido (
    idpedido integer DEFAULT nextval(('pedido_idpedido_seq'::text)::regclass) NOT NULL,
    fecha date,
    hora time without time zone,
    coordenada character varying(100) NOT NULL,
    observacion character varying(100),
    direccion character varying(100) NOT NULL,
    estado character varying(10),
    referencia character varying(200) NOT NULL,
    fkidtipo_entrega integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.pedido;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050273    pedido_idpedido_seq    SEQUENCE     |   CREATE SEQUENCE public.pedido_idpedido_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.pedido_idpedido_seq;
       public          eypzbnbznnepmq    false                       1259    7050658    permissions    TABLE     #  CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.permissions;
       public         heap    eypzbnbznnepmq    false                       1259    7050656    permissions_id_seq    SEQUENCE     {   CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.permissions_id_seq;
       public          eypzbnbznnepmq    false    260            ?           0    0    permissions_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;
          public          eypzbnbznnepmq    false    259            ?            1259    7050284    personal    TABLE     0  CREATE TABLE public.personal (
    idpersonal integer DEFAULT nextval(('personal_idpersonal_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    ci character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    telefono_celular character varying(50) NOT NULL,
    direccion character varying(50) NOT NULL,
    fkidtipo_personal integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    fkidsucursal integer
);
    DROP TABLE public.personal;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050282    personal_idpersonal_seq    SEQUENCE     ?   CREATE SEQUENCE public.personal_idpersonal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.personal_idpersonal_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050288    produccion_personal    TABLE     7  CREATE TABLE public.produccion_personal (
    fkidficha_produccion integer NOT NULL,
    fkidpersonal integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 '   DROP TABLE public.produccion_personal;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050293    producto    TABLE     ?  CREATE TABLE public.producto (
    idproducto integer DEFAULT nextval(('producto_idproducto_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(50) NOT NULL,
    precio numeric(10,2) NOT NULL,
    foto character varying(200),
    fkidcategoria integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.producto;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050291    producto_idproducto_seq    SEQUENCE     ?   CREATE SEQUENCE public.producto_idproducto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.producto_idproducto_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050299 	   proveedor    TABLE       CREATE TABLE public.proveedor (
    idproveedor integer DEFAULT nextval(('proveedor_idproveedor_seq'::text)::regclass) NOT NULL,
    empresa character varying(50) NOT NULL,
    ci_nit character varying(50) NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    telefono_celular character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.proveedor;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050297    proveedor_idproveedor_seq    SEQUENCE     ?   CREATE SEQUENCE public.proveedor_idproveedor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.proveedor_idproveedor_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050305    receta    TABLE       CREATE TABLE public.receta (
    idreceta integer DEFAULT nextval(('receta_idreceta_seq'::text)::regclass) NOT NULL,
    costo_produccion integer NOT NULL,
    tiempo_produccion timestamp without time zone NOT NULL,
    fkidproducto integer NOT NULL,
    total_masa integer NOT NULL,
    peso integer NOT NULL,
    bollos numeric(10,2) NOT NULL,
    cantidad_producto numeric(10,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.receta;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050303    receta_idreceta_seq    SEQUENCE     |   CREATE SEQUENCE public.receta_idreceta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.receta_idreceta_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050309    receta_insumo    TABLE     6  CREATE TABLE public.receta_insumo (
    fkidreceta integer NOT NULL,
    fkidinsumo integer NOT NULL,
    cantidad integer NOT NULL,
    costo numeric(10,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 !   DROP TABLE public.receta_insumo;
       public         heap    eypzbnbznnepmq    false            	           1259    7050700    role_has_permissions    TABLE     ?   CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL,
    visible boolean DEFAULT false NOT NULL
);
 (   DROP TABLE public.role_has_permissions;
       public         heap    eypzbnbznnepmq    false                       1259    7050669    roles    TABLE       CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.roles;
       public         heap    eypzbnbznnepmq    false                       1259    7050667    roles_id_seq    SEQUENCE     u   CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          eypzbnbznnepmq    false    262            ?           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          eypzbnbznnepmq    false    261            ?            1259    7050314    sucursal    TABLE     ?  CREATE TABLE public.sucursal (
    idsucursal integer DEFAULT nextval(('sucursal_idsucursal_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    direccion character varying(100) NOT NULL,
    telefono character varying(10) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.sucursal;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050312    sucursal_idsucursal_seq    SEQUENCE     ?   CREATE SEQUENCE public.sucursal_idsucursal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.sucursal_idsucursal_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050320    sucursal_producto    TABLE     ?  CREATE TABLE public.sucursal_producto (
    idsucursal_producto integer DEFAULT nextval(('sucursal_producto_idsucursal_producto_seq'::text)::regclass) NOT NULL,
    stock integer NOT NULL,
    stock_minimo integer NOT NULL,
    stock_maximo integer NOT NULL,
    fkidsucursal integer NOT NULL,
    fkidproducto integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 %   DROP TABLE public.sucursal_producto;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050318 )   sucursal_producto_idsucursal_producto_seq    SEQUENCE     ?   CREATE SEQUENCE public.sucursal_producto_idsucursal_producto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public.sucursal_producto_idsucursal_producto_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050326    tipo_entrega    TABLE     G  CREATE TABLE public.tipo_entrega (
    idtipo_entrega integer DEFAULT nextval(('tipo_entrega_idtipo_entrega_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
     DROP TABLE public.tipo_entrega;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050324    tipo_entrega_idtipo_entrega_seq    SEQUENCE     ?   CREATE SEQUENCE public.tipo_entrega_idtipo_entrega_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.tipo_entrega_idtipo_entrega_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050332    tipo_personal    TABLE     K  CREATE TABLE public.tipo_personal (
    idtipo_personal integer DEFAULT nextval(('tipo_personal_idtipo_personal_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 !   DROP TABLE public.tipo_personal;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050330 !   tipo_personal_idtipo_personal_seq    SEQUENCE     ?   CREATE SEQUENCE public.tipo_personal_idtipo_personal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.tipo_personal_idtipo_personal_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050338    unidad_medida    TABLE     {  CREATE TABLE public.unidad_medida (
    idunidad_medida integer DEFAULT nextval(('unidad_medida_idunidad_medida_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    abreviatura character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 !   DROP TABLE public.unidad_medida;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050336 !   unidad_medida_idunidad_medida_seq    SEQUENCE     ?   CREATE SEQUENCE public.unidad_medida_idunidad_medida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.unidad_medida_idunidad_medida_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050611    users    TABLE     ?  CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    fkidusuario bigint NOT NULL
);
    DROP TABLE public.users;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050609    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          eypzbnbznnepmq    false    255            ?           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          eypzbnbznnepmq    false    254            ?            1259    7050344    usuario    TABLE     ?  CREATE TABLE public.usuario (
    idusuario integer DEFAULT nextval(('usuario_idusuario_seq'::text)::regclass) NOT NULL,
    email character varying(50) NOT NULL,
    password character varying(200) NOT NULL,
    fkidcliente integer,
    fkidpersonal integer,
    token character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.usuario;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050342    usuario_idusuario_seq    SEQUENCE     ~   CREATE SEQUENCE public.usuario_idusuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.usuario_idusuario_seq;
       public          eypzbnbznnepmq    false            ?            1259    7050353    venta    TABLE     ?  CREATE TABLE public.venta (
    idventa integer DEFAULT nextval(('venta_idventa_seq'::text)::regclass) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    total numeric(10,2) NOT NULL,
    fkidcliente integer,
    fkidusuario integer,
    fkidpedido integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    fkidsucursal integer NOT NULL
);
    DROP TABLE public.venta;
       public         heap    eypzbnbznnepmq    false            ?            1259    7050351    venta_idventa_seq    SEQUENCE     z   CREATE SEQUENCE public.venta_idventa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.venta_idventa_seq;
       public          eypzbnbznnepmq    false            l           2604    9097728 %   asignacion_pedido idasignacion_pedido    DEFAULT     ?   ALTER TABLE ONLY public.asignacion_pedido ALTER COLUMN idasignacion_pedido SET DEFAULT nextval('public.asignacion_pedido_idasignacion_pedido_seq'::regclass);
 T   ALTER TABLE public.asignacion_pedido ALTER COLUMN idasignacion_pedido DROP DEFAULT;
       public          eypzbnbznnepmq    false    267    268    268            g           2604    7050649    failed_jobs id    DEFAULT     p   ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);
 =   ALTER TABLE public.failed_jobs ALTER COLUMN id DROP DEFAULT;
       public          eypzbnbznnepmq    false    257    258    258            e           2604    7050606    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public          eypzbnbznnepmq    false    253    252    253            i           2604    7050661    permissions id    DEFAULT     p   ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);
 =   ALTER TABLE public.permissions ALTER COLUMN id DROP DEFAULT;
       public          eypzbnbznnepmq    false    259    260    260            j           2604    7050672    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          eypzbnbznnepmq    false    261    262    262            f           2604    7050614    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          eypzbnbznnepmq    false    254    255    255            ?          0    9097725    asignacion_pedido 
   TABLE DATA           ~   COPY public.asignacion_pedido (idasignacion_pedido, fkidpersonal, fkidpedido, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    268   _O      h          0    7050203 	   categoria 
   TABLE DATA           \   COPY public.categoria (idcategoria, nombre, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    203   ?O      j          0    7050209    cliente 
   TABLE DATA           ?   COPY public.cliente (idcliente, ci, nombre, apellido, telefono_celular, direccion, created_at, updated_at, deleted_at, token) FROM stdin;
    public          eypzbnbznnepmq    false    205   aP      l          0    7050215    compra 
   TABLE DATA           p   COPY public.compra (idcompra, fecha_hora, total, fkidproveedor, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    207   8Q      m          0    7050219    detalle_compra 
   TABLE DATA           ?   COPY public.detalle_compra (fkidinsumo, fkidcompra, cantidad, precio, created_at, updated_at, deleted_at, subtotal) FROM stdin;
    public          eypzbnbznnepmq    false    208   ?Q      n          0    7050222    detalle_entrada 
   TABLE DATA           ?   COPY public.detalle_entrada (fkidorden_entrada, fkidinventario_producto, cantidad, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    209   ?Q      o          0    7050225    detalle_inventario 
   TABLE DATA           ?   COPY public.detalle_inventario (fkidinventario_inicial, fkidsucursal_producto, cantidad, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    210   ?R      p          0    7050228    detalle_produccion 
   TABLE DATA           ?   COPY public.detalle_produccion (fkidficha_produccion, fkidproducto, cantidad, costo, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    211   \S      q          0    7050231    detalle_salida 
   TABLE DATA           ?   COPY public.detalle_salida (fkidorden_salida, fkidinventario_producto, cantidad, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    212   BT      r          0    7050234    detalle_venta 
   TABLE DATA           ?   COPY public.detalle_venta (fkidsucursal_producto, fkidventa, cantidad, precio, created_at, updated_at, deleted_at, subtotal) FROM stdin;
    public          eypzbnbznnepmq    false    213   U      ?          0    7050646    failed_jobs 
   TABLE DATA           [   COPY public.failed_jobs (id, connection, queue, payload, exception, failed_at) FROM stdin;
    public          eypzbnbznnepmq    false    258   ?U      t          0    7050239    ficha_produccion 
   TABLE DATA           ?   COPY public.ficha_produccion (idficha_produccion, fecha_hora, estado, created_at, updated_at, deleted_at, costo_total) FROM stdin;
    public          eypzbnbznnepmq    false    215   ?U      v          0    7050245    insumo 
   TABLE DATA           ?   COPY public.insumo (idinsumo, nombre, costo, stock, stock_minimo, stock_maximo, fecha_vencimiento, fkidunidad_medida, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    217   ?V      x          0    7050251    inventario_inicial 
   TABLE DATA           {   COPY public.inventario_inicial (idinventario_inicial, fecha, fkidsucursal, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    219   X      z          0    7050257    inventario_producto 
   TABLE DATA           ?   COPY public.inventario_producto (idinventario_producto, stock, stock_minimo, stock_maximo, fkidproducto, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    221   xX      ?          0    7050603 
   migrations 
   TABLE DATA           :   COPY public.migrations (id, migration, batch) FROM stdin;
    public          eypzbnbznnepmq    false    253   *Y      ?          0    7050678    model_has_permissions 
   TABLE DATA           T   COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
    public          eypzbnbznnepmq    false    263   ?Y      ?          0    7050689    model_has_roles 
   TABLE DATA           H   COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;
    public          eypzbnbznnepmq    false    264   ?Y      |          0    7050263    orden_entrada 
   TABLE DATA           ?   COPY public.orden_entrada (idorden_entrada, numero_orden, fecha_hora, nota, fkidsucursal, created_at, updated_at, deleted_at, estado) FROM stdin;
    public          eypzbnbznnepmq    false    223   Z      ~          0    7050269    orden_salida 
   TABLE DATA           ?   COPY public.orden_salida (idorden_salida, numero_orden, fecha_hora, nota, fkidsucursal, created_at, updated_at, deleted_at, estado) FROM stdin;
    public          eypzbnbznnepmq    false    225   $[      ?          0    7050637    password_resets 
   TABLE DATA           C   COPY public.password_resets (email, token, created_at) FROM stdin;
    public          eypzbnbznnepmq    false    256   D\      ?          0    7050275    pedido 
   TABLE DATA           ?   COPY public.pedido (idpedido, fecha, hora, coordenada, observacion, direccion, estado, referencia, fkidtipo_entrega, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    227   a\      ?          0    7050658    permissions 
   TABLE DATA           _   COPY public.permissions (id, name, guard_name, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    260   I]      ?          0    7050284    personal 
   TABLE DATA           ?   COPY public.personal (idpersonal, nombre, ci, apellido, telefono_celular, direccion, fkidtipo_personal, created_at, updated_at, deleted_at, fkidsucursal) FROM stdin;
    public          eypzbnbznnepmq    false    229   ?a      ?          0    7050288    produccion_personal 
   TABLE DATA           |   COPY public.produccion_personal (fkidficha_produccion, fkidpersonal, fecha, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    230   ?b      ?          0    7050293    producto 
   TABLE DATA           ?   COPY public.producto (idproducto, nombre, descripcion, precio, foto, fkidcategoria, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    232   c      ?          0    7050299 	   proveedor 
   TABLE DATA           ?   COPY public.proveedor (idproveedor, empresa, ci_nit, nombre, apellido, telefono_celular, email, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    234   ?f      ?          0    7050305    receta 
   TABLE DATA           ?   COPY public.receta (idreceta, costo_produccion, tiempo_produccion, fkidproducto, total_masa, peso, bollos, cantidad_producto, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    236   ?g      ?          0    7050309    receta_insumo 
   TABLE DATA           t   COPY public.receta_insumo (fkidreceta, fkidinsumo, cantidad, costo, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    237   Uh      ?          0    7050700    role_has_permissions 
   TABLE DATA           O   COPY public.role_has_permissions (permission_id, role_id, visible) FROM stdin;
    public          eypzbnbznnepmq    false    265   i      ?          0    7050669    roles 
   TABLE DATA           Y   COPY public.roles (id, name, guard_name, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    262   %j      ?          0    7050314    sucursal 
   TABLE DATA           o   COPY public.sucursal (idsucursal, nombre, direccion, telefono, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    239   ?j      ?          0    7050320    sucursal_producto 
   TABLE DATA           ?   COPY public.sucursal_producto (idsucursal_producto, stock, stock_minimo, stock_maximo, fkidsucursal, fkidproducto, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    241   Mk      ?          0    7050326    tipo_entrega 
   TABLE DATA           b   COPY public.tipo_entrega (idtipo_entrega, nombre, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    243   4l      ?          0    7050332    tipo_personal 
   TABLE DATA           d   COPY public.tipo_personal (idtipo_personal, nombre, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    245   zl      ?          0    7050338    unidad_medida 
   TABLE DATA           q   COPY public.unidad_medida (idunidad_medida, nombre, abreviatura, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    247   ?l      ?          0    7050611    users 
   TABLE DATA           ?   COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, deleted_at, fkidusuario) FROM stdin;
    public          eypzbnbznnepmq    false    255   ?m      ?          0    7050344    usuario 
   TABLE DATA           ?   COPY public.usuario (idusuario, email, password, fkidcliente, fkidpersonal, token, created_at, updated_at, deleted_at) FROM stdin;
    public          eypzbnbznnepmq    false    249   o      ?          0    7050353    venta 
   TABLE DATA           ?   COPY public.venta (idventa, fecha_hora, total, fkidcliente, fkidusuario, fkidpedido, created_at, updated_at, deleted_at, fkidsucursal) FROM stdin;
    public          eypzbnbznnepmq    false    251   }q      ?           0    0 )   asignacion_pedido_idasignacion_pedido_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.asignacion_pedido_idasignacion_pedido_seq', 1, true);
          public          eypzbnbznnepmq    false    267            ?           0    0    categoria_idcategoria_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.categoria_idcategoria_seq', 10, true);
          public          eypzbnbznnepmq    false    202            ?           0    0    cliente_idcliente_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.cliente_idcliente_seq', 3, true);
          public          eypzbnbznnepmq    false    204            ?           0    0    compra_idcompra_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.compra_idcompra_seq', 97, true);
          public          eypzbnbznnepmq    false    206            ?           0    0    failed_jobs_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);
          public          eypzbnbznnepmq    false    257            ?           0    0 '   ficha_produccion_idficha_produccion_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.ficha_produccion_idficha_produccion_seq', 11, true);
          public          eypzbnbznnepmq    false    214            ?           0    0    insumo_idinsumo_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.insumo_idinsumo_seq', 14, true);
          public          eypzbnbznnepmq    false    216            ?           0    0 +   inventario_inicial_idinventario_inicial_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.inventario_inicial_idinventario_inicial_seq', 12, true);
          public          eypzbnbznnepmq    false    218            ?           0    0 -   inventario_producto_idinventario_producto_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.inventario_producto_idinventario_producto_seq', 10, true);
          public          eypzbnbznnepmq    false    220            ?           0    0    migrations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.migrations_id_seq', 4, true);
          public          eypzbnbznnepmq    false    252            ?           0    0    numero_orden_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.numero_orden_seq', 1020, true);
          public          eypzbnbznnepmq    false    266            ?           0    0 !   orden_entrada_idorden_entrada_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.orden_entrada_idorden_entrada_seq', 22, true);
          public          eypzbnbznnepmq    false    222            ?           0    0    orden_salida_idorden_salida_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.orden_salida_idorden_salida_seq', 20, true);
          public          eypzbnbznnepmq    false    224            ?           0    0    pedido_idpedido_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.pedido_idpedido_seq', 9, true);
          public          eypzbnbznnepmq    false    226            ?           0    0    permissions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.permissions_id_seq', 112, true);
          public          eypzbnbznnepmq    false    259            ?           0    0    personal_idpersonal_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.personal_idpersonal_seq', 5, true);
          public          eypzbnbznnepmq    false    228            ?           0    0    producto_idproducto_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.producto_idproducto_seq', 43, true);
          public          eypzbnbznnepmq    false    231            ?           0    0    proveedor_idproveedor_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.proveedor_idproveedor_seq', 4, true);
          public          eypzbnbznnepmq    false    233            ?           0    0    receta_idreceta_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.receta_idreceta_seq', 14, true);
          public          eypzbnbznnepmq    false    235            ?           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 3, true);
          public          eypzbnbznnepmq    false    261            ?           0    0    sucursal_idsucursal_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.sucursal_idsucursal_seq', 3, true);
          public          eypzbnbznnepmq    false    238            ?           0    0 )   sucursal_producto_idsucursal_producto_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public.sucursal_producto_idsucursal_producto_seq', 11, true);
          public          eypzbnbznnepmq    false    240            ?           0    0    tipo_entrega_idtipo_entrega_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.tipo_entrega_idtipo_entrega_seq', 3, true);
          public          eypzbnbznnepmq    false    242            ?           0    0 !   tipo_personal_idtipo_personal_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.tipo_personal_idtipo_personal_seq', 1, false);
          public          eypzbnbznnepmq    false    244            ?           0    0 !   unidad_medida_idunidad_medida_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.unidad_medida_idunidad_medida_seq', 9, true);
          public          eypzbnbznnepmq    false    246            ?           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 9, true);
          public          eypzbnbznnepmq    false    254            ?           0    0    usuario_idusuario_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.usuario_idusuario_seq', 11, true);
          public          eypzbnbznnepmq    false    248            ?           0    0    venta_idventa_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.venta_idventa_seq', 30, true);
          public          eypzbnbznnepmq    false    250            ?           2606    9097730 (   asignacion_pedido asignacion_pedido_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.asignacion_pedido
    ADD CONSTRAINT asignacion_pedido_pkey PRIMARY KEY (idasignacion_pedido);
 R   ALTER TABLE ONLY public.asignacion_pedido DROP CONSTRAINT asignacion_pedido_pkey;
       public            eypzbnbznnepmq    false    268            ?           2606    7050655    failed_jobs failed_jobs_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.failed_jobs DROP CONSTRAINT failed_jobs_pkey;
       public            eypzbnbznnepmq    false    258            ?           2606    8567643 8   inventario_producto inventario_producto_fkidproducto_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.inventario_producto
    ADD CONSTRAINT inventario_producto_fkidproducto_key UNIQUE (fkidproducto);
 b   ALTER TABLE ONLY public.inventario_producto DROP CONSTRAINT inventario_producto_fkidproducto_key;
       public            eypzbnbznnepmq    false    221            ?           2606    7050608    migrations migrations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
       public            eypzbnbznnepmq    false    253            ?           2606    7050688 0   model_has_permissions model_has_permissions_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);
 Z   ALTER TABLE ONLY public.model_has_permissions DROP CONSTRAINT model_has_permissions_pkey;
       public            eypzbnbznnepmq    false    263    263    263            ?           2606    7050699 $   model_has_roles model_has_roles_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);
 N   ALTER TABLE ONLY public.model_has_roles DROP CONSTRAINT model_has_roles_pkey;
       public            eypzbnbznnepmq    false    264    264    264            ?           2606    8596503 ,   orden_entrada orden_entrada_numero_orden_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.orden_entrada
    ADD CONSTRAINT orden_entrada_numero_orden_key UNIQUE (numero_orden);
 V   ALTER TABLE ONLY public.orden_entrada DROP CONSTRAINT orden_entrada_numero_orden_key;
       public            eypzbnbznnepmq    false    223            ?           2606    7050666    permissions permissions_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.permissions DROP CONSTRAINT permissions_pkey;
       public            eypzbnbznnepmq    false    260            ?           2606    7050404 %   sucursal_producto pk_almacen_producto 
   CONSTRAINT     t   ALTER TABLE ONLY public.sucursal_producto
    ADD CONSTRAINT pk_almacen_producto PRIMARY KEY (idsucursal_producto);
 O   ALTER TABLE ONLY public.sucursal_producto DROP CONSTRAINT pk_almacen_producto;
       public            eypzbnbznnepmq    false    241            n           2606    7050358    categoria pk_categoria 
   CONSTRAINT     ]   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT pk_categoria PRIMARY KEY (idcategoria);
 @   ALTER TABLE ONLY public.categoria DROP CONSTRAINT pk_categoria;
       public            eypzbnbznnepmq    false    203            p           2606    7050360    cliente pk_cliente 
   CONSTRAINT     W   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT pk_cliente PRIMARY KEY (idcliente);
 <   ALTER TABLE ONLY public.cliente DROP CONSTRAINT pk_cliente;
       public            eypzbnbznnepmq    false    205            r           2606    7050362    compra pk_compra 
   CONSTRAINT     T   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT pk_compra PRIMARY KEY (idcompra);
 :   ALTER TABLE ONLY public.compra DROP CONSTRAINT pk_compra;
       public            eypzbnbznnepmq    false    207            t           2606    9662536     detalle_compra pk_detalle_compra 
   CONSTRAINT     r   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT pk_detalle_compra PRIMARY KEY (fkidinsumo, fkidcompra);
 J   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT pk_detalle_compra;
       public            eypzbnbznnepmq    false    208    208            v           2606    7050366 "   detalle_entrada pk_detalle_entrada 
   CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_entrada
    ADD CONSTRAINT pk_detalle_entrada PRIMARY KEY (fkidorden_entrada, fkidinventario_producto);
 L   ALTER TABLE ONLY public.detalle_entrada DROP CONSTRAINT pk_detalle_entrada;
       public            eypzbnbznnepmq    false    209    209            x           2606    7050368 (   detalle_inventario pk_detalle_inventario 
   CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_inventario
    ADD CONSTRAINT pk_detalle_inventario PRIMARY KEY (fkidinventario_inicial, fkidsucursal_producto);
 R   ALTER TABLE ONLY public.detalle_inventario DROP CONSTRAINT pk_detalle_inventario;
       public            eypzbnbznnepmq    false    210    210            z           2606    7050370 (   detalle_produccion pk_detalle_produccion 
   CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_produccion
    ADD CONSTRAINT pk_detalle_produccion PRIMARY KEY (fkidficha_produccion, fkidproducto);
 R   ALTER TABLE ONLY public.detalle_produccion DROP CONSTRAINT pk_detalle_produccion;
       public            eypzbnbznnepmq    false    211    211            |           2606    7050372     detalle_salida pk_detalle_salida 
   CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_salida
    ADD CONSTRAINT pk_detalle_salida PRIMARY KEY (fkidorden_salida, fkidinventario_producto);
 J   ALTER TABLE ONLY public.detalle_salida DROP CONSTRAINT pk_detalle_salida;
       public            eypzbnbznnepmq    false    212    212            ~           2606    7050374    detalle_venta pk_detalle_venta 
   CONSTRAINT     z   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT pk_detalle_venta PRIMARY KEY (fkidsucursal_producto, fkidventa);
 H   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT pk_detalle_venta;
       public            eypzbnbznnepmq    false    213    213            ?           2606    7050376 $   ficha_produccion pk_ficha_produccion 
   CONSTRAINT     r   ALTER TABLE ONLY public.ficha_produccion
    ADD CONSTRAINT pk_ficha_produccion PRIMARY KEY (idficha_produccion);
 N   ALTER TABLE ONLY public.ficha_produccion DROP CONSTRAINT pk_ficha_produccion;
       public            eypzbnbznnepmq    false    215            ?           2606    7050378    insumo pk_insumo 
   CONSTRAINT     T   ALTER TABLE ONLY public.insumo
    ADD CONSTRAINT pk_insumo PRIMARY KEY (idinsumo);
 :   ALTER TABLE ONLY public.insumo DROP CONSTRAINT pk_insumo;
       public            eypzbnbznnepmq    false    217            ?           2606    7050380 (   inventario_inicial pk_inventario_inicial 
   CONSTRAINT     x   ALTER TABLE ONLY public.inventario_inicial
    ADD CONSTRAINT pk_inventario_inicial PRIMARY KEY (idinventario_inicial);
 R   ALTER TABLE ONLY public.inventario_inicial DROP CONSTRAINT pk_inventario_inicial;
       public            eypzbnbznnepmq    false    219            ?           2606    7050382 *   inventario_producto pk_inventario_producto 
   CONSTRAINT     {   ALTER TABLE ONLY public.inventario_producto
    ADD CONSTRAINT pk_inventario_producto PRIMARY KEY (idinventario_producto);
 T   ALTER TABLE ONLY public.inventario_producto DROP CONSTRAINT pk_inventario_producto;
       public            eypzbnbznnepmq    false    221            ?           2606    7050384    orden_entrada pk_orden_entrada 
   CONSTRAINT     i   ALTER TABLE ONLY public.orden_entrada
    ADD CONSTRAINT pk_orden_entrada PRIMARY KEY (idorden_entrada);
 H   ALTER TABLE ONLY public.orden_entrada DROP CONSTRAINT pk_orden_entrada;
       public            eypzbnbznnepmq    false    223            ?           2606    7050386    orden_salida pk_orden_salida 
   CONSTRAINT     f   ALTER TABLE ONLY public.orden_salida
    ADD CONSTRAINT pk_orden_salida PRIMARY KEY (idorden_salida);
 F   ALTER TABLE ONLY public.orden_salida DROP CONSTRAINT pk_orden_salida;
       public            eypzbnbznnepmq    false    225            ?           2606    7050388    pedido pk_pedido 
   CONSTRAINT     T   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pk_pedido PRIMARY KEY (idpedido);
 :   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pk_pedido;
       public            eypzbnbznnepmq    false    227            ?           2606    7050390    personal pk_personal 
   CONSTRAINT     Z   ALTER TABLE ONLY public.personal
    ADD CONSTRAINT pk_personal PRIMARY KEY (idpersonal);
 >   ALTER TABLE ONLY public.personal DROP CONSTRAINT pk_personal;
       public            eypzbnbznnepmq    false    229            ?           2606    7050392 *   produccion_personal pk_produccion_personal 
   CONSTRAINT     ?   ALTER TABLE ONLY public.produccion_personal
    ADD CONSTRAINT pk_produccion_personal PRIMARY KEY (fkidficha_produccion, fkidpersonal);
 T   ALTER TABLE ONLY public.produccion_personal DROP CONSTRAINT pk_produccion_personal;
       public            eypzbnbznnepmq    false    230    230            ?           2606    7050394    producto pk_producto 
   CONSTRAINT     Z   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT pk_producto PRIMARY KEY (idproducto);
 >   ALTER TABLE ONLY public.producto DROP CONSTRAINT pk_producto;
       public            eypzbnbznnepmq    false    232            ?           2606    7050396    proveedor pk_proveedor 
   CONSTRAINT     ]   ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT pk_proveedor PRIMARY KEY (idproveedor);
 @   ALTER TABLE ONLY public.proveedor DROP CONSTRAINT pk_proveedor;
       public            eypzbnbznnepmq    false    234            ?           2606    7050398    receta pk_receta 
   CONSTRAINT     T   ALTER TABLE ONLY public.receta
    ADD CONSTRAINT pk_receta PRIMARY KEY (idreceta);
 :   ALTER TABLE ONLY public.receta DROP CONSTRAINT pk_receta;
       public            eypzbnbznnepmq    false    236            ?           2606    7050400    receta_insumo pk_receta_insumo 
   CONSTRAINT     p   ALTER TABLE ONLY public.receta_insumo
    ADD CONSTRAINT pk_receta_insumo PRIMARY KEY (fkidreceta, fkidinsumo);
 H   ALTER TABLE ONLY public.receta_insumo DROP CONSTRAINT pk_receta_insumo;
       public            eypzbnbznnepmq    false    237    237            ?           2606    7050402    sucursal pk_sucursal 
   CONSTRAINT     Z   ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT pk_sucursal PRIMARY KEY (idsucursal);
 >   ALTER TABLE ONLY public.sucursal DROP CONSTRAINT pk_sucursal;
       public            eypzbnbznnepmq    false    239            ?           2606    7050406    tipo_entrega pk_tipo_entrega 
   CONSTRAINT     f   ALTER TABLE ONLY public.tipo_entrega
    ADD CONSTRAINT pk_tipo_entrega PRIMARY KEY (idtipo_entrega);
 F   ALTER TABLE ONLY public.tipo_entrega DROP CONSTRAINT pk_tipo_entrega;
       public            eypzbnbznnepmq    false    243            ?           2606    7050408    tipo_personal pk_tipo_personal 
   CONSTRAINT     i   ALTER TABLE ONLY public.tipo_personal
    ADD CONSTRAINT pk_tipo_personal PRIMARY KEY (idtipo_personal);
 H   ALTER TABLE ONLY public.tipo_personal DROP CONSTRAINT pk_tipo_personal;
       public            eypzbnbznnepmq    false    245            ?           2606    7050410    unidad_medida pk_unidad_medida 
   CONSTRAINT     i   ALTER TABLE ONLY public.unidad_medida
    ADD CONSTRAINT pk_unidad_medida PRIMARY KEY (idunidad_medida);
 H   ALTER TABLE ONLY public.unidad_medida DROP CONSTRAINT pk_unidad_medida;
       public            eypzbnbznnepmq    false    247            ?           2606    7050412    usuario pk_usuario 
   CONSTRAINT     W   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (idusuario);
 <   ALTER TABLE ONLY public.usuario DROP CONSTRAINT pk_usuario;
       public            eypzbnbznnepmq    false    249            ?           2606    7050414    venta pk_venta 
   CONSTRAINT     Q   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT pk_venta PRIMARY KEY (idventa);
 8   ALTER TABLE ONLY public.venta DROP CONSTRAINT pk_venta;
       public            eypzbnbznnepmq    false    251            ?           2606    7050719 .   role_has_permissions role_has_permissions_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);
 X   ALTER TABLE ONLY public.role_has_permissions DROP CONSTRAINT role_has_permissions_pkey;
       public            eypzbnbznnepmq    false    265    265            ?           2606    7050677    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            eypzbnbznnepmq    false    262            ?           2606    7050631    users users_email_unique 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_unique;
       public            eypzbnbznnepmq    false    255            ?           2606    7050619    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            eypzbnbznnepmq    false    255            ?           1259    7050681 /   model_has_permissions_model_id_model_type_index    INDEX     ?   CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);
 C   DROP INDEX public.model_has_permissions_model_id_model_type_index;
       public            eypzbnbznnepmq    false    263    263            ?           1259    7050692 )   model_has_roles_model_id_model_type_index    INDEX     u   CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);
 =   DROP INDEX public.model_has_roles_model_id_model_type_index;
       public            eypzbnbznnepmq    false    264    264            ?           1259    7050643    password_resets_email_index    INDEX     X   CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);
 /   DROP INDEX public.password_resets_email_index;
       public            eypzbnbznnepmq    false    256            ?           2606    9097736 3   asignacion_pedido asignacion_pedido_fkidpedido_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.asignacion_pedido
    ADD CONSTRAINT asignacion_pedido_fkidpedido_fkey FOREIGN KEY (fkidpedido) REFERENCES public.pedido(idpedido);
 ]   ALTER TABLE ONLY public.asignacion_pedido DROP CONSTRAINT asignacion_pedido_fkidpedido_fkey;
       public          eypzbnbznnepmq    false    227    3984    268            ?           2606    9097731 5   asignacion_pedido asignacion_pedido_fkidpersonal_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.asignacion_pedido
    ADD CONSTRAINT asignacion_pedido_fkidpersonal_fkey FOREIGN KEY (fkidpersonal) REFERENCES public.personal(idpersonal);
 _   ALTER TABLE ONLY public.asignacion_pedido DROP CONSTRAINT asignacion_pedido_fkidpersonal_fkey;
       public          eypzbnbznnepmq    false    229    3986    268            ?           2606    7050515 .   sucursal_producto fk_almacen_producto_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.sucursal_producto
    ADD CONSTRAINT fk_almacen_producto_producto FOREIGN KEY (fkidproducto) REFERENCES public.producto(idproducto);
 X   ALTER TABLE ONLY public.sucursal_producto DROP CONSTRAINT fk_almacen_producto_producto;
       public          eypzbnbznnepmq    false    241    3990    232            ?           2606    7050520 .   sucursal_producto fk_almacen_producto_sucursal    FK CONSTRAINT     ?   ALTER TABLE ONLY public.sucursal_producto
    ADD CONSTRAINT fk_almacen_producto_sucursal FOREIGN KEY (fkidsucursal) REFERENCES public.sucursal(idsucursal);
 X   ALTER TABLE ONLY public.sucursal_producto DROP CONSTRAINT fk_almacen_producto_sucursal;
       public          eypzbnbznnepmq    false    3998    239    241            ?           2606    7050415    compra fk_compra_proveedor    FK CONSTRAINT     ?   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_compra_proveedor FOREIGN KEY (fkidproveedor) REFERENCES public.proveedor(idproveedor);
 D   ALTER TABLE ONLY public.compra DROP CONSTRAINT fk_compra_proveedor;
       public          eypzbnbznnepmq    false    234    207    3992            ?           2606    7050420 '   detalle_compra fk_detalle_compra_compra    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_detalle_compra_compra FOREIGN KEY (fkidcompra) REFERENCES public.compra(idcompra);
 Q   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT fk_detalle_compra_compra;
       public          eypzbnbznnepmq    false    207    208    3954            ?           2606    7050425 '   detalle_compra fk_detalle_compra_insumo    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_detalle_compra_insumo FOREIGN KEY (fkidinsumo) REFERENCES public.insumo(idinsumo);
 Q   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT fk_detalle_compra_insumo;
       public          eypzbnbznnepmq    false    208    217    3970            ?           2606    7050430 6   detalle_entrada fk_detalle_entrada_inventario_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_entrada
    ADD CONSTRAINT fk_detalle_entrada_inventario_producto FOREIGN KEY (fkidinventario_producto) REFERENCES public.inventario_producto(idinventario_producto);
 `   ALTER TABLE ONLY public.detalle_entrada DROP CONSTRAINT fk_detalle_entrada_inventario_producto;
       public          eypzbnbznnepmq    false    221    3976    209            ?           2606    7050435 0   detalle_entrada fk_detalle_entrada_orden_entrada    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_entrada
    ADD CONSTRAINT fk_detalle_entrada_orden_entrada FOREIGN KEY (fkidorden_entrada) REFERENCES public.orden_entrada(idorden_entrada);
 Z   ALTER TABLE ONLY public.detalle_entrada DROP CONSTRAINT fk_detalle_entrada_orden_entrada;
       public          eypzbnbznnepmq    false    3980    209    223            ?           2606    7050440 ;   detalle_inventario fk_detalle_inventario_inventario_inicial    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_inventario
    ADD CONSTRAINT fk_detalle_inventario_inventario_inicial FOREIGN KEY (fkidinventario_inicial) REFERENCES public.inventario_inicial(idinventario_inicial);
 e   ALTER TABLE ONLY public.detalle_inventario DROP CONSTRAINT fk_detalle_inventario_inventario_inicial;
       public          eypzbnbznnepmq    false    210    3972    219            ?           2606    7050445 :   detalle_inventario fk_detalle_inventario_sucursal_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_inventario
    ADD CONSTRAINT fk_detalle_inventario_sucursal_producto FOREIGN KEY (fkidsucursal_producto) REFERENCES public.sucursal_producto(idsucursal_producto);
 d   ALTER TABLE ONLY public.detalle_inventario DROP CONSTRAINT fk_detalle_inventario_sucursal_producto;
       public          eypzbnbznnepmq    false    210    4000    241            ?           2606    7050450 9   detalle_produccion fk_detalle_produccion_ficha_produccion    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_produccion
    ADD CONSTRAINT fk_detalle_produccion_ficha_produccion FOREIGN KEY (fkidficha_produccion) REFERENCES public.ficha_produccion(idficha_produccion);
 c   ALTER TABLE ONLY public.detalle_produccion DROP CONSTRAINT fk_detalle_produccion_ficha_produccion;
       public          eypzbnbznnepmq    false    3968    215    211            ?           2606    7050455 1   detalle_produccion fk_detalle_produccion_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_produccion
    ADD CONSTRAINT fk_detalle_produccion_producto FOREIGN KEY (fkidproducto) REFERENCES public.producto(idproducto);
 [   ALTER TABLE ONLY public.detalle_produccion DROP CONSTRAINT fk_detalle_produccion_producto;
       public          eypzbnbznnepmq    false    211    3990    232            ?           2606    7050460 4   detalle_salida fk_detalle_salida_inventario_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_salida
    ADD CONSTRAINT fk_detalle_salida_inventario_producto FOREIGN KEY (fkidinventario_producto) REFERENCES public.inventario_producto(idinventario_producto);
 ^   ALTER TABLE ONLY public.detalle_salida DROP CONSTRAINT fk_detalle_salida_inventario_producto;
       public          eypzbnbznnepmq    false    3976    212    221            ?           2606    7050465 -   detalle_salida fk_detalle_salida_orden_salida    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_salida
    ADD CONSTRAINT fk_detalle_salida_orden_salida FOREIGN KEY (fkidorden_salida) REFERENCES public.orden_salida(idorden_salida);
 W   ALTER TABLE ONLY public.detalle_salida DROP CONSTRAINT fk_detalle_salida_orden_salida;
       public          eypzbnbznnepmq    false    3982    225    212            ?           2606    8700123 0   detalle_venta fk_detalle_venta_sucursal_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_detalle_venta_sucursal_producto FOREIGN KEY (fkidsucursal_producto) REFERENCES public.sucursal_producto(idsucursal_producto) NOT VALID;
 Z   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT fk_detalle_venta_sucursal_producto;
       public          eypzbnbznnepmq    false    213    4000    241            ?           2606    7050475 $   detalle_venta fk_detalle_venta_venta    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_detalle_venta_venta FOREIGN KEY (fkidventa) REFERENCES public.venta(idventa);
 N   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT fk_detalle_venta_venta;
       public          eypzbnbznnepmq    false    213    251    4010            ?           2606    7050480    insumo fk_insumo_unidad_medida    FK CONSTRAINT     ?   ALTER TABLE ONLY public.insumo
    ADD CONSTRAINT fk_insumo_unidad_medida FOREIGN KEY (fkidunidad_medida) REFERENCES public.unidad_medida(idunidad_medida);
 H   ALTER TABLE ONLY public.insumo DROP CONSTRAINT fk_insumo_unidad_medida;
       public          eypzbnbznnepmq    false    4006    247    217            ?           2606    7050485 1   inventario_inicial fk_inventario_inicial_sucursal    FK CONSTRAINT     ?   ALTER TABLE ONLY public.inventario_inicial
    ADD CONSTRAINT fk_inventario_inicial_sucursal FOREIGN KEY (fkidsucursal) REFERENCES public.sucursal(idsucursal);
 [   ALTER TABLE ONLY public.inventario_inicial DROP CONSTRAINT fk_inventario_inicial_sucursal;
       public          eypzbnbznnepmq    false    3998    219    239            ?           2606    7050490 3   inventario_producto fk_inventario_producto_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.inventario_producto
    ADD CONSTRAINT fk_inventario_producto_producto FOREIGN KEY (fkidproducto) REFERENCES public.producto(idproducto);
 ]   ALTER TABLE ONLY public.inventario_producto DROP CONSTRAINT fk_inventario_producto_producto;
       public          eypzbnbznnepmq    false    3990    232    221            ?           2606    7050495 %   orden_salida fk_orden_salida_sucursal    FK CONSTRAINT     ?   ALTER TABLE ONLY public.orden_salida
    ADD CONSTRAINT fk_orden_salida_sucursal FOREIGN KEY (fkidsucursal) REFERENCES public.sucursal(idsucursal);
 O   ALTER TABLE ONLY public.orden_salida DROP CONSTRAINT fk_orden_salida_sucursal;
       public          eypzbnbznnepmq    false    225    239    3998            ?           2606    7050500 "   personal fk_personal_tipo_personal    FK CONSTRAINT     ?   ALTER TABLE ONLY public.personal
    ADD CONSTRAINT fk_personal_tipo_personal FOREIGN KEY (fkidtipo_personal) REFERENCES public.tipo_personal(idtipo_personal);
 L   ALTER TABLE ONLY public.personal DROP CONSTRAINT fk_personal_tipo_personal;
       public          eypzbnbznnepmq    false    4004    245    229            ?           2606    7050505    producto fk_producto_categoria    FK CONSTRAINT     ?   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (fkidcategoria) REFERENCES public.categoria(idcategoria);
 H   ALTER TABLE ONLY public.producto DROP CONSTRAINT fk_producto_categoria;
       public          eypzbnbznnepmq    false    3950    232    203            ?           2606    7050510 %   receta_insumo fk_receta_insumo_insumo    FK CONSTRAINT     ?   ALTER TABLE ONLY public.receta_insumo
    ADD CONSTRAINT fk_receta_insumo_insumo FOREIGN KEY (fkidinsumo) REFERENCES public.insumo(idinsumo);
 O   ALTER TABLE ONLY public.receta_insumo DROP CONSTRAINT fk_receta_insumo_insumo;
       public          eypzbnbznnepmq    false    3970    217    237            ?           2606    7050525    usuario fk_usuario_cliente    FK CONSTRAINT     ?   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_cliente FOREIGN KEY (fkidcliente) REFERENCES public.cliente(idcliente);
 D   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_usuario_cliente;
       public          eypzbnbznnepmq    false    3952    205    249            ?           2606    7050530    usuario fk_usuario_personal    FK CONSTRAINT     ?   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_personal FOREIGN KEY (fkidpersonal) REFERENCES public.personal(idpersonal);
 E   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_usuario_personal;
       public          eypzbnbznnepmq    false    249    3986    229            ?           2606    7050535    venta fk_venta_cliente    FK CONSTRAINT     ?   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (fkidcliente) REFERENCES public.cliente(idcliente);
 @   ALTER TABLE ONLY public.venta DROP CONSTRAINT fk_venta_cliente;
       public          eypzbnbznnepmq    false    251    3952    205            ?           2606    7050540    venta fk_venta_pedido    FK CONSTRAINT     ~   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_pedido FOREIGN KEY (fkidpedido) REFERENCES public.pedido(idpedido);
 ?   ALTER TABLE ONLY public.venta DROP CONSTRAINT fk_venta_pedido;
       public          eypzbnbznnepmq    false    251    3984    227            ?           2606    7050545    venta fk_venta_usuario    FK CONSTRAINT     ?   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_usuario FOREIGN KEY (fkidusuario) REFERENCES public.usuario(idusuario);
 @   ALTER TABLE ONLY public.venta DROP CONSTRAINT fk_venta_usuario;
       public          eypzbnbznnepmq    false    4008    251    249            ?           2606    7050682 A   model_has_permissions model_has_permissions_permission_id_foreign    FK CONSTRAINT     ?   ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;
 k   ALTER TABLE ONLY public.model_has_permissions DROP CONSTRAINT model_has_permissions_permission_id_foreign;
       public          eypzbnbznnepmq    false    4021    260    263            ?           2606    7050693 /   model_has_roles model_has_roles_role_id_foreign    FK CONSTRAINT     ?   ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.model_has_roles DROP CONSTRAINT model_has_roles_role_id_foreign;
       public          eypzbnbznnepmq    false    4023    262    264            ?           2606    8596504 -   orden_entrada orden_entrada_fkidsucursal_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.orden_entrada
    ADD CONSTRAINT orden_entrada_fkidsucursal_fkey FOREIGN KEY (fkidsucursal) REFERENCES public.sucursal(idsucursal) NOT VALID;
 W   ALTER TABLE ONLY public.orden_entrada DROP CONSTRAINT orden_entrada_fkidsucursal_fkey;
       public          eypzbnbznnepmq    false    3998    223    239            ?           2606    9012958 #   pedido pedido_fkidtipo_entrega_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_fkidtipo_entrega_fkey FOREIGN KEY (fkidtipo_entrega) REFERENCES public.tipo_entrega(idtipo_entrega) NOT VALID;
 M   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_fkidtipo_entrega_fkey;
       public          eypzbnbznnepmq    false    4002    227    243            ?           2606    7451651 #   personal personal_fkidsucursal_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_fkidsucursal_fkey FOREIGN KEY (fkidsucursal) REFERENCES public.sucursal(idsucursal) NOT VALID;
 M   ALTER TABLE ONLY public.personal DROP CONSTRAINT personal_fkidsucursal_fkey;
       public          eypzbnbznnepmq    false    239    229    3998            ?           2606    7050728    receta receta_fkidproducto_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.receta
    ADD CONSTRAINT receta_fkidproducto_fkey FOREIGN KEY (fkidproducto) REFERENCES public.producto(idproducto) NOT VALID;
 I   ALTER TABLE ONLY public.receta DROP CONSTRAINT receta_fkidproducto_fkey;
       public          eypzbnbznnepmq    false    3990    236    232            ?           2606    7050703 ?   role_has_permissions role_has_permissions_permission_id_foreign    FK CONSTRAINT     ?   ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.role_has_permissions DROP CONSTRAINT role_has_permissions_permission_id_foreign;
       public          eypzbnbznnepmq    false    265    260    4021            ?           2606    7050708 9   role_has_permissions role_has_permissions_role_id_foreign    FK CONSTRAINT     ?   ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.role_has_permissions DROP CONSTRAINT role_has_permissions_role_id_foreign;
       public          eypzbnbznnepmq    false    265    262    4023            ?           2606    7050623    users users_fkidusuario_foreign    FK CONSTRAINT     ?   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_fkidusuario_foreign FOREIGN KEY (fkidusuario) REFERENCES public.usuario(idusuario);
 I   ALTER TABLE ONLY public.users DROP CONSTRAINT users_fkidusuario_foreign;
       public          eypzbnbznnepmq    false    4008    249    255            ?           2606    8700216    venta venta_fkidsucursal_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_fkidsucursal_fkey FOREIGN KEY (fkidsucursal) REFERENCES public.sucursal(idsucursal) NOT VALID;
 G   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_fkidsucursal_fkey;
       public          eypzbnbznnepmq    false    3998    239    251            ?      x?3?4?4???? ?=... % t      h   ?   x?m?9?0 ??+?? _?p???L?$Vd??`???????hgǇ?+??J(QIQ????ښ?e??PpƔ???3??ڰ?D????2??c~???????r??g?ؾei5??g??Z??6FN????c>?4?Hl??:򘚖,#??C?'?U^??๪ɾac?@
8?⦘<҆?=??*+є?X#??YFz?+??|?}      j   ?   x?m??j?@???S???ޞ?O??0?@???X8???
?Oa'?`??+??m?|?????	?s??	Bl???3˄????ic̆w:?V??eI??????X`+?|iU??5?????_ew???8?`??r?Q+?/R??Z?<S?-|?I?Ms4C-xp'????Ԫ_eҳ??\q??6?ԑ_fW?????i?o??L      l   I   x??4?4202?54?5?T04?24?20?451?4B?1?24?24?*??ei?n??N-@d?UhL? Θ?      m   E   x?m??	?0Cѳ4L????Kt???G(????
???Ԥĺ?F????i?6??S+?[?h}????H>l?      n   ?   x??ѱ?0??M??dY?!2???#(?p???폾?	I''gRV^D???Qe4?m?dԶ?D??Sa??H???C??6?`K??!??{S?g?????|p?????q؂(Sl?8U;rئ??;MU? l)<?v???͖?S?
[??"+lI???%??V?lI??[?%????R?w?      o   ?   x?m???0C??0?I?D'??s?A/?\?>K??@????{??P-p칢?=?????w0?i`?E;X3??17???.?+(N???F?j?F?Z?-?T~???	?,?,?,?,c-C-?Ծg?????t?^4ь(?+?+?+?+?+???ס?C_?????I)=>,?4      p   ?   x?u???0E?N40?W?1?c<?0R???????@@???w{?W!0?+6  AD??yj????,<?*?8R?????+?CH&┑????xi?\l?cTU??)=e!ޝ??T?O??C5??6;?/8?С???M?7?Q?BT0??8e??|:}a??S-e!????DZ??w????P>?G?:??l	ָ?j??so???????      q   ?   x??ѱ? ??ZL?????!2???#`? ܫ????$)ԩ3)+?"'?!?????v??2*h?`"L?lU??xAvHu6?[???5d?i??IeA?v?]??@???$Fc?^???~Uئ+ȶ?6/????B4B???h!??B?j_?<?66g?Q??q?^? ??[al
l?ܯ???Ӟ?      r   ?   x?u??? ߦ?4?? E\鿎3??NG?5x??)I?
b?$$??n??u??????LB߬.?Mb??e.??.EX$O?"?[^{rK?v?P??Fx6?n}k?'???΁Z???e߀?<?.3U?lj۵??誴?hsٲ?d??y0?l?g!|??a?      ?      x?????? ? ?      t   ?   x?}?Mn?0FמS???7v???ME?+????? J0?????g??{➨C?z?t????i?????B~???ͅN+M=Z???.C???]?O?L8&V4? ??]?p??ׯ???sn?{+?c??DAԑa?_?.???V????&?Z??&???.???2???Y?e2شLn?*-??i3[l)*J6?S??n?>?VV??@?/Ӳ?7???fV?Z48F ?p???      v   4  x?m?An?0E??)? ??؃??u?M{?l,J$??$??????	?2??????{?S,?ӵ=??!?BZ????TV,@y??Ɨ$*A???*?%??Sa?5??ޚ8<?ޑ????h??+?t?h??T??d?????7?<????z?dM??X??Q63j?n?>?? ?{h???F???
?5??d;M??י-w???o?k#??`qe?7???U?$??J.G?I?ϭ???O@??	???=Q?k<?vҗ?|kҹ<M?Ьg:D?Emr`?T7?N?#?8?ӕ??????k????????????      x   `   x?????0??,Pd? H?`???- ?#R^g?K?P??}???/????vd?IX8nj????l8?&:l?+]?p?????ZB?m?9?5?2R      z   ?   x?m???0?o<EHu??????B?????8????? ?W?16/Q???+??K?t|????R?p?8FJ?zʽ???E?,?-Y'??????.R?[O٨?	??W82????}??l0.??&4d?vo?? -!??Zg?06?x?s?K)_?QE      ?   w   x?U??
?@??u?a$???wSa?:?????(??EV???F?[0??;?LcQ|\?Q?0i?A???ݿ?F???-9פ]P?!??4??G6?.\??a??[Ԟ?=??_?¯??x_:      ?      x?????? ? ?      ?   '   x?3?t,(??	-N-?4?2B??s#?,P?,?b???? A?      |     x???AN?0E??)| ?i??ޱ`	? ?	??fh;p.???H?U???D?????6?????(qG?C?9'V(n?ipO?v???JF??;!?S?i?????????`?4?a?E?'k?vpN??^?W??h??bT3ZRDW??,C?J<????+????????c????a???Xh???=gy???O?D?d?D=s???b?r??
Q??{?Ys6??\L?%Frj?P?m??_??&<??y	V3႕?[??Y????}?c8??g쯳,?]?       ~     x???MN?0F??)? ͌??̎K??4.J⒤p.??Ű?$?Hl,k???EHF12n?6H@Z4?Au??{?p??????"?=(???u-m??QaBY??? P&Xg????P98v'?l????x?ԔP??(????O?23s	?9?.????b???????G??R	???K:?E??
??-Փ?`o?}w?۹?<4?????????pT?y?W??i[?+?0f]????1??uZ???????A?Z?=??I?|-??      ?      x?????? ? ?      ?   ?   x??ұN?0?9}?H????q???]"???S???ǥ? wR?????VR??1O?YX? ???8j?Is1??Tx;?tY?/?9>`
?[\N?˱??vj?]?׀??`DA"P?\ź?|??~????ܗ;????^????g????{?~???+?n??]?j??? ?o_ ?(??g۶?????{{??W)P??>?m(?Ԅ??T?\?f?d??a? w~ͪ      ?   ?  x???Mn?HF??)?Կ$bN?@ (???vs??bQ?2do	?[|%=W???}???????.????<O??m?k3?ύ3???????8{??";???S????1]n?://?e???|???oY-;+???~߇??[X??
,r?a?݇???w?h?Y?%??1_e?eg??r<????Y?uͲ?N??\??Al vV0??~d?"?V??G͝Y?K??/(5rf%"?Dﾠ??{vV@A??Ű?ɐ?Y???!?|ı????1r??if??>????)???2?v?=?͛-dN??3?
??B,??do`?	??9?|???;D#?ys??@??.???
?
?7???6_?<???<]?b??T
?B?;A??%vV i??y??f??%O?WW{??u?>S???>}????b??<?0˧3???2?L??? Z~?<?0+  9;?t??C?x].?w>??y4=<?>9E?@?x ?(?d?&}:(Z??y8<??=(r??)5?R?\@L40??Zi???8????G=?fɔZ?-gQj?L?Jr???:Z?rZ)Hje?,ǹ?,??T???????&??B:(Z???zX????0P??N??m??????T??W??@ȱ2?Q?+7|04?4??X?\???T?JWD???#k?a?????}?s??I?u?Y5+??E?0vm?ܼ&A͔?j?ƴC?D?6??v??yZ?/???7/???V?2??Zk?D??F4?d??e???l?E˔:pDN??}-T?\????z?ި??߈???v^??oD?Mqhq:?W???1?0????9?C??*tD?N]?k???e???*q???zJ??e??6??R?f??*֭?4-r?T????Q?>??????f??IT??hwD?n?v^?jwD?n?????ѽ۴1?P??B????J?????2s?(^?1o?j?mϠ??f[??w?aiYS%????epZ?T?#*z?~?\??O'CV f??=??E???r'?r?=?o??ß?n?bq8?Fʒ??-K?n??>??f??r?s???*?9>??uY?,s?fCe???e?¦
?5r?zH?֤?4???}???R{Hh6?鸼???%+????`?j"@?^?%?:?y???J?!?<?l??"????l^a?(y2?:h??????Ά??      ?     x?m??j? ?ϓ??v?QG??Z(?Rz??R?˰?"\?h??6l)??G?oF??X??ek^?S?X??9֞????j?J>?t-@pzY??4?y;??g??Z??6?}g?9?,??1??xj?w?;??@?lf???S??j?\????Z??r?4??h????9?v?z?qW25?"???l??p?eHc?@?ڴo?\?3?v?????.?G??xPā9??̖i??????.s?*4????????K?YÚ?????? m?      ?      x?????? ? ?      ?   ?  x????r?0???)x?8????M:??iz?.?Q??&???3?[??bՑp,)5??|??_G????˹??׹,6y!?p#?b?7"@?Ś-y}?a?ɚ???l?"??2	?H??ĩ?]??(?a??p?C??/o??x?^??8CnMa?ƾ????<6C?YB??BE?P??GNM?c~'Y????i?ݚ"M4邕%oX8[??C?N???M5o^ܫ?9??͙d?!?d??1	??????????$?"???x??2?G??? ??U?3?[#?5??h?????l=??5 ??tcR?ԀI?s???H??Z$ޮ??ق???l??dn`?5?ibGG㧎Fpv:㒳??pFY???䕇?O??'?S>?PY4?n?}???>YGV???Ip+J?U}???|ɟ?U?I??d?ةƊ?y??w?)?o??j?x?T??kq?6???9Mv??|?e~?_B?E?a???YVk?,?g?^2??C?? ??k???????7????*?րL?????Ir|<?Kk ?π???h]?Z?Y??D?=$ț?ձ$CIk@?;????~H?? i֢K???ʥj??p`??9?M-o???Z?S+?J???7탋???????bՁ??pÈ\????Y/|?? ?:?????8͐Uf???A?yӈ?3?Ŀ?;H?N??v"?9????/??A?ψ^?ڦ??L???(???zp?urӝGP(?S;??Њ??zW???!??F^?ǻVO???3P???p?1???)?h?x? ^Q[?GRa":2?	4w??? =?gc?tC??_=V ؾڍ?L?@???????[?hH?2[1	s?7??@?GM??I|U-GZO"???(?m??fn??a?9???Xݙ?????C?1????????X1<;?Πրm???????????~C??!y}??yt?yw??h?+??c      ?   ?   x???M
?0???x
/?$?D?????Е?i+??O?U??W??B?n????4?M;h?F??\?<L4???ogH???i?????Y|mk@?,?,?$??Jc??m?1??y?F껡?C򞞎>???T?r?m?)aG??6po}Y??G?@ U"M?????U_???0???d?mA?8?3?Y      ?   ?   x?m??!???
XÀ?ql?u????L4?????????ٶH	2???.??ba????????܉??]eČ~!???
?"?Z[.<??N???D?▅M??<ւ?????to??Wbp????a5C?ւ_I?ǰփ?}??t????G?ǚ???R???FV      ?   ?   x???A
? E??^???Z?????X??Z(H??o???j?r?9P??d??? ???Nj4?zł??'^??8?L???Xr|?&???8?,??n?7?K6D?'?K6???Wb??? ????GlQʒu1??(ݴ?M-;-??R???v????]?      ?     x?5һQD1@??z??7l???8?.?F?>???kGt1?Klq?q??P?P?o??x/?e????2^.Q???J(??J(??J?tJ?tJ?tJ?tJ?tʠʠʠʠʠʤLʤLʤLʤLʤLʢ,ʢ,ʢ,ʢ,ʢ,ʦ?[?#Ǒ?H{???f???~sܼ??Y7??x?׮׮?꿰RX)?V
+O]??<uy???e??^Y???ʦlʦlʦlʦʡ??u???????(3ʌ2??(3ʌ2??(3ʌ?b??(6????????Ý?      ?   {   x?m?1? ??N????J?t[lkLlmX?????????????_??#Y??[BC?P3?Tmc'I??m??T?????A`Y(0??[Sm??ބ?T???΅??0׭֦ڊ3~??'!1?      ?   ?   x?m?A
?0??)?R?????y?v4????ooA?.g3?N?y??G.??ʜ?~m~a?s?{$<ѭ	~?ǘ???Zr#IR()ȂtO?7?n8p?=
h}I??N???1?Yg?Z??OT	??j{E????hh8?/D9?      ?   ?   x?m??? D??*? ]\*"??:"??Ml>@?ͮ???}A??1&n;u#??????1h?P?kk??T~5JH;?1?@	D/??(?e2*?C5^??6?? ?Eh;?y//??c?\????????;es?ܗ5gH????tH_l],?ls?O	?g?x??B?NV??Ýl???%?
?M?֧i?7֥u,?xҕ???җ#?xm??S?s?      ?   6   x?3?tTH???L???????? .#??ƜA?????E
?9
9?ɉ9?=... ???      ?   ,   x?3?tL????,.)JL?/???? .#N?܂?T? B,F??? ???      ?   ?   x?m?I?0E??? Uڜ*??*E?e??d???????Ƣ???%?fj??e?=P?t?{?s???Q7/????5.q??O?&G?????Ԯ??]'??ۊ?k?:?A?eEx.????E???"~??3
?Oyk???d?'ǰ???????<?6F?+???3[?a\?Gi?+K????Q?ۻA????t?_9fB??^F?K/??v4      ?   b  x?m??n?@?5<??????j?"??R?b?qt A???i??՜????1C????<1U$UCI?	??<e?s?/4}???7?n?????艪?<???O?HJ??z??cm*n??4Svd~G?k_ @0?Tt??2???*bf?_?^?K?_?S;wb҅ꊊ?????̟ęV??<{%?Rc?2A?|???&?$???zc`{??. ]??Y[?X?1(?HJJ文y????d%i?
?7K4????Q?8?
3?????q?TgW???E????_?zP?eY?Jg?V!`?7??w?I?/????h$m?[?)?"???/FC>???<,CӵYX???$5\[????CU????E???cY?????      ?   ]  x?Փɲ?@@??.?
?̰?<@??^?+@d??Dԯ???*??dӋ???N??jx̓	?(???2???з???c_?N??8?????m?MWd;6???????)t??}?+??&????i?J2ǽe?vO ????ͫ?ǦQՙ?K`<?𥑌d?2u??7?xR??4???d?:??G+??????+???]KZ?.?
y??I0zH?Fm?F*4????????nxl	_???q,?7?#7
?_m?Ψ?4??{?4Sn?,pϋM?qm???ъc2K?e<T<?????
3S?{G?!??8????????h?d?e?F"???&2$?;???p?3T??'R?W'??Hmu????bP?|??F????&by??߲G"?(p??*]?a????uPxR7:g??KFgo&?S???z"?󄱢t?}b??1|?m?2߲? ??8B?./??Մ˗?4o??l0
Z??DSz??ݸ?(q??ڽ??Ǒv??^????	???{?????i?[x?_??[Y???Mr?~eV1J???T*?.7N?c'Dk?2????vpm?>?ùx?2K?e?O?????C?      ?     x?m?ݱ? ?gSEX???[??_?E??&???3_J?????<	?2?ҳ@?T??oS(?lV??I??TZ???j? '???f?րT??W??F?p??1l3W[T?ڈmrK?}??HX??S?9?ˬR?AM_??E!κ2GGD??a?_??,?(X-?ue?"V?7Ff?????m????-
???G???>????ܥ???yL????Z??fK??3??\݀??X???Yѹ??Ek?m??;??????     