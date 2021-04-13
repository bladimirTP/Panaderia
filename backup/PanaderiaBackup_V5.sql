--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

-- Started on 2020-09-14 08:33:57

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16744)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    idcategoria integer NOT NULL,
    nombre character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16750)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
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


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16404)
-- Name: cliente_idcliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_idcliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cliente_idcliente_seq OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16754)
-- Name: compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compra (
    idcompra integer DEFAULT nextval(('compra_idcompra_seq'::text)::regclass) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    total integer NOT NULL,
    fkidproveedor integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.compra OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16410)
-- Name: compra_idcompra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.compra_idcompra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.compra_idcompra_seq OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16758)
-- Name: detalle_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_compra (
    fkidinsumo integer NOT NULL,
    fkidcompra integer NOT NULL,
    cantidad integer NOT NULL,
    precio real NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.detalle_compra OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16761)
-- Name: detalle_produccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_produccion (
    fkidficha_produccion integer NOT NULL,
    fkidinsumo integer NOT NULL,
    cantidad integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.detalle_produccion OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16764)
-- Name: detalle_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_venta (
    fkidproducto integer NOT NULL,
    fkidventa integer NOT NULL,
    cantidad integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    precio real NOT NULL
);


ALTER TABLE public.detalle_venta OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16767)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16774)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO postgres;

--
-- TOC entry 3115 (class 0 OID 0)
-- Dependencies: 224
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 225 (class 1259 OID 16776)
-- Name: ficha_produccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ficha_produccion (
    idficha_produccion integer DEFAULT nextval(('ficha_produccion_idficha_produccion_seq'::text)::regclass) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    fkidproducto integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    cantidad integer NOT NULL
);


ALTER TABLE public.ficha_produccion OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16434)
-- Name: ficha_produccion_idficha_produccion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ficha_produccion_idficha_produccion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ficha_produccion_idficha_produccion_seq OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16780)
-- Name: insumo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.insumo (
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


ALTER TABLE public.insumo OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16440)
-- Name: insumo_idinsumo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.insumo_idinsumo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.insumo_idinsumo_seq OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16784)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16787)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 3116 (class 0 OID 0)
-- Dependencies: 228
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 229 (class 1259 OID 16789)
-- Name: model_has_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_permissions OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16792)
-- Name: model_has_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_roles OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16795)
-- Name: password_resets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_resets OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16801)
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido (
    idpedido integer DEFAULT nextval(('pedido_idpedido_seq'::text)::regclass) NOT NULL,
    fecha timestamp without time zone NOT NULL,
    hora time without time zone NOT NULL,
    coordenada character varying(50) NOT NULL,
    fkidtipo_entrega integer NOT NULL,
    observacion character varying(100),
    referencia character varying(200) NOT NULL,
    estado character varying(10) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    direccion character varying(100)
);


ALTER TABLE public.pedido OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16463)
-- Name: pedido_idpedido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedido_idpedido_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pedido_idpedido_seq OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16469)
-- Name: permiso_idpermiso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permiso_idpermiso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permiso_idpermiso_seq OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16805)
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    description character varying(255)
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16811)
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_seq OWNER TO postgres;

--
-- TOC entry 3117 (class 0 OID 0)
-- Dependencies: 234
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- TOC entry 235 (class 1259 OID 16813)
-- Name: personal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal (
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


ALTER TABLE public.personal OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16483)
-- Name: personal_idpersonal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_idpersonal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_idpersonal_seq OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16817)
-- Name: produccion_personal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produccion_personal (
    fkidficha_produccion integer NOT NULL,
    fkidpersonal integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.produccion_personal OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16820)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
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


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16492)
-- Name: producto_idproducto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producto_idproducto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.producto_idproducto_seq OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16824)
-- Name: proveedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proveedor (
    idproveedor integer DEFAULT nextval(('proveedor_idproveedor_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    telefono_celular character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.proveedor OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16498)
-- Name: proveedor_idproveedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proveedor_idproveedor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proveedor_idproveedor_seq OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16504)
-- Name: rol_idrol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rol_idrol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rol_idrol_seq OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16828)
-- Name: role_has_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.role_has_permissions OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16831)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16837)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 3118 (class 0 OID 0)
-- Dependencies: 241
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 242 (class 1259 OID 16839)
-- Name: tipo_entrega; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_entrega (
    idtipo_entrega integer DEFAULT nextval(('tipo_entrega_idtipo_entrega_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.tipo_entrega OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16524)
-- Name: tipo_entrega_idtipo_entrega_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_entrega_idtipo_entrega_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_entrega_idtipo_entrega_seq OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16843)
-- Name: tipo_personal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_personal (
    idtipo_personal integer DEFAULT nextval(('tipo_personal_idtipo_personal_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.tipo_personal OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16530)
-- Name: tipo_personal_idtipo_personal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_personal_idtipo_personal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_personal_idtipo_personal_seq OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16847)
-- Name: unidad_medida; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unidad_medida (
    idunidad_medida integer DEFAULT nextval(('unidad_medida_idunidad_medida_seq'::text)::regclass) NOT NULL,
    nombre character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    abreviatura character varying(50) NOT NULL
);


ALTER TABLE public.unidad_medida OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16536)
-- Name: unidad_medida_idunidad_medida_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unidad_medida_idunidad_medida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unidad_medida_idunidad_medida_seq OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16851)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    fkidusuario integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16857)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3119 (class 0 OID 0)
-- Dependencies: 246
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 247 (class 1259 OID 16859)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    idusuario integer DEFAULT nextval(('usuario_idusuario_seq'::text)::regclass) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    fkidcliente integer,
    fkidpersonal integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    token character varying(150)
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16542)
-- Name: usuario_idusuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_idusuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_idusuario_seq OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16866)
-- Name: venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta (
    idventa integer DEFAULT nextval(('venta_idventa_seq'::text)::regclass) NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    total integer NOT NULL,
    fkidcliente integer NOT NULL,
    fkidusuario integer,
    fkidpedido integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.venta OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16548)
-- Name: venta_idventa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venta_idventa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venta_idventa_seq OWNER TO postgres;

--
-- TOC entry 2839 (class 2604 OID 16870)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 2842 (class 2604 OID 16871)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 2844 (class 2604 OID 16872)
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- TOC entry 2848 (class 2604 OID 16873)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 2852 (class 2604 OID 16874)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3078 (class 0 OID 16744)
-- Dependencies: 217
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (idcategoria, nombre, created_at, updated_at, deleted_at) FROM stdin;
1	Normal	\N	\N	\N
2	Especial	\N	\N	\N
3	Integral	\N	\N	\N
\.


--
-- TOC entry 3079 (class 0 OID 16750)
-- Dependencies: 218
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (idcliente, ci, nombre, apellido, telefono_celular, direccion, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- TOC entry 3080 (class 0 OID 16754)
-- Dependencies: 219
-- Data for Name: compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compra (idcompra, fecha_hora, total, fkidproveedor, created_at, updated_at, deleted_at) FROM stdin;
2	2020-09-16 10:30:00	5500	1	\N	\N	\N
6	2020-09-25 06:12:00	500	1	2020-09-14 04:13:00	2020-09-14 04:13:00	\N
\.


--
-- TOC entry 3081 (class 0 OID 16758)
-- Dependencies: 220
-- Data for Name: detalle_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_compra (fkidinsumo, fkidcompra, cantidad, precio, created_at, updated_at, deleted_at) FROM stdin;
1	2	150	15	\N	\N	\N
2	2	20	7	\N	\N	\N
4	6	50	15	\N	\N	\N
2	6	10	2	\N	\N	\N
\.


--
-- TOC entry 3082 (class 0 OID 16761)
-- Dependencies: 221
-- Data for Name: detalle_produccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_produccion (fkidficha_produccion, fkidinsumo, cantidad, created_at, updated_at, deleted_at) FROM stdin;
1	1	50	\N	\N	\N
1	2	20	\N	\N	\N
1	4	14	\N	\N	\N
\.


--
-- TOC entry 3083 (class 0 OID 16764)
-- Dependencies: 222
-- Data for Name: detalle_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_venta (fkidproducto, fkidventa, cantidad, created_at, updated_at, deleted_at, precio) FROM stdin;
\.


--
-- TOC entry 3084 (class 0 OID 16767)
-- Dependencies: 223
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 3086 (class 0 OID 16776)
-- Dependencies: 225
-- Data for Name: ficha_produccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ficha_produccion (idficha_produccion, fecha_hora, fkidproducto, created_at, updated_at, deleted_at, cantidad) FROM stdin;
1	2020-09-15 10:00:00	1	\N	\N	\N	500
\.


--
-- TOC entry 3087 (class 0 OID 16780)
-- Dependencies: 226
-- Data for Name: insumo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.insumo (idinsumo, nombre, costo, stock, stock_minimo, stock_maximo, fkidunidad_medida, created_at, updated_at, deleted_at) FROM stdin;
1	Harina	45.00	50	10	500	1	\N	\N	\N
2	Levadura	12.00	20	10	40	1	\N	\N	\N
4	Manteca	42.00	40	25	130	1	2020-09-14 01:01:20	2020-09-14 01:01:20	\N
\.


--
-- TOC entry 3088 (class 0 OID 16784)
-- Dependencies: 227
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
52	2014_10_12_000000_create_users_table	1
53	2014_10_12_100000_create_password_resets_table	1
54	2019_08_19_000000_create_failed_jobs_table	1
55	2020_09_12_211616_create_permission_tables	1
\.


--
-- TOC entry 3090 (class 0 OID 16789)
-- Dependencies: 229
-- Data for Name: model_has_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
\.


--
-- TOC entry 3091 (class 0 OID 16792)
-- Dependencies: 230
-- Data for Name: model_has_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;
\.


--
-- TOC entry 3092 (class 0 OID 16795)
-- Dependencies: 231
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_resets (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 3093 (class 0 OID 16801)
-- Dependencies: 232
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido (idpedido, fecha, hora, coordenada, fkidtipo_entrega, observacion, referencia, estado, created_at, updated_at, deleted_at, direccion) FROM stdin;
\.


--
-- TOC entry 3094 (class 0 OID 16805)
-- Dependencies: 233
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, name, guard_name, created_at, updated_at, deleted_at, description) FROM stdin;
\.


--
-- TOC entry 3096 (class 0 OID 16813)
-- Dependencies: 235
-- Data for Name: personal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal (idpersonal, nombre, ci, apellido, telefono_celular, direccion, fkidtipo_personal, created_at, updated_at, deleted_at) FROM stdin;
2	vladimir alan	11306459	vasquez arratia	60003467	plan 3000	1	\N	\N	\N
3	matia manuel	8554654	flores	75389644	plan 3000	2	\N	\N	\N
4	daniel	456879	mendoza	4561745	los mangales	3	2020-09-13 23:47:26	2020-09-13 23:47:26	\N
5	daniel	214353	mendoza	77035709	los mangales	3	2020-09-13 23:52:56	2020-09-13 23:52:56	\N
6	bladimir	213521	yavi quiroz	2313245	la villa 1ro de mayo	4	2020-09-13 23:56:52	2020-09-13 23:56:52	\N
7	bladimir	45369871	toco prieto	15647899	la guarida	5	2020-09-14 00:09:38	2020-09-14 00:09:38	\N
\.


--
-- TOC entry 3097 (class 0 OID 16817)
-- Dependencies: 236
-- Data for Name: produccion_personal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produccion_personal (fkidficha_produccion, fkidpersonal, created_at, updated_at, deleted_at) FROM stdin;
1	2	\N	\N	\N
1	3	\N	\N	\N
\.


--
-- TOC entry 3098 (class 0 OID 16820)
-- Dependencies: 237
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producto (idproducto, nombre, descripcion, precio, foto, fkidcategoria, created_at, updated_at, deleted_at) FROM stdin;
1	Pan casero	Pan casero normal	50.00	\N	1	\N	\N	\N
2	Pan Chama	Pan especial	2.00	\N	2	\N	\N	\N
3	Pan Molde	Pan integral	5.00	\N	3	\N	\N	\N
\.


--
-- TOC entry 3099 (class 0 OID 16824)
-- Dependencies: 238
-- Data for Name: proveedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proveedor (idproveedor, nombre, apellido, telefono_celular, email, created_at, updated_at, deleted_at) FROM stdin;
1	Saturnino 	Perez ortiz	52114545	saturnino@gmail.com	\N	\N	\N
2	Oscar 	Villagomez	10251545	oscar@gmail.com	\N	\N	\N
4	ricardo	pereira salinas	74589123	ricardo@gmail.com	2020-09-14 03:26:52	2020-09-14 03:26:52	\N
\.


--
-- TOC entry 3100 (class 0 OID 16828)
-- Dependencies: 239
-- Data for Name: role_has_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_has_permissions (permission_id, role_id) FROM stdin;
\.


--
-- TOC entry 3101 (class 0 OID 16831)
-- Dependencies: 240
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, guard_name, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- TOC entry 3103 (class 0 OID 16839)
-- Dependencies: 242
-- Data for Name: tipo_entrega; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_entrega (idtipo_entrega, nombre, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- TOC entry 3104 (class 0 OID 16843)
-- Dependencies: 243
-- Data for Name: tipo_personal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_personal (idtipo_personal, nombre, created_at, updated_at, deleted_at) FROM stdin;
1	Cajero	\N	\N	\N
2	Hornero	\N	\N	\N
3	Panadero	\N	\N	\N
4	Administrador	\N	\N	\N
5	Repartidor	\N	\N	\N
\.


--
-- TOC entry 3105 (class 0 OID 16847)
-- Dependencies: 244
-- Data for Name: unidad_medida; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unidad_medida (idunidad_medida, nombre, created_at, updated_at, deleted_at, abreviatura) FROM stdin;
1	Kilogramo	\N	\N	\N	Kg
2	Litro	\N	\N	\N	L
3	Gramos	\N	\N	\N	Gr
\.


--
-- TOC entry 3106 (class 0 OID 16851)
-- Dependencies: 245
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, deleted_at, fkidusuario) FROM stdin;
\.


--
-- TOC entry 3108 (class 0 OID 16859)
-- Dependencies: 247
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (idusuario, email, password, fkidcliente, fkidpersonal, created_at, updated_at, deleted_at, token) FROM stdin;
3	vasquez@gmail.com	123	\N	2	\N	\N	\N	\N
4	flores@gmail.com	admin123	\N	3	\N	\N	\N	\N
\.


--
-- TOC entry 3109 (class 0 OID 16866)
-- Dependencies: 248
-- Data for Name: venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venta (idventa, fecha_hora, total, fkidcliente, fkidusuario, fkidpedido, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- TOC entry 3120 (class 0 OID 0)
-- Dependencies: 202
-- Name: cliente_idcliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_idcliente_seq', 1, true);


--
-- TOC entry 3121 (class 0 OID 0)
-- Dependencies: 203
-- Name: compra_idcompra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compra_idcompra_seq', 6, true);


--
-- TOC entry 3122 (class 0 OID 0)
-- Dependencies: 224
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 3123 (class 0 OID 0)
-- Dependencies: 204
-- Name: ficha_produccion_idficha_produccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ficha_produccion_idficha_produccion_seq', 1, true);


--
-- TOC entry 3124 (class 0 OID 0)
-- Dependencies: 205
-- Name: insumo_idinsumo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.insumo_idinsumo_seq', 4, true);


--
-- TOC entry 3125 (class 0 OID 0)
-- Dependencies: 228
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 55, true);


--
-- TOC entry 3126 (class 0 OID 0)
-- Dependencies: 206
-- Name: pedido_idpedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_idpedido_seq', 1, false);


--
-- TOC entry 3127 (class 0 OID 0)
-- Dependencies: 207
-- Name: permiso_idpermiso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permiso_idpermiso_seq', 1, false);


--
-- TOC entry 3128 (class 0 OID 0)
-- Dependencies: 234
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- TOC entry 3129 (class 0 OID 0)
-- Dependencies: 208
-- Name: personal_idpersonal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_idpersonal_seq', 7, true);


--
-- TOC entry 3130 (class 0 OID 0)
-- Dependencies: 209
-- Name: producto_idproducto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producto_idproducto_seq', 3, true);


--
-- TOC entry 3131 (class 0 OID 0)
-- Dependencies: 210
-- Name: proveedor_idproveedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proveedor_idproveedor_seq', 4, true);


--
-- TOC entry 3132 (class 0 OID 0)
-- Dependencies: 211
-- Name: rol_idrol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rol_idrol_seq', 1, false);


--
-- TOC entry 3133 (class 0 OID 0)
-- Dependencies: 241
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 3134 (class 0 OID 0)
-- Dependencies: 212
-- Name: tipo_entrega_idtipo_entrega_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_entrega_idtipo_entrega_seq', 1, false);


--
-- TOC entry 3135 (class 0 OID 0)
-- Dependencies: 213
-- Name: tipo_personal_idtipo_personal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_personal_idtipo_personal_seq', 11, true);


--
-- TOC entry 3136 (class 0 OID 0)
-- Dependencies: 214
-- Name: unidad_medida_idunidad_medida_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unidad_medida_idunidad_medida_seq', 3, true);


--
-- TOC entry 3137 (class 0 OID 0)
-- Dependencies: 246
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 3138 (class 0 OID 0)
-- Dependencies: 215
-- Name: usuario_idusuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_idusuario_seq', 4, true);


--
-- TOC entry 3139 (class 0 OID 0)
-- Dependencies: 216
-- Name: venta_idventa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venta_idventa_seq', 1, false);


--
-- TOC entry 2856 (class 2606 OID 16876)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (idcategoria);


--
-- TOC entry 2868 (class 2606 OID 16878)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 2874 (class 2606 OID 16880)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 2877 (class 2606 OID 16882)
-- Name: model_has_permissions model_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);


