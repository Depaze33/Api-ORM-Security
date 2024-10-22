--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8 (Debian 15.8-1.pgdg120+1)
-- Dumped by pg_dump version 15.3

-- Started on 2024-10-22 15:52:52

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

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 222 (class 1255 OID 16408)
-- Name: create_accounts(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.create_accounts()
    LANGUAGE plpgsql
    AS $$
BEGIN
    FOR i IN 1..200 LOOP
            INSERT INTO public.account (creationtime, balance, active, id_client)
            VALUES (
                               current_timestamp,
                               1000 * i,
                               true,
                               (SELECT id FROM public."client" OFFSET floor(random() * (SELECT COUNT(*) FROM public."client")) LIMIT 1)
                   );
        END LOOP;
END;
$$;


ALTER PROCEDURE public.create_accounts() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16391)
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    id integer NOT NULL,
    creation_time timestamp without time zone,
    balance bigint,
    id_client uuid,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.account OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16390)
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_id_seq OWNER TO postgres;

--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 215
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_id_seq OWNED BY public.account.id;


--
-- TOC entry 214 (class 1259 OID 16385)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id uuid NOT NULL,
    first_name character varying(100),
    last_name character varying(50),
    email character varying(50),
    birthdate date
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16432)
-- Name: insurance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.insurance (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    client_id uuid
);


ALTER TABLE public.insurance OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16431)
-- Name: insurance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.insurance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.insurance_id_seq OWNER TO postgres;

--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 217
-- Name: insurance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.insurance_id_seq OWNED BY public.insurance.id;


--
-- TOC entry 219 (class 1259 OID 16443)
-- Name: subscribe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscribe (
    client_id uuid NOT NULL,
    insurance_id integer NOT NULL
);


ALTER TABLE public.subscribe OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16459)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    full_name character varying(200) NOT NULL,
    email character varying(1000) NOT NULL,
    pass character varying(100) NOT NULL,
    created_at date DEFAULT now(),
    updated_at date DEFAULT now()
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16458)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 220
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 3218 (class 2604 OID 16394)
-- Name: account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account ALTER COLUMN id SET DEFAULT nextval('public.account_id_seq'::regclass);


--
-- TOC entry 3220 (class 2604 OID 16435)
-- Name: insurance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insurance ALTER COLUMN id SET DEFAULT nextval('public.insurance_id_seq'::regclass);


--
-- TOC entry 3221 (class 2604 OID 16462)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 3382 (class 0 OID 16391)
-- Dependencies: 216
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account (id, creation_time, balance, id_client, active) FROM stdin;
1	2024-10-17 13:47:50.677106	1000	163204ca-22ee-428d-b1f8-451cd1a59974	t
2	2024-10-17 13:47:50.677106	2000	96ef444e-ecba-4f3e-b6be-4aeacd91b30c	t
3	2024-10-17 13:47:50.677106	3000	0f857d95-c7ee-48da-91f7-67fcb151fffa	t
4	2024-10-17 13:47:50.677106	4000	aaf8b71e-80b9-46db-8c7d-d977142cb5ef	t
5	2024-10-17 13:47:50.677106	5000	f059341e-1fb0-496f-a5c6-d1b416eebdbc	t
6	2024-10-17 13:47:50.677106	6000	d2899a7d-67d6-447a-9723-51b483ddbaf7	t
7	2024-10-17 13:47:50.677106	7000	52b9477e-0402-457d-bdbe-52f68d98da71	t
8	2024-10-17 13:47:50.677106	8000	1503eabe-2aed-4673-a681-6d2cd9771d21	t
9	2024-10-17 13:47:50.677106	9000	96ef444e-ecba-4f3e-b6be-4aeacd91b30c	t
10	2024-10-17 13:47:50.677106	10000	6a1dd4b8-d07c-45a4-960d-11e038025cb5	t
11	2024-10-17 13:47:50.677106	11000	d2899a7d-67d6-447a-9723-51b483ddbaf7	t
12	2024-10-17 13:47:50.677106	12000	bd95d21e-58da-4d6f-aeb1-da6db9d9ce5f	t
13	2024-10-17 13:47:50.677106	13000	79738eba-835b-4fc1-bfc5-1ba3b444f9e2	t
14	2024-10-17 13:47:50.677106	14000	c592c81b-4cea-4ce9-b327-569abde72d45	t
15	2024-10-17 13:47:50.677106	15000	4f2277df-f770-4a7e-bae2-f49eafc6afe0	t
16	2024-10-17 13:47:50.677106	16000	c1664585-a364-43c8-a668-9bdb5ae36a0c	t
17	2024-10-17 13:47:50.677106	17000	ec45ecf1-e11e-40ce-b12e-a392c98856d2	t
18	2024-10-17 13:47:50.677106	18000	6bb4ff8f-ac82-4bb5-91a9-7c5ab3f13a4d	t
19	2024-10-17 13:47:50.677106	19000	5c8fcf04-6271-49db-8563-1fa53e3ae3a0	t
20	2024-10-17 13:47:50.677106	20000	ab50c6cd-3cfb-4063-bf06-d10067f46d2c	t
21	2024-10-17 13:47:50.677106	21000	89dde868-2e58-4dd0-903d-f1eaf7c6a152	t
22	2024-10-17 13:47:50.677106	22000	1c8ee013-7e03-455c-839c-543d18e80886	t
23	2024-10-17 13:47:50.677106	23000	bd95d21e-58da-4d6f-aeb1-da6db9d9ce5f	t
24	2024-10-17 13:47:50.677106	24000	50043d19-7569-4b4d-b68d-21248a770fa5	t
25	2024-10-17 13:47:50.677106	25000	061e4288-8955-4b8f-9272-e89e54101092	t
26	2024-10-17 13:47:50.677106	26000	4f2277df-f770-4a7e-bae2-f49eafc6afe0	t
27	2024-10-17 13:47:50.677106	27000	80f690d9-fedc-4fdb-900f-0b52650671e4	t
28	2024-10-17 13:47:50.677106	28000	34d16ed6-ba12-4daf-9b96-f8501522c459	t
29	2024-10-17 13:47:50.677106	29000	bd95d21e-58da-4d6f-aeb1-da6db9d9ce5f	t
30	2024-10-17 13:47:50.677106	30000	50043d19-7569-4b4d-b68d-21248a770fa5	t
31	2024-10-17 13:47:50.677106	31000	678091ae-4c9c-4c24-9f47-a9496d6ffca6	t
32	2024-10-17 13:47:50.677106	32000	a770a0b5-fa84-494e-81d9-2e83bd896eb4	t
33	2024-10-17 13:47:50.677106	33000	a8cff319-d1c2-428c-9b3c-a1d8b21ac011	t
34	2024-10-17 13:47:50.677106	34000	bf11282f-4156-4833-9305-d652ef38e7b5	t
35	2024-10-17 13:47:50.677106	35000	678091ae-4c9c-4c24-9f47-a9496d6ffca6	t
36	2024-10-17 13:47:50.677106	36000	5c8fcf04-6271-49db-8563-1fa53e3ae3a0	t
37	2024-10-17 13:47:50.677106	37000	061e4288-8955-4b8f-9272-e89e54101092	t
38	2024-10-17 13:47:50.677106	38000	163204ca-22ee-428d-b1f8-451cd1a59974	t
39	2024-10-17 13:47:50.677106	39000	e318e9b4-d6cc-4040-8f5c-83fa6352a325	t
40	2024-10-17 13:47:50.677106	40000	678091ae-4c9c-4c24-9f47-a9496d6ffca6	t
41	2024-10-17 13:47:50.677106	41000	ec45ecf1-e11e-40ce-b12e-a392c98856d2	t
42	2024-10-17 13:47:50.677106	42000	305b9bc4-a229-4001-b699-684e3915b433	t
43	2024-10-17 13:47:50.677106	43000	50043d19-7569-4b4d-b68d-21248a770fa5	t
44	2024-10-17 13:47:50.677106	44000	6a1dd4b8-d07c-45a4-960d-11e038025cb5	t
45	2024-10-17 13:47:50.677106	45000	a0c4ed9d-a6c6-4139-ad78-256a198fd0ae	t
46	2024-10-17 13:47:50.677106	46000	ec45ecf1-e11e-40ce-b12e-a392c98856d2	t
47	2024-10-17 13:47:50.677106	47000	a0c4ed9d-a6c6-4139-ad78-256a198fd0ae	t
48	2024-10-17 13:47:50.677106	48000	7689fc83-0bf4-4452-82d5-f2735d292933	t
49	2024-10-17 13:47:50.677106	49000	061e4288-8955-4b8f-9272-e89e54101092	t
50	2024-10-17 13:47:50.677106	50000	e318e9b4-d6cc-4040-8f5c-83fa6352a325	t
51	2024-10-17 13:47:50.677106	51000	061e4288-8955-4b8f-9272-e89e54101092	t
52	2024-10-17 13:47:50.677106	52000	6bb4ff8f-ac82-4bb5-91a9-7c5ab3f13a4d	t
53	2024-10-17 13:47:50.677106	53000	5c8fcf04-6271-49db-8563-1fa53e3ae3a0	t
54	2024-10-17 13:47:50.677106	54000	7f4d1315-6725-4aae-9037-2d13218e1ae9	t
55	2024-10-17 13:47:50.677106	55000	f059341e-1fb0-496f-a5c6-d1b416eebdbc	t
56	2024-10-17 13:47:50.677106	56000	305b9bc4-a229-4001-b699-684e3915b433	t
57	2024-10-17 13:47:50.677106	57000	45368c39-a4c6-4352-b9c7-f91633c5261b	t
58	2024-10-17 13:47:50.677106	58000	2ac379e9-bd83-42d5-b56a-26b99ee7cb2f	t
59	2024-10-17 13:47:50.677106	59000	aaf8b71e-80b9-46db-8c7d-d977142cb5ef	t
60	2024-10-17 13:47:50.677106	60000	80ab47ac-201f-4628-a26e-3e74f701919c	t
61	2024-10-17 13:47:50.677106	61000	7f4d1315-6725-4aae-9037-2d13218e1ae9	t
62	2024-10-17 13:47:50.677106	62000	8b953915-2a76-4598-a5cd-1907c04d8ab5	t
63	2024-10-17 13:47:50.677106	63000	0f857d95-c7ee-48da-91f7-67fcb151fffa	t
64	2024-10-17 13:47:50.677106	64000	6c8018d3-4cc4-4d5d-be06-388ceecb231b	t
65	2024-10-17 13:47:50.677106	65000	6e57b73c-256b-4ae8-b238-1496e17dceb6	t
66	2024-10-17 13:47:50.677106	66000	ec45ecf1-e11e-40ce-b12e-a392c98856d2	t
67	2024-10-17 13:47:50.677106	67000	9f018761-03b8-483f-aaf9-1d461b5e7da1	t
68	2024-10-17 13:47:50.677106	68000	c1664585-a364-43c8-a668-9bdb5ae36a0c	t
69	2024-10-17 13:47:50.677106	69000	a0c4ed9d-a6c6-4139-ad78-256a198fd0ae	t
70	2024-10-17 13:47:50.677106	70000	7689fc83-0bf4-4452-82d5-f2735d292933	t
71	2024-10-17 13:47:50.677106	71000	c5732695-24d2-4419-8bdf-ff8662e94396	t
72	2024-10-17 13:47:50.677106	72000	105a8f37-54f5-43c8-a57e-a113b33ad831	t
73	2024-10-17 13:47:50.677106	73000	45368c39-a4c6-4352-b9c7-f91633c5261b	t
74	2024-10-17 13:47:50.677106	74000	9ce519f0-1cad-471f-9b36-eded31f91956	t
75	2024-10-17 13:47:50.677106	75000	ab50c6cd-3cfb-4063-bf06-d10067f46d2c	t
76	2024-10-17 13:47:50.677106	76000	e318e9b4-d6cc-4040-8f5c-83fa6352a325	t
77	2024-10-17 13:47:50.677106	77000	5c8fcf04-6271-49db-8563-1fa53e3ae3a0	t
78	2024-10-17 13:47:50.677106	78000	6a1489d1-f6b5-48f7-b46b-7f967f120fbc	t
79	2024-10-17 13:47:50.677106	79000	79738eba-835b-4fc1-bfc5-1ba3b444f9e2	t
80	2024-10-17 13:47:50.677106	80000	e318e9b4-d6cc-4040-8f5c-83fa6352a325	t
81	2024-10-17 13:47:50.677106	81000	061e4288-8955-4b8f-9272-e89e54101092	t
82	2024-10-17 13:47:50.677106	82000	1c8ee013-7e03-455c-839c-543d18e80886	t
83	2024-10-17 13:47:50.677106	83000	a678c7f0-86c2-4fca-aaec-874b4567d753	t
84	2024-10-17 13:47:50.677106	84000	163204ca-22ee-428d-b1f8-451cd1a59974	t
85	2024-10-17 13:47:50.677106	85000	a770a0b5-fa84-494e-81d9-2e83bd896eb4	t
86	2024-10-17 13:47:50.677106	86000	a678c7f0-86c2-4fca-aaec-874b4567d753	t
87	2024-10-17 13:47:50.677106	87000	79738eba-835b-4fc1-bfc5-1ba3b444f9e2	t
88	2024-10-17 13:47:50.677106	88000	b351cbf7-9cd3-41f1-8859-b079593b51df	t
89	2024-10-17 13:47:50.677106	89000	7f4d1315-6725-4aae-9037-2d13218e1ae9	t
90	2024-10-17 13:47:50.677106	90000	6a1dd4b8-d07c-45a4-960d-11e038025cb5	t
91	2024-10-17 13:47:50.677106	91000	f059341e-1fb0-496f-a5c6-d1b416eebdbc	t
92	2024-10-17 13:47:50.677106	92000	4865a438-13d7-48e7-9c26-e52547b18c48	t
93	2024-10-17 13:47:50.677106	93000	52b9477e-0402-457d-bdbe-52f68d98da71	t
94	2024-10-17 13:47:50.677106	94000	aaf8b71e-80b9-46db-8c7d-d977142cb5ef	t
95	2024-10-17 13:47:50.677106	95000	0d2ab408-7b94-42f0-ac5e-5a5cd117e786	t
96	2024-10-17 13:47:50.677106	96000	80f690d9-fedc-4fdb-900f-0b52650671e4	t
97	2024-10-17 13:47:50.677106	97000	4f2277df-f770-4a7e-bae2-f49eafc6afe0	t
98	2024-10-17 13:47:50.677106	98000	503354a6-ea60-4d72-afce-6e39ca481f3a	t
99	2024-10-17 13:47:50.677106	99000	f059341e-1fb0-496f-a5c6-d1b416eebdbc	t
100	2024-10-17 13:47:50.677106	100000	96ef444e-ecba-4f3e-b6be-4aeacd91b30c	t
101	2024-10-17 13:47:50.677106	101000	a8cff319-d1c2-428c-9b3c-a1d8b21ac011	t
102	2024-10-17 13:47:50.677106	102000	96ef444e-ecba-4f3e-b6be-4aeacd91b30c	t
103	2024-10-17 13:47:50.677106	103000	0f857d95-c7ee-48da-91f7-67fcb151fffa	t
104	2024-10-17 13:47:50.677106	104000	3badad53-def1-4e7a-8472-404301d080e1	t
105	2024-10-17 13:47:50.677106	105000	305b9bc4-a229-4001-b699-684e3915b433	t
106	2024-10-17 13:47:50.677106	106000	a07ed2fb-1fd3-4d01-9a0f-5510431035b8	t
107	2024-10-17 13:47:50.677106	107000	6e57b73c-256b-4ae8-b238-1496e17dceb6	t
108	2024-10-17 13:47:50.677106	108000	6a1489d1-f6b5-48f7-b46b-7f967f120fbc	t
109	2024-10-17 13:47:50.677106	109000	ec45ecf1-e11e-40ce-b12e-a392c98856d2	t
110	2024-10-17 13:47:50.677106	110000	105a8f37-54f5-43c8-a57e-a113b33ad831	t
111	2024-10-17 13:47:50.677106	111000	6e57b73c-256b-4ae8-b238-1496e17dceb6	t
112	2024-10-17 13:47:50.677106	112000	c592c81b-4cea-4ce9-b327-569abde72d45	t
113	2024-10-17 13:47:50.677106	113000	6e57b73c-256b-4ae8-b238-1496e17dceb6	t
114	2024-10-17 13:47:50.677106	114000	e318e9b4-d6cc-4040-8f5c-83fa6352a325	t
115	2024-10-17 13:47:50.677106	115000	678091ae-4c9c-4c24-9f47-a9496d6ffca6	t
116	2024-10-17 13:47:50.677106	116000	4f2277df-f770-4a7e-bae2-f49eafc6afe0	t
117	2024-10-17 13:47:50.677106	117000	ec45ecf1-e11e-40ce-b12e-a392c98856d2	t
118	2024-10-17 13:47:50.677106	118000	a678c7f0-86c2-4fca-aaec-874b4567d753	t
119	2024-10-17 13:47:50.677106	119000	a770a0b5-fa84-494e-81d9-2e83bd896eb4	t
120	2024-10-17 13:47:50.677106	120000	1c8ee013-7e03-455c-839c-543d18e80886	t
121	2024-10-17 13:47:50.677106	121000	3badad53-def1-4e7a-8472-404301d080e1	t
122	2024-10-17 13:47:50.677106	122000	6c8018d3-4cc4-4d5d-be06-388ceecb231b	t
123	2024-10-17 13:47:50.677106	123000	bf11282f-4156-4833-9305-d652ef38e7b5	t
124	2024-10-17 13:47:50.677106	124000	0d2ab408-7b94-42f0-ac5e-5a5cd117e786	t
125	2024-10-17 13:47:50.677106	125000	6c8018d3-4cc4-4d5d-be06-388ceecb231b	t
126	2024-10-17 13:47:50.677106	126000	4865a438-13d7-48e7-9c26-e52547b18c48	t
127	2024-10-17 13:47:50.677106	127000	061e4288-8955-4b8f-9272-e89e54101092	t
128	2024-10-17 13:47:50.677106	128000	45368c39-a4c6-4352-b9c7-f91633c5261b	t
129	2024-10-17 13:47:50.677106	129000	4f2277df-f770-4a7e-bae2-f49eafc6afe0	t
130	2024-10-17 13:47:50.677106	130000	1dd5fb93-3644-43c6-aa16-79097091f6b1	t
131	2024-10-17 13:47:50.677106	131000	6e57b73c-256b-4ae8-b238-1496e17dceb6	t
132	2024-10-17 13:47:50.677106	132000	163204ca-22ee-428d-b1f8-451cd1a59974	t
133	2024-10-17 13:47:50.677106	133000	ec45ecf1-e11e-40ce-b12e-a392c98856d2	t
134	2024-10-17 13:47:50.677106	134000	5c8fcf04-6271-49db-8563-1fa53e3ae3a0	t
135	2024-10-17 13:47:50.677106	135000	678091ae-4c9c-4c24-9f47-a9496d6ffca6	t
136	2024-10-17 13:47:50.677106	136000	34d16ed6-ba12-4daf-9b96-f8501522c459	t
137	2024-10-17 13:47:50.677106	137000	80ab47ac-201f-4628-a26e-3e74f701919c	t
138	2024-10-17 13:47:50.677106	138000	34d16ed6-ba12-4daf-9b96-f8501522c459	t
139	2024-10-17 13:47:50.677106	139000	4865a438-13d7-48e7-9c26-e52547b18c48	t
140	2024-10-17 13:47:50.677106	140000	bd95d21e-58da-4d6f-aeb1-da6db9d9ce5f	t
141	2024-10-17 13:47:50.677106	141000	5c8fcf04-6271-49db-8563-1fa53e3ae3a0	t
142	2024-10-17 13:47:50.677106	142000	ab50c6cd-3cfb-4063-bf06-d10067f46d2c	t
143	2024-10-17 13:47:50.677106	143000	0d2ab408-7b94-42f0-ac5e-5a5cd117e786	t
144	2024-10-17 13:47:50.677106	144000	96ef444e-ecba-4f3e-b6be-4aeacd91b30c	t
145	2024-10-17 13:47:50.677106	145000	c5732695-24d2-4419-8bdf-ff8662e94396	t
146	2024-10-17 13:47:50.677106	146000	5c8fcf04-6271-49db-8563-1fa53e3ae3a0	t
147	2024-10-17 13:47:50.677106	147000	6bb4ff8f-ac82-4bb5-91a9-7c5ab3f13a4d	t
148	2024-10-17 13:47:50.677106	148000	0f857d95-c7ee-48da-91f7-67fcb151fffa	t
149	2024-10-17 13:47:50.677106	149000	96ef444e-ecba-4f3e-b6be-4aeacd91b30c	t
150	2024-10-17 13:47:50.677106	150000	b351cbf7-9cd3-41f1-8859-b079593b51df	t
151	2024-10-17 13:47:50.677106	151000	2ac379e9-bd83-42d5-b56a-26b99ee7cb2f	t
152	2024-10-17 13:47:50.677106	152000	eea6ea1a-0c67-4774-9f33-e4779d394cfb	t
153	2024-10-17 13:47:50.677106	153000	503354a6-ea60-4d72-afce-6e39ca481f3a	t
154	2024-10-17 13:47:50.677106	154000	a770a0b5-fa84-494e-81d9-2e83bd896eb4	t
155	2024-10-17 13:47:50.677106	155000	eea6ea1a-0c67-4774-9f33-e4779d394cfb	t
156	2024-10-17 13:47:50.677106	156000	7689fc83-0bf4-4452-82d5-f2735d292933	t
157	2024-10-17 13:47:50.677106	157000	163204ca-22ee-428d-b1f8-451cd1a59974	t
158	2024-10-17 13:47:50.677106	158000	79738eba-835b-4fc1-bfc5-1ba3b444f9e2	t
159	2024-10-17 13:47:50.677106	159000	a0c4ed9d-a6c6-4139-ad78-256a198fd0ae	t
160	2024-10-17 13:47:50.677106	160000	52b9477e-0402-457d-bdbe-52f68d98da71	t
161	2024-10-17 13:47:50.677106	161000	503354a6-ea60-4d72-afce-6e39ca481f3a	t
162	2024-10-17 13:47:50.677106	162000	45368c39-a4c6-4352-b9c7-f91633c5261b	t
163	2024-10-17 13:47:50.677106	163000	305b9bc4-a229-4001-b699-684e3915b433	t
164	2024-10-17 13:47:50.677106	164000	6e57b73c-256b-4ae8-b238-1496e17dceb6	t
165	2024-10-17 13:47:50.677106	165000	bf11282f-4156-4833-9305-d652ef38e7b5	t
166	2024-10-17 13:47:50.677106	166000	a07ed2fb-1fd3-4d01-9a0f-5510431035b8	t
167	2024-10-17 13:47:50.677106	167000	678091ae-4c9c-4c24-9f47-a9496d6ffca6	t
168	2024-10-17 13:47:50.677106	168000	7f4d1315-6725-4aae-9037-2d13218e1ae9	t
169	2024-10-17 13:47:50.677106	169000	1503eabe-2aed-4673-a681-6d2cd9771d21	t
170	2024-10-17 13:47:50.677106	170000	bf11282f-4156-4833-9305-d652ef38e7b5	t
171	2024-10-17 13:47:50.677106	171000	8b953915-2a76-4598-a5cd-1907c04d8ab5	t
172	2024-10-17 13:47:50.677106	172000	305b9bc4-a229-4001-b699-684e3915b433	t
173	2024-10-17 13:47:50.677106	173000	9f018761-03b8-483f-aaf9-1d461b5e7da1	t
174	2024-10-17 13:47:50.677106	174000	ab50c6cd-3cfb-4063-bf06-d10067f46d2c	t
175	2024-10-17 13:47:50.677106	175000	52b9477e-0402-457d-bdbe-52f68d98da71	t
176	2024-10-17 13:47:50.677106	176000	0d2ab408-7b94-42f0-ac5e-5a5cd117e786	t
177	2024-10-17 13:47:50.677106	177000	ec45ecf1-e11e-40ce-b12e-a392c98856d2	t
178	2024-10-17 13:47:50.677106	178000	f059341e-1fb0-496f-a5c6-d1b416eebdbc	t
179	2024-10-17 13:47:50.677106	179000	bd95d21e-58da-4d6f-aeb1-da6db9d9ce5f	t
180	2024-10-17 13:47:50.677106	180000	45368c39-a4c6-4352-b9c7-f91633c5261b	t
181	2024-10-17 13:47:50.677106	181000	45368c39-a4c6-4352-b9c7-f91633c5261b	t
182	2024-10-17 13:47:50.677106	182000	a770a0b5-fa84-494e-81d9-2e83bd896eb4	t
183	2024-10-17 13:47:50.677106	183000	305b9bc4-a229-4001-b699-684e3915b433	t
184	2024-10-17 13:47:50.677106	184000	89dde868-2e58-4dd0-903d-f1eaf7c6a152	t
185	2024-10-17 13:47:50.677106	185000	a770a0b5-fa84-494e-81d9-2e83bd896eb4	t
186	2024-10-17 13:47:50.677106	186000	2ac379e9-bd83-42d5-b56a-26b99ee7cb2f	t
187	2024-10-17 13:47:50.677106	187000	9ce519f0-1cad-471f-9b36-eded31f91956	t
188	2024-10-17 13:47:50.677106	188000	a8cff319-d1c2-428c-9b3c-a1d8b21ac011	t
189	2024-10-17 13:47:50.677106	189000	4f2277df-f770-4a7e-bae2-f49eafc6afe0	t
190	2024-10-17 13:47:50.677106	190000	50043d19-7569-4b4d-b68d-21248a770fa5	t
191	2024-10-17 13:47:50.677106	191000	45368c39-a4c6-4352-b9c7-f91633c5261b	t
192	2024-10-17 13:47:50.677106	192000	bf11282f-4156-4833-9305-d652ef38e7b5	t
193	2024-10-17 13:47:50.677106	193000	9ce519f0-1cad-471f-9b36-eded31f91956	t
194	2024-10-17 13:47:50.677106	194000	c5732695-24d2-4419-8bdf-ff8662e94396	t
195	2024-10-17 13:47:50.677106	195000	80ab47ac-201f-4628-a26e-3e74f701919c	t
196	2024-10-17 13:47:50.677106	196000	52b9477e-0402-457d-bdbe-52f68d98da71	t
197	2024-10-17 13:47:50.677106	197000	678091ae-4c9c-4c24-9f47-a9496d6ffca6	t
198	2024-10-17 13:47:50.677106	198000	1503eabe-2aed-4673-a681-6d2cd9771d21	t
199	2024-10-17 13:47:50.677106	199000	7689fc83-0bf4-4452-82d5-f2735d292933	t
200	2024-10-17 13:47:50.677106	200000	34d16ed6-ba12-4daf-9b96-f8501522c459	t
\.


--
-- TOC entry 3380 (class 0 OID 16385)
-- Dependencies: 214
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, first_name, last_name, email, birthdate) FROM stdin;
80ab47ac-201f-4628-a26e-3e74f701919c	Emma	Johnson	emma.johnson@example.com	1985-12-20
061e4288-8955-4b8f-9272-e89e54101092	Ahmed	Ali	ahmed.ali@example.com	1978-07-10
8b953915-2a76-4598-a5cd-1907c04d8ab5	Maria	Garcia	maria.garcia@example.com	1995-02-28
a770a0b5-fa84-494e-81d9-2e83bd896eb4	Sophie	Dubois	sophie.dubois@example.com	1992-04-03
1503eabe-2aed-4673-a681-6d2cd9771d21	Juan	Martinez	juan.martinez@example.com	1989-10-12
9f018761-03b8-483f-aaf9-1d461b5e7da1	Ling	Li	ling.li@example.com	1976-06-25
3badad53-def1-4e7a-8472-404301d080e1	Yuki	Tanaka	yuki.tanaka@example.com	1980-03-17
503354a6-ea60-4d72-afce-6e39ca481f3a	Fatima	Khan	fatima.khan@example.com	1998-08-05
6a1489d1-f6b5-48f7-b46b-7f967f120fbc	Mikhail	Ivanov	mikhail.ivanov@example.com	1991-11-30
c5732695-24d2-4419-8bdf-ff8662e94396	Ana	Silva	ana.silva@example.com	1987-01-22
9ce519f0-1cad-471f-9b36-eded31f91956	Andrea	Ricci	andrea.ricci@example.com	1984-07-08
2ac379e9-bd83-42d5-b56a-26b99ee7cb2f	Muhammad	Abdullah	muhammad.abdullah@example.com	1993-04-14
6bb4ff8f-ac82-4bb5-91a9-7c5ab3f13a4d	Javier	Gonzalez	javier.gonzalez@example.com	1979-09-02
e318e9b4-d6cc-4040-8f5c-83fa6352a325	Fatemeh	Mohammadi	fatemeh.mohammadi@example.com	1986-05-18
4f2277df-f770-4a7e-bae2-f49eafc6afe0	Hans	Schmidt	hans.schmidt@example.com	1990-02-10
bf11282f-4156-4833-9305-d652ef38e7b5	Youssef	El Amir	youssef.elamir@example.com	1982-12-24
5c8fcf04-6271-49db-8563-1fa53e3ae3a0	Sofia	Kowalski	sofia.kowalski@example.com	1996-10-01
4865a438-13d7-48e7-9c26-e52547b18c48	Ravi	Patel	ravi.patel@example.com	1988-03-12
89dde868-2e58-4dd0-903d-f1eaf7c6a152	Nadia	Popescu	nadia.popescu@example.com	1975-08-20
6c8018d3-4cc4-4d5d-be06-388ceecb231b	Santiago	Lopez	santiago.lopez@example.com	1981-01-07
79738eba-835b-4fc1-bfc5-1ba3b444f9e2	Agnieszka	Nowak	agnieszka.nowak@example.com	1994-06-16
163204ca-22ee-428d-b1f8-451cd1a59974	Chen	Wang	chen.wang@example.com	1983-11-28
aaf8b71e-80b9-46db-8c7d-d977142cb5ef	Alessandro	Rossi	alessandro.rossi@example.com	1997-09-14
f059341e-1fb0-496f-a5c6-d1b416eebdbc	Elena	Novak	elena.novak@example.com	1989-04-02
6e57b73c-256b-4ae8-b238-1496e17dceb6	Abdul	Ahmed	abdul.ahmed@example.com	1984-12-10
305b9bc4-a229-4001-b699-684e3915b433	Giovanni	Ferrari	giovanni.ferrari@example.com	1992-07-22
a0c4ed9d-a6c6-4139-ad78-256a198fd0ae	Natasha	Ivanova	natasha.ivanova@example.com	1978-03-05
eea6ea1a-0c67-4774-9f33-e4779d394cfb	Ali	Al-Farsi	ali.alfarsi@example.com	1985-10-13
6a1dd4b8-d07c-45a4-960d-11e038025cb5	Seung	Park	seung.park@example.com	1990-05-25
52b9477e-0402-457d-bdbe-52f68d98da71	Léa	Dupont	lea.dupont@example.com	1987-01-03
b351cbf7-9cd3-41f1-8859-b079593b51df	Igor	Vasiliev	igor.vasiliev@example.com	1996-08-11
c592c81b-4cea-4ce9-b327-569abde72d45	Yasmin	Khalifa	yasmin.khalifa@example.com	1980-04-19
7689fc83-0bf4-4452-82d5-f2735d292933	Katarzyna	Kowalczyk	katarzyna.kowalczyk@example.com	1993-12-27
34d16ed6-ba12-4daf-9b96-f8501522c459	Dong	Nguyen	dong.nguyen@example.com	1995-10-30
a678c7f0-86c2-4fca-aaec-874b4567d753	Amir	Elias	amir.elias@example.com	1981-02-15
1c8ee013-7e03-455c-839c-543d18e80886	Katja	Laine	katja.laine@example.com	1977-06-05
d2899a7d-67d6-447a-9723-51b483ddbaf7	Rajesh	Sharma	rajesh.sharma@example.com	1994-07-20
a8cff319-d1c2-428c-9b3c-a1d8b21ac011	Ana	Sousa	ana.sousa@example.com	1988-09-10
80f690d9-fedc-4fdb-900f-0b52650671e4	Giorgos	Papadopoulos	giorgos.papadopoulos@example.com	1983-03-25
ab50c6cd-3cfb-4063-bf06-d10067f46d2c	Maya	Patil	maya.patil@example.com	1990-12-05
50043d19-7569-4b4d-b68d-21248a770fa5	Fiona	Murphy	fiona.murphy@example.com	1976-04-15
96ef444e-ecba-4f3e-b6be-4aeacd91b30c	Santiago	Hernandez	santiago.hernandez@example.com	1997-05-01
7f4d1315-6725-4aae-9037-2d13218e1ae9	Yuki	Takahashi	yuki.takahashi@example.com	1982-08-21
ec45ecf1-e11e-40ce-b12e-a392c98856d2	Irina	Kuznetsova	irina.kuznetsova@example.com	1996-01-25
105a8f37-54f5-43c8-a57e-a113b33ad831	José	Gutierrez	jose.gutierrez@example.com	1979-11-15
bd95d21e-58da-4d6f-aeb1-da6db9d9ce5f	Amira	Said	amira.said@example.com	1985-03-05
a07ed2fb-1fd3-4d01-9a0f-5510431035b8	Federico	Romano	federico.romano@example.com	1992-06-20
0f857d95-c7ee-48da-91f7-67fcb151fffa	André	Moreira	andre.moreira@example.com	1991-09-30
0d2ab408-7b94-42f0-ac5e-5a5cd117e786	Tariq	Choudhury	tariq.choudhury@example.com	1994-04-01
c1664585-a364-43c8-a668-9bdb5ae36a0c	Catarina	Santos	catarina.santos@example.com	1976-10-20
f14f4134-5b29-461a-ac2c-bf3e4332db4a	Boby	Bob	\N	\N
1dd5fb93-3644-43c6-aa16-79097091f6b1	Hiroo	Kobayashi	hiroko.kobayashi@example.com	1987-02-10
678091ae-4c9c-4c24-9f47-a9496d6ffca6	Nadir	Omar	nadia.omar@example.com	1978-08-10
45368c39-a4c6-4352-b9c7-f91633c5261b	Nadir	Omar	nadia.omar@example.com	1978-08-10
\.


