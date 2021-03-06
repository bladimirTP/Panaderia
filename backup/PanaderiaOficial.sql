PGDMP     (    	                x            bd_panaderia_oficial    12.3    12.3 ?    l           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            m           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            n           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            o           1262    19240    bd_panaderia_oficial    DATABASE     ?   CREATE DATABASE bd_panaderia_oficial WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
 $   DROP DATABASE bd_panaderia_oficial;
                postgres    false            ?            1259    19243 	   categoria    TABLE     2  CREATE TABLE public.categoria (
    idcategoria integer DEFAULT nextval(('categoria_idcategoria_seq'::text)::regclass) NOT NULL,
    nombre character varying(50),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.categoria;
       public         heap    postgres    false            ?            1259    19241    categoria_idcategoria_seq    SEQUENCE     ?   CREATE SEQUENCE public.categoria_idcategoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.categoria_idcategoria_seq;
       public          postgres    false            ?            1259    19249    cliente    TABLE     ?  CREATE TABLE public.cliente (
    idcliente integer DEFAULT nextval(('cliente_idcliente_seq'::text)::regclass) NOT NULL,
    ci character varying(50) NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    telefono_celular character varying(50) NOT NULL,
    direccion character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            ?            1259    19247    cliente_idcliente_seq    SEQUENCE     ~   CREATE SEQUENCE public.cliente_idcliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.cliente_idcliente_seq;
       public          postgres    false            ?            1259    19255    compra    TABLE     y  CREATE TABLE public.compra (
    idcompra integer DEFAULT nextval(('compra_idcompra_seq'::text)::regclass) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    total integer NOT NULL,
    fkidproveedor integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.compra;
       public         heap    postgres    false            ?            1259    19253    compra_idcompra_seq    SEQUENCE     |   CREATE SEQUENCE public.compra_idcompra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.compra_idcompra_seq;
       public          postgres    false            ?            1259    19259    detalle_compra    TABLE     /  CREATE TABLE public.detalle_compra (
    fkidinsumo integer NOT NULL,
    fkidcompra integer NOT NULL,
    cantidad integer NOT NULL,
    precio real NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 "   DROP TABLE public.detalle_compra;
       public         heap    postgres    false            ?            1259    19262    detalle_inventario    TABLE     '  CREATE TABLE public.detalle_inventario (
    fkidinventario_inicial integer NOT NULL,
    fkidproducto integer NOT NULL,
    cantidad integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 &   DROP TABLE public.detalle_inventario;
       public         heap    postgres    false            ?            1259    19265    detalle_produccion    TABLE     #  CREATE TABLE public.detalle_produccion (
    fkidficha_produccion integer NOT NULL,
    fkidinsumo integer NOT NULL,
    cantidad integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 &   DROP TABLE public.detalle_produccion;
       public         heap    postgres    false            ?            1259    19268    detalle_salida    TABLE     (  CREATE TABLE public.detalle_salida (
    fkidorden_salida integer NOT NULL,
    fkidinventario_producto integer NOT NULL,
    cantidad integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 "   DROP TABLE public.detalle_salida;
       public         heap    postgres    false            ?            1259    19271    detalle_venta    TABLE     /  CREATE TABLE public.detalle_venta (
    fkidproducto integer NOT NULL,
    fkidventa integer NOT NULL,
    cantidad integer NOT NULL,
    precio real NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 !   DROP TABLE public.detalle_venta;
       public         heap    postgres    false            ?            1259    19623    failed_jobs    TABLE     ?   CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.failed_jobs;
       public         heap    postgres    false            ?            1259    19621    failed_jobs_id_seq    SEQUENCE     {   CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.failed_jobs_id_seq;
       public          postgres    false    252            p           0    0    failed_jobs_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;
          public          postgres    false    251            ?            1259    19276    ficha_produccion    TABLE     ?  CREATE TABLE public.ficha_produccion (
    idficha_produccion integer DEFAULT nextval(('ficha_produccion_idficha_produccion_seq'::text)::regclass) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    cantidad integer NOT NULL,
    fkidproducto integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 $   DROP TABLE public.ficha_produccion;
       public         heap    postgres    false            ?            1259    19274 '   ficha_produccion_idficha_produccion_seq    SEQUENCE     ?   CREATE SEQUENCE public.ficha_produccion_idficha_produccion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.ficha_produccion_idficha_produccion_seq;
       public          postgres    false            ?            1259    19282    insumo    TABLE     ?  CREATE TABLE public.insumo (
    idinsumo integer DEFAULT nextval(('insumo_idinsumo_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    costo numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    stock_minimo integer NOT NULL,
    stock_maximo integer NOT NULL,
    fkidunidad_medida integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.insumo;
       public         heap    postgres    false            ?            1259    19280    insumo_idinsumo_seq    SEQUENCE     |   CREATE SEQUENCE public.insumo_idinsumo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.insumo_idinsumo_seq;
       public          postgres    false            ?            1259    19288    inventario_inicial    TABLE     ?  CREATE TABLE public.inventario_inicial (
    idinventario_inicial integer DEFAULT nextval(('inventario_inicial_idinventario_inicial_seq'::text)::regclass) NOT NULL,
    fecha timestamp without time zone NOT NULL,
    fkidsucursal integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 &   DROP TABLE public.inventario_inicial;
       public         heap    postgres    false            ?            1259    19286 +   inventario_inicial_idinventario_inicial_seq    SEQUENCE     ?   CREATE SEQUENCE public.inventario_inicial_idinventario_inicial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.inventario_inicial_idinventario_inicial_seq;
       public          postgres    false            ?            1259    19294    inventario_producto    TABLE     ?  CREATE TABLE public.inventario_producto (
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
       public         heap    postgres    false            ?            1259    19292 -   inventario_producto_idinventario_producto_seq    SEQUENCE     ?   CREATE SEQUENCE public.inventario_producto_idinventario_producto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE public.inventario_producto_idinventario_producto_seq;
       public          postgres    false            ?            1259    19590 
   migrations    TABLE     ?   CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);
    DROP TABLE public.migrations;
       public         heap    postgres    false            ?            1259    19588    migrations_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public          postgres    false    247            q           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public          postgres    false    246                       1259    19655    model_has_permissions    TABLE     ?   CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);
 )   DROP TABLE public.model_has_permissions;
       public         heap    postgres    false                       1259    19666    model_has_roles    TABLE     ?   CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);
 #   DROP TABLE public.model_has_roles;
       public         heap    postgres    false            ?            1259    19300    orden_salida    TABLE     ?  CREATE TABLE public.orden_salida (
    idorden_salida integer DEFAULT nextval(('orden_salida_idorden_salida_seq'::text)::regclass) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    nota character varying(200),
    fkidsucursal integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
     DROP TABLE public.orden_salida;
       public         heap    postgres    false            ?            1259    19298    orden_salida_idorden_salida_seq    SEQUENCE     ?   CREATE SEQUENCE public.orden_salida_idorden_salida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.orden_salida_idorden_salida_seq;
       public          postgres    false            ?            1259    19614    password_resets    TABLE     ?   CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);
 #   DROP TABLE public.password_resets;
       public         heap    postgres    false            ?            1259    19306    pedido    TABLE     c  CREATE TABLE public.pedido (
    idpedido integer DEFAULT nextval(('pedido_idpedido_seq'::text)::regclass) NOT NULL,
    fecha timestamp without time zone NOT NULL,
    hora timestamp without time zone NOT NULL,
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
       public         heap    postgres    false            ?            1259    19304    pedido_idpedido_seq    SEQUENCE     |   CREATE SEQUENCE public.pedido_idpedido_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.pedido_idpedido_seq;
       public          postgres    false            ?            1259    19313    permiso_idpermiso_seq    SEQUENCE     ~   CREATE SEQUENCE public.permiso_idpermiso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.permiso_idpermiso_seq;
       public          postgres    false            ?            1259    19635    permissions    TABLE     #  CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.permissions;
       public         heap    postgres    false            ?            1259    19633    permissions_id_seq    SEQUENCE     {   CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.permissions_id_seq;
       public          postgres    false    254            r           0    0    permissions_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;
          public          postgres    false    253            ?            1259    19321    personal    TABLE       CREATE TABLE public.personal (
    idpersonal integer DEFAULT nextval(('personal_idpersonal_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    ci character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    telefono_celular character varying(50) NOT NULL,
    direccion character varying(50) NOT NULL,
    fkidtipo_personal integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.personal;
       public         heap    postgres    false            ?            1259    19319    personal_idpersonal_seq    SEQUENCE     ?   CREATE SEQUENCE public.personal_idpersonal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.personal_idpersonal_seq;
       public          postgres    false            ?            1259    19325    produccion_personal    TABLE     7  CREATE TABLE public.produccion_personal (
    fkidficha_produccion integer NOT NULL,
    fkidpersonal integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 '   DROP TABLE public.produccion_personal;
       public         heap    postgres    false            ?            1259    19330    producto    TABLE     ?  CREATE TABLE public.producto (
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
       public         heap    postgres    false            ?            1259    19328    producto_idproducto_seq    SEQUENCE     ?   CREATE SEQUENCE public.producto_idproducto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.producto_idproducto_seq;
       public          postgres    false            ?            1259    19336 	   proveedor    TABLE     ?  CREATE TABLE public.proveedor (
    idproveedor integer DEFAULT nextval(('proveedor_idproveedor_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    telefono_celular character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.proveedor;
       public         heap    postgres    false            ?            1259    19334    proveedor_idproveedor_seq    SEQUENCE     ?   CREATE SEQUENCE public.proveedor_idproveedor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.proveedor_idproveedor_seq;
       public          postgres    false            ?            1259    19340    rol_idrol_seq    SEQUENCE     v   CREATE SEQUENCE public.rol_idrol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.rol_idrol_seq;
       public          postgres    false                       1259    19677    role_has_permissions    TABLE     m   CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);
 (   DROP TABLE public.role_has_permissions;
       public         heap    postgres    false                        1259    19646    roles    TABLE       CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.roles;
       public         heap    postgres    false            ?            1259    19644    roles_id_seq    SEQUENCE     u   CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          postgres    false    256            s           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          postgres    false    255            ?            1259    19351    sucursal    TABLE     ?  CREATE TABLE public.sucursal (
    idsucursal integer DEFAULT nextval(('sucursal_idsucursal_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    direccion character varying(100) NOT NULL,
    telefono character varying(10) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.sucursal;
       public         heap    postgres    false            ?            1259    19349    sucursal_idsucursal_seq    SEQUENCE     ?   CREATE SEQUENCE public.sucursal_idsucursal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.sucursal_idsucursal_seq;
       public          postgres    false            ?            1259    19357    tipo_entrega    TABLE     G  CREATE TABLE public.tipo_entrega (
    idtipo_entrega integer DEFAULT nextval(('tipo_entrega_idtipo_entrega_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
     DROP TABLE public.tipo_entrega;
       public         heap    postgres    false            ?            1259    19355    tipo_entrega_idtipo_entrega_seq    SEQUENCE     ?   CREATE SEQUENCE public.tipo_entrega_idtipo_entrega_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.tipo_entrega_idtipo_entrega_seq;
       public          postgres    false            ?            1259    19363    tipo_personal    TABLE     K  CREATE TABLE public.tipo_personal (
    idtipo_personal integer DEFAULT nextval(('tipo_personal_idtipo_personal_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 !   DROP TABLE public.tipo_personal;
       public         heap    postgres    false            ?            1259    19361 !   tipo_personal_idtipo_personal_seq    SEQUENCE     ?   CREATE SEQUENCE public.tipo_personal_idtipo_personal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.tipo_personal_idtipo_personal_seq;
       public          postgres    false            ?            1259    19369    unidad_medida    TABLE     {  CREATE TABLE public.unidad_medida (
    idunidad_medida integer DEFAULT nextval(('unidad_medida_idunidad_medida_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    abreviatura character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
 !   DROP TABLE public.unidad_medida;
       public         heap    postgres    false            ?            1259    19367 !   unidad_medida_idunidad_medida_seq    SEQUENCE     ?   CREATE SEQUENCE public.unidad_medida_idunidad_medida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.unidad_medida_idunidad_medida_seq;
       public          postgres    false            ?            1259    19598    users    TABLE     ?  CREATE TABLE public.users (
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
       public         heap    postgres    false            ?            1259    19596    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    249            t           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    248            ?            1259    19375    usuario    TABLE     ?  CREATE TABLE public.usuario (
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
       public         heap    postgres    false            ?            1259    19373    usuario_idusuario_seq    SEQUENCE     ~   CREATE SEQUENCE public.usuario_idusuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.usuario_idusuario_seq;
       public          postgres    false            ?            1259    19384    venta    TABLE     ?  CREATE TABLE public.venta (
    idventa integer DEFAULT nextval(('venta_idventa_seq'::text)::regclass) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    total integer NOT NULL,
    fkidcliente integer NOT NULL,
    fkidusuario integer NOT NULL,
    fkidpedido integer,
    fkidsucursal integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);
    DROP TABLE public.venta;
       public         heap    postgres    false            ?            1259    19382    venta_idventa_seq    SEQUENCE     z   CREATE SEQUENCE public.venta_idventa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.venta_idventa_seq;
       public          postgres    false            J           2604    19626    failed_jobs id    DEFAULT     p   ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);
 =   ALTER TABLE public.failed_jobs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    251    252    252            H           2604    19593    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    246    247    247            L           2604    19638    permissions id    DEFAULT     p   ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);
 =   ALTER TABLE public.permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    253    254    254            M           2604    19649    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    256    255    256            I           2604    19601    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    249    248    249            1          0    19243 	   categoria 
   TABLE DATA           \   COPY public.categoria (idcategoria, nombre, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    203   ?      3          0    19249    cliente 
   TABLE DATA           ?   COPY public.cliente (idcliente, ci, nombre, apellido, telefono_celular, direccion, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    205   ?      5          0    19255    compra 
   TABLE DATA           p   COPY public.compra (idcompra, fecha_hora, total, fkidproveedor, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    207         6          0    19259    detalle_compra 
   TABLE DATA           v   COPY public.detalle_compra (fkidinsumo, fkidcompra, cantidad, precio, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    208   /      7          0    19262    detalle_inventario 
   TABLE DATA           ?   COPY public.detalle_inventario (fkidinventario_inicial, fkidproducto, cantidad, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    209   L      8          0    19265    detalle_produccion 
   TABLE DATA           |   COPY public.detalle_produccion (fkidficha_produccion, fkidinsumo, cantidad, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    210   i      9          0    19268    detalle_salida 
   TABLE DATA           ?   COPY public.detalle_salida (fkidorden_salida, fkidinventario_producto, cantidad, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    211   ?      :          0    19271    detalle_venta 
   TABLE DATA           v   COPY public.detalle_venta (fkidproducto, fkidventa, cantidad, precio, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    212   ?      b          0    19623    failed_jobs 
   TABLE DATA           [   COPY public.failed_jobs (id, connection, queue, payload, exception, failed_at) FROM stdin;
    public          postgres    false    252   ?      <          0    19276    ficha_produccion 
   TABLE DATA           ?   COPY public.ficha_produccion (idficha_produccion, fecha_hora, cantidad, fkidproducto, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    214   ?      >          0    19282    insumo 
   TABLE DATA           ?   COPY public.insumo (idinsumo, nombre, costo, stock, stock_minimo, stock_maximo, fkidunidad_medida, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    216   ?      @          0    19288    inventario_inicial 
   TABLE DATA           {   COPY public.inventario_inicial (idinventario_inicial, fecha, fkidsucursal, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    218         B          0    19294    inventario_producto 
   TABLE DATA           ?   COPY public.inventario_producto (idinventario_producto, stock, stock_minimo, stock_maximo, fkidproducto, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    220   4      ]          0    19590 
   migrations 
   TABLE DATA           :   COPY public.migrations (id, migration, batch) FROM stdin;
    public          postgres    false    247   Q      g          0    19655    model_has_permissions 
   TABLE DATA           T   COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
    public          postgres    false    257   ?      h          0    19666    model_has_roles 
   TABLE DATA           H   COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;
    public          postgres    false    258   ?      D          0    19300    orden_salida 
   TABLE DATA           z   COPY public.orden_salida (idorden_salida, fecha_hora, nota, fkidsucursal, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    222         `          0    19614    password_resets 
   TABLE DATA           C   COPY public.password_resets (email, token, created_at) FROM stdin;
    public          postgres    false    250   /      F          0    19306    pedido 
   TABLE DATA           ?   COPY public.pedido (idpedido, fecha, hora, coordenada, observacion, direccion, estado, referencia, fkidtipo_entrega, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    224   L      d          0    19635    permissions 
   TABLE DATA           _   COPY public.permissions (id, name, guard_name, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    254   i      I          0    19321    personal 
   TABLE DATA           ?   COPY public.personal (idpersonal, nombre, ci, apellido, telefono_celular, direccion, fkidtipo_personal, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    227   ?      J          0    19325    produccion_personal 
   TABLE DATA           |   COPY public.produccion_personal (fkidficha_produccion, fkidpersonal, fecha, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    228   ?      L          0    19330    producto 
   TABLE DATA           ?   COPY public.producto (idproducto, nombre, descripcion, precio, foto, fkidcategoria, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    230   ?      N          0    19336 	   proveedor 
   TABLE DATA              COPY public.proveedor (idproveedor, nombre, apellido, telefono_celular, email, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    232   ?      i          0    19677    role_has_permissions 
   TABLE DATA           F   COPY public.role_has_permissions (permission_id, role_id) FROM stdin;
    public          postgres    false    259   ?      f          0    19646    roles 
   TABLE DATA           Y   COPY public.roles (id, name, guard_name, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    256         Q          0    19351    sucursal 
   TABLE DATA           o   COPY public.sucursal (idsucursal, nombre, direccion, telefono, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    235   4      S          0    19357    tipo_entrega 
   TABLE DATA           b   COPY public.tipo_entrega (idtipo_entrega, nombre, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    237   Q      U          0    19363    tipo_personal 
   TABLE DATA           d   COPY public.tipo_personal (idtipo_personal, nombre, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    239   n      W          0    19369    unidad_medida 
   TABLE DATA           q   COPY public.unidad_medida (idunidad_medida, nombre, abreviatura, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    241   ?      _          0    19598    users 
   TABLE DATA           ?   COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, deleted_at, fkidusuario) FROM stdin;
    public          postgres    false    249   ?      Y          0    19375    usuario 
   TABLE DATA           ?   COPY public.usuario (idusuario, email, password, fkidcliente, fkidpersonal, token, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    243   ?      [          0    19384    venta 
   TABLE DATA           ?   COPY public.venta (idventa, fecha_hora, total, fkidcliente, fkidusuario, fkidpedido, fkidsucursal, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    245   ?      u           0    0    categoria_idcategoria_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.categoria_idcategoria_seq', 1, false);
          public          postgres    false    202            v           0    0    cliente_idcliente_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.cliente_idcliente_seq', 1, false);
          public          postgres    false    204            w           0    0    compra_idcompra_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.compra_idcompra_seq', 1, false);
          public          postgres    false    206            x           0    0    failed_jobs_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);
          public          postgres    false    251            y           0    0 '   ficha_produccion_idficha_produccion_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.ficha_produccion_idficha_produccion_seq', 1, false);
          public          postgres    false    213            z           0    0    insumo_idinsumo_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.insumo_idinsumo_seq', 1, false);
          public          postgres    false    215            {           0    0 +   inventario_inicial_idinventario_inicial_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.inventario_inicial_idinventario_inicial_seq', 1, false);
          public          postgres    false    217            |           0    0 -   inventario_producto_idinventario_producto_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.inventario_producto_idinventario_producto_seq', 1, false);
          public          postgres    false    219            }           0    0    migrations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.migrations_id_seq', 4, true);
          public          postgres    false    246            ~           0    0    orden_salida_idorden_salida_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.orden_salida_idorden_salida_seq', 1, false);
          public          postgres    false    221                       0    0    pedido_idpedido_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.pedido_idpedido_seq', 1, false);
          public          postgres    false    223            ?           0    0    permiso_idpermiso_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.permiso_idpermiso_seq', 1, false);
          public          postgres    false    225            ?           0    0    permissions_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);
          public          postgres    false    253            ?           0    0    personal_idpersonal_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.personal_idpersonal_seq', 1, false);
          public          postgres    false    226            ?           0    0    producto_idproducto_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.producto_idproducto_seq', 1, false);
          public          postgres    false    229            ?           0    0    proveedor_idproveedor_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.proveedor_idproveedor_seq', 1, false);
          public          postgres    false    231            ?           0    0    rol_idrol_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.rol_idrol_seq', 1, false);
          public          postgres    false    233            ?           0    0    roles_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.roles_id_seq', 1, false);
          public          postgres    false    255            ?           0    0    sucursal_idsucursal_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.sucursal_idsucursal_seq', 1, false);
          public          postgres    false    234            ?           0    0    tipo_entrega_idtipo_entrega_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.tipo_entrega_idtipo_entrega_seq', 1, false);
          public          postgres    false    236            ?           0    0 !   tipo_personal_idtipo_personal_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.tipo_personal_idtipo_personal_seq', 1, false);
          public          postgres    false    238            ?           0    0 !   unidad_medida_idunidad_medida_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.unidad_medida_idunidad_medida_seq', 1, false);
          public          postgres    false    240            ?           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 1, false);
          public          postgres    false    248            ?           0    0    usuario_idusuario_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.usuario_idusuario_seq', 1, false);
          public          postgres    false    242            ?           0    0    venta_idventa_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.venta_idventa_seq', 1, false);
          public          postgres    false    244            ?           2606    19632    failed_jobs failed_jobs_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.failed_jobs DROP CONSTRAINT failed_jobs_pkey;
       public            postgres    false    252                       2606    19595    migrations migrations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
       public            postgres    false    247            ?           2606    19665 0   model_has_permissions model_has_permissions_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);
 Z   ALTER TABLE ONLY public.model_has_permissions DROP CONSTRAINT model_has_permissions_pkey;
       public            postgres    false    257    257    257            ?           2606    19676 $   model_has_roles model_has_roles_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);
 N   ALTER TABLE ONLY public.model_has_roles DROP CONSTRAINT model_has_roles_pkey;
       public            postgres    false    258    258    258            ?           2606    19643    permissions permissions_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.permissions DROP CONSTRAINT permissions_pkey;
       public            postgres    false    254            O           2606    19389    categoria pk_categoria 
   CONSTRAINT     ]   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT pk_categoria PRIMARY KEY (idcategoria);
 @   ALTER TABLE ONLY public.categoria DROP CONSTRAINT pk_categoria;
       public            postgres    false    203            Q           2606    19391    cliente pk_cliente 
   CONSTRAINT     W   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT pk_cliente PRIMARY KEY (idcliente);
 <   ALTER TABLE ONLY public.cliente DROP CONSTRAINT pk_cliente;
       public            postgres    false    205            S           2606    19393    compra pk_compra 
   CONSTRAINT     T   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT pk_compra PRIMARY KEY (idcompra);
 :   ALTER TABLE ONLY public.compra DROP CONSTRAINT pk_compra;
       public            postgres    false    207            U           2606    19395     detalle_compra pk_detalle_compra 
   CONSTRAINT     r   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT pk_detalle_compra PRIMARY KEY (fkidinsumo, fkidcompra);
 J   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT pk_detalle_compra;
       public            postgres    false    208    208            W           2606    19397 (   detalle_inventario pk_detalle_inventario 
   CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_inventario
    ADD CONSTRAINT pk_detalle_inventario PRIMARY KEY (fkidinventario_inicial, fkidproducto);
 R   ALTER TABLE ONLY public.detalle_inventario DROP CONSTRAINT pk_detalle_inventario;
       public            postgres    false    209    209            Y           2606    19399 (   detalle_produccion pk_detalle_produccion 
   CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_produccion
    ADD CONSTRAINT pk_detalle_produccion PRIMARY KEY (fkidficha_produccion, fkidinsumo);
 R   ALTER TABLE ONLY public.detalle_produccion DROP CONSTRAINT pk_detalle_produccion;
       public            postgres    false    210    210            [           2606    19401     detalle_salida pk_detalle_salida 
   CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_salida
    ADD CONSTRAINT pk_detalle_salida PRIMARY KEY (fkidorden_salida, fkidinventario_producto);
 J   ALTER TABLE ONLY public.detalle_salida DROP CONSTRAINT pk_detalle_salida;
       public            postgres    false    211    211            ]           2606    19403    detalle_venta pk_detalle_venta 
   CONSTRAINT     q   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT pk_detalle_venta PRIMARY KEY (fkidproducto, fkidventa);
 H   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT pk_detalle_venta;
       public            postgres    false    212    212            _           2606    19405 $   ficha_produccion pk_ficha_produccion 
   CONSTRAINT     r   ALTER TABLE ONLY public.ficha_produccion
    ADD CONSTRAINT pk_ficha_produccion PRIMARY KEY (idficha_produccion);
 N   ALTER TABLE ONLY public.ficha_produccion DROP CONSTRAINT pk_ficha_produccion;
       public            postgres    false    214            a           2606    19407    insumo pk_insumo 
   CONSTRAINT     T   ALTER TABLE ONLY public.insumo
    ADD CONSTRAINT pk_insumo PRIMARY KEY (idinsumo);
 :   ALTER TABLE ONLY public.insumo DROP CONSTRAINT pk_insumo;
       public            postgres    false    216            c           2606    19409 (   inventario_inicial pk_inventario_inicial 
   CONSTRAINT     x   ALTER TABLE ONLY public.inventario_inicial
    ADD CONSTRAINT pk_inventario_inicial PRIMARY KEY (idinventario_inicial);
 R   ALTER TABLE ONLY public.inventario_inicial DROP CONSTRAINT pk_inventario_inicial;
       public            postgres    false    218            e           2606    19411 *   inventario_producto pk_inventario_producto 
   CONSTRAINT     {   ALTER TABLE ONLY public.inventario_producto
    ADD CONSTRAINT pk_inventario_producto PRIMARY KEY (idinventario_producto);
 T   ALTER TABLE ONLY public.inventario_producto DROP CONSTRAINT pk_inventario_producto;
       public            postgres    false    220            g           2606    19413    orden_salida pk_orden_salida 
   CONSTRAINT     f   ALTER TABLE ONLY public.orden_salida
    ADD CONSTRAINT pk_orden_salida PRIMARY KEY (idorden_salida);
 F   ALTER TABLE ONLY public.orden_salida DROP CONSTRAINT pk_orden_salida;
       public            postgres    false    222            i           2606    19415    pedido pk_pedido 
   CONSTRAINT     T   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pk_pedido PRIMARY KEY (idpedido);
 :   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pk_pedido;
       public            postgres    false    224            k           2606    19419    personal pk_personal 
   CONSTRAINT     Z   ALTER TABLE ONLY public.personal
    ADD CONSTRAINT pk_personal PRIMARY KEY (idpersonal);
 >   ALTER TABLE ONLY public.personal DROP CONSTRAINT pk_personal;
       public            postgres    false    227            m           2606    19421 *   produccion_personal pk_produccion_personal 
   CONSTRAINT     ?   ALTER TABLE ONLY public.produccion_personal
    ADD CONSTRAINT pk_produccion_personal PRIMARY KEY (fkidficha_produccion, fkidpersonal);
 T   ALTER TABLE ONLY public.produccion_personal DROP CONSTRAINT pk_produccion_personal;
       public            postgres    false    228    228            o           2606    19423    producto pk_producto 
   CONSTRAINT     Z   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT pk_producto PRIMARY KEY (idproducto);
 >   ALTER TABLE ONLY public.producto DROP CONSTRAINT pk_producto;
       public            postgres    false    230            q           2606    19425    proveedor pk_proveedor 
   CONSTRAINT     ]   ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT pk_proveedor PRIMARY KEY (idproveedor);
 @   ALTER TABLE ONLY public.proveedor DROP CONSTRAINT pk_proveedor;
       public            postgres    false    232            s           2606    19431    sucursal pk_sucursal 
   CONSTRAINT     Z   ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT pk_sucursal PRIMARY KEY (idsucursal);
 >   ALTER TABLE ONLY public.sucursal DROP CONSTRAINT pk_sucursal;
       public            postgres    false    235            u           2606    19433    tipo_entrega pk_tipo_entrega 
   CONSTRAINT     f   ALTER TABLE ONLY public.tipo_entrega
    ADD CONSTRAINT pk_tipo_entrega PRIMARY KEY (idtipo_entrega);
 F   ALTER TABLE ONLY public.tipo_entrega DROP CONSTRAINT pk_tipo_entrega;
       public            postgres    false    237            w           2606    19435    tipo_personal pk_tipo_personal 
   CONSTRAINT     i   ALTER TABLE ONLY public.tipo_personal
    ADD CONSTRAINT pk_tipo_personal PRIMARY KEY (idtipo_personal);
 H   ALTER TABLE ONLY public.tipo_personal DROP CONSTRAINT pk_tipo_personal;
       public            postgres    false    239            y           2606    19437    unidad_medida pk_unidad_medida 
   CONSTRAINT     i   ALTER TABLE ONLY public.unidad_medida
    ADD CONSTRAINT pk_unidad_medida PRIMARY KEY (idunidad_medida);
 H   ALTER TABLE ONLY public.unidad_medida DROP CONSTRAINT pk_unidad_medida;
       public            postgres    false    241            {           2606    19439    usuario pk_usuario 
   CONSTRAINT     W   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (idusuario);
 <   ALTER TABLE ONLY public.usuario DROP CONSTRAINT pk_usuario;
       public            postgres    false    243            }           2606    19441    venta pk_venta 
   CONSTRAINT     Q   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT pk_venta PRIMARY KEY (idventa);
 8   ALTER TABLE ONLY public.venta DROP CONSTRAINT pk_venta;
       public            postgres    false    245            ?           2606    19691 .   role_has_permissions role_has_permissions_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);
 X   ALTER TABLE ONLY public.role_has_permissions DROP CONSTRAINT role_has_permissions_pkey;
       public            postgres    false    259    259            ?           2606    19654    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    256            ?           2606    19613    users users_email_unique 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_unique;
       public            postgres    false    249            ?           2606    19606    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    249            ?           1259    19658 /   model_has_permissions_model_id_model_type_index    INDEX     ?   CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);
 C   DROP INDEX public.model_has_permissions_model_id_model_type_index;
       public            postgres    false    257    257            ?           1259    19669 )   model_has_roles_model_id_model_type_index    INDEX     u   CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);
 =   DROP INDEX public.model_has_roles_model_id_model_type_index;
       public            postgres    false    258    258            ?           1259    19620    password_resets_email_index    INDEX     X   CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);
 /   DROP INDEX public.password_resets_email_index;
       public            postgres    false    250            ?           2606    19442    compra fk_compra_proveedor    FK CONSTRAINT     ?   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_compra_proveedor FOREIGN KEY (fkidproveedor) REFERENCES public.proveedor(idproveedor);
 D   ALTER TABLE ONLY public.compra DROP CONSTRAINT fk_compra_proveedor;
       public          postgres    false    232    207    2929            ?           2606    19447 '   detalle_compra fk_detalle_compra_compra    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_detalle_compra_compra FOREIGN KEY (fkidcompra) REFERENCES public.compra(idcompra);
 Q   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT fk_detalle_compra_compra;
       public          postgres    false    207    208    2899            ?           2606    19452 '   detalle_compra fk_detalle_compra_insumo    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_detalle_compra_insumo FOREIGN KEY (fkidinsumo) REFERENCES public.insumo(idinsumo);
 Q   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT fk_detalle_compra_insumo;
       public          postgres    false    216    2913    208            ?           2606    19457 ;   detalle_inventario fk_detalle_inventario_inventario_inicial    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_inventario
    ADD CONSTRAINT fk_detalle_inventario_inventario_inicial FOREIGN KEY (fkidinventario_inicial) REFERENCES public.inventario_inicial(idinventario_inicial);
 e   ALTER TABLE ONLY public.detalle_inventario DROP CONSTRAINT fk_detalle_inventario_inventario_inicial;
       public          postgres    false    218    2915    209            ?           2606    19462 1   detalle_inventario fk_detalle_inventario_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_inventario
    ADD CONSTRAINT fk_detalle_inventario_producto FOREIGN KEY (fkidproducto) REFERENCES public.producto(idproducto);
 [   ALTER TABLE ONLY public.detalle_inventario DROP CONSTRAINT fk_detalle_inventario_producto;
       public          postgres    false    209    230    2927            ?           2606    19467 9   detalle_produccion fk_detalle_produccion_ficha_produccion    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_produccion
    ADD CONSTRAINT fk_detalle_produccion_ficha_produccion FOREIGN KEY (fkidficha_produccion) REFERENCES public.ficha_produccion(idficha_produccion);
 c   ALTER TABLE ONLY public.detalle_produccion DROP CONSTRAINT fk_detalle_produccion_ficha_produccion;
       public          postgres    false    2911    210    214            ?           2606    19472 /   detalle_produccion fk_detalle_produccion_insumo    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_produccion
    ADD CONSTRAINT fk_detalle_produccion_insumo FOREIGN KEY (fkidinsumo) REFERENCES public.insumo(idinsumo);
 Y   ALTER TABLE ONLY public.detalle_produccion DROP CONSTRAINT fk_detalle_produccion_insumo;
       public          postgres    false    2913    210    216            ?           2606    19477 4   detalle_salida fk_detalle_salida_inventario_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_salida
    ADD CONSTRAINT fk_detalle_salida_inventario_producto FOREIGN KEY (fkidinventario_producto) REFERENCES public.inventario_producto(idinventario_producto);
 ^   ALTER TABLE ONLY public.detalle_salida DROP CONSTRAINT fk_detalle_salida_inventario_producto;
       public          postgres    false    211    220    2917            ?           2606    19482 -   detalle_salida fk_detalle_salida_orden_salida    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_salida
    ADD CONSTRAINT fk_detalle_salida_orden_salida FOREIGN KEY (fkidorden_salida) REFERENCES public.orden_salida(idorden_salida);
 W   ALTER TABLE ONLY public.detalle_salida DROP CONSTRAINT fk_detalle_salida_orden_salida;
       public          postgres    false    211    222    2919            ?           2606    19487 '   detalle_venta fk_detalle_venta_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_detalle_venta_producto FOREIGN KEY (fkidproducto) REFERENCES public.producto(idproducto);
 Q   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT fk_detalle_venta_producto;
       public          postgres    false    212    2927    230            ?           2606    19492 $   detalle_venta fk_detalle_venta_venta    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_detalle_venta_venta FOREIGN KEY (fkidventa) REFERENCES public.venta(idventa);
 N   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT fk_detalle_venta_venta;
       public          postgres    false    2941    245    212            ?           2606    19497 -   ficha_produccion fk_ficha_produccion_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.ficha_produccion
    ADD CONSTRAINT fk_ficha_produccion_producto FOREIGN KEY (fkidproducto) REFERENCES public.producto(idproducto);
 W   ALTER TABLE ONLY public.ficha_produccion DROP CONSTRAINT fk_ficha_produccion_producto;
       public          postgres    false    214    2927    230            ?           2606    19502    insumo fk_insumo_unidad_medida    FK CONSTRAINT     ?   ALTER TABLE ONLY public.insumo
    ADD CONSTRAINT fk_insumo_unidad_medida FOREIGN KEY (fkidunidad_medida) REFERENCES public.unidad_medida(idunidad_medida);
 H   ALTER TABLE ONLY public.insumo DROP CONSTRAINT fk_insumo_unidad_medida;
       public          postgres    false    2937    241    216            ?           2606    19507 1   inventario_inicial fk_inventario_inicial_sucursal    FK CONSTRAINT     ?   ALTER TABLE ONLY public.inventario_inicial
    ADD CONSTRAINT fk_inventario_inicial_sucursal FOREIGN KEY (fkidsucursal) REFERENCES public.sucursal(idsucursal);
 [   ALTER TABLE ONLY public.inventario_inicial DROP CONSTRAINT fk_inventario_inicial_sucursal;
       public          postgres    false    2931    235    218            ?           2606    19512 3   inventario_producto fk_inventario_producto_producto    FK CONSTRAINT     ?   ALTER TABLE ONLY public.inventario_producto
    ADD CONSTRAINT fk_inventario_producto_producto FOREIGN KEY (fkidproducto) REFERENCES public.producto(idproducto);
 ]   ALTER TABLE ONLY public.inventario_producto DROP CONSTRAINT fk_inventario_producto_producto;
       public          postgres    false    2927    230    220            ?           2606    19517 %   orden_salida fk_orden_salida_sucursal    FK CONSTRAINT     ?   ALTER TABLE ONLY public.orden_salida
    ADD CONSTRAINT fk_orden_salida_sucursal FOREIGN KEY (fkidsucursal) REFERENCES public.sucursal(idsucursal);
 O   ALTER TABLE ONLY public.orden_salida DROP CONSTRAINT fk_orden_salida_sucursal;
       public          postgres    false    2931    235    222            ?           2606    19522 "   personal fk_personal_tipo_personal    FK CONSTRAINT     ?   ALTER TABLE ONLY public.personal
    ADD CONSTRAINT fk_personal_tipo_personal FOREIGN KEY (fkidtipo_personal) REFERENCES public.tipo_personal(idtipo_personal);
 L   ALTER TABLE ONLY public.personal DROP CONSTRAINT fk_personal_tipo_personal;
       public          postgres    false    2935    239    227            ?           2606    19527 ;   produccion_personal fk_produccion_personal_ficha_produccion    FK CONSTRAINT     ?   ALTER TABLE ONLY public.produccion_personal
    ADD CONSTRAINT fk_produccion_personal_ficha_produccion FOREIGN KEY (fkidficha_produccion) REFERENCES public.ficha_produccion(idficha_produccion);
 e   ALTER TABLE ONLY public.produccion_personal DROP CONSTRAINT fk_produccion_personal_ficha_produccion;
       public          postgres    false    228    214    2911            ?           2606    19532 3   produccion_personal fk_produccion_personal_personal    FK CONSTRAINT     ?   ALTER TABLE ONLY public.produccion_personal
    ADD CONSTRAINT fk_produccion_personal_personal FOREIGN KEY (fkidpersonal) REFERENCES public.personal(idpersonal);
 ]   ALTER TABLE ONLY public.produccion_personal DROP CONSTRAINT fk_produccion_personal_personal;
       public          postgres    false    227    228    2923            ?           2606    19537    producto fk_producto_categoria    FK CONSTRAINT     ?   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (fkidcategoria) REFERENCES public.categoria(idcategoria);
 H   ALTER TABLE ONLY public.producto DROP CONSTRAINT fk_producto_categoria;
       public          postgres    false    230    203    2895            ?           2606    19552    usuario fk_usuario_cliente    FK CONSTRAINT     ?   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_cliente FOREIGN KEY (fkidcliente) REFERENCES public.cliente(idcliente);
 D   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_usuario_cliente;
       public          postgres    false    205    243    2897            ?           2606    19557    usuario fk_usuario_personal    FK CONSTRAINT     ?   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_personal FOREIGN KEY (fkidpersonal) REFERENCES public.personal(idpersonal);
 E   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_usuario_personal;
       public          postgres    false    227    2923    243            ?           2606    19567    venta fk_venta_cliente    FK CONSTRAINT     ?   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (fkidcliente) REFERENCES public.cliente(idcliente);
 @   ALTER TABLE ONLY public.venta DROP CONSTRAINT fk_venta_cliente;
       public          postgres    false    2897    205    245            ?           2606    19572    venta fk_venta_pedido    FK CONSTRAINT     ~   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_pedido FOREIGN KEY (fkidpedido) REFERENCES public.pedido(idpedido);
 ?   ALTER TABLE ONLY public.venta DROP CONSTRAINT fk_venta_pedido;
       public          postgres    false    2921    224    245            ?           2606    19577    venta fk_venta_sucursal    FK CONSTRAINT     ?   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_sucursal FOREIGN KEY (fkidsucursal) REFERENCES public.sucursal(idsucursal);
 A   ALTER TABLE ONLY public.venta DROP CONSTRAINT fk_venta_sucursal;
       public          postgres    false    2931    245    235            ?           2606    19582    venta fk_venta_usuario    FK CONSTRAINT     ?   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_usuario FOREIGN KEY (fkidusuario) REFERENCES public.usuario(idusuario);
 @   ALTER TABLE ONLY public.venta DROP CONSTRAINT fk_venta_usuario;
       public          postgres    false    245    2939    243            ?           2606    19659 A   model_has_permissions model_has_permissions_permission_id_foreign    FK CONSTRAINT     ?   ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;
 k   ALTER TABLE ONLY public.model_has_permissions DROP CONSTRAINT model_has_permissions_permission_id_foreign;
       public          postgres    false    254    2952    257            ?           2606    19670 /   model_has_roles model_has_roles_role_id_foreign    FK CONSTRAINT     ?   ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.model_has_roles DROP CONSTRAINT model_has_roles_role_id_foreign;
       public          postgres    false    2954    256    258            ?           2606    19680 ?   role_has_permissions role_has_permissions_permission_id_foreign    FK CONSTRAINT     ?   ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.role_has_permissions DROP CONSTRAINT role_has_permissions_permission_id_foreign;
       public          postgres    false    254    259    2952            ?           2606    19685 9   role_has_permissions role_has_permissions_role_id_foreign    FK CONSTRAINT     ?   ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.role_has_permissions DROP CONSTRAINT role_has_permissions_role_id_foreign;
       public          postgres    false    256    259    2954            ?           2606    19607    users users_fkidusuario_foreign    FK CONSTRAINT     ?   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_fkidusuario_foreign FOREIGN KEY (fkidusuario) REFERENCES public.usuario(idusuario);
 I   ALTER TABLE ONLY public.users DROP CONSTRAINT users_fkidusuario_foreign;
       public          postgres    false    2939    249    243            1      x?????? ? ?      3      x?????? ? ?      5      x?????? ? ?      6      x?????? ? ?      7      x?????? ? ?      8      x?????? ? ?      9      x?????? ? ?      :      x?????? ? ?      b      x?????? ? ?      <      x?????? ? ?      >      x?????? ? ?      @      x?????? ? ?      B      x?????? ? ?      ]   w   x?U??
?@??u?a$???wSa?:?????(??EV???F?[0??;?LcQ|\?Q?0i?A???ݿ?F???-9פ]P?!??4??G6?.\??a??[Ԟ?=??_?¯??x_:      g      x?????? ? ?      h      x?????? ? ?      D      x?????? ? ?      `      x?????? ? ?      F      x?????? ? ?      d      x?????? ? ?      I      x?????? ? ?      J      x?????? ? ?      L      x?????? ? ?      N      x?????? ? ?      i      x?????? ? ?      f      x?????? ? ?      Q      x?????? ? ?      S      x?????? ? ?      U      x?????? ? ?      W      x?????? ? ?      _      x?????? ? ?      Y      x?????? ? ?      [      x?????? ? ?     