toc.dat                                                                                             0000600 0004000 0002000 00000016617 13326340433 0014453 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       7    '                v            b2b-test    9.6.9    10.4      k           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false         l           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false         m           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false         n           1262    16393    b2b-test    DATABASE     �   CREATE DATABASE "b2b-test" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE "b2b-test";
             postgres    false                     2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false         o           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                     3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false         p           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1         �            1259    16460    images    TABLE     f   CREATE TABLE public.images (
    id integer NOT NULL,
    img_path character varying(255) NOT NULL
);
    DROP TABLE public.images;
       public         postgres    false    3         �            1259    16458    images_id_seq    SEQUENCE     v   CREATE SEQUENCE public.images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.images_id_seq;
       public       postgres    false    191    3         q           0    0    images_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;
            public       postgres    false    190         �            1259    16426    recipe    TABLE     �   CREATE TABLE public.recipe (
    id integer NOT NULL,
    name character varying(80) NOT NULL,
    text text,
    img integer,
    user_id integer
);
    DROP TABLE public.recipe;
       public         postgres    false    3         �            1259    16424    recipe_id_seq    SEQUENCE     v   CREATE SEQUENCE public.recipe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.recipe_id_seq;
       public       postgres    false    3    189         r           0    0    recipe_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.recipe_id_seq OWNED BY public.recipe.id;
            public       postgres    false    188         �            1259    16419    sessions    TABLE     �   CREATE TABLE public.sessions (
    session_id character varying(32) NOT NULL,
    session_exp integer NOT NULL,
    user_id integer
);
    DROP TABLE public.sessions;
       public         postgres    false    3         �            1259    16394    users    TABLE     �   CREATE TABLE public.users (
    username character varying(80) NOT NULL,
    password character varying(32) NOT NULL,
    id integer NOT NULL
);
    DROP TABLE public.users;
       public         postgres    false    3         �            1259    16399    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       postgres    false    185    3         s           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
            public       postgres    false    186         �           2604    16463 	   images id    DEFAULT     f   ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);
 8   ALTER TABLE public.images ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    190    191    191         �           2604    16429 	   recipe id    DEFAULT     f   ALTER TABLE ONLY public.recipe ALTER COLUMN id SET DEFAULT nextval('public.recipe_id_seq'::regclass);
 8   ALTER TABLE public.recipe ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    188    189    189         �           2604    16401    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    186    185         h          0    16460    images 
   TABLE DATA               .   COPY public.images (id, img_path) FROM stdin;
    public       postgres    false    191       2152.dat f          0    16426    recipe 
   TABLE DATA               >   COPY public.recipe (id, name, text, img, user_id) FROM stdin;
    public       postgres    false    189       2150.dat d          0    16419    sessions 
   TABLE DATA               D   COPY public.sessions (session_id, session_exp, user_id) FROM stdin;
    public       postgres    false    187       2148.dat b          0    16394    users 
   TABLE DATA               7   COPY public.users (username, password, id) FROM stdin;
    public       postgres    false    185       2146.dat t           0    0    images_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.images_id_seq', 5, true);
            public       postgres    false    190         u           0    0    recipe_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.recipe_id_seq', 35, true);
            public       postgres    false    188         v           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 19, true);
            public       postgres    false    186         �           2606    16465    images images_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.images DROP CONSTRAINT images_pkey;
       public         postgres    false    191         �           2606    16434    recipe recipe_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT recipe_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.recipe DROP CONSTRAINT recipe_pkey;
       public         postgres    false    189         �           2606    16423    sessions sessions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id);
 @   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
       public         postgres    false    187         �           2606    16406    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         postgres    false    185                                                                                                                         2152.dat                                                                                            0000600 0004000 0002000 00000000207 13326340433 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	https://yandex.ru/logo.png
2	38d311e12235d89c.jpg
3	7c988e314265a4ea.jpg
4	6025135e944dab9e.jpg
5	/uploads/c530af3254d470ce.jpg
\.


                                                                                                                                                                                                                                                                                                                                                                                         2150.dat                                                                                            0000600 0004000 0002000 00000000673 13326340433 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        18	88005553535		0	17
19	88005553535		0	17
20	88005553535		0	17
21	88005553535		0	17
22	88005553535		0	17
23	88005553535		0	17
24	88005553535		0	17
25	88005553535		0	17
26	88005553535		0	17
27	88005553535		0	17
28	88005553535		0	17
29	88005553535		0	17
30	88005553535		0	17
31	88005553535	asdasdasdasd	1	17
32	88005553535	asdasdasdasd	1	17
33	88005553535	asdasdasdasd	4	17
34	88005553535	asdasdasdasd	5	17
35	88005553535	asdasdasdasd	5	17
\.


                                                                     2148.dat                                                                                            0000600 0004000 0002000 00000000143 13326340433 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        3ff123c3ff544c1d6d9ec5f1e7e37937	1532603086	17
4c491a9209ccd5917138a200a6a73311	1532613018	17
\.


                                                                                                                                                                                                                                                                                                                                                                                                                             2146.dat                                                                                            0000600 0004000 0002000 00000000200 13326340433 0014237 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        asd	5f039b4ef0058a1d652f13d612375a5b	17
asd'	5f039b4ef0058a1d652f13d612375a5b	18
asd'"	5f039b4ef0058a1d652f13d612375a5b	19
\.


                                                                                                                                                                                                                                                                                                                                                                                                restore.sql                                                                                         0000600 0004000 0002000 00000014704 13326340433 0015373 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.9
-- Dumped by pg_dump version 10.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
ALTER TABLE ONLY public.recipe DROP CONSTRAINT recipe_pkey;
ALTER TABLE ONLY public.images DROP CONSTRAINT images_pkey;
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.recipe ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.images ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.users_id_seq;
DROP TABLE public.users;
DROP TABLE public.sessions;
DROP SEQUENCE public.recipe_id_seq;
DROP TABLE public.recipe;
DROP SEQUENCE public.images_id_seq;
DROP TABLE public.images;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    id integer NOT NULL,
    img_path character varying(255) NOT NULL
);


ALTER TABLE public.images OWNER TO postgres;

--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_id_seq OWNER TO postgres;

--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;


--
-- Name: recipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipe (
    id integer NOT NULL,
    name character varying(80) NOT NULL,
    text text,
    img integer,
    user_id integer
);


ALTER TABLE public.recipe OWNER TO postgres;

--
-- Name: recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recipe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recipe_id_seq OWNER TO postgres;

--
-- Name: recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recipe_id_seq OWNED BY public.recipe.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    session_id character varying(32) NOT NULL,
    session_exp integer NOT NULL,
    user_id integer
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    username character varying(80) NOT NULL,
    password character varying(32) NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
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
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);


--
-- Name: recipe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe ALTER COLUMN id SET DEFAULT nextval('public.recipe_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (id, img_path) FROM stdin;
\.
COPY public.images (id, img_path) FROM '$$PATH$$/2152.dat';

--
-- Data for Name: recipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipe (id, name, text, img, user_id) FROM stdin;
\.
COPY public.recipe (id, name, text, img, user_id) FROM '$$PATH$$/2150.dat';

--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (session_id, session_exp, user_id) FROM stdin;
\.
COPY public.sessions (session_id, session_exp, user_id) FROM '$$PATH$$/2148.dat';

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (username, password, id) FROM stdin;
\.
COPY public.users (username, password, id) FROM '$$PATH$$/2146.dat';

--
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_id_seq', 5, true);


--
-- Name: recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recipe_id_seq', 35, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 19, true);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: recipe recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT recipe_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            