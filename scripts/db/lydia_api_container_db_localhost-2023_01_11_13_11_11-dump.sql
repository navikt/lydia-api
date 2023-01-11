--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6 (Debian 14.6-1.pgdg110+1)
-- Dumped by pg_dump version 14.5

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

ALTER TABLE IF EXISTS ONLY public.virksomhet_naring DROP CONSTRAINT IF EXISTS fk_virksomhet_naring_virksomhet;
ALTER TABLE IF EXISTS ONLY public.virksomhet_naring DROP CONSTRAINT IF EXISTS fk_virksomhet_naring_naring;
ALTER TABLE IF EXISTS ONLY public.ia_sak_hendelse DROP CONSTRAINT IF EXISTS fk_ia_sak_hendelse_virksomhet;
ALTER TABLE IF EXISTS ONLY public.ia_sak DROP CONSTRAINT IF EXISTS fk_ia_sak_endret_av_hendelse;
ALTER TABLE IF EXISTS ONLY public.hendelse_begrunnelse DROP CONSTRAINT IF EXISTS fk_hendelse_begrunnelse;
DROP INDEX IF EXISTS public.idx_virksomhet_kommunenr;
DROP INDEX IF EXISTS public.idx_sykefraver_periode_tapte_dagsverk;
DROP INDEX IF EXISTS public.idx_sykefravar_statistikk_virksomhet_kvartal;
DROP INDEX IF EXISTS public.idx_sykefravar_statistikk_virksomhet_arstall;
DROP INDEX IF EXISTS public.idx_sektor_kode_sykefravar_statistikk_sektor;
DROP INDEX IF EXISTS public.idx_orgnr_virksomhet_statistikk_metadata;
DROP INDEX IF EXISTS public.idx_orgnr_sykefravar_statistikk_virksomhet;
DROP INDEX IF EXISTS public.idx_naringsundergruppe_sykefravar_statistikk_naringsundergruppe;
DROP INDEX IF EXISTS public.idx_naring_sykefravar_statistikk_naring;
DROP INDEX IF EXISTS public.idx_land_sykefravar_statistikk_land;
DROP INDEX IF EXISTS public.idx_ia_sak_status;
DROP INDEX IF EXISTS public.idx_ia_sak_orgnr;
DROP INDEX IF EXISTS public.idx_ia_sak_hendelse_saksnummer;
DROP INDEX IF EXISTS public.idx_ia_sak_hendelse_orgnr;
DROP INDEX IF EXISTS public.flyway_schema_history_s_idx;
ALTER TABLE IF EXISTS ONLY public.virksomhet DROP CONSTRAINT IF EXISTS virksomhet_unik_orgnr;
ALTER TABLE IF EXISTS ONLY public.virksomhet_statistikk_metadata DROP CONSTRAINT IF EXISTS virksomhet_statistikk_metadata_unik_orgnr;
ALTER TABLE IF EXISTS ONLY public.virksomhet DROP CONSTRAINT IF EXISTS virksomhet_pkey;
ALTER TABLE IF EXISTS ONLY public.virksomhet_naring DROP CONSTRAINT IF EXISTS virksomhet_naring_unik;
ALTER TABLE IF EXISTS ONLY public.virksomhet_statistikk_metadata DROP CONSTRAINT IF EXISTS virksomhet_metadata_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet_siste_4_kvartal DROP CONSTRAINT IF EXISTS sykefravar_statistikk_virksomhet_siste_4_kvartal_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet_siste_4_kvartal DROP CONSTRAINT IF EXISTS sykefravar_statistikk_virksomhet_siste_4_kvartal_orgnr_key;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet DROP CONSTRAINT IF EXISTS sykefravar_statistikk_virksomhet_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_sektor DROP CONSTRAINT IF EXISTS sykefravar_statistikk_sektor_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naringsundergruppe DROP CONSTRAINT IF EXISTS sykefravar_statistikk_naringsundergruppe_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naring DROP CONSTRAINT IF EXISTS sykefravar_statistikk_naring_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_land DROP CONSTRAINT IF EXISTS sykefravar_statistikk_land_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_kategori_siste_4_kvartal DROP CONSTRAINT IF EXISTS sykefravar_statistikk_kategori_siste_4_kvartal_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet DROP CONSTRAINT IF EXISTS sykefravar_periode;
ALTER TABLE IF EXISTS ONLY public.sektor DROP CONSTRAINT IF EXISTS sektor_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_sektor DROP CONSTRAINT IF EXISTS sektor_periode;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naringsundergruppe DROP CONSTRAINT IF EXISTS naringsundergruppe_periode;
ALTER TABLE IF EXISTS ONLY public.naring DROP CONSTRAINT IF EXISTS naring_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naring DROP CONSTRAINT IF EXISTS naring_periode;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_land DROP CONSTRAINT IF EXISTS land_periode;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_kategori_siste_4_kvartal DROP CONSTRAINT IF EXISTS kategori_og_kode;
ALTER TABLE IF EXISTS ONLY public.ia_sak DROP CONSTRAINT IF EXISTS ia_sak_pkey;
ALTER TABLE IF EXISTS ONLY public.ia_sak_hendelse DROP CONSTRAINT IF EXISTS ia_sak_hendelse_pkey;
ALTER TABLE IF EXISTS ONLY public.flyway_schema_history DROP CONSTRAINT IF EXISTS flyway_schema_history_pk;
ALTER TABLE IF EXISTS public.virksomhet_statistikk_metadata ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.virksomhet ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_virksomhet_siste_4_kvartal ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_virksomhet ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_sektor ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_naringsundergruppe ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_naring ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_land ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_kategori_siste_4_kvartal ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS public.virksomhet_naring;
DROP SEQUENCE IF EXISTS public.virksomhet_metadata_id_seq;
DROP TABLE IF EXISTS public.virksomhet_statistikk_metadata;
DROP SEQUENCE IF EXISTS public.virksomhet_id_seq;
DROP TABLE IF EXISTS public.virksomhet;
DROP SEQUENCE IF EXISTS public.sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq;
DROP TABLE IF EXISTS public.sykefravar_statistikk_virksomhet_siste_4_kvartal;
DROP SEQUENCE IF EXISTS public.sykefravar_statistikk_virksomhet_id_seq;
DROP TABLE IF EXISTS public.sykefravar_statistikk_virksomhet;
DROP SEQUENCE IF EXISTS public.sykefravar_statistikk_sektor_id_seq;
DROP TABLE IF EXISTS public.sykefravar_statistikk_sektor;
DROP SEQUENCE IF EXISTS public.sykefravar_statistikk_naringsundergruppe_id_seq;
DROP TABLE IF EXISTS public.sykefravar_statistikk_naringsundergruppe;
DROP SEQUENCE IF EXISTS public.sykefravar_statistikk_naring_id_seq;
DROP TABLE IF EXISTS public.sykefravar_statistikk_naring;
DROP SEQUENCE IF EXISTS public.sykefravar_statistikk_land_id_seq;
DROP TABLE IF EXISTS public.sykefravar_statistikk_land;
DROP SEQUENCE IF EXISTS public.sykefravar_statistikk_kategori_siste_4_kvartal_id_seq;
DROP TABLE IF EXISTS public.sykefravar_statistikk_kategori_siste_4_kvartal;
DROP TABLE IF EXISTS public.sektor;
DROP TABLE IF EXISTS public.naring;
DROP TABLE IF EXISTS public.ia_sak_hendelse;
DROP TABLE IF EXISTS public.ia_sak;
DROP TABLE IF EXISTS public.hendelse_begrunnelse;
DROP TABLE IF EXISTS public.flyway_schema_history;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: test
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO test;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: test
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO test;

--
-- Name: hendelse_begrunnelse; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.hendelse_begrunnelse (
    hendelse_id character varying NOT NULL,
    aarsak character varying NOT NULL,
    begrunnelse character varying NOT NULL,
    aarsak_enum character varying NOT NULL,
    begrunnelse_enum character varying NOT NULL
);


ALTER TABLE public.hendelse_begrunnelse OWNER TO test;

--
-- Name: ia_sak; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.ia_sak (
    saksnummer character varying(26) NOT NULL,
    orgnr character varying(20) NOT NULL,
    status character varying NOT NULL,
    opprettet_av character varying NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    endret_av character varying,
    endret timestamp without time zone,
    endret_av_hendelse character varying,
    eid_av character varying
);


ALTER TABLE public.ia_sak OWNER TO test;

--
-- Name: ia_sak_hendelse; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.ia_sak_hendelse (
    id character varying NOT NULL,
    saksnummer character varying NOT NULL,
    orgnr character varying(20) NOT NULL,
    type character varying NOT NULL,
    opprettet_av character varying NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ia_sak_hendelse OWNER TO test;

--
-- Name: naring; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.naring (
    kode character varying NOT NULL,
    navn character varying NOT NULL,
    kort_navn character varying
);


ALTER TABLE public.naring OWNER TO test;

--
-- Name: sektor; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.sektor (
    kode character varying NOT NULL,
    navn character varying(255) NOT NULL
);


ALTER TABLE public.sektor OWNER TO test;

--
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.sykefravar_statistikk_kategori_siste_4_kvartal (
    id integer NOT NULL,
    kategori character varying(20) NOT NULL,
    kode character varying(20) NOT NULL,
    tapte_dagsverk numeric,
    mulige_dagsverk numeric,
    prosent numeric,
    maskert boolean NOT NULL,
    antall_kvartaler smallint NOT NULL,
    kvartaler jsonb,
    sist_endret timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sykefravar_statistikk_kategori_siste_4_kvartal OWNER TO test;

--
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.sykefravar_statistikk_kategori_siste_4_kvartal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_kategori_siste_4_kvartal_id_seq OWNER TO test;

--
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.sykefravar_statistikk_kategori_siste_4_kvartal_id_seq OWNED BY public.sykefravar_statistikk_kategori_siste_4_kvartal.id;


--
-- Name: sykefravar_statistikk_land; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.sykefravar_statistikk_land (
    id integer NOT NULL,
    arstall smallint NOT NULL,
    kvartal smallint NOT NULL,
    land character varying NOT NULL,
    antall_personer numeric NOT NULL,
    tapte_dagsverk numeric NOT NULL,
    mulige_dagsverk numeric NOT NULL,
    prosent numeric NOT NULL,
    maskert boolean NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sykefravar_statistikk_land OWNER TO test;

--
-- Name: sykefravar_statistikk_land_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.sykefravar_statistikk_land_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_land_id_seq OWNER TO test;

--
-- Name: sykefravar_statistikk_land_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.sykefravar_statistikk_land_id_seq OWNED BY public.sykefravar_statistikk_land.id;


--
-- Name: sykefravar_statistikk_naring; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.sykefravar_statistikk_naring (
    id integer NOT NULL,
    arstall smallint NOT NULL,
    kvartal smallint NOT NULL,
    naring character varying NOT NULL,
    antall_personer numeric NOT NULL,
    tapte_dagsverk numeric NOT NULL,
    mulige_dagsverk numeric NOT NULL,
    prosent numeric NOT NULL,
    maskert boolean NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sykefravar_statistikk_naring OWNER TO test;

--
-- Name: sykefravar_statistikk_naring_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.sykefravar_statistikk_naring_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_naring_id_seq OWNER TO test;

--
-- Name: sykefravar_statistikk_naring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.sykefravar_statistikk_naring_id_seq OWNED BY public.sykefravar_statistikk_naring.id;


--
-- Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.sykefravar_statistikk_naringsundergruppe (
    id integer NOT NULL,
    arstall smallint NOT NULL,
    kvartal smallint NOT NULL,
    naringsundergruppe character varying NOT NULL,
    antall_personer numeric NOT NULL,
    tapte_dagsverk numeric NOT NULL,
    mulige_dagsverk numeric NOT NULL,
    prosent numeric NOT NULL,
    maskert boolean NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sykefravar_statistikk_naringsundergruppe OWNER TO test;

--
-- Name: sykefravar_statistikk_naringsundergruppe_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.sykefravar_statistikk_naringsundergruppe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_naringsundergruppe_id_seq OWNER TO test;

--
-- Name: sykefravar_statistikk_naringsundergruppe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.sykefravar_statistikk_naringsundergruppe_id_seq OWNED BY public.sykefravar_statistikk_naringsundergruppe.id;


--
-- Name: sykefravar_statistikk_sektor; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.sykefravar_statistikk_sektor (
    id integer NOT NULL,
    arstall smallint NOT NULL,
    kvartal smallint NOT NULL,
    sektor_kode character varying NOT NULL,
    antall_personer numeric NOT NULL,
    tapte_dagsverk numeric NOT NULL,
    mulige_dagsverk numeric NOT NULL,
    prosent numeric NOT NULL,
    maskert boolean NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sykefravar_statistikk_sektor OWNER TO test;

--
-- Name: sykefravar_statistikk_sektor_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.sykefravar_statistikk_sektor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_sektor_id_seq OWNER TO test;

--
-- Name: sykefravar_statistikk_sektor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.sykefravar_statistikk_sektor_id_seq OWNED BY public.sykefravar_statistikk_sektor.id;


--
-- Name: sykefravar_statistikk_virksomhet; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.sykefravar_statistikk_virksomhet (
    id integer NOT NULL,
    orgnr character varying(20) NOT NULL,
    arstall smallint NOT NULL,
    kvartal smallint NOT NULL,
    antall_personer numeric NOT NULL,
    tapte_dagsverk numeric NOT NULL,
    mulige_dagsverk numeric NOT NULL,
    sykefraversprosent numeric NOT NULL,
    maskert boolean NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    endret timestamp without time zone
);


ALTER TABLE public.sykefravar_statistikk_virksomhet OWNER TO test;

--
-- Name: sykefravar_statistikk_virksomhet_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.sykefravar_statistikk_virksomhet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_virksomhet_id_seq OWNER TO test;

--
-- Name: sykefravar_statistikk_virksomhet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.sykefravar_statistikk_virksomhet_id_seq OWNED BY public.sykefravar_statistikk_virksomhet.id;


--
-- Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.sykefravar_statistikk_virksomhet_siste_4_kvartal (
    id integer NOT NULL,
    orgnr character varying(20) NOT NULL,
    tapte_dagsverk numeric,
    mulige_dagsverk numeric,
    prosent numeric,
    maskert boolean NOT NULL,
    antall_kvartaler smallint NOT NULL,
    kvartaler jsonb,
    sist_endret timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sykefravar_statistikk_virksomhet_siste_4_kvartal OWNER TO test;

--
-- Name: sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq OWNER TO test;

--
-- Name: sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq OWNED BY public.sykefravar_statistikk_virksomhet_siste_4_kvartal.id;


--
-- Name: virksomhet; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.virksomhet (
    id integer NOT NULL,
    orgnr character varying NOT NULL,
    land character varying NOT NULL,
    landkode character varying NOT NULL,
    postnummer character varying NOT NULL,
    poststed character varying NOT NULL,
    kommune character varying NOT NULL,
    kommunenummer character varying NOT NULL,
    navn character varying DEFAULT ''::character varying NOT NULL,
    adresse text[] DEFAULT '{}'::text[] NOT NULL,
    status character varying DEFAULT 'AKTIV'::character varying NOT NULL,
    oppstartsdato date,
    oppdatertavbrregoppdateringsid bigint,
    opprettettidspunkt timestamp without time zone DEFAULT now() NOT NULL,
    sistendrettidspunkt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.virksomhet OWNER TO test;

--
-- Name: virksomhet_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.virksomhet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.virksomhet_id_seq OWNER TO test;

--
-- Name: virksomhet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.virksomhet_id_seq OWNED BY public.virksomhet.id;


--
-- Name: virksomhet_statistikk_metadata; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.virksomhet_statistikk_metadata (
    id integer NOT NULL,
    orgnr character varying NOT NULL,
    kategori character varying NOT NULL,
    sektor character varying NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.virksomhet_statistikk_metadata OWNER TO test;

--
-- Name: virksomhet_metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.virksomhet_metadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.virksomhet_metadata_id_seq OWNER TO test;

--
-- Name: virksomhet_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.virksomhet_metadata_id_seq OWNED BY public.virksomhet_statistikk_metadata.id;


--
-- Name: virksomhet_naring; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.virksomhet_naring (
    virksomhet integer NOT NULL,
    narings_kode character varying NOT NULL
);


ALTER TABLE public.virksomhet_naring OWNER TO test;

--
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_kategori_siste_4_kvartal ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_kategori_siste_4_kvartal_id_seq'::regclass);


--
-- Name: sykefravar_statistikk_land id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_land ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_land_id_seq'::regclass);


--
-- Name: sykefravar_statistikk_naring id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_naring ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_naring_id_seq'::regclass);


--
-- Name: sykefravar_statistikk_naringsundergruppe id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_naringsundergruppe ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_naringsundergruppe_id_seq'::regclass);


--
-- Name: sykefravar_statistikk_sektor id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_sektor ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_sektor_id_seq'::regclass);


--
-- Name: sykefravar_statistikk_virksomhet id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_virksomhet ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_virksomhet_id_seq'::regclass);


--
-- Name: sykefravar_statistikk_virksomhet_siste_4_kvartal id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_virksomhet_siste_4_kvartal ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq'::regclass);


--
-- Name: virksomhet id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet ALTER COLUMN id SET DEFAULT nextval('public.virksomhet_id_seq'::regclass);


--
-- Name: virksomhet_statistikk_metadata id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_statistikk_metadata ALTER COLUMN id SET DEFAULT nextval('public.virksomhet_metadata_id_seq'::regclass);


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', 'V1__init.sql', 1782034767, 'test', '2023-01-11 13:06:22.337639', 19, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', 'V2__create_virksomhet_adresse.sql', -64248919, 'test', '2023-01-11 13:06:22.393992', 15, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', 'V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2023-01-11 13:06:22.439295', 6, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', 'V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2023-01-11 13:06:22.463728', 5, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', 'V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2023-01-11 13:06:22.485703', 8, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', 'V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2023-01-11 13:06:22.510516', 6, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', 'V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2023-01-11 13:06:22.529075', 7, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', 'V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2023-01-11 13:06:22.551424', 6, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', 'V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2023-01-11 13:06:22.568627', 10, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', 'V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2023-01-11 13:06:22.594255', 5, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', 'V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2023-01-11 13:06:22.610997', 5, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', 'V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2023-01-11 13:06:22.629434', 6, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', 'V13__ia_prosess.sql', -1755516749, 'test', '2023-01-11 13:06:22.648126', 6, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', 'V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2023-01-11 13:06:22.663653', 12, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', 'V15__endre_saknummer.sql', -1379621340, 'test', '2023-01-11 13:06:22.69289', 6, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', 'V16__ia_sak_hendelse.sql', 586872662, 'test', '2023-01-11 13:06:22.710014', 10, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', 'V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2023-01-11 13:06:22.735809', 11, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', 'V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2023-01-11 13:06:22.756979', 10, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', 'V19__legg_til_begrunnelser.sql', 779259005, 'test', '2023-01-11 13:06:22.782853', 5, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', 'V20__legg_til_flere_indekser.sql', -843857404, 'test', '2023-01-11 13:06:22.800189', 6, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', 'V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2023-01-11 13:06:22.816187', 3, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', 'V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2023-01-11 13:06:22.82858', 4, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', 'V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2023-01-11 13:06:22.842507', 7, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', 'V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2023-01-11 13:06:22.860927', 7, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', 'V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2023-01-11 13:06:22.879378', 15, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', 'V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2023-01-11 13:06:22.905724', 5, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', 'V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2023-01-11 13:06:22.918424', 4, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', 'V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2023-01-11 13:06:22.9305', 4, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', 'V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2023-01-11 13:06:22.942235', 5, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', 'V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2023-01-11 13:06:22.954895', 6, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', 'V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2023-01-11 13:06:22.970798', 7, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', 'V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2023-01-11 13:06:22.98841', 9, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', 'V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2023-01-11 13:06:23.017859', 7, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', 'V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2023-01-11 13:06:23.035611', 11, true);
INSERT INTO public.flyway_schema_history VALUES (35, '35', 'drop sykefravar statistikk grunnlag', 'SQL', 'V35__drop_sykefravar_statistikk_grunnlag.sql', 461103825, 'test', '2023-01-11 13:06:23.057491', 5, true);
INSERT INTO public.flyway_schema_history VALUES (36, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -28506308, 'test', '2023-01-11 13:06:23.070649', 12, true);
INSERT INTO public.flyway_schema_history VALUES (37, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -229433645, 'test', '2023-01-11 13:06:26.752732', 31, true);
INSERT INTO public.flyway_schema_history VALUES (38, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 1807041472, 'test', '2023-01-11 13:06:42.24095', 23, true);


--
-- Data for Name: hendelse_begrunnelse; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: ia_sak; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: ia_sak_hendelse; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.naring VALUES ('00.000', 'Uoppgitt', 'Uoppgitt');
INSERT INTO public.naring VALUES ('00', 'Uoppgitt', 'Uoppgitt');
INSERT INTO public.naring VALUES ('01', 'Næring', 'Kortnavn for 01');
INSERT INTO public.naring VALUES ('90', 'Næring', 'Kortnavn for 90');
INSERT INTO public.naring VALUES ('01.120', 'Dyrking av ris', 'Kortnavn for 01.120');
INSERT INTO public.naring VALUES ('90.012', 'Utøvende kunstnere og underholdningsvirksomhet innen scenekunst', 'Kortnavn for 90.012');
INSERT INTO public.naring VALUES ('70', 'Næring', 'Kortnavn for 70');
INSERT INTO public.naring VALUES ('70.220', 'Bedriftsrådgivning og annen administrativ rådgivning', 'Kortnavn for 70.220');
INSERT INTO public.naring VALUES ('01.110', 'Dyrking av korn, unntatt ris', 'Kortnavn for 01.110');


--
-- Data for Name: sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_kategori_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_land; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_land VALUES (1, 2022, 3, 'NO', 2500000, 10000000, 500000000, 2, false, '2023-01-11 13:06:30.360883');
INSERT INTO public.sykefravar_statistikk_land VALUES (2, 2022, 2, 'NO', 2500000, 10000000, 500000000, 2, false, '2023-01-11 13:06:30.419584');


--
-- Data for Name: sykefravar_statistikk_naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naring VALUES (1, 2022, 3, '01', 150, 100, 5000, 2, false, '2023-01-11 13:06:30.360883');
INSERT INTO public.sykefravar_statistikk_naring VALUES (2, 2022, 2, '01', 150, 100, 5000, 2, false, '2023-01-11 13:06:30.419584');


--
-- Data for Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naringsundergruppe VALUES (1, 2022, 3, '01.110', 1250, 40, 4000, 1, false, '2023-01-11 13:06:30.360883');
INSERT INTO public.sykefravar_statistikk_naringsundergruppe VALUES (2, 2022, 2, '01.110', 1250, 40, 4000, 1, false, '2023-01-11 13:06:30.419584');


--
-- Data for Name: sykefravar_statistikk_sektor; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_sektor VALUES (1, 2022, 3, '1', 33000, 1340, 8000, 1.5, false, '2023-01-11 13:06:30.360883');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (2, 2022, 2, '1', 33000, 1340, 8000, 1.5, false, '2023-01-11 13:06:30.419584');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (14, 2022, 3, '2', 33000, 1340, 8000, 1.5, false, '2023-01-11 13:06:30.491876');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (15, 2022, 3, '0', 33000, 1340, 8000, 1.5, false, '2023-01-11 13:06:30.491876');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (17, 2022, 3, '3', 33000, 1340, 8000, 1.5, false, '2023-01-11 13:06:30.491876');


--
-- Data for Name: sykefravar_statistikk_virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2022, 3, 6, 9365.5385806238, 500, 12, false, '2023-01-11 13:06:30.360883', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2022, 2, 6, 9365.5385806238, 500, 4, false, '2023-01-11 13:06:30.419584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2022, 3, 931.57810008714, 7391.65354352409, 500, 7, false, '2023-01-11 13:06:30.419584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2022, 2, 931.57810008714, 7391.65354352409, 500, 7, false, '2023-01-11 13:06:30.419584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '555555555', 2022, 3, 234.537851373277, 1021.18850019126, 500, 18, false, '2023-01-11 13:06:30.419584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '881532376', 2022, 3, 663.924825875148, 3779.68988064686, 500, 6, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '881532376', 2022, 2, 663.924825875148, 3779.68988064686, 500, 6, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '883874352', 2022, 3, 42, 7013.50788484618, 500, 6, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '883874352', 2022, 2, 42, 7013.50788484618, 500, 6, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '848147638', 2022, 3, 42, 5557.88814673258, 500, 6, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '848147638', 2022, 2, 42, 5557.88814673258, 500, 6, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '876763949', 2022, 3, 478.82390716933, 5872.58620433572, 500, 19, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '876763949', 2022, 2, 478.82390716933, 5872.58620433572, 500, 18, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '871871807', 2022, 3, 358.284749898638, 3753.03554832438, 500, 4, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '864079801', 2022, 3, 497.19558920762, 2012.47545319462, 500, 1, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '836041617', 2022, 3, 552.845958723694, 2496.28820083561, 500, 10, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '857842260', 2022, 3, 771.536563287056, 7813.03911712495, 500, 11, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '885073621', 2022, 3, 928.040595782749, 9412.36628600224, 500, 15, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '864754605', 2022, 3, 624.659669500617, 7826.5545669624, 500, 14, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '846347581', 2022, 3, 963.300421071768, 4450.34482151051, 500, 1, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '824680794', 2022, 3, 10.691923392832, 8345.68720663147, 500, 5, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '839415001', 2022, 3, 376.154054798503, 5514.64661594725, 500, 13, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '861744528', 2022, 3, 683.459526950376, 6583.09617379438, 500, 7, false, '2023-01-11 13:06:30.491876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '860138909', 2022, 3, 581.248465848496, 980.274844808093, 500, 19, false, '2023-01-11 13:06:30.673266', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '843242104', 2022, 3, 952.423846879699, 161.783504250299, 500, 16, false, '2023-01-11 13:06:30.673266', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '890093850', 2022, 3, 444.715208608567, 2061.24791228539, 500, 8, false, '2023-01-11 13:06:30.673266', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '892511017', 2022, 3, 528.463177642731, 2323.42781112241, 500, 11, false, '2023-01-11 13:06:30.673266', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '842605109', 2022, 3, 539.329662759078, 5568.90679036946, 500, 2, false, '2023-01-11 13:06:30.673266', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '870491047', 2022, 3, 496.351050548606, 4771.84857308131, 500, 10, false, '2023-01-11 13:06:30.673266', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '863507760', 2022, 3, 425.148769820711, 3581.47349273366, 500, 7, false, '2023-01-11 13:06:30.673266', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '817257908', 2022, 3, 277.347945589595, 8576.90289497349, 500, 16, false, '2023-01-11 13:06:30.673266', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '809042383', 2022, 3, 659.464698465342, 7947.75557572465, 500, 14, false, '2023-01-11 13:06:30.673266', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '810734693', 2022, 3, 414.772767929091, 3713.37558109094, 500, 2, false, '2023-01-11 13:06:30.673266', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '804629062', 2022, 3, 427.053065333831, 4786.42869737423, 500, 2, false, '2023-01-11 13:06:30.673266', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '873621335', 2022, 3, 127.374938023119, 3369.96926995884, 500, 19, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '835058832', 2022, 3, 16.7666729884067, 7310.50662159552, 500, 10, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '803826652', 2022, 3, 690.429498819137, 8725.7370144098, 500, 3, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '874394467', 2022, 3, 661.411540562674, 575.731668074726, 500, 5, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '838903289', 2022, 3, 388.927202516392, 3550.16888081596, 500, 20, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '882051647', 2022, 3, 549.835790646643, 9726.28521402417, 500, 15, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '879681201', 2022, 3, 783.41951959861, 2681.13460493245, 500, 20, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '852409131', 2022, 3, 193.819443778783, 3834.46668395426, 500, 10, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '808215075', 2022, 3, 158.500600563689, 1558.28760184127, 500, 5, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '865074415', 2022, 3, 139.627567571298, 7748.85837287293, 500, 10, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '836669149', 2022, 3, 654.387207830695, 2854.70312456269, 500, 9, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '884369776', 2022, 3, 679.9958083657, 5573.90816154359, 500, 6, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '873418367', 2022, 3, 93.1882584070726, 7129.28455543243, 500, 10, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '802905016', 2022, 3, 6.88829654660646, 3176.09573426986, 500, 12, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '885609899', 2022, 3, 973.398696924965, 7276.82174133455, 500, 1, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '860836918', 2022, 3, 703.840402522627, 4645.03816157184, 500, 9, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '829745509', 2022, 3, 221.464239694748, 7396.94193686332, 500, 20, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '844246611', 2022, 3, 27.852619531252, 3088.49285544932, 500, 17, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '867216743', 2022, 3, 877.346590184825, 9097.8916685438, 500, 10, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '890941228', 2022, 3, 952.346881743432, 6153.61875117796, 500, 13, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '838540049', 2022, 3, 940.149383557895, 3905.50495059048, 500, 6, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '809501750', 2022, 3, 65.8980916857552, 9652.90963481968, 500, 8, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '844496478', 2022, 3, 266.551456885491, 9189.89856773547, 500, 13, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '863501025', 2022, 3, 645.374442775692, 9077.40295070081, 500, 16, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '839166324', 2022, 3, 967.125306594449, 2017.05732515683, 500, 19, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '879962157', 2022, 3, 133.275059524944, 320.98731180388, 500, 19, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '848543645', 2022, 3, 684.859926627814, 9810.35932083311, 500, 19, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '880279851', 2022, 3, 514.287676705319, 3458.54918966853, 500, 6, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '808671188', 2022, 3, 857.573977137201, 3703.03238183128, 500, 18, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '851333885', 2022, 3, 858.695880000144, 1529.76979033216, 500, 1, false, '2023-01-11 13:06:30.758814', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '815366017', 2022, 3, 454.910352085436, 9766.10109605796, 500, 3, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '891113900', 2022, 3, 604.838123648693, 9274.89262841256, 500, 17, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '894926128', 2022, 3, 824.236276687361, 9661.63125476056, 500, 12, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '802290404', 2022, 3, 580.380269104141, 2091.40286984746, 500, 11, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '896239097', 2022, 3, 691.424451099766, 44.1334563157848, 500, 1, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '816868949', 2022, 3, 927.597148120249, 281.445983114234, 500, 13, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '895298219', 2022, 3, 113.54418616107, 2613.30099900213, 500, 18, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '842893897', 2022, 3, 571.666920860246, 8020.84897948973, 500, 20, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '814670938', 2022, 3, 856.227350028867, 9846.04362099609, 500, 16, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '820433803', 2022, 3, 934.229345563307, 924.821248433015, 500, 6, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '874104569', 2022, 3, 995.242099669578, 165.202440118429, 500, 10, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '856520283', 2022, 3, 153.974909532557, 8093.98949141047, 500, 9, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '879090305', 2022, 3, 109.355695444433, 5216.97647209787, 500, 19, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '809468321', 2022, 3, 989.416990679143, 1011.770371269, 500, 13, false, '2023-01-11 13:06:31.002485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '826378947', 2022, 3, 36.2534003099316, 1703.12477321642, 500, 19, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '866390365', 2022, 3, 913.356913902797, 5178.39676841926, 500, 16, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '862771013', 2022, 3, 530.462177342565, 6373.26707455638, 500, 20, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '864363318', 2022, 3, 205.275280025599, 4453.05354074083, 500, 17, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '896438075', 2022, 3, 79.7844292498188, 2812.49134917998, 500, 20, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '829368106', 2022, 3, 555.432236907753, 7611.06487599627, 500, 7, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '867407313', 2022, 3, 911.06940427839, 1762.79374883324, 500, 10, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '896587504', 2022, 3, 752.378709699797, 4505.36172950016, 500, 2, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '847845944', 2022, 3, 980.20918668024, 2967.30580996577, 500, 7, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '826389298', 2022, 3, 861.073804921292, 8571.12167478316, 500, 17, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '848399886', 2022, 3, 589.891821385094, 8596.50039889448, 500, 14, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '854846835', 2022, 3, 707.823377295914, 6588.20436273446, 500, 5, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '800634899', 2022, 3, 890.055537957075, 7655.82255192136, 500, 3, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '857110616', 2022, 3, 144.638152949826, 264.888915985379, 500, 7, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '808271586', 2022, 3, 12.6580153908253, 2794.33443383865, 500, 19, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '819801010', 2022, 3, 532.843683911448, 5454.04572113711, 500, 20, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '848578637', 2022, 3, 35.8084659827274, 797.008518337617, 500, 8, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '827490752', 2022, 3, 613.255387707658, 3808.53909162524, 500, 20, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '835736810', 2022, 3, 67.5120526670877, 1172.15012126137, 500, 6, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '857544475', 2022, 3, 810.140743376934, 9596.00071273121, 500, 19, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '847721823', 2022, 3, 833.556504280633, 8613.13826796056, 500, 7, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '862581603', 2022, 3, 724.787225343674, 1995.67910803829, 500, 18, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '810313500', 2022, 3, 63.5533431089989, 3435.11530824208, 500, 1, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '885129733', 2022, 3, 141.125428980027, 3456.54712173968, 500, 2, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '898243796', 2022, 3, 491.84402507959, 7967.09528484178, 500, 18, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '887079787', 2022, 3, 286.036842569569, 6349.55700412723, 500, 4, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '861058672', 2022, 3, 750.122008594931, 2047.35460600132, 500, 1, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '876537913', 2022, 3, 8.32482008775481, 5243.69447443562, 500, 2, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '890597928', 2022, 3, 130.868343159912, 1522.14252477412, 500, 8, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '842982051', 2022, 3, 464.301049613024, 3329.63135654566, 500, 14, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '842389667', 2022, 3, 768.957716113451, 6536.32619542003, 500, 15, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '820004072', 2022, 3, 491.238829141773, 9498.71272431279, 500, 4, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '897688257', 2022, 3, 34.5828663024978, 9668.70994112268, 500, 11, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '837534390', 2022, 3, 503.983626315742, 3741.67329692534, 500, 10, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '808543637', 2022, 3, 934.472254120983, 3351.83668154388, 500, 9, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '870201888', 2022, 3, 927.870639786657, 1268.53145846032, 500, 15, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '817311070', 2022, 3, 751.366010665769, 7752.09620794699, 500, 16, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '868012776', 2022, 3, 851.544318168884, 3632.72216708459, 500, 15, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '896429753', 2022, 3, 970.42115405705, 9841.96484849155, 500, 8, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '851603425', 2022, 3, 786.709968552687, 7936.89739312716, 500, 4, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '827443317', 2022, 3, 901.414043946751, 3464.62005133511, 500, 9, false, '2023-01-11 13:06:31.105832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '833362642', 2022, 3, 471.516592258444, 4785.94017546028, 500, 19, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '882069408', 2022, 3, 816.453136124097, 428.016572550953, 500, 1, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '863878944', 2022, 3, 710.301123586626, 8294.25393026687, 500, 17, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '866558221', 2022, 3, 280.227770169398, 3258.50744665762, 500, 4, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '868767855', 2022, 3, 69.1374642548442, 4754.71583085083, 500, 5, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '875885300', 2022, 3, 708.584366486377, 5491.17271104301, 500, 5, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '842216735', 2022, 3, 84.8052757108351, 5365.99245961874, 500, 17, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '856920437', 2022, 3, 905.149976132556, 5630.26711641425, 500, 1, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '830858963', 2022, 3, 204.612570528117, 8948.70829156906, 500, 11, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '812434114', 2022, 3, 473.380973594816, 2852.28020427605, 500, 1, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '847041353', 2022, 3, 373.052944002136, 6038.19815783, 500, 4, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '803269327', 2022, 3, 215.480863689112, 4674.39988354255, 500, 3, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '843457384', 2022, 3, 954.609180421512, 7080.73546743112, 500, 5, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '818306281', 2022, 3, 472.06154929044, 7352.48749353287, 500, 7, false, '2023-01-11 13:06:31.322482', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '844449510', 2022, 3, 116.438245957719, 2699.87416438165, 500, 13, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '867177223', 2022, 3, 825.513344080211, 9562.03270700296, 500, 13, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '883963814', 2022, 3, 30.4962529242319, 2398.27634885428, 500, 14, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '886253015', 2022, 3, 861.379963993347, 6544.97639737846, 500, 8, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '895281822', 2022, 3, 635.646771840243, 7476.6652642158, 500, 2, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '840533481', 2022, 3, 340.591180533347, 2099.16814055973, 500, 6, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '839216776', 2022, 3, 44.3913090209069, 4511.2520292696, 500, 11, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '803533948', 2022, 3, 591.986123595866, 3563.97061182099, 500, 8, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '827095124', 2022, 3, 19.4292118085598, 1010.07569186975, 500, 14, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '808251981', 2022, 3, 709.861281737987, 8307.59766125223, 500, 3, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '817358823', 2022, 3, 462.89356534481, 1428.71526928241, 500, 11, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '871910327', 2022, 3, 386.184925211354, 455.470678844676, 500, 15, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '866587133', 2022, 3, 130.979444382145, 9301.16078009932, 500, 6, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '842840788', 2022, 3, 960.596274305678, 921.357945737936, 500, 19, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '812781923', 2022, 3, 376.343171083173, 9649.48111821052, 500, 1, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '804058381', 2022, 3, 180.227460040231, 5489.44163879611, 500, 8, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '811423248', 2022, 3, 900.463396818458, 1570.42401146895, 500, 16, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '840837641', 2022, 3, 234.29965710833, 5764.54212062968, 500, 10, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '818816392', 2022, 3, 660.734532586101, 2093.51298329787, 500, 13, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '806494928', 2022, 3, 738.699032494141, 6014.73535907213, 500, 12, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '893055618', 2022, 3, 440.752339413794, 7013.17827657494, 500, 18, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '875340822', 2022, 3, 381.796750331065, 1879.99753398562, 500, 4, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '818463756', 2022, 3, 182.505448889203, 2409.42579636398, 500, 8, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '884152302', 2022, 3, 209.541005080725, 2566.15622912562, 500, 17, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '849742742', 2022, 3, 175.383049520892, 7849.72060620984, 500, 19, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '804979817', 2022, 3, 116.202202461195, 4035.73233224922, 500, 10, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '814190896', 2022, 3, 910.965831691622, 339.063207484028, 500, 19, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '822331640', 2022, 3, 45.0928554094917, 3625.75550262823, 500, 11, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '862678317', 2022, 3, 278.580809802482, 1279.75193872779, 500, 7, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '831093023', 2022, 3, 204.072124584049, 3445.91589970061, 500, 10, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '874226454', 2022, 3, 417.215378429065, 3605.39147778564, 500, 8, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '832436811', 2022, 3, 78.2896721758288, 754.523020575193, 500, 8, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '838432048', 2022, 3, 404.886809492446, 5127.32043763342, 500, 10, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '870022919', 2022, 3, 556.593045801233, 2035.82747286523, 500, 17, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '879268334', 2022, 3, 907.51324072272, 829.388098556909, 500, 8, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '806599852', 2022, 3, 169.655197109359, 3607.67827648517, 500, 15, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '863181199', 2022, 3, 419.711080419845, 6712.02025711694, 500, 10, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '863767568', 2022, 3, 425.964967774753, 3872.96863177205, 500, 4, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '844014636', 2022, 3, 338.148573786733, 9429.54616029289, 500, 12, false, '2023-01-11 13:06:31.439627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '866404710', 2022, 3, 539.086468926378, 5841.94503174918, 500, 16, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '833129946', 2022, 3, 116.126009952881, 5041.92248197155, 500, 7, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '846977998', 2022, 3, 888.92488504402, 6869.51047464923, 500, 6, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '811030348', 2022, 3, 403.341247765711, 3492.95234344701, 500, 18, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '890815907', 2022, 3, 748.323726408432, 3394.69421017937, 500, 6, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '822694021', 2022, 3, 805.14986207532, 3252.48896156285, 500, 15, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '852558904', 2022, 3, 283.851646875255, 507.086043201649, 500, 19, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '822874914', 2022, 3, 200.006062067817, 7144.79347794333, 500, 1, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '866646453', 2022, 3, 401.849710922808, 9795.48975644455, 500, 14, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '881021956', 2022, 3, 80.860964902493, 7002.675595211, 500, 3, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '899291735', 2022, 3, 941.984192985765, 2745.57933863854, 500, 12, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '867918928', 2022, 3, 634.499764955117, 4146.6153526148, 500, 18, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '823439458', 2022, 3, 688.272027031866, 9747.72378347414, 500, 6, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '837805347', 2022, 3, 24.3744411949556, 2610.42459727785, 500, 3, false, '2023-01-11 13:06:31.683286', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '805499088', 2022, 3, 769.381778855634, 5804.41245210148, 500, 12, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '845822610', 2022, 3, 476.55557555519, 3198.65571607792, 500, 10, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '841405633', 2022, 3, 176.695274152466, 1583.4439368204, 500, 5, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '889675608', 2022, 3, 39.3607090266882, 5216.52601190864, 500, 8, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '899025387', 2022, 3, 569.840477645865, 553.108872998917, 500, 9, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '863280835', 2022, 3, 117.052390971835, 4341.14434272795, 500, 16, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '860629673', 2022, 3, 681.74761769152, 4928.40792077931, 500, 15, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '833667497', 2022, 3, 979.70745282014, 7053.74322992898, 500, 10, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '842471044', 2022, 3, 773.431894902908, 508.030129735448, 500, 12, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '861459803', 2022, 3, 210.885209798677, 5861.74064576915, 500, 9, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '812926032', 2022, 3, 20.1864562067938, 2032.05354646212, 500, 14, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '871631319', 2022, 3, 980.721511214171, 4934.43779556168, 500, 14, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '865439281', 2022, 3, 722.208308791647, 6589.39082026731, 500, 17, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '824210548', 2022, 3, 97.9579748393018, 1219.26332111095, 500, 5, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '805486005', 2022, 3, 862.777607153485, 4954.70469838802, 500, 3, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '832448472', 2022, 3, 76.8043698476959, 6508.68434033924, 500, 1, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '805820685', 2022, 3, 91.0260435437359, 5323.08200452427, 500, 19, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '883768894', 2022, 3, 955.791563022838, 6439.92410845175, 500, 12, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '856903021', 2022, 3, 747.815509694485, 2812.04156501953, 500, 4, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '850012745', 2022, 3, 187.146943103629, 7156.40613495964, 500, 1, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '820149848', 2022, 3, 103.324703894261, 3440.58337597068, 500, 10, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '822705108', 2022, 3, 721.035981800167, 9921.65969567091, 500, 5, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '857573851', 2022, 3, 560.094181607596, 9455.86839328205, 500, 12, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '856078198', 2022, 3, 255.155017705909, 6204.51439095816, 500, 19, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '859225721', 2022, 3, 759.524321400079, 2631.55057386213, 500, 7, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '873879874', 2022, 3, 646.157367425546, 3838.98645569895, 500, 11, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '890065285', 2022, 3, 717.327137123175, 714.936785399262, 500, 7, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '893423280', 2022, 3, 690.079780049792, 3096.68893006439, 500, 20, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '816273126', 2022, 3, 950.113512596641, 2191.30209451992, 500, 10, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '874977909', 2022, 3, 564.988529813518, 3555.63448760055, 500, 17, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '888632161', 2022, 3, 266.513618637421, 6926.51456253768, 500, 12, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '852452427', 2022, 3, 930.423817285281, 4268.88242863796, 500, 9, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '807389236', 2022, 3, 466.69694964328, 8715.59194460675, 500, 16, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '833163111', 2022, 3, 765.366088564365, 8449.61709710598, 500, 7, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '813080832', 2022, 3, 876.620600396814, 6472.01758087736, 500, 1, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '896489260', 2022, 3, 662.068610934185, 1973.83460636143, 500, 13, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '845881839', 2022, 3, 65.162799953575, 6889.29783961865, 500, 19, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '898157169', 2022, 3, 373.837375319182, 3704.18659394271, 500, 13, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '882940656', 2022, 3, 814.21705777765, 5663.34355536998, 500, 10, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '887589106', 2022, 3, 730.300951465456, 1329.54237875677, 500, 12, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '856439808', 2022, 3, 41.8004224056644, 5343.05335596406, 500, 8, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '869911712', 2022, 3, 86.5615231111411, 2389.27536397529, 500, 17, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '836420677', 2022, 3, 428.938592336107, 2573.89271431274, 500, 6, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '810521018', 2022, 3, 61.0687337452767, 6040.53891513578, 500, 13, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '863021621', 2022, 3, 992.005340556118, 4594.75397242533, 500, 7, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '846289494', 2022, 3, 605.628170052176, 4829.68690202878, 500, 6, false, '2023-01-11 13:06:31.817827', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '834191416', 2022, 3, 339.614587851471, 9633.02299613335, 500, 5, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '837420340', 2022, 3, 359.772942609935, 3977.75305361092, 500, 12, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '871949311', 2022, 3, 418.252968434286, 5035.69563517599, 500, 18, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '821633142', 2022, 3, 956.84135967723, 9433.88860640258, 500, 3, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '893463166', 2022, 3, 233.494953844205, 4518.64201054558, 500, 1, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '833218825', 2022, 3, 182.813198806002, 3104.03560777977, 500, 16, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '807456455', 2022, 3, 828.167995594992, 7621.37149295836, 500, 11, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '821381486', 2022, 3, 712.79521443398, 1541.43089090489, 500, 1, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '814324199', 2022, 3, 289.011673426835, 5023.14874950078, 500, 9, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '805904949', 2022, 3, 348.874482332478, 801.268375885762, 500, 15, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '813242515', 2022, 3, 93.1612941371107, 3110.39416066302, 500, 11, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '839415843', 2022, 3, 717.235542831523, 6797.91909309106, 500, 15, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '804234371', 2022, 3, 507.401420898755, 7034.60918426733, 500, 11, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '816585946', 2022, 3, 796.367920771506, 7539.73694163413, 500, 17, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '824097835', 2022, 3, 664.889602148834, 256.603938757907, 500, 4, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '880538674', 2022, 3, 17.2032030764655, 5739.14939673326, 500, 1, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '875775705', 2022, 3, 751.796248291944, 9383.07849137505, 500, 3, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '877421692', 2022, 3, 781.256570684926, 6554.06654388593, 500, 3, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '871547736', 2022, 3, 460.262464310619, 7193.62809103146, 500, 8, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '857653378', 2022, 3, 882.657551738563, 5364.12134661392, 500, 13, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '829980700', 2022, 3, 564.408800421388, 6558.71181470824, 500, 10, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '852627790', 2022, 3, 801.880793340121, 4136.83517856652, 500, 13, false, '2023-01-11 13:06:32.075809', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '865978526', 2022, 3, 38.0817606000461, 1804.08697200741, 500, 14, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '840145629', 2022, 3, 157.770656067624, 734.887186268998, 500, 10, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '875016141', 2022, 3, 850.968505741444, 4905.57223617159, 500, 2, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '869419134', 2022, 3, 197.696600165454, 7091.40823497954, 500, 9, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '813944600', 2022, 3, 452.266332557629, 8062.87768712455, 500, 10, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '885600454', 2022, 3, 8.98072243020098, 1079.80740729373, 500, 2, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '877550656', 2022, 3, 791.497707256651, 8313.27299217338, 500, 9, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '804227830', 2022, 3, 757.544859078924, 6980.22559147847, 500, 20, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '858956619', 2022, 3, 844.98248211467, 3350.82331367884, 500, 3, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '865153645', 2022, 3, 347.714414448928, 8253.43293392586, 500, 15, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '817941723', 2022, 3, 765.650094544818, 7785.04654189184, 500, 7, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '811667993', 2022, 3, 920.95318204212, 3694.15729783347, 500, 10, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '859462534', 2022, 3, 696.361734709523, 2542.07106276734, 500, 11, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '822317092', 2022, 3, 890.569413539093, 9757.85797241348, 500, 10, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '877772835', 2022, 3, 388.598745853566, 4123.40854103184, 500, 1, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '846495295', 2022, 3, 515.229091435576, 6940.53709241877, 500, 18, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '804775869', 2022, 3, 448.173075730051, 607.99845400596, 500, 15, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '831030012', 2022, 3, 776.816600622195, 9177.28926067278, 500, 7, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '802809462', 2022, 3, 786.391534003399, 8106.32371777374, 500, 6, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '896200151', 2022, 3, 585.647009830604, 8500.04846263991, 500, 11, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '873610100', 2022, 3, 56.8925564286632, 9567.01247502744, 500, 4, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '847931581', 2022, 3, 648.075368785715, 5040.35415208718, 500, 1, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '870810427', 2022, 3, 399.928339891513, 2215.44310246097, 500, 2, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '816457914', 2022, 3, 824.589362724874, 9418.40639229608, 500, 13, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '816760477', 2022, 3, 796.599017264862, 6687.73881754978, 500, 14, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '821449527', 2022, 3, 106.097110886848, 8968.88218579413, 500, 5, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '897412997', 2022, 3, 809.464375253204, 7526.26047650483, 500, 9, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '801856356', 2022, 3, 219.349667055843, 8769.76146465971, 500, 9, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '898170941', 2022, 3, 979.048134136851, 8777.68991279107, 500, 5, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '884390144', 2022, 3, 187.958658470279, 9767.44526525106, 500, 7, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '894424841', 2022, 3, 440.003252789697, 161.928711359936, 500, 16, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '828972512', 2022, 3, 169.750738698938, 6467.22322640608, 500, 16, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '815082581', 2022, 3, 52.7061109321536, 915.248854597949, 500, 10, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '887159012', 2022, 3, 621.830157992396, 489.856439829547, 500, 8, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '829493874', 2022, 3, 242.962991778246, 7718.9085229476, 500, 17, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '814929193', 2022, 3, 241.456641179521, 4033.0119386274, 500, 7, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '859907302', 2022, 3, 343.751474878829, 3418.71199775992, 500, 11, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '895124699', 2022, 3, 77.8915428902051, 2818.28691488708, 500, 1, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '813239227', 2022, 3, 69.7330420760289, 5444.7018279803, 500, 6, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '840430296', 2022, 3, 50.7159509355956, 2252.87300969911, 500, 5, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '858726639', 2022, 3, 707.758253387218, 242.444903356643, 500, 19, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '823234800', 2022, 3, 810.187633395297, 2585.26965187722, 500, 12, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '874361830', 2022, 3, 428.203744409414, 8507.25963953563, 500, 9, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '808481735', 2022, 3, 816.958856695658, 4960.11322689511, 500, 3, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '860499175', 2022, 3, 666.382426866125, 3747.09340733199, 500, 12, false, '2023-01-11 13:06:32.2109', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '892697142', 2022, 3, 500.722963653273, 5682.43961420226, 500, 6, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '826727890', 2022, 3, 609.45376975072, 6740.3745056341, 500, 20, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '895582762', 2022, 3, 212.742197534126, 4467.78953075589, 500, 5, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '814663914', 2022, 3, 852.165310738995, 7420.56537969301, 500, 19, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '887191975', 2022, 3, 768.995659848882, 4610.43138247589, 500, 1, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '856729012', 2022, 3, 9.80353081196038, 1485.01554181639, 500, 20, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '816248533', 2022, 3, 337.576766296403, 487.290869528983, 500, 12, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '847253663', 2022, 3, 185.992876536751, 9002.46353695235, 500, 9, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '851556995', 2022, 3, 847.777212467558, 8873.57362765091, 500, 2, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '897000352', 2022, 3, 178.659120093876, 1426.8037148357, 500, 16, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '891267708', 2022, 3, 778.856636658917, 9167.74137003795, 500, 7, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '868369009', 2022, 3, 114.68252141629, 9987.58416822434, 500, 13, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '836786224', 2022, 3, 755.6554442711, 5402.51181362625, 500, 9, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '800910790', 2022, 3, 384.169960958552, 2391.24398056811, 500, 9, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '847922087', 2022, 3, 649.196555554914, 2308.87730828906, 500, 2, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '882737279', 2022, 3, 524.229351454924, 7698.54446572676, 500, 18, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '817612413', 2022, 3, 331.524803083925, 4363.93998196635, 500, 1, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '857680168', 2022, 3, 669.290517337, 2332.78516935126, 500, 10, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '878624841', 2022, 3, 527.950489646606, 9849.62700780274, 500, 16, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '867183919', 2022, 3, 927.576665561533, 8043.98166513218, 500, 16, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '824306551', 2022, 3, 122.906451615915, 6228.48628997165, 500, 4, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '812929350', 2022, 3, 998.728464844284, 2156.53302141585, 500, 10, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '890735735', 2022, 3, 100.347711578074, 958.213844710152, 500, 4, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '894341616', 2022, 3, 715.805821090658, 4011.31302895991, 500, 1, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '845690609', 2022, 3, 242.654553402858, 4697.09251444824, 500, 10, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '884945724', 2022, 3, 11.5832609649129, 2663.53410257332, 500, 17, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '820865124', 2022, 3, 862.029550988264, 3503.11837635069, 500, 16, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '870514368', 2022, 3, 843.449662792492, 5933.95143385449, 500, 17, false, '2023-01-11 13:06:32.457723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '833643869', 2022, 3, 172.865561818093, 6223.07930174514, 500, 1, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '807702188', 2022, 3, 471.780415515184, 1835.99763114704, 500, 13, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '820638689', 2022, 3, 665.096986659832, 8206.04264723472, 500, 9, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '843380901', 2022, 3, 153.042762365073, 8289.86593736509, 500, 3, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '832951634', 2022, 3, 30.5531297720599, 3792.13587047252, 500, 10, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '833677243', 2022, 3, 342.138911790708, 5527.17163403761, 500, 19, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '873656323', 2022, 3, 205.318470207132, 5289.26324527101, 500, 17, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '859159231', 2022, 3, 93.798748932656, 7810.62926998467, 500, 5, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '868067017', 2022, 3, 509.57991216104, 3592.98690960648, 500, 5, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '856435712', 2022, 3, 883.204453853702, 2389.32977465604, 500, 10, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '888937591', 2022, 3, 58.2165387806808, 6960.08212832333, 500, 11, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '873906284', 2022, 3, 815.48603843308, 3230.74775987249, 500, 5, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '855150484', 2022, 3, 897.707605210198, 9253.21891176021, 500, 19, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '836365546', 2022, 3, 68.4508054996371, 336.529037094888, 500, 5, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '822564929', 2022, 3, 913.500381497937, 2389.04286108156, 500, 15, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '833204596', 2022, 3, 739.047762076831, 1509.06206157028, 500, 13, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '863592645', 2022, 3, 538.744517217755, 9558.43169019046, 500, 19, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '865956727', 2022, 3, 296.858220118653, 6269.45752693038, 500, 3, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '807629933', 2022, 3, 889.771805064968, 188.130376707786, 500, 9, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '832454631', 2022, 3, 830.809681915618, 6861.70168356159, 500, 10, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '823356725', 2022, 3, 589.653772034871, 2699.39482379398, 500, 11, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '800824855', 2022, 3, 185.949855659539, 2617.31248939124, 500, 4, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '894510083', 2022, 3, 508.444541283295, 6450.58163848616, 500, 15, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '815854671', 2022, 3, 216.062832929217, 2187.48055452057, 500, 13, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '876401827', 2022, 3, 158.751720651476, 7972.26019520802, 500, 13, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '845066027', 2022, 3, 486.405608146354, 6496.50930477561, 500, 15, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '815406101', 2022, 3, 583.391039912684, 5479.39137799388, 500, 16, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '866878310', 2022, 3, 789.796441191467, 6636.07506809697, 500, 12, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '830803739', 2022, 3, 274.601270115358, 1927.75894338309, 500, 6, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '805933483', 2022, 3, 789.747981582983, 1269.35524065724, 500, 20, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '868252144', 2022, 3, 521.549601993249, 1718.44882535641, 500, 19, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '828744326', 2022, 3, 217.834416918949, 5305.94088302802, 500, 10, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '830122600', 2022, 3, 199.581952591688, 3531.20813319367, 500, 15, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '813147327', 2022, 3, 632.402363908158, 4196.93336649688, 500, 19, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '846250295', 2022, 3, 638.970549930563, 8116.70449861283, 500, 4, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '898250721', 2022, 3, 215.841512202425, 5759.72762626146, 500, 3, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '813697349', 2022, 3, 893.317881785307, 173.033529236235, 500, 8, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '863104800', 2022, 3, 86.0268705105772, 9578.45516882601, 500, 6, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '897979593', 2022, 3, 567.632792464707, 9435.09361768182, 500, 20, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '860772161', 2022, 3, 174.976889465226, 2369.29653808025, 500, 4, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '808002552', 2022, 3, 371.319603993679, 2224.04892044786, 500, 8, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '876394411', 2022, 3, 603.566553104006, 8451.34251516759, 500, 13, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '846214156', 2022, 3, 897.236520938857, 955.531879629572, 500, 10, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '850015354', 2022, 3, 403.182585059899, 9712.37577410398, 500, 6, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '805145991', 2022, 3, 550.792549267936, 945.383298224108, 500, 1, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '853879838', 2022, 3, 705.147562215325, 770.256909715314, 500, 12, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '882939801', 2022, 3, 307.94598856472, 4424.68381235404, 500, 13, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '859605190', 2022, 3, 244.477246473103, 7081.30937124574, 500, 11, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '891814367', 2022, 3, 206.700996710322, 5680.55832398304, 500, 11, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '875021136', 2022, 3, 451.834557542079, 360.811489641577, 500, 14, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '825379831', 2022, 3, 853.301918508253, 3786.13470214279, 500, 13, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '800469195', 2022, 3, 888.427380095054, 6122.45964681721, 500, 13, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '871244244', 2022, 3, 300.85574284258, 1900.80446741847, 500, 12, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '837133219', 2022, 3, 665.414851563536, 7925.20432108766, 500, 18, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '855964219', 2022, 3, 431.817054065537, 3472.49574205225, 500, 4, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '838273484', 2022, 3, 982.657668774636, 4965.40002720424, 500, 8, false, '2023-01-11 13:06:32.613076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '893483616', 2022, 3, 212.49322022261, 810.183277275336, 500, 13, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '891497759', 2022, 3, 601.168700248529, 9241.7795403152, 500, 9, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '888247901', 2022, 3, 255.077309312815, 3011.15644690147, 500, 13, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '883590490', 2022, 3, 11.2487521314211, 8866.44409722092, 500, 13, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '804908767', 2022, 3, 957.114230703283, 5981.99964589687, 500, 14, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '851919134', 2022, 3, 946.281102671678, 9460.86292700648, 500, 11, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '813682750', 2022, 3, 492.797689080058, 7961.00779034625, 500, 12, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '875544956', 2022, 3, 154.694083742737, 857.99004538062, 500, 16, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '889472231', 2022, 3, 604.126873486607, 8995.17882898588, 500, 12, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '875631634', 2022, 3, 932.091127234838, 3125.48026796976, 500, 1, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '856007783', 2022, 3, 660.935922407203, 9994.18039230509, 500, 4, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '844760467', 2022, 3, 332.373796470058, 9943.65989235512, 500, 13, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '863256691', 2022, 3, 180.982279637756, 7666.06844310401, 500, 2, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '851705582', 2022, 3, 671.75768101707, 2173.69729922591, 500, 1, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '854298834', 2022, 3, 924.493195101814, 6119.84847371159, 500, 12, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '836216435', 2022, 3, 423.627604649562, 291.591265556331, 500, 15, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '893017297', 2022, 3, 843.474625138311, 8467.01711338251, 500, 8, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '841372032', 2022, 3, 866.450284608733, 2630.92650513912, 500, 19, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '862589424', 2022, 3, 798.201435899122, 9398.5991088688, 500, 9, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '871501781', 2022, 3, 612.867225958845, 9867.91560759582, 500, 1, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '880977356', 2022, 3, 886.716932662269, 7688.52508105869, 500, 9, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '859708655', 2022, 3, 187.419727242942, 5185.42778297886, 500, 4, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '837130075', 2022, 3, 733.101280297494, 2232.03677344703, 500, 11, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '803170681', 2022, 3, 847.679611886854, 7993.65161600802, 500, 16, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '875018446', 2022, 3, 945.384794134611, 4973.98195561904, 500, 9, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '872251225', 2022, 3, 135.962815049345, 185.101336750804, 500, 4, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '889927472', 2022, 3, 687.368531642986, 216.026494788027, 500, 6, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '850310272', 2022, 3, 538.237481293281, 341.112290933665, 500, 14, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '878277970', 2022, 3, 44.5322469544529, 4831.55427788326, 500, 19, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '811324382', 2022, 3, 374.782627042125, 7536.77703651145, 500, 15, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '878265174', 2022, 3, 56.0779402964794, 5400.30780221509, 500, 2, false, '2023-01-11 13:06:32.919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '803799726', 2022, 3, 399.24205806077, 6622.05067062415, 500, 3, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '827344157', 2022, 3, 947.886752159751, 6955.87852284009, 500, 5, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '868610918', 2022, 3, 212.876189730747, 907.885506647061, 500, 5, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '891144647', 2022, 3, 192.071292686188, 6957.99234954098, 500, 13, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '874750888', 2022, 3, 58.108844255323, 8481.31988993914, 500, 1, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '879572863', 2022, 3, 349.967629548771, 921.753213607802, 500, 13, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '816719384', 2022, 3, 433.327880085607, 7193.33481995437, 500, 12, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '823372812', 2022, 3, 334.311876322117, 4892.34978547053, 500, 19, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '872671153', 2022, 3, 467.73704596417, 871.682803160858, 500, 15, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '837782686', 2022, 3, 153.922587136283, 9391.94236717274, 500, 3, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '856373244', 2022, 3, 48.6147800814296, 7837.01761781039, 500, 18, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '802319687', 2022, 3, 47.4460116276229, 9209.27747218831, 500, 20, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '882221112', 2022, 3, 407.551248996177, 608.436643510232, 500, 20, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '825823538', 2022, 3, 781.758222917296, 8770.43684749342, 500, 3, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '840744367', 2022, 3, 735.494657785718, 542.779992027588, 500, 11, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '807485242', 2022, 3, 483.542390718333, 7980.84199501993, 500, 10, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '878321914', 2022, 3, 613.953843957903, 5764.84458943315, 500, 6, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '886892017', 2022, 3, 464.962896106464, 9600.58670551411, 500, 13, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '871623349', 2022, 3, 586.176634652628, 8137.42809134653, 500, 2, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '864986459', 2022, 3, 141.58032717696, 2518.17241257309, 500, 2, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '849227492', 2022, 3, 501.402093043537, 75.3010992085159, 500, 19, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '850910144', 2022, 3, 267.836724782796, 9267.82930988355, 500, 6, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '869658223', 2022, 3, 352.615459693938, 832.337759910066, 500, 2, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '866431270', 2022, 3, 136.175052339473, 8117.75733157864, 500, 4, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '858356342', 2022, 3, 266.8422579798, 5202.53642017799, 500, 19, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '852467356', 2022, 3, 993.510769974751, 8465.78052862964, 500, 5, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '898657961', 2022, 3, 91.5507812857704, 8802.87679097543, 500, 9, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '846849579', 2022, 3, 349.988889881421, 8330.09264822892, 500, 16, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '873579899', 2022, 3, 861.174877504242, 1113.91442680741, 500, 1, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '843035298', 2022, 3, 34.282736258735, 4369.11028994273, 500, 2, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '858836952', 2022, 3, 672.836546385855, 5257.57481266266, 500, 2, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '805709917', 2022, 3, 443.329540307984, 5580.27806226157, 500, 8, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '808479485', 2022, 3, 271.681777853105, 8756.62145360621, 500, 9, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '838878962', 2022, 3, 784.041436160418, 175.141227764883, 500, 8, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '885625328', 2022, 3, 917.019473762888, 1764.59010036369, 500, 1, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '837527996', 2022, 3, 653.208533939067, 7256.41803561968, 500, 10, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '844848494', 2022, 3, 63.5695491262723, 8374.50010733869, 500, 12, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '825573136', 2022, 3, 761.617466185098, 487.888630203439, 500, 18, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '809036318', 2022, 3, 257.719880333542, 3777.69178819462, 500, 1, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '800223332', 2022, 3, 339.977602173617, 5161.30650369782, 500, 1, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '878112453', 2022, 3, 134.38283850004, 5932.29707555998, 500, 8, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '893781546', 2022, 3, 845.824177183454, 5773.6017589397, 500, 11, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '818658010', 2022, 3, 282.199736754785, 770.297450944718, 500, 1, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '862270603', 2022, 3, 183.270147379109, 287.881021996372, 500, 14, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '812325897', 2022, 3, 681.234471744872, 7603.40652341765, 500, 8, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '817554736', 2022, 3, 111.755476490521, 3437.99005798569, 500, 6, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '884291457', 2022, 3, 101.97876991283, 7103.60557530123, 500, 4, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '890910485', 2022, 3, 487.538649762865, 990.052422721673, 500, 18, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '810677960', 2022, 3, 509.403447452151, 2690.75723441272, 500, 7, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '830621787', 2022, 3, 575.149841503679, 9219.78780301509, 500, 4, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '874792210', 2022, 3, 888.842118118652, 1268.36704320699, 500, 19, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '828718942', 2022, 3, 791.39258358291, 5872.24628818398, 500, 2, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '846277869', 2022, 3, 572.505211399029, 2823.28913297452, 500, 10, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '809316543', 2022, 3, 387.463630922036, 2421.72567766319, 500, 10, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '846821438', 2022, 3, 292.463600849633, 9612.88123043573, 500, 16, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '836005340', 2022, 3, 161.045103608214, 1998.68887416634, 500, 14, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '869069081', 2022, 3, 942.740891484511, 1416.3797966398, 500, 17, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '824870495', 2022, 3, 35.9525146405441, 9834.50429882042, 500, 20, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '821850314', 2022, 3, 812.902395371808, 6465.72957469233, 500, 9, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '895629317', 2022, 3, 185.381740522779, 5178.05259887292, 500, 13, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '854843256', 2022, 3, 21.3275719389159, 6184.26707303535, 500, 5, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '825397589', 2022, 3, 442.591829429647, 1576.71030036428, 500, 16, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '856901774', 2022, 3, 17.534305964081, 3810.81783098641, 500, 8, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '886566656', 2022, 3, 146.014421336579, 5172.00280360483, 500, 12, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '868634250', 2022, 3, 754.547007514138, 1487.54981742071, 500, 10, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '827178297', 2022, 3, 219.148284010464, 6933.06879426518, 500, 15, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '889901026', 2022, 3, 657.742785425414, 5788.16276731039, 500, 12, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '860932226', 2022, 3, 37.8840881574359, 6522.9930281089, 500, 3, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '883640440', 2022, 3, 602.702582453166, 3788.22163651124, 500, 8, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '899511765', 2022, 3, 961.74630603573, 3588.41188728467, 500, 17, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '826671551', 2022, 3, 49.6888648397077, 1895.35422881632, 500, 14, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '838991015', 2022, 3, 907.024838247149, 538.369807766854, 500, 14, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '831768843', 2022, 3, 252.532566380693, 4021.03378974331, 500, 6, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '803324193', 2022, 3, 707.172293779023, 2569.27047396088, 500, 19, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '827269180', 2022, 3, 460.071936917849, 3322.85177025329, 500, 6, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '806938796', 2022, 3, 407.539341245166, 3282.08991352543, 500, 11, false, '2023-01-11 13:06:33.070103', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '817130185', 2022, 3, 555.871976330445, 6954.9224537143, 500, 8, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '810402680', 2022, 3, 24.1416159686928, 4990.74783120607, 500, 3, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '887841956', 2022, 3, 835.869238639322, 3771.16800205343, 500, 17, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '897336611', 2022, 3, 619.148461956207, 4333.28099965704, 500, 13, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '858728795', 2022, 3, 264.016737402134, 667.219102460249, 500, 4, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '880050743', 2022, 3, 831.06367410671, 9258.65242991025, 500, 18, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '871161662', 2022, 3, 732.4564876464, 2059.52404920302, 500, 13, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '862924848', 2022, 3, 213.608385537164, 2742.01183440375, 500, 5, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '895031114', 2022, 3, 559.903296657114, 5532.10555259637, 500, 3, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '815517829', 2022, 3, 421.147104897098, 9755.92060653281, 500, 6, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '836666246', 2022, 3, 168.590858678214, 774.087776597126, 500, 14, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '845715533', 2022, 3, 397.694721234118, 5928.06154441238, 500, 9, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '897156462', 2022, 3, 336.95003281332, 7415.41856269014, 500, 16, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '890815244', 2022, 3, 542.68315376842, 1692.25646696556, 500, 1, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '866562589', 2022, 3, 498.189516657159, 4667.64807550458, 500, 10, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '875322390', 2022, 3, 650.360406599295, 5362.43320749337, 500, 3, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '870376312', 2022, 3, 766.895911086571, 5080.43201706145, 500, 13, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '863074238', 2022, 3, 655.914821134071, 4623.99248969152, 500, 9, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '873535604', 2022, 3, 343.64965701886, 4935.83866661761, 500, 20, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '820029647', 2022, 3, 463.264480978331, 6735.92763347288, 500, 4, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '825514130', 2022, 3, 749.436149023171, 2770.92767744573, 500, 9, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '815801592', 2022, 3, 846.730607330564, 8444.73045325624, 500, 15, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '839528084', 2022, 3, 600.831143591553, 5119.66352848022, 500, 3, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '864571830', 2022, 3, 237.684626003663, 6687.2498371491, 500, 17, false, '2023-01-11 13:06:33.428089', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '883989256', 2022, 3, 865.578250507884, 3660.90944225309, 500, 9, false, '2023-01-11 13:06:36.502938', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '831272011', 2022, 3, 238.540424841078, 4258.96894949914, 500, 12, false, '2023-01-11 13:06:36.525673', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '831658088', 2022, 3, 483.611802461825, 1837.11570403734, 500, 19, false, '2023-01-11 13:06:36.544047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '802008121', 2022, 3, 712.479064190576, 9513.67002994848, 500, 18, false, '2023-01-11 13:06:36.544047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '857721878', 2022, 3, 966.120657227334, 844.617992385927, 500, 5, false, '2023-01-11 13:06:36.544047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '811747377', 2022, 3, 159.443052323257, 3105.72621465161, 500, 12, false, '2023-01-11 13:06:36.578395', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '801396893', 2022, 3, 492.083274708454, 3090.56272967464, 500, 7, false, '2023-01-11 13:06:36.578395', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '885133950', 2022, 3, 196.453092723349, 1456.47674629267, 500, 4, false, '2023-01-11 13:06:36.610102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '864761302', 2022, 3, 462.327640889993, 3945.84861647023, 500, 7, false, '2023-01-11 13:06:36.610102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '870050263', 2022, 3, 18.2773184048734, 291.437473317923, 500, 7, false, '2023-01-11 13:06:36.610102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '881536611', 2022, 3, 433.641735649922, 9917.79575387109, 500, 8, false, '2023-01-11 13:06:36.610102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '862811969', 2022, 3, 131.485072847569, 9773.37662341324, 500, 7, false, '2023-01-11 13:06:36.610102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '892708443', 2022, 3, 54.4651206548943, 701.824131008669, 500, 14, false, '2023-01-11 13:06:36.610102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '866931781', 2022, 3, 592.179828287168, 1848.63159837034, 500, 7, false, '2023-01-11 13:06:36.610102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '868378133', 2022, 3, 895.766368085961, 7998.78272584079, 500, 17, false, '2023-01-11 13:06:36.656769', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '872308278', 2022, 3, 796.779320698965, 9222.65394724128, 500, 2, false, '2023-01-11 13:06:36.656769', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '854032309', 2022, 3, 634.351789737581, 3102.69894198732, 500, 20, false, '2023-01-11 13:06:36.656769', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '842782667', 2022, 3, 731.845977642708, 1395.01095515513, 500, 6, false, '2023-01-11 13:06:36.656769', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 9365.5385806238, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.586084');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 7391.65354352409, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.605721');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '555555555', 1021.18850019126, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.605721');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '881532376', 3779.68988064686, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.614646');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '883874352', 7013.50788484618, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.644281');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '848147638', 5557.88814673258, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.644281');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '876763949', 5872.58620433572, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.659116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '871871807', 3753.03554832438, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.668698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '864079801', 2012.47545319462, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.668698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '836041617', 2496.28820083561, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.668698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '857842260', 7813.03911712495, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.68187');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '885073621', 9412.36628600224, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.68187');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '864754605', 7826.5545669624, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.697834');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '846347581', 4450.34482151051, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.697834');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '824680794', 8345.68720663147, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.697834');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '839415001', 5514.64661594725, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.712893');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '861744528', 6583.09617379438, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.712893');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '860138909', 980.274844808093, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.722327');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '843242104', 161.783504250299, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.730708');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '890093850', 2061.24791228539, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.730708');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '892511017', 2323.42781112241, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.740759');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '842605109', 5568.90679036946, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.740759');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '870491047', 4771.84857308131, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.749375');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '863507760', 3581.47349273366, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.749375');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '817257908', 8576.90289497349, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.771529');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '809042383', 7947.75557572465, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.771529');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '810734693', 3713.37558109094, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.780403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '804629062', 4786.42869737423, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.780403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '873621335', 3369.96926995884, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.780403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '835058832', 7310.50662159552, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.780403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '803826652', 8725.7370144098, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.780403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '874394467', 575.731668074726, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.799789');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '838903289', 3550.16888081596, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.799789');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '882051647', 9726.28521402417, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.808709');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '879681201', 2681.13460493245, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.808709');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '852409131', 3834.46668395426, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.808709');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '808215075', 1558.28760184127, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.808709');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '865074415', 7748.85837287293, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.81851');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '836669149', 2854.70312456269, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.82674');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '884369776', 5573.90816154359, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.82674');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '873418367', 7129.28455543243, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.82674');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '802905016', 3176.09573426986, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.837443');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '885609899', 7276.82174133455, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.837443');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '860836918', 4645.03816157184, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.846909');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '829745509', 7396.94193686332, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.846909');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '844246611', 3088.49285544932, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.861922');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '867216743', 9097.8916685438, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.873906');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '890941228', 6153.61875117796, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.873906');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '838540049', 3905.50495059048, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.882465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '809501750', 9652.90963481968, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.882465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '844496478', 9189.89856773547, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.882465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '863501025', 9077.40295070081, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.882465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '839166324', 2017.05732515683, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.895513');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '879962157', 320.98731180388, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.90463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '848543645', 9810.35932083311, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.90463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '880279851', 3458.54918966853, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.90463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '808671188', 3703.03238183128, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.916209');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '851333885', 1529.76979033216, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.916209');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '815366017', 9766.10109605796, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.928464');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '891113900', 9274.89262841256, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.928464');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '894926128', 9661.63125476056, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.93727');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '802290404', 2091.40286984746, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.93727');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '896239097', 44.1334563157848, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.945961');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '816868949', 281.445983114234, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.945961');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '895298219', 2613.30099900213, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.951751');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '842893897', 8020.84897948973, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.951751');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '814670938', 9846.04362099609, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.960921');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '820433803', 924.821248433015, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.968975');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '874104569', 165.202440118429, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.980819');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '856520283', 8093.98949141047, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.980819');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '879090305', 5216.97647209787, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.992411');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '809468321', 1011.770371269, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:33.992411');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '826378947', 1703.12477321642, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.005532');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '866390365', 5178.39676841926, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.005532');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '862771013', 6373.26707455638, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.005532');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '864363318', 4453.05354074083, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.017402');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '896438075', 2812.49134917998, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.026946');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '829368106', 7611.06487599627, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.026946');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '867407313', 1762.79374883324, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.036333');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '896587504', 4505.36172950016, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.036333');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '847845944', 2967.30580996577, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.054029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '826389298', 8571.12167478316, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.054029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '848399886', 8596.50039889448, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.066278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '854846835', 6588.20436273446, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.066278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '800634899', 7655.82255192136, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.078797');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '857110616', 264.888915985379, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.090716');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '808271586', 2794.33443383865, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.090716');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '819801010', 5454.04572113711, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.090716');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '848578637', 797.008518337617, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.101057');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '827490752', 3808.53909162524, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.119533');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '835736810', 1172.15012126137, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.136879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '857544475', 9596.00071273121, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.136879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '847721823', 8613.13826796056, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.150615');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '862581603', 1995.67910803829, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.150615');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '810313500', 3435.11530824208, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.16378');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '885129733', 3456.54712173968, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.17946');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '898243796', 7967.09528484178, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.17946');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '887079787', 6349.55700412723, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.17946');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '861058672', 2047.35460600132, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.189859');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '876537913', 5243.69447443562, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.189859');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '890597928', 1522.14252477412, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.20785');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '842982051', 3329.63135654566, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.215736');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '842389667', 6536.32619542003, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.215736');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '820004072', 9498.71272431279, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.215736');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '897688257', 9668.70994112268, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.215736');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '837534390', 3741.67329692534, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.234372');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '808543637', 3351.83668154388, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.234372');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '870201888', 1268.53145846032, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.234372');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '817311070', 7752.09620794699, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.234372');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '868012776', 3632.72216708459, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.234372');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '896429753', 9841.96484849155, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.252811');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '851603425', 7936.89739312716, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.26168');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '827443317', 3464.62005133511, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.26168');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '833362642', 4785.94017546028, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.26168');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '882069408', 428.016572550953, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.26168');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '863878944', 8294.25393026687, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.27034');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '866558221', 3258.50744665762, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.27034');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '868767855', 4754.71583085083, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.279915');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '875885300', 5491.17271104301, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.279915');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '842216735', 5365.99245961874, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.296262');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '856920437', 5630.26711641425, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.303249');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '830858963', 8948.70829156906, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.303249');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '812434114', 2852.28020427605, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.311389');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '847041353', 6038.19815783, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.311389');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '803269327', 4674.39988354255, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.322901');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '843457384', 7080.73546743112, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.322901');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '818306281', 7352.48749353287, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.332677');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '844449510', 2699.87416438165, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.332677');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '867177223', 9562.03270700296, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.343201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '883963814', 2398.27634885428, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.343201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '886253015', 6544.97639737846, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.354385');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '895281822', 7476.6652642158, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.354385');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '840533481', 2099.16814055973, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.364439');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '839216776', 4511.2520292696, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.364439');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '803533948', 3563.97061182099, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.374471');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '827095124', 1010.07569186975, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.383403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '808251981', 8307.59766125223, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.383403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '817358823', 1428.71526928241, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.396719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '871910327', 455.470678844676, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.396719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '866587133', 9301.16078009932, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.408266');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '842840788', 921.357945737936, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.408266');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '812781923', 9649.48111821052, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.408266');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '804058381', 5489.44163879611, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.421793');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '811423248', 1570.42401146895, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.421793');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '840837641', 5764.54212062968, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.430916');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '818816392', 2093.51298329787, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.430916');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '806494928', 6014.73535907213, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.430916');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '893055618', 7013.17827657494, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.430916');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '875340822', 1879.99753398562, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.444697');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '818463756', 2409.42579636398, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.444697');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '884152302', 2566.15622912562, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.454101');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '849742742', 7849.72060620984, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.454101');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '804979817', 4035.73233224922, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.454101');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '814190896', 339.063207484028, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.465059');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '822331640', 3625.75550262823, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.465059');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '862678317', 1279.75193872779, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.474262');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '831093023', 3445.91589970061, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.481488');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '874226454', 3605.39147778564, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.481488');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '832436811', 754.523020575193, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.481488');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '838432048', 5127.32043763342, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.492252');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '870022919', 2035.82747286523, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.492252');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '879268334', 829.388098556909, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.500663');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '806599852', 3607.67827648517, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.500663');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '863181199', 6712.02025711694, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.511509');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '863767568', 3872.96863177205, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.511509');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '844014636', 9429.54616029289, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.524384');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '866404710', 5841.94503174918, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.524384');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '833129946', 5041.92248197155, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.533654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '846977998', 6869.51047464923, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.533654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '811030348', 3492.95234344701, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.542496');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '890815907', 3394.69421017937, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.542496');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '822694021', 3252.48896156285, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.551719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '852558904', 507.086043201649, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.551719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '822874914', 7144.79347794333, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.551719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '866646453', 9795.48975644455, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.561801');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '881021956', 7002.675595211, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.561801');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '899291735', 2745.57933863854, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.573584');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '867918928', 4146.6153526148, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.573584');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '823439458', 9747.72378347414, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.582919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '837805347', 2610.42459727785, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.582919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '805499088', 5804.41245210148, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.582919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '845822610', 3198.65571607792, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.597181');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '841405633', 1583.4439368204, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.597181');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '889675608', 5216.52601190864, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.603698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '899025387', 553.108872998917, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.603698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '863280835', 4341.14434272795, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.61341');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '860629673', 4928.40792077931, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.61341');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '833667497', 7053.74322992898, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.61341');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '842471044', 508.030129735448, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.622926');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '861459803', 5861.74064576915, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.622926');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '812926032', 2032.05354646212, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.6335');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '871631319', 4934.43779556168, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.6335');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '865439281', 6589.39082026731, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.6335');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '824210548', 1219.26332111095, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.642048');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '805486005', 4954.70469838802, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.651496');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '832448472', 6508.68434033924, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.651496');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '805820685', 5323.08200452427, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.660911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '883768894', 6439.92410845175, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.660911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '856903021', 2812.04156501953, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.673778');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '850012745', 7156.40613495964, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.673778');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '820149848', 3440.58337597068, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.686427');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '822705108', 9921.65969567091, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.686427');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '857573851', 9455.86839328205, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.686427');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '856078198', 6204.51439095816, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.693934');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '859225721', 2631.55057386213, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.693934');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '873879874', 3838.98645569895, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.702299');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '890065285', 714.936785399262, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.702299');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '893423280', 3096.68893006439, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.711625');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '816273126', 2191.30209451992, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.711625');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '874977909', 3555.63448760055, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.711625');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '888632161', 6926.51456253768, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.720937');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '852452427', 4268.88242863796, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.729465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '807389236', 8715.59194460675, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.729465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '833163111', 8449.61709710598, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.729465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '813080832', 6472.01758087736, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.737204');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '896489260', 1973.83460636143, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.747501');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '845881839', 6889.29783961865, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.747501');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '898157169', 3704.18659394271, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.747501');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '882940656', 5663.34355536998, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.758949');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '887589106', 1329.54237875677, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.758949');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '856439808', 5343.05335596406, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.769669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '869911712', 2389.27536397529, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.769669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '836420677', 2573.89271431274, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.779361');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '810521018', 6040.53891513578, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.779361');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '863021621', 4594.75397242533, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.80159');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '846289494', 4829.68690202878, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.810578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '834191416', 9633.02299613335, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.810578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '837420340', 3977.75305361092, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.810578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '871949311', 5035.69563517599, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.819429');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '821633142', 9433.88860640258, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.825234');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '893463166', 4518.64201054558, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.825234');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '833218825', 3104.03560777977, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.825234');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '807456455', 7621.37149295836, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.838768');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '821381486', 1541.43089090489, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.838768');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '814324199', 5023.14874950078, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.846821');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '805904949', 801.268375885762, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.846821');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '813242515', 3110.39416066302, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.846821');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '839415843', 6797.91909309106, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.855013');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '804234371', 7034.60918426733, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.855013');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '816585946', 7539.73694163413, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.855013');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '824097835', 256.603938757907, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.864614');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '880538674', 5739.14939673326, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.864614');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '875775705', 9383.07849137505, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.873385');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '877421692', 6554.06654388593, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.873385');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '871547736', 7193.62809103146, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.881943');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '857653378', 5364.12134661392, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.891621');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '829980700', 6558.71181470824, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.891621');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '852627790', 4136.83517856652, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.905176');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '865978526', 1804.08697200741, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.918971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '840145629', 734.887186268998, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.918971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '875016141', 4905.57223617159, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.93067');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '869419134', 7091.40823497954, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.93067');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '813944600', 8062.87768712455, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.946081');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '885600454', 1079.80740729373, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.946081');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '877550656', 8313.27299217338, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.946081');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '804227830', 6980.22559147847, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.958117');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '858956619', 3350.82331367884, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.958117');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '865153645', 8253.43293392586, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.966486');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '817941723', 7785.04654189184, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.966486');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '811667993', 3694.15729783347, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.973917');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '859462534', 2542.07106276734, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.973917');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '822317092', 9757.85797241348, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.982754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '877772835', 4123.40854103184, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.989483');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '846495295', 6940.53709241877, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.996354');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '804775869', 607.99845400596, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:34.996354');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '831030012', 9177.28926067278, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.007774');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '802809462', 8106.32371777374, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.007774');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '896200151', 8500.04846263991, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.007774');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '873610100', 9567.01247502744, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.01753');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '847931581', 5040.35415208718, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.025556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '870810427', 2215.44310246097, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.025556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '816457914', 9418.40639229608, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.025556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '816760477', 6687.73881754978, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.04441');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '821449527', 8968.88218579413, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.051876');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '897412997', 7526.26047650483, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.051876');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '801856356', 8769.76146465971, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.061759');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '898170941', 8777.68991279107, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.061759');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '884390144', 9767.44526525106, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.061759');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '894424841', 161.928711359936, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.061759');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '828972512', 6467.22322640608, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.071553');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '815082581', 915.248854597949, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.071553');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '887159012', 489.856439829547, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.077289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '829493874', 7718.9085229476, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.077289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '814929193', 4033.0119386274, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.087085');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '859907302', 3418.71199775992, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.094437');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '895124699', 2818.28691488708, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.094437');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '813239227', 5444.7018279803, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.103836');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '840430296', 2252.87300969911, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.113405');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '858726639', 242.444903356643, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.113405');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '823234800', 2585.26965187722, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.121178');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '874361830', 8507.25963953563, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.121178');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '808481735', 4960.11322689511, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.12921');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '860499175', 3747.09340733199, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.12921');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '892697142', 5682.43961420226, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.12921');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '826727890', 6740.3745056341, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.135349');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '895582762', 4467.78953075589, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.135349');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '814663914', 7420.56537969301, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.141091');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '887191975', 4610.43138247589, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.146637');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '856729012', 1485.01554181639, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.146637');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '816248533', 487.290869528983, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.153354');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '847253663', 9002.46353695235, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.159246');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '851556995', 8873.57362765091, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.166724');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '897000352', 1426.8037148357, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.17667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '891267708', 9167.74137003795, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.18433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '868369009', 9987.58416822434, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.18433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '836786224', 5402.51181362625, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.191333');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '800910790', 2391.24398056811, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.205107');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '847922087', 2308.87730828906, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.215532');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '882737279', 7698.54446572676, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.215532');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '817612413', 4363.93998196635, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.22343');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '857680168', 2332.78516935126, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.232382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '878624841', 9849.62700780274, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.232382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '867183919', 8043.98166513218, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.247525');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '824306551', 6228.48628997165, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.247525');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '812929350', 2156.53302141585, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.247525');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '890735735', 958.213844710152, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.25544');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '894341616', 4011.31302895991, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.25544');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '845690609', 4697.09251444824, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.25544');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '884945724', 2663.53410257332, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.25544');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '820865124', 3503.11837635069, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.266137');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '870514368', 5933.95143385449, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.266137');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '833643869', 6223.07930174514, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.273953');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '807702188', 1835.99763114704, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.273953');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '820638689', 8206.04264723472, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.281211');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '843380901', 8289.86593736509, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.281211');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '832951634', 3792.13587047252, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.28908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '833677243', 5527.17163403761, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.28908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '873656323', 5289.26324527101, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.297045');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '859159231', 7810.62926998467, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.297045');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '868067017', 3592.98690960648, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.308779');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '856435712', 2389.32977465604, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.308779');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '888937591', 6960.08212832333, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.308779');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '873906284', 3230.74775987249, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.33073');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '855150484', 9253.21891176021, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.338451');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '836365546', 336.529037094888, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.338451');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '822564929', 2389.04286108156, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.338451');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '833204596', 1509.06206157028, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.338451');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '863592645', 9558.43169019046, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.338451');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '865956727', 6269.45752693038, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.348195');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '807629933', 188.130376707786, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.348195');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '832454631', 6861.70168356159, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.355705');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '823356725', 2699.39482379398, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.355705');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '800824855', 2617.31248939124, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.367807');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '894510083', 6450.58163848616, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.367807');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '815854671', 2187.48055452057, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.379794');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '876401827', 7972.26019520802, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.379794');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '845066027', 6496.50930477561, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.386481');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '815406101', 5479.39137799388, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.386481');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '866878310', 6636.07506809697, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.392649');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '830803739', 1927.75894338309, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.403949');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '805933483', 1269.35524065724, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.403949');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '868252144', 1718.44882535641, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.420283');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '828744326', 5305.94088302802, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.420283');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '830122600', 3531.20813319367, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.435889');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '813147327', 4196.93336649688, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.435889');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '846250295', 8116.70449861283, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.435889');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '898250721', 5759.72762626146, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.44713');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '813697349', 173.033529236235, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.44713');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '863104800', 9578.45516882601, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.44713');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '897979593', 9435.09361768182, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.455702');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '860772161', 2369.29653808025, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.462429');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '808002552', 2224.04892044786, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.462429');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '876394411', 8451.34251516759, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.473841');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '846214156', 955.531879629572, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.482009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '850015354', 9712.37577410398, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.482009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '805145991', 945.383298224108, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.490714');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '853879838', 770.256909715314, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.500692');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '882939801', 4424.68381235404, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.500692');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '859605190', 7081.30937124574, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.508662');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '891814367', 5680.55832398304, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.516896');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '875021136', 360.811489641577, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.516896');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '825379831', 3786.13470214279, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.516896');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '800469195', 6122.45964681721, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.52881');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '871244244', 1900.80446741847, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.52881');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '837133219', 7925.20432108766, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.54141');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '855964219', 3472.49574205225, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.54141');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '838273484', 4965.40002720424, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.551624');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '893483616', 810.183277275336, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.562086');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '891497759', 9241.7795403152, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.57116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '888247901', 3011.15644690147, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.581417');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '883590490', 8866.44409722092, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.581417');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '804908767', 5981.99964589687, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.589702');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '851919134', 9460.86292700648, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.598632');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '813682750', 7961.00779034625, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.598632');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '875544956', 857.99004538062, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.607725');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '889472231', 8995.17882898588, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.615844');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '875631634', 3125.48026796976, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.615844');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '856007783', 9994.18039230509, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.623228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '844760467', 9943.65989235512, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.631747');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '863256691', 7666.06844310401, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.64135');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '851705582', 2173.69729922591, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.64135');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '854298834', 6119.84847371159, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.650938');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '836216435', 291.591265556331, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.659599');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '893017297', 8467.01711338251, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.659599');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '841372032', 2630.92650513912, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.670855');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '862589424', 9398.5991088688, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.670855');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '871501781', 9867.91560759582, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.680795');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '880977356', 7688.52508105869, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.689207');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '859708655', 5185.42778297886, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.689207');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '837130075', 2232.03677344703, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.6988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '803170681', 7993.65161600802, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.6988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '875018446', 4973.98195561904, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.708722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '872251225', 185.101336750804, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.717777');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '889927472', 216.026494788027, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.717777');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '850310272', 341.112290933665, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.72784');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '878277970', 4831.55427788326, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.736018');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '811324382', 7536.77703651145, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.736018');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '878265174', 5400.30780221509, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.745881');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '803799726', 6622.05067062415, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.745881');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '827344157', 6955.87852284009, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.753563');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '868610918', 907.885506647061, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.753563');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '891144647', 6957.99234954098, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.753563');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '874750888', 8481.31988993914, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.764168');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '879572863', 921.753213607802, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.764168');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '816719384', 7193.33481995437, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.774797');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '823372812', 4892.34978547053, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.774797');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '872671153', 871.682803160858, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.785532');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '837782686', 9391.94236717274, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.785532');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '856373244', 7837.01761781039, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.792344');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '802319687', 9209.27747218831, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.792344');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '882221112', 608.436643510232, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.80595');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '825823538', 8770.43684749342, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.80595');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '840744367', 542.779992027588, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.80595');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '807485242', 7980.84199501993, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.83084');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '878321914', 5764.84458943315, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.839475');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '886892017', 9600.58670551411, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.839475');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '871623349', 8137.42809134653, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.839475');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '864986459', 2518.17241257309, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.839475');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '849227492', 75.3010992085159, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.839475');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '850910144', 9267.82930988355, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.839475');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '869658223', 832.337759910066, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.839475');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '866431270', 8117.75733157864, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.854747');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '858356342', 5202.53642017799, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.854747');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '852467356', 8465.78052862964, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.865023');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '898657961', 8802.87679097543, 500, 11, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.875613');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '846849579', 8330.09264822892, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.875613');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '873579899', 1113.91442680741, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.883833');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '843035298', 4369.11028994273, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.883833');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '858836952', 5257.57481266266, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.902343');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '805709917', 5580.27806226157, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.911609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '808479485', 8756.62145360621, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.911609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '838878962', 175.141227764883, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.926018');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '885625328', 1764.59010036369, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.939006');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '837527996', 7256.41803561968, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.939006');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '844848494', 8374.50010733869, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.946743');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '825573136', 487.888630203439, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.946743');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '809036318', 3777.69178819462, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.95832');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '800223332', 5161.30650369782, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.95832');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '878112453', 5932.29707555998, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.95832');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '893781546', 5773.6017589397, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.970297');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '818658010', 770.297450944718, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.979093');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '862270603', 287.881021996372, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.991163');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '812325897', 7603.40652341765, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.991163');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '817554736', 3437.99005798569, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.991163');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '884291457', 7103.60557530123, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:35.999966');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '890910485', 990.052422721673, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.008978');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '810677960', 2690.75723441272, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.019658');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '830621787', 9219.78780301509, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.019658');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '874792210', 1268.36704320699, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.019658');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '828718942', 5872.24628818398, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.037351');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '846277869', 2823.28913297452, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.046819');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '809316543', 2421.72567766319, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.046819');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '846821438', 9612.88123043573, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.055303');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '836005340', 1998.68887416634, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.062047');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '869069081', 1416.3797966398, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.074506');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '824870495', 9834.50429882042, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.087648');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '821850314', 6465.72957469233, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.095643');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '895629317', 5178.05259887292, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.095643');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '854843256', 6184.26707303535, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.10719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '825397589', 1576.71030036428, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.10719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '856901774', 3810.81783098641, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.116101');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '886566656', 5172.00280360483, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.116101');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '868634250', 1487.54981742071, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.126044');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '827178297', 6933.06879426518, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.126044');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '889901026', 5788.16276731039, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.138042');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '860932226', 6522.9930281089, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.138042');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '883640440', 3788.22163651124, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.158078');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '899511765', 3588.41188728467, 500, 7, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.167004');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '826671551', 1895.35422881632, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.167004');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '838991015', 538.369807766854, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.167004');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '831768843', 4021.03378974331, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.176677');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '803324193', 2569.27047396088, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.176677');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '827269180', 3322.85177025329, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.192605');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '806938796', 3282.08991352543, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.192605');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '817130185', 6954.9224537143, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.201462');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '810402680', 4990.74783120607, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.201462');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '887841956', 3771.16800205343, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.20974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '897336611', 4333.28099965704, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.20974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '858728795', 667.219102460249, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.20974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '880050743', 9258.65242991025, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.215489');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '871161662', 2059.52404920302, 500, 14, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.215489');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '862924848', 2742.01183440375, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.222145');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '895031114', 5532.10555259637, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.222145');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '815517829', 9755.92060653281, 500, 15, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.228174');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '836666246', 774.087776597126, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.236487');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '845715533', 5928.06154441238, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.243201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '897156462', 7415.41856269014, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.243201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '890815244', 1692.25646696556, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.249859');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '866562589', 4667.64807550458, 500, 18, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.25642');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '875322390', 5362.43320749337, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.26079');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '870376312', 5080.43201706145, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.26079');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '863074238', 4623.99248969152, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.285387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '873535604', 4935.83866661761, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.291991');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '820029647', 6735.92763347288, 500, 6, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.291991');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '825514130', 2770.92767744573, 500, 13, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.291991');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '815801592', 8444.73045325624, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.291991');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '839528084', 5119.66352848022, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.291991');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '864571830', 6687.2498371491, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.291991');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '883989256', 3660.90944225309, 500, 20, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.701405');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '831272011', 4258.96894949914, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.711961');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '831658088', 1837.11570403734, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.72184');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '802008121', 9513.67002994848, 500, 19, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.728937');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '857721878', 844.617992385927, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.728937');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '811747377', 3105.72621465161, 500, 10, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.739226');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '801396893', 3090.56272967464, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.739226');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '885133950', 1456.47674629267, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.752867');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '864761302', 3945.84861647023, 500, 9, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.760817');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '870050263', 291.437473317923, 500, 12, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.760817');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '881536611', 9917.79575387109, 500, 3, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.760817');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '862811969', 9773.37662341324, 500, 4, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.774612');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '892708443', 701.824131008669, 500, 1, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.786058');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '866931781', 1848.63159837034, 500, 16, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.786058');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '868378133', 7998.78272584079, 500, 8, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.786058');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '872308278', 9222.65394724128, 500, 17, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.79692');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '854032309', 3102.69894198732, 500, 2, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.803903');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '842782667', 1395.01095515513, 500, 5, false, 2, '[{"kvartal": 3, "årstall": 2022}, {"kvartal": 2, "årstall": 2022}]', '2023-01-11 13:06:36.803903');


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.401516', '2023-01-11 13:06:27.401516');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.41491', '2023-01-11 13:06:27.41491');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.425926', '2023-01-11 13:06:27.425926');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.43852', '2023-01-11 13:06:27.43852');
INSERT INTO public.virksomhet VALUES (5, '800061965', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800061965', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.447209', '2023-01-11 13:06:27.447209');
INSERT INTO public.virksomhet VALUES (6, '881532376', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881532376', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.455144', '2023-01-11 13:06:27.455144');
INSERT INTO public.virksomhet VALUES (7, '883874352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883874352', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.461135', '2023-01-11 13:06:27.461135');
INSERT INTO public.virksomhet VALUES (8, '848147638', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848147638', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.467991', '2023-01-11 13:06:27.467991');
INSERT INTO public.virksomhet VALUES (9, '876763949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876763949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.475366', '2023-01-11 13:06:27.475366');
INSERT INTO public.virksomhet VALUES (10, '871871807', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871871807', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.481547', '2023-01-11 13:06:27.481547');
INSERT INTO public.virksomhet VALUES (11, '864079801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864079801', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.487941', '2023-01-11 13:06:27.487941');
INSERT INTO public.virksomhet VALUES (12, '836041617', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836041617', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.493848', '2023-01-11 13:06:27.493848');
INSERT INTO public.virksomhet VALUES (13, '857842260', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857842260', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.500812', '2023-01-11 13:06:27.500812');
INSERT INTO public.virksomhet VALUES (14, '885073621', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885073621', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.508829', '2023-01-11 13:06:27.508829');
INSERT INTO public.virksomhet VALUES (15, '864754605', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864754605', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.516159', '2023-01-11 13:06:27.516159');
INSERT INTO public.virksomhet VALUES (16, '846347581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846347581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.522549', '2023-01-11 13:06:27.522549');
INSERT INTO public.virksomhet VALUES (17, '824680794', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824680794', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.529159', '2023-01-11 13:06:27.529159');
INSERT INTO public.virksomhet VALUES (18, '839415001', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839415001', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.535376', '2023-01-11 13:06:27.535376');
INSERT INTO public.virksomhet VALUES (19, '861744528', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861744528', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.541516', '2023-01-11 13:06:27.541516');
INSERT INTO public.virksomhet VALUES (20, '860138909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860138909', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.546974', '2023-01-11 13:06:27.546974');
INSERT INTO public.virksomhet VALUES (21, '843242104', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843242104', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.552624', '2023-01-11 13:06:27.552624');
INSERT INTO public.virksomhet VALUES (22, '890093850', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890093850', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.55781', '2023-01-11 13:06:27.55781');
INSERT INTO public.virksomhet VALUES (23, '892511017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892511017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.563054', '2023-01-11 13:06:27.563054');
INSERT INTO public.virksomhet VALUES (24, '842605109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842605109', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.567934', '2023-01-11 13:06:27.567934');
INSERT INTO public.virksomhet VALUES (25, '870491047', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870491047', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.572747', '2023-01-11 13:06:27.572747');
INSERT INTO public.virksomhet VALUES (26, '863507760', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863507760', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.578554', '2023-01-11 13:06:27.578554');
INSERT INTO public.virksomhet VALUES (27, '817257908', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817257908', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.584305', '2023-01-11 13:06:27.584305');
INSERT INTO public.virksomhet VALUES (28, '809042383', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809042383', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.589829', '2023-01-11 13:06:27.589829');
INSERT INTO public.virksomhet VALUES (29, '810734693', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810734693', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.595151', '2023-01-11 13:06:27.595151');
INSERT INTO public.virksomhet VALUES (30, '804629062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804629062', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.600354', '2023-01-11 13:06:27.600354');
INSERT INTO public.virksomhet VALUES (31, '873621335', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873621335', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.606577', '2023-01-11 13:06:27.606577');
INSERT INTO public.virksomhet VALUES (32, '835058832', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835058832', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.612434', '2023-01-11 13:06:27.612434');
INSERT INTO public.virksomhet VALUES (33, '803826652', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803826652', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.61833', '2023-01-11 13:06:27.61833');
INSERT INTO public.virksomhet VALUES (34, '874394467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874394467', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.624326', '2023-01-11 13:06:27.624326');
INSERT INTO public.virksomhet VALUES (35, '838903289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838903289', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.630028', '2023-01-11 13:06:27.630028');
INSERT INTO public.virksomhet VALUES (36, '882051647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882051647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.636153', '2023-01-11 13:06:27.636153');
INSERT INTO public.virksomhet VALUES (37, '879681201', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879681201', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.642283', '2023-01-11 13:06:27.642283');
INSERT INTO public.virksomhet VALUES (38, '852409131', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852409131', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.647765', '2023-01-11 13:06:27.647765');
INSERT INTO public.virksomhet VALUES (39, '808215075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808215075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.653568', '2023-01-11 13:06:27.653568');
INSERT INTO public.virksomhet VALUES (40, '865074415', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865074415', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.658914', '2023-01-11 13:06:27.658914');
INSERT INTO public.virksomhet VALUES (41, '836669149', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836669149', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.665521', '2023-01-11 13:06:27.665521');
INSERT INTO public.virksomhet VALUES (42, '884369776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884369776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.672207', '2023-01-11 13:06:27.672207');
INSERT INTO public.virksomhet VALUES (43, '873418367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873418367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.679104', '2023-01-11 13:06:27.679104');
INSERT INTO public.virksomhet VALUES (44, '802905016', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802905016', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.686953', '2023-01-11 13:06:27.686953');
INSERT INTO public.virksomhet VALUES (45, '885609899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885609899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.695023', '2023-01-11 13:06:27.695023');
INSERT INTO public.virksomhet VALUES (46, '860836918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860836918', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.702866', '2023-01-11 13:06:27.702866');
INSERT INTO public.virksomhet VALUES (47, '829745509', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829745509', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.709298', '2023-01-11 13:06:27.709298');
INSERT INTO public.virksomhet VALUES (48, '844246611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844246611', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.715895', '2023-01-11 13:06:27.715895');
INSERT INTO public.virksomhet VALUES (49, '867216743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867216743', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.722393', '2023-01-11 13:06:27.722393');
INSERT INTO public.virksomhet VALUES (50, '890941228', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890941228', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.72905', '2023-01-11 13:06:27.72905');
INSERT INTO public.virksomhet VALUES (51, '838540049', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838540049', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.734799', '2023-01-11 13:06:27.734799');
INSERT INTO public.virksomhet VALUES (52, '809501750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809501750', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.741945', '2023-01-11 13:06:27.741945');
INSERT INTO public.virksomhet VALUES (53, '844496478', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844496478', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.74764', '2023-01-11 13:06:27.74764');
INSERT INTO public.virksomhet VALUES (54, '863501025', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863501025', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.753083', '2023-01-11 13:06:27.753083');
INSERT INTO public.virksomhet VALUES (55, '839166324', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839166324', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.758506', '2023-01-11 13:06:27.758506');
INSERT INTO public.virksomhet VALUES (56, '879962157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879962157', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.764098', '2023-01-11 13:06:27.764098');
INSERT INTO public.virksomhet VALUES (57, '848543645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848543645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.769145', '2023-01-11 13:06:27.769145');
INSERT INTO public.virksomhet VALUES (58, '880279851', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880279851', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.774448', '2023-01-11 13:06:27.774448');
INSERT INTO public.virksomhet VALUES (59, '808671188', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808671188', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.779361', '2023-01-11 13:06:27.779361');
INSERT INTO public.virksomhet VALUES (60, '851333885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851333885', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.784482', '2023-01-11 13:06:27.784482');
INSERT INTO public.virksomhet VALUES (61, '815366017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815366017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.789493', '2023-01-11 13:06:27.789493');
INSERT INTO public.virksomhet VALUES (62, '891113900', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891113900', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.79505', '2023-01-11 13:06:27.79505');
INSERT INTO public.virksomhet VALUES (63, '894926128', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894926128', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.800651', '2023-01-11 13:06:27.800651');
INSERT INTO public.virksomhet VALUES (64, '802290404', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802290404', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.805791', '2023-01-11 13:06:27.805791');
INSERT INTO public.virksomhet VALUES (65, '896239097', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896239097', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.811149', '2023-01-11 13:06:27.811149');
INSERT INTO public.virksomhet VALUES (66, '816868949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816868949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.816393', '2023-01-11 13:06:27.816393');
INSERT INTO public.virksomhet VALUES (67, '895298219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895298219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.821343', '2023-01-11 13:06:27.821343');
INSERT INTO public.virksomhet VALUES (68, '842893897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842893897', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.826333', '2023-01-11 13:06:27.826333');
INSERT INTO public.virksomhet VALUES (69, '814670938', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814670938', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.831475', '2023-01-11 13:06:27.831475');
INSERT INTO public.virksomhet VALUES (70, '820433803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820433803', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.836405', '2023-01-11 13:06:27.836405');
INSERT INTO public.virksomhet VALUES (71, '874104569', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874104569', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.842003', '2023-01-11 13:06:27.842003');
INSERT INTO public.virksomhet VALUES (72, '856520283', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856520283', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.847417', '2023-01-11 13:06:27.847417');
INSERT INTO public.virksomhet VALUES (73, '879090305', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879090305', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.852571', '2023-01-11 13:06:27.852571');
INSERT INTO public.virksomhet VALUES (74, '809468321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809468321', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.857379', '2023-01-11 13:06:27.857379');
INSERT INTO public.virksomhet VALUES (75, '826378947', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826378947', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.862497', '2023-01-11 13:06:27.862497');
INSERT INTO public.virksomhet VALUES (76, '866390365', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866390365', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.868203', '2023-01-11 13:06:27.868203');
INSERT INTO public.virksomhet VALUES (77, '862771013', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862771013', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.874173', '2023-01-11 13:06:27.874173');
INSERT INTO public.virksomhet VALUES (78, '864363318', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864363318', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.879099', '2023-01-11 13:06:27.879099');
INSERT INTO public.virksomhet VALUES (79, '896438075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896438075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.884518', '2023-01-11 13:06:27.884518');
INSERT INTO public.virksomhet VALUES (80, '829368106', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829368106', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.889624', '2023-01-11 13:06:27.889624');
INSERT INTO public.virksomhet VALUES (81, '867407313', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867407313', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.894998', '2023-01-11 13:06:27.894998');
INSERT INTO public.virksomhet VALUES (82, '896587504', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896587504', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.900417', '2023-01-11 13:06:27.900417');
INSERT INTO public.virksomhet VALUES (83, '847845944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847845944', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.906307', '2023-01-11 13:06:27.906307');
INSERT INTO public.virksomhet VALUES (84, '826389298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826389298', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.911596', '2023-01-11 13:06:27.911596');
INSERT INTO public.virksomhet VALUES (85, '848399886', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848399886', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.916334', '2023-01-11 13:06:27.916334');
INSERT INTO public.virksomhet VALUES (86, '854846835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854846835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.921454', '2023-01-11 13:06:27.921454');
INSERT INTO public.virksomhet VALUES (87, '800634899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800634899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.926853', '2023-01-11 13:06:27.926853');
INSERT INTO public.virksomhet VALUES (88, '857110616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857110616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.932032', '2023-01-11 13:06:27.932032');
INSERT INTO public.virksomhet VALUES (89, '808271586', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808271586', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.937643', '2023-01-11 13:06:27.937643');
INSERT INTO public.virksomhet VALUES (90, '819801010', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819801010', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.942952', '2023-01-11 13:06:27.942952');
INSERT INTO public.virksomhet VALUES (91, '848578637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848578637', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.947661', '2023-01-11 13:06:27.947661');
INSERT INTO public.virksomhet VALUES (92, '827490752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827490752', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.952914', '2023-01-11 13:06:27.952914');
INSERT INTO public.virksomhet VALUES (93, '835736810', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835736810', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.96024', '2023-01-11 13:06:27.96024');
INSERT INTO public.virksomhet VALUES (94, '857544475', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857544475', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.966742', '2023-01-11 13:06:27.966742');
INSERT INTO public.virksomhet VALUES (95, '847721823', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847721823', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.972375', '2023-01-11 13:06:27.972375');
INSERT INTO public.virksomhet VALUES (96, '862581603', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862581603', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.97824', '2023-01-11 13:06:27.97824');
INSERT INTO public.virksomhet VALUES (97, '810313500', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810313500', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.983604', '2023-01-11 13:06:27.983604');
INSERT INTO public.virksomhet VALUES (98, '885129733', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885129733', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.98867', '2023-01-11 13:06:27.98867');
INSERT INTO public.virksomhet VALUES (99, '898243796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898243796', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.99387', '2023-01-11 13:06:27.99387');
INSERT INTO public.virksomhet VALUES (100, '887079787', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887079787', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:27.999181', '2023-01-11 13:06:27.999181');
INSERT INTO public.virksomhet VALUES (101, '861058672', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861058672', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.004421', '2023-01-11 13:06:28.004421');
INSERT INTO public.virksomhet VALUES (102, '876537913', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876537913', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.010441', '2023-01-11 13:06:28.010441');
INSERT INTO public.virksomhet VALUES (103, '890597928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890597928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.017086', '2023-01-11 13:06:28.017086');
INSERT INTO public.virksomhet VALUES (104, '842982051', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842982051', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.024543', '2023-01-11 13:06:28.024543');
INSERT INTO public.virksomhet VALUES (105, '842389667', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842389667', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.030396', '2023-01-11 13:06:28.030396');
INSERT INTO public.virksomhet VALUES (106, '820004072', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820004072', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.035653', '2023-01-11 13:06:28.035653');
INSERT INTO public.virksomhet VALUES (107, '897688257', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897688257', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.040904', '2023-01-11 13:06:28.040904');
INSERT INTO public.virksomhet VALUES (108, '837534390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837534390', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.046542', '2023-01-11 13:06:28.046542');
INSERT INTO public.virksomhet VALUES (109, '808543637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808543637', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.051426', '2023-01-11 13:06:28.051426');
INSERT INTO public.virksomhet VALUES (110, '870201888', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870201888', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.056181', '2023-01-11 13:06:28.056181');
INSERT INTO public.virksomhet VALUES (111, '817311070', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817311070', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.061336', '2023-01-11 13:06:28.061336');
INSERT INTO public.virksomhet VALUES (112, '868012776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868012776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.066641', '2023-01-11 13:06:28.066641');
INSERT INTO public.virksomhet VALUES (113, '896429753', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896429753', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.072236', '2023-01-11 13:06:28.072236');
INSERT INTO public.virksomhet VALUES (114, '851603425', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851603425', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.077144', '2023-01-11 13:06:28.077144');
INSERT INTO public.virksomhet VALUES (115, '827443317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827443317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.081767', '2023-01-11 13:06:28.081767');
INSERT INTO public.virksomhet VALUES (116, '833362642', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833362642', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.08713', '2023-01-11 13:06:28.08713');
INSERT INTO public.virksomhet VALUES (117, '882069408', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882069408', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.092125', '2023-01-11 13:06:28.092125');
INSERT INTO public.virksomhet VALUES (118, '863878944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863878944', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.100827', '2023-01-11 13:06:28.100827');
INSERT INTO public.virksomhet VALUES (119, '866558221', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866558221', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.106082', '2023-01-11 13:06:28.106082');
INSERT INTO public.virksomhet VALUES (120, '868767855', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868767855', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.111196', '2023-01-11 13:06:28.111196');
INSERT INTO public.virksomhet VALUES (121, '875885300', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875885300', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.116036', '2023-01-11 13:06:28.116036');
INSERT INTO public.virksomhet VALUES (122, '842216735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842216735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.12112', '2023-01-11 13:06:28.12112');
INSERT INTO public.virksomhet VALUES (123, '856920437', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856920437', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.126998', '2023-01-11 13:06:28.126998');
INSERT INTO public.virksomhet VALUES (124, '830858963', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830858963', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.133767', '2023-01-11 13:06:28.133767');
INSERT INTO public.virksomhet VALUES (125, '812434114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812434114', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.139826', '2023-01-11 13:06:28.139826');
INSERT INTO public.virksomhet VALUES (126, '847041353', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847041353', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.145323', '2023-01-11 13:06:28.145323');
INSERT INTO public.virksomhet VALUES (127, '803269327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803269327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.150458', '2023-01-11 13:06:28.150458');
INSERT INTO public.virksomhet VALUES (128, '843457384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843457384', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.155647', '2023-01-11 13:06:28.155647');
INSERT INTO public.virksomhet VALUES (129, '818306281', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818306281', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.160828', '2023-01-11 13:06:28.160828');
INSERT INTO public.virksomhet VALUES (130, '844449510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844449510', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.166142', '2023-01-11 13:06:28.166142');
INSERT INTO public.virksomhet VALUES (131, '867177223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867177223', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.170932', '2023-01-11 13:06:28.170932');
INSERT INTO public.virksomhet VALUES (132, '883963814', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883963814', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.176165', '2023-01-11 13:06:28.176165');
INSERT INTO public.virksomhet VALUES (133, '886253015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886253015', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.180931', '2023-01-11 13:06:28.180931');
INSERT INTO public.virksomhet VALUES (134, '895281822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895281822', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.186128', '2023-01-11 13:06:28.186128');
INSERT INTO public.virksomhet VALUES (135, '840533481', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840533481', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.19096', '2023-01-11 13:06:28.19096');
INSERT INTO public.virksomhet VALUES (136, '839216776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839216776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.195607', '2023-01-11 13:06:28.195607');
INSERT INTO public.virksomhet VALUES (137, '803533948', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803533948', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.20009', '2023-01-11 13:06:28.20009');
INSERT INTO public.virksomhet VALUES (138, '827095124', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827095124', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.204938', '2023-01-11 13:06:28.204938');
INSERT INTO public.virksomhet VALUES (139, '808251981', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808251981', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.21005', '2023-01-11 13:06:28.21005');
INSERT INTO public.virksomhet VALUES (140, '817358823', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817358823', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.214764', '2023-01-11 13:06:28.214764');
INSERT INTO public.virksomhet VALUES (141, '871910327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871910327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.219766', '2023-01-11 13:06:28.219766');
INSERT INTO public.virksomhet VALUES (142, '866587133', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866587133', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.224326', '2023-01-11 13:06:28.224326');
INSERT INTO public.virksomhet VALUES (143, '842840788', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842840788', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.229184', '2023-01-11 13:06:28.229184');
INSERT INTO public.virksomhet VALUES (144, '812781923', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812781923', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.233973', '2023-01-11 13:06:28.233973');
INSERT INTO public.virksomhet VALUES (145, '804058381', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804058381', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.238866', '2023-01-11 13:06:28.238866');
INSERT INTO public.virksomhet VALUES (146, '811423248', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811423248', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.24405', '2023-01-11 13:06:28.24405');
INSERT INTO public.virksomhet VALUES (147, '840837641', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840837641', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.249077', '2023-01-11 13:06:28.249077');
INSERT INTO public.virksomhet VALUES (148, '818816392', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818816392', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.254435', '2023-01-11 13:06:28.254435');
INSERT INTO public.virksomhet VALUES (149, '806494928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806494928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.260528', '2023-01-11 13:06:28.260528');
INSERT INTO public.virksomhet VALUES (150, '893055618', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893055618', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.265642', '2023-01-11 13:06:28.265642');
INSERT INTO public.virksomhet VALUES (151, '875340822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875340822', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.271813', '2023-01-11 13:06:28.271813');
INSERT INTO public.virksomhet VALUES (152, '818463756', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818463756', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.276694', '2023-01-11 13:06:28.276694');
INSERT INTO public.virksomhet VALUES (153, '884152302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884152302', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.28237', '2023-01-11 13:06:28.28237');
INSERT INTO public.virksomhet VALUES (154, '849742742', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849742742', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.287922', '2023-01-11 13:06:28.287922');
INSERT INTO public.virksomhet VALUES (155, '804979817', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804979817', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.293652', '2023-01-11 13:06:28.293652');
INSERT INTO public.virksomhet VALUES (156, '814190896', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814190896', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.298763', '2023-01-11 13:06:28.298763');
INSERT INTO public.virksomhet VALUES (157, '822331640', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822331640', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.30425', '2023-01-11 13:06:28.30425');
INSERT INTO public.virksomhet VALUES (158, '862678317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862678317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.309297', '2023-01-11 13:06:28.309297');
INSERT INTO public.virksomhet VALUES (159, '831093023', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831093023', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.314789', '2023-01-11 13:06:28.314789');
INSERT INTO public.virksomhet VALUES (160, '874226454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874226454', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.321181', '2023-01-11 13:06:28.321181');
INSERT INTO public.virksomhet VALUES (161, '832436811', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832436811', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.326833', '2023-01-11 13:06:28.326833');
INSERT INTO public.virksomhet VALUES (162, '838432048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838432048', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.332462', '2023-01-11 13:06:28.332462');
INSERT INTO public.virksomhet VALUES (163, '870022919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870022919', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.337676', '2023-01-11 13:06:28.337676');
INSERT INTO public.virksomhet VALUES (164, '879268334', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879268334', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.34249', '2023-01-11 13:06:28.34249');
INSERT INTO public.virksomhet VALUES (165, '806599852', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806599852', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.347346', '2023-01-11 13:06:28.347346');
INSERT INTO public.virksomhet VALUES (166, '863181199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863181199', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.352595', '2023-01-11 13:06:28.352595');
INSERT INTO public.virksomhet VALUES (167, '863767568', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863767568', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.35776', '2023-01-11 13:06:28.35776');
INSERT INTO public.virksomhet VALUES (168, '844014636', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844014636', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.363067', '2023-01-11 13:06:28.363067');
INSERT INTO public.virksomhet VALUES (169, '866404710', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866404710', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.368088', '2023-01-11 13:06:28.368088');
INSERT INTO public.virksomhet VALUES (170, '833129946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833129946', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.373275', '2023-01-11 13:06:28.373275');
INSERT INTO public.virksomhet VALUES (171, '846977998', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846977998', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.378388', '2023-01-11 13:06:28.378388');
INSERT INTO public.virksomhet VALUES (172, '811030348', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811030348', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.383454', '2023-01-11 13:06:28.383454');
INSERT INTO public.virksomhet VALUES (173, '890815907', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890815907', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.388572', '2023-01-11 13:06:28.388572');
INSERT INTO public.virksomhet VALUES (174, '822694021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822694021', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.394295', '2023-01-11 13:06:28.394295');
INSERT INTO public.virksomhet VALUES (175, '852558904', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852558904', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.400578', '2023-01-11 13:06:28.400578');
INSERT INTO public.virksomhet VALUES (176, '822874914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822874914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.406897', '2023-01-11 13:06:28.406897');
INSERT INTO public.virksomhet VALUES (177, '866646453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866646453', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.412132', '2023-01-11 13:06:28.412132');
INSERT INTO public.virksomhet VALUES (178, '881021956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881021956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.418995', '2023-01-11 13:06:28.418995');
INSERT INTO public.virksomhet VALUES (179, '899291735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899291735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.423369', '2023-01-11 13:06:28.423369');
INSERT INTO public.virksomhet VALUES (180, '867918928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867918928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.427802', '2023-01-11 13:06:28.427802');
INSERT INTO public.virksomhet VALUES (181, '823439458', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823439458', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.432456', '2023-01-11 13:06:28.432456');
INSERT INTO public.virksomhet VALUES (182, '837805347', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837805347', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.437038', '2023-01-11 13:06:28.437038');
INSERT INTO public.virksomhet VALUES (183, '805499088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805499088', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.442023', '2023-01-11 13:06:28.442023');
INSERT INTO public.virksomhet VALUES (184, '845822610', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845822610', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.447507', '2023-01-11 13:06:28.447507');
INSERT INTO public.virksomhet VALUES (185, '841405633', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841405633', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.452352', '2023-01-11 13:06:28.452352');
INSERT INTO public.virksomhet VALUES (186, '889675608', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889675608', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.456761', '2023-01-11 13:06:28.456761');
INSERT INTO public.virksomhet VALUES (187, '899025387', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899025387', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.4624', '2023-01-11 13:06:28.4624');
INSERT INTO public.virksomhet VALUES (188, '863280835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863280835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.467249', '2023-01-11 13:06:28.467249');
INSERT INTO public.virksomhet VALUES (189, '860629673', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860629673', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.472383', '2023-01-11 13:06:28.472383');
INSERT INTO public.virksomhet VALUES (190, '833667497', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833667497', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.47743', '2023-01-11 13:06:28.47743');
INSERT INTO public.virksomhet VALUES (191, '842471044', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842471044', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.482137', '2023-01-11 13:06:28.482137');
INSERT INTO public.virksomhet VALUES (192, '861459803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861459803', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.490941', '2023-01-11 13:06:28.490941');
INSERT INTO public.virksomhet VALUES (193, '812926032', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812926032', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.496405', '2023-01-11 13:06:28.496405');
INSERT INTO public.virksomhet VALUES (194, '871631319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871631319', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.50162', '2023-01-11 13:06:28.50162');
INSERT INTO public.virksomhet VALUES (195, '865439281', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865439281', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.507198', '2023-01-11 13:06:28.507198');
INSERT INTO public.virksomhet VALUES (196, '824210548', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824210548', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.512724', '2023-01-11 13:06:28.512724');
INSERT INTO public.virksomhet VALUES (197, '805486005', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805486005', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.524717', '2023-01-11 13:06:28.524717');
INSERT INTO public.virksomhet VALUES (198, '832448472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832448472', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.532697', '2023-01-11 13:06:28.532697');
INSERT INTO public.virksomhet VALUES (199, '805820685', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805820685', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.541009', '2023-01-11 13:06:28.541009');
INSERT INTO public.virksomhet VALUES (200, '883768894', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883768894', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.547534', '2023-01-11 13:06:28.547534');
INSERT INTO public.virksomhet VALUES (201, '856903021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856903021', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.552432', '2023-01-11 13:06:28.552432');
INSERT INTO public.virksomhet VALUES (202, '850012745', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850012745', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.557344', '2023-01-11 13:06:28.557344');
INSERT INTO public.virksomhet VALUES (203, '820149848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820149848', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.561791', '2023-01-11 13:06:28.561791');
INSERT INTO public.virksomhet VALUES (204, '822705108', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822705108', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.566326', '2023-01-11 13:06:28.566326');
INSERT INTO public.virksomhet VALUES (205, '857573851', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857573851', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.570857', '2023-01-11 13:06:28.570857');
INSERT INTO public.virksomhet VALUES (206, '856078198', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856078198', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.57571', '2023-01-11 13:06:28.57571');
INSERT INTO public.virksomhet VALUES (207, '859225721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859225721', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.580122', '2023-01-11 13:06:28.580122');
INSERT INTO public.virksomhet VALUES (208, '873879874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873879874', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.585056', '2023-01-11 13:06:28.585056');
INSERT INTO public.virksomhet VALUES (209, '890065285', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890065285', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.58989', '2023-01-11 13:06:28.58989');
INSERT INTO public.virksomhet VALUES (210, '893423280', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893423280', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.595008', '2023-01-11 13:06:28.595008');
INSERT INTO public.virksomhet VALUES (211, '816273126', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816273126', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.600145', '2023-01-11 13:06:28.600145');
INSERT INTO public.virksomhet VALUES (212, '874977909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874977909', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.605298', '2023-01-11 13:06:28.605298');
INSERT INTO public.virksomhet VALUES (213, '888632161', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888632161', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.610398', '2023-01-11 13:06:28.610398');
INSERT INTO public.virksomhet VALUES (214, '852452427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852452427', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.615453', '2023-01-11 13:06:28.615453');
INSERT INTO public.virksomhet VALUES (215, '807389236', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807389236', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.620971', '2023-01-11 13:06:28.620971');
INSERT INTO public.virksomhet VALUES (216, '833163111', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833163111', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.62608', '2023-01-11 13:06:28.62608');
INSERT INTO public.virksomhet VALUES (217, '813080832', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813080832', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.631841', '2023-01-11 13:06:28.631841');
INSERT INTO public.virksomhet VALUES (218, '896489260', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896489260', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.636513', '2023-01-11 13:06:28.636513');
INSERT INTO public.virksomhet VALUES (219, '845881839', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845881839', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.641793', '2023-01-11 13:06:28.641793');
INSERT INTO public.virksomhet VALUES (220, '898157169', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898157169', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.646836', '2023-01-11 13:06:28.646836');
INSERT INTO public.virksomhet VALUES (221, '882940656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882940656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.65178', '2023-01-11 13:06:28.65178');
INSERT INTO public.virksomhet VALUES (222, '887589106', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887589106', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.656687', '2023-01-11 13:06:28.656687');
INSERT INTO public.virksomhet VALUES (223, '856439808', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856439808', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.662336', '2023-01-11 13:06:28.662336');
INSERT INTO public.virksomhet VALUES (224, '869911712', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869911712', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.667573', '2023-01-11 13:06:28.667573');
INSERT INTO public.virksomhet VALUES (225, '836420677', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836420677', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.673031', '2023-01-11 13:06:28.673031');
INSERT INTO public.virksomhet VALUES (226, '810521018', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810521018', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.678287', '2023-01-11 13:06:28.678287');
INSERT INTO public.virksomhet VALUES (227, '863021621', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863021621', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.683549', '2023-01-11 13:06:28.683549');
INSERT INTO public.virksomhet VALUES (228, '846289494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846289494', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.688766', '2023-01-11 13:06:28.688766');
INSERT INTO public.virksomhet VALUES (229, '834191416', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834191416', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.69401', '2023-01-11 13:06:28.69401');
INSERT INTO public.virksomhet VALUES (230, '837420340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837420340', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.699507', '2023-01-11 13:06:28.699507');
INSERT INTO public.virksomhet VALUES (231, '871949311', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871949311', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.706508', '2023-01-11 13:06:28.706508');
INSERT INTO public.virksomhet VALUES (232, '821633142', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821633142', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.713972', '2023-01-11 13:06:28.713972');
INSERT INTO public.virksomhet VALUES (233, '893463166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893463166', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.719761', '2023-01-11 13:06:28.719761');
INSERT INTO public.virksomhet VALUES (234, '833218825', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833218825', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.724456', '2023-01-11 13:06:28.724456');
INSERT INTO public.virksomhet VALUES (235, '807456455', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807456455', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.73047', '2023-01-11 13:06:28.73047');
INSERT INTO public.virksomhet VALUES (236, '821381486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821381486', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.73608', '2023-01-11 13:06:28.73608');
INSERT INTO public.virksomhet VALUES (237, '814324199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814324199', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.742972', '2023-01-11 13:06:28.742972');
INSERT INTO public.virksomhet VALUES (238, '805904949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805904949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.749927', '2023-01-11 13:06:28.749927');
INSERT INTO public.virksomhet VALUES (239, '813242515', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813242515', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.756055', '2023-01-11 13:06:28.756055');
INSERT INTO public.virksomhet VALUES (240, '839415843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839415843', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.765122', '2023-01-11 13:06:28.765122');
INSERT INTO public.virksomhet VALUES (241, '804234371', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804234371', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.770666', '2023-01-11 13:06:28.770666');
INSERT INTO public.virksomhet VALUES (242, '816585946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816585946', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.776464', '2023-01-11 13:06:28.776464');
INSERT INTO public.virksomhet VALUES (243, '824097835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824097835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.782868', '2023-01-11 13:06:28.782868');
INSERT INTO public.virksomhet VALUES (244, '880538674', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880538674', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.789384', '2023-01-11 13:06:28.789384');
INSERT INTO public.virksomhet VALUES (245, '875775705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875775705', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.795542', '2023-01-11 13:06:28.795542');
INSERT INTO public.virksomhet VALUES (246, '877421692', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877421692', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.801527', '2023-01-11 13:06:28.801527');
INSERT INTO public.virksomhet VALUES (247, '871547736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871547736', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.806661', '2023-01-11 13:06:28.806661');
INSERT INTO public.virksomhet VALUES (248, '857653378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857653378', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.811854', '2023-01-11 13:06:28.811854');
INSERT INTO public.virksomhet VALUES (249, '829980700', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829980700', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.816737', '2023-01-11 13:06:28.816737');
INSERT INTO public.virksomhet VALUES (250, '852627790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852627790', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.821779', '2023-01-11 13:06:28.821779');
INSERT INTO public.virksomhet VALUES (251, '865978526', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865978526', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.826428', '2023-01-11 13:06:28.826428');
INSERT INTO public.virksomhet VALUES (252, '840145629', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840145629', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.83142', '2023-01-11 13:06:28.83142');
INSERT INTO public.virksomhet VALUES (253, '875016141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875016141', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.83593', '2023-01-11 13:06:28.83593');
INSERT INTO public.virksomhet VALUES (254, '869419134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869419134', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.840835', '2023-01-11 13:06:28.840835');
INSERT INTO public.virksomhet VALUES (255, '813944600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813944600', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.84555', '2023-01-11 13:06:28.84555');
INSERT INTO public.virksomhet VALUES (256, '885600454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885600454', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.850255', '2023-01-11 13:06:28.850255');
INSERT INTO public.virksomhet VALUES (257, '877550656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877550656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.855478', '2023-01-11 13:06:28.855478');
INSERT INTO public.virksomhet VALUES (258, '804227830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804227830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.860047', '2023-01-11 13:06:28.860047');
INSERT INTO public.virksomhet VALUES (259, '858956619', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858956619', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.864535', '2023-01-11 13:06:28.864535');
INSERT INTO public.virksomhet VALUES (260, '865153645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865153645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.869164', '2023-01-11 13:06:28.869164');
INSERT INTO public.virksomhet VALUES (261, '817941723', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817941723', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.874034', '2023-01-11 13:06:28.874034');
INSERT INTO public.virksomhet VALUES (262, '811667993', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811667993', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.878737', '2023-01-11 13:06:28.878737');
INSERT INTO public.virksomhet VALUES (263, '859462534', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859462534', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.883387', '2023-01-11 13:06:28.883387');
INSERT INTO public.virksomhet VALUES (264, '822317092', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822317092', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.887908', '2023-01-11 13:06:28.887908');
INSERT INTO public.virksomhet VALUES (265, '877772835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877772835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.892635', '2023-01-11 13:06:28.892635');
INSERT INTO public.virksomhet VALUES (266, '846495295', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846495295', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.897404', '2023-01-11 13:06:28.897404');
INSERT INTO public.virksomhet VALUES (267, '804775869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804775869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.902282', '2023-01-11 13:06:28.902282');
INSERT INTO public.virksomhet VALUES (268, '831030012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831030012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.907066', '2023-01-11 13:06:28.907066');
INSERT INTO public.virksomhet VALUES (269, '802809462', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802809462', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.911862', '2023-01-11 13:06:28.911862');
INSERT INTO public.virksomhet VALUES (270, '896200151', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896200151', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.916349', '2023-01-11 13:06:28.916349');
INSERT INTO public.virksomhet VALUES (271, '873610100', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873610100', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.921374', '2023-01-11 13:06:28.921374');
INSERT INTO public.virksomhet VALUES (272, '847931581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847931581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.926874', '2023-01-11 13:06:28.926874');
INSERT INTO public.virksomhet VALUES (273, '870810427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870810427', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.93232', '2023-01-11 13:06:28.93232');
INSERT INTO public.virksomhet VALUES (274, '816457914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816457914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.937009', '2023-01-11 13:06:28.937009');
INSERT INTO public.virksomhet VALUES (275, '816760477', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816760477', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.941669', '2023-01-11 13:06:28.941669');
INSERT INTO public.virksomhet VALUES (276, '821449527', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821449527', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.946587', '2023-01-11 13:06:28.946587');
INSERT INTO public.virksomhet VALUES (277, '897412997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897412997', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.951392', '2023-01-11 13:06:28.951392');
INSERT INTO public.virksomhet VALUES (278, '801856356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801856356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.955958', '2023-01-11 13:06:28.955958');
INSERT INTO public.virksomhet VALUES (279, '898170941', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898170941', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.961363', '2023-01-11 13:06:28.961363');
INSERT INTO public.virksomhet VALUES (280, '884390144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884390144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.966165', '2023-01-11 13:06:28.966165');
INSERT INTO public.virksomhet VALUES (281, '894424841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894424841', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.971509', '2023-01-11 13:06:28.971509');
INSERT INTO public.virksomhet VALUES (282, '828972512', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828972512', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.9764', '2023-01-11 13:06:28.9764');
INSERT INTO public.virksomhet VALUES (283, '815082581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815082581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.980905', '2023-01-11 13:06:28.980905');
INSERT INTO public.virksomhet VALUES (284, '887159012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887159012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.98559', '2023-01-11 13:06:28.98559');
INSERT INTO public.virksomhet VALUES (285, '829493874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829493874', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.990264', '2023-01-11 13:06:28.990264');
INSERT INTO public.virksomhet VALUES (286, '814929193', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814929193', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:28.994937', '2023-01-11 13:06:28.994937');
INSERT INTO public.virksomhet VALUES (287, '859907302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859907302', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.00014', '2023-01-11 13:06:29.00014');
INSERT INTO public.virksomhet VALUES (288, '895124699', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895124699', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.004957', '2023-01-11 13:06:29.004957');
INSERT INTO public.virksomhet VALUES (289, '813239227', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813239227', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.009273', '2023-01-11 13:06:29.009273');
INSERT INTO public.virksomhet VALUES (290, '840430296', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840430296', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.014476', '2023-01-11 13:06:29.014476');
INSERT INTO public.virksomhet VALUES (291, '858726639', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858726639', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.019487', '2023-01-11 13:06:29.019487');
INSERT INTO public.virksomhet VALUES (292, '823234800', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823234800', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.025272', '2023-01-11 13:06:29.025272');
INSERT INTO public.virksomhet VALUES (293, '874361830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874361830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.03233', '2023-01-11 13:06:29.03233');
INSERT INTO public.virksomhet VALUES (294, '808481735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808481735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.038581', '2023-01-11 13:06:29.038581');
INSERT INTO public.virksomhet VALUES (295, '860499175', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860499175', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.044646', '2023-01-11 13:06:29.044646');
INSERT INTO public.virksomhet VALUES (296, '892697142', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892697142', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.052785', '2023-01-11 13:06:29.052785');
INSERT INTO public.virksomhet VALUES (297, '826727890', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826727890', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.058787', '2023-01-11 13:06:29.058787');
INSERT INTO public.virksomhet VALUES (298, '895582762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895582762', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.064501', '2023-01-11 13:06:29.064501');
INSERT INTO public.virksomhet VALUES (299, '814663914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814663914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.069559', '2023-01-11 13:06:29.069559');
INSERT INTO public.virksomhet VALUES (300, '887191975', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887191975', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.074883', '2023-01-11 13:06:29.074883');
INSERT INTO public.virksomhet VALUES (301, '856729012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856729012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.080442', '2023-01-11 13:06:29.080442');
INSERT INTO public.virksomhet VALUES (302, '816248533', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816248533', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.085796', '2023-01-11 13:06:29.085796');
INSERT INTO public.virksomhet VALUES (303, '847253663', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847253663', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.090863', '2023-01-11 13:06:29.090863');
INSERT INTO public.virksomhet VALUES (304, '851556995', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851556995', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.09625', '2023-01-11 13:06:29.09625');
INSERT INTO public.virksomhet VALUES (305, '897000352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897000352', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.101002', '2023-01-11 13:06:29.101002');
INSERT INTO public.virksomhet VALUES (306, '891267708', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891267708', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.106338', '2023-01-11 13:06:29.106338');
INSERT INTO public.virksomhet VALUES (307, '868369009', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868369009', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.111862', '2023-01-11 13:06:29.111862');
INSERT INTO public.virksomhet VALUES (308, '836786224', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836786224', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.117365', '2023-01-11 13:06:29.117365');
INSERT INTO public.virksomhet VALUES (309, '800910790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800910790', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.122728', '2023-01-11 13:06:29.122728');
INSERT INTO public.virksomhet VALUES (310, '847922087', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847922087', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.12736', '2023-01-11 13:06:29.12736');
INSERT INTO public.virksomhet VALUES (311, '882737279', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882737279', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.133298', '2023-01-11 13:06:29.133298');
INSERT INTO public.virksomhet VALUES (312, '817612413', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817612413', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.138514', '2023-01-11 13:06:29.138514');
INSERT INTO public.virksomhet VALUES (313, '857680168', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857680168', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.143484', '2023-01-11 13:06:29.143484');
INSERT INTO public.virksomhet VALUES (314, '878624841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878624841', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.149386', '2023-01-11 13:06:29.149386');
INSERT INTO public.virksomhet VALUES (315, '867183919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867183919', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.155328', '2023-01-11 13:06:29.155328');
INSERT INTO public.virksomhet VALUES (316, '824306551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824306551', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.160509', '2023-01-11 13:06:29.160509');
INSERT INTO public.virksomhet VALUES (317, '812929350', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812929350', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.165704', '2023-01-11 13:06:29.165704');
INSERT INTO public.virksomhet VALUES (318, '890735735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890735735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.170966', '2023-01-11 13:06:29.170966');
INSERT INTO public.virksomhet VALUES (319, '894341616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894341616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.17615', '2023-01-11 13:06:29.17615');
INSERT INTO public.virksomhet VALUES (320, '845690609', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845690609', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.18116', '2023-01-11 13:06:29.18116');
INSERT INTO public.virksomhet VALUES (321, '884945724', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884945724', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.186715', '2023-01-11 13:06:29.186715');
INSERT INTO public.virksomhet VALUES (322, '820865124', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820865124', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.192398', '2023-01-11 13:06:29.192398');
INSERT INTO public.virksomhet VALUES (323, '870514368', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870514368', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.197695', '2023-01-11 13:06:29.197695');
INSERT INTO public.virksomhet VALUES (324, '833643869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833643869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.203185', '2023-01-11 13:06:29.203185');
INSERT INTO public.virksomhet VALUES (325, '807702188', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807702188', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.207843', '2023-01-11 13:06:29.207843');
INSERT INTO public.virksomhet VALUES (326, '820638689', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820638689', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.213288', '2023-01-11 13:06:29.213288');
INSERT INTO public.virksomhet VALUES (327, '843380901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843380901', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.21865', '2023-01-11 13:06:29.21865');
INSERT INTO public.virksomhet VALUES (328, '832951634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832951634', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.224055', '2023-01-11 13:06:29.224055');
INSERT INTO public.virksomhet VALUES (329, '833677243', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833677243', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.229798', '2023-01-11 13:06:29.229798');
INSERT INTO public.virksomhet VALUES (330, '873656323', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873656323', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.234946', '2023-01-11 13:06:29.234946');
INSERT INTO public.virksomhet VALUES (331, '859159231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859159231', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.239684', '2023-01-11 13:06:29.239684');
INSERT INTO public.virksomhet VALUES (332, '868067017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868067017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.245648', '2023-01-11 13:06:29.245648');
INSERT INTO public.virksomhet VALUES (333, '856435712', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856435712', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.249991', '2023-01-11 13:06:29.249991');
INSERT INTO public.virksomhet VALUES (334, '888937591', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888937591', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.254893', '2023-01-11 13:06:29.254893');
INSERT INTO public.virksomhet VALUES (335, '873906284', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873906284', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.260112', '2023-01-11 13:06:29.260112');
INSERT INTO public.virksomhet VALUES (336, '855150484', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855150484', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.265536', '2023-01-11 13:06:29.265536');
INSERT INTO public.virksomhet VALUES (337, '836365546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836365546', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.271034', '2023-01-11 13:06:29.271034');
INSERT INTO public.virksomhet VALUES (338, '822564929', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822564929', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.275662', '2023-01-11 13:06:29.275662');
INSERT INTO public.virksomhet VALUES (339, '833204596', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833204596', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.280802', '2023-01-11 13:06:29.280802');
INSERT INTO public.virksomhet VALUES (340, '863592645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863592645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.285869', '2023-01-11 13:06:29.285869');
INSERT INTO public.virksomhet VALUES (341, '865956727', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865956727', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.290378', '2023-01-11 13:06:29.290378');
INSERT INTO public.virksomhet VALUES (342, '807629933', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807629933', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.295653', '2023-01-11 13:06:29.295653');
INSERT INTO public.virksomhet VALUES (343, '832454631', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832454631', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.300482', '2023-01-11 13:06:29.300482');
INSERT INTO public.virksomhet VALUES (344, '823356725', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823356725', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.305993', '2023-01-11 13:06:29.305993');
INSERT INTO public.virksomhet VALUES (345, '800824855', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800824855', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.310976', '2023-01-11 13:06:29.310976');
INSERT INTO public.virksomhet VALUES (346, '894510083', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894510083', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.316872', '2023-01-11 13:06:29.316872');
INSERT INTO public.virksomhet VALUES (347, '815854671', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815854671', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.323799', '2023-01-11 13:06:29.323799');
INSERT INTO public.virksomhet VALUES (348, '876401827', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876401827', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.330075', '2023-01-11 13:06:29.330075');
INSERT INTO public.virksomhet VALUES (349, '845066027', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845066027', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.336525', '2023-01-11 13:06:29.336525');
INSERT INTO public.virksomhet VALUES (350, '815406101', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815406101', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.34231', '2023-01-11 13:06:29.34231');
INSERT INTO public.virksomhet VALUES (351, '866878310', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866878310', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.347968', '2023-01-11 13:06:29.347968');
INSERT INTO public.virksomhet VALUES (352, '830803739', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830803739', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.353898', '2023-01-11 13:06:29.353898');
INSERT INTO public.virksomhet VALUES (353, '805933483', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805933483', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.35884', '2023-01-11 13:06:29.35884');
INSERT INTO public.virksomhet VALUES (354, '868252144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868252144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.363717', '2023-01-11 13:06:29.363717');
INSERT INTO public.virksomhet VALUES (355, '828744326', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828744326', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.369101', '2023-01-11 13:06:29.369101');
INSERT INTO public.virksomhet VALUES (356, '830122600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830122600', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.383286', '2023-01-11 13:06:29.383286');
INSERT INTO public.virksomhet VALUES (357, '813147327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813147327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.394083', '2023-01-11 13:06:29.394083');
INSERT INTO public.virksomhet VALUES (358, '846250295', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846250295', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.403636', '2023-01-11 13:06:29.403636');
INSERT INTO public.virksomhet VALUES (359, '898250721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898250721', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.409035', '2023-01-11 13:06:29.409035');
INSERT INTO public.virksomhet VALUES (360, '813697349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813697349', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.413787', '2023-01-11 13:06:29.413787');
INSERT INTO public.virksomhet VALUES (361, '863104800', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863104800', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.418778', '2023-01-11 13:06:29.418778');
INSERT INTO public.virksomhet VALUES (362, '897979593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897979593', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.423653', '2023-01-11 13:06:29.423653');
INSERT INTO public.virksomhet VALUES (363, '860772161', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860772161', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.428666', '2023-01-11 13:06:29.428666');
INSERT INTO public.virksomhet VALUES (364, '808002552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808002552', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.433959', '2023-01-11 13:06:29.433959');
INSERT INTO public.virksomhet VALUES (365, '876394411', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876394411', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.438487', '2023-01-11 13:06:29.438487');
INSERT INTO public.virksomhet VALUES (366, '846214156', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846214156', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.444921', '2023-01-11 13:06:29.444921');
INSERT INTO public.virksomhet VALUES (367, '850015354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850015354', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.451256', '2023-01-11 13:06:29.451256');
INSERT INTO public.virksomhet VALUES (368, '805145991', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805145991', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.457335', '2023-01-11 13:06:29.457335');
INSERT INTO public.virksomhet VALUES (369, '853879838', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853879838', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.464398', '2023-01-11 13:06:29.464398');
INSERT INTO public.virksomhet VALUES (370, '882939801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882939801', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.474011', '2023-01-11 13:06:29.474011');
INSERT INTO public.virksomhet VALUES (371, '859605190', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859605190', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.481647', '2023-01-11 13:06:29.481647');
INSERT INTO public.virksomhet VALUES (372, '891814367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891814367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.48803', '2023-01-11 13:06:29.48803');
INSERT INTO public.virksomhet VALUES (373, '875021136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875021136', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.494022', '2023-01-11 13:06:29.494022');
INSERT INTO public.virksomhet VALUES (374, '825379831', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825379831', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.499909', '2023-01-11 13:06:29.499909');
INSERT INTO public.virksomhet VALUES (375, '800469195', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800469195', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.506154', '2023-01-11 13:06:29.506154');
INSERT INTO public.virksomhet VALUES (376, '871244244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871244244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.513116', '2023-01-11 13:06:29.513116');
INSERT INTO public.virksomhet VALUES (377, '837133219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837133219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.521032', '2023-01-11 13:06:29.521032');
INSERT INTO public.virksomhet VALUES (378, '855964219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855964219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.529362', '2023-01-11 13:06:29.529362');
INSERT INTO public.virksomhet VALUES (379, '838273484', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838273484', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.538391', '2023-01-11 13:06:29.538391');
INSERT INTO public.virksomhet VALUES (380, '893483616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893483616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.54471', '2023-01-11 13:06:29.54471');
INSERT INTO public.virksomhet VALUES (381, '891497759', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891497759', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.551385', '2023-01-11 13:06:29.551385');
INSERT INTO public.virksomhet VALUES (382, '888247901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888247901', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.557839', '2023-01-11 13:06:29.557839');
INSERT INTO public.virksomhet VALUES (383, '883590490', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883590490', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.563543', '2023-01-11 13:06:29.563543');
INSERT INTO public.virksomhet VALUES (384, '804908767', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804908767', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.567957', '2023-01-11 13:06:29.567957');
INSERT INTO public.virksomhet VALUES (385, '851919134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851919134', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.573213', '2023-01-11 13:06:29.573213');
INSERT INTO public.virksomhet VALUES (386, '813682750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813682750', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.577661', '2023-01-11 13:06:29.577661');
INSERT INTO public.virksomhet VALUES (387, '875544956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875544956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.582602', '2023-01-11 13:06:29.582602');
INSERT INTO public.virksomhet VALUES (388, '889472231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889472231', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.588112', '2023-01-11 13:06:29.588112');
INSERT INTO public.virksomhet VALUES (389, '875631634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875631634', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.592791', '2023-01-11 13:06:29.592791');
INSERT INTO public.virksomhet VALUES (390, '856007783', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856007783', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.597814', '2023-01-11 13:06:29.597814');
INSERT INTO public.virksomhet VALUES (391, '844760467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844760467', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.602232', '2023-01-11 13:06:29.602232');
INSERT INTO public.virksomhet VALUES (392, '863256691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863256691', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.606923', '2023-01-11 13:06:29.606923');
INSERT INTO public.virksomhet VALUES (393, '851705582', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851705582', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.611165', '2023-01-11 13:06:29.611165');
INSERT INTO public.virksomhet VALUES (394, '854298834', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854298834', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.61618', '2023-01-11 13:06:29.61618');
INSERT INTO public.virksomhet VALUES (395, '836216435', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836216435', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.621074', '2023-01-11 13:06:29.621074');
INSERT INTO public.virksomhet VALUES (396, '893017297', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893017297', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.625615', '2023-01-11 13:06:29.625615');
INSERT INTO public.virksomhet VALUES (397, '841372032', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841372032', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.630407', '2023-01-11 13:06:29.630407');
INSERT INTO public.virksomhet VALUES (398, '862589424', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862589424', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.635355', '2023-01-11 13:06:29.635355');
INSERT INTO public.virksomhet VALUES (399, '871501781', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871501781', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.640394', '2023-01-11 13:06:29.640394');
INSERT INTO public.virksomhet VALUES (400, '880977356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880977356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.644947', '2023-01-11 13:06:29.644947');
INSERT INTO public.virksomhet VALUES (401, '859708655', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859708655', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.649773', '2023-01-11 13:06:29.649773');
INSERT INTO public.virksomhet VALUES (402, '837130075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837130075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.654663', '2023-01-11 13:06:29.654663');
INSERT INTO public.virksomhet VALUES (403, '803170681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803170681', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.659086', '2023-01-11 13:06:29.659086');
INSERT INTO public.virksomhet VALUES (404, '875018446', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875018446', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.663814', '2023-01-11 13:06:29.663814');
INSERT INTO public.virksomhet VALUES (405, '872251225', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872251225', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.668445', '2023-01-11 13:06:29.668445');
INSERT INTO public.virksomhet VALUES (406, '889927472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889927472', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.673555', '2023-01-11 13:06:29.673555');
INSERT INTO public.virksomhet VALUES (407, '850310272', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850310272', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.678043', '2023-01-11 13:06:29.678043');
INSERT INTO public.virksomhet VALUES (408, '878277970', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878277970', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.682358', '2023-01-11 13:06:29.682358');
INSERT INTO public.virksomhet VALUES (409, '811324382', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811324382', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.686988', '2023-01-11 13:06:29.686988');
INSERT INTO public.virksomhet VALUES (410, '878265174', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878265174', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.691255', '2023-01-11 13:06:29.691255');
INSERT INTO public.virksomhet VALUES (411, '803799726', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803799726', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.695644', '2023-01-11 13:06:29.695644');
INSERT INTO public.virksomhet VALUES (412, '827344157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827344157', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.70005', '2023-01-11 13:06:29.70005');
INSERT INTO public.virksomhet VALUES (413, '868610918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868610918', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.704806', '2023-01-11 13:06:29.704806');
INSERT INTO public.virksomhet VALUES (414, '891144647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891144647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.708993', '2023-01-11 13:06:29.708993');
INSERT INTO public.virksomhet VALUES (415, '874750888', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874750888', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.71425', '2023-01-11 13:06:29.71425');
INSERT INTO public.virksomhet VALUES (416, '879572863', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879572863', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.719328', '2023-01-11 13:06:29.719328');
INSERT INTO public.virksomhet VALUES (417, '816719384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816719384', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.724796', '2023-01-11 13:06:29.724796');
INSERT INTO public.virksomhet VALUES (418, '823372812', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823372812', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.729362', '2023-01-11 13:06:29.729362');
INSERT INTO public.virksomhet VALUES (419, '872671153', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872671153', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.734565', '2023-01-11 13:06:29.734565');
INSERT INTO public.virksomhet VALUES (420, '837782686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837782686', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.73927', '2023-01-11 13:06:29.73927');
INSERT INTO public.virksomhet VALUES (421, '856373244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856373244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.743611', '2023-01-11 13:06:29.743611');
INSERT INTO public.virksomhet VALUES (422, '802319687', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802319687', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.74851', '2023-01-11 13:06:29.74851');
INSERT INTO public.virksomhet VALUES (423, '882221112', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882221112', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.753518', '2023-01-11 13:06:29.753518');
INSERT INTO public.virksomhet VALUES (424, '825823538', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825823538', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.758244', '2023-01-11 13:06:29.758244');
INSERT INTO public.virksomhet VALUES (425, '840744367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840744367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.763004', '2023-01-11 13:06:29.763004');
INSERT INTO public.virksomhet VALUES (426, '807485242', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807485242', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.768715', '2023-01-11 13:06:29.768715');
INSERT INTO public.virksomhet VALUES (427, '878321914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878321914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.773512', '2023-01-11 13:06:29.773512');
INSERT INTO public.virksomhet VALUES (428, '886892017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886892017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.778022', '2023-01-11 13:06:29.778022');
INSERT INTO public.virksomhet VALUES (429, '871623349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871623349', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.782663', '2023-01-11 13:06:29.782663');
INSERT INTO public.virksomhet VALUES (430, '864986459', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864986459', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.787913', '2023-01-11 13:06:29.787913');
INSERT INTO public.virksomhet VALUES (431, '849227492', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849227492', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.792524', '2023-01-11 13:06:29.792524');
INSERT INTO public.virksomhet VALUES (432, '850910144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850910144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.796845', '2023-01-11 13:06:29.796845');
INSERT INTO public.virksomhet VALUES (433, '869658223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869658223', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.801458', '2023-01-11 13:06:29.801458');
INSERT INTO public.virksomhet VALUES (434, '866431270', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866431270', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.80631', '2023-01-11 13:06:29.80631');
INSERT INTO public.virksomhet VALUES (435, '858356342', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858356342', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.810993', '2023-01-11 13:06:29.810993');
INSERT INTO public.virksomhet VALUES (436, '852467356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852467356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.815588', '2023-01-11 13:06:29.815588');
INSERT INTO public.virksomhet VALUES (437, '898657961', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898657961', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.820143', '2023-01-11 13:06:29.820143');
INSERT INTO public.virksomhet VALUES (438, '846849579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846849579', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.824525', '2023-01-11 13:06:29.824525');
INSERT INTO public.virksomhet VALUES (439, '873579899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873579899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.828934', '2023-01-11 13:06:29.828934');
INSERT INTO public.virksomhet VALUES (440, '843035298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843035298', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.833547', '2023-01-11 13:06:29.833547');
INSERT INTO public.virksomhet VALUES (441, '858836952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858836952', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.838004', '2023-01-11 13:06:29.838004');
INSERT INTO public.virksomhet VALUES (442, '805709917', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805709917', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.842783', '2023-01-11 13:06:29.842783');
INSERT INTO public.virksomhet VALUES (443, '808479485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808479485', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.84722', '2023-01-11 13:06:29.84722');
INSERT INTO public.virksomhet VALUES (444, '838878962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838878962', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.851841', '2023-01-11 13:06:29.851841');
INSERT INTO public.virksomhet VALUES (445, '885625328', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885625328', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.856517', '2023-01-11 13:06:29.856517');
INSERT INTO public.virksomhet VALUES (446, '837527996', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837527996', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.861611', '2023-01-11 13:06:29.861611');
INSERT INTO public.virksomhet VALUES (447, '844848494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844848494', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.866691', '2023-01-11 13:06:29.866691');
INSERT INTO public.virksomhet VALUES (448, '825573136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825573136', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.871871', '2023-01-11 13:06:29.871871');
INSERT INTO public.virksomhet VALUES (449, '809036318', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809036318', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.876576', '2023-01-11 13:06:29.876576');
INSERT INTO public.virksomhet VALUES (450, '800223332', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800223332', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.88114', '2023-01-11 13:06:29.88114');
INSERT INTO public.virksomhet VALUES (451, '878112453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878112453', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.885471', '2023-01-11 13:06:29.885471');
INSERT INTO public.virksomhet VALUES (452, '893781546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893781546', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.88961', '2023-01-11 13:06:29.88961');
INSERT INTO public.virksomhet VALUES (453, '818658010', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818658010', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.894038', '2023-01-11 13:06:29.894038');
INSERT INTO public.virksomhet VALUES (454, '862270603', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862270603', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.898632', '2023-01-11 13:06:29.898632');
INSERT INTO public.virksomhet VALUES (455, '812325897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812325897', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.903216', '2023-01-11 13:06:29.903216');
INSERT INTO public.virksomhet VALUES (456, '817554736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817554736', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.90762', '2023-01-11 13:06:29.90762');
INSERT INTO public.virksomhet VALUES (457, '884291457', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884291457', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.911998', '2023-01-11 13:06:29.911998');
INSERT INTO public.virksomhet VALUES (458, '890910485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890910485', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.915947', '2023-01-11 13:06:29.915947');
INSERT INTO public.virksomhet VALUES (459, '810677960', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810677960', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.920644', '2023-01-11 13:06:29.920644');
INSERT INTO public.virksomhet VALUES (460, '830621787', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830621787', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.925437', '2023-01-11 13:06:29.925437');
INSERT INTO public.virksomhet VALUES (461, '874792210', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874792210', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.930061', '2023-01-11 13:06:29.930061');
INSERT INTO public.virksomhet VALUES (462, '828718942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828718942', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.935036', '2023-01-11 13:06:29.935036');
INSERT INTO public.virksomhet VALUES (463, '846277869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846277869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.939729', '2023-01-11 13:06:29.939729');
INSERT INTO public.virksomhet VALUES (464, '809316543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809316543', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.944344', '2023-01-11 13:06:29.944344');
INSERT INTO public.virksomhet VALUES (465, '846821438', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846821438', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.948978', '2023-01-11 13:06:29.948978');
INSERT INTO public.virksomhet VALUES (466, '836005340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836005340', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.953754', '2023-01-11 13:06:29.953754');
INSERT INTO public.virksomhet VALUES (467, '869069081', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869069081', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.958385', '2023-01-11 13:06:29.958385');
INSERT INTO public.virksomhet VALUES (468, '824870495', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824870495', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.962974', '2023-01-11 13:06:29.962974');
INSERT INTO public.virksomhet VALUES (469, '821850314', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821850314', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.967059', '2023-01-11 13:06:29.967059');
INSERT INTO public.virksomhet VALUES (470, '895629317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895629317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.971435', '2023-01-11 13:06:29.971435');
INSERT INTO public.virksomhet VALUES (471, '854843256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854843256', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.976953', '2023-01-11 13:06:29.976953');
INSERT INTO public.virksomhet VALUES (472, '825397589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825397589', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.982023', '2023-01-11 13:06:29.982023');
INSERT INTO public.virksomhet VALUES (473, '856901774', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856901774', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.987123', '2023-01-11 13:06:29.987123');
INSERT INTO public.virksomhet VALUES (474, '886566656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886566656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.992138', '2023-01-11 13:06:29.992138');
INSERT INTO public.virksomhet VALUES (475, '868634250', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868634250', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:29.996822', '2023-01-11 13:06:29.996822');
INSERT INTO public.virksomhet VALUES (476, '827178297', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827178297', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.002023', '2023-01-11 13:06:30.002023');
INSERT INTO public.virksomhet VALUES (477, '889901026', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889901026', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.007939', '2023-01-11 13:06:30.007939');
INSERT INTO public.virksomhet VALUES (478, '860932226', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860932226', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.014721', '2023-01-11 13:06:30.014721');
INSERT INTO public.virksomhet VALUES (479, '883640440', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883640440', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.021063', '2023-01-11 13:06:30.021063');
INSERT INTO public.virksomhet VALUES (480, '899511765', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899511765', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.026698', '2023-01-11 13:06:30.026698');
INSERT INTO public.virksomhet VALUES (481, '826671551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826671551', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.031789', '2023-01-11 13:06:30.031789');
INSERT INTO public.virksomhet VALUES (482, '838991015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838991015', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.036305', '2023-01-11 13:06:30.036305');
INSERT INTO public.virksomhet VALUES (483, '831768843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831768843', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.040827', '2023-01-11 13:06:30.040827');
INSERT INTO public.virksomhet VALUES (484, '803324193', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803324193', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.046088', '2023-01-11 13:06:30.046088');
INSERT INTO public.virksomhet VALUES (485, '827269180', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827269180', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.050509', '2023-01-11 13:06:30.050509');
INSERT INTO public.virksomhet VALUES (486, '806938796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806938796', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.056441', '2023-01-11 13:06:30.056441');
INSERT INTO public.virksomhet VALUES (487, '817130185', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817130185', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.060916', '2023-01-11 13:06:30.060916');
INSERT INTO public.virksomhet VALUES (488, '810402680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810402680', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.067955', '2023-01-11 13:06:30.067955');
INSERT INTO public.virksomhet VALUES (489, '887841956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887841956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.072581', '2023-01-11 13:06:30.072581');
INSERT INTO public.virksomhet VALUES (490, '897336611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897336611', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.077512', '2023-01-11 13:06:30.077512');
INSERT INTO public.virksomhet VALUES (491, '858728795', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858728795', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.081921', '2023-01-11 13:06:30.081921');
INSERT INTO public.virksomhet VALUES (492, '880050743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880050743', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.08653', '2023-01-11 13:06:30.08653');
INSERT INTO public.virksomhet VALUES (493, '871161662', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871161662', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.090911', '2023-01-11 13:06:30.090911');
INSERT INTO public.virksomhet VALUES (494, '862924848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862924848', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.095211', '2023-01-11 13:06:30.095211');
INSERT INTO public.virksomhet VALUES (495, '895031114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895031114', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.099481', '2023-01-11 13:06:30.099481');
INSERT INTO public.virksomhet VALUES (496, '815517829', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815517829', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.103771', '2023-01-11 13:06:30.103771');
INSERT INTO public.virksomhet VALUES (497, '836666246', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836666246', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.107965', '2023-01-11 13:06:30.107965');
INSERT INTO public.virksomhet VALUES (498, '845715533', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845715533', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.112041', '2023-01-11 13:06:30.112041');
INSERT INTO public.virksomhet VALUES (499, '897156462', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897156462', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.116818', '2023-01-11 13:06:30.116818');
INSERT INTO public.virksomhet VALUES (500, '890815244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890815244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.121602', '2023-01-11 13:06:30.121602');
INSERT INTO public.virksomhet VALUES (501, '866562589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866562589', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.126809', '2023-01-11 13:06:30.126809');
INSERT INTO public.virksomhet VALUES (502, '875322390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875322390', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.131587', '2023-01-11 13:06:30.131587');
INSERT INTO public.virksomhet VALUES (503, '870376312', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870376312', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.136316', '2023-01-11 13:06:30.136316');
INSERT INTO public.virksomhet VALUES (504, '863074238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863074238', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.141043', '2023-01-11 13:06:30.141043');
INSERT INTO public.virksomhet VALUES (505, '873535604', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873535604', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.145926', '2023-01-11 13:06:30.145926');
INSERT INTO public.virksomhet VALUES (506, '820029647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820029647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.150569', '2023-01-11 13:06:30.150569');
INSERT INTO public.virksomhet VALUES (507, '825514130', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825514130', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.154967', '2023-01-11 13:06:30.154967');
INSERT INTO public.virksomhet VALUES (508, '815801592', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815801592', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.159133', '2023-01-11 13:06:30.159133');
INSERT INTO public.virksomhet VALUES (509, '839528084', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839528084', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.163474', '2023-01-11 13:06:30.163474');
INSERT INTO public.virksomhet VALUES (510, '864571830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864571830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:30.168322', '2023-01-11 13:06:30.168322');
INSERT INTO public.virksomhet VALUES (511, '883989256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883989256', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-01-11 13:06:36.342906', '2023-01-11 13:06:36.342906');
INSERT INTO public.virksomhet VALUES (512, '831272011', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '110272138 nvaN', '{adresse}', 'AKTIV', NULL, 831272012, '2023-01-11 13:06:36.348522', '2023-01-11 13:06:41.99343');
INSERT INTO public.virksomhet VALUES (513, '831658088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '880856138 nvaN', '{adresse}', 'AKTIV', NULL, 831658089, '2023-01-11 13:06:36.354966', '2023-01-11 13:06:41.999622');
INSERT INTO public.virksomhet VALUES (514, '802008121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '121800208 nvaN', '{adresse}', 'AKTIV', NULL, 802008122, '2023-01-11 13:06:36.360008', '2023-01-11 13:06:42.006607');
INSERT INTO public.virksomhet VALUES (515, '857721878', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '878127758 nvaN', '{adresse}', 'AKTIV', NULL, 857721879, '2023-01-11 13:06:36.365282', '2023-01-11 13:06:42.018898');
INSERT INTO public.virksomhet VALUES (516, '811747377', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '773747118 nvaN', '{adresse}', 'AKTIV', NULL, 811747378, '2023-01-11 13:06:36.371877', '2023-01-11 13:06:42.022818');
INSERT INTO public.virksomhet VALUES (527, '854032309', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '903230458 nvaN', '{adresse}', 'AKTIV', NULL, 854032310, '2023-01-11 13:06:36.489682', '2023-01-11 13:06:42.028814');
INSERT INTO public.virksomhet VALUES (517, '801396893', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801396893', '{adresse}', 'FJERNET', '2010-07-01', 801396894, '2023-01-11 13:06:36.406795', '2023-01-11 13:06:42.031594');
INSERT INTO public.virksomhet VALUES (518, '885133950', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885133950', '{adresse}', 'FJERNET', '2010-07-01', 885133951, '2023-01-11 13:06:36.416233', '2023-01-11 13:06:42.034407');
INSERT INTO public.virksomhet VALUES (519, '864761302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864761302', '{adresse}', 'FJERNET', '2010-07-01', 864761303, '2023-01-11 13:06:36.427505', '2023-01-11 13:06:42.036227');
INSERT INTO public.virksomhet VALUES (520, '870050263', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870050263', '{adresse}', 'FJERNET', '2010-07-01', 870050264, '2023-01-11 13:06:36.435487', '2023-01-11 13:06:42.03843');
INSERT INTO public.virksomhet VALUES (521, '881536611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881536611', '{adresse}', 'FJERNET', '2010-07-01', 881536612, '2023-01-11 13:06:36.443534', '2023-01-11 13:06:42.039516');
INSERT INTO public.virksomhet VALUES (522, '862811969', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862811969', '{adresse}', 'SLETTET', '2010-07-01', 862811970, '2023-01-11 13:06:36.452003', '2023-01-11 13:06:42.040942');
INSERT INTO public.virksomhet VALUES (523, '892708443', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892708443', '{adresse}', 'SLETTET', '2010-07-01', 892708444, '2023-01-11 13:06:36.459619', '2023-01-11 13:06:42.04151');
INSERT INTO public.virksomhet VALUES (524, '866931781', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866931781', '{adresse}', 'SLETTET', '2010-07-01', 866931782, '2023-01-11 13:06:36.467074', '2023-01-11 13:06:42.042228');
INSERT INTO public.virksomhet VALUES (525, '868378133', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868378133', '{adresse}', 'SLETTET', '2010-07-01', 868378134, '2023-01-11 13:06:36.474171', '2023-01-11 13:06:42.043561');
INSERT INTO public.virksomhet VALUES (526, '872308278', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872308278', '{adresse}', 'SLETTET', '2010-07-01', 872308279, '2023-01-11 13:06:36.482208', '2023-01-11 13:06:42.044483');
INSERT INTO public.virksomhet VALUES (534, '854620752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854620752', '{adresse}', 'AKTIV', NULL, 854620753, '2023-01-11 13:06:42.060746', '2023-01-11 13:06:42.060746');
INSERT INTO public.virksomhet VALUES (535, '813662974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813662974', '{adresse}', 'AKTIV', NULL, 813662975, '2023-01-11 13:06:42.068623', '2023-01-11 13:06:42.068623');
INSERT INTO public.virksomhet VALUES (536, '877870510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877870510', '{adresse}', 'AKTIV', NULL, 877870511, '2023-01-11 13:06:42.074019', '2023-01-11 13:06:42.074019');
INSERT INTO public.virksomhet VALUES (537, '828539481', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828539481', '{adresse}', 'AKTIV', NULL, 828539482, '2023-01-11 13:06:42.086567', '2023-01-11 13:06:42.086567');
INSERT INTO public.virksomhet VALUES (538, '833469738', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833469738', '{adresse}', 'AKTIV', NULL, 833469739, '2023-01-11 13:06:42.0921', '2023-01-11 13:06:42.0921');


--
-- Data for Name: virksomhet_naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_naring VALUES (1, '90.012');
INSERT INTO public.virksomhet_naring VALUES (2, '70.220');
INSERT INTO public.virksomhet_naring VALUES (2, '90.012');
INSERT INTO public.virksomhet_naring VALUES (3, '90.012');
INSERT INTO public.virksomhet_naring VALUES (3, '70.220');
INSERT INTO public.virksomhet_naring VALUES (4, '90.012');
INSERT INTO public.virksomhet_naring VALUES (5, '01.120');
INSERT INTO public.virksomhet_naring VALUES (6, '01.120');
INSERT INTO public.virksomhet_naring VALUES (7, '01.120');
INSERT INTO public.virksomhet_naring VALUES (8, '01.120');
INSERT INTO public.virksomhet_naring VALUES (8, '90.012');
INSERT INTO public.virksomhet_naring VALUES (9, '01.120');
INSERT INTO public.virksomhet_naring VALUES (10, '01.120');
INSERT INTO public.virksomhet_naring VALUES (11, '01.120');
INSERT INTO public.virksomhet_naring VALUES (11, '90.012');
INSERT INTO public.virksomhet_naring VALUES (12, '01.120');
INSERT INTO public.virksomhet_naring VALUES (12, '90.012');
INSERT INTO public.virksomhet_naring VALUES (12, '70.220');
INSERT INTO public.virksomhet_naring VALUES (13, '01.120');
INSERT INTO public.virksomhet_naring VALUES (14, '01.120');
INSERT INTO public.virksomhet_naring VALUES (14, '90.012');
INSERT INTO public.virksomhet_naring VALUES (15, '01.120');
INSERT INTO public.virksomhet_naring VALUES (15, '90.012');
INSERT INTO public.virksomhet_naring VALUES (16, '01.120');
INSERT INTO public.virksomhet_naring VALUES (16, '90.012');
INSERT INTO public.virksomhet_naring VALUES (16, '70.220');
INSERT INTO public.virksomhet_naring VALUES (17, '01.120');
INSERT INTO public.virksomhet_naring VALUES (17, '90.012');
INSERT INTO public.virksomhet_naring VALUES (17, '70.220');
INSERT INTO public.virksomhet_naring VALUES (18, '01.120');
INSERT INTO public.virksomhet_naring VALUES (18, '90.012');
INSERT INTO public.virksomhet_naring VALUES (19, '01.120');
INSERT INTO public.virksomhet_naring VALUES (20, '01.120');
INSERT INTO public.virksomhet_naring VALUES (21, '01.120');
INSERT INTO public.virksomhet_naring VALUES (21, '90.012');
INSERT INTO public.virksomhet_naring VALUES (22, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '90.012');
INSERT INTO public.virksomhet_naring VALUES (24, '01.120');
INSERT INTO public.virksomhet_naring VALUES (25, '01.120');
INSERT INTO public.virksomhet_naring VALUES (25, '90.012');
INSERT INTO public.virksomhet_naring VALUES (26, '01.120');
INSERT INTO public.virksomhet_naring VALUES (27, '01.120');
INSERT INTO public.virksomhet_naring VALUES (27, '90.012');
INSERT INTO public.virksomhet_naring VALUES (28, '01.120');
INSERT INTO public.virksomhet_naring VALUES (29, '01.120');
INSERT INTO public.virksomhet_naring VALUES (30, '01.120');
INSERT INTO public.virksomhet_naring VALUES (30, '90.012');
INSERT INTO public.virksomhet_naring VALUES (31, '01.120');
INSERT INTO public.virksomhet_naring VALUES (32, '01.120');
INSERT INTO public.virksomhet_naring VALUES (33, '01.120');
INSERT INTO public.virksomhet_naring VALUES (33, '90.012');
INSERT INTO public.virksomhet_naring VALUES (33, '70.220');
INSERT INTO public.virksomhet_naring VALUES (34, '01.120');
INSERT INTO public.virksomhet_naring VALUES (34, '90.012');
INSERT INTO public.virksomhet_naring VALUES (35, '01.120');
INSERT INTO public.virksomhet_naring VALUES (35, '90.012');
INSERT INTO public.virksomhet_naring VALUES (35, '70.220');
INSERT INTO public.virksomhet_naring VALUES (36, '01.120');
INSERT INTO public.virksomhet_naring VALUES (36, '90.012');
INSERT INTO public.virksomhet_naring VALUES (36, '70.220');
INSERT INTO public.virksomhet_naring VALUES (37, '01.120');
INSERT INTO public.virksomhet_naring VALUES (38, '01.120');
INSERT INTO public.virksomhet_naring VALUES (38, '90.012');
INSERT INTO public.virksomhet_naring VALUES (38, '70.220');
INSERT INTO public.virksomhet_naring VALUES (39, '01.120');
INSERT INTO public.virksomhet_naring VALUES (39, '90.012');
INSERT INTO public.virksomhet_naring VALUES (40, '01.120');
INSERT INTO public.virksomhet_naring VALUES (41, '01.120');
INSERT INTO public.virksomhet_naring VALUES (41, '90.012');
INSERT INTO public.virksomhet_naring VALUES (41, '70.220');
INSERT INTO public.virksomhet_naring VALUES (42, '01.120');
INSERT INTO public.virksomhet_naring VALUES (42, '90.012');
INSERT INTO public.virksomhet_naring VALUES (43, '01.120');
INSERT INTO public.virksomhet_naring VALUES (44, '01.120');
INSERT INTO public.virksomhet_naring VALUES (45, '01.120');
INSERT INTO public.virksomhet_naring VALUES (45, '90.012');
INSERT INTO public.virksomhet_naring VALUES (45, '70.220');
INSERT INTO public.virksomhet_naring VALUES (46, '01.120');
INSERT INTO public.virksomhet_naring VALUES (47, '01.120');
INSERT INTO public.virksomhet_naring VALUES (47, '90.012');
INSERT INTO public.virksomhet_naring VALUES (48, '01.120');
INSERT INTO public.virksomhet_naring VALUES (49, '01.120');
INSERT INTO public.virksomhet_naring VALUES (50, '01.120');
INSERT INTO public.virksomhet_naring VALUES (51, '01.120');
INSERT INTO public.virksomhet_naring VALUES (51, '90.012');
INSERT INTO public.virksomhet_naring VALUES (51, '70.220');
INSERT INTO public.virksomhet_naring VALUES (52, '01.120');
INSERT INTO public.virksomhet_naring VALUES (52, '90.012');
INSERT INTO public.virksomhet_naring VALUES (52, '70.220');
INSERT INTO public.virksomhet_naring VALUES (53, '01.120');
INSERT INTO public.virksomhet_naring VALUES (53, '90.012');
INSERT INTO public.virksomhet_naring VALUES (53, '70.220');
INSERT INTO public.virksomhet_naring VALUES (54, '01.120');
INSERT INTO public.virksomhet_naring VALUES (54, '90.012');
INSERT INTO public.virksomhet_naring VALUES (55, '01.120');
INSERT INTO public.virksomhet_naring VALUES (56, '01.120');
INSERT INTO public.virksomhet_naring VALUES (57, '01.120');
INSERT INTO public.virksomhet_naring VALUES (57, '90.012');
INSERT INTO public.virksomhet_naring VALUES (57, '70.220');
INSERT INTO public.virksomhet_naring VALUES (58, '01.120');
INSERT INTO public.virksomhet_naring VALUES (58, '90.012');
INSERT INTO public.virksomhet_naring VALUES (59, '01.120');
INSERT INTO public.virksomhet_naring VALUES (59, '90.012');
INSERT INTO public.virksomhet_naring VALUES (60, '01.120');
INSERT INTO public.virksomhet_naring VALUES (61, '01.120');
INSERT INTO public.virksomhet_naring VALUES (61, '90.012');
INSERT INTO public.virksomhet_naring VALUES (62, '01.120');
INSERT INTO public.virksomhet_naring VALUES (62, '90.012');
INSERT INTO public.virksomhet_naring VALUES (63, '01.120');
INSERT INTO public.virksomhet_naring VALUES (64, '01.120');
INSERT INTO public.virksomhet_naring VALUES (65, '01.120');
INSERT INTO public.virksomhet_naring VALUES (65, '90.012');
INSERT INTO public.virksomhet_naring VALUES (66, '01.120');
INSERT INTO public.virksomhet_naring VALUES (67, '01.120');
INSERT INTO public.virksomhet_naring VALUES (68, '01.120');
INSERT INTO public.virksomhet_naring VALUES (68, '90.012');
INSERT INTO public.virksomhet_naring VALUES (69, '01.120');
INSERT INTO public.virksomhet_naring VALUES (70, '01.120');
INSERT INTO public.virksomhet_naring VALUES (70, '90.012');
INSERT INTO public.virksomhet_naring VALUES (70, '70.220');
INSERT INTO public.virksomhet_naring VALUES (71, '01.120');
INSERT INTO public.virksomhet_naring VALUES (72, '01.120');
INSERT INTO public.virksomhet_naring VALUES (73, '01.120');
INSERT INTO public.virksomhet_naring VALUES (73, '90.012');
INSERT INTO public.virksomhet_naring VALUES (74, '01.120');
INSERT INTO public.virksomhet_naring VALUES (75, '01.120');
INSERT INTO public.virksomhet_naring VALUES (76, '01.120');
INSERT INTO public.virksomhet_naring VALUES (76, '90.012');
INSERT INTO public.virksomhet_naring VALUES (77, '01.120');
INSERT INTO public.virksomhet_naring VALUES (78, '01.120');
INSERT INTO public.virksomhet_naring VALUES (79, '01.120');
INSERT INTO public.virksomhet_naring VALUES (80, '01.120');
INSERT INTO public.virksomhet_naring VALUES (81, '01.120');
INSERT INTO public.virksomhet_naring VALUES (81, '90.012');
INSERT INTO public.virksomhet_naring VALUES (81, '70.220');
INSERT INTO public.virksomhet_naring VALUES (82, '01.120');
INSERT INTO public.virksomhet_naring VALUES (82, '90.012');
INSERT INTO public.virksomhet_naring VALUES (83, '01.120');
INSERT INTO public.virksomhet_naring VALUES (84, '01.120');
INSERT INTO public.virksomhet_naring VALUES (85, '01.120');
INSERT INTO public.virksomhet_naring VALUES (85, '90.012');
INSERT INTO public.virksomhet_naring VALUES (86, '01.120');
INSERT INTO public.virksomhet_naring VALUES (87, '01.120');
INSERT INTO public.virksomhet_naring VALUES (87, '90.012');
INSERT INTO public.virksomhet_naring VALUES (88, '01.120');
INSERT INTO public.virksomhet_naring VALUES (88, '90.012');
INSERT INTO public.virksomhet_naring VALUES (88, '70.220');
INSERT INTO public.virksomhet_naring VALUES (89, '01.120');
INSERT INTO public.virksomhet_naring VALUES (89, '90.012');
INSERT INTO public.virksomhet_naring VALUES (89, '70.220');
INSERT INTO public.virksomhet_naring VALUES (90, '01.120');
INSERT INTO public.virksomhet_naring VALUES (90, '90.012');
INSERT INTO public.virksomhet_naring VALUES (91, '01.120');
INSERT INTO public.virksomhet_naring VALUES (92, '01.120');
INSERT INTO public.virksomhet_naring VALUES (92, '90.012');
INSERT INTO public.virksomhet_naring VALUES (92, '70.220');
INSERT INTO public.virksomhet_naring VALUES (93, '01.120');
INSERT INTO public.virksomhet_naring VALUES (94, '01.120');
INSERT INTO public.virksomhet_naring VALUES (95, '01.120');
INSERT INTO public.virksomhet_naring VALUES (96, '01.120');
INSERT INTO public.virksomhet_naring VALUES (97, '01.120');
INSERT INTO public.virksomhet_naring VALUES (97, '90.012');
INSERT INTO public.virksomhet_naring VALUES (97, '70.220');
INSERT INTO public.virksomhet_naring VALUES (98, '01.120');
INSERT INTO public.virksomhet_naring VALUES (99, '01.120');
INSERT INTO public.virksomhet_naring VALUES (100, '01.120');
INSERT INTO public.virksomhet_naring VALUES (101, '01.120');
INSERT INTO public.virksomhet_naring VALUES (101, '90.012');
INSERT INTO public.virksomhet_naring VALUES (102, '01.120');
INSERT INTO public.virksomhet_naring VALUES (103, '01.120');
INSERT INTO public.virksomhet_naring VALUES (104, '01.120');
INSERT INTO public.virksomhet_naring VALUES (105, '01.120');
INSERT INTO public.virksomhet_naring VALUES (105, '90.012');
INSERT INTO public.virksomhet_naring VALUES (106, '01.120');
INSERT INTO public.virksomhet_naring VALUES (106, '90.012');
INSERT INTO public.virksomhet_naring VALUES (106, '70.220');
INSERT INTO public.virksomhet_naring VALUES (107, '01.120');
INSERT INTO public.virksomhet_naring VALUES (107, '90.012');
INSERT INTO public.virksomhet_naring VALUES (107, '70.220');
INSERT INTO public.virksomhet_naring VALUES (108, '01.120');
INSERT INTO public.virksomhet_naring VALUES (108, '90.012');
INSERT INTO public.virksomhet_naring VALUES (109, '01.120');
INSERT INTO public.virksomhet_naring VALUES (110, '01.120');
INSERT INTO public.virksomhet_naring VALUES (111, '01.120');
INSERT INTO public.virksomhet_naring VALUES (112, '01.120');
INSERT INTO public.virksomhet_naring VALUES (112, '90.012');
INSERT INTO public.virksomhet_naring VALUES (113, '01.120');
INSERT INTO public.virksomhet_naring VALUES (114, '01.120');
INSERT INTO public.virksomhet_naring VALUES (115, '01.120');
INSERT INTO public.virksomhet_naring VALUES (115, '90.012');
INSERT INTO public.virksomhet_naring VALUES (116, '01.120');
INSERT INTO public.virksomhet_naring VALUES (116, '90.012');
INSERT INTO public.virksomhet_naring VALUES (117, '01.120');
INSERT INTO public.virksomhet_naring VALUES (118, '01.120');
INSERT INTO public.virksomhet_naring VALUES (118, '90.012');
INSERT INTO public.virksomhet_naring VALUES (119, '01.120');
INSERT INTO public.virksomhet_naring VALUES (120, '01.120');
INSERT INTO public.virksomhet_naring VALUES (121, '01.120');
INSERT INTO public.virksomhet_naring VALUES (122, '01.120');
INSERT INTO public.virksomhet_naring VALUES (122, '90.012');
INSERT INTO public.virksomhet_naring VALUES (122, '70.220');
INSERT INTO public.virksomhet_naring VALUES (123, '01.120');
INSERT INTO public.virksomhet_naring VALUES (124, '01.120');
INSERT INTO public.virksomhet_naring VALUES (125, '01.120');
INSERT INTO public.virksomhet_naring VALUES (125, '90.012');
INSERT INTO public.virksomhet_naring VALUES (125, '70.220');
INSERT INTO public.virksomhet_naring VALUES (126, '01.120');
INSERT INTO public.virksomhet_naring VALUES (126, '90.012');
INSERT INTO public.virksomhet_naring VALUES (126, '70.220');
INSERT INTO public.virksomhet_naring VALUES (127, '01.120');
INSERT INTO public.virksomhet_naring VALUES (127, '90.012');
INSERT INTO public.virksomhet_naring VALUES (127, '70.220');
INSERT INTO public.virksomhet_naring VALUES (128, '01.120');
INSERT INTO public.virksomhet_naring VALUES (129, '01.120');
INSERT INTO public.virksomhet_naring VALUES (130, '01.120');
INSERT INTO public.virksomhet_naring VALUES (130, '90.012');
INSERT INTO public.virksomhet_naring VALUES (131, '01.120');
INSERT INTO public.virksomhet_naring VALUES (131, '90.012');
INSERT INTO public.virksomhet_naring VALUES (131, '70.220');
INSERT INTO public.virksomhet_naring VALUES (132, '01.120');
INSERT INTO public.virksomhet_naring VALUES (133, '01.120');
INSERT INTO public.virksomhet_naring VALUES (134, '01.120');
INSERT INTO public.virksomhet_naring VALUES (134, '90.012');
INSERT INTO public.virksomhet_naring VALUES (135, '01.120');
INSERT INTO public.virksomhet_naring VALUES (136, '01.120');
INSERT INTO public.virksomhet_naring VALUES (136, '90.012');
INSERT INTO public.virksomhet_naring VALUES (136, '70.220');
INSERT INTO public.virksomhet_naring VALUES (137, '01.120');
INSERT INTO public.virksomhet_naring VALUES (137, '90.012');
INSERT INTO public.virksomhet_naring VALUES (138, '01.120');
INSERT INTO public.virksomhet_naring VALUES (138, '90.012');
INSERT INTO public.virksomhet_naring VALUES (138, '70.220');
INSERT INTO public.virksomhet_naring VALUES (139, '01.120');
INSERT INTO public.virksomhet_naring VALUES (139, '90.012');
INSERT INTO public.virksomhet_naring VALUES (140, '01.120');
INSERT INTO public.virksomhet_naring VALUES (140, '90.012');
INSERT INTO public.virksomhet_naring VALUES (140, '70.220');
INSERT INTO public.virksomhet_naring VALUES (141, '01.120');
INSERT INTO public.virksomhet_naring VALUES (142, '01.120');
INSERT INTO public.virksomhet_naring VALUES (142, '90.012');
INSERT INTO public.virksomhet_naring VALUES (143, '01.120');
INSERT INTO public.virksomhet_naring VALUES (143, '90.012');
INSERT INTO public.virksomhet_naring VALUES (144, '01.120');
INSERT INTO public.virksomhet_naring VALUES (145, '01.120');
INSERT INTO public.virksomhet_naring VALUES (146, '01.120');
INSERT INTO public.virksomhet_naring VALUES (147, '01.120');
INSERT INTO public.virksomhet_naring VALUES (148, '01.120');
INSERT INTO public.virksomhet_naring VALUES (148, '90.012');
INSERT INTO public.virksomhet_naring VALUES (148, '70.220');
INSERT INTO public.virksomhet_naring VALUES (149, '01.120');
INSERT INTO public.virksomhet_naring VALUES (150, '01.120');
INSERT INTO public.virksomhet_naring VALUES (151, '01.120');
INSERT INTO public.virksomhet_naring VALUES (152, '01.120');
INSERT INTO public.virksomhet_naring VALUES (153, '01.120');
INSERT INTO public.virksomhet_naring VALUES (154, '01.120');
INSERT INTO public.virksomhet_naring VALUES (154, '90.012');
INSERT INTO public.virksomhet_naring VALUES (155, '01.120');
INSERT INTO public.virksomhet_naring VALUES (155, '90.012');
INSERT INTO public.virksomhet_naring VALUES (155, '70.220');
INSERT INTO public.virksomhet_naring VALUES (156, '01.120');
INSERT INTO public.virksomhet_naring VALUES (157, '01.120');
INSERT INTO public.virksomhet_naring VALUES (157, '90.012');
INSERT INTO public.virksomhet_naring VALUES (157, '70.220');
INSERT INTO public.virksomhet_naring VALUES (158, '01.120');
INSERT INTO public.virksomhet_naring VALUES (159, '01.120');
INSERT INTO public.virksomhet_naring VALUES (159, '90.012');
INSERT INTO public.virksomhet_naring VALUES (159, '70.220');
INSERT INTO public.virksomhet_naring VALUES (160, '01.120');
INSERT INTO public.virksomhet_naring VALUES (160, '90.012');
INSERT INTO public.virksomhet_naring VALUES (161, '01.120');
INSERT INTO public.virksomhet_naring VALUES (161, '90.012');
INSERT INTO public.virksomhet_naring VALUES (161, '70.220');
INSERT INTO public.virksomhet_naring VALUES (162, '01.120');
INSERT INTO public.virksomhet_naring VALUES (162, '90.012');
INSERT INTO public.virksomhet_naring VALUES (163, '01.120');
INSERT INTO public.virksomhet_naring VALUES (163, '90.012');
INSERT INTO public.virksomhet_naring VALUES (164, '01.120');
INSERT INTO public.virksomhet_naring VALUES (164, '90.012');
INSERT INTO public.virksomhet_naring VALUES (165, '01.120');
INSERT INTO public.virksomhet_naring VALUES (165, '90.012');
INSERT INTO public.virksomhet_naring VALUES (166, '01.120');
INSERT INTO public.virksomhet_naring VALUES (166, '90.012');
INSERT INTO public.virksomhet_naring VALUES (166, '70.220');
INSERT INTO public.virksomhet_naring VALUES (167, '01.120');
INSERT INTO public.virksomhet_naring VALUES (168, '01.120');
INSERT INTO public.virksomhet_naring VALUES (169, '01.120');
INSERT INTO public.virksomhet_naring VALUES (170, '01.120');
INSERT INTO public.virksomhet_naring VALUES (170, '90.012');
INSERT INTO public.virksomhet_naring VALUES (171, '01.120');
INSERT INTO public.virksomhet_naring VALUES (172, '01.120');
INSERT INTO public.virksomhet_naring VALUES (173, '01.120');
INSERT INTO public.virksomhet_naring VALUES (173, '90.012');
INSERT INTO public.virksomhet_naring VALUES (174, '01.120');
INSERT INTO public.virksomhet_naring VALUES (174, '90.012');
INSERT INTO public.virksomhet_naring VALUES (174, '70.220');
INSERT INTO public.virksomhet_naring VALUES (175, '01.120');
INSERT INTO public.virksomhet_naring VALUES (175, '90.012');
INSERT INTO public.virksomhet_naring VALUES (176, '01.120');
INSERT INTO public.virksomhet_naring VALUES (176, '90.012');
INSERT INTO public.virksomhet_naring VALUES (176, '70.220');
INSERT INTO public.virksomhet_naring VALUES (177, '01.120');
INSERT INTO public.virksomhet_naring VALUES (177, '90.012');
INSERT INTO public.virksomhet_naring VALUES (178, '01.120');
INSERT INTO public.virksomhet_naring VALUES (179, '01.120');
INSERT INTO public.virksomhet_naring VALUES (180, '01.120');
INSERT INTO public.virksomhet_naring VALUES (180, '90.012');
INSERT INTO public.virksomhet_naring VALUES (181, '01.120');
INSERT INTO public.virksomhet_naring VALUES (181, '90.012');
INSERT INTO public.virksomhet_naring VALUES (182, '01.120');
INSERT INTO public.virksomhet_naring VALUES (182, '90.012');
INSERT INTO public.virksomhet_naring VALUES (183, '01.120');
INSERT INTO public.virksomhet_naring VALUES (183, '90.012');
INSERT INTO public.virksomhet_naring VALUES (184, '01.120');
INSERT INTO public.virksomhet_naring VALUES (184, '90.012');
INSERT INTO public.virksomhet_naring VALUES (184, '70.220');
INSERT INTO public.virksomhet_naring VALUES (185, '01.120');
INSERT INTO public.virksomhet_naring VALUES (186, '01.120');
INSERT INTO public.virksomhet_naring VALUES (187, '01.120');
INSERT INTO public.virksomhet_naring VALUES (187, '90.012');
INSERT INTO public.virksomhet_naring VALUES (188, '01.120');
INSERT INTO public.virksomhet_naring VALUES (189, '01.120');
INSERT INTO public.virksomhet_naring VALUES (190, '01.120');
INSERT INTO public.virksomhet_naring VALUES (191, '01.120');
INSERT INTO public.virksomhet_naring VALUES (192, '01.120');
INSERT INTO public.virksomhet_naring VALUES (192, '90.012');
INSERT INTO public.virksomhet_naring VALUES (193, '01.120');
INSERT INTO public.virksomhet_naring VALUES (194, '01.120');
INSERT INTO public.virksomhet_naring VALUES (194, '90.012');
INSERT INTO public.virksomhet_naring VALUES (195, '01.120');
INSERT INTO public.virksomhet_naring VALUES (196, '01.120');
INSERT INTO public.virksomhet_naring VALUES (196, '90.012');
INSERT INTO public.virksomhet_naring VALUES (197, '01.120');
INSERT INTO public.virksomhet_naring VALUES (198, '01.120');
INSERT INTO public.virksomhet_naring VALUES (199, '01.120');
INSERT INTO public.virksomhet_naring VALUES (200, '01.120');
INSERT INTO public.virksomhet_naring VALUES (201, '01.120');
INSERT INTO public.virksomhet_naring VALUES (202, '01.120');
INSERT INTO public.virksomhet_naring VALUES (203, '01.120');
INSERT INTO public.virksomhet_naring VALUES (203, '90.012');
INSERT INTO public.virksomhet_naring VALUES (204, '01.120');
INSERT INTO public.virksomhet_naring VALUES (205, '01.120');
INSERT INTO public.virksomhet_naring VALUES (205, '90.012');
INSERT INTO public.virksomhet_naring VALUES (205, '70.220');
INSERT INTO public.virksomhet_naring VALUES (206, '01.120');
INSERT INTO public.virksomhet_naring VALUES (206, '90.012');
INSERT INTO public.virksomhet_naring VALUES (207, '01.120');
INSERT INTO public.virksomhet_naring VALUES (208, '01.120');
INSERT INTO public.virksomhet_naring VALUES (209, '01.120');
INSERT INTO public.virksomhet_naring VALUES (210, '01.120');
INSERT INTO public.virksomhet_naring VALUES (211, '01.120');
INSERT INTO public.virksomhet_naring VALUES (212, '01.120');
INSERT INTO public.virksomhet_naring VALUES (212, '90.012');
INSERT INTO public.virksomhet_naring VALUES (213, '01.120');
INSERT INTO public.virksomhet_naring VALUES (214, '01.120');
INSERT INTO public.virksomhet_naring VALUES (214, '90.012');
INSERT INTO public.virksomhet_naring VALUES (215, '01.120');
INSERT INTO public.virksomhet_naring VALUES (215, '90.012');
INSERT INTO public.virksomhet_naring VALUES (216, '01.120');
INSERT INTO public.virksomhet_naring VALUES (217, '01.120');
INSERT INTO public.virksomhet_naring VALUES (217, '90.012');
INSERT INTO public.virksomhet_naring VALUES (218, '01.120');
INSERT INTO public.virksomhet_naring VALUES (219, '01.120');
INSERT INTO public.virksomhet_naring VALUES (220, '01.120');
INSERT INTO public.virksomhet_naring VALUES (221, '01.120');
INSERT INTO public.virksomhet_naring VALUES (222, '01.120');
INSERT INTO public.virksomhet_naring VALUES (222, '90.012');
INSERT INTO public.virksomhet_naring VALUES (223, '01.120');
INSERT INTO public.virksomhet_naring VALUES (223, '90.012');
INSERT INTO public.virksomhet_naring VALUES (224, '01.120');
INSERT INTO public.virksomhet_naring VALUES (224, '90.012');
INSERT INTO public.virksomhet_naring VALUES (225, '01.120');
INSERT INTO public.virksomhet_naring VALUES (226, '01.120');
INSERT INTO public.virksomhet_naring VALUES (227, '01.120');
INSERT INTO public.virksomhet_naring VALUES (227, '90.012');
INSERT INTO public.virksomhet_naring VALUES (228, '01.120');
INSERT INTO public.virksomhet_naring VALUES (229, '01.120');
INSERT INTO public.virksomhet_naring VALUES (229, '90.012');
INSERT INTO public.virksomhet_naring VALUES (230, '01.120');
INSERT INTO public.virksomhet_naring VALUES (230, '90.012');
INSERT INTO public.virksomhet_naring VALUES (231, '01.120');
INSERT INTO public.virksomhet_naring VALUES (232, '01.120');
INSERT INTO public.virksomhet_naring VALUES (233, '01.120');
INSERT INTO public.virksomhet_naring VALUES (234, '01.120');
INSERT INTO public.virksomhet_naring VALUES (235, '01.120');
INSERT INTO public.virksomhet_naring VALUES (235, '90.012');
INSERT INTO public.virksomhet_naring VALUES (236, '01.120');
INSERT INTO public.virksomhet_naring VALUES (237, '01.120');
INSERT INTO public.virksomhet_naring VALUES (238, '01.120');
INSERT INTO public.virksomhet_naring VALUES (239, '01.120');
INSERT INTO public.virksomhet_naring VALUES (240, '01.120');
INSERT INTO public.virksomhet_naring VALUES (240, '90.012');
INSERT INTO public.virksomhet_naring VALUES (240, '70.220');
INSERT INTO public.virksomhet_naring VALUES (241, '01.120');
INSERT INTO public.virksomhet_naring VALUES (241, '90.012');
INSERT INTO public.virksomhet_naring VALUES (242, '01.120');
INSERT INTO public.virksomhet_naring VALUES (242, '90.012');
INSERT INTO public.virksomhet_naring VALUES (242, '70.220');
INSERT INTO public.virksomhet_naring VALUES (243, '01.120');
INSERT INTO public.virksomhet_naring VALUES (244, '01.120');
INSERT INTO public.virksomhet_naring VALUES (245, '01.120');
INSERT INTO public.virksomhet_naring VALUES (245, '90.012');
INSERT INTO public.virksomhet_naring VALUES (246, '01.120');
INSERT INTO public.virksomhet_naring VALUES (247, '01.120');
INSERT INTO public.virksomhet_naring VALUES (247, '90.012');
INSERT INTO public.virksomhet_naring VALUES (248, '01.120');
INSERT INTO public.virksomhet_naring VALUES (249, '01.120');
INSERT INTO public.virksomhet_naring VALUES (250, '01.120');
INSERT INTO public.virksomhet_naring VALUES (250, '90.012');
INSERT INTO public.virksomhet_naring VALUES (251, '01.120');
INSERT INTO public.virksomhet_naring VALUES (252, '01.120');
INSERT INTO public.virksomhet_naring VALUES (253, '01.120');
INSERT INTO public.virksomhet_naring VALUES (253, '90.012');
INSERT INTO public.virksomhet_naring VALUES (253, '70.220');
INSERT INTO public.virksomhet_naring VALUES (254, '01.120');
INSERT INTO public.virksomhet_naring VALUES (255, '01.120');
INSERT INTO public.virksomhet_naring VALUES (256, '01.120');
INSERT INTO public.virksomhet_naring VALUES (257, '01.120');
INSERT INTO public.virksomhet_naring VALUES (258, '01.120');
INSERT INTO public.virksomhet_naring VALUES (259, '01.120');
INSERT INTO public.virksomhet_naring VALUES (260, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '90.012');
INSERT INTO public.virksomhet_naring VALUES (262, '01.120');
INSERT INTO public.virksomhet_naring VALUES (262, '90.012');
INSERT INTO public.virksomhet_naring VALUES (263, '01.120');
INSERT INTO public.virksomhet_naring VALUES (263, '90.012');
INSERT INTO public.virksomhet_naring VALUES (263, '70.220');
INSERT INTO public.virksomhet_naring VALUES (264, '01.120');
INSERT INTO public.virksomhet_naring VALUES (264, '90.012');
INSERT INTO public.virksomhet_naring VALUES (265, '01.120');
INSERT INTO public.virksomhet_naring VALUES (265, '90.012');
INSERT INTO public.virksomhet_naring VALUES (266, '01.120');
INSERT INTO public.virksomhet_naring VALUES (267, '01.120');
INSERT INTO public.virksomhet_naring VALUES (267, '90.012');
INSERT INTO public.virksomhet_naring VALUES (268, '01.120');
INSERT INTO public.virksomhet_naring VALUES (268, '90.012');
INSERT INTO public.virksomhet_naring VALUES (268, '70.220');
INSERT INTO public.virksomhet_naring VALUES (269, '01.120');
INSERT INTO public.virksomhet_naring VALUES (270, '01.120');
INSERT INTO public.virksomhet_naring VALUES (270, '90.012');
INSERT INTO public.virksomhet_naring VALUES (271, '01.120');
INSERT INTO public.virksomhet_naring VALUES (272, '01.120');
INSERT INTO public.virksomhet_naring VALUES (273, '01.120');
INSERT INTO public.virksomhet_naring VALUES (273, '90.012');
INSERT INTO public.virksomhet_naring VALUES (274, '01.120');
INSERT INTO public.virksomhet_naring VALUES (274, '90.012');
INSERT INTO public.virksomhet_naring VALUES (275, '01.120');
INSERT INTO public.virksomhet_naring VALUES (275, '90.012');
INSERT INTO public.virksomhet_naring VALUES (275, '70.220');
INSERT INTO public.virksomhet_naring VALUES (276, '01.120');
INSERT INTO public.virksomhet_naring VALUES (277, '01.120');
INSERT INTO public.virksomhet_naring VALUES (277, '90.012');
INSERT INTO public.virksomhet_naring VALUES (277, '70.220');
INSERT INTO public.virksomhet_naring VALUES (278, '01.120');
INSERT INTO public.virksomhet_naring VALUES (278, '90.012');
INSERT INTO public.virksomhet_naring VALUES (279, '01.120');
INSERT INTO public.virksomhet_naring VALUES (279, '90.012');
INSERT INTO public.virksomhet_naring VALUES (279, '70.220');
INSERT INTO public.virksomhet_naring VALUES (280, '01.120');
INSERT INTO public.virksomhet_naring VALUES (281, '01.120');
INSERT INTO public.virksomhet_naring VALUES (281, '90.012');
INSERT INTO public.virksomhet_naring VALUES (282, '01.120');
INSERT INTO public.virksomhet_naring VALUES (283, '01.120');
INSERT INTO public.virksomhet_naring VALUES (284, '01.120');
INSERT INTO public.virksomhet_naring VALUES (285, '01.120');
INSERT INTO public.virksomhet_naring VALUES (286, '01.120');
INSERT INTO public.virksomhet_naring VALUES (287, '01.120');
INSERT INTO public.virksomhet_naring VALUES (288, '01.120');
INSERT INTO public.virksomhet_naring VALUES (288, '90.012');
INSERT INTO public.virksomhet_naring VALUES (289, '01.120');
INSERT INTO public.virksomhet_naring VALUES (289, '90.012');
INSERT INTO public.virksomhet_naring VALUES (289, '70.220');
INSERT INTO public.virksomhet_naring VALUES (290, '01.120');
INSERT INTO public.virksomhet_naring VALUES (291, '01.120');
INSERT INTO public.virksomhet_naring VALUES (292, '01.120');
INSERT INTO public.virksomhet_naring VALUES (293, '01.120');
INSERT INTO public.virksomhet_naring VALUES (293, '90.012');
INSERT INTO public.virksomhet_naring VALUES (294, '01.120');
INSERT INTO public.virksomhet_naring VALUES (295, '01.120');
INSERT INTO public.virksomhet_naring VALUES (295, '90.012');
INSERT INTO public.virksomhet_naring VALUES (295, '70.220');
INSERT INTO public.virksomhet_naring VALUES (296, '01.120');
INSERT INTO public.virksomhet_naring VALUES (297, '01.120');
INSERT INTO public.virksomhet_naring VALUES (297, '90.012');
INSERT INTO public.virksomhet_naring VALUES (297, '70.220');
INSERT INTO public.virksomhet_naring VALUES (298, '01.120');
INSERT INTO public.virksomhet_naring VALUES (298, '90.012');
INSERT INTO public.virksomhet_naring VALUES (298, '70.220');
INSERT INTO public.virksomhet_naring VALUES (299, '01.120');
INSERT INTO public.virksomhet_naring VALUES (299, '90.012');
INSERT INTO public.virksomhet_naring VALUES (299, '70.220');
INSERT INTO public.virksomhet_naring VALUES (300, '01.120');
INSERT INTO public.virksomhet_naring VALUES (301, '01.120');
INSERT INTO public.virksomhet_naring VALUES (301, '90.012');
INSERT INTO public.virksomhet_naring VALUES (302, '01.120');
INSERT INTO public.virksomhet_naring VALUES (302, '90.012');
INSERT INTO public.virksomhet_naring VALUES (303, '01.120');
INSERT INTO public.virksomhet_naring VALUES (303, '90.012');
INSERT INTO public.virksomhet_naring VALUES (303, '70.220');
INSERT INTO public.virksomhet_naring VALUES (304, '01.120');
INSERT INTO public.virksomhet_naring VALUES (304, '90.012');
INSERT INTO public.virksomhet_naring VALUES (304, '70.220');
INSERT INTO public.virksomhet_naring VALUES (305, '01.120');
INSERT INTO public.virksomhet_naring VALUES (306, '01.120');
INSERT INTO public.virksomhet_naring VALUES (306, '90.012');
INSERT INTO public.virksomhet_naring VALUES (307, '01.120');
INSERT INTO public.virksomhet_naring VALUES (307, '90.012');
INSERT INTO public.virksomhet_naring VALUES (308, '01.120');
INSERT INTO public.virksomhet_naring VALUES (308, '90.012');
INSERT INTO public.virksomhet_naring VALUES (309, '01.120');
INSERT INTO public.virksomhet_naring VALUES (310, '01.120');
INSERT INTO public.virksomhet_naring VALUES (311, '01.120');
INSERT INTO public.virksomhet_naring VALUES (312, '01.120');
INSERT INTO public.virksomhet_naring VALUES (313, '01.120');
INSERT INTO public.virksomhet_naring VALUES (314, '01.120');
INSERT INTO public.virksomhet_naring VALUES (315, '01.120');
INSERT INTO public.virksomhet_naring VALUES (315, '90.012');
INSERT INTO public.virksomhet_naring VALUES (316, '01.120');
INSERT INTO public.virksomhet_naring VALUES (316, '90.012');
INSERT INTO public.virksomhet_naring VALUES (317, '01.120');
INSERT INTO public.virksomhet_naring VALUES (317, '90.012');
INSERT INTO public.virksomhet_naring VALUES (317, '70.220');
INSERT INTO public.virksomhet_naring VALUES (318, '01.120');
INSERT INTO public.virksomhet_naring VALUES (318, '90.012');
INSERT INTO public.virksomhet_naring VALUES (318, '70.220');
INSERT INTO public.virksomhet_naring VALUES (319, '01.120');
INSERT INTO public.virksomhet_naring VALUES (320, '01.120');
INSERT INTO public.virksomhet_naring VALUES (320, '90.012');
INSERT INTO public.virksomhet_naring VALUES (320, '70.220');
INSERT INTO public.virksomhet_naring VALUES (321, '01.120');
INSERT INTO public.virksomhet_naring VALUES (321, '90.012');
INSERT INTO public.virksomhet_naring VALUES (321, '70.220');
INSERT INTO public.virksomhet_naring VALUES (322, '01.120');
INSERT INTO public.virksomhet_naring VALUES (323, '01.120');
INSERT INTO public.virksomhet_naring VALUES (323, '90.012');
INSERT INTO public.virksomhet_naring VALUES (323, '70.220');
INSERT INTO public.virksomhet_naring VALUES (324, '01.120');
INSERT INTO public.virksomhet_naring VALUES (325, '01.120');
INSERT INTO public.virksomhet_naring VALUES (326, '01.120');
INSERT INTO public.virksomhet_naring VALUES (326, '90.012');
INSERT INTO public.virksomhet_naring VALUES (326, '70.220');
INSERT INTO public.virksomhet_naring VALUES (327, '01.120');
INSERT INTO public.virksomhet_naring VALUES (328, '01.120');
INSERT INTO public.virksomhet_naring VALUES (328, '90.012');
INSERT INTO public.virksomhet_naring VALUES (329, '01.120');
INSERT INTO public.virksomhet_naring VALUES (330, '01.120');
INSERT INTO public.virksomhet_naring VALUES (331, '01.120');
INSERT INTO public.virksomhet_naring VALUES (332, '01.120');
INSERT INTO public.virksomhet_naring VALUES (332, '90.012');
INSERT INTO public.virksomhet_naring VALUES (333, '01.120');
INSERT INTO public.virksomhet_naring VALUES (333, '90.012');
INSERT INTO public.virksomhet_naring VALUES (334, '01.120');
INSERT INTO public.virksomhet_naring VALUES (335, '01.120');
INSERT INTO public.virksomhet_naring VALUES (335, '90.012');
INSERT INTO public.virksomhet_naring VALUES (335, '70.220');
INSERT INTO public.virksomhet_naring VALUES (336, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '01.120');
INSERT INTO public.virksomhet_naring VALUES (338, '01.120');
INSERT INTO public.virksomhet_naring VALUES (338, '90.012');
INSERT INTO public.virksomhet_naring VALUES (338, '70.220');
INSERT INTO public.virksomhet_naring VALUES (339, '01.120');
INSERT INTO public.virksomhet_naring VALUES (340, '01.120');
INSERT INTO public.virksomhet_naring VALUES (341, '01.120');
INSERT INTO public.virksomhet_naring VALUES (342, '01.120');
INSERT INTO public.virksomhet_naring VALUES (342, '90.012');
INSERT INTO public.virksomhet_naring VALUES (343, '01.120');
INSERT INTO public.virksomhet_naring VALUES (344, '01.120');
INSERT INTO public.virksomhet_naring VALUES (345, '01.120');
INSERT INTO public.virksomhet_naring VALUES (346, '01.120');
INSERT INTO public.virksomhet_naring VALUES (347, '01.120');
INSERT INTO public.virksomhet_naring VALUES (348, '01.120');
INSERT INTO public.virksomhet_naring VALUES (348, '90.012');
INSERT INTO public.virksomhet_naring VALUES (348, '70.220');
INSERT INTO public.virksomhet_naring VALUES (349, '01.120');
INSERT INTO public.virksomhet_naring VALUES (350, '01.120');
INSERT INTO public.virksomhet_naring VALUES (350, '90.012');
INSERT INTO public.virksomhet_naring VALUES (351, '01.120');
INSERT INTO public.virksomhet_naring VALUES (352, '01.120');
INSERT INTO public.virksomhet_naring VALUES (353, '01.120');
INSERT INTO public.virksomhet_naring VALUES (353, '90.012');
INSERT INTO public.virksomhet_naring VALUES (354, '01.120');
INSERT INTO public.virksomhet_naring VALUES (354, '90.012');
INSERT INTO public.virksomhet_naring VALUES (355, '01.120');
INSERT INTO public.virksomhet_naring VALUES (356, '01.120');
INSERT INTO public.virksomhet_naring VALUES (357, '01.120');
INSERT INTO public.virksomhet_naring VALUES (358, '01.120');
INSERT INTO public.virksomhet_naring VALUES (359, '01.120');
INSERT INTO public.virksomhet_naring VALUES (359, '90.012');
INSERT INTO public.virksomhet_naring VALUES (359, '70.220');
INSERT INTO public.virksomhet_naring VALUES (360, '01.120');
INSERT INTO public.virksomhet_naring VALUES (360, '90.012');
INSERT INTO public.virksomhet_naring VALUES (361, '01.120');
INSERT INTO public.virksomhet_naring VALUES (361, '90.012');
INSERT INTO public.virksomhet_naring VALUES (362, '01.120');
INSERT INTO public.virksomhet_naring VALUES (362, '90.012');
INSERT INTO public.virksomhet_naring VALUES (363, '01.120');
INSERT INTO public.virksomhet_naring VALUES (363, '90.012');
INSERT INTO public.virksomhet_naring VALUES (363, '70.220');
INSERT INTO public.virksomhet_naring VALUES (364, '01.120');
INSERT INTO public.virksomhet_naring VALUES (365, '01.120');
INSERT INTO public.virksomhet_naring VALUES (366, '01.120');
INSERT INTO public.virksomhet_naring VALUES (366, '90.012');
INSERT INTO public.virksomhet_naring VALUES (366, '70.220');
INSERT INTO public.virksomhet_naring VALUES (367, '01.120');
INSERT INTO public.virksomhet_naring VALUES (367, '90.012');
INSERT INTO public.virksomhet_naring VALUES (368, '01.120');
INSERT INTO public.virksomhet_naring VALUES (368, '90.012');
INSERT INTO public.virksomhet_naring VALUES (369, '01.120');
INSERT INTO public.virksomhet_naring VALUES (369, '90.012');
INSERT INTO public.virksomhet_naring VALUES (369, '70.220');
INSERT INTO public.virksomhet_naring VALUES (370, '01.120');
INSERT INTO public.virksomhet_naring VALUES (371, '01.120');
INSERT INTO public.virksomhet_naring VALUES (372, '01.120');
INSERT INTO public.virksomhet_naring VALUES (372, '90.012');
INSERT INTO public.virksomhet_naring VALUES (372, '70.220');
INSERT INTO public.virksomhet_naring VALUES (373, '01.120');
INSERT INTO public.virksomhet_naring VALUES (373, '90.012');
INSERT INTO public.virksomhet_naring VALUES (373, '70.220');
INSERT INTO public.virksomhet_naring VALUES (374, '01.120');
INSERT INTO public.virksomhet_naring VALUES (374, '90.012');
INSERT INTO public.virksomhet_naring VALUES (375, '01.120');
INSERT INTO public.virksomhet_naring VALUES (375, '90.012');
INSERT INTO public.virksomhet_naring VALUES (376, '01.120');
INSERT INTO public.virksomhet_naring VALUES (376, '90.012');
INSERT INTO public.virksomhet_naring VALUES (377, '01.120');
INSERT INTO public.virksomhet_naring VALUES (377, '90.012');
INSERT INTO public.virksomhet_naring VALUES (378, '01.120');
INSERT INTO public.virksomhet_naring VALUES (378, '90.012');
INSERT INTO public.virksomhet_naring VALUES (379, '01.120');
INSERT INTO public.virksomhet_naring VALUES (379, '90.012');
INSERT INTO public.virksomhet_naring VALUES (380, '01.120');
INSERT INTO public.virksomhet_naring VALUES (380, '90.012');
INSERT INTO public.virksomhet_naring VALUES (381, '01.120');
INSERT INTO public.virksomhet_naring VALUES (382, '01.120');
INSERT INTO public.virksomhet_naring VALUES (382, '90.012');
INSERT INTO public.virksomhet_naring VALUES (383, '01.120');
INSERT INTO public.virksomhet_naring VALUES (384, '01.120');
INSERT INTO public.virksomhet_naring VALUES (385, '01.120');
INSERT INTO public.virksomhet_naring VALUES (385, '90.012');
INSERT INTO public.virksomhet_naring VALUES (386, '01.120');
INSERT INTO public.virksomhet_naring VALUES (387, '01.120');
INSERT INTO public.virksomhet_naring VALUES (388, '01.120');
INSERT INTO public.virksomhet_naring VALUES (389, '01.120');
INSERT INTO public.virksomhet_naring VALUES (389, '90.012');
INSERT INTO public.virksomhet_naring VALUES (390, '01.120');
INSERT INTO public.virksomhet_naring VALUES (390, '90.012');
INSERT INTO public.virksomhet_naring VALUES (391, '01.120');
INSERT INTO public.virksomhet_naring VALUES (391, '90.012');
INSERT INTO public.virksomhet_naring VALUES (392, '01.120');
INSERT INTO public.virksomhet_naring VALUES (393, '01.120');
INSERT INTO public.virksomhet_naring VALUES (394, '01.120');
INSERT INTO public.virksomhet_naring VALUES (394, '90.012');
INSERT INTO public.virksomhet_naring VALUES (395, '01.120');
INSERT INTO public.virksomhet_naring VALUES (395, '90.012');
INSERT INTO public.virksomhet_naring VALUES (396, '01.120');
INSERT INTO public.virksomhet_naring VALUES (397, '01.120');
INSERT INTO public.virksomhet_naring VALUES (397, '90.012');
INSERT INTO public.virksomhet_naring VALUES (398, '01.120');
INSERT INTO public.virksomhet_naring VALUES (398, '90.012');
INSERT INTO public.virksomhet_naring VALUES (399, '01.120');
INSERT INTO public.virksomhet_naring VALUES (399, '90.012');
INSERT INTO public.virksomhet_naring VALUES (400, '01.120');
INSERT INTO public.virksomhet_naring VALUES (400, '90.012');
INSERT INTO public.virksomhet_naring VALUES (400, '70.220');
INSERT INTO public.virksomhet_naring VALUES (401, '01.120');
INSERT INTO public.virksomhet_naring VALUES (401, '90.012');
INSERT INTO public.virksomhet_naring VALUES (401, '70.220');
INSERT INTO public.virksomhet_naring VALUES (402, '01.120');
INSERT INTO public.virksomhet_naring VALUES (403, '01.120');
INSERT INTO public.virksomhet_naring VALUES (404, '01.120');
INSERT INTO public.virksomhet_naring VALUES (405, '01.120');
INSERT INTO public.virksomhet_naring VALUES (406, '01.120');
INSERT INTO public.virksomhet_naring VALUES (406, '90.012');
INSERT INTO public.virksomhet_naring VALUES (406, '70.220');
INSERT INTO public.virksomhet_naring VALUES (407, '01.120');
INSERT INTO public.virksomhet_naring VALUES (408, '01.120');
INSERT INTO public.virksomhet_naring VALUES (408, '90.012');
INSERT INTO public.virksomhet_naring VALUES (409, '01.120');
INSERT INTO public.virksomhet_naring VALUES (410, '01.120');
INSERT INTO public.virksomhet_naring VALUES (411, '01.120');
INSERT INTO public.virksomhet_naring VALUES (411, '90.012');
INSERT INTO public.virksomhet_naring VALUES (411, '70.220');
INSERT INTO public.virksomhet_naring VALUES (412, '01.120');
INSERT INTO public.virksomhet_naring VALUES (412, '90.012');
INSERT INTO public.virksomhet_naring VALUES (413, '01.120');
INSERT INTO public.virksomhet_naring VALUES (414, '01.120');
INSERT INTO public.virksomhet_naring VALUES (414, '90.012');
INSERT INTO public.virksomhet_naring VALUES (415, '01.120');
INSERT INTO public.virksomhet_naring VALUES (416, '01.120');
INSERT INTO public.virksomhet_naring VALUES (416, '90.012');
INSERT INTO public.virksomhet_naring VALUES (416, '70.220');
INSERT INTO public.virksomhet_naring VALUES (417, '01.120');
INSERT INTO public.virksomhet_naring VALUES (417, '90.012');
INSERT INTO public.virksomhet_naring VALUES (417, '70.220');
INSERT INTO public.virksomhet_naring VALUES (418, '01.120');
INSERT INTO public.virksomhet_naring VALUES (418, '90.012');
INSERT INTO public.virksomhet_naring VALUES (419, '01.120');
INSERT INTO public.virksomhet_naring VALUES (420, '01.120');
INSERT INTO public.virksomhet_naring VALUES (420, '90.012');
INSERT INTO public.virksomhet_naring VALUES (421, '01.120');
INSERT INTO public.virksomhet_naring VALUES (422, '01.120');
INSERT INTO public.virksomhet_naring VALUES (422, '90.012');
INSERT INTO public.virksomhet_naring VALUES (423, '01.120');
INSERT INTO public.virksomhet_naring VALUES (424, '01.120');
INSERT INTO public.virksomhet_naring VALUES (425, '01.120');
INSERT INTO public.virksomhet_naring VALUES (426, '01.120');
INSERT INTO public.virksomhet_naring VALUES (426, '90.012');
INSERT INTO public.virksomhet_naring VALUES (426, '70.220');
INSERT INTO public.virksomhet_naring VALUES (427, '01.120');
INSERT INTO public.virksomhet_naring VALUES (428, '01.120');
INSERT INTO public.virksomhet_naring VALUES (428, '90.012');
INSERT INTO public.virksomhet_naring VALUES (429, '01.120');
INSERT INTO public.virksomhet_naring VALUES (429, '90.012');
INSERT INTO public.virksomhet_naring VALUES (429, '70.220');
INSERT INTO public.virksomhet_naring VALUES (430, '01.120');
INSERT INTO public.virksomhet_naring VALUES (430, '90.012');
INSERT INTO public.virksomhet_naring VALUES (431, '01.120');
INSERT INTO public.virksomhet_naring VALUES (432, '01.120');
INSERT INTO public.virksomhet_naring VALUES (432, '90.012');
INSERT INTO public.virksomhet_naring VALUES (433, '01.120');
INSERT INTO public.virksomhet_naring VALUES (434, '01.120');
INSERT INTO public.virksomhet_naring VALUES (434, '90.012');
INSERT INTO public.virksomhet_naring VALUES (435, '01.120');
INSERT INTO public.virksomhet_naring VALUES (435, '90.012');
INSERT INTO public.virksomhet_naring VALUES (435, '70.220');
INSERT INTO public.virksomhet_naring VALUES (436, '01.120');
INSERT INTO public.virksomhet_naring VALUES (436, '90.012');
INSERT INTO public.virksomhet_naring VALUES (437, '01.120');
INSERT INTO public.virksomhet_naring VALUES (437, '90.012');
INSERT INTO public.virksomhet_naring VALUES (438, '01.120');
INSERT INTO public.virksomhet_naring VALUES (439, '01.120');
INSERT INTO public.virksomhet_naring VALUES (439, '90.012');
INSERT INTO public.virksomhet_naring VALUES (440, '01.120');
INSERT INTO public.virksomhet_naring VALUES (441, '01.120');
INSERT INTO public.virksomhet_naring VALUES (441, '90.012');
INSERT INTO public.virksomhet_naring VALUES (442, '01.120');
INSERT INTO public.virksomhet_naring VALUES (442, '90.012');
INSERT INTO public.virksomhet_naring VALUES (443, '01.120');
INSERT INTO public.virksomhet_naring VALUES (444, '01.120');
INSERT INTO public.virksomhet_naring VALUES (445, '01.120');
INSERT INTO public.virksomhet_naring VALUES (446, '01.120');
INSERT INTO public.virksomhet_naring VALUES (447, '01.120');
INSERT INTO public.virksomhet_naring VALUES (447, '90.012');
INSERT INTO public.virksomhet_naring VALUES (448, '01.120');
INSERT INTO public.virksomhet_naring VALUES (448, '90.012');
INSERT INTO public.virksomhet_naring VALUES (449, '01.120');
INSERT INTO public.virksomhet_naring VALUES (450, '01.120');
INSERT INTO public.virksomhet_naring VALUES (450, '90.012');
INSERT INTO public.virksomhet_naring VALUES (451, '01.120');
INSERT INTO public.virksomhet_naring VALUES (451, '90.012');
INSERT INTO public.virksomhet_naring VALUES (452, '01.120');
INSERT INTO public.virksomhet_naring VALUES (453, '01.120');
INSERT INTO public.virksomhet_naring VALUES (454, '01.120');
INSERT INTO public.virksomhet_naring VALUES (454, '90.012');
INSERT INTO public.virksomhet_naring VALUES (455, '01.120');
INSERT INTO public.virksomhet_naring VALUES (456, '01.120');
INSERT INTO public.virksomhet_naring VALUES (457, '01.120');
INSERT INTO public.virksomhet_naring VALUES (458, '01.120');
INSERT INTO public.virksomhet_naring VALUES (459, '01.120');
INSERT INTO public.virksomhet_naring VALUES (460, '01.120');
INSERT INTO public.virksomhet_naring VALUES (460, '90.012');
INSERT INTO public.virksomhet_naring VALUES (461, '01.120');
INSERT INTO public.virksomhet_naring VALUES (462, '01.120');
INSERT INTO public.virksomhet_naring VALUES (463, '01.120');
INSERT INTO public.virksomhet_naring VALUES (463, '90.012');
INSERT INTO public.virksomhet_naring VALUES (463, '70.220');
INSERT INTO public.virksomhet_naring VALUES (464, '01.120');
INSERT INTO public.virksomhet_naring VALUES (465, '01.120');
INSERT INTO public.virksomhet_naring VALUES (466, '01.120');
INSERT INTO public.virksomhet_naring VALUES (467, '01.120');
INSERT INTO public.virksomhet_naring VALUES (467, '90.012');
INSERT INTO public.virksomhet_naring VALUES (468, '01.120');
INSERT INTO public.virksomhet_naring VALUES (469, '01.120');
INSERT INTO public.virksomhet_naring VALUES (469, '90.012');
INSERT INTO public.virksomhet_naring VALUES (470, '01.120');
INSERT INTO public.virksomhet_naring VALUES (470, '90.012');
INSERT INTO public.virksomhet_naring VALUES (471, '01.120');
INSERT INTO public.virksomhet_naring VALUES (472, '01.120');
INSERT INTO public.virksomhet_naring VALUES (473, '01.120');
INSERT INTO public.virksomhet_naring VALUES (474, '01.120');
INSERT INTO public.virksomhet_naring VALUES (474, '90.012');
INSERT INTO public.virksomhet_naring VALUES (475, '01.120');
INSERT INTO public.virksomhet_naring VALUES (475, '90.012');
INSERT INTO public.virksomhet_naring VALUES (476, '01.120');
INSERT INTO public.virksomhet_naring VALUES (477, '01.120');
INSERT INTO public.virksomhet_naring VALUES (478, '01.120');
INSERT INTO public.virksomhet_naring VALUES (479, '01.120');
INSERT INTO public.virksomhet_naring VALUES (479, '90.012');
INSERT INTO public.virksomhet_naring VALUES (480, '01.120');
INSERT INTO public.virksomhet_naring VALUES (480, '90.012');
INSERT INTO public.virksomhet_naring VALUES (481, '01.120');
INSERT INTO public.virksomhet_naring VALUES (481, '90.012');
INSERT INTO public.virksomhet_naring VALUES (482, '01.120');
INSERT INTO public.virksomhet_naring VALUES (482, '90.012');
INSERT INTO public.virksomhet_naring VALUES (483, '01.120');
INSERT INTO public.virksomhet_naring VALUES (483, '90.012');
INSERT INTO public.virksomhet_naring VALUES (483, '70.220');
INSERT INTO public.virksomhet_naring VALUES (484, '01.120');
INSERT INTO public.virksomhet_naring VALUES (484, '90.012');
INSERT INTO public.virksomhet_naring VALUES (484, '70.220');
INSERT INTO public.virksomhet_naring VALUES (485, '01.120');
INSERT INTO public.virksomhet_naring VALUES (485, '90.012');
INSERT INTO public.virksomhet_naring VALUES (485, '70.220');
INSERT INTO public.virksomhet_naring VALUES (486, '01.120');
INSERT INTO public.virksomhet_naring VALUES (486, '90.012');
INSERT INTO public.virksomhet_naring VALUES (486, '70.220');
INSERT INTO public.virksomhet_naring VALUES (487, '01.120');
INSERT INTO public.virksomhet_naring VALUES (487, '90.012');
INSERT INTO public.virksomhet_naring VALUES (488, '01.120');
INSERT INTO public.virksomhet_naring VALUES (488, '90.012');
INSERT INTO public.virksomhet_naring VALUES (489, '01.120');
INSERT INTO public.virksomhet_naring VALUES (490, '01.120');
INSERT INTO public.virksomhet_naring VALUES (490, '90.012');
INSERT INTO public.virksomhet_naring VALUES (490, '70.220');
INSERT INTO public.virksomhet_naring VALUES (491, '01.120');
INSERT INTO public.virksomhet_naring VALUES (492, '01.120');
INSERT INTO public.virksomhet_naring VALUES (492, '90.012');
INSERT INTO public.virksomhet_naring VALUES (493, '01.120');
INSERT INTO public.virksomhet_naring VALUES (493, '90.012');
INSERT INTO public.virksomhet_naring VALUES (494, '01.120');
INSERT INTO public.virksomhet_naring VALUES (494, '90.012');
INSERT INTO public.virksomhet_naring VALUES (494, '70.220');
INSERT INTO public.virksomhet_naring VALUES (495, '01.120');
INSERT INTO public.virksomhet_naring VALUES (495, '90.012');
INSERT INTO public.virksomhet_naring VALUES (496, '01.120');
INSERT INTO public.virksomhet_naring VALUES (497, '01.120');
INSERT INTO public.virksomhet_naring VALUES (498, '01.120');
INSERT INTO public.virksomhet_naring VALUES (499, '01.120');
INSERT INTO public.virksomhet_naring VALUES (500, '01.120');
INSERT INTO public.virksomhet_naring VALUES (501, '01.120');
INSERT INTO public.virksomhet_naring VALUES (501, '90.012');
INSERT INTO public.virksomhet_naring VALUES (501, '70.220');
INSERT INTO public.virksomhet_naring VALUES (502, '01.120');
INSERT INTO public.virksomhet_naring VALUES (502, '90.012');
INSERT INTO public.virksomhet_naring VALUES (502, '70.220');
INSERT INTO public.virksomhet_naring VALUES (503, '01.120');
INSERT INTO public.virksomhet_naring VALUES (504, '01.120');
INSERT INTO public.virksomhet_naring VALUES (505, '01.120');
INSERT INTO public.virksomhet_naring VALUES (505, '90.012');
INSERT INTO public.virksomhet_naring VALUES (506, '01.120');
INSERT INTO public.virksomhet_naring VALUES (507, '01.120');
INSERT INTO public.virksomhet_naring VALUES (507, '90.012');
INSERT INTO public.virksomhet_naring VALUES (508, '01.120');
INSERT INTO public.virksomhet_naring VALUES (509, '01.120');
INSERT INTO public.virksomhet_naring VALUES (509, '90.012');
INSERT INTO public.virksomhet_naring VALUES (509, '70.220');
INSERT INTO public.virksomhet_naring VALUES (510, '01.120');
INSERT INTO public.virksomhet_naring VALUES (511, '01.120');
INSERT INTO public.virksomhet_naring VALUES (511, '90.012');
INSERT INTO public.virksomhet_naring VALUES (517, '01.120');
INSERT INTO public.virksomhet_naring VALUES (518, '01.120');
INSERT INTO public.virksomhet_naring VALUES (519, '01.120');
INSERT INTO public.virksomhet_naring VALUES (519, '90.012');
INSERT INTO public.virksomhet_naring VALUES (520, '01.120');
INSERT INTO public.virksomhet_naring VALUES (521, '01.120');
INSERT INTO public.virksomhet_naring VALUES (522, '01.120');
INSERT INTO public.virksomhet_naring VALUES (522, '90.012');
INSERT INTO public.virksomhet_naring VALUES (522, '70.220');
INSERT INTO public.virksomhet_naring VALUES (523, '01.120');
INSERT INTO public.virksomhet_naring VALUES (523, '90.012');
INSERT INTO public.virksomhet_naring VALUES (523, '70.220');
INSERT INTO public.virksomhet_naring VALUES (524, '01.120');
INSERT INTO public.virksomhet_naring VALUES (525, '01.120');
INSERT INTO public.virksomhet_naring VALUES (525, '90.012');
INSERT INTO public.virksomhet_naring VALUES (526, '01.120');
INSERT INTO public.virksomhet_naring VALUES (512, '01.120');
INSERT INTO public.virksomhet_naring VALUES (512, '90.012');
INSERT INTO public.virksomhet_naring VALUES (512, '70.220');
INSERT INTO public.virksomhet_naring VALUES (513, '01.120');
INSERT INTO public.virksomhet_naring VALUES (514, '01.120');
INSERT INTO public.virksomhet_naring VALUES (514, '90.012');
INSERT INTO public.virksomhet_naring VALUES (515, '01.120');
INSERT INTO public.virksomhet_naring VALUES (516, '01.120');
INSERT INTO public.virksomhet_naring VALUES (516, '90.012');
INSERT INTO public.virksomhet_naring VALUES (527, '01.120');
INSERT INTO public.virksomhet_naring VALUES (527, '01.110');
INSERT INTO public.virksomhet_naring VALUES (527, '70.220');
INSERT INTO public.virksomhet_naring VALUES (534, '01.120');
INSERT INTO public.virksomhet_naring VALUES (535, '01.120');
INSERT INTO public.virksomhet_naring VALUES (535, '90.012');
INSERT INTO public.virksomhet_naring VALUES (536, '01.120');
INSERT INTO public.virksomhet_naring VALUES (536, '90.012');
INSERT INTO public.virksomhet_naring VALUES (537, '01.120');
INSERT INTO public.virksomhet_naring VALUES (537, '90.012');
INSERT INTO public.virksomhet_naring VALUES (538, '01.120');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.360883');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.419584');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '555555555', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.419584');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (6, '881532376', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '883874352', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '848147638', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '876763949', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '871871807', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (15, '864079801', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (16, '836041617', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (17, '857842260', 'VIRKSOMHET', '3', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (18, '885073621', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (19, '864754605', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (20, '846347581', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (21, '824680794', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (22, '839415001', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '861744528', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.491876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '860138909', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.673266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (25, '843242104', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.673266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '890093850', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.673266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (27, '892511017', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.673266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '842605109', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.673266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (29, '870491047', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.673266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '863507760', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.673266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (31, '817257908', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.673266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '809042383', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.673266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '810734693', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.673266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '804629062', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.673266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '873621335', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '835058832', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '803826652', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '874394467', 'VIRKSOMHET', '3', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '838903289', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '882051647', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '879681201', 'VIRKSOMHET', '3', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '852409131', 'VIRKSOMHET', '3', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '808215075', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '865074415', 'VIRKSOMHET', '3', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '836669149', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '884369776', 'VIRKSOMHET', '3', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '873418367', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '802905016', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '885609899', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '860836918', 'VIRKSOMHET', '3', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '829745509', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '844246611', 'VIRKSOMHET', '3', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '867216743', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '890941228', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '838540049', 'VIRKSOMHET', '3', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '809501750', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '844496478', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '863501025', 'VIRKSOMHET', '2', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '839166324', 'VIRKSOMHET', '3', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '879962157', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '848543645', 'VIRKSOMHET', '1', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '880279851', 'VIRKSOMHET', '3', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '808671188', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '851333885', 'VIRKSOMHET', '0', '2023-01-11 13:06:30.758814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '815366017', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '891113900', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '894926128', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '802290404', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '896239097', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '816868949', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '895298219', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '842893897', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '814670938', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '820433803', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '874104569', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '856520283', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '879090305', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '809468321', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.002485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '826378947', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '866390365', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '862771013', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '864363318', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '896438075', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '829368106', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '867407313', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '896587504', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '847845944', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '826389298', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '848399886', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '854846835', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '800634899', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '857110616', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '808271586', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '819801010', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '848578637', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '827490752', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '835736810', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '857544475', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '847721823', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '862581603', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '810313500', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '885129733', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '898243796', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '887079787', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '861058672', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '876537913', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '890597928', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '842982051', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '842389667', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '820004072', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '897688257', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '837534390', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '808543637', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '870201888', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '817311070', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '868012776', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '896429753', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '851603425', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '827443317', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.105832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '833362642', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '882069408', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '863878944', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '866558221', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '868767855', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '875885300', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '842216735', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '856920437', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '830858963', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '812434114', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '847041353', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '803269327', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '843457384', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '818306281', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.322482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '844449510', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '867177223', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '883963814', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '886253015', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '895281822', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '840533481', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '839216776', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '803533948', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '827095124', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '808251981', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '817358823', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '871910327', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '866587133', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '842840788', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '812781923', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '804058381', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '811423248', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '840837641', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '818816392', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '806494928', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '893055618', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '875340822', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '818463756', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '884152302', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '849742742', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '804979817', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '814190896', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '822331640', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '862678317', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '831093023', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '874226454', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '832436811', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '838432048', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '870022919', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '879268334', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '806599852', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '863181199', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '863767568', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '844014636', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.439627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '866404710', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '833129946', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '846977998', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '811030348', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '890815907', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '822694021', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '852558904', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '822874914', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '866646453', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '881021956', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '899291735', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '867918928', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '823439458', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '837805347', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.683286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '805499088', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '845822610', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '841405633', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '889675608', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '899025387', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '863280835', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '860629673', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '833667497', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '842471044', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '861459803', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '812926032', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '871631319', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '865439281', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '824210548', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '805486005', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '832448472', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '805820685', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '883768894', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '856903021', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '850012745', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '820149848', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '822705108', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '857573851', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '856078198', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '859225721', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '873879874', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '890065285', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '893423280', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '816273126', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '874977909', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '888632161', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '852452427', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '807389236', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '833163111', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '813080832', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '896489260', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '845881839', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '898157169', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '882940656', 'VIRKSOMHET', '0', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '887589106', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '856439808', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '869911712', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '836420677', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '810521018', 'VIRKSOMHET', '3', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '863021621', 'VIRKSOMHET', '2', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '846289494', 'VIRKSOMHET', '1', '2023-01-11 13:06:31.817827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '834191416', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '837420340', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '871949311', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '821633142', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '893463166', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '833218825', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '807456455', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '821381486', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '814324199', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '805904949', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '813242515', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '839415843', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '804234371', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '816585946', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '824097835', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '880538674', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '875775705', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '877421692', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '871547736', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '857653378', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '829980700', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '852627790', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.075809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '865978526', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '840145629', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '875016141', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '869419134', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '813944600', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '885600454', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '877550656', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '804227830', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '858956619', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '865153645', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '817941723', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '811667993', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '859462534', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '822317092', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '877772835', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '846495295', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '804775869', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '831030012', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '802809462', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '896200151', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '873610100', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '847931581', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '870810427', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '816457914', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '816760477', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '821449527', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '897412997', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '801856356', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '898170941', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '884390144', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '894424841', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '828972512', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '815082581', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '887159012', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '829493874', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '814929193', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '859907302', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '895124699', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '813239227', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '840430296', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '858726639', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '823234800', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '874361830', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '808481735', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '860499175', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.2109');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '892697142', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '826727890', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '895582762', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '814663914', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '887191975', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '856729012', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '816248533', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '847253663', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '851556995', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '897000352', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '891267708', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '868369009', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '836786224', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '800910790', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '847922087', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '882737279', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '817612413', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '857680168', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '878624841', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '867183919', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '824306551', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '812929350', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '890735735', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '894341616', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '845690609', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '884945724', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '820865124', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '870514368', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.457723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '833643869', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '807702188', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '820638689', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '843380901', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '832951634', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '833677243', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '873656323', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '859159231', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '868067017', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '856435712', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '888937591', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '873906284', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '855150484', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '836365546', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '822564929', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '833204596', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '863592645', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '865956727', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '807629933', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '832454631', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '823356725', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '800824855', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '894510083', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '815854671', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '876401827', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '845066027', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '815406101', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '866878310', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '830803739', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '805933483', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '868252144', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '828744326', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '830122600', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '813147327', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '846250295', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '898250721', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '813697349', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '863104800', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '897979593', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '860772161', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '808002552', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '876394411', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '846214156', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '850015354', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '805145991', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '853879838', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '882939801', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '859605190', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '891814367', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '875021136', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '825379831', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '800469195', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '871244244', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '837133219', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '855964219', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '838273484', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.613076');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '893483616', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '891497759', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '888247901', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '883590490', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '804908767', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '851919134', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '813682750', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '875544956', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '889472231', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '875631634', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '856007783', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '844760467', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '863256691', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '851705582', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '854298834', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '836216435', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '893017297', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '841372032', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '862589424', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '871501781', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '880977356', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '859708655', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '837130075', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '803170681', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '875018446', 'VIRKSOMHET', '3', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '872251225', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '889927472', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '850310272', 'VIRKSOMHET', '1', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '878277970', 'VIRKSOMHET', '2', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '811324382', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '878265174', 'VIRKSOMHET', '0', '2023-01-11 13:06:32.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '803799726', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '827344157', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '868610918', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '891144647', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '874750888', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '879572863', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '816719384', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '823372812', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '872671153', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '837782686', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '856373244', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '802319687', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '882221112', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '825823538', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '840744367', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '807485242', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '878321914', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '886892017', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '871623349', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '864986459', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '849227492', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '850910144', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '869658223', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '866431270', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '858356342', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '852467356', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '898657961', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '846849579', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '873579899', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '843035298', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '858836952', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '805709917', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '808479485', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '838878962', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '885625328', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '837527996', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '844848494', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '825573136', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '809036318', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '800223332', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '878112453', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '893781546', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '818658010', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '862270603', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '812325897', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '817554736', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '884291457', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '890910485', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '810677960', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '830621787', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '874792210', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '828718942', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '846277869', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '809316543', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '846821438', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '836005340', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '869069081', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '824870495', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '821850314', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '895629317', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '854843256', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '825397589', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '856901774', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '886566656', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '868634250', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '827178297', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '889901026', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '860932226', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '883640440', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '899511765', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '826671551', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '838991015', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '831768843', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '803324193', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '827269180', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '806938796', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.070103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '817130185', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '810402680', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '887841956', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '897336611', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '858728795', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '880050743', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '871161662', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '862924848', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '895031114', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '815517829', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '836666246', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '845715533', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '897156462', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '890815244', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '866562589', 'VIRKSOMHET', '2', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '875322390', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '870376312', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '863074238', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '873535604', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '820029647', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '825514130', 'VIRKSOMHET', '0', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '815801592', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '839528084', 'VIRKSOMHET', '3', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '864571830', 'VIRKSOMHET', '1', '2023-01-11 13:06:33.428089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '883989256', 'VIRKSOMHET', '0', '2023-01-11 13:06:36.502938');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '831272011', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.525673');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '831658088', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.544047');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '802008121', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.544047');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '857721878', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.544047');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '811747377', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.578395');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '801396893', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.578395');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '885133950', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.610102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '864761302', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.610102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '870050263', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.610102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '881536611', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.610102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '862811969', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.610102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '892708443', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.610102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '866931781', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.610102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '868378133', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.656769');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '872308278', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.656769');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '854032309', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.656769');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '842782667', 'VIRKSOMHET', '1', '2023-01-11 13:06:36.656769');


--
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_kategori_siste_4_kvartal_id_seq', 1, false);


--
-- Name: sykefravar_statistikk_land_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_land_id_seq', 532, true);


--
-- Name: sykefravar_statistikk_naring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_naring_id_seq', 532, true);


--
-- Name: sykefravar_statistikk_naringsundergruppe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_naringsundergruppe_id_seq', 532, true);


--
-- Name: sykefravar_statistikk_sektor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_sektor_id_seq', 532, true);


--
-- Name: sykefravar_statistikk_virksomhet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_virksomhet_id_seq', 532, true);


--
-- Name: sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq', 532, true);


--
-- Name: virksomhet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_id_seq', 538, true);


--
-- Name: virksomhet_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_metadata_id_seq', 532, true);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: ia_sak_hendelse ia_sak_hendelse_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.ia_sak_hendelse
    ADD CONSTRAINT ia_sak_hendelse_pkey PRIMARY KEY (id);


--
-- Name: ia_sak ia_sak_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.ia_sak
    ADD CONSTRAINT ia_sak_pkey PRIMARY KEY (saksnummer);


--
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal kategori_og_kode; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_kategori_siste_4_kvartal
    ADD CONSTRAINT kategori_og_kode UNIQUE (kategori, kode);


--
-- Name: sykefravar_statistikk_land land_periode; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_land
    ADD CONSTRAINT land_periode UNIQUE (land, arstall, kvartal);


--
-- Name: sykefravar_statistikk_naring naring_periode; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_naring
    ADD CONSTRAINT naring_periode UNIQUE (naring, arstall, kvartal);


--
-- Name: naring naring_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.naring
    ADD CONSTRAINT naring_pkey PRIMARY KEY (kode);


--
-- Name: sykefravar_statistikk_naringsundergruppe naringsundergruppe_periode; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_naringsundergruppe
    ADD CONSTRAINT naringsundergruppe_periode UNIQUE (naringsundergruppe, arstall, kvartal);


--
-- Name: sykefravar_statistikk_sektor sektor_periode; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_sektor
    ADD CONSTRAINT sektor_periode UNIQUE (sektor_kode, arstall, kvartal);


--
-- Name: sektor sektor_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sektor
    ADD CONSTRAINT sektor_pkey PRIMARY KEY (kode);


--
-- Name: sykefravar_statistikk_virksomhet sykefravar_periode; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_virksomhet
    ADD CONSTRAINT sykefravar_periode UNIQUE (orgnr, arstall, kvartal);


--
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal sykefravar_statistikk_kategori_siste_4_kvartal_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_kategori_siste_4_kvartal
    ADD CONSTRAINT sykefravar_statistikk_kategori_siste_4_kvartal_pkey PRIMARY KEY (id);


--
-- Name: sykefravar_statistikk_land sykefravar_statistikk_land_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_land
    ADD CONSTRAINT sykefravar_statistikk_land_pkey PRIMARY KEY (id);


--
-- Name: sykefravar_statistikk_naring sykefravar_statistikk_naring_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_naring
    ADD CONSTRAINT sykefravar_statistikk_naring_pkey PRIMARY KEY (id);


--
-- Name: sykefravar_statistikk_naringsundergruppe sykefravar_statistikk_naringsundergruppe_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_naringsundergruppe
    ADD CONSTRAINT sykefravar_statistikk_naringsundergruppe_pkey PRIMARY KEY (id);


--
-- Name: sykefravar_statistikk_sektor sykefravar_statistikk_sektor_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_sektor
    ADD CONSTRAINT sykefravar_statistikk_sektor_pkey PRIMARY KEY (id);


--
-- Name: sykefravar_statistikk_virksomhet sykefravar_statistikk_virksomhet_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_virksomhet
    ADD CONSTRAINT sykefravar_statistikk_virksomhet_pkey PRIMARY KEY (id);


--
-- Name: sykefravar_statistikk_virksomhet_siste_4_kvartal sykefravar_statistikk_virksomhet_siste_4_kvartal_orgnr_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_virksomhet_siste_4_kvartal
    ADD CONSTRAINT sykefravar_statistikk_virksomhet_siste_4_kvartal_orgnr_key UNIQUE (orgnr);


--
-- Name: sykefravar_statistikk_virksomhet_siste_4_kvartal sykefravar_statistikk_virksomhet_siste_4_kvartal_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_virksomhet_siste_4_kvartal
    ADD CONSTRAINT sykefravar_statistikk_virksomhet_siste_4_kvartal_pkey PRIMARY KEY (id);


--
-- Name: virksomhet_statistikk_metadata virksomhet_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_statistikk_metadata
    ADD CONSTRAINT virksomhet_metadata_pkey PRIMARY KEY (id);


--
-- Name: virksomhet_naring virksomhet_naring_unik; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_naring
    ADD CONSTRAINT virksomhet_naring_unik UNIQUE (virksomhet, narings_kode);


--
-- Name: virksomhet virksomhet_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet
    ADD CONSTRAINT virksomhet_pkey PRIMARY KEY (id);


--
-- Name: virksomhet_statistikk_metadata virksomhet_statistikk_metadata_unik_orgnr; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_statistikk_metadata
    ADD CONSTRAINT virksomhet_statistikk_metadata_unik_orgnr UNIQUE (orgnr);


--
-- Name: virksomhet virksomhet_unik_orgnr; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet
    ADD CONSTRAINT virksomhet_unik_orgnr UNIQUE (orgnr);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_ia_sak_hendelse_orgnr; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_ia_sak_hendelse_orgnr ON public.ia_sak_hendelse USING btree (orgnr);


--
-- Name: idx_ia_sak_hendelse_saksnummer; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_ia_sak_hendelse_saksnummer ON public.ia_sak_hendelse USING btree (saksnummer);


--
-- Name: idx_ia_sak_orgnr; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_ia_sak_orgnr ON public.ia_sak USING btree (orgnr);


--
-- Name: idx_ia_sak_status; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_ia_sak_status ON public.ia_sak USING btree (status);


--
-- Name: idx_land_sykefravar_statistikk_land; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_land_sykefravar_statistikk_land ON public.sykefravar_statistikk_land USING btree (land);


--
-- Name: idx_naring_sykefravar_statistikk_naring; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_naring_sykefravar_statistikk_naring ON public.sykefravar_statistikk_naring USING btree (naring);


--
-- Name: idx_naringsundergruppe_sykefravar_statistikk_naringsundergruppe; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_naringsundergruppe_sykefravar_statistikk_naringsundergruppe ON public.sykefravar_statistikk_naringsundergruppe USING btree (naringsundergruppe);


--
-- Name: idx_orgnr_sykefravar_statistikk_virksomhet; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_orgnr_sykefravar_statistikk_virksomhet ON public.sykefravar_statistikk_virksomhet USING btree (orgnr);


--
-- Name: idx_orgnr_virksomhet_statistikk_metadata; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_orgnr_virksomhet_statistikk_metadata ON public.virksomhet_statistikk_metadata USING btree (orgnr);


--
-- Name: idx_sektor_kode_sykefravar_statistikk_sektor; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_sektor_kode_sykefravar_statistikk_sektor ON public.sykefravar_statistikk_sektor USING btree (sektor_kode);


--
-- Name: idx_sykefravar_statistikk_virksomhet_arstall; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_sykefravar_statistikk_virksomhet_arstall ON public.sykefravar_statistikk_virksomhet USING btree (arstall);


--
-- Name: idx_sykefravar_statistikk_virksomhet_kvartal; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_sykefravar_statistikk_virksomhet_kvartal ON public.sykefravar_statistikk_virksomhet USING btree (kvartal);


--
-- Name: idx_sykefraver_periode_tapte_dagsverk; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_sykefraver_periode_tapte_dagsverk ON public.sykefravar_statistikk_virksomhet USING btree (arstall, kvartal, tapte_dagsverk DESC NULLS LAST);


--
-- Name: idx_virksomhet_kommunenr; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_virksomhet_kommunenr ON public.virksomhet USING btree (kommunenummer);


--
-- Name: hendelse_begrunnelse fk_hendelse_begrunnelse; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.hendelse_begrunnelse
    ADD CONSTRAINT fk_hendelse_begrunnelse FOREIGN KEY (hendelse_id) REFERENCES public.ia_sak_hendelse(id);


--
-- Name: ia_sak fk_ia_sak_endret_av_hendelse; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.ia_sak
    ADD CONSTRAINT fk_ia_sak_endret_av_hendelse FOREIGN KEY (endret_av_hendelse) REFERENCES public.ia_sak_hendelse(id);


--
-- Name: ia_sak_hendelse fk_ia_sak_hendelse_virksomhet; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.ia_sak_hendelse
    ADD CONSTRAINT fk_ia_sak_hendelse_virksomhet FOREIGN KEY (orgnr) REFERENCES public.virksomhet(orgnr);


--
-- Name: virksomhet_naring fk_virksomhet_naring_naring; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_naring
    ADD CONSTRAINT fk_virksomhet_naring_naring FOREIGN KEY (narings_kode) REFERENCES public.naring(kode);


--
-- Name: virksomhet_naring fk_virksomhet_naring_virksomhet; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_naring
    ADD CONSTRAINT fk_virksomhet_naring_virksomhet FOREIGN KEY (virksomhet) REFERENCES public.virksomhet(id) ON DELETE CASCADE;


--
-- Name: TABLE flyway_schema_history; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.flyway_schema_history TO cloudsqliamuser;


--
-- Name: TABLE hendelse_begrunnelse; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.hendelse_begrunnelse TO cloudsqliamuser;


--
-- Name: TABLE ia_sak; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.ia_sak TO cloudsqliamuser;


--
-- Name: TABLE ia_sak_hendelse; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.ia_sak_hendelse TO cloudsqliamuser;


--
-- Name: TABLE naring; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.naring TO cloudsqliamuser;


--
-- Name: TABLE sektor; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.sektor TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_kategori_siste_4_kvartal; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.sykefravar_statistikk_kategori_siste_4_kvartal TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_land; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.sykefravar_statistikk_land TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_naring; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.sykefravar_statistikk_naring TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_naringsundergruppe; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.sykefravar_statistikk_naringsundergruppe TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_sektor; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.sykefravar_statistikk_sektor TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_virksomhet; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.sykefravar_statistikk_virksomhet TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.sykefravar_statistikk_virksomhet_siste_4_kvartal TO cloudsqliamuser;


--
-- Name: TABLE virksomhet; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.virksomhet TO cloudsqliamuser;


--
-- Name: TABLE virksomhet_statistikk_metadata; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.virksomhet_statistikk_metadata TO cloudsqliamuser;


--
-- Name: TABLE virksomhet_naring; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.virksomhet_naring TO cloudsqliamuser;


--
-- PostgreSQL database dump complete
--

