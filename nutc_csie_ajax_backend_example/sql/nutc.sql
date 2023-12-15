--
-- PostgreSQL database cluster dump
--

-- Started on 2023-12-01 13:53:07 CST

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE "imac-3373";
ALTER ROLE "imac-3373" WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN NOREPLICATION NOBYPASSRLS;

--
-- User Configurations
--






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 16.0

-- Started on 2023-12-01 13:53:07 CST

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: imac-3373
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO "imac-3373";

--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: imac-3373
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-12-01 13:53:07 CST

--
-- PostgreSQL database dump complete
--

--
-- Database "example" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 16.0

-- Started on 2023-12-01 13:53:07 CST

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
-- TOC entry 3656 (class 1262 OID 24616)
-- Name: example; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE example WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE example OWNER TO postgres;

\connect example

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
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: imac-3373
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO "imac-3373";

--
-- TOC entry 2 (class 3079 OID 24617)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 3658 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 24628)
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    id uuid NOT NULL,
    course_code character varying(50) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 24631)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id uuid NOT NULL,
    name character varying NOT NULL,
    short_name character varying NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 24636)
-- Name: members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.members (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.members OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 24640)
-- Name: student_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_course (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid NOT NULL,
    course_id uuid NOT NULL
);


ALTER TABLE public.student_course OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24644)
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    student_id character varying(20) NOT NULL,
    department_id uuid NOT NULL
);


ALTER TABLE public.students OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24650)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    account character varying(20) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 3645 (class 0 OID 24628)
-- Dependencies: 210
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (id, course_code, name) FROM stdin;
47bf2860-c8df-4743-a9e4-dadc435798a0	BA_001	BA
0a9c883c-b352-47f0-96d4-6bd3e192b346	CS_001	cs
\.


--
-- TOC entry 3646 (class 0 OID 24631)
-- Dependencies: 211
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (id, name, short_name) FROM stdin;
790c5da8-8fd6-40e1-808b-a5700bab96b0	Computer Science and Information Engineering	CSIE
d20c1f42-8ace-421f-8fbc-51886a003d3b	Business postgresistration	BA
\.


--
-- TOC entry 3647 (class 0 OID 24636)
-- Dependencies: 212
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.members (id, name) FROM stdin;
\.


--
-- TOC entry 3648 (class 0 OID 24640)
-- Dependencies: 213
-- Data for Name: student_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_course (id, student_id, course_id) FROM stdin;
f198e95e-000d-4907-8bdb-8235603d751e	12c52dbe-70db-481e-8a6f-d3791624ab6f	47bf2860-c8df-4743-a9e4-dadc435798a0
1787d676-4077-4713-b03a-36c0ff6c1924	5270a56f-9bee-4258-a236-2e9b943ec68a	47bf2860-c8df-4743-a9e4-dadc435798a0
df5b29af-5f58-4d3e-9a45-755582841d19	5270a56f-9bee-4258-a236-2e9b943ec68a	0a9c883c-b352-47f0-96d4-6bd3e192b346
077a80b5-4c9d-41df-9778-561f60f8c41a	6d02724e-5122-4dbf-bdbf-99d4c8d11b53	0a9c883c-b352-47f0-96d4-6bd3e192b346
3e8fda77-cfdd-4749-a7db-5794fc4801e4	7ffa01cc-4234-4eaa-8711-3bf20abd2184	47bf2860-c8df-4743-a9e4-dadc435798a0
\.


--
-- TOC entry 3649 (class 0 OID 24644)
-- Dependencies: 214
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (id, first_name, last_name, student_id, department_id) FROM stdin;
3525d408-7a9d-43b1-931c-5b64e192085c	Jaeger	劉	1110549	d20c1f42-8ace-421f-8fbc-51886a003d3b
12c52dbe-70db-481e-8a6f-d3791624ab6f	Jack	Ma	11105452	d20c1f42-8ace-421f-8fbc-51886a003d3b
7ffa01cc-4234-4eaa-8711-3bf20abd2184	Jaeger	劉	11105458	d20c1f42-8ace-421f-8fbc-51886a003d3b
5270a56f-9bee-4258-a236-2e9b943ec68a	Victor	Tsai	11105453	790c5da8-8fd6-40e1-808b-a5700bab96b0
6d02724e-5122-4dbf-bdbf-99d4c8d11b53	YK	Tsai	11105454	d20c1f42-8ace-421f-8fbc-51886a003d3b
\.


