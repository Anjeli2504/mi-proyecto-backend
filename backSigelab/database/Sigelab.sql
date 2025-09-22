--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-06-05 21:34:33

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 220 (class 1259 OID 65649)
-- Name: eventos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eventos (
    id integer NOT NULL,
    titulo character varying(150) NOT NULL,
    descripcion text,
    fecha timestamp without time zone NOT NULL,
    ubicacion character varying(150),
    creado_por integer,
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    mapa text
);


ALTER TABLE public.eventos OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 65648)
-- Name: eventos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eventos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.eventos_id_seq OWNER TO postgres;

--
-- TOC entry 4852 (class 0 OID 0)
-- Dependencies: 219
-- Name: eventos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eventos_id_seq OWNED BY public.eventos.id;


--
-- TOC entry 226 (class 1259 OID 73814)
-- Name: ferias_aplicadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ferias_aplicadas (
    id integer NOT NULL,
    users_id integer NOT NULL,
    eventos_id integer NOT NULL,
    formulario jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cedula integer
);


ALTER TABLE public.ferias_aplicadas OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 73813)
-- Name: ferias_aplicadas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ferias_aplicadas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ferias_aplicadas_id_seq OWNER TO postgres;

--
-- TOC entry 4853 (class 0 OID 0)
-- Dependencies: 225
-- Name: ferias_aplicadas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ferias_aplicadas_id_seq OWNED BY public.ferias_aplicadas.id;


--
-- TOC entry 222 (class 1259 OID 73770)
-- Name: ofertas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ofertas (
    id integer NOT NULL,
    puesto character varying(100) NOT NULL,
    empresa character varying(100) NOT NULL,
    requerimientos text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    creado_por integer
);


ALTER TABLE public.ofertas OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 73782)
-- Name: ofertas_aplicadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ofertas_aplicadas (
    id integer NOT NULL,
    usuario_id integer,
    oferta_id integer,
    cv_url text,
    applied_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ofertas_aplicadas OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 73781)
-- Name: ofertas_aplicadas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ofertas_aplicadas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ofertas_aplicadas_id_seq OWNER TO postgres;

--
-- TOC entry 4854 (class 0 OID 0)
-- Dependencies: 223
-- Name: ofertas_aplicadas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ofertas_aplicadas_id_seq OWNED BY public.ofertas_aplicadas.id;


--
-- TOC entry 221 (class 1259 OID 73769)
-- Name: ofertas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ofertas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ofertas_id_seq OWNER TO postgres;

--
-- TOC entry 4855 (class 0 OID 0)
-- Dependencies: 221
-- Name: ofertas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ofertas_id_seq OWNED BY public.ofertas.id;