--
-- TOC entry 2880 (class 2606 OID 16884)
-- Name: model_has_roles model_has_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);


--
-- TOC entry 2885 (class 2606 OID 16886)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2858 (class 2606 OID 16888)
-- Name: cliente pk_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT pk_cliente PRIMARY KEY (idcliente);


--
-- TOC entry 2860 (class 2606 OID 16890)
-- Name: compra pk_compra; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT pk_compra PRIMARY KEY (idcompra);


--
-- TOC entry 2862 (class 2606 OID 16892)
-- Name: detalle_compra pk_detalle_compra; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT pk_detalle_compra PRIMARY KEY (fkidinsumo, fkidcompra);


--
-- TOC entry 2864 (class 2606 OID 16894)
-- Name: detalle_produccion pk_detalle_produccion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_produccion
    ADD CONSTRAINT pk_detalle_produccion PRIMARY KEY (fkidficha_produccion, fkidinsumo);


--
-- TOC entry 2866 (class 2606 OID 16896)
-- Name: detalle_venta pk_detalle_venta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT pk_detalle_venta PRIMARY KEY (fkidproducto, fkidventa);


--
-- TOC entry 2870 (class 2606 OID 16898)
-- Name: ficha_produccion pk_ficha_produccion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ficha_produccion
    ADD CONSTRAINT pk_ficha_produccion PRIMARY KEY (idficha_produccion);


