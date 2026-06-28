--
-- PostgreSQL database dump
--

-- Dumped from database version 16.14 (Debian 16.14-1.pgdg13+1)
-- Dumped by pg_dump version 17.0

-- Started on 2026-06-28 11:40:19

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
-- TOC entry 219 (class 1259 OID 24646)
-- Name: alerts; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.alerts (
    id integer NOT NULL,
    nom character varying(25),
    valeur double precision,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_checked boolean DEFAULT false
);


ALTER TABLE public.alerts OWNER TO admin;

--
-- TOC entry 218 (class 1259 OID 24645)
-- Name: alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alerts_id_seq OWNER TO admin;

--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 218
-- Name: alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.alerts_id_seq OWNED BY public.alerts.id;


--
-- TOC entry 215 (class 1259 OID 24585)
-- Name: lots; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.lots (
    nom character varying(25) NOT NULL,
    type character varying(25) NOT NULL,
    max double precision,
    min double precision,
    description text,
    date_debut date DEFAULT CURRENT_DATE,
    duree_jours integer DEFAULT 365
);


ALTER TABLE public.lots OWNER TO admin;

--
-- TOC entry 217 (class 1259 OID 24606)
-- Name: mesures; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.mesures (
    id integer NOT NULL,
    nom character varying(25),
    valeur double precision,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.mesures OWNER TO admin;

--
-- TOC entry 216 (class 1259 OID 24605)
-- Name: mesures_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.mesures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mesures_id_seq OWNER TO admin;

--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 216
-- Name: mesures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.mesures_id_seq OWNED BY public.mesures.id;


--
-- TOC entry 3280 (class 2604 OID 24649)
-- Name: alerts id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.alerts ALTER COLUMN id SET DEFAULT nextval('public.alerts_id_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 24609)
-- Name: mesures id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.mesures ALTER COLUMN id SET DEFAULT nextval('public.mesures_id_seq'::regclass);


--
-- TOC entry 3288 (class 2606 OID 24653)
-- Name: alerts alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2606 OID 24591)
-- Name: lots lots_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.lots
    ADD CONSTRAINT lots_pkey PRIMARY KEY (nom);


--
-- TOC entry 3286 (class 2606 OID 24612)
-- Name: mesures mesures_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.mesures
    ADD CONSTRAINT mesures_pkey PRIMARY KEY (id);


--
-- TOC entry 3290 (class 2606 OID 24654)
-- Name: alerts alerts_nom_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_nom_fkey FOREIGN KEY (nom) REFERENCES public.lots(nom);


--
-- TOC entry 3289 (class 2606 OID 24613)
-- Name: mesures mesures_nom_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.mesures
    ADD CONSTRAINT mesures_nom_fkey FOREIGN KEY (nom) REFERENCES public.lots(nom);


-- Completed on 2026-06-28 11:40:19

--
-- PostgreSQL database dump complete
--