--
-- TOC entry 218 (class 1259 OID 65636)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password text NOT NULL,
    rol character varying(20) NOT NULL,
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    discapacidad character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_rol_check CHECK (((rol)::text = ANY ((ARRAY['ADMIN'::character varying, 'USUARIO'::character varying, 'EMPRESA'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 65635)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4856 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4664 (class 2604 OID 65652)
-- Name: eventos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventos ALTER COLUMN id SET DEFAULT nextval('public.eventos_id_seq'::regclass);


--
-- TOC entry 4670 (class 2604 OID 73817)
-- Name: ferias_aplicadas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ferias_aplicadas ALTER COLUMN id SET DEFAULT nextval('public.ferias_aplicadas_id_seq'::regclass);


--
-- TOC entry 4666 (class 2604 OID 73773)
-- Name: ofertas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertas ALTER COLUMN id SET DEFAULT nextval('public.ofertas_id_seq'::regclass);


--
-- TOC entry 4668 (class 2604 OID 73785)
-- Name: ofertas_aplicadas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertas_aplicadas ALTER COLUMN id SET DEFAULT nextval('public.ofertas_aplicadas_id_seq'::regclass);


--
-- TOC entry 4661 (class 2604 OID 65639)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4840 (class 0 OID 65649)
-- Dependencies: 220
-- Data for Name: eventos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eventos (id, titulo, descripcion, fecha, ubicacion, creado_por, creado_en, mapa) FROM stdin;
3	Expo-Feria 2025	Mas de 100 vacantes en el ámbito de seguridad con preferencias para personas con discapacidad	2025-08-07 00:00:00	Centro de Convenciones de la Universidad del Atlántico	\N	2025-06-03 11:10:50.990609	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d62659.966763203585!2d-74.94534015655519!3d11.020016339690022!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8ef42c760e5a4201%3A0xd6d36d10c819f600!2sCentro%20de%20Convenciones%20de%20la%20Universidad%20del%20Atl%C3%A1ntico!5e0!3m2!1ses!2sco!4v1748967013232!5m2!1ses!2sco
1	Feria Profesional	Durante 2 días estaremos ofreciendo 150 vacantes con preferencia en personas con discapacidad	2025-06-25 09:00:00	Universidad del Norte	\N	2025-06-01 11:06:56.841393	\N
2	Mega Feria Inclusiva 2025	Gracias a convenios con distintas empresas de barranquilla, ofrecemos 300 vacantes con preferencia en personas discapacitadas 	2025-07-05 10:30:00	Centro de Convenciones Puerta de Oro	\N	2025-06-01 16:05:13.636313	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d62658.98283538931!2d-74.87242117832032!3d11.024635300000014!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8ef42d684acbef63%3A0xd9d15451a605fa2d!2sCentro%20de%20Convenciones%20Puerta%20de%20Oro!5e0!3m2!1ses!2sco!4v1748814133054!5m2!1ses!2sco
4	Feria por la igualdad	Mas de 50 vacantes en distintos campos laborales podemos ofrecerles para cambiar vidas	2025-08-30 00:00:00	Coliseo Los Fundadores	\N	2025-06-05 02:08:15.455137	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3916.2404655181927!2d-74.85282332616379!3d11.020576554645293!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8ef42c41e74d156f%3A0xfe1ae3b088118063!2sColiseo%20Los%20Fundadores!5e0!3m2!1ses!2sco!4v1749105945407!5m2!1ses!2sco
\.


--
-- TOC entry 4846 (class 0 OID 73814)
-- Dependencies: 226
-- Data for Name: ferias_aplicadas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ferias_aplicadas (id, users_id, eventos_id, formulario, created_at, cedula) FROM stdin;
1	19	3	{"cedula": "104685233", "nombre": "Anjeli Reyes", "telefono": "3147223062"}	2025-06-03 22:25:18.071859	104685233
4	19	2	{"cedula": "10462285223", "nombre": "Anjeli Reyes", "telefono": "3147223062"}	2025-06-04 00:20:59.055208	\N
5	1	2	{"cedula": "1042243665", "nombre": "Jesus Parra", "telefono": "3045793560"}	2025-06-04 11:32:12.451829	\N
11	1	3	{"cedula": "304579356'", "nombre": "Jesus Parra", "telefono": "3045793560"}	2025-06-04 20:22:32.46167	\N
12	23	2	{"cedula": "1042243665", "nombre": "Jesus Alonso", "telefono": "3045793560"}	2025-06-05 01:00:42.576825	\N
13	25	3	{"cedula": "1045664646", "nombre": "Jesus Parra", "telefono": "3454664546464"}	2025-06-05 02:06:38.141076	\N
\.


--
-- TOC entry 4842 (class 0 OID 73770)
-- Dependencies: 222
-- Data for Name: ofertas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ofertas (id, puesto, empresa, requerimientos, created_at, creado_por) FROM stdin;
1	Desarrollador Frontend	Tech Solutions	Angular, Material, APIs REST	2025-05-29 22:56:58.105981	\N
2	Servicios Generales	Job&Talent	Educación mínima: Bachillerato / Educación Media	2025-06-02 19:12:08.710257	\N
3	Operador de Atención al Cliente	Job&Talent	Secundaria completa, buena dicción y paciencia para atender clientes, disponibilidad de 4-6 horas diarias 	2025-06-02 23:44:34.965341	22
4	Aseador	Job&Talent	Conocimiento básico de productos de limpieza y su uso seguro, Capacidad para seguir instrucciones y protocolos de limpieza y puntualidad\n\nReferencias laborales: Al menos 1 referencias de trabajos anteriores	2025-06-04 12:33:22.616559	22
5	Redactor	Job&Talent	Experencia o buen conocimiento y manejo de la comprensión lectora, habilidades de investigación y buen manejo de herramientas digitales 	2025-06-05 02:09:32.618545	22
\.


--
-- TOC entry 4844 (class 0 OID 73782)
-- Dependencies: 224
-- Data for Name: ofertas_aplicadas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ofertas_aplicadas (id, usuario_id, oferta_id, cv_url, applied_at) FROM stdin;
1	1	3	/uploads/cv/1748977718747-HOJA-DE-VIDA-JESUS-PARRA-(2).pdf	2025-06-03 14:08:38.845946
2	1	2	/uploads/cv/1748978567056-HOJA-DE-VIDA-JESUS-PARRA-(2).pdf	2025-06-03 14:22:47.120868
3	19	1	/uploads/cv/1748979604458-HOJA-DE-VIDA-JESUS-PARRA-(2).pdf	2025-06-03 14:40:04.518811
4	19	3	/uploads/cv/1748980782045-HOJA-DE-VIDA-JESUS-PARRA-(2).pdf	2025-06-03 14:59:42.114576
5	1	1	/uploads/cv/1749049553373-HOJA-DE-VIDA-JESUS-PARRA-(2).pdf	2025-06-04 10:05:53.440415
6	1	4	/uploads/cv/1749058449134-HOJA-DE-VIDA-JESUS-PARRA-(2).pdf	2025-06-04 12:34:09.307036
7	23	3	/uploads/cv/1749103364534-HOJA-DE-VIDA-JESUS-PARRA-(2).pdf	2025-06-05 01:02:45.117557
8	25	3	/uploads/cv/1749107228275-HOJA-DE-VIDA-JESUS-PARRA-(2).pdf	2025-06-05 02:07:08.35062
\.


--
-- TOC entry 4838 (class 0 OID 65636)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, nombre, email, password, rol, creado_en, discapacidad, created_at) FROM stdin;
1	Jesus Parra	Jesus@gmail.com	$2b$10$I.r/Lnak76Dfs4WbS501COMYPBZUy.ygFUPIViJ06LftVx/xj9rj6	USUARIO	2025-05-24 23:49:36.115114	\N	2025-06-01 13:46:00.529124
7	Piedad Alonso	Piedad@gmail.com	$2b$10$oXjpDa2l8expfeVOSspyxuSnoCRgydnMyAGI6byOTxWK2tZMvAPgi	USUARIO	2025-05-29 20:50:41.087829	Cognitiva	2025-06-01 13:46:00.529124
9	Leonardo 	Leo@gmail.com	$2b$10$Eiwym0nhSiVq467Tn06mlOjJ.aOT3grt4X1rGXvtcnkFnqKdSIs02	USUARIO	2025-05-30 15:18:53.616491	\N	2025-06-01 13:46:00.529124
10	Administrado	admin@sigelab.com	$2b$10$IH.cutAlNarIDjc0OIyTce.fXnilAvXpo800IAxVFtmWJ1fgwTdgC	ADMIN	2025-05-30 16:06:33.395807	\N	2025-06-01 13:46:00.529124
11	Administrador2	admin2@sigelab.com	$2b$10$/nXDrek3p2IxCRWUmBBzI.dVdn1IhHgx6SFiVKbDMIvY2E8qlqRie	ADMIN	2025-05-30 16:31:34.802677	\N	2025-06-01 13:46:00.529124
16	Piedad	piedadalonsocolina@gmail.com	$2b$10$PEuO3GLikWDc73Duy.JAAewehfZoeLM6SwtVIngmo0zNuY1IicFFi	USUARIO	2025-06-01 10:33:30.627456	\N	2025-06-01 13:46:00.529124
18	Jesus	j26378720@gmail.com	$2b$10$WJ3/odxTkStMQz4223Wp8erv7msHMsRSNcYHCkT5/82TedF6creDK	USUARIO	2025-06-01 12:31:59.323928	\N	2025-06-01 13:46:00.529124
19	Anjeli Reyes	anjelirh2505@gmail.com	$2b$10$l6j0MhJPkKkw6E9YOovhW.mKYUuVKixogDg71GOyvsneBiP6qB4Ee	USUARIO	2025-06-01 17:33:11.416149	\N	2025-06-01 17:33:11.416149
20	Andrés Vergara	Andresvergara1045@gmail.com	$2b$10$ecsSEY1mLzojPQv5X0nrEOL0qrsu7PiPprFF0FsxwnFXzbWTzpDXG	USUARIO	2025-06-01 17:40:21.723509	\N	2025-06-01 17:40:21.723509
22	Empresa S.A.	empresa@correo.com	$2b$10$23DYCckRU4Sc6tYyvsdi4.Xa28/4XFL7niH3DSSBOFyf4dOTlgpIi	EMPRESA	2025-06-02 17:40:06.195422	\N	2025-06-02 17:40:06.195422
23	Jesus Alonso	Jesusdparraa2004@gmail.com	$2b$10$ItdhnGY1e84yffb.urM7hOs/H5kBI.RaLXr2.dni/xcp0/THV0zv2	USUARIO	2025-06-05 00:58:53.504506	\N	2025-06-05 00:58:53.504506
25	Jesus Parra	Jesusdpa2004@gmail.com	$2b$10$uxu2Ih0rGnl7pUmQ/XB1fOS4Aelb7YpLFOOuha05Kzp0WtvwtHOqa	USUARIO	2025-06-05 02:05:42.363013	\N	2025-06-05 02:05:42.363013
\.


--
-- TOC entry 4857 (class 0 OID 0)
-- Dependencies: 219
-- Name: eventos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eventos_id_seq', 4, true);


--
-- TOC entry 4858 (class 0 OID 0)
-- Dependencies: 225
-- Name: ferias_aplicadas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ferias_aplicadas_id_seq', 13, true);


--
-- TOC entry 4859 (class 0 OID 0)
-- Dependencies: 223
-- Name: ofertas_aplicadas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ofertas_aplicadas_id_seq', 8, true);


--
-- TOC entry 4860 (class 0 OID 0)
-- Dependencies: 221
-- Name: ofertas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ofertas_id_seq', 37, true);


--
-- TOC entry 4861 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 25, true);


--
-- TOC entry 4678 (class 2606 OID 65657)
-- Name: eventos eventos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventos
    ADD CONSTRAINT eventos_pkey PRIMARY KEY (id);


--
-- TOC entry 4684 (class 2606 OID 73822)
-- Name: ferias_aplicadas ferias_aplicadas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ferias_aplicadas
    ADD CONSTRAINT ferias_aplicadas_pkey PRIMARY KEY (id);


--
-- TOC entry 4686 (class 2606 OID 73824)
-- Name: ferias_aplicadas ferias_aplicadas_users_id_eventos_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ferias_aplicadas
    ADD CONSTRAINT ferias_aplicadas_users_id_eventos_id_key UNIQUE (users_id, eventos_id);


--
-- TOC entry 4682 (class 2606 OID 73790)
-- Name: ofertas_aplicadas ofertas_aplicadas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertas_aplicadas
    ADD CONSTRAINT ofertas_aplicadas_pkey PRIMARY KEY (id);


--
-- TOC entry 4680 (class 2606 OID 73778)
-- Name: ofertas ofertas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertas
    ADD CONSTRAINT ofertas_pkey PRIMARY KEY (id);


--
-- TOC entry 4674 (class 2606 OID 65647)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4676 (class 2606 OID 65645)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4687 (class 2606 OID 65658)
-- Name: eventos eventos_creado_por_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventos
    ADD CONSTRAINT eventos_creado_por_fkey FOREIGN KEY (creado_por) REFERENCES public.users(id);


--
-- TOC entry 4690 (class 2606 OID 73830)
-- Name: ferias_aplicadas fk_eventos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ferias_aplicadas
    ADD CONSTRAINT fk_eventos FOREIGN KEY (eventos_id) REFERENCES public.eventos(id) ON DELETE CASCADE;


--
-- TOC entry 4691 (class 2606 OID 73825)
-- Name: ferias_aplicadas fk_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ferias_aplicadas
    ADD CONSTRAINT fk_users FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4688 (class 2606 OID 73796)
-- Name: ofertas_aplicadas ofertas_aplicadas_oferta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertas_aplicadas
    ADD CONSTRAINT ofertas_aplicadas_oferta_id_fkey FOREIGN KEY (oferta_id) REFERENCES public.ofertas(id);


--
-- TOC entry 4689 (class 2606 OID 73791)
-- Name: ofertas_aplicadas ofertas_aplicadas_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertas_aplicadas
    ADD CONSTRAINT ofertas_aplicadas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.users(id);


-- Completed on 2025-06-05 21:34:33

--
-- PostgreSQL database dump complete
--