--
-- TOC entry 2872 (class 2606 OID 16900)
-- Name: insumo pk_insumo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insumo
    ADD CONSTRAINT pk_insumo PRIMARY KEY (idinsumo);


--
-- TOC entry 2883 (class 2606 OID 16902)
-- Name: pedido pk_pedido; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pk_pedido PRIMARY KEY (idpedido);


--
-- TOC entry 2887 (class 2606 OID 16904)
-- Name: personal pk_personal; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT pk_personal PRIMARY KEY (idpersonal);


--
-- TOC entry 2889 (class 2606 OID 16906)
-- Name: produccion_personal pk_produccion_personal; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produccion_personal
    ADD CONSTRAINT pk_produccion_personal PRIMARY KEY (fkidficha_produccion, fkidpersonal);


--
-- TOC entry 2891 (class 2606 OID 16908)
-- Name: producto pk_producto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT pk_producto PRIMARY KEY (idproducto);


--
-- TOC entry 2893 (class 2606 OID 16910)
-- Name: proveedor pk_proveedor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT pk_proveedor PRIMARY KEY (idproveedor);


--
-- TOC entry 2899 (class 2606 OID 16912)
-- Name: tipo_entrega pk_tipo_entrega; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_entrega
    ADD CONSTRAINT pk_tipo_entrega PRIMARY KEY (idtipo_entrega);


