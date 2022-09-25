--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5
-- Dumped by pg_dump version 14.4

-- Started on 2022-09-25 14:41:33 CDT

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
-- TOC entry 11 (class 2615 OID 19167)
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA tiger;


--
-- TOC entry 8 (class 2615 OID 19445)
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA tiger_data;


--
-- TOC entry 12 (class 2615 OID 19010)
-- Name: topology; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA topology;


--
-- TOC entry 4466 (class 0 OID 0)
-- Dependencies: 12
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- TOC entry 4 (class 3079 OID 19156)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 4467 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- TOC entry 2 (class 3079 OID 17995)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4468 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- TOC entry 5 (class 3079 OID 19168)
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- TOC entry 4469 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- TOC entry 3 (class 3079 OID 19011)
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- TOC entry 4470 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 269 (class 1259 OID 19632)
-- Name: huc8; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.huc8 (
    gid integer NOT NULL,
    areaacres numeric,
    states character varying(50),
    huc8 character varying(8) NOT NULL,
    name character varying(120),
    geom public.geometry(MultiPolygon,4326)
);


--
-- TOC entry 270 (class 1259 OID 19638)
-- Name: huc8_geo_data_gid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.huc8_geo_data_gid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4471 (class 0 OID 0)
-- Dependencies: 270
-- Name: huc8_geo_data_gid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.huc8_geo_data_gid_seq OWNED BY public.huc8.gid;


--
-- TOC entry 272 (class 1259 OID 27798)
-- Name: huc_practice_relations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.huc_practice_relations (
    huc_practice_id integer NOT NULL,
    huc8_id character varying(8) NOT NULL,
    practice_id integer NOT NULL
);


--
-- TOC entry 273 (class 1259 OID 27823)
-- Name: huc_practice_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.huc_practice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4472 (class 0 OID 0)
-- Dependencies: 273
-- Name: huc_practice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.huc_practice_id_seq OWNED BY public.huc_practice_relations.huc_practice_id;


--
-- TOC entry 271 (class 1259 OID 19649)
-- Name: practices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.practices (
    practice_id integer NOT NULL,
    city character varying(50),
    county character varying(50),
    installation_date integer NOT NULL,
    cost double precision,
    practice_drainage_area double precision,
    new_development_or_retrofit character varying(50),
    type_id integer NOT NULL
);


--
-- TOC entry 274 (class 1259 OID 27826)
-- Name: practice_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.practice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4473 (class 0 OID 0)
-- Dependencies: 274
-- Name: practice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.practice_id_seq OWNED BY public.practices.practice_id;


--
-- TOC entry 276 (class 1259 OID 27910)
-- Name: practice_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.practice_types (
    practice_type_id integer NOT NULL,
    practice_category_type_name character varying(255) NOT NULL,
    practice_category character varying(255) NOT NULL,
    practice_source character varying(255),
    practice_definition text
);


--
-- TOC entry 275 (class 1259 OID 27908)
-- Name: practice_types_practice_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.practice_types_practice_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4474 (class 0 OID 0)
-- Dependencies: 275
-- Name: practice_types_practice_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.practice_types_practice_type_id_seq OWNED BY public.practice_types.practice_type_id;


--
-- TOC entry 4182 (class 2604 OID 19652)
-- Name: huc8 gid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.huc8 ALTER COLUMN gid SET DEFAULT nextval('public.huc8_geo_data_gid_seq'::regclass);


--
-- TOC entry 4184 (class 2604 OID 27825)
-- Name: huc_practice_relations huc_practice_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.huc_practice_relations ALTER COLUMN huc_practice_id SET DEFAULT nextval('public.huc_practice_id_seq'::regclass);


--
-- TOC entry 4185 (class 2604 OID 27913)
-- Name: practice_types practice_type_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.practice_types ALTER COLUMN practice_type_id SET DEFAULT nextval('public.practice_types_practice_type_id_seq'::regclass);


--
-- TOC entry 4183 (class 2604 OID 27828)
-- Name: practices practice_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.practices ALTER COLUMN practice_id SET DEFAULT nextval('public.practice_id_seq'::regclass);


--
-- TOC entry 4310 (class 2606 OID 27797)
-- Name: huc8 huc8_primary_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.huc8
    ADD CONSTRAINT huc8_primary_key PRIMARY KEY (huc8);


--
-- TOC entry 4312 (class 2606 OID 19715)
-- Name: huc8 huc8_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.huc8
    ADD CONSTRAINT huc8_unique UNIQUE (huc8);


--
-- TOC entry 4316 (class 2606 OID 27802)
-- Name: huc_practice_relations huc_practice_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.huc_practice_relations
    ADD CONSTRAINT huc_practice_relations_pkey PRIMARY KEY (huc_practice_id);


--
-- TOC entry 4314 (class 2606 OID 19721)
-- Name: practices practice_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.practices
    ADD CONSTRAINT practice_id_pk PRIMARY KEY (practice_id);


--
-- TOC entry 4318 (class 2606 OID 27925)
-- Name: practice_types practice_type_primary_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.practice_types
    ADD CONSTRAINT practice_type_primary_key PRIMARY KEY (practice_type_id);


--
-- TOC entry 4320 (class 2606 OID 27918)
-- Name: practice_types unique_practice_type_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.practice_types
    ADD CONSTRAINT unique_practice_type_id UNIQUE (practice_type_id);


--
-- TOC entry 4308 (class 1259 OID 19724)
-- Name: huc8_geo_data_geom_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX huc8_geo_data_geom_idx ON public.huc8 USING gist (geom);


--
-- TOC entry 4322 (class 2606 OID 27813)
-- Name: huc_practice_relations fk_huc8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.huc_practice_relations
    ADD CONSTRAINT fk_huc8 FOREIGN KEY (huc8_id) REFERENCES public.huc8(huc8);


--
-- TOC entry 4323 (class 2606 OID 27818)
-- Name: huc_practice_relations fk_practice; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.huc_practice_relations
    ADD CONSTRAINT fk_practice FOREIGN KEY (practice_id) REFERENCES public.practices(practice_id);


--
-- TOC entry 4321 (class 2606 OID 27919)
-- Name: practices fkey_practice_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.practices
    ADD CONSTRAINT fkey_practice_type_id FOREIGN KEY (type_id) REFERENCES public.practice_types(practice_type_id) NOT VALID;


--
-- TOC entry 4324 (class 2606 OID 27803)
-- Name: huc_practice_relations huc_practice_relations_huc8_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.huc_practice_relations
    ADD CONSTRAINT huc_practice_relations_huc8_id_fkey FOREIGN KEY (huc8_id) REFERENCES public.huc8(huc8);


--
-- TOC entry 4325 (class 2606 OID 27808)
-- Name: huc_practice_relations huc_practice_relations_practice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.huc_practice_relations
    ADD CONSTRAINT huc_practice_relations_practice_id_fkey FOREIGN KEY (practice_id) REFERENCES public.practices(practice_id);


-- Completed on 2022-09-25 14:41:35 CDT

--
-- PostgreSQL database dump complete
--

