--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: activation_level; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.activation_level AS ENUM (
    'low',
    'medium',
    'high'
);


ALTER TYPE public.activation_level OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercises (
    name character varying NOT NULL
);


ALTER TABLE public.exercises OWNER TO postgres;

--
-- Name: muscle_group_exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muscle_group_exercises (
    exercise character varying NOT NULL,
    muscle_group character varying NOT NULL,
    activation_level public.activation_level NOT NULL
);


ALTER TABLE public.muscle_group_exercises OWNER TO postgres;

--
-- Name: muscle_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muscle_groups (
    name character varying NOT NULL
);


ALTER TABLE public.muscle_groups OWNER TO postgres;

--
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercises (name) FROM stdin;
squat
leg press
lunge
deadlift
leg extension
leg curl
standing calf raise
seated calf raise
hip adductor
bench press
chest fly
push-up
pull-down
pull-up
bent-over row
upright row
shoulder press
shoulder fly
lateral raise
shoulder shrug
pushdown
triceps extension
biceps curl
crunch
russian twist
leg raise
back extension
\.


--
-- Data for Name: muscle_group_exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muscle_group_exercises (exercise, muscle_group, activation_level) FROM stdin;
squat	calves	low
squat	hamstrings	low
squat	gluteus	medium
squat	hips other	medium
squat	lower back	low
squat	abdominals	medium
leg press	calves	low
leg press	quadriceps	medium
leg press	hamstrings	low
leg press	gluteus	medium
lunge	quadriceps	medium
lunge	hamstrings	medium
lunge	gluteus	medium
lunge	hips other	medium
deadlift	calves	low
deadlift	quadriceps	medium
deadlift	hamstrings	medium
deadlift	gluteus	medium
deadlift	hips other	medium
deadlift	lower back	medium
deadlift	trapezius	low
deadlift	abdominals	low
deadlift	forearms	low
leg extension	quadriceps	medium
leg curl	calves	low
leg curl	hamstrings	medium
standing calf raise	calves	medium
seated calf raise	calves	medium
hip adductor	hips other	medium
bench press	pectorals	medium
bench press	deltoids	low
bench press	triceps	medium
chest fly	pectorals	medium
chest fly	deltoids	low
push-up	abdominals	low
push-up	pectorals	medium
push-up	deltoids	low
push-up	triceps	medium
pull-down	lats	medium
pull-down	pectorals	low
pull-down	deltoids	low
pull-down	biceps	low
pull-down	forearms	low
pull-up	lats	medium
pull-up	trapezius	low
pull-up	pectorals	low
pull-up	deltoids	low
pull-up	biceps	low
pull-up	forearms	low
bent-over row	lats	medium
bent-over row	trapezius	low
bent-over row	biceps	low
bent-over row	forearms	low
upright row	trapezius	medium
upright row	deltoids	medium
upright row	biceps	low
upright row	forearms	low
shoulder press	trapezius	low
shoulder press	deltoids	medium
shoulder press	triceps	low
shoulder fly	trapezius	low
shoulder fly	deltoids	medium
shoulder fly	forearms	low
lateral raise	trapezius	low
lateral raise	deltoids	medium
shoulder shrug	trapezius	medium
shoulder shrug	pectorals	low
shoulder shrug	forearms	low
pushdown	abdominals	low
pushdown	triceps	medium
triceps extension	triceps	medium
triceps extension	forearms	low
biceps curl	biceps	medium
biceps curl	forearms	low
crunch	abdominals	medium
russian twist	abdominals	medium
leg raise	hips other	medium
leg raise	abdominals	low
back extension	hamstrings	low
back extension	gluteus	medium
back extension	lower back	medium
\.


--
-- Data for Name: muscle_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muscle_groups (name) FROM stdin;
calves
quadriceps
hamstrings
gluteus
hips other
lower back
lats
trapezius
abdominals
pectorals
deltoids
triceps
biceps
forearms
\.


--
-- Name: exercises exercises_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pk PRIMARY KEY (name);


--
-- Name: muscle_group_exercises muscle_group_exercises_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muscle_group_exercises
    ADD CONSTRAINT muscle_group_exercises_pk PRIMARY KEY (exercise, muscle_group);


--
-- Name: muscle_groups muscle_groups_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muscle_groups
    ADD CONSTRAINT muscle_groups_pk PRIMARY KEY (name);


--
-- Name: muscle_group_exercises muscle_group_exercises_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muscle_group_exercises
    ADD CONSTRAINT muscle_group_exercises_fk FOREIGN KEY (exercise) REFERENCES public.exercises(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: muscle_group_exercises muscle_group_exercises_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muscle_group_exercises
    ADD CONSTRAINT muscle_group_exercises_fk_1 FOREIGN KEY (muscle_group) REFERENCES public.muscle_groups(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