--
-- TOC entry 3650 (class 0 OID 24650)
-- Dependencies: 215
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, account) FROM stdin;
12c52dbe-70db-481e-8a6f-d3791624ab6f	Jack	Ma	S11105452
5270a56f-9bee-4258-a236-2e9b943ec68a	Victor	Tsai	S11105453
6d02724e-5122-4dbf-bdbf-99d4c8d11b53	YK	Tsai	S11105454
\.


--
-- TOC entry 3486 (class 2606 OID 24656)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- TOC entry 3488 (class 2606 OID 24658)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- TOC entry 3490 (class 2606 OID 24660)
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- TOC entry 3494 (class 2606 OID 24662)
-- Name: student_course student_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT student_course_pkey PRIMARY KEY (id);


--
-- TOC entry 3496 (class 2606 OID 24664)
-- Name: student_course student_course_unique_constraint; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT student_course_unique_constraint UNIQUE (student_id, course_id);


--
-- TOC entry 3500 (class 2606 OID 24666)
-- Name: students studnets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT studnets_pkey PRIMARY KEY (id);


--
-- TOC entry 3502 (class 2606 OID 24668)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3491 (class 1259 OID 24669)
-- Name: fki_s; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_s ON public.student_course USING btree (student_id);


--
-- TOC entry 3492 (class 1259 OID 24670)
-- Name: fki_s2c_c_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_s2c_c_fkey ON public.student_course USING btree (course_id);


--
-- TOC entry 3497 (class 1259 OID 24671)
-- Name: fki_students_departments_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_students_departments_fkey ON public.students USING btree (department_id);


--
-- TOC entry 3498 (class 1259 OID 24672)
-- Name: idx_student_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_student_id ON public.students USING btree (student_id) WITH (deduplicate_items='true');


--
-- TOC entry 3503 (class 2606 OID 24673)
-- Name: student_course s2c_c_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT s2c_c_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id) NOT VALID;


--
-- TOC entry 3504 (class 2606 OID 24678)
-- Name: student_course s2c_s_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT s2c_s_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) NOT VALID;


--
-- TOC entry 3505 (class 2606 OID 24683)
-- Name: students students_departments_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_departments_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id) NOT VALID;


--
-- TOC entry 3657 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: imac-3373
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-12-01 13:53:07 CST

--
-- PostgreSQL database dump complete
--

--
-- Database "nutc_csie" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 16.0

-- Started on 2023-12-01 13:53:07 CST

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
-- TOC entry 3633 (class 1262 OID 16385)
-- Name: nutc_csie; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE nutc_csie WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE nutc_csie OWNER TO postgres;

\connect nutc_csie

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: imac-3373
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO "imac-3373";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 211 (class 1259 OID 24586)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id uuid NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 24596)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    id uuid NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24611)
-- Name: item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item (
    id uuid NOT NULL,
    order_id uuid NOT NULL,
    product_id uuid NOT NULL,
    is_shipped boolean NOT NULL
);


ALTER TABLE public.item OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 24606)
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    id uuid NOT NULL,
    customer_id uuid NOT NULL,
    is_paid boolean NOT NULL
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 24576)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id uuid NOT NULL,
    name character varying(20) NOT NULL,
    price integer NOT NULL,
    category_id uuid
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16386)
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    id uuid NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    student_id character varying(20) NOT NULL,
    department_id uuid
);


ALTER TABLE public.students OWNER TO postgres;

