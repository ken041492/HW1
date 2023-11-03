--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0

-- Started on 2023-10-31 11:53:35 CST

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
-- TOC entry 2 (class 3079 OID 16449)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16408)
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    id uuid NOT NULL,
    course_code character varying(50) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16413)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id uuid NOT NULL,
    name character varying NOT NULL,
    short_name character varying NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16443)
-- Name: members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.members (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.members OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16426)
-- Name: student_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_course (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid NOT NULL,
    course_id uuid NOT NULL
);


ALTER TABLE public.student_course OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16389)
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
-- TOC entry 217 (class 1259 OID 16401)
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
-- TOC entry 3402 (class 0 OID 16408)
-- Dependencies: 218
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.courses (id, course_code, name) VALUES ('47bf2860-c8df-4743-a9e4-dadc435798a0', 'BA_001', 'BA');
INSERT INTO public.courses (id, course_code, name) VALUES ('0a9c883c-b352-47f0-96d4-6bd3e192b346', 'CS_001', 'cs');


--
-- TOC entry 3403 (class 0 OID 16413)
-- Dependencies: 219
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.departments (id, name, short_name) VALUES ('790c5da8-8fd6-40e1-808b-a5700bab96b0', 'Computer Science and Information Engineering', 'CSIE');
INSERT INTO public.departments (id, name, short_name) VALUES ('d20c1f42-8ace-421f-8fbc-51886a003d3b', 'Business postgresistration', 'BA');


--
-- TOC entry 3405 (class 0 OID 16443)
-- Dependencies: 221
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3404 (class 0 OID 16426)
-- Dependencies: 220
-- Data for Name: student_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.student_course (id, student_id, course_id) VALUES ('f198e95e-000d-4907-8bdb-8235603d751e', '12c52dbe-70db-481e-8a6f-d3791624ab6f', '47bf2860-c8df-4743-a9e4-dadc435798a0');
INSERT INTO public.student_course (id, student_id, course_id) VALUES ('1787d676-4077-4713-b03a-36c0ff6c1924', '5270a56f-9bee-4258-a236-2e9b943ec68a', '47bf2860-c8df-4743-a9e4-dadc435798a0');
INSERT INTO public.student_course (id, student_id, course_id) VALUES ('df5b29af-5f58-4d3e-9a45-755582841d19', '5270a56f-9bee-4258-a236-2e9b943ec68a', '0a9c883c-b352-47f0-96d4-6bd3e192b346');
INSERT INTO public.student_course (id, student_id, course_id) VALUES ('077a80b5-4c9d-41df-9778-561f60f8c41a', '6d02724e-5122-4dbf-bdbf-99d4c8d11b53', '0a9c883c-b352-47f0-96d4-6bd3e192b346');
INSERT INTO public.student_course (id, student_id, course_id) VALUES ('3e8fda77-cfdd-4749-a7db-5794fc4801e4', '7ffa01cc-4234-4eaa-8711-3bf20abd2184', '47bf2860-c8df-4743-a9e4-dadc435798a0');


--
-- TOC entry 3400 (class 0 OID 16389)
-- Dependencies: 216
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.students (id, first_name, last_name, student_id, department_id) VALUES ('3525d408-7a9d-43b1-931c-5b64e192085c', 'Jaeger', '劉', '1110549', 'd20c1f42-8ace-421f-8fbc-51886a003d3b');
INSERT INTO public.students (id, first_name, last_name, student_id, department_id) VALUES ('12c52dbe-70db-481e-8a6f-d3791624ab6f', 'Jack', 'Ma', '11105452', 'd20c1f42-8ace-421f-8fbc-51886a003d3b');
INSERT INTO public.students (id, first_name, last_name, student_id, department_id) VALUES ('7ffa01cc-4234-4eaa-8711-3bf20abd2184', 'Jaeger', '劉', '11105458', 'd20c1f42-8ace-421f-8fbc-51886a003d3b');
INSERT INTO public.students (id, first_name, last_name, student_id, department_id) VALUES ('5270a56f-9bee-4258-a236-2e9b943ec68a', 'Victor', 'Tsai', '11105453', '790c5da8-8fd6-40e1-808b-a5700bab96b0');
INSERT INTO public.students (id, first_name, last_name, student_id, department_id) VALUES ('6d02724e-5122-4dbf-bdbf-99d4c8d11b53', 'YK', 'Tsai', '11105454', 'd20c1f42-8ace-421f-8fbc-51886a003d3b');


--
-- TOC entry 3401 (class 0 OID 16401)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, first_name, last_name, account) VALUES ('12c52dbe-70db-481e-8a6f-d3791624ab6f', 'Jack', 'Ma', 'S11105452');
INSERT INTO public.users (id, first_name, last_name, account) VALUES ('5270a56f-9bee-4258-a236-2e9b943ec68a', 'Victor', 'Tsai', 'S11105453');
INSERT INTO public.users (id, first_name, last_name, account) VALUES ('6d02724e-5122-4dbf-bdbf-99d4c8d11b53', 'YK', 'Tsai', 'S11105454');


--
-- TOC entry 3243 (class 2606 OID 16412)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- TOC entry 3245 (class 2606 OID 16419)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- TOC entry 3253 (class 2606 OID 16448)
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- TOC entry 3249 (class 2606 OID 16430)
-- Name: student_course student_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT student_course_pkey PRIMARY KEY (id);


--
-- TOC entry 3251 (class 2606 OID 16466)
-- Name: student_course student_course_unique_constraint; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT student_course_unique_constraint UNIQUE (student_id, course_id);


--
-- TOC entry 3239 (class 2606 OID 16395)
-- Name: students studnets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT studnets_pkey PRIMARY KEY (id);


--
-- TOC entry 3241 (class 2606 OID 16407)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 1259 OID 16436)
-- Name: fki_s; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_s ON public.student_course USING btree (student_id);


--
-- TOC entry 3247 (class 1259 OID 16442)
-- Name: fki_s2c_c_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_s2c_c_fkey ON public.student_course USING btree (course_id);


--
-- TOC entry 3236 (class 1259 OID 16425)
-- Name: fki_students_departments_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_students_departments_fkey ON public.students USING btree (department_id);


--
-- TOC entry 3237 (class 1259 OID 16463)
-- Name: idx_student_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_student_id ON public.students USING btree (student_id) WITH (deduplicate_items='true');


--
-- TOC entry 3255 (class 2606 OID 16437)
-- Name: student_course s2c_c_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT s2c_c_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id) NOT VALID;


--
-- TOC entry 3256 (class 2606 OID 16431)
-- Name: student_course s2c_s_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT s2c_s_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) NOT VALID;


--
-- TOC entry 3254 (class 2606 OID 16420)
-- Name: students students_departments_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_departments_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id) NOT VALID;


-- Completed on 2023-10-31 11:53:35 CST

--
-- PostgreSQL database dump complete
--