--
-- TOC entry 3384 (class 0 OID 16432)
-- Dependencies: 218
-- Data for Name: insurance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.insurance (id, name, client_id) FROM stdin;
2	santé	\N
3	vie	\N
4	auto	\N
5	scolaire	\N
6	responsabilité civile	\N
7	ponsabilité personnel	\N
8	responsabilité professionnelle	\N
11	sco	\N
\.


--
-- TOC entry 3385 (class 0 OID 16443)
-- Dependencies: 219
-- Data for Name: subscribe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscribe (client_id, insurance_id) FROM stdin;
\.


--
-- TOC entry 3387 (class 0 OID 16459)
-- Dependencies: 221
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, full_name, email, pass, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 215
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_id_seq', 201, true);


--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 217
-- Name: insurance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.insurance_id_seq', 11, true);


--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 220
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 1, true);


--
-- TOC entry 3227 (class 2606 OID 16396)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 3231 (class 2606 OID 16447)
-- Name: subscribe client_insurance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscribe
    ADD CONSTRAINT client_insurance_pkey PRIMARY KEY (client_id, insurance_id);


--
-- TOC entry 3225 (class 2606 OID 16389)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- TOC entry 3229 (class 2606 OID 16437)
-- Name: insurance insurance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insurance
    ADD CONSTRAINT insurance_pkey PRIMARY KEY (id);


--
-- TOC entry 3233 (class 2606 OID 16466)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3234 (class 2606 OID 16397)
-- Name: account account_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id);


--
-- TOC entry 3235 (class 2606 OID 16438)
-- Name: insurance fk_client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insurance
    ADD CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES public.client(id) ON DELETE CASCADE;


--
-- TOC entry 3236 (class 2606 OID 16448)
-- Name: subscribe fk_client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscribe
    ADD CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES public.client(id) ON DELETE CASCADE;


--
-- TOC entry 3237 (class 2606 OID 16453)
-- Name: subscribe fk_insurance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscribe
    ADD CONSTRAINT fk_insurance FOREIGN KEY (insurance_id) REFERENCES public.insurance(id) ON DELETE CASCADE;


-- Completed on 2024-10-22 15:52:53

--
-- PostgreSQL database dump complete
--