--
-- TOC entry 3624 (class 0 OID 24586)
-- Dependencies: 211
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, name) FROM stdin;
a93a89a3-b810-47bc-9dde-b1e30e7653e1	ddd
64b9bec6-b44b-455a-9124-0ed6dc901e2b	ooo
\.


--
-- TOC entry 3625 (class 0 OID 24596)
-- Dependencies: 212
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (id, name) FROM stdin;
4cc83578-0eda-433d-ae2f-6184f4251c90	Ken
e425b64e-6fab-4d08-932f-5d2a5024a0f3	Joy
8710a71a-e4fd-46c6-9f2f-f07694a23b8e	Andy
\.


--
-- TOC entry 3627 (class 0 OID 24611)
-- Dependencies: 214
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item (id, order_id, product_id, is_shipped) FROM stdin;
c6c2913d-bba5-4329-935b-b5445f86a1ad	e1323019-79ee-47ec-8028-0aa8082874e2	3ed123d3-a155-4c09-ba97-f2ca143f772e	f
07acac67-aca2-48f2-a0ad-9ae781bb1b18	1cdd871e-5607-405a-8a70-7c7cf53a69ad	856c36e5-5b6a-48d5-8460-7f4111bb5df2	t
\.


--
-- TOC entry 3626 (class 0 OID 24606)
-- Dependencies: 213
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (id, customer_id, is_paid) FROM stdin;
e1323019-79ee-47ec-8028-0aa8082874e2	e425b64e-6fab-4d08-932f-5d2a5024a0f3	f
1cdd871e-5607-405a-8a70-7c7cf53a69ad	4cc83578-0eda-433d-ae2f-6184f4251c90	t
a897ea38-6da1-4548-9eb0-5527f5270aa9	8710a71a-e4fd-46c6-9f2f-f07694a23b8e	t
\.


--
-- TOC entry 3623 (class 0 OID 24576)
-- Dependencies: 210
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, name, price, category_id) FROM stdin;
3ed123d3-a155-4c09-ba97-f2ca143f772e	car	50	64b9bec6-b44b-455a-9124-0ed6dc901e2b
856c36e5-5b6a-48d5-8460-7f4111bb5df2	house	100	a93a89a3-b810-47bc-9dde-b1e30e7653e1
1e7dcf56-7a2e-419a-86a2-1566dfb3467b	shoe	0	ca33a935-0961-43c5-b803-4788fdaca63e
fd413f0f-70ea-4d28-b49d-f98959b9ce59	T-shirt	0	e8b9dae0-02a2-4f5c-bab3-42917efc9efd
1f3ad9a4-b055-48cc-838c-00e3f7f104d0	ball	350	62efa3b3-0cde-4b5c-829e-5f6564051458
\.


--
-- TOC entry 3622 (class 0 OID 16386)
-- Dependencies: 209
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (id, first_name, last_name, student_id, department_id) FROM stdin;
9413648b-ee05-4f97-b570-68d2a49806bc	K-Xiang	Zhang	1411032078	\N
583972e7-1155-48d2-98bc-8bdda23b4990	B-Wei\n	Wang	1411032070	\N
\.


--
-- TOC entry 3476 (class 2606 OID 24595)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 3478 (class 2606 OID 24600)
-- Name: customer custom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT custom_pkey PRIMARY KEY (id);


--
-- TOC entry 3482 (class 2606 OID 24615)
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- TOC entry 3480 (class 2606 OID 24610)
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- TOC entry 3474 (class 2606 OID 24580)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 3472 (class 2606 OID 16390)
-- Name: students student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- TOC entry 3634 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: imac-3373
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-12-01 13:53:07 CST

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 16.0

-- Started on 2023-12-01 13:53:07 CST

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: imac-3373
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO "imac-3373";

--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: imac-3373
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-12-01 13:53:07 CST

--
-- PostgreSQL database dump complete
--

-- Completed on 2023-12-01 13:53:07 CST

--
-- PostgreSQL database cluster dump complete
--