--
-- TOC entry 2901 (class 2606 OID 16914)
-- Name: tipo_personal pk_tipo_personal; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_personal
    ADD CONSTRAINT pk_tipo_personal PRIMARY KEY (idtipo_personal);


--
-- TOC entry 2903 (class 2606 OID 16916)
-- Name: unidad_medida pk_unidad_medida; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unidad_medida
    ADD CONSTRAINT pk_unidad_medida PRIMARY KEY (idunidad_medida);


--
-- TOC entry 2909 (class 2606 OID 16918)
-- Name: usuario pk_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (idusuario);


--
-- TOC entry 2913 (class 2606 OID 16920)
-- Name: venta pk_venta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT pk_venta PRIMARY KEY (idventa);


--
-- TOC entry 2895 (class 2606 OID 16922)
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);


--
-- TOC entry 2897 (class 2606 OID 16924)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 2905 (class 2606 OID 16926)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 2907 (class 2606 OID 16928)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2911 (class 2606 OID 16930)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 2875 (class 1259 OID 16931)
-- Name: model_has_permissions_model_id_model_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);


--
-- TOC entry 2878 (class 1259 OID 16932)
-- Name: model_has_roles_model_id_model_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);


--
-- TOC entry 2881 (class 1259 OID 16933)
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);


--
-- TOC entry 2914 (class 2606 OID 16934)
-- Name: compra fk_compra_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_compra_proveedor FOREIGN KEY (fkidproveedor) REFERENCES public.proveedor(idproveedor);


--
-- TOC entry 2915 (class 2606 OID 16939)
-- Name: detalle_compra fk_detalle_compra_compra; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_detalle_compra_compra FOREIGN KEY (fkidcompra) REFERENCES public.compra(idcompra);


--
-- TOC entry 2916 (class 2606 OID 16944)
-- Name: detalle_compra fk_detalle_compra_insumo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_detalle_compra_insumo FOREIGN KEY (fkidinsumo) REFERENCES public.insumo(idinsumo);


--
-- TOC entry 2917 (class 2606 OID 16949)
-- Name: detalle_produccion fk_detalle_produccion_ficha_produccion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_produccion
    ADD CONSTRAINT fk_detalle_produccion_ficha_produccion FOREIGN KEY (fkidficha_produccion) REFERENCES public.ficha_produccion(idficha_produccion);


--
-- TOC entry 2918 (class 2606 OID 16954)
-- Name: detalle_produccion fk_detalle_produccion_insumo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_produccion
    ADD CONSTRAINT fk_detalle_produccion_insumo FOREIGN KEY (fkidinsumo) REFERENCES public.insumo(idinsumo);


--
-- TOC entry 2919 (class 2606 OID 16959)
-- Name: detalle_venta fk_detalle_venta_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_detalle_venta_producto FOREIGN KEY (fkidproducto) REFERENCES public.producto(idproducto);


--
-- TOC entry 2920 (class 2606 OID 16964)
-- Name: detalle_venta fk_detalle_venta_venta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_detalle_venta_venta FOREIGN KEY (fkidventa) REFERENCES public.venta(idventa);


--
-- TOC entry 2921 (class 2606 OID 16969)
-- Name: ficha_produccion fk_ficha_produccion_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ficha_produccion
    ADD CONSTRAINT fk_ficha_produccion_producto FOREIGN KEY (fkidproducto) REFERENCES public.producto(idproducto);


--
-- TOC entry 2922 (class 2606 OID 16974)
-- Name: insumo fk_insumo_unidad_medida; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insumo
    ADD CONSTRAINT fk_insumo_unidad_medida FOREIGN KEY (fkidunidad_medida) REFERENCES public.unidad_medida(idunidad_medida);


--
-- TOC entry 2925 (class 2606 OID 16979)
-- Name: personal fk_personal_tipo_personal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT fk_personal_tipo_personal FOREIGN KEY (fkidtipo_personal) REFERENCES public.tipo_personal(idtipo_personal);


--
-- TOC entry 2926 (class 2606 OID 16984)
-- Name: produccion_personal fk_produccion_personal_ficha_produccion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produccion_personal
    ADD CONSTRAINT fk_produccion_personal_ficha_produccion FOREIGN KEY (fkidficha_produccion) REFERENCES public.ficha_produccion(idficha_produccion);


--
-- TOC entry 2927 (class 2606 OID 16989)
-- Name: produccion_personal fk_produccion_personal_personal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produccion_personal
    ADD CONSTRAINT fk_produccion_personal_personal FOREIGN KEY (fkidpersonal) REFERENCES public.personal(idpersonal);


--
-- TOC entry 2932 (class 2606 OID 16994)
-- Name: usuario fk_usuario_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_cliente FOREIGN KEY (fkidcliente) REFERENCES public.cliente(idcliente);


--
-- TOC entry 2933 (class 2606 OID 16999)
-- Name: usuario fk_usuario_personal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_personal FOREIGN KEY (fkidpersonal) REFERENCES public.personal(idpersonal);


--
-- TOC entry 2934 (class 2606 OID 17004)
-- Name: venta fk_venta_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (fkidcliente) REFERENCES public.cliente(idcliente);


--
-- TOC entry 2935 (class 2606 OID 17009)
-- Name: venta fk_venta_pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_pedido FOREIGN KEY (fkidpedido) REFERENCES public.pedido(idpedido);


--
-- TOC entry 2936 (class 2606 OID 17014)
-- Name: venta fk_venta_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_usuario FOREIGN KEY (fkidusuario) REFERENCES public.usuario(idusuario);


--
-- TOC entry 2923 (class 2606 OID 17019)
-- Name: model_has_permissions model_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- TOC entry 2924 (class 2606 OID 17024)
-- Name: model_has_roles model_has_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 2928 (class 2606 OID 17029)
-- Name: producto producto_fkidcategoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_fkidcategoria_fkey FOREIGN KEY (fkidcategoria) REFERENCES public.categoria(idcategoria) NOT VALID;


--
-- TOC entry 2929 (class 2606 OID 17034)
-- Name: role_has_permissions role_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- TOC entry 2930 (class 2606 OID 17039)
-- Name: role_has_permissions role_has_permissions_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 2931 (class 2606 OID 17044)
-- Name: users users_fkidusuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_fkidusuario_fkey FOREIGN KEY (fkidusuario) REFERENCES public.usuario(idusuario) NOT VALID;


-- Completed on 2020-09-14 08:33:59

--
-- PostgreSQL database dump complete
--

