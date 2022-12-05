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
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_grunnlag DROP CONSTRAINT IF EXISTS fk_sykefravar_statistikk_grunnlag_sak;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_grunnlag DROP CONSTRAINT IF EXISTS fk_sykefravar_statistikk_grunnlag_hendelse;
ALTER TABLE IF EXISTS ONLY public.ia_sak_hendelse DROP CONSTRAINT IF EXISTS fk_ia_sak_hendelse_virksomhet;
ALTER TABLE IF EXISTS ONLY public.ia_sak DROP CONSTRAINT IF EXISTS fk_ia_sak_endret_av_hendelse;
ALTER TABLE IF EXISTS ONLY public.hendelse_begrunnelse DROP CONSTRAINT IF EXISTS fk_hendelse_begrunnelse;
DROP INDEX IF EXISTS public.idx_virksomhet_kommunenr;
DROP INDEX IF EXISTS public.idx_sykefraver_periode_tapte_dagsverk;
DROP INDEX IF EXISTS public.idx_sykefravar_statistikk_virksomhet_kvartal;
DROP INDEX IF EXISTS public.idx_sykefravar_statistikk_virksomhet_arstall;
DROP INDEX IF EXISTS public.idx_sykefravar_statistikk_grunnlag_orgnr;
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
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_grunnlag DROP CONSTRAINT IF EXISTS sykefravar_statistikk_grunnlag_pkey;
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
ALTER TABLE IF EXISTS public.sykefravar_statistikk_grunnlag ALTER COLUMN id DROP DEFAULT;
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
DROP SEQUENCE IF EXISTS public.sykefravar_statistikk_grunnlag_id_seq;
DROP TABLE IF EXISTS public.sykefravar_statistikk_grunnlag;
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
-- Name: sykefravar_statistikk_grunnlag; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.sykefravar_statistikk_grunnlag (
    id integer NOT NULL,
    saksnummer character varying NOT NULL,
    hendelse_id character varying NOT NULL,
    orgnr character varying(20) NOT NULL,
    arstall smallint NOT NULL,
    kvartal smallint NOT NULL,
    antall_personer numeric NOT NULL,
    tapte_dagsverk numeric NOT NULL,
    mulige_dagsverk numeric NOT NULL,
    prosent numeric NOT NULL,
    maskert boolean NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sykefravar_statistikk_grunnlag OWNER TO test;

--
-- Name: sykefravar_statistikk_grunnlag_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.sykefravar_statistikk_grunnlag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_grunnlag_id_seq OWNER TO test;

--
-- Name: sykefravar_statistikk_grunnlag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.sykefravar_statistikk_grunnlag_id_seq OWNED BY public.sykefravar_statistikk_grunnlag.id;


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
-- Name: sykefravar_statistikk_grunnlag id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_grunnlag ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_grunnlag_id_seq'::regclass);


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

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', 'V1__init.sql', 1782034767, 'test', '2022-12-05 10:42:48.556799', 18, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', 'V2__create_virksomhet_adresse.sql', -64248919, 'test', '2022-12-05 10:42:48.607438', 15, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', 'V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2022-12-05 10:42:48.643243', 5, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', 'V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2022-12-05 10:42:48.666782', 5, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', 'V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2022-12-05 10:42:48.686306', 8, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', 'V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2022-12-05 10:42:48.706681', 5, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', 'V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2022-12-05 10:42:48.721835', 8, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', 'V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2022-12-05 10:42:48.742048', 6, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', 'V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2022-12-05 10:42:48.756474', 9, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', 'V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2022-12-05 10:42:48.778999', 7, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', 'V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2022-12-05 10:42:48.797806', 6, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', 'V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2022-12-05 10:42:48.814765', 6, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', 'V13__ia_prosess.sql', -1755516749, 'test', '2022-12-05 10:42:48.831694', 8, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', 'V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2022-12-05 10:42:48.851184', 9, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', 'V15__endre_saknummer.sql', -1379621340, 'test', '2022-12-05 10:42:48.873699', 5, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', 'V16__ia_sak_hendelse.sql', 586872662, 'test', '2022-12-05 10:42:48.886459', 9, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', 'V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2022-12-05 10:42:48.906723', 4, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', 'V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2022-12-05 10:42:48.920648', 7, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', 'V19__legg_til_begrunnelser.sql', 779259005, 'test', '2022-12-05 10:42:48.937231', 6, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', 'V20__legg_til_flere_indekser.sql', -843857404, 'test', '2022-12-05 10:42:48.952129', 9, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', 'V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2022-12-05 10:42:48.972342', 7, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', 'V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2022-12-05 10:42:48.99479', 5, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', 'V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2022-12-05 10:42:49.008912', 6, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', 'V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2022-12-05 10:42:49.024104', 8, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', 'V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2022-12-05 10:42:49.044702', 17, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', 'V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2022-12-05 10:42:49.076851', 6, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', 'V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2022-12-05 10:42:49.091336', 6, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', 'V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2022-12-05 10:42:49.109929', 4, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', 'V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2022-12-05 10:42:49.122784', 4, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', 'V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2022-12-05 10:42:49.135123', 4, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', 'V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2022-12-05 10:42:49.146934', 5, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', 'V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2022-12-05 10:42:49.159184', 5, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', 'V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2022-12-05 10:42:49.172069', 7, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', 'V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2022-12-05 10:42:49.195152', 9, true);
INSERT INTO public.flyway_schema_history VALUES (35, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 1541169943, 'test', '2022-12-05 10:42:49.213362', 8, true);
INSERT INTO public.flyway_schema_history VALUES (36, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -1755801133, 'test', '2022-12-05 10:42:52.300229', 26, true);
INSERT INTO public.flyway_schema_history VALUES (37, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -90976808, 'test', '2022-12-05 10:43:06.429645', 22, true);


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
INSERT INTO public.naring VALUES ('90', 'Næring', 'Kortnavn for 90');
INSERT INTO public.naring VALUES ('90.012', 'Utøvende kunstnere og underholdningsvirksomhet innen scenekunst', 'Kortnavn for 90.012');
INSERT INTO public.naring VALUES ('70', 'Næring', 'Kortnavn for 70');
INSERT INTO public.naring VALUES ('70.220', 'Bedriftsrådgivning og annen administrativ rådgivning', 'Kortnavn for 70.220');
INSERT INTO public.naring VALUES ('01.110', 'Dyrking av korn, unntatt ris', 'Kortnavn for 01.110');
INSERT INTO public.naring VALUES ('01', 'Næring', 'Kortnavn for 01');
INSERT INTO public.naring VALUES ('01.120', 'Dyrking av ris', 'Kortnavn for 01.120');


--
-- Data for Name: sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_grunnlag; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_kategori_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_land; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_land VALUES (1, 2022, 3, 'NO', 2500000, 10000000, 500000000, 2, false, '2022-12-05 10:42:55.730555');
INSERT INTO public.sykefravar_statistikk_land VALUES (2, 2022, 2, 'NO', 2500000, 10000000, 500000000, 2, false, '2022-12-05 10:42:55.837642');


--
-- Data for Name: sykefravar_statistikk_naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naring VALUES (1, 2022, 3, '01', 150, 100, 5000, 2, false, '2022-12-05 10:42:55.730555');
INSERT INTO public.sykefravar_statistikk_naring VALUES (2, 2022, 2, '01', 150, 100, 5000, 2, false, '2022-12-05 10:42:55.837642');


--
-- Data for Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naringsundergruppe VALUES (1, 2022, 3, '01.110', 1250, 40, 4000, 1, false, '2022-12-05 10:42:55.730555');
INSERT INTO public.sykefravar_statistikk_naringsundergruppe VALUES (2, 2022, 2, '01.110', 1250, 40, 4000, 1, false, '2022-12-05 10:42:55.837642');


--
-- Data for Name: sykefravar_statistikk_sektor; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_sektor VALUES (1, 2022, 3, '1', 33000, 1340, 8000, 1.5, false, '2022-12-05 10:42:55.730555');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (2, 2022, 2, '1', 33000, 1340, 8000, 1.5, false, '2022-12-05 10:42:55.837642');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (14, 2022, 3, '0', 33000, 1340, 8000, 1.5, false, '2022-12-05 10:42:55.907904');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (15, 2022, 3, '2', 33000, 1340, 8000, 1.5, false, '2022-12-05 10:42:55.907904');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (23, 2022, 3, '3', 33000, 1340, 8000, 1.5, false, '2022-12-05 10:42:55.907904');


--
-- Data for Name: sykefravar_statistikk_virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2022, 3, 6, 5471.48283213096, 500, 9, false, '2022-12-05 10:42:55.730555', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2022, 2, 6, 5471.48283213096, 500, 9, false, '2022-12-05 10:42:55.837642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2022, 3, 906.815382505885, 3541.20694160976, 500, 7, false, '2022-12-05 10:42:55.837642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2022, 2, 906.815382505885, 3541.20694160976, 500, 7, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '555555555', 2022, 3, 654.307773554752, 1489.24791400852, 500, 19, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '881532376', 2022, 3, 170.298399132576, 621.173526966986, 500, 6, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '881532376', 2022, 2, 170.298399132576, 621.173526966986, 500, 6, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '883874352', 2022, 3, 42, 9456.75807865886, 500, 6, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '883874352', 2022, 2, 42, 9456.75807865886, 500, 6, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '848147638', 2022, 3, 42, 2175.37347737687, 500, 6, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '848147638', 2022, 2, 42, 2175.37347737687, 500, 6, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '876763949', 2022, 3, 510.216801763279, 7501.9894535084, 500, 1, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '876763949', 2022, 2, 510.216801763279, 7501.9894535084, 500, 1, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '871871807', 2022, 3, 166.589258104453, 4759.62091271058, 500, 14, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '864079801', 2022, 3, 96.8763945189877, 6787.04136535292, 500, 7, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '836041617', 2022, 3, 269.130278577318, 3756.8825870314, 500, 13, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '857842260', 2022, 3, 144.204167884998, 4998.01993338812, 500, 8, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '885073621', 2022, 3, 648.269437307858, 8750.81862174338, 500, 19, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '864754605', 2022, 3, 262.355229669726, 8954.20764127112, 500, 15, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '846347581', 2022, 3, 940.921482536871, 4492.98325592836, 500, 20, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '824680794', 2022, 3, 249.130773031781, 2919.0100101838, 500, 9, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '839415001', 2022, 3, 788.620543343275, 821.486343168438, 500, 14, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '861744528', 2022, 3, 724.770236230729, 4088.18593505123, 500, 3, false, '2022-12-05 10:42:55.907904', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '860138909', 2022, 3, 979.525889250885, 664.060283534183, 500, 15, false, '2022-12-05 10:42:56.130522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '843242104', 2022, 3, 604.315742598904, 5462.25156082903, 500, 8, false, '2022-12-05 10:42:56.130522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '890093850', 2022, 3, 896.276885543594, 8372.79190885587, 500, 19, false, '2022-12-05 10:42:56.130522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '892511017', 2022, 3, 12.857946662367, 3972.85040841671, 500, 13, false, '2022-12-05 10:42:56.130522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '842605109', 2022, 3, 475.628380244967, 350.328575089571, 500, 4, false, '2022-12-05 10:42:56.130522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '870491047', 2022, 3, 806.562003656689, 2760.95655147445, 500, 4, false, '2022-12-05 10:42:56.130522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '863507760', 2022, 3, 271.868099228473, 9353.1383306312, 500, 14, false, '2022-12-05 10:42:56.130522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '817257908', 2022, 3, 284.333283261464, 4419.88883419615, 500, 20, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '809042383', 2022, 3, 434.424305940091, 4061.58426210254, 500, 20, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '810734693', 2022, 3, 789.44606513289, 5098.30926397023, 500, 5, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '804629062', 2022, 3, 307.013383197838, 2590.35899055835, 500, 18, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '873621335', 2022, 3, 169.582301696581, 5946.65718700388, 500, 4, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '835058832', 2022, 3, 177.793782293709, 4236.66058490336, 500, 13, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '803826652', 2022, 3, 175.688675823525, 4556.44393109249, 500, 2, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '874394467', 2022, 3, 12.2499687736514, 2785.25355286158, 500, 20, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '838903289', 2022, 3, 463.865385821366, 1949.10440474138, 500, 20, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '882051647', 2022, 3, 847.685923370883, 5689.35663780786, 500, 2, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '879681201', 2022, 3, 627.504343437997, 2615.90104777218, 500, 8, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '852409131', 2022, 3, 37.4045595828152, 1004.2205954351, 500, 18, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '808215075', 2022, 3, 884.167711278658, 9503.78557576979, 500, 2, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '865074415', 2022, 3, 226.451378449675, 4771.00172739768, 500, 20, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '836669149', 2022, 3, 203.995729143981, 1575.77615177134, 500, 3, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '884369776', 2022, 3, 990.585055176006, 2516.96687622528, 500, 15, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '873418367', 2022, 3, 976.118595278837, 6157.52284859248, 500, 9, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '802905016', 2022, 3, 468.690191150656, 6076.63807999529, 500, 3, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '885609899', 2022, 3, 916.119568168877, 1824.94301960841, 500, 17, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '860836918', 2022, 3, 399.320065942892, 4058.71074465806, 500, 3, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '829745509', 2022, 3, 566.787107599796, 207.604446663122, 500, 1, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '844246611', 2022, 3, 357.111871073268, 437.522179372899, 500, 1, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '867216743', 2022, 3, 332.402009135236, 5954.91687770568, 500, 7, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '890941228', 2022, 3, 605.556753005751, 5048.35714114067, 500, 16, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '838540049', 2022, 3, 912.367298521193, 3576.3120758413, 500, 16, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '809501750', 2022, 3, 747.765855209912, 6244.29912773032, 500, 20, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '844496478', 2022, 3, 661.420451180728, 5328.85808319286, 500, 20, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '863501025', 2022, 3, 688.850504343443, 1356.54419842431, 500, 16, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '839166324', 2022, 3, 95.1872477194755, 8424.9040477056, 500, 8, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '879962157', 2022, 3, 92.945785713361, 4902.26698844878, 500, 2, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '848543645', 2022, 3, 537.380552924361, 1116.52509110386, 500, 2, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '880279851', 2022, 3, 564.183945748806, 7297.81756770441, 500, 12, false, '2022-12-05 10:42:56.198391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '808671188', 2022, 3, 618.800869631898, 2817.68098625638, 500, 9, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '851333885', 2022, 3, 634.47920793919, 6386.25948747084, 500, 10, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '815366017', 2022, 3, 847.0845606875, 8246.79526449683, 500, 7, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '891113900', 2022, 3, 376.815194534899, 4625.68434518162, 500, 10, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '894926128', 2022, 3, 13.3905299792093, 9593.24854198427, 500, 2, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '802290404', 2022, 3, 348.732036219456, 44.2160265052829, 500, 8, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '896239097', 2022, 3, 61.4537354988936, 1158.8428289974, 500, 17, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '816868949', 2022, 3, 318.464644923492, 5434.56618946473, 500, 19, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '895298219', 2022, 3, 973.489063241856, 305.267561978005, 500, 7, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '842893897', 2022, 3, 156.278879689796, 7985.42010223819, 500, 19, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '814670938', 2022, 3, 727.58295318751, 7472.73717666649, 500, 3, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '820433803', 2022, 3, 504.120682850708, 3952.19228420451, 500, 1, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '874104569', 2022, 3, 273.586809599424, 2149.00465665943, 500, 7, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '856520283', 2022, 3, 996.414785361738, 2175.23061541612, 500, 15, false, '2022-12-05 10:42:56.418009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '879090305', 2022, 3, 746.100953593442, 9821.56623045451, 500, 2, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '809468321', 2022, 3, 650.316744931526, 5737.54017690457, 500, 13, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '826378947', 2022, 3, 222.16276524282, 8385.25176519625, 500, 7, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '866390365', 2022, 3, 74.7769717975849, 5711.12588279609, 500, 5, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '862771013', 2022, 3, 575.663427044122, 6769.22094888337, 500, 8, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '864363318', 2022, 3, 114.955955449993, 4953.12412206676, 500, 19, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '896438075', 2022, 3, 320.598014555444, 1467.07184058369, 500, 12, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '829368106', 2022, 3, 248.874278407696, 7929.8407446665, 500, 6, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '867407313', 2022, 3, 182.087886307512, 8703.82246491887, 500, 5, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '896587504', 2022, 3, 504.18854891591, 5072.63468868687, 500, 1, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '847845944', 2022, 3, 541.41062790965, 2799.79243815745, 500, 15, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '826389298', 2022, 3, 895.513863180705, 4498.44225972919, 500, 5, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '848399886', 2022, 3, 913.020991896059, 8387.0864873234, 500, 19, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '854846835', 2022, 3, 519.017947459611, 4126.09388148005, 500, 11, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '800634899', 2022, 3, 447.551465387518, 9608.46265866485, 500, 7, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '857110616', 2022, 3, 261.582176853513, 7594.40310441572, 500, 14, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '808271586', 2022, 3, 208.270932783552, 6026.10919846057, 500, 15, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '819801010', 2022, 3, 807.72764100262, 7760.3361688454, 500, 11, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '848578637', 2022, 3, 459.852007690644, 2639.9949394004, 500, 19, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '827490752', 2022, 3, 595.457449221073, 6240.45540068695, 500, 9, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '835736810', 2022, 3, 201.459047246824, 49.2966877278199, 500, 17, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '857544475', 2022, 3, 153.223382662989, 4897.26410154236, 500, 16, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '847721823', 2022, 3, 395.66430328501, 9105.17574025612, 500, 1, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '862581603', 2022, 3, 129.328025770149, 783.123160904308, 500, 8, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '810313500', 2022, 3, 153.646553537122, 3916.80866084549, 500, 12, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '885129733', 2022, 3, 37.7769002423057, 8462.06447015175, 500, 15, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '898243796', 2022, 3, 911.538821715979, 3675.32998792617, 500, 14, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '887079787', 2022, 3, 404.077138482035, 4961.94897411307, 500, 12, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '861058672', 2022, 3, 485.202730915378, 9129.84702940054, 500, 6, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '876537913', 2022, 3, 584.979269687161, 7559.39156206232, 500, 10, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '890597928', 2022, 3, 693.853958175377, 4358.50117464015, 500, 10, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '842982051', 2022, 3, 305.093165819536, 6499.03627181771, 500, 16, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '842389667', 2022, 3, 520.343713892126, 8773.1009172127, 500, 15, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '820004072', 2022, 3, 878.608205873224, 5686.31086362843, 500, 11, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '897688257', 2022, 3, 123.299873334802, 8267.03087001752, 500, 19, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '837534390', 2022, 3, 965.775878855487, 2653.66828314559, 500, 1, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '808543637', 2022, 3, 352.812952941904, 8963.59989120904, 500, 4, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '870201888', 2022, 3, 918.598864785322, 1200.42844232253, 500, 3, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '817311070', 2022, 3, 114.636784503355, 9151.66955314209, 500, 9, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '868012776', 2022, 3, 6.08922072736671, 3020.98730895796, 500, 14, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '896429753', 2022, 3, 998.538274162791, 8777.34742327567, 500, 17, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '851603425', 2022, 3, 304.570186786473, 3271.41970640124, 500, 14, false, '2022-12-05 10:42:56.543598', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '827443317', 2022, 3, 880.893182920922, 3435.92015420002, 500, 1, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '833362642', 2022, 3, 267.027426372051, 1558.69908107029, 500, 14, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '882069408', 2022, 3, 762.94547206631, 974.592392034204, 500, 7, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '863878944', 2022, 3, 440.704488267681, 1806.56177443046, 500, 13, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '866558221', 2022, 3, 993.440862687548, 9976.06112390243, 500, 19, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '868767855', 2022, 3, 164.88804804906, 5465.75452150936, 500, 7, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '875885300', 2022, 3, 641.72458668343, 2459.44870127098, 500, 2, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '842216735', 2022, 3, 944.978044661147, 3418.20826583983, 500, 6, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '856920437', 2022, 3, 985.74622899576, 5762.05607260234, 500, 1, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '830858963', 2022, 3, 875.07338942952, 319.735871500111, 500, 10, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '812434114', 2022, 3, 89.3340276253092, 3289.95022054221, 500, 5, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '847041353', 2022, 3, 710.409307472226, 8572.35354296723, 500, 19, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '803269327', 2022, 3, 782.620642983012, 4063.01581652227, 500, 20, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '843457384', 2022, 3, 871.146994254665, 6563.51667275102, 500, 19, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '818306281', 2022, 3, 960.859157327002, 3768.86172184697, 500, 4, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '844449510', 2022, 3, 926.377595294535, 2877.75612330657, 500, 20, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '867177223', 2022, 3, 333.68104363284, 6744.94067249012, 500, 19, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '883963814', 2022, 3, 632.499830776185, 4421.42001283242, 500, 14, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '886253015', 2022, 3, 418.460138900368, 590.983612781807, 500, 12, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '895281822', 2022, 3, 820.776105199813, 3166.83960076502, 500, 9, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '840533481', 2022, 3, 279.013871257262, 619.898257937398, 500, 15, false, '2022-12-05 10:42:56.805072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '839216776', 2022, 3, 489.434740062509, 7656.56347475349, 500, 19, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '803533948', 2022, 3, 15.4907909318574, 1764.40949344221, 500, 12, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '827095124', 2022, 3, 473.793941151994, 5080.90950933543, 500, 14, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '808251981', 2022, 3, 914.550491185223, 9877.11579547307, 500, 9, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '817358823', 2022, 3, 654.84045445833, 6265.78857701058, 500, 14, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '871910327', 2022, 3, 536.163767522656, 1543.92173017929, 500, 12, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '866587133', 2022, 3, 582.771868201705, 395.069208959843, 500, 9, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '842840788', 2022, 3, 251.931919681928, 7858.30797838529, 500, 3, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '812781923', 2022, 3, 14.7815909634433, 9040.47808609221, 500, 6, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '804058381', 2022, 3, 23.3504280521937, 1273.11463374731, 500, 2, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '811423248', 2022, 3, 757.028910144808, 5368.41086302948, 500, 9, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '840837641', 2022, 3, 805.424569260228, 9563.77173108771, 500, 2, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '818816392', 2022, 3, 893.038124897846, 4787.8396648172, 500, 12, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '806494928', 2022, 3, 381.754796725921, 7773.31430454198, 500, 13, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '893055618', 2022, 3, 871.615890755859, 4161.06778157526, 500, 16, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '875340822', 2022, 3, 839.17527885874, 6525.21801764396, 500, 19, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '818463756', 2022, 3, 155.392166726972, 4105.99220438402, 500, 8, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '884152302', 2022, 3, 887.070622102153, 998.507626332581, 500, 7, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '849742742', 2022, 3, 40.5517887301036, 6773.86353397805, 500, 8, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '804979817', 2022, 3, 387.841617419046, 2107.83917463871, 500, 9, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '814190896', 2022, 3, 955.438317129304, 7837.74754356034, 500, 7, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '822331640', 2022, 3, 180.254312673543, 7655.31718914746, 500, 2, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '862678317', 2022, 3, 989.131823898031, 6139.95205651381, 500, 3, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '831093023', 2022, 3, 853.597358424314, 2834.38316347382, 500, 6, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '874226454', 2022, 3, 267.514046850271, 2775.35098850585, 500, 10, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '832436811', 2022, 3, 204.267578927205, 49.0721918761744, 500, 19, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '838432048', 2022, 3, 568.546925104339, 7975.34469523689, 500, 19, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '870022919', 2022, 3, 201.031742917511, 9856.66792398258, 500, 15, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '879268334', 2022, 3, 767.608480353077, 9847.14706958844, 500, 5, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '806599852', 2022, 3, 349.471627758071, 1997.34000124855, 500, 3, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '863181199', 2022, 3, 61.9124498437328, 3514.62865456759, 500, 11, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '863767568', 2022, 3, 492.637428480161, 8877.80368688552, 500, 16, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '844014636', 2022, 3, 515.770476801796, 1215.60367947298, 500, 18, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '866404710', 2022, 3, 168.17066679788, 1941.068968937, 500, 7, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '833129946', 2022, 3, 94.9097940381772, 9522.65080363375, 500, 19, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '846977998', 2022, 3, 55.1641160773908, 4423.57534399189, 500, 6, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '811030348', 2022, 3, 547.91683062231, 549.633316123116, 500, 3, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '890815907', 2022, 3, 827.574292910424, 4916.16187378295, 500, 2, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '822694021', 2022, 3, 245.241294209408, 1301.33064442477, 500, 19, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '852558904', 2022, 3, 70.2834527812173, 7214.43201125494, 500, 3, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '822874914', 2022, 3, 329.326112391785, 4576.02831625812, 500, 9, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '866646453', 2022, 3, 271.295275473971, 6833.12036850345, 500, 18, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '881021956', 2022, 3, 10.189506914127, 660.933373916624, 500, 1, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '899291735', 2022, 3, 24.0762593647857, 4576.58589044399, 500, 7, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '867918928', 2022, 3, 20.7625667371754, 9153.95009508408, 500, 10, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '823439458', 2022, 3, 240.078141563517, 125.534063715015, 500, 18, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '837805347', 2022, 3, 505.062922905934, 266.531287833418, 500, 6, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '805499088', 2022, 3, 860.196516405577, 6923.74127452954, 500, 10, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '845822610', 2022, 3, 578.800694586348, 6969.68753313692, 500, 17, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '841405633', 2022, 3, 653.305562006648, 300.741474373531, 500, 8, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '889675608', 2022, 3, 423.642655480376, 8159.53780221801, 500, 16, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '899025387', 2022, 3, 125.04010628776, 430.865832862644, 500, 4, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '863280835', 2022, 3, 741.97404584455, 7517.51555391271, 500, 10, false, '2022-12-05 10:42:56.958189', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '860629673', 2022, 3, 878.650649939402, 959.132841389267, 500, 5, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '833667497', 2022, 3, 657.691530292496, 3357.82833286723, 500, 13, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '842471044', 2022, 3, 77.5785812816389, 3731.00584628077, 500, 6, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '861459803', 2022, 3, 92.3650285732615, 5571.08942298991, 500, 8, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '812926032', 2022, 3, 771.482184717629, 7188.0353004881, 500, 2, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '871631319', 2022, 3, 240.95505948166, 3357.3120466863, 500, 11, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '865439281', 2022, 3, 352.785806128499, 9562.24965430978, 500, 1, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '824210548', 2022, 3, 477.395404026888, 5767.87890616113, 500, 14, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '805486005', 2022, 3, 332.95991289117, 7547.53955905571, 500, 19, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '832448472', 2022, 3, 434.048931860367, 9836.75324752651, 500, 2, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '805820685', 2022, 3, 843.291532598145, 7940.2444026333, 500, 3, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '883768894', 2022, 3, 746.668070046622, 3242.34939743198, 500, 10, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '856903021', 2022, 3, 604.224213684935, 5830.00645131842, 500, 10, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '850012745', 2022, 3, 879.292341686924, 2330.72945473188, 500, 18, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '820149848', 2022, 3, 916.078429921429, 4148.20152708615, 500, 18, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '822705108', 2022, 3, 269.788980676279, 2786.65176485577, 500, 11, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '857573851', 2022, 3, 365.666135901379, 1316.9278227338, 500, 19, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '856078198', 2022, 3, 475.42739074653, 7068.24181025749, 500, 17, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '859225721', 2022, 3, 74.3218611928466, 2645.90079053853, 500, 17, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '873879874', 2022, 3, 59.9670506892795, 1348.35177399937, 500, 8, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '890065285', 2022, 3, 187.824744449677, 4004.30048974752, 500, 8, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '893423280', 2022, 3, 633.379327723005, 4848.18410389865, 500, 17, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '816273126', 2022, 3, 918.101963734515, 9220.16098343167, 500, 9, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '874977909', 2022, 3, 37.1186777409521, 8882.16683921211, 500, 3, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '888632161', 2022, 3, 269.334640575181, 8345.03977386934, 500, 8, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '852452427', 2022, 3, 769.199669837835, 5187.96656446689, 500, 1, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '807389236', 2022, 3, 906.517824339593, 7744.69295443274, 500, 14, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '833163111', 2022, 3, 161.227098760648, 946.855609786253, 500, 1, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '813080832', 2022, 3, 960.836190747095, 7336.17389877625, 500, 10, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '896489260', 2022, 3, 874.870415936339, 3262.34609268625, 500, 11, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '845881839', 2022, 3, 292.926172683098, 45.0302729408038, 500, 15, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '898157169', 2022, 3, 252.956258623253, 1532.93578514343, 500, 14, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '882940656', 2022, 3, 925.390482174416, 3990.52669285336, 500, 9, false, '2022-12-05 10:42:57.21877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '887589106', 2022, 3, 510.884243483956, 4067.29303136487, 500, 1, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '856439808', 2022, 3, 163.246098532892, 5407.82525524393, 500, 12, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '869911712', 2022, 3, 347.599580554409, 6798.0931153864, 500, 15, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '836420677', 2022, 3, 528.302954210336, 3496.22421703742, 500, 2, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '810521018', 2022, 3, 905.119541497926, 334.195799105467, 500, 15, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '863021621', 2022, 3, 611.822724396654, 9315.62382381299, 500, 16, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '846289494', 2022, 3, 553.768308928343, 9246.01048746831, 500, 15, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '834191416', 2022, 3, 541.621322681167, 5858.11486295986, 500, 4, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '837420340', 2022, 3, 160.816532753933, 9954.94793340408, 500, 4, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '871949311', 2022, 3, 220.78173637322, 4251.70935535591, 500, 16, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '821633142', 2022, 3, 698.755798982223, 6424.42446777665, 500, 13, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '893463166', 2022, 3, 183.474874502553, 200.548993739936, 500, 18, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '833218825', 2022, 3, 176.51154364621, 2247.61689083347, 500, 10, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '807456455', 2022, 3, 390.681313746014, 3967.22305727176, 500, 9, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '821381486', 2022, 3, 982.796929300586, 5391.24094036125, 500, 19, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '814324199', 2022, 3, 185.132464120123, 6616.91724064428, 500, 6, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '805904949', 2022, 3, 197.471929589029, 1880.23916452023, 500, 14, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '813242515', 2022, 3, 499.826101446524, 5105.99320192289, 500, 18, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '839415843', 2022, 3, 283.382169600664, 7691.90569257323, 500, 8, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '804234371', 2022, 3, 881.238205045316, 2384.5077281242, 500, 20, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '816585946', 2022, 3, 610.268241303478, 8996.08412528799, 500, 18, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '824097835', 2022, 3, 487.67658665056, 4886.23198118888, 500, 3, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '880538674', 2022, 3, 888.434141905178, 9208.28637760105, 500, 16, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '875775705', 2022, 3, 827.356638178176, 1752.65683429192, 500, 2, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '877421692', 2022, 3, 909.269722739448, 8.26902356119417, 500, 15, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '871547736', 2022, 3, 874.19533490715, 4445.43714120178, 500, 1, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '857653378', 2022, 3, 232.527621209957, 3002.15573324514, 500, 9, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '829980700', 2022, 3, 796.355978415578, 3479.70028230336, 500, 9, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '852627790', 2022, 3, 719.354317810857, 1325.49648717369, 500, 15, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '865978526', 2022, 3, 531.23717508896, 778.875554067024, 500, 2, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '840145629', 2022, 3, 406.644179295965, 2201.99247006394, 500, 13, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '875016141', 2022, 3, 969.390813626987, 1151.87381414685, 500, 11, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '869419134', 2022, 3, 573.277291701469, 9420.43781294223, 500, 4, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '813944600', 2022, 3, 198.123356615528, 8712.57220545685, 500, 17, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '885600454', 2022, 3, 631.397113325829, 9375.96849417847, 500, 12, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '877550656', 2022, 3, 395.464000419685, 1432.26081692811, 500, 18, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '804227830', 2022, 3, 214.249985659152, 3036.82257270133, 500, 17, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '858956619', 2022, 3, 302.193060268317, 71.9735226729415, 500, 3, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '865153645', 2022, 3, 621.636278299514, 5517.76676706049, 500, 14, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '817941723', 2022, 3, 828.762399294105, 6283.85391130941, 500, 4, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '811667993', 2022, 3, 455.65650284401, 8981.67713669776, 500, 1, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '859462534', 2022, 3, 349.104505515716, 5541.78238234476, 500, 2, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '822317092', 2022, 3, 620.838265340012, 7982.65440943172, 500, 2, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '877772835', 2022, 3, 43.0684618994301, 6953.41317123117, 500, 1, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '846495295', 2022, 3, 259.41269701082, 1381.57166449449, 500, 10, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '804775869', 2022, 3, 990.808129465491, 6199.68660776788, 500, 4, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '831030012', 2022, 3, 185.662480737286, 1334.56253608982, 500, 4, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '802809462', 2022, 3, 332.594361172, 6515.48256145116, 500, 16, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '896200151', 2022, 3, 288.252766076277, 4681.0331799749, 500, 5, false, '2022-12-05 10:42:57.391485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '873610100', 2022, 3, 655.282209518804, 6392.59754611213, 500, 19, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '847931581', 2022, 3, 184.932368037195, 665.124955420069, 500, 9, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '870810427', 2022, 3, 512.156117559399, 1604.42579463882, 500, 4, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '816457914', 2022, 3, 844.176815657373, 506.785408053248, 500, 8, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '816760477', 2022, 3, 681.602334968172, 6136.51145173513, 500, 8, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '821449527', 2022, 3, 853.123497111219, 4324.31257074738, 500, 7, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '897412997', 2022, 3, 539.035945631699, 6641.00997799906, 500, 3, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '801856356', 2022, 3, 65.5838785323259, 8808.35675713779, 500, 5, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '898170941', 2022, 3, 97.0636318174998, 8759.70355605598, 500, 5, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '884390144', 2022, 3, 824.297465511264, 8427.95312080857, 500, 17, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '894424841', 2022, 3, 428.485415801797, 9611.58369761575, 500, 4, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '828972512', 2022, 3, 874.653155475212, 4976.99567176787, 500, 8, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '815082581', 2022, 3, 415.223679660969, 1459.46497891066, 500, 7, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '887159012', 2022, 3, 725.770763159484, 3594.34051527546, 500, 5, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '829493874', 2022, 3, 368.665581714208, 195.666918104692, 500, 6, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '814929193', 2022, 3, 397.316497312911, 9424.624203392, 500, 7, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '859907302', 2022, 3, 731.842036092013, 3621.05913009418, 500, 7, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '895124699', 2022, 3, 194.579176024511, 9992.89976495013, 500, 19, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '813239227', 2022, 3, 349.30793831149, 9864.33242645944, 500, 5, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '840430296', 2022, 3, 124.542969952585, 1309.45543652725, 500, 2, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '858726639', 2022, 3, 683.992337060954, 1585.69406169495, 500, 3, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '823234800', 2022, 3, 776.587034365837, 568.058722254767, 500, 19, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '874361830', 2022, 3, 43.4190292140213, 5345.00984792032, 500, 9, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '808481735', 2022, 3, 238.169166327083, 7061.52726965286, 500, 6, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '860499175', 2022, 3, 91.8509616991267, 7781.3052643416, 500, 2, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '892697142', 2022, 3, 277.516896294963, 483.383807045507, 500, 12, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '826727890', 2022, 3, 7.751976447386, 6617.84337611619, 500, 5, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '895582762', 2022, 3, 842.934333329334, 314.096393510483, 500, 15, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '814663914', 2022, 3, 104.4822019005, 9530.54028642358, 500, 6, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '887191975', 2022, 3, 697.465807313688, 7160.46282464153, 500, 13, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '856729012', 2022, 3, 271.851378484209, 4794.61963056469, 500, 5, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '816248533', 2022, 3, 48.2875428018623, 8215.79416976847, 500, 13, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '847253663', 2022, 3, 917.451387369862, 7963.13245427878, 500, 20, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '851556995', 2022, 3, 447.81039124754, 6021.38305816914, 500, 19, false, '2022-12-05 10:42:57.613799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '897000352', 2022, 3, 813.164828045881, 1330.03701300888, 500, 18, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '891267708', 2022, 3, 375.404264612588, 2815.37826474634, 500, 13, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '868369009', 2022, 3, 321.488760580185, 3344.63529790238, 500, 12, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '836786224', 2022, 3, 354.433941422819, 3142.8633370112, 500, 19, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '800910790', 2022, 3, 480.06701182196, 9205.86225788969, 500, 4, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '847922087', 2022, 3, 909.443006212574, 2916.92143630535, 500, 12, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '882737279', 2022, 3, 85.9504095996414, 2527.99931634561, 500, 9, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '817612413', 2022, 3, 746.248140379381, 2000.81046563359, 500, 5, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '857680168', 2022, 3, 929.29627103174, 7265.56817031278, 500, 2, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '878624841', 2022, 3, 770.34009220698, 9113.96674916906, 500, 3, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '867183919', 2022, 3, 49.7659675597148, 8233.53679913559, 500, 5, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '824306551', 2022, 3, 175.677236452543, 9606.71936146004, 500, 10, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '812929350', 2022, 3, 430.31459368549, 6209.52124390007, 500, 11, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '890735735', 2022, 3, 301.043753133793, 6619.14956805349, 500, 11, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '894341616', 2022, 3, 886.11737922572, 8932.04616561992, 500, 20, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '845690609', 2022, 3, 757.539228821654, 5501.88599669819, 500, 11, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '884945724', 2022, 3, 925.438445990125, 9031.94608765818, 500, 9, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '820865124', 2022, 3, 325.119428136294, 6452.63768724536, 500, 19, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '870514368', 2022, 3, 538.066206727318, 371.918484126773, 500, 9, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '833643869', 2022, 3, 46.2309917589074, 3129.61829577929, 500, 1, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '807702188', 2022, 3, 165.00901494992, 9187.94424879352, 500, 15, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '820638689', 2022, 3, 137.34105616753, 8023.14662445193, 500, 1, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '843380901', 2022, 3, 23.5632412317585, 9246.26262541175, 500, 9, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '832951634', 2022, 3, 107.191117919931, 6503.504438684, 500, 10, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '833677243', 2022, 3, 590.255757477573, 5247.68883778187, 500, 13, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '873656323', 2022, 3, 885.824688776567, 6243.30524681956, 500, 9, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '859159231', 2022, 3, 474.657321676351, 667.772377276567, 500, 19, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '868067017', 2022, 3, 329.433611275427, 6186.01137273957, 500, 3, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '856435712', 2022, 3, 730.174490402498, 3859.56940869084, 500, 20, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '888937591', 2022, 3, 874.212384094027, 8158.37867897912, 500, 3, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '873906284', 2022, 3, 55.2245207525529, 7919.01177178076, 500, 15, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '855150484', 2022, 3, 64.1529669848622, 9061.19170738381, 500, 17, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '836365546', 2022, 3, 864.215312905699, 2265.30234463782, 500, 9, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '822564929', 2022, 3, 222.045774122934, 5873.28512795725, 500, 9, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '833204596', 2022, 3, 308.714690355448, 242.245227259752, 500, 10, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '863592645', 2022, 3, 765.225460944317, 7812.12734108915, 500, 17, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '865956727', 2022, 3, 976.86137104989, 3226.65117371347, 500, 12, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '807629933', 2022, 3, 990.053554149879, 3654.36608890285, 500, 14, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '832454631', 2022, 3, 974.713242301613, 7254.05717772301, 500, 5, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '823356725', 2022, 3, 108.656043335321, 8205.62164657554, 500, 7, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '800824855', 2022, 3, 382.270059120327, 8843.60922012447, 500, 6, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '894510083', 2022, 3, 503.220500463319, 9014.42574506739, 500, 7, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '815854671', 2022, 3, 346.284181169174, 7029.9241811903, 500, 9, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '876401827', 2022, 3, 68.4615090567878, 5026.50193906141, 500, 11, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '845066027', 2022, 3, 324.080565843624, 6291.55000330138, 500, 14, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '815406101', 2022, 3, 401.326096644464, 4642.2033639526, 500, 3, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '866878310', 2022, 3, 69.7368275497916, 4008.82950521073, 500, 10, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '830803739', 2022, 3, 615.54626312, 1429.17219816082, 500, 3, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '805933483', 2022, 3, 974.466795326627, 8236.87948527692, 500, 9, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '868252144', 2022, 3, 867.465037702581, 4582.38638756645, 500, 12, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '828744326', 2022, 3, 976.018358511218, 3772.89522130383, 500, 3, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '830122600', 2022, 3, 487.847764601333, 2367.05553974608, 500, 8, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '813147327', 2022, 3, 693.129856361131, 9039.06757514102, 500, 17, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '846250295', 2022, 3, 492.233975307462, 5063.45284266988, 500, 16, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '898250721', 2022, 3, 461.186146298327, 898.403007219565, 500, 3, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '813697349', 2022, 3, 937.122997438781, 9621.27869691851, 500, 16, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '863104800', 2022, 3, 287.807944261048, 9535.83003703886, 500, 15, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '897979593', 2022, 3, 210.013681673454, 2418.00636451359, 500, 3, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '860772161', 2022, 3, 211.568010480938, 2756.66666769904, 500, 13, false, '2022-12-05 10:42:57.790795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '808002552', 2022, 3, 813.040379767714, 4326.89716130224, 500, 11, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '876394411', 2022, 3, 585.281241013985, 6389.88224369918, 500, 17, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '846214156', 2022, 3, 366.227254047111, 9357.72414727229, 500, 6, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '850015354', 2022, 3, 584.484884107408, 307.804441210466, 500, 10, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '805145991', 2022, 3, 402.942377743995, 4211.1345394836, 500, 7, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '853879838', 2022, 3, 456.6298584639, 7189.65926047863, 500, 3, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '882939801', 2022, 3, 588.676038774186, 2790.28569927354, 500, 9, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '859605190', 2022, 3, 168.933612494045, 279.612864887193, 500, 1, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '891814367', 2022, 3, 156.648537788575, 4014.69476496909, 500, 14, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '875021136', 2022, 3, 963.5077816021, 8022.90121397201, 500, 18, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '825379831', 2022, 3, 583.391581187715, 6770.40046688049, 500, 8, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '800469195', 2022, 3, 788.705688425161, 2866.30297024675, 500, 5, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '871244244', 2022, 3, 544.653686399981, 4261.90337856182, 500, 19, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '837133219', 2022, 3, 80.2341930805345, 8008.17671619511, 500, 1, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '855964219', 2022, 3, 398.782155902899, 7639.00568192425, 500, 1, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '838273484', 2022, 3, 689.791766661163, 1491.1493475381, 500, 10, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '893483616', 2022, 3, 499.920337003143, 8810.00060874641, 500, 12, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '891497759', 2022, 3, 460.639618822149, 6298.92821595054, 500, 18, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '888247901', 2022, 3, 42.5699905326931, 8784.62168081404, 500, 17, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '883590490', 2022, 3, 302.266945059994, 4787.25235642746, 500, 15, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '804908767', 2022, 3, 428.57159849533, 9371.52484363624, 500, 18, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '851919134', 2022, 3, 309.440684709028, 4979.16069847087, 500, 16, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '813682750', 2022, 3, 203.502109336712, 4978.4787466021, 500, 10, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '875544956', 2022, 3, 224.007736848018, 7727.8808423631, 500, 19, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '889472231', 2022, 3, 540.023891628924, 5293.81883233276, 500, 8, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '875631634', 2022, 3, 325.013053565316, 761.586854611059, 500, 20, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '856007783', 2022, 3, 482.706425274945, 1835.15693597304, 500, 8, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '844760467', 2022, 3, 122.779175707715, 1860.89334960296, 500, 6, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '863256691', 2022, 3, 408.124127518423, 6538.54541026549, 500, 17, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '851705582', 2022, 3, 899.654457323632, 9720.23140564815, 500, 2, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '854298834', 2022, 3, 173.685182050494, 4519.08162227157, 500, 17, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '836216435', 2022, 3, 54.3069959613586, 5587.51577255714, 500, 14, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '893017297', 2022, 3, 407.915888443244, 6668.54874746705, 500, 20, false, '2022-12-05 10:42:58.07777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '841372032', 2022, 3, 995.238051065146, 882.777985756789, 500, 11, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '862589424', 2022, 3, 147.022138474836, 1255.33629931929, 500, 5, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '871501781', 2022, 3, 753.569428632837, 7046.43606247672, 500, 1, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '880977356', 2022, 3, 61.0004890278373, 2739.28260007092, 500, 19, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '859708655', 2022, 3, 810.149201611887, 498.128335539301, 500, 5, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '837130075', 2022, 3, 860.137615622774, 6344.60749795013, 500, 7, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '803170681', 2022, 3, 583.26361263518, 3790.47844737888, 500, 4, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '875018446', 2022, 3, 938.888884103582, 3242.42743066822, 500, 17, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '872251225', 2022, 3, 443.375442280955, 1468.0606078798, 500, 11, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '889927472', 2022, 3, 260.554387929899, 8955.78978751233, 500, 1, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '850310272', 2022, 3, 527.830796723896, 4504.53958094792, 500, 19, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '878277970', 2022, 3, 405.83382969744, 3100.15652907372, 500, 20, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '811324382', 2022, 3, 159.009247082517, 3643.51355394219, 500, 3, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '878265174', 2022, 3, 650.617527260064, 878.14465244471, 500, 2, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '803799726', 2022, 3, 208.29370326704, 3392.281093843, 500, 17, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '827344157', 2022, 3, 24.0252391341408, 7970.09625370604, 500, 18, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '868610918', 2022, 3, 564.179372982821, 2587.53880841903, 500, 18, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '891144647', 2022, 3, 958.08860516254, 3012.65131045483, 500, 20, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '874750888', 2022, 3, 34.9205079842816, 5994.04945195493, 500, 1, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '879572863', 2022, 3, 109.375806450177, 9453.53515617348, 500, 20, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '816719384', 2022, 3, 406.401571966443, 933.384847032294, 500, 3, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '823372812', 2022, 3, 834.424719451788, 8166.1419864997, 500, 1, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '872671153', 2022, 3, 337.326158152897, 556.45639877093, 500, 4, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '837782686', 2022, 3, 236.899292152416, 2434.71125892135, 500, 3, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '856373244', 2022, 3, 884.027276234052, 9261.68986699028, 500, 20, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '802319687', 2022, 3, 897.341666351395, 159.383765624841, 500, 14, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '882221112', 2022, 3, 891.03382125398, 1380.64233149674, 500, 3, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '825823538', 2022, 3, 433.5524028053, 7743.35588788984, 500, 11, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '840744367', 2022, 3, 920.29341811652, 8866.65741987201, 500, 4, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '807485242', 2022, 3, 988.606628647634, 7310.86797284707, 500, 8, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '878321914', 2022, 3, 99.2411002545063, 6709.5614092684, 500, 11, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '886892017', 2022, 3, 470.254194991875, 8180.62500773342, 500, 15, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '871623349', 2022, 3, 405.73395804958, 9959.46989702065, 500, 12, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '864986459', 2022, 3, 911.17153404061, 459.426014288514, 500, 16, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '849227492', 2022, 3, 158.479928079961, 4761.93026753749, 500, 17, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '850910144', 2022, 3, 165.836028660981, 3874.51943023948, 500, 13, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '869658223', 2022, 3, 359.894769478828, 7139.56150979653, 500, 2, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '866431270', 2022, 3, 841.66432503579, 3650.79688399931, 500, 3, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '858356342', 2022, 3, 701.446609444421, 5990.45588217906, 500, 9, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '852467356', 2022, 3, 27.2437402104324, 9896.55925834339, 500, 2, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '898657961', 2022, 3, 955.32210109218, 5593.31539636119, 500, 15, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '846849579', 2022, 3, 515.521490800843, 1047.99548208559, 500, 4, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '873579899', 2022, 3, 90.3337028261372, 9031.9699787671, 500, 7, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '843035298', 2022, 3, 412.20133921242, 1234.88519348482, 500, 13, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '858836952', 2022, 3, 378.831245178255, 3102.74683904812, 500, 9, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '805709917', 2022, 3, 646.811307278992, 498.501820669752, 500, 13, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '808479485', 2022, 3, 218.563488449547, 3954.40691923848, 500, 15, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '838878962', 2022, 3, 352.607958602275, 1111.30089995564, 500, 2, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '885625328', 2022, 3, 520.669197850047, 2461.75388151989, 500, 19, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '837527996', 2022, 3, 765.828050523237, 1433.31818697245, 500, 3, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '844848494', 2022, 3, 391.807889880667, 1835.66901523663, 500, 1, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '825573136', 2022, 3, 147.364947987609, 8973.22059914468, 500, 4, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '809036318', 2022, 3, 841.937541499201, 6351.20429851037, 500, 6, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '800223332', 2022, 3, 525.413364562306, 7149.45032487511, 500, 8, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '878112453', 2022, 3, 871.45101810932, 9599.52142821318, 500, 9, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '893781546', 2022, 3, 79.9216927998106, 2159.79749586887, 500, 20, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '818658010', 2022, 3, 154.796314258447, 2174.36826781023, 500, 1, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '862270603', 2022, 3, 703.07743143334, 5221.19697376643, 500, 14, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '812325897', 2022, 3, 556.38685211799, 9789.29013990651, 500, 13, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '817554736', 2022, 3, 274.833796857117, 9397.08920841531, 500, 19, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '884291457', 2022, 3, 121.352730232061, 2488.94578609142, 500, 12, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '890910485', 2022, 3, 773.622260946003, 7620.84945511635, 500, 3, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '810677960', 2022, 3, 342.719911483617, 9130.15730423971, 500, 11, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '830621787', 2022, 3, 528.285751338302, 1943.506780185, 500, 17, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '874792210', 2022, 3, 656.744549840249, 6532.15539034358, 500, 7, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '828718942', 2022, 3, 725.513600487779, 5349.56367882374, 500, 16, false, '2022-12-05 10:42:58.228161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '846277869', 2022, 3, 41.9949355323077, 258.964131549818, 500, 4, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '809316543', 2022, 3, 366.62858913087, 6024.88616460637, 500, 2, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '846821438', 2022, 3, 893.597068140596, 8705.90458092763, 500, 3, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '836005340', 2022, 3, 577.228114495556, 3389.10176172667, 500, 2, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '869069081', 2022, 3, 768.062827778927, 8704.1027748533, 500, 7, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '824870495', 2022, 3, 73.6013850872839, 2912.75024645671, 500, 10, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '821850314', 2022, 3, 190.710369568469, 8170.6775551927, 500, 7, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '895629317', 2022, 3, 405.59170774877, 1104.56938987583, 500, 19, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '854843256', 2022, 3, 32.6554807656206, 5051.92962981132, 500, 13, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '825397589', 2022, 3, 802.223928831735, 6631.40399604967, 500, 12, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '856901774', 2022, 3, 234.108607022901, 3045.91466226533, 500, 10, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '886566656', 2022, 3, 118.430826510502, 7167.06289252262, 500, 4, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '868634250', 2022, 3, 385.903606076005, 1772.11408069709, 500, 2, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '827178297', 2022, 3, 340.479588118368, 5698.79173337186, 500, 12, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '889901026', 2022, 3, 182.010409357878, 1758.7739541495, 500, 19, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '860932226', 2022, 3, 817.439551263567, 6540.83542830354, 500, 20, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '883640440', 2022, 3, 938.103432859113, 4938.64416253414, 500, 17, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '899511765', 2022, 3, 215.432702267498, 6383.33091284, 500, 11, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '826671551', 2022, 3, 451.159701072738, 5332.22881525061, 500, 9, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '838991015', 2022, 3, 894.834770860371, 2608.33391432613, 500, 13, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '831768843', 2022, 3, 244.891940342311, 5846.90504300353, 500, 18, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '803324193', 2022, 3, 761.13045823642, 4312.57286782167, 500, 17, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '827269180', 2022, 3, 117.756967129985, 4281.20288705358, 500, 13, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '806938796', 2022, 3, 428.401580793409, 9281.80151833857, 500, 14, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '817130185', 2022, 3, 153.436626792366, 1174.36923207574, 500, 13, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '810402680', 2022, 3, 292.136405599259, 6496.57818295849, 500, 15, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '887841956', 2022, 3, 446.921171191264, 2815.70094624347, 500, 4, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '897336611', 2022, 3, 137.110484417703, 2623.29036404851, 500, 2, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '858728795', 2022, 3, 936.576161165276, 8230.96776360259, 500, 6, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '880050743', 2022, 3, 622.492621641358, 4893.31656244515, 500, 16, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '871161662', 2022, 3, 948.824717010229, 9499.1107595604, 500, 14, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '862924848', 2022, 3, 74.8650521578661, 49.0022394238522, 500, 1, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '895031114', 2022, 3, 84.4132921755645, 6058.78939929326, 500, 3, false, '2022-12-05 10:42:58.521442', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '815517829', 2022, 3, 259.94914768265, 9753.39249097198, 500, 8, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '836666246', 2022, 3, 705.015670600143, 5267.68569394228, 500, 8, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '845715533', 2022, 3, 60.1373129620332, 1520.7837087449, 500, 16, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '897156462', 2022, 3, 192.473681124966, 4802.03138301885, 500, 7, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '890815244', 2022, 3, 699.943077957245, 3236.08179540181, 500, 1, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '866562589', 2022, 3, 122.145841533344, 2083.26442547051, 500, 3, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '875322390', 2022, 3, 477.295330175527, 2776.17395805639, 500, 12, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '870376312', 2022, 3, 713.994654017075, 4384.46738307762, 500, 10, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '863074238', 2022, 3, 59.0578585531632, 581.035120669152, 500, 6, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '873535604', 2022, 3, 685.352794003071, 929.330422737142, 500, 19, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '820029647', 2022, 3, 873.98423971651, 1933.78907735103, 500, 18, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '825514130', 2022, 3, 178.258763070628, 5183.46413190183, 500, 2, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '815801592', 2022, 3, 601.598217409212, 9448.66976543331, 500, 17, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '839528084', 2022, 3, 205.930310054256, 598.642508333722, 500, 4, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '864571830', 2022, 3, 859.385906738939, 8176.25459867593, 500, 12, false, '2022-12-05 10:42:58.643058', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '883989256', 2022, 3, 825.556153373013, 6341.20844262028, 500, 5, false, '2022-12-05 10:43:01.692503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '831272011', 2022, 3, 805.244460500552, 923.121749334804, 500, 17, false, '2022-12-05 10:43:01.716182', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '831658088', 2022, 3, 45.0397325660894, 709.195849107258, 500, 9, false, '2022-12-05 10:43:01.738881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '802008121', 2022, 3, 558.598229391699, 645.549536580495, 500, 13, false, '2022-12-05 10:43:01.738881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '857721878', 2022, 3, 488.678566614643, 3717.07663809845, 500, 14, false, '2022-12-05 10:43:01.738881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '811747377', 2022, 3, 975.034985998941, 8450.3000303575, 500, 19, false, '2022-12-05 10:43:01.738881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '801396893', 2022, 3, 324.015045181318, 9762.76751344184, 500, 5, false, '2022-12-05 10:43:01.780341', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '885133950', 2022, 3, 617.009206442011, 9875.14333973524, 500, 7, false, '2022-12-05 10:43:01.780341', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '864761302', 2022, 3, 921.802832349401, 8656.63047509325, 500, 19, false, '2022-12-05 10:43:01.780341', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '870050263', 2022, 3, 554.172989104294, 8115.23903246291, 500, 4, false, '2022-12-05 10:43:01.780341', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '881536611', 2022, 3, 655.874974546484, 8381.80696226399, 500, 14, false, '2022-12-05 10:43:01.817307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '862811969', 2022, 3, 162.054365157738, 6896.42057036105, 500, 8, false, '2022-12-05 10:43:01.817307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '892708443', 2022, 3, 972.414589110301, 5851.46877470491, 500, 2, false, '2022-12-05 10:43:01.817307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '866931781', 2022, 3, 504.381305616905, 8546.83195158219, 500, 18, false, '2022-12-05 10:43:01.817307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '868378133', 2022, 3, 413.580502217633, 8135.61786699797, 500, 8, false, '2022-12-05 10:43:01.817307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '872308278', 2022, 3, 673.410235672737, 2966.57511414481, 500, 6, false, '2022-12-05 10:43:01.862091', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '854032309', 2022, 3, 659.350594147472, 3274.51750286338, 500, 8, false, '2022-12-05 10:43:01.862091', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '842782667', 2022, 3, 168.556243855073, 7398.86517039878, 500, 1, false, '2022-12-05 10:43:01.862091', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (533, '846058502', 2022, 3, 584.677977108953, 4208.14214639256, 500, 3, false, '2022-12-05 10:43:06.197956', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (534, '878151780', 2022, 3, 465.153686952603, 9289.47571597349, 500, 11, false, '2022-12-05 10:43:06.212004', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (535, '878151780', 2022, 2, 465.153686952603, 9289.47571597349, 500, 11, false, '2022-12-05 10:43:06.226877', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 5471.48283213096, 500, 59, false, 0, '[]', '2022-12-05 10:42:58.760298');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 3541.20694160976, 500, 57, false, 0, '[]', '2022-12-05 10:42:58.760298');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '555555555', 1489.24791400852, 500, 69, false, 0, '[]', '2022-12-05 10:42:58.760298');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '881532376', 621.173526966986, 500, 56, false, 0, '[]', '2022-12-05 10:42:58.785198');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '883874352', 9456.75807865886, 500, 56, false, 0, '[]', '2022-12-05 10:42:58.79872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '848147638', 2175.37347737687, 500, 56, false, 0, '[]', '2022-12-05 10:42:58.79872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '876763949', 7501.9894535084, 500, 51, false, 0, '[]', '2022-12-05 10:42:58.79872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '871871807', 4759.62091271058, 500, 64, false, 0, '[]', '2022-12-05 10:42:58.79872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '864079801', 6787.04136535292, 500, 57, false, 0, '[]', '2022-12-05 10:42:58.813252');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '836041617', 3756.8825870314, 500, 63, false, 0, '[]', '2022-12-05 10:42:58.813252');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '857842260', 4998.01993338812, 500, 58, false, 0, '[]', '2022-12-05 10:42:58.824578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '885073621', 8750.81862174338, 500, 69, false, 0, '[]', '2022-12-05 10:42:58.824578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '864754605', 8954.20764127112, 500, 65, false, 0, '[]', '2022-12-05 10:42:58.834174');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '846347581', 4492.98325592836, 500, 70, false, 0, '[]', '2022-12-05 10:42:58.834174');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '824680794', 2919.0100101838, 500, 59, false, 0, '[]', '2022-12-05 10:42:58.849221');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '839415001', 821.486343168438, 500, 64, false, 0, '[]', '2022-12-05 10:42:58.868723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '861744528', 4088.18593505123, 500, 53, false, 0, '[]', '2022-12-05 10:42:58.868723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '860138909', 664.060283534183, 500, 65, false, 0, '[]', '2022-12-05 10:42:58.88075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '843242104', 5462.25156082903, 500, 58, false, 0, '[]', '2022-12-05 10:42:58.88075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '890093850', 8372.79190885587, 500, 69, false, 0, '[]', '2022-12-05 10:42:58.88075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '892511017', 3972.85040841671, 500, 63, false, 0, '[]', '2022-12-05 10:42:58.893669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '842605109', 350.328575089571, 500, 54, false, 0, '[]', '2022-12-05 10:42:58.893669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '870491047', 2760.95655147445, 500, 54, false, 0, '[]', '2022-12-05 10:42:58.893669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '863507760', 9353.1383306312, 500, 64, false, 0, '[]', '2022-12-05 10:42:58.893669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '817257908', 4419.88883419615, 500, 70, false, 0, '[]', '2022-12-05 10:42:58.903759');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '809042383', 4061.58426210254, 500, 70, false, 0, '[]', '2022-12-05 10:42:58.903759');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '810734693', 5098.30926397023, 500, 55, false, 0, '[]', '2022-12-05 10:42:58.903759');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '804629062', 2590.35899055835, 500, 68, false, 0, '[]', '2022-12-05 10:42:58.912702');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '873621335', 5946.65718700388, 500, 54, false, 0, '[]', '2022-12-05 10:42:58.912702');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '835058832', 4236.66058490336, 500, 63, false, 0, '[]', '2022-12-05 10:42:58.912702');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '803826652', 4556.44393109249, 500, 52, false, 0, '[]', '2022-12-05 10:42:58.924747');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '874394467', 2785.25355286158, 500, 70, false, 0, '[]', '2022-12-05 10:42:58.924747');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '838903289', 1949.10440474138, 500, 70, false, 0, '[]', '2022-12-05 10:42:58.924747');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '882051647', 5689.35663780786, 500, 52, false, 0, '[]', '2022-12-05 10:42:58.934537');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '879681201', 2615.90104777218, 500, 58, false, 0, '[]', '2022-12-05 10:42:58.934537');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '852409131', 1004.2205954351, 500, 68, false, 0, '[]', '2022-12-05 10:42:58.934537');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '808215075', 9503.78557576979, 500, 52, false, 0, '[]', '2022-12-05 10:42:58.944567');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '865074415', 4771.00172739768, 500, 70, false, 0, '[]', '2022-12-05 10:42:58.944567');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '836669149', 1575.77615177134, 500, 53, false, 0, '[]', '2022-12-05 10:42:58.944567');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '884369776', 2516.96687622528, 500, 65, false, 0, '[]', '2022-12-05 10:42:58.956665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '873418367', 6157.52284859248, 500, 59, false, 0, '[]', '2022-12-05 10:42:58.956665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '802905016', 6076.63807999529, 500, 53, false, 0, '[]', '2022-12-05 10:42:58.964805');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '885609899', 1824.94301960841, 500, 67, false, 0, '[]', '2022-12-05 10:42:58.964805');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '860836918', 4058.71074465806, 500, 53, false, 0, '[]', '2022-12-05 10:42:58.964805');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '829745509', 207.604446663122, 500, 51, false, 0, '[]', '2022-12-05 10:42:58.971808');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '844246611', 437.522179372899, 500, 51, false, 0, '[]', '2022-12-05 10:42:58.971808');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '867216743', 5954.91687770568, 500, 57, false, 0, '[]', '2022-12-05 10:42:58.984289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '890941228', 5048.35714114067, 500, 66, false, 0, '[]', '2022-12-05 10:42:58.9918');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '838540049', 3576.3120758413, 500, 66, false, 0, '[]', '2022-12-05 10:42:58.9918');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '809501750', 6244.29912773032, 500, 70, false, 0, '[]', '2022-12-05 10:42:59.001547');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '844496478', 5328.85808319286, 500, 70, false, 0, '[]', '2022-12-05 10:42:59.001547');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '863501025', 1356.54419842431, 500, 66, false, 0, '[]', '2022-12-05 10:42:59.001547');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '839166324', 8424.9040477056, 500, 58, false, 0, '[]', '2022-12-05 10:42:59.010479');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '879962157', 4902.26698844878, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.010479');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '848543645', 1116.52509110386, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.010479');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '880279851', 7297.81756770441, 500, 62, false, 0, '[]', '2022-12-05 10:42:59.021741');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '808671188', 2817.68098625638, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.021741');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '851333885', 6386.25948747084, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.028734');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '815366017', 8246.79526449683, 500, 57, false, 0, '[]', '2022-12-05 10:42:59.036422');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '891113900', 4625.68434518162, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.036422');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '894926128', 9593.24854198427, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.036422');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '802290404', 44.2160265052829, 500, 58, false, 0, '[]', '2022-12-05 10:42:59.044317');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '896239097', 1158.8428289974, 500, 67, false, 0, '[]', '2022-12-05 10:42:59.044317');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '816868949', 5434.56618946473, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.053977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '895298219', 305.267561978005, 500, 57, false, 0, '[]', '2022-12-05 10:42:59.053977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '842893897', 7985.42010223819, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.067322');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '814670938', 7472.73717666649, 500, 53, false, 0, '[]', '2022-12-05 10:42:59.067322');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '820433803', 3952.19228420451, 500, 51, false, 0, '[]', '2022-12-05 10:42:59.082096');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '874104569', 2149.00465665943, 500, 57, false, 0, '[]', '2022-12-05 10:42:59.082096');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '856520283', 2175.23061541612, 500, 65, false, 0, '[]', '2022-12-05 10:42:59.082096');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '879090305', 9821.56623045451, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.082096');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '809468321', 5737.54017690457, 500, 63, false, 0, '[]', '2022-12-05 10:42:59.102497');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '826378947', 8385.25176519625, 500, 57, false, 0, '[]', '2022-12-05 10:42:59.102497');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '866390365', 5711.12588279609, 500, 55, false, 0, '[]', '2022-12-05 10:42:59.115017');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '862771013', 6769.22094888337, 500, 58, false, 0, '[]', '2022-12-05 10:42:59.115017');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '864363318', 4953.12412206676, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.123925');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '896438075', 1467.07184058369, 500, 62, false, 0, '[]', '2022-12-05 10:42:59.123925');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '829368106', 7929.8407446665, 500, 56, false, 0, '[]', '2022-12-05 10:42:59.137874');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '867407313', 8703.82246491887, 500, 55, false, 0, '[]', '2022-12-05 10:42:59.154418');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '896587504', 5072.63468868687, 500, 51, false, 0, '[]', '2022-12-05 10:42:59.154418');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '847845944', 2799.79243815745, 500, 65, false, 0, '[]', '2022-12-05 10:42:59.154418');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '826389298', 4498.44225972919, 500, 55, false, 0, '[]', '2022-12-05 10:42:59.167205');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '848399886', 8387.0864873234, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.167205');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '854846835', 4126.09388148005, 500, 61, false, 0, '[]', '2022-12-05 10:42:59.17946');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '800634899', 9608.46265866485, 500, 57, false, 0, '[]', '2022-12-05 10:42:59.17946');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '857110616', 7594.40310441572, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.190867');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '808271586', 6026.10919846057, 500, 65, false, 0, '[]', '2022-12-05 10:42:59.19875');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '819801010', 7760.3361688454, 500, 61, false, 0, '[]', '2022-12-05 10:42:59.19875');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '848578637', 2639.9949394004, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.209459');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '827490752', 6240.45540068695, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.216832');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '835736810', 49.2966877278199, 500, 67, false, 0, '[]', '2022-12-05 10:42:59.216832');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '857544475', 4897.26410154236, 500, 66, false, 0, '[]', '2022-12-05 10:42:59.222678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '847721823', 9105.17574025612, 500, 51, false, 0, '[]', '2022-12-05 10:42:59.222678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '862581603', 783.123160904308, 500, 58, false, 0, '[]', '2022-12-05 10:42:59.235852');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '810313500', 3916.80866084549, 500, 62, false, 0, '[]', '2022-12-05 10:42:59.254094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '885129733', 8462.06447015175, 500, 65, false, 0, '[]', '2022-12-05 10:42:59.262228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '898243796', 3675.32998792617, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.262228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '887079787', 4961.94897411307, 500, 62, false, 0, '[]', '2022-12-05 10:42:59.262228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '861058672', 9129.84702940054, 500, 56, false, 0, '[]', '2022-12-05 10:42:59.262228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '876537913', 7559.39156206232, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.277879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '890597928', 4358.50117464015, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.28799');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '842982051', 6499.03627181771, 500, 66, false, 0, '[]', '2022-12-05 10:42:59.28799');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '842389667', 8773.1009172127, 500, 65, false, 0, '[]', '2022-12-05 10:42:59.28799');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '820004072', 5686.31086362843, 500, 61, false, 0, '[]', '2022-12-05 10:42:59.299319');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '897688257', 8267.03087001752, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.299319');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '837534390', 2653.66828314559, 500, 51, false, 0, '[]', '2022-12-05 10:42:59.309433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '808543637', 8963.59989120904, 500, 54, false, 0, '[]', '2022-12-05 10:42:59.309433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '870201888', 1200.42844232253, 500, 53, false, 0, '[]', '2022-12-05 10:42:59.322016');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '817311070', 9151.66955314209, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.322016');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '868012776', 3020.98730895796, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.333337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '896429753', 8777.34742327567, 500, 67, false, 0, '[]', '2022-12-05 10:42:59.333337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '851603425', 3271.41970640124, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.346328');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '827443317', 3435.92015420002, 500, 51, false, 0, '[]', '2022-12-05 10:42:59.365084');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '833362642', 1558.69908107029, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.365084');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '882069408', 974.592392034204, 500, 57, false, 0, '[]', '2022-12-05 10:42:59.379746');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '863878944', 1806.56177443046, 500, 63, false, 0, '[]', '2022-12-05 10:42:59.379746');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '866558221', 9976.06112390243, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.379746');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '868767855', 5465.75452150936, 500, 57, false, 0, '[]', '2022-12-05 10:42:59.379746');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '875885300', 2459.44870127098, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.393958');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '842216735', 3418.20826583983, 500, 56, false, 0, '[]', '2022-12-05 10:42:59.401039');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '856920437', 5762.05607260234, 500, 51, false, 0, '[]', '2022-12-05 10:42:59.401039');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '830858963', 319.735871500111, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.401039');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '812434114', 3289.95022054221, 500, 55, false, 0, '[]', '2022-12-05 10:42:59.41092');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '847041353', 8572.35354296723, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.420148');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '803269327', 4063.01581652227, 500, 70, false, 0, '[]', '2022-12-05 10:42:59.429401');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '843457384', 6563.51667275102, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.429401');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '818306281', 3768.86172184697, 500, 54, false, 0, '[]', '2022-12-05 10:42:59.439261');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '844449510', 2877.75612330657, 500, 70, false, 0, '[]', '2022-12-05 10:42:59.439261');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '867177223', 6744.94067249012, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.452012');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '883963814', 4421.42001283242, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.452012');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '886253015', 590.983612781807, 500, 62, false, 0, '[]', '2022-12-05 10:42:59.452012');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '895281822', 3166.83960076502, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.459991');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '840533481', 619.898257937398, 500, 65, false, 0, '[]', '2022-12-05 10:42:59.471583');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '839216776', 7656.56347475349, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.471583');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '803533948', 1764.40949344221, 500, 62, false, 0, '[]', '2022-12-05 10:42:59.471583');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '827095124', 5080.90950933543, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.47945');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '808251981', 9877.11579547307, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.47945');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '817358823', 6265.78857701058, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.47945');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '871910327', 1543.92173017929, 500, 62, false, 0, '[]', '2022-12-05 10:42:59.488382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '866587133', 395.069208959843, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.488382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '842840788', 7858.30797838529, 500, 53, false, 0, '[]', '2022-12-05 10:42:59.488382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '812781923', 9040.47808609221, 500, 56, false, 0, '[]', '2022-12-05 10:42:59.500025');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '804058381', 1273.11463374731, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.509487');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '811423248', 5368.41086302948, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.509487');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '840837641', 9563.77173108771, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.516068');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '818816392', 4787.8396648172, 500, 62, false, 0, '[]', '2022-12-05 10:42:59.516068');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '806494928', 7773.31430454198, 500, 63, false, 0, '[]', '2022-12-05 10:42:59.531893');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '893055618', 4161.06778157526, 500, 66, false, 0, '[]', '2022-12-05 10:42:59.531893');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '875340822', 6525.21801764396, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.545152');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '818463756', 4105.99220438402, 500, 58, false, 0, '[]', '2022-12-05 10:42:59.545152');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '884152302', 998.507626332581, 500, 57, false, 0, '[]', '2022-12-05 10:42:59.545152');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '849742742', 6773.86353397805, 500, 58, false, 0, '[]', '2022-12-05 10:42:59.553312');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '804979817', 2107.83917463871, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.553312');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '814190896', 7837.74754356034, 500, 57, false, 0, '[]', '2022-12-05 10:42:59.553312');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '822331640', 7655.31718914746, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.564095');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '862678317', 6139.95205651381, 500, 53, false, 0, '[]', '2022-12-05 10:42:59.574639');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '831093023', 2834.38316347382, 500, 56, false, 0, '[]', '2022-12-05 10:42:59.574639');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '874226454', 2775.35098850585, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.584212');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '832436811', 49.0721918761744, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.584212');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '838432048', 7975.34469523689, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.592835');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '870022919', 9856.66792398258, 500, 65, false, 0, '[]', '2022-12-05 10:42:59.592835');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '879268334', 9847.14706958844, 500, 55, false, 0, '[]', '2022-12-05 10:42:59.601503');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '806599852', 1997.34000124855, 500, 53, false, 0, '[]', '2022-12-05 10:42:59.601503');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '863181199', 3514.62865456759, 500, 61, false, 0, '[]', '2022-12-05 10:42:59.613987');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '863767568', 8877.80368688552, 500, 66, false, 0, '[]', '2022-12-05 10:42:59.620062');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '844014636', 1215.60367947298, 500, 68, false, 0, '[]', '2022-12-05 10:42:59.620062');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '866404710', 1941.068968937, 500, 57, false, 0, '[]', '2022-12-05 10:42:59.628447');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '833129946', 9522.65080363375, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.635626');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '846977998', 4423.57534399189, 500, 56, false, 0, '[]', '2022-12-05 10:42:59.635626');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '811030348', 549.633316123116, 500, 53, false, 0, '[]', '2022-12-05 10:42:59.643406');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '890815907', 4916.16187378295, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.654285');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '822694021', 1301.33064442477, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.654285');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '852558904', 7214.43201125494, 500, 53, false, 0, '[]', '2022-12-05 10:42:59.664418');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '822874914', 4576.02831625812, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.673299');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '866646453', 6833.12036850345, 500, 68, false, 0, '[]', '2022-12-05 10:42:59.673299');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '881021956', 660.933373916624, 500, 51, false, 0, '[]', '2022-12-05 10:42:59.684646');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '899291735', 4576.58589044399, 500, 57, false, 0, '[]', '2022-12-05 10:42:59.693779');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '867918928', 9153.95009508408, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.693779');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '823439458', 125.534063715015, 500, 68, false, 0, '[]', '2022-12-05 10:42:59.702228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '837805347', 266.531287833418, 500, 56, false, 0, '[]', '2022-12-05 10:42:59.702228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '805499088', 6923.74127452954, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.710447');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '845822610', 6969.68753313692, 500, 67, false, 0, '[]', '2022-12-05 10:42:59.722601');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '841405633', 300.741474373531, 500, 58, false, 0, '[]', '2022-12-05 10:42:59.722601');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '889675608', 8159.53780221801, 500, 66, false, 0, '[]', '2022-12-05 10:42:59.733774');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '899025387', 430.865832862644, 500, 54, false, 0, '[]', '2022-12-05 10:42:59.733774');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '863280835', 7517.51555391271, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.744369');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '860629673', 959.132841389267, 500, 55, false, 0, '[]', '2022-12-05 10:42:59.756352');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '833667497', 3357.82833286723, 500, 63, false, 0, '[]', '2022-12-05 10:42:59.756352');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '842471044', 3731.00584628077, 500, 56, false, 0, '[]', '2022-12-05 10:42:59.771603');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '861459803', 5571.08942298991, 500, 58, false, 0, '[]', '2022-12-05 10:42:59.787569');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '812926032', 7188.0353004881, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.787569');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '871631319', 3357.3120466863, 500, 61, false, 0, '[]', '2022-12-05 10:42:59.787569');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '865439281', 9562.24965430978, 500, 51, false, 0, '[]', '2022-12-05 10:42:59.787569');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '824210548', 5767.87890616113, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.798935');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '805486005', 7547.53955905571, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.798935');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '832448472', 9836.75324752651, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.821578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '805820685', 7940.2444026333, 500, 53, false, 0, '[]', '2022-12-05 10:42:59.821578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '883768894', 3242.34939743198, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.821578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '856903021', 5830.00645131842, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.821578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '850012745', 2330.72945473188, 500, 68, false, 0, '[]', '2022-12-05 10:42:59.821578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '820149848', 4148.20152708615, 500, 68, false, 0, '[]', '2022-12-05 10:42:59.821578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '822705108', 2786.65176485577, 500, 61, false, 0, '[]', '2022-12-05 10:42:59.821578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '857573851', 1316.9278227338, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.821578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '856078198', 7068.24181025749, 500, 67, false, 0, '[]', '2022-12-05 10:42:59.834964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '859225721', 2645.90079053853, 500, 67, false, 0, '[]', '2022-12-05 10:42:59.843206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '873879874', 1348.35177399937, 500, 58, false, 0, '[]', '2022-12-05 10:42:59.843206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '890065285', 4004.30048974752, 500, 58, false, 0, '[]', '2022-12-05 10:42:59.843206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '893423280', 4848.18410389865, 500, 67, false, 0, '[]', '2022-12-05 10:42:59.843206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '816273126', 9220.16098343167, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.851365');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '874977909', 8882.16683921211, 500, 53, false, 0, '[]', '2022-12-05 10:42:59.851365');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '888632161', 8345.03977386934, 500, 58, false, 0, '[]', '2022-12-05 10:42:59.859648');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '852452427', 5187.96656446689, 500, 51, false, 0, '[]', '2022-12-05 10:42:59.859648');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '807389236', 7744.69295443274, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.868174');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '833163111', 946.855609786253, 500, 51, false, 0, '[]', '2022-12-05 10:42:59.868174');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '813080832', 7336.17389877625, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.875669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '896489260', 3262.34609268625, 500, 61, false, 0, '[]', '2022-12-05 10:42:59.875669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '845881839', 45.0302729408038, 500, 65, false, 0, '[]', '2022-12-05 10:42:59.88852');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '898157169', 1532.93578514343, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.88852');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '882940656', 3990.52669285336, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.898807');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '887589106', 4067.29303136487, 500, 51, false, 0, '[]', '2022-12-05 10:42:59.898807');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '856439808', 5407.82525524393, 500, 62, false, 0, '[]', '2022-12-05 10:42:59.90907');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '869911712', 6798.0931153864, 500, 65, false, 0, '[]', '2022-12-05 10:42:59.90907');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '836420677', 3496.22421703742, 500, 52, false, 0, '[]', '2022-12-05 10:42:59.90907');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '810521018', 334.195799105467, 500, 65, false, 0, '[]', '2022-12-05 10:42:59.932499');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '863021621', 9315.62382381299, 500, 66, false, 0, '[]', '2022-12-05 10:42:59.932499');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '846289494', 9246.01048746831, 500, 65, false, 0, '[]', '2022-12-05 10:42:59.945634');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '834191416', 5858.11486295986, 500, 54, false, 0, '[]', '2022-12-05 10:42:59.945634');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '837420340', 9954.94793340408, 500, 54, false, 0, '[]', '2022-12-05 10:42:59.945634');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '871949311', 4251.70935535591, 500, 66, false, 0, '[]', '2022-12-05 10:42:59.945634');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '821633142', 6424.42446777665, 500, 63, false, 0, '[]', '2022-12-05 10:42:59.96343');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '893463166', 200.548993739936, 500, 68, false, 0, '[]', '2022-12-05 10:42:59.96343');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '833218825', 2247.61689083347, 500, 60, false, 0, '[]', '2022-12-05 10:42:59.976668');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '807456455', 3967.22305727176, 500, 59, false, 0, '[]', '2022-12-05 10:42:59.976668');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '821381486', 5391.24094036125, 500, 69, false, 0, '[]', '2022-12-05 10:42:59.985385');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '814324199', 6616.91724064428, 500, 56, false, 0, '[]', '2022-12-05 10:42:59.985385');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '805904949', 1880.23916452023, 500, 64, false, 0, '[]', '2022-12-05 10:42:59.994385');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '813242515', 5105.99320192289, 500, 68, false, 0, '[]', '2022-12-05 10:43:00.002069');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '839415843', 7691.90569257323, 500, 58, false, 0, '[]', '2022-12-05 10:43:00.010071');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '804234371', 2384.5077281242, 500, 70, false, 0, '[]', '2022-12-05 10:43:00.019063');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '816585946', 8996.08412528799, 500, 68, false, 0, '[]', '2022-12-05 10:43:00.019063');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '824097835', 4886.23198118888, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.030618');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '880538674', 9208.28637760105, 500, 66, false, 0, '[]', '2022-12-05 10:43:00.030618');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '875775705', 1752.65683429192, 500, 52, false, 0, '[]', '2022-12-05 10:43:00.030618');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '877421692', 8.26902356119417, 500, 65, false, 0, '[]', '2022-12-05 10:43:00.044301');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '871547736', 4445.43714120178, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.044301');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '857653378', 3002.15573324514, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.055046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '829980700', 3479.70028230336, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.055046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '852627790', 1325.49648717369, 500, 65, false, 0, '[]', '2022-12-05 10:43:00.068702');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '865978526', 778.875554067024, 500, 52, false, 0, '[]', '2022-12-05 10:43:00.068702');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '840145629', 2201.99247006394, 500, 63, false, 0, '[]', '2022-12-05 10:43:00.081578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '875016141', 1151.87381414685, 500, 61, false, 0, '[]', '2022-12-05 10:43:00.081578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '869419134', 9420.43781294223, 500, 54, false, 0, '[]', '2022-12-05 10:43:00.081578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '813944600', 8712.57220545685, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.094499');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '885600454', 9375.96849417847, 500, 62, false, 0, '[]', '2022-12-05 10:43:00.094499');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '877550656', 1432.26081692811, 500, 68, false, 0, '[]', '2022-12-05 10:43:00.106654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '804227830', 3036.82257270133, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.106654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '858956619', 71.9735226729415, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.106654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '865153645', 5517.76676706049, 500, 64, false, 0, '[]', '2022-12-05 10:43:00.116295');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '817941723', 6283.85391130941, 500, 54, false, 0, '[]', '2022-12-05 10:43:00.116295');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '811667993', 8981.67713669776, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.122964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '859462534', 5541.78238234476, 500, 52, false, 0, '[]', '2022-12-05 10:43:00.122964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '822317092', 7982.65440943172, 500, 52, false, 0, '[]', '2022-12-05 10:43:00.132492');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '877772835', 6953.41317123117, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.132492');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '846495295', 1381.57166449449, 500, 60, false, 0, '[]', '2022-12-05 10:43:00.140197');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '804775869', 6199.68660776788, 500, 54, false, 0, '[]', '2022-12-05 10:43:00.140197');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '831030012', 1334.56253608982, 500, 54, false, 0, '[]', '2022-12-05 10:43:00.149353');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '802809462', 6515.48256145116, 500, 66, false, 0, '[]', '2022-12-05 10:43:00.149353');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '896200151', 4681.0331799749, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.149353');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '873610100', 6392.59754611213, 500, 69, false, 0, '[]', '2022-12-05 10:43:00.157364');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '847931581', 665.124955420069, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.157364');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '870810427', 1604.42579463882, 500, 54, false, 0, '[]', '2022-12-05 10:43:00.165848');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '816457914', 506.785408053248, 500, 58, false, 0, '[]', '2022-12-05 10:43:00.165848');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '816760477', 6136.51145173513, 500, 58, false, 0, '[]', '2022-12-05 10:43:00.165848');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '821449527', 4324.31257074738, 500, 57, false, 0, '[]', '2022-12-05 10:43:00.176286');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '897412997', 6641.00997799906, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.176286');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '801856356', 8808.35675713779, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.185295');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '898170941', 8759.70355605598, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.185295');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '884390144', 8427.95312080857, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.194377');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '894424841', 9611.58369761575, 500, 54, false, 0, '[]', '2022-12-05 10:43:00.200496');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '828972512', 4976.99567176787, 500, 58, false, 0, '[]', '2022-12-05 10:43:00.200496');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '815082581', 1459.46497891066, 500, 57, false, 0, '[]', '2022-12-05 10:43:00.212062');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '887159012', 3594.34051527546, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.212062');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '829493874', 195.666918104692, 500, 56, false, 0, '[]', '2022-12-05 10:43:00.219978');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '814929193', 9424.624203392, 500, 57, false, 0, '[]', '2022-12-05 10:43:00.219978');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '859907302', 3621.05913009418, 500, 57, false, 0, '[]', '2022-12-05 10:43:00.22845');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '895124699', 9992.89976495013, 500, 69, false, 0, '[]', '2022-12-05 10:43:00.22845');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '813239227', 9864.33242645944, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.238145');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '840430296', 1309.45543652725, 500, 52, false, 0, '[]', '2022-12-05 10:43:00.244976');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '858726639', 1585.69406169495, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.244976');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '823234800', 568.058722254767, 500, 69, false, 0, '[]', '2022-12-05 10:43:00.255303');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '874361830', 5345.00984792032, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.263115');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '808481735', 7061.52726965286, 500, 56, false, 0, '[]', '2022-12-05 10:43:00.263115');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '860499175', 7781.3052643416, 500, 52, false, 0, '[]', '2022-12-05 10:43:00.272883');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '892697142', 483.383807045507, 500, 62, false, 0, '[]', '2022-12-05 10:43:00.272883');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '826727890', 6617.84337611619, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.285401');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '895582762', 314.096393510483, 500, 65, false, 0, '[]', '2022-12-05 10:43:00.285401');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '814663914', 9530.54028642358, 500, 56, false, 0, '[]', '2022-12-05 10:43:00.300445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '887191975', 7160.46282464153, 500, 63, false, 0, '[]', '2022-12-05 10:43:00.300445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '856729012', 4794.61963056469, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.309849');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '816248533', 8215.79416976847, 500, 63, false, 0, '[]', '2022-12-05 10:43:00.319666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '847253663', 7963.13245427878, 500, 70, false, 0, '[]', '2022-12-05 10:43:00.319666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '851556995', 6021.38305816914, 500, 69, false, 0, '[]', '2022-12-05 10:43:00.328176');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '897000352', 1330.03701300888, 500, 68, false, 0, '[]', '2022-12-05 10:43:00.328176');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '891267708', 2815.37826474634, 500, 63, false, 0, '[]', '2022-12-05 10:43:00.328176');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '868369009', 3344.63529790238, 500, 62, false, 0, '[]', '2022-12-05 10:43:00.337338');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '836786224', 3142.8633370112, 500, 69, false, 0, '[]', '2022-12-05 10:43:00.337338');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '800910790', 9205.86225788969, 500, 54, false, 0, '[]', '2022-12-05 10:43:00.345549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '847922087', 2916.92143630535, 500, 62, false, 0, '[]', '2022-12-05 10:43:00.35169');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '882737279', 2527.99931634561, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.35169');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '817612413', 2000.81046563359, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.35169');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '857680168', 7265.56817031278, 500, 52, false, 0, '[]', '2022-12-05 10:43:00.360748');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '878624841', 9113.96674916906, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.367525');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '867183919', 8233.53679913559, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.367525');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '824306551', 9606.71936146004, 500, 60, false, 0, '[]', '2022-12-05 10:43:00.367525');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '812929350', 6209.52124390007, 500, 61, false, 0, '[]', '2022-12-05 10:43:00.376841');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '890735735', 6619.14956805349, 500, 61, false, 0, '[]', '2022-12-05 10:43:00.376841');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '894341616', 8932.04616561992, 500, 70, false, 0, '[]', '2022-12-05 10:43:00.393399');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '845690609', 5501.88599669819, 500, 61, false, 0, '[]', '2022-12-05 10:43:00.393399');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '884945724', 9031.94608765818, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.393399');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '820865124', 6452.63768724536, 500, 69, false, 0, '[]', '2022-12-05 10:43:00.393399');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '870514368', 371.918484126773, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.393399');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '833643869', 3129.61829577929, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.403941');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '807702188', 9187.94424879352, 500, 65, false, 0, '[]', '2022-12-05 10:43:00.411528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '820638689', 8023.14662445193, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.411528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '843380901', 9246.26262541175, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.421307');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '832951634', 6503.504438684, 500, 60, false, 0, '[]', '2022-12-05 10:43:00.421307');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '833677243', 5247.68883778187, 500, 63, false, 0, '[]', '2022-12-05 10:43:00.430735');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '873656323', 6243.30524681956, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.430735');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '859159231', 667.772377276567, 500, 69, false, 0, '[]', '2022-12-05 10:43:00.430735');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '868067017', 6186.01137273957, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.443928');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '856435712', 3859.56940869084, 500, 70, false, 0, '[]', '2022-12-05 10:43:00.454512');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '888937591', 8158.37867897912, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.454512');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '873906284', 7919.01177178076, 500, 65, false, 0, '[]', '2022-12-05 10:43:00.463055');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '855150484', 9061.19170738381, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.4721');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '836365546', 2265.30234463782, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.482544');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '822564929', 5873.28512795725, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.491397');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '833204596', 242.245227259752, 500, 60, false, 0, '[]', '2022-12-05 10:43:00.501015');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '863592645', 7812.12734108915, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.501015');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '865956727', 3226.65117371347, 500, 62, false, 0, '[]', '2022-12-05 10:43:00.51306');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '807629933', 3654.36608890285, 500, 64, false, 0, '[]', '2022-12-05 10:43:00.51306');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '832454631', 7254.05717772301, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.524151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '823356725', 8205.62164657554, 500, 57, false, 0, '[]', '2022-12-05 10:43:00.524151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '800824855', 8843.60922012447, 500, 56, false, 0, '[]', '2022-12-05 10:43:00.534298');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '894510083', 9014.42574506739, 500, 57, false, 0, '[]', '2022-12-05 10:43:00.54489');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '815854671', 7029.9241811903, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.554953');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '876401827', 5026.50193906141, 500, 61, false, 0, '[]', '2022-12-05 10:43:00.554953');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '845066027', 6291.55000330138, 500, 64, false, 0, '[]', '2022-12-05 10:43:00.569112');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '815406101', 4642.2033639526, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.569112');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '866878310', 4008.82950521073, 500, 60, false, 0, '[]', '2022-12-05 10:43:00.581972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '830803739', 1429.17219816082, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.581972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '805933483', 8236.87948527692, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.59817');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '868252144', 4582.38638756645, 500, 62, false, 0, '[]', '2022-12-05 10:43:00.59817');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '828744326', 3772.89522130383, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.606376');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '830122600', 2367.05553974608, 500, 58, false, 0, '[]', '2022-12-05 10:43:00.606376');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '813147327', 9039.06757514102, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.606376');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '846250295', 5063.45284266988, 500, 66, false, 0, '[]', '2022-12-05 10:43:00.606376');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '898250721', 898.403007219565, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.621192');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '813697349', 9621.27869691851, 500, 66, false, 0, '[]', '2022-12-05 10:43:00.628486');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '863104800', 9535.83003703886, 500, 65, false, 0, '[]', '2022-12-05 10:43:00.628486');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '897979593', 2418.00636451359, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.628486');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '860772161', 2756.66666769904, 500, 63, false, 0, '[]', '2022-12-05 10:43:00.628486');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '808002552', 4326.89716130224, 500, 61, false, 0, '[]', '2022-12-05 10:43:00.637154');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '876394411', 6389.88224369918, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.637154');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '846214156', 9357.72414727229, 500, 56, false, 0, '[]', '2022-12-05 10:43:00.642653');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '850015354', 307.804441210466, 500, 60, false, 0, '[]', '2022-12-05 10:43:00.642653');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '805145991', 4211.1345394836, 500, 57, false, 0, '[]', '2022-12-05 10:43:00.654774');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '853879838', 7189.65926047863, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.663417');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '882939801', 2790.28569927354, 500, 59, false, 0, '[]', '2022-12-05 10:43:00.670606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '859605190', 279.612864887193, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.670606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '891814367', 4014.69476496909, 500, 64, false, 0, '[]', '2022-12-05 10:43:00.681134');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '875021136', 8022.90121397201, 500, 68, false, 0, '[]', '2022-12-05 10:43:00.69078');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '825379831', 6770.40046688049, 500, 58, false, 0, '[]', '2022-12-05 10:43:00.69078');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '800469195', 2866.30297024675, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.69078');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '871244244', 4261.90337856182, 500, 69, false, 0, '[]', '2022-12-05 10:43:00.69078');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '837133219', 8008.17671619511, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.701527');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '855964219', 7639.00568192425, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.707784');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '838273484', 1491.1493475381, 500, 60, false, 0, '[]', '2022-12-05 10:43:00.722261');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '893483616', 8810.00060874641, 500, 62, false, 0, '[]', '2022-12-05 10:43:00.729466');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '891497759', 6298.92821595054, 500, 68, false, 0, '[]', '2022-12-05 10:43:00.735315');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '888247901', 8784.62168081404, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.735315');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '883590490', 4787.25235642746, 500, 65, false, 0, '[]', '2022-12-05 10:43:00.741465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '804908767', 9371.52484363624, 500, 68, false, 0, '[]', '2022-12-05 10:43:00.752891');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '851919134', 4979.16069847087, 500, 66, false, 0, '[]', '2022-12-05 10:43:00.761004');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '813682750', 4978.4787466021, 500, 60, false, 0, '[]', '2022-12-05 10:43:00.769024');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '875544956', 7727.8808423631, 500, 69, false, 0, '[]', '2022-12-05 10:43:00.769024');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '889472231', 5293.81883233276, 500, 58, false, 0, '[]', '2022-12-05 10:43:00.782287');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '875631634', 761.586854611059, 500, 70, false, 0, '[]', '2022-12-05 10:43:00.782287');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '856007783', 1835.15693597304, 500, 58, false, 0, '[]', '2022-12-05 10:43:00.799441');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '844760467', 1860.89334960296, 500, 56, false, 0, '[]', '2022-12-05 10:43:00.799441');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '863256691', 6538.54541026549, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.81353');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '851705582', 9720.23140564815, 500, 52, false, 0, '[]', '2022-12-05 10:43:00.81353');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '854298834', 4519.08162227157, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.81353');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '836216435', 5587.51577255714, 500, 64, false, 0, '[]', '2022-12-05 10:43:00.823162');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '893017297', 6668.54874746705, 500, 70, false, 0, '[]', '2022-12-05 10:43:00.823162');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '841372032', 882.777985756789, 500, 61, false, 0, '[]', '2022-12-05 10:43:00.836485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '862589424', 1255.33629931929, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.851726');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '871501781', 7046.43606247672, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.851726');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '880977356', 2739.28260007092, 500, 69, false, 0, '[]', '2022-12-05 10:43:00.864565');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '859708655', 498.128335539301, 500, 55, false, 0, '[]', '2022-12-05 10:43:00.864565');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '837130075', 6344.60749795013, 500, 57, false, 0, '[]', '2022-12-05 10:43:00.864565');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '803170681', 3790.47844737888, 500, 54, false, 0, '[]', '2022-12-05 10:43:00.874274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '875018446', 3242.42743066822, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.874274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '872251225', 1468.0606078798, 500, 61, false, 0, '[]', '2022-12-05 10:43:00.883653');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '889927472', 8955.78978751233, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.891112');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '850310272', 4504.53958094792, 500, 69, false, 0, '[]', '2022-12-05 10:43:00.900537');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '878277970', 3100.15652907372, 500, 70, false, 0, '[]', '2022-12-05 10:43:00.90877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '811324382', 3643.51355394219, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.90877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '878265174', 878.14465244471, 500, 52, false, 0, '[]', '2022-12-05 10:43:00.917524');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '803799726', 3392.281093843, 500, 67, false, 0, '[]', '2022-12-05 10:43:00.917524');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '827344157', 7970.09625370604, 500, 68, false, 0, '[]', '2022-12-05 10:43:00.926215');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '868610918', 2587.53880841903, 500, 68, false, 0, '[]', '2022-12-05 10:43:00.926215');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '891144647', 3012.65131045483, 500, 70, false, 0, '[]', '2022-12-05 10:43:00.936977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '874750888', 5994.04945195493, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.945268');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '879572863', 9453.53515617348, 500, 70, false, 0, '[]', '2022-12-05 10:43:00.955778');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '816719384', 933.384847032294, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.96421');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '823372812', 8166.1419864997, 500, 51, false, 0, '[]', '2022-12-05 10:43:00.96421');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '872671153', 556.45639877093, 500, 54, false, 0, '[]', '2022-12-05 10:43:00.975633');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '837782686', 2434.71125892135, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.975633');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '856373244', 9261.68986699028, 500, 70, false, 0, '[]', '2022-12-05 10:43:00.987029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '802319687', 159.383765624841, 500, 64, false, 0, '[]', '2022-12-05 10:43:00.987029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '882221112', 1380.64233149674, 500, 53, false, 0, '[]', '2022-12-05 10:43:00.996791');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '825823538', 7743.35588788984, 500, 61, false, 0, '[]', '2022-12-05 10:43:00.996791');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '840744367', 8866.65741987201, 500, 54, false, 0, '[]', '2022-12-05 10:43:01.005962');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '807485242', 7310.86797284707, 500, 58, false, 0, '[]', '2022-12-05 10:43:01.005962');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '878321914', 6709.5614092684, 500, 61, false, 0, '[]', '2022-12-05 10:43:01.015309');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '886892017', 8180.62500773342, 500, 65, false, 0, '[]', '2022-12-05 10:43:01.023493');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '871623349', 9959.46989702065, 500, 62, false, 0, '[]', '2022-12-05 10:43:01.023493');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '864986459', 459.426014288514, 500, 66, false, 0, '[]', '2022-12-05 10:43:01.035792');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '849227492', 4761.93026753749, 500, 67, false, 0, '[]', '2022-12-05 10:43:01.044182');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '850910144', 3874.51943023948, 500, 63, false, 0, '[]', '2022-12-05 10:43:01.044182');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '869658223', 7139.56150979653, 500, 52, false, 0, '[]', '2022-12-05 10:43:01.044182');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '866431270', 3650.79688399931, 500, 53, false, 0, '[]', '2022-12-05 10:43:01.052908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '858356342', 5990.45588217906, 500, 59, false, 0, '[]', '2022-12-05 10:43:01.052908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '852467356', 9896.55925834339, 500, 52, false, 0, '[]', '2022-12-05 10:43:01.059807');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '898657961', 5593.31539636119, 500, 65, false, 0, '[]', '2022-12-05 10:43:01.066672');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '846849579', 1047.99548208559, 500, 54, false, 0, '[]', '2022-12-05 10:43:01.066672');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '873579899', 9031.9699787671, 500, 57, false, 0, '[]', '2022-12-05 10:43:01.07729');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '843035298', 1234.88519348482, 500, 63, false, 0, '[]', '2022-12-05 10:43:01.085609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '858836952', 3102.74683904812, 500, 59, false, 0, '[]', '2022-12-05 10:43:01.09291');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '805709917', 498.501820669752, 500, 63, false, 0, '[]', '2022-12-05 10:43:01.099878');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '808479485', 3954.40691923848, 500, 65, false, 0, '[]', '2022-12-05 10:43:01.099878');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '838878962', 1111.30089995564, 500, 52, false, 0, '[]', '2022-12-05 10:43:01.108505');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '885625328', 2461.75388151989, 500, 69, false, 0, '[]', '2022-12-05 10:43:01.108505');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '837527996', 1433.31818697245, 500, 53, false, 0, '[]', '2022-12-05 10:43:01.120805');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '844848494', 1835.66901523663, 500, 51, false, 0, '[]', '2022-12-05 10:43:01.130156');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '825573136', 8973.22059914468, 500, 54, false, 0, '[]', '2022-12-05 10:43:01.130156');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '809036318', 6351.20429851037, 500, 56, false, 0, '[]', '2022-12-05 10:43:01.130156');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '800223332', 7149.45032487511, 500, 58, false, 0, '[]', '2022-12-05 10:43:01.141791');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '878112453', 9599.52142821318, 500, 59, false, 0, '[]', '2022-12-05 10:43:01.141791');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '893781546', 2159.79749586887, 500, 70, false, 0, '[]', '2022-12-05 10:43:01.149671');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '818658010', 2174.36826781023, 500, 51, false, 0, '[]', '2022-12-05 10:43:01.160921');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '862270603', 5221.19697376643, 500, 64, false, 0, '[]', '2022-12-05 10:43:01.160921');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '812325897', 9789.29013990651, 500, 63, false, 0, '[]', '2022-12-05 10:43:01.169905');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '817554736', 9397.08920841531, 500, 69, false, 0, '[]', '2022-12-05 10:43:01.184064');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '884291457', 2488.94578609142, 500, 62, false, 0, '[]', '2022-12-05 10:43:01.193887');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '890910485', 7620.84945511635, 500, 53, false, 0, '[]', '2022-12-05 10:43:01.193887');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '810677960', 9130.15730423971, 500, 61, false, 0, '[]', '2022-12-05 10:43:01.203491');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '830621787', 1943.506780185, 500, 67, false, 0, '[]', '2022-12-05 10:43:01.216173');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '874792210', 6532.15539034358, 500, 57, false, 0, '[]', '2022-12-05 10:43:01.216173');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '828718942', 5349.56367882374, 500, 66, false, 0, '[]', '2022-12-05 10:43:01.225947');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '846277869', 258.964131549818, 500, 54, false, 0, '[]', '2022-12-05 10:43:01.225947');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '809316543', 6024.88616460637, 500, 52, false, 0, '[]', '2022-12-05 10:43:01.239547');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '846821438', 8705.90458092763, 500, 53, false, 0, '[]', '2022-12-05 10:43:01.239547');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '836005340', 3389.10176172667, 500, 52, false, 0, '[]', '2022-12-05 10:43:01.239547');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '869069081', 8704.1027748533, 500, 57, false, 0, '[]', '2022-12-05 10:43:01.239547');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '824870495', 2912.75024645671, 500, 60, false, 0, '[]', '2022-12-05 10:43:01.248327');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '821850314', 8170.6775551927, 500, 57, false, 0, '[]', '2022-12-05 10:43:01.266641');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '895629317', 1104.56938987583, 500, 69, false, 0, '[]', '2022-12-05 10:43:01.266641');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '854843256', 5051.92962981132, 500, 63, false, 0, '[]', '2022-12-05 10:43:01.266641');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '825397589', 6631.40399604967, 500, 62, false, 0, '[]', '2022-12-05 10:43:01.266641');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '856901774', 3045.91466226533, 500, 60, false, 0, '[]', '2022-12-05 10:43:01.274214');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '886566656', 7167.06289252262, 500, 54, false, 0, '[]', '2022-12-05 10:43:01.274214');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '868634250', 1772.11408069709, 500, 52, false, 0, '[]', '2022-12-05 10:43:01.274214');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '827178297', 5698.79173337186, 500, 62, false, 0, '[]', '2022-12-05 10:43:01.287262');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '889901026', 1758.7739541495, 500, 69, false, 0, '[]', '2022-12-05 10:43:01.297689');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '860932226', 6540.83542830354, 500, 70, false, 0, '[]', '2022-12-05 10:43:01.297689');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '883640440', 4938.64416253414, 500, 67, false, 0, '[]', '2022-12-05 10:43:01.316973');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '899511765', 6383.33091284, 500, 61, false, 0, '[]', '2022-12-05 10:43:01.316973');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '826671551', 5332.22881525061, 500, 59, false, 0, '[]', '2022-12-05 10:43:01.332768');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '838991015', 2608.33391432613, 500, 63, false, 0, '[]', '2022-12-05 10:43:01.332768');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '831768843', 5846.90504300353, 500, 68, false, 0, '[]', '2022-12-05 10:43:01.344158');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '803324193', 4312.57286782167, 500, 67, false, 0, '[]', '2022-12-05 10:43:01.344158');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '827269180', 4281.20288705358, 500, 63, false, 0, '[]', '2022-12-05 10:43:01.344158');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '806938796', 9281.80151833857, 500, 64, false, 0, '[]', '2022-12-05 10:43:01.354251');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '817130185', 1174.36923207574, 500, 63, false, 0, '[]', '2022-12-05 10:43:01.362755');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '810402680', 6496.57818295849, 500, 65, false, 0, '[]', '2022-12-05 10:43:01.362755');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '887841956', 2815.70094624347, 500, 54, false, 0, '[]', '2022-12-05 10:43:01.373085');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '897336611', 2623.29036404851, 500, 52, false, 0, '[]', '2022-12-05 10:43:01.373085');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '858728795', 8230.96776360259, 500, 56, false, 0, '[]', '2022-12-05 10:43:01.387606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '880050743', 4893.31656244515, 500, 66, false, 0, '[]', '2022-12-05 10:43:01.398145');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '871161662', 9499.1107595604, 500, 64, false, 0, '[]', '2022-12-05 10:43:01.398145');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '862924848', 49.0022394238522, 500, 51, false, 0, '[]', '2022-12-05 10:43:01.398145');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '895031114', 6058.78939929326, 500, 53, false, 0, '[]', '2022-12-05 10:43:01.398145');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '815517829', 9753.39249097198, 500, 58, false, 0, '[]', '2022-12-05 10:43:01.415449');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '836666246', 5267.68569394228, 500, 58, false, 0, '[]', '2022-12-05 10:43:01.415449');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '845715533', 1520.7837087449, 500, 66, false, 0, '[]', '2022-12-05 10:43:01.42573');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '897156462', 4802.03138301885, 500, 57, false, 0, '[]', '2022-12-05 10:43:01.436769');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '890815244', 3236.08179540181, 500, 51, false, 0, '[]', '2022-12-05 10:43:01.436769');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '866562589', 2083.26442547051, 500, 53, false, 0, '[]', '2022-12-05 10:43:01.448666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '875322390', 2776.17395805639, 500, 62, false, 0, '[]', '2022-12-05 10:43:01.455359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '870376312', 4384.46738307762, 500, 60, false, 0, '[]', '2022-12-05 10:43:01.455359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '863074238', 581.035120669152, 500, 56, false, 0, '[]', '2022-12-05 10:43:01.469571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '873535604', 929.330422737142, 500, 69, false, 0, '[]', '2022-12-05 10:43:01.481331');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '820029647', 1933.78907735103, 500, 68, false, 0, '[]', '2022-12-05 10:43:01.481331');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '825514130', 5183.46413190183, 500, 52, false, 0, '[]', '2022-12-05 10:43:01.481331');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '815801592', 9448.66976543331, 500, 67, false, 0, '[]', '2022-12-05 10:43:01.493224');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '839528084', 598.642508333722, 500, 54, false, 0, '[]', '2022-12-05 10:43:01.500321');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '864571830', 8176.25459867593, 500, 62, false, 0, '[]', '2022-12-05 10:43:01.500321');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '883989256', 6341.20844262028, 500, 55, false, 0, '[]', '2022-12-05 10:43:01.904904');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '831272011', 923.121749334804, 500, 67, false, 0, '[]', '2022-12-05 10:43:01.911759');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '831658088', 709.195849107258, 500, 59, false, 0, '[]', '2022-12-05 10:43:01.917102');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '802008121', 645.549536580495, 500, 63, false, 0, '[]', '2022-12-05 10:43:01.917102');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '857721878', 3717.07663809845, 500, 64, false, 0, '[]', '2022-12-05 10:43:01.917102');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '811747377', 8450.3000303575, 500, 69, false, 0, '[]', '2022-12-05 10:43:01.923863');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '801396893', 9762.76751344184, 500, 55, false, 0, '[]', '2022-12-05 10:43:01.93004');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '885133950', 9875.14333973524, 500, 57, false, 0, '[]', '2022-12-05 10:43:01.93004');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '864761302', 8656.63047509325, 500, 69, false, 0, '[]', '2022-12-05 10:43:01.942253');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '870050263', 8115.23903246291, 500, 54, false, 0, '[]', '2022-12-05 10:43:01.949443');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '881536611', 8381.80696226399, 500, 64, false, 0, '[]', '2022-12-05 10:43:01.949443');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '862811969', 6896.42057036105, 500, 58, false, 0, '[]', '2022-12-05 10:43:01.949443');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '892708443', 5851.46877470491, 500, 52, false, 0, '[]', '2022-12-05 10:43:01.949443');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '866931781', 8546.83195158219, 500, 68, false, 0, '[]', '2022-12-05 10:43:01.960965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '868378133', 8135.61786699797, 500, 58, false, 0, '[]', '2022-12-05 10:43:01.969557');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '872308278', 2966.57511414481, 500, 56, false, 0, '[]', '2022-12-05 10:43:01.969557');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '854032309', 3274.51750286338, 500, 58, false, 0, '[]', '2022-12-05 10:43:01.969557');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '842782667', 7398.86517039878, 500, 51, false, 0, '[]', '2022-12-05 10:43:01.976198');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (533, '846058502', 4208.14214639256, 500, 53, false, 0, '[]', '2022-12-05 10:43:06.256498');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (534, '878151780', 9289.47571597349, 500, 61, false, 0, '[]', '2022-12-05 10:43:06.272916');


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:52.930167', '2022-12-05 10:42:52.930167');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:52.94216', '2022-12-05 10:42:52.94216');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:52.949992', '2022-12-05 10:42:52.949992');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:52.961922', '2022-12-05 10:42:52.961922');
INSERT INTO public.virksomhet VALUES (5, '800061965', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800061965', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:52.97052', '2022-12-05 10:42:52.97052');
INSERT INTO public.virksomhet VALUES (6, '881532376', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881532376', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:52.980423', '2022-12-05 10:42:52.980423');
INSERT INTO public.virksomhet VALUES (7, '883874352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883874352', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:52.987509', '2022-12-05 10:42:52.987509');
INSERT INTO public.virksomhet VALUES (8, '848147638', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848147638', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:52.99437', '2022-12-05 10:42:52.99437');
INSERT INTO public.virksomhet VALUES (9, '876763949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876763949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.000753', '2022-12-05 10:42:53.000753');
INSERT INTO public.virksomhet VALUES (10, '871871807', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871871807', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.00817', '2022-12-05 10:42:53.00817');
INSERT INTO public.virksomhet VALUES (11, '864079801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864079801', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.016181', '2022-12-05 10:42:53.016181');
INSERT INTO public.virksomhet VALUES (12, '836041617', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836041617', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.022271', '2022-12-05 10:42:53.022271');
INSERT INTO public.virksomhet VALUES (13, '857842260', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857842260', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.030019', '2022-12-05 10:42:53.030019');
INSERT INTO public.virksomhet VALUES (14, '885073621', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885073621', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.038031', '2022-12-05 10:42:53.038031');
INSERT INTO public.virksomhet VALUES (15, '864754605', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864754605', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.044432', '2022-12-05 10:42:53.044432');
INSERT INTO public.virksomhet VALUES (16, '846347581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846347581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.050056', '2022-12-05 10:42:53.050056');
INSERT INTO public.virksomhet VALUES (17, '824680794', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824680794', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.05625', '2022-12-05 10:42:53.05625');
INSERT INTO public.virksomhet VALUES (18, '839415001', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839415001', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.064905', '2022-12-05 10:42:53.064905');
INSERT INTO public.virksomhet VALUES (19, '861744528', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861744528', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.07102', '2022-12-05 10:42:53.07102');
INSERT INTO public.virksomhet VALUES (20, '860138909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860138909', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.077193', '2022-12-05 10:42:53.077193');
INSERT INTO public.virksomhet VALUES (21, '843242104', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843242104', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.086039', '2022-12-05 10:42:53.086039');
INSERT INTO public.virksomhet VALUES (22, '890093850', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890093850', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.091876', '2022-12-05 10:42:53.091876');
INSERT INTO public.virksomhet VALUES (23, '892511017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892511017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.097196', '2022-12-05 10:42:53.097196');
INSERT INTO public.virksomhet VALUES (24, '842605109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842605109', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.102797', '2022-12-05 10:42:53.102797');
INSERT INTO public.virksomhet VALUES (25, '870491047', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870491047', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.108213', '2022-12-05 10:42:53.108213');
INSERT INTO public.virksomhet VALUES (26, '863507760', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863507760', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.114327', '2022-12-05 10:42:53.114327');
INSERT INTO public.virksomhet VALUES (27, '817257908', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817257908', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.120464', '2022-12-05 10:42:53.120464');
INSERT INTO public.virksomhet VALUES (28, '809042383', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809042383', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.126351', '2022-12-05 10:42:53.126351');
INSERT INTO public.virksomhet VALUES (29, '810734693', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810734693', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.131703', '2022-12-05 10:42:53.131703');
INSERT INTO public.virksomhet VALUES (30, '804629062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804629062', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.141096', '2022-12-05 10:42:53.141096');
INSERT INTO public.virksomhet VALUES (31, '873621335', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873621335', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.147198', '2022-12-05 10:42:53.147198');
INSERT INTO public.virksomhet VALUES (32, '835058832', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835058832', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.153365', '2022-12-05 10:42:53.153365');
INSERT INTO public.virksomhet VALUES (33, '803826652', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803826652', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.159225', '2022-12-05 10:42:53.159225');
INSERT INTO public.virksomhet VALUES (34, '874394467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874394467', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.166465', '2022-12-05 10:42:53.166465');
INSERT INTO public.virksomhet VALUES (35, '838903289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838903289', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.173869', '2022-12-05 10:42:53.173869');
INSERT INTO public.virksomhet VALUES (36, '882051647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882051647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.179563', '2022-12-05 10:42:53.179563');
INSERT INTO public.virksomhet VALUES (37, '879681201', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879681201', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.184744', '2022-12-05 10:42:53.184744');
INSERT INTO public.virksomhet VALUES (38, '852409131', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852409131', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.189815', '2022-12-05 10:42:53.189815');
INSERT INTO public.virksomhet VALUES (39, '808215075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808215075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.195858', '2022-12-05 10:42:53.195858');
INSERT INTO public.virksomhet VALUES (40, '865074415', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865074415', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.200941', '2022-12-05 10:42:53.200941');
INSERT INTO public.virksomhet VALUES (41, '836669149', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836669149', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.205861', '2022-12-05 10:42:53.205861');
INSERT INTO public.virksomhet VALUES (42, '884369776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884369776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.210514', '2022-12-05 10:42:53.210514');
INSERT INTO public.virksomhet VALUES (43, '873418367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873418367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.215444', '2022-12-05 10:42:53.215444');
INSERT INTO public.virksomhet VALUES (44, '802905016', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802905016', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.220834', '2022-12-05 10:42:53.220834');
INSERT INTO public.virksomhet VALUES (45, '885609899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885609899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.226195', '2022-12-05 10:42:53.226195');
INSERT INTO public.virksomhet VALUES (46, '860836918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860836918', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.231562', '2022-12-05 10:42:53.231562');
INSERT INTO public.virksomhet VALUES (47, '829745509', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829745509', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.237112', '2022-12-05 10:42:53.237112');
INSERT INTO public.virksomhet VALUES (48, '844246611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844246611', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.242618', '2022-12-05 10:42:53.242618');
INSERT INTO public.virksomhet VALUES (49, '867216743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867216743', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.247848', '2022-12-05 10:42:53.247848');
INSERT INTO public.virksomhet VALUES (50, '890941228', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890941228', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.252814', '2022-12-05 10:42:53.252814');
INSERT INTO public.virksomhet VALUES (51, '838540049', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838540049', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.258173', '2022-12-05 10:42:53.258173');
INSERT INTO public.virksomhet VALUES (52, '809501750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809501750', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.263758', '2022-12-05 10:42:53.263758');
INSERT INTO public.virksomhet VALUES (53, '844496478', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844496478', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.26942', '2022-12-05 10:42:53.26942');
INSERT INTO public.virksomhet VALUES (54, '863501025', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863501025', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.276116', '2022-12-05 10:42:53.276116');
INSERT INTO public.virksomhet VALUES (55, '839166324', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839166324', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.282592', '2022-12-05 10:42:53.282592');
INSERT INTO public.virksomhet VALUES (56, '879962157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879962157', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.289261', '2022-12-05 10:42:53.289261');
INSERT INTO public.virksomhet VALUES (57, '848543645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848543645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.296504', '2022-12-05 10:42:53.296504');
INSERT INTO public.virksomhet VALUES (58, '880279851', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880279851', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.303251', '2022-12-05 10:42:53.303251');
INSERT INTO public.virksomhet VALUES (59, '808671188', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808671188', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.310276', '2022-12-05 10:42:53.310276');
INSERT INTO public.virksomhet VALUES (60, '851333885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851333885', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.317306', '2022-12-05 10:42:53.317306');
INSERT INTO public.virksomhet VALUES (61, '815366017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815366017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.324527', '2022-12-05 10:42:53.324527');
INSERT INTO public.virksomhet VALUES (62, '891113900', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891113900', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.330406', '2022-12-05 10:42:53.330406');
INSERT INTO public.virksomhet VALUES (63, '894926128', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894926128', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.336208', '2022-12-05 10:42:53.336208');
INSERT INTO public.virksomhet VALUES (64, '802290404', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802290404', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.342879', '2022-12-05 10:42:53.342879');
INSERT INTO public.virksomhet VALUES (65, '896239097', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896239097', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.348466', '2022-12-05 10:42:53.348466');
INSERT INTO public.virksomhet VALUES (66, '816868949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816868949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.354463', '2022-12-05 10:42:53.354463');
INSERT INTO public.virksomhet VALUES (67, '895298219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895298219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.359775', '2022-12-05 10:42:53.359775');
INSERT INTO public.virksomhet VALUES (68, '842893897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842893897', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.3657', '2022-12-05 10:42:53.3657');
INSERT INTO public.virksomhet VALUES (69, '814670938', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814670938', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.371362', '2022-12-05 10:42:53.371362');
INSERT INTO public.virksomhet VALUES (70, '820433803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820433803', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.377683', '2022-12-05 10:42:53.377683');
INSERT INTO public.virksomhet VALUES (71, '874104569', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874104569', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.383185', '2022-12-05 10:42:53.383185');
INSERT INTO public.virksomhet VALUES (72, '856520283', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856520283', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.387975', '2022-12-05 10:42:53.387975');
INSERT INTO public.virksomhet VALUES (73, '879090305', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879090305', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.392734', '2022-12-05 10:42:53.392734');
INSERT INTO public.virksomhet VALUES (74, '809468321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809468321', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.397507', '2022-12-05 10:42:53.397507');
INSERT INTO public.virksomhet VALUES (75, '826378947', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826378947', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.40205', '2022-12-05 10:42:53.40205');
INSERT INTO public.virksomhet VALUES (76, '866390365', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866390365', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.406852', '2022-12-05 10:42:53.406852');
INSERT INTO public.virksomhet VALUES (77, '862771013', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862771013', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.411771', '2022-12-05 10:42:53.411771');
INSERT INTO public.virksomhet VALUES (78, '864363318', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864363318', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.416322', '2022-12-05 10:42:53.416322');
INSERT INTO public.virksomhet VALUES (79, '896438075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896438075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.42177', '2022-12-05 10:42:53.42177');
INSERT INTO public.virksomhet VALUES (80, '829368106', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829368106', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.427371', '2022-12-05 10:42:53.427371');
INSERT INTO public.virksomhet VALUES (81, '867407313', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867407313', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.432249', '2022-12-05 10:42:53.432249');
INSERT INTO public.virksomhet VALUES (82, '896587504', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896587504', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.436927', '2022-12-05 10:42:53.436927');
INSERT INTO public.virksomhet VALUES (83, '847845944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847845944', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.442332', '2022-12-05 10:42:53.442332');
INSERT INTO public.virksomhet VALUES (84, '826389298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826389298', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.447143', '2022-12-05 10:42:53.447143');
INSERT INTO public.virksomhet VALUES (85, '848399886', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848399886', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.452632', '2022-12-05 10:42:53.452632');
INSERT INTO public.virksomhet VALUES (86, '854846835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854846835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.458911', '2022-12-05 10:42:53.458911');
INSERT INTO public.virksomhet VALUES (87, '800634899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800634899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.463443', '2022-12-05 10:42:53.463443');
INSERT INTO public.virksomhet VALUES (88, '857110616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857110616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.468317', '2022-12-05 10:42:53.468317');
INSERT INTO public.virksomhet VALUES (89, '808271586', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808271586', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.47304', '2022-12-05 10:42:53.47304');
INSERT INTO public.virksomhet VALUES (90, '819801010', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819801010', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.478027', '2022-12-05 10:42:53.478027');
INSERT INTO public.virksomhet VALUES (91, '848578637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848578637', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.483358', '2022-12-05 10:42:53.483358');
INSERT INTO public.virksomhet VALUES (92, '827490752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827490752', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.488695', '2022-12-05 10:42:53.488695');
INSERT INTO public.virksomhet VALUES (93, '835736810', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835736810', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.49366', '2022-12-05 10:42:53.49366');
INSERT INTO public.virksomhet VALUES (94, '857544475', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857544475', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.498872', '2022-12-05 10:42:53.498872');
INSERT INTO public.virksomhet VALUES (95, '847721823', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847721823', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.504256', '2022-12-05 10:42:53.504256');
INSERT INTO public.virksomhet VALUES (96, '862581603', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862581603', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.50929', '2022-12-05 10:42:53.50929');
INSERT INTO public.virksomhet VALUES (97, '810313500', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810313500', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.514155', '2022-12-05 10:42:53.514155');
INSERT INTO public.virksomhet VALUES (98, '885129733', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885129733', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.520712', '2022-12-05 10:42:53.520712');
INSERT INTO public.virksomhet VALUES (99, '898243796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898243796', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.525999', '2022-12-05 10:42:53.525999');
INSERT INTO public.virksomhet VALUES (100, '887079787', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887079787', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.530971', '2022-12-05 10:42:53.530971');
INSERT INTO public.virksomhet VALUES (101, '861058672', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861058672', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.53653', '2022-12-05 10:42:53.53653');
INSERT INTO public.virksomhet VALUES (102, '876537913', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876537913', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.541358', '2022-12-05 10:42:53.541358');
INSERT INTO public.virksomhet VALUES (103, '890597928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890597928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.546697', '2022-12-05 10:42:53.546697');
INSERT INTO public.virksomhet VALUES (104, '842982051', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842982051', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.552046', '2022-12-05 10:42:53.552046');
INSERT INTO public.virksomhet VALUES (105, '842389667', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842389667', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.557354', '2022-12-05 10:42:53.557354');
INSERT INTO public.virksomhet VALUES (106, '820004072', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820004072', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.562108', '2022-12-05 10:42:53.562108');
INSERT INTO public.virksomhet VALUES (107, '897688257', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897688257', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.566841', '2022-12-05 10:42:53.566841');
INSERT INTO public.virksomhet VALUES (108, '837534390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837534390', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.572109', '2022-12-05 10:42:53.572109');
INSERT INTO public.virksomhet VALUES (109, '808543637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808543637', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.57691', '2022-12-05 10:42:53.57691');
INSERT INTO public.virksomhet VALUES (110, '870201888', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870201888', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.581917', '2022-12-05 10:42:53.581917');
INSERT INTO public.virksomhet VALUES (111, '817311070', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817311070', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.587369', '2022-12-05 10:42:53.587369');
INSERT INTO public.virksomhet VALUES (112, '868012776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868012776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.59259', '2022-12-05 10:42:53.59259');
INSERT INTO public.virksomhet VALUES (113, '896429753', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896429753', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.597383', '2022-12-05 10:42:53.597383');
INSERT INTO public.virksomhet VALUES (114, '851603425', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851603425', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.602194', '2022-12-05 10:42:53.602194');
INSERT INTO public.virksomhet VALUES (115, '827443317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827443317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.606901', '2022-12-05 10:42:53.606901');
INSERT INTO public.virksomhet VALUES (116, '833362642', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833362642', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.611555', '2022-12-05 10:42:53.611555');
INSERT INTO public.virksomhet VALUES (117, '882069408', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882069408', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.616323', '2022-12-05 10:42:53.616323');
INSERT INTO public.virksomhet VALUES (118, '863878944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863878944', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.621186', '2022-12-05 10:42:53.621186');
INSERT INTO public.virksomhet VALUES (119, '866558221', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866558221', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.626171', '2022-12-05 10:42:53.626171');
INSERT INTO public.virksomhet VALUES (120, '868767855', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868767855', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.630808', '2022-12-05 10:42:53.630808');
INSERT INTO public.virksomhet VALUES (121, '875885300', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875885300', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.635577', '2022-12-05 10:42:53.635577');
INSERT INTO public.virksomhet VALUES (122, '842216735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842216735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.640644', '2022-12-05 10:42:53.640644');
INSERT INTO public.virksomhet VALUES (123, '856920437', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856920437', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.644913', '2022-12-05 10:42:53.644913');
INSERT INTO public.virksomhet VALUES (124, '830858963', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830858963', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.649563', '2022-12-05 10:42:53.649563');
INSERT INTO public.virksomhet VALUES (125, '812434114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812434114', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.654329', '2022-12-05 10:42:53.654329');
INSERT INTO public.virksomhet VALUES (126, '847041353', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847041353', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.659404', '2022-12-05 10:42:53.659404');
INSERT INTO public.virksomhet VALUES (127, '803269327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803269327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.664659', '2022-12-05 10:42:53.664659');
INSERT INTO public.virksomhet VALUES (128, '843457384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843457384', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.671552', '2022-12-05 10:42:53.671552');
INSERT INTO public.virksomhet VALUES (129, '818306281', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818306281', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.678309', '2022-12-05 10:42:53.678309');
INSERT INTO public.virksomhet VALUES (130, '844449510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844449510', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.692314', '2022-12-05 10:42:53.692314');
INSERT INTO public.virksomhet VALUES (131, '867177223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867177223', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.697738', '2022-12-05 10:42:53.697738');
INSERT INTO public.virksomhet VALUES (132, '883963814', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883963814', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.704211', '2022-12-05 10:42:53.704211');
INSERT INTO public.virksomhet VALUES (133, '886253015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886253015', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.709378', '2022-12-05 10:42:53.709378');
INSERT INTO public.virksomhet VALUES (134, '895281822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895281822', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.714121', '2022-12-05 10:42:53.714121');
INSERT INTO public.virksomhet VALUES (135, '840533481', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840533481', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.719677', '2022-12-05 10:42:53.719677');
INSERT INTO public.virksomhet VALUES (136, '839216776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839216776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.725062', '2022-12-05 10:42:53.725062');
INSERT INTO public.virksomhet VALUES (137, '803533948', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803533948', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.729856', '2022-12-05 10:42:53.729856');
INSERT INTO public.virksomhet VALUES (138, '827095124', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827095124', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.735007', '2022-12-05 10:42:53.735007');
INSERT INTO public.virksomhet VALUES (139, '808251981', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808251981', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.739797', '2022-12-05 10:42:53.739797');
INSERT INTO public.virksomhet VALUES (140, '817358823', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817358823', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.744516', '2022-12-05 10:42:53.744516');
INSERT INTO public.virksomhet VALUES (141, '871910327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871910327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.749813', '2022-12-05 10:42:53.749813');
INSERT INTO public.virksomhet VALUES (142, '866587133', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866587133', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.755103', '2022-12-05 10:42:53.755103');
INSERT INTO public.virksomhet VALUES (143, '842840788', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842840788', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.76018', '2022-12-05 10:42:53.76018');
INSERT INTO public.virksomhet VALUES (144, '812781923', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812781923', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.764789', '2022-12-05 10:42:53.764789');
INSERT INTO public.virksomhet VALUES (145, '804058381', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804058381', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.769652', '2022-12-05 10:42:53.769652');
INSERT INTO public.virksomhet VALUES (146, '811423248', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811423248', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.77491', '2022-12-05 10:42:53.77491');
INSERT INTO public.virksomhet VALUES (147, '840837641', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840837641', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.779905', '2022-12-05 10:42:53.779905');
INSERT INTO public.virksomhet VALUES (148, '818816392', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818816392', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.785127', '2022-12-05 10:42:53.785127');
INSERT INTO public.virksomhet VALUES (149, '806494928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806494928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.790101', '2022-12-05 10:42:53.790101');
INSERT INTO public.virksomhet VALUES (150, '893055618', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893055618', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.794968', '2022-12-05 10:42:53.794968');
INSERT INTO public.virksomhet VALUES (151, '875340822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875340822', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.800241', '2022-12-05 10:42:53.800241');
INSERT INTO public.virksomhet VALUES (152, '818463756', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818463756', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.805311', '2022-12-05 10:42:53.805311');
INSERT INTO public.virksomhet VALUES (153, '884152302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884152302', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.810387', '2022-12-05 10:42:53.810387');
INSERT INTO public.virksomhet VALUES (154, '849742742', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849742742', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.816373', '2022-12-05 10:42:53.816373');
INSERT INTO public.virksomhet VALUES (155, '804979817', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804979817', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.821351', '2022-12-05 10:42:53.821351');
INSERT INTO public.virksomhet VALUES (156, '814190896', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814190896', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.826585', '2022-12-05 10:42:53.826585');
INSERT INTO public.virksomhet VALUES (157, '822331640', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822331640', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.832268', '2022-12-05 10:42:53.832268');
INSERT INTO public.virksomhet VALUES (158, '862678317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862678317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.837527', '2022-12-05 10:42:53.837527');
INSERT INTO public.virksomhet VALUES (159, '831093023', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831093023', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.841719', '2022-12-05 10:42:53.841719');
INSERT INTO public.virksomhet VALUES (160, '874226454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874226454', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.847069', '2022-12-05 10:42:53.847069');
INSERT INTO public.virksomhet VALUES (161, '832436811', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832436811', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.853331', '2022-12-05 10:42:53.853331');
INSERT INTO public.virksomhet VALUES (162, '838432048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838432048', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.858971', '2022-12-05 10:42:53.858971');
INSERT INTO public.virksomhet VALUES (163, '870022919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870022919', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.863815', '2022-12-05 10:42:53.863815');
INSERT INTO public.virksomhet VALUES (164, '879268334', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879268334', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.868599', '2022-12-05 10:42:53.868599');
INSERT INTO public.virksomhet VALUES (165, '806599852', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806599852', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.873021', '2022-12-05 10:42:53.873021');
INSERT INTO public.virksomhet VALUES (166, '863181199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863181199', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.878078', '2022-12-05 10:42:53.878078');
INSERT INTO public.virksomhet VALUES (167, '863767568', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863767568', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.883352', '2022-12-05 10:42:53.883352');
INSERT INTO public.virksomhet VALUES (168, '844014636', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844014636', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.888024', '2022-12-05 10:42:53.888024');
INSERT INTO public.virksomhet VALUES (169, '866404710', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866404710', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.892678', '2022-12-05 10:42:53.892678');
INSERT INTO public.virksomhet VALUES (170, '833129946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833129946', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.897188', '2022-12-05 10:42:53.897188');
INSERT INTO public.virksomhet VALUES (171, '846977998', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846977998', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.90171', '2022-12-05 10:42:53.90171');
INSERT INTO public.virksomhet VALUES (172, '811030348', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811030348', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.906119', '2022-12-05 10:42:53.906119');
INSERT INTO public.virksomhet VALUES (173, '890815907', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890815907', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.910695', '2022-12-05 10:42:53.910695');
INSERT INTO public.virksomhet VALUES (174, '822694021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822694021', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.915284', '2022-12-05 10:42:53.915284');
INSERT INTO public.virksomhet VALUES (175, '852558904', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852558904', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.920084', '2022-12-05 10:42:53.920084');
INSERT INTO public.virksomhet VALUES (176, '822874914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822874914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.92611', '2022-12-05 10:42:53.92611');
INSERT INTO public.virksomhet VALUES (177, '866646453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866646453', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.930977', '2022-12-05 10:42:53.930977');
INSERT INTO public.virksomhet VALUES (178, '881021956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881021956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.936009', '2022-12-05 10:42:53.936009');
INSERT INTO public.virksomhet VALUES (179, '899291735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899291735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.940779', '2022-12-05 10:42:53.940779');
INSERT INTO public.virksomhet VALUES (180, '867918928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867918928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.945077', '2022-12-05 10:42:53.945077');
INSERT INTO public.virksomhet VALUES (181, '823439458', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823439458', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.950067', '2022-12-05 10:42:53.950067');
INSERT INTO public.virksomhet VALUES (182, '837805347', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837805347', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.955311', '2022-12-05 10:42:53.955311');
INSERT INTO public.virksomhet VALUES (183, '805499088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805499088', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.96007', '2022-12-05 10:42:53.96007');
INSERT INTO public.virksomhet VALUES (184, '845822610', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845822610', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.964616', '2022-12-05 10:42:53.964616');
INSERT INTO public.virksomhet VALUES (185, '841405633', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841405633', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.968979', '2022-12-05 10:42:53.968979');
INSERT INTO public.virksomhet VALUES (186, '889675608', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889675608', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.9736', '2022-12-05 10:42:53.9736');
INSERT INTO public.virksomhet VALUES (187, '899025387', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899025387', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.978864', '2022-12-05 10:42:53.978864');
INSERT INTO public.virksomhet VALUES (188, '863280835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863280835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.983874', '2022-12-05 10:42:53.983874');
INSERT INTO public.virksomhet VALUES (189, '860629673', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860629673', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.98882', '2022-12-05 10:42:53.98882');
INSERT INTO public.virksomhet VALUES (190, '833667497', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833667497', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.994123', '2022-12-05 10:42:53.994123');
INSERT INTO public.virksomhet VALUES (191, '842471044', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842471044', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:53.998913', '2022-12-05 10:42:53.998913');
INSERT INTO public.virksomhet VALUES (192, '861459803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861459803', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.003861', '2022-12-05 10:42:54.003861');
INSERT INTO public.virksomhet VALUES (193, '812926032', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812926032', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.00945', '2022-12-05 10:42:54.00945');
INSERT INTO public.virksomhet VALUES (194, '871631319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871631319', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.014441', '2022-12-05 10:42:54.014441');
INSERT INTO public.virksomhet VALUES (195, '865439281', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865439281', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.019263', '2022-12-05 10:42:54.019263');
INSERT INTO public.virksomhet VALUES (196, '824210548', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824210548', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.023986', '2022-12-05 10:42:54.023986');
INSERT INTO public.virksomhet VALUES (197, '805486005', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805486005', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.029026', '2022-12-05 10:42:54.029026');
INSERT INTO public.virksomhet VALUES (198, '832448472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832448472', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.033912', '2022-12-05 10:42:54.033912');
INSERT INTO public.virksomhet VALUES (199, '805820685', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805820685', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.03844', '2022-12-05 10:42:54.03844');
INSERT INTO public.virksomhet VALUES (200, '883768894', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883768894', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.042874', '2022-12-05 10:42:54.042874');
INSERT INTO public.virksomhet VALUES (201, '856903021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856903021', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.047851', '2022-12-05 10:42:54.047851');
INSERT INTO public.virksomhet VALUES (202, '850012745', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850012745', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.052483', '2022-12-05 10:42:54.052483');
INSERT INTO public.virksomhet VALUES (203, '820149848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820149848', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.057436', '2022-12-05 10:42:54.057436');
INSERT INTO public.virksomhet VALUES (204, '822705108', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822705108', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.062245', '2022-12-05 10:42:54.062245');
INSERT INTO public.virksomhet VALUES (205, '857573851', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857573851', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.067263', '2022-12-05 10:42:54.067263');
INSERT INTO public.virksomhet VALUES (206, '856078198', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856078198', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.072125', '2022-12-05 10:42:54.072125');
INSERT INTO public.virksomhet VALUES (207, '859225721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859225721', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.077081', '2022-12-05 10:42:54.077081');
INSERT INTO public.virksomhet VALUES (208, '873879874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873879874', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.082412', '2022-12-05 10:42:54.082412');
INSERT INTO public.virksomhet VALUES (209, '890065285', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890065285', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.088126', '2022-12-05 10:42:54.088126');
INSERT INTO public.virksomhet VALUES (210, '893423280', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893423280', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.093782', '2022-12-05 10:42:54.093782');
INSERT INTO public.virksomhet VALUES (211, '816273126', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816273126', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.099239', '2022-12-05 10:42:54.099239');
INSERT INTO public.virksomhet VALUES (212, '874977909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874977909', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.104163', '2022-12-05 10:42:54.104163');
INSERT INTO public.virksomhet VALUES (213, '888632161', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888632161', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.111254', '2022-12-05 10:42:54.111254');
INSERT INTO public.virksomhet VALUES (214, '852452427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852452427', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.11715', '2022-12-05 10:42:54.11715');
INSERT INTO public.virksomhet VALUES (215, '807389236', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807389236', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.123287', '2022-12-05 10:42:54.123287');
INSERT INTO public.virksomhet VALUES (216, '833163111', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833163111', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.129054', '2022-12-05 10:42:54.129054');
INSERT INTO public.virksomhet VALUES (217, '813080832', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813080832', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.133651', '2022-12-05 10:42:54.133651');
INSERT INTO public.virksomhet VALUES (218, '896489260', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896489260', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.139418', '2022-12-05 10:42:54.139418');
INSERT INTO public.virksomhet VALUES (219, '845881839', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845881839', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.144427', '2022-12-05 10:42:54.144427');
INSERT INTO public.virksomhet VALUES (220, '898157169', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898157169', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.150259', '2022-12-05 10:42:54.150259');
INSERT INTO public.virksomhet VALUES (221, '882940656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882940656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.155201', '2022-12-05 10:42:54.155201');
INSERT INTO public.virksomhet VALUES (222, '887589106', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887589106', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.161018', '2022-12-05 10:42:54.161018');
INSERT INTO public.virksomhet VALUES (223, '856439808', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856439808', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.166416', '2022-12-05 10:42:54.166416');
INSERT INTO public.virksomhet VALUES (224, '869911712', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869911712', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.172105', '2022-12-05 10:42:54.172105');
INSERT INTO public.virksomhet VALUES (225, '836420677', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836420677', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.184658', '2022-12-05 10:42:54.184658');
INSERT INTO public.virksomhet VALUES (226, '810521018', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810521018', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.194487', '2022-12-05 10:42:54.194487');
INSERT INTO public.virksomhet VALUES (227, '863021621', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863021621', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.202233', '2022-12-05 10:42:54.202233');
INSERT INTO public.virksomhet VALUES (228, '846289494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846289494', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.207254', '2022-12-05 10:42:54.207254');
INSERT INTO public.virksomhet VALUES (229, '834191416', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834191416', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.212089', '2022-12-05 10:42:54.212089');
INSERT INTO public.virksomhet VALUES (230, '837420340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837420340', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.2168', '2022-12-05 10:42:54.2168');
INSERT INTO public.virksomhet VALUES (231, '871949311', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871949311', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.221852', '2022-12-05 10:42:54.221852');
INSERT INTO public.virksomhet VALUES (232, '821633142', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821633142', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.226819', '2022-12-05 10:42:54.226819');
INSERT INTO public.virksomhet VALUES (233, '893463166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893463166', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.231348', '2022-12-05 10:42:54.231348');
INSERT INTO public.virksomhet VALUES (234, '833218825', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833218825', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.235978', '2022-12-05 10:42:54.235978');
INSERT INTO public.virksomhet VALUES (235, '807456455', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807456455', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.241539', '2022-12-05 10:42:54.241539');
INSERT INTO public.virksomhet VALUES (236, '821381486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821381486', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.247713', '2022-12-05 10:42:54.247713');
INSERT INTO public.virksomhet VALUES (237, '814324199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814324199', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.252514', '2022-12-05 10:42:54.252514');
INSERT INTO public.virksomhet VALUES (238, '805904949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805904949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.257086', '2022-12-05 10:42:54.257086');
INSERT INTO public.virksomhet VALUES (239, '813242515', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813242515', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.262175', '2022-12-05 10:42:54.262175');
INSERT INTO public.virksomhet VALUES (240, '839415843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839415843', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.267068', '2022-12-05 10:42:54.267068');
INSERT INTO public.virksomhet VALUES (241, '804234371', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804234371', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.271697', '2022-12-05 10:42:54.271697');
INSERT INTO public.virksomhet VALUES (242, '816585946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816585946', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.276391', '2022-12-05 10:42:54.276391');
INSERT INTO public.virksomhet VALUES (243, '824097835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824097835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.28154', '2022-12-05 10:42:54.28154');
INSERT INTO public.virksomhet VALUES (244, '880538674', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880538674', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.286194', '2022-12-05 10:42:54.286194');
INSERT INTO public.virksomhet VALUES (245, '875775705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875775705', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.291844', '2022-12-05 10:42:54.291844');
INSERT INTO public.virksomhet VALUES (246, '877421692', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877421692', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.297001', '2022-12-05 10:42:54.297001');
INSERT INTO public.virksomhet VALUES (247, '871547736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871547736', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.301991', '2022-12-05 10:42:54.301991');
INSERT INTO public.virksomhet VALUES (248, '857653378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857653378', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.30714', '2022-12-05 10:42:54.30714');
INSERT INTO public.virksomhet VALUES (249, '829980700', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829980700', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.312309', '2022-12-05 10:42:54.312309');
INSERT INTO public.virksomhet VALUES (250, '852627790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852627790', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.317528', '2022-12-05 10:42:54.317528');
INSERT INTO public.virksomhet VALUES (251, '865978526', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865978526', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.322712', '2022-12-05 10:42:54.322712');
INSERT INTO public.virksomhet VALUES (252, '840145629', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840145629', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.327769', '2022-12-05 10:42:54.327769');
INSERT INTO public.virksomhet VALUES (253, '875016141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875016141', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.332326', '2022-12-05 10:42:54.332326');
INSERT INTO public.virksomhet VALUES (254, '869419134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869419134', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.337663', '2022-12-05 10:42:54.337663');
INSERT INTO public.virksomhet VALUES (255, '813944600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813944600', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.34313', '2022-12-05 10:42:54.34313');
INSERT INTO public.virksomhet VALUES (256, '885600454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885600454', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.34845', '2022-12-05 10:42:54.34845');
INSERT INTO public.virksomhet VALUES (257, '877550656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877550656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.353658', '2022-12-05 10:42:54.353658');
INSERT INTO public.virksomhet VALUES (258, '804227830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804227830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.359026', '2022-12-05 10:42:54.359026');
INSERT INTO public.virksomhet VALUES (259, '858956619', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858956619', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.364125', '2022-12-05 10:42:54.364125');
INSERT INTO public.virksomhet VALUES (260, '865153645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865153645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.369141', '2022-12-05 10:42:54.369141');
INSERT INTO public.virksomhet VALUES (261, '817941723', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817941723', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.373961', '2022-12-05 10:42:54.373961');
INSERT INTO public.virksomhet VALUES (262, '811667993', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811667993', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.381822', '2022-12-05 10:42:54.381822');
INSERT INTO public.virksomhet VALUES (263, '859462534', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859462534', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.387313', '2022-12-05 10:42:54.387313');
INSERT INTO public.virksomhet VALUES (264, '822317092', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822317092', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.392068', '2022-12-05 10:42:54.392068');
INSERT INTO public.virksomhet VALUES (265, '877772835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877772835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.396395', '2022-12-05 10:42:54.396395');
INSERT INTO public.virksomhet VALUES (266, '846495295', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846495295', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.400737', '2022-12-05 10:42:54.400737');
INSERT INTO public.virksomhet VALUES (267, '804775869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804775869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.405882', '2022-12-05 10:42:54.405882');
INSERT INTO public.virksomhet VALUES (268, '831030012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831030012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.410257', '2022-12-05 10:42:54.410257');
INSERT INTO public.virksomhet VALUES (269, '802809462', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802809462', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.414785', '2022-12-05 10:42:54.414785');
INSERT INTO public.virksomhet VALUES (270, '896200151', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896200151', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.419322', '2022-12-05 10:42:54.419322');
INSERT INTO public.virksomhet VALUES (271, '873610100', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873610100', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.423377', '2022-12-05 10:42:54.423377');
INSERT INTO public.virksomhet VALUES (272, '847931581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847931581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.429226', '2022-12-05 10:42:54.429226');
INSERT INTO public.virksomhet VALUES (273, '870810427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870810427', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.433844', '2022-12-05 10:42:54.433844');
INSERT INTO public.virksomhet VALUES (274, '816457914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816457914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.43875', '2022-12-05 10:42:54.43875');
INSERT INTO public.virksomhet VALUES (275, '816760477', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816760477', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.443194', '2022-12-05 10:42:54.443194');
INSERT INTO public.virksomhet VALUES (276, '821449527', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821449527', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.447864', '2022-12-05 10:42:54.447864');
INSERT INTO public.virksomhet VALUES (277, '897412997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897412997', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.452739', '2022-12-05 10:42:54.452739');
INSERT INTO public.virksomhet VALUES (278, '801856356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801856356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.457399', '2022-12-05 10:42:54.457399');
INSERT INTO public.virksomhet VALUES (279, '898170941', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898170941', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.461843', '2022-12-05 10:42:54.461843');
INSERT INTO public.virksomhet VALUES (280, '884390144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884390144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.46658', '2022-12-05 10:42:54.46658');
INSERT INTO public.virksomhet VALUES (281, '894424841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894424841', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.47077', '2022-12-05 10:42:54.47077');
INSERT INTO public.virksomhet VALUES (282, '828972512', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828972512', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.47502', '2022-12-05 10:42:54.47502');
INSERT INTO public.virksomhet VALUES (283, '815082581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815082581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.479748', '2022-12-05 10:42:54.479748');
INSERT INTO public.virksomhet VALUES (284, '887159012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887159012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.484195', '2022-12-05 10:42:54.484195');
INSERT INTO public.virksomhet VALUES (285, '829493874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829493874', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.488732', '2022-12-05 10:42:54.488732');
INSERT INTO public.virksomhet VALUES (286, '814929193', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814929193', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.493475', '2022-12-05 10:42:54.493475');
INSERT INTO public.virksomhet VALUES (287, '859907302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859907302', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.498198', '2022-12-05 10:42:54.498198');
INSERT INTO public.virksomhet VALUES (288, '895124699', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895124699', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.503211', '2022-12-05 10:42:54.503211');
INSERT INTO public.virksomhet VALUES (289, '813239227', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813239227', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.509309', '2022-12-05 10:42:54.509309');
INSERT INTO public.virksomhet VALUES (290, '840430296', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840430296', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.514016', '2022-12-05 10:42:54.514016');
INSERT INTO public.virksomhet VALUES (291, '858726639', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858726639', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.518694', '2022-12-05 10:42:54.518694');
INSERT INTO public.virksomhet VALUES (292, '823234800', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823234800', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.523744', '2022-12-05 10:42:54.523744');
INSERT INTO public.virksomhet VALUES (293, '874361830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874361830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.528779', '2022-12-05 10:42:54.528779');
INSERT INTO public.virksomhet VALUES (294, '808481735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808481735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.534055', '2022-12-05 10:42:54.534055');
INSERT INTO public.virksomhet VALUES (295, '860499175', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860499175', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.539779', '2022-12-05 10:42:54.539779');
INSERT INTO public.virksomhet VALUES (296, '892697142', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892697142', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.544516', '2022-12-05 10:42:54.544516');
INSERT INTO public.virksomhet VALUES (297, '826727890', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826727890', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.549602', '2022-12-05 10:42:54.549602');
INSERT INTO public.virksomhet VALUES (298, '895582762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895582762', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.554518', '2022-12-05 10:42:54.554518');
INSERT INTO public.virksomhet VALUES (299, '814663914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814663914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.560043', '2022-12-05 10:42:54.560043');
INSERT INTO public.virksomhet VALUES (300, '887191975', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887191975', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.565004', '2022-12-05 10:42:54.565004');
INSERT INTO public.virksomhet VALUES (301, '856729012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856729012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.570314', '2022-12-05 10:42:54.570314');
INSERT INTO public.virksomhet VALUES (302, '816248533', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816248533', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.575557', '2022-12-05 10:42:54.575557');
INSERT INTO public.virksomhet VALUES (303, '847253663', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847253663', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.580607', '2022-12-05 10:42:54.580607');
INSERT INTO public.virksomhet VALUES (304, '851556995', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851556995', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.586462', '2022-12-05 10:42:54.586462');
INSERT INTO public.virksomhet VALUES (305, '897000352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897000352', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.591336', '2022-12-05 10:42:54.591336');
INSERT INTO public.virksomhet VALUES (306, '891267708', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891267708', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.595912', '2022-12-05 10:42:54.595912');
INSERT INTO public.virksomhet VALUES (307, '868369009', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868369009', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.600815', '2022-12-05 10:42:54.600815');
INSERT INTO public.virksomhet VALUES (308, '836786224', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836786224', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.605414', '2022-12-05 10:42:54.605414');
INSERT INTO public.virksomhet VALUES (309, '800910790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800910790', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.609969', '2022-12-05 10:42:54.609969');
INSERT INTO public.virksomhet VALUES (310, '847922087', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847922087', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.615933', '2022-12-05 10:42:54.615933');
INSERT INTO public.virksomhet VALUES (311, '882737279', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882737279', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.620979', '2022-12-05 10:42:54.620979');
INSERT INTO public.virksomhet VALUES (312, '817612413', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817612413', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.625474', '2022-12-05 10:42:54.625474');
INSERT INTO public.virksomhet VALUES (313, '857680168', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857680168', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.629923', '2022-12-05 10:42:54.629923');
INSERT INTO public.virksomhet VALUES (314, '878624841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878624841', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.634271', '2022-12-05 10:42:54.634271');
INSERT INTO public.virksomhet VALUES (315, '867183919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867183919', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.640589', '2022-12-05 10:42:54.640589');
INSERT INTO public.virksomhet VALUES (316, '824306551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824306551', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.645279', '2022-12-05 10:42:54.645279');
INSERT INTO public.virksomhet VALUES (317, '812929350', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812929350', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.649733', '2022-12-05 10:42:54.649733');
INSERT INTO public.virksomhet VALUES (318, '890735735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890735735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.654455', '2022-12-05 10:42:54.654455');
INSERT INTO public.virksomhet VALUES (319, '894341616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894341616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.659392', '2022-12-05 10:42:54.659392');
INSERT INTO public.virksomhet VALUES (320, '845690609', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845690609', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.664067', '2022-12-05 10:42:54.664067');
INSERT INTO public.virksomhet VALUES (321, '884945724', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884945724', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.669216', '2022-12-05 10:42:54.669216');
INSERT INTO public.virksomhet VALUES (322, '820865124', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820865124', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.673941', '2022-12-05 10:42:54.673941');
INSERT INTO public.virksomhet VALUES (323, '870514368', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870514368', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.678571', '2022-12-05 10:42:54.678571');
INSERT INTO public.virksomhet VALUES (324, '833643869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833643869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.682949', '2022-12-05 10:42:54.682949');
INSERT INTO public.virksomhet VALUES (325, '807702188', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807702188', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.691082', '2022-12-05 10:42:54.691082');
INSERT INTO public.virksomhet VALUES (326, '820638689', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820638689', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.698333', '2022-12-05 10:42:54.698333');
INSERT INTO public.virksomhet VALUES (327, '843380901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843380901', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.703423', '2022-12-05 10:42:54.703423');
INSERT INTO public.virksomhet VALUES (328, '832951634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832951634', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.708872', '2022-12-05 10:42:54.708872');
INSERT INTO public.virksomhet VALUES (329, '833677243', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833677243', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.713516', '2022-12-05 10:42:54.713516');
INSERT INTO public.virksomhet VALUES (330, '873656323', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873656323', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.717994', '2022-12-05 10:42:54.717994');
INSERT INTO public.virksomhet VALUES (331, '859159231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859159231', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.722524', '2022-12-05 10:42:54.722524');
INSERT INTO public.virksomhet VALUES (332, '868067017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868067017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.726981', '2022-12-05 10:42:54.726981');
INSERT INTO public.virksomhet VALUES (333, '856435712', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856435712', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.731891', '2022-12-05 10:42:54.731891');
INSERT INTO public.virksomhet VALUES (334, '888937591', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888937591', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.736359', '2022-12-05 10:42:54.736359');
INSERT INTO public.virksomhet VALUES (335, '873906284', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873906284', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.740925', '2022-12-05 10:42:54.740925');
INSERT INTO public.virksomhet VALUES (336, '855150484', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855150484', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.745273', '2022-12-05 10:42:54.745273');
INSERT INTO public.virksomhet VALUES (337, '836365546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836365546', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.749387', '2022-12-05 10:42:54.749387');
INSERT INTO public.virksomhet VALUES (338, '822564929', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822564929', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.753783', '2022-12-05 10:42:54.753783');
INSERT INTO public.virksomhet VALUES (339, '833204596', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833204596', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.758377', '2022-12-05 10:42:54.758377');
INSERT INTO public.virksomhet VALUES (340, '863592645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863592645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.762543', '2022-12-05 10:42:54.762543');
INSERT INTO public.virksomhet VALUES (341, '865956727', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865956727', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.767202', '2022-12-05 10:42:54.767202');
INSERT INTO public.virksomhet VALUES (342, '807629933', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807629933', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.772032', '2022-12-05 10:42:54.772032');
INSERT INTO public.virksomhet VALUES (343, '832454631', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832454631', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.776641', '2022-12-05 10:42:54.776641');
INSERT INTO public.virksomhet VALUES (344, '823356725', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823356725', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.780867', '2022-12-05 10:42:54.780867');
INSERT INTO public.virksomhet VALUES (345, '800824855', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800824855', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.785177', '2022-12-05 10:42:54.785177');
INSERT INTO public.virksomhet VALUES (346, '894510083', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894510083', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.789612', '2022-12-05 10:42:54.789612');
INSERT INTO public.virksomhet VALUES (347, '815854671', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815854671', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.794036', '2022-12-05 10:42:54.794036');
INSERT INTO public.virksomhet VALUES (348, '876401827', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876401827', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.798931', '2022-12-05 10:42:54.798931');
INSERT INTO public.virksomhet VALUES (349, '845066027', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845066027', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.803519', '2022-12-05 10:42:54.803519');
INSERT INTO public.virksomhet VALUES (350, '815406101', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815406101', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.808266', '2022-12-05 10:42:54.808266');
INSERT INTO public.virksomhet VALUES (351, '866878310', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866878310', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.812648', '2022-12-05 10:42:54.812648');
INSERT INTO public.virksomhet VALUES (352, '830803739', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830803739', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.81692', '2022-12-05 10:42:54.81692');
INSERT INTO public.virksomhet VALUES (353, '805933483', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805933483', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.821239', '2022-12-05 10:42:54.821239');
INSERT INTO public.virksomhet VALUES (354, '868252144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868252144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.82548', '2022-12-05 10:42:54.82548');
INSERT INTO public.virksomhet VALUES (355, '828744326', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828744326', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.829758', '2022-12-05 10:42:54.829758');
INSERT INTO public.virksomhet VALUES (356, '830122600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830122600', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.834416', '2022-12-05 10:42:54.834416');
INSERT INTO public.virksomhet VALUES (357, '813147327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813147327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.83894', '2022-12-05 10:42:54.83894');
INSERT INTO public.virksomhet VALUES (358, '846250295', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846250295', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.843505', '2022-12-05 10:42:54.843505');
INSERT INTO public.virksomhet VALUES (359, '898250721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898250721', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.848571', '2022-12-05 10:42:54.848571');
INSERT INTO public.virksomhet VALUES (360, '813697349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813697349', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.853796', '2022-12-05 10:42:54.853796');
INSERT INTO public.virksomhet VALUES (361, '863104800', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863104800', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.858639', '2022-12-05 10:42:54.858639');
INSERT INTO public.virksomhet VALUES (362, '897979593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897979593', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.863279', '2022-12-05 10:42:54.863279');
INSERT INTO public.virksomhet VALUES (363, '860772161', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860772161', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.867987', '2022-12-05 10:42:54.867987');
INSERT INTO public.virksomhet VALUES (364, '808002552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808002552', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.872681', '2022-12-05 10:42:54.872681');
INSERT INTO public.virksomhet VALUES (365, '876394411', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876394411', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.87765', '2022-12-05 10:42:54.87765');
INSERT INTO public.virksomhet VALUES (366, '846214156', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846214156', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.882019', '2022-12-05 10:42:54.882019');
INSERT INTO public.virksomhet VALUES (367, '850015354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850015354', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.887933', '2022-12-05 10:42:54.887933');
INSERT INTO public.virksomhet VALUES (368, '805145991', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805145991', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.892418', '2022-12-05 10:42:54.892418');
INSERT INTO public.virksomhet VALUES (369, '853879838', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853879838', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.896668', '2022-12-05 10:42:54.896668');
INSERT INTO public.virksomhet VALUES (370, '882939801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882939801', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.901835', '2022-12-05 10:42:54.901835');
INSERT INTO public.virksomhet VALUES (371, '859605190', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859605190', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.906499', '2022-12-05 10:42:54.906499');
INSERT INTO public.virksomhet VALUES (372, '891814367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891814367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.911345', '2022-12-05 10:42:54.911345');
INSERT INTO public.virksomhet VALUES (373, '875021136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875021136', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.915666', '2022-12-05 10:42:54.915666');
INSERT INTO public.virksomhet VALUES (374, '825379831', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825379831', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.920326', '2022-12-05 10:42:54.920326');
INSERT INTO public.virksomhet VALUES (375, '800469195', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800469195', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.924718', '2022-12-05 10:42:54.924718');
INSERT INTO public.virksomhet VALUES (376, '871244244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871244244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.929922', '2022-12-05 10:42:54.929922');
INSERT INTO public.virksomhet VALUES (377, '837133219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837133219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.935369', '2022-12-05 10:42:54.935369');
INSERT INTO public.virksomhet VALUES (378, '855964219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855964219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.940687', '2022-12-05 10:42:54.940687');
INSERT INTO public.virksomhet VALUES (379, '838273484', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838273484', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.94519', '2022-12-05 10:42:54.94519');
INSERT INTO public.virksomhet VALUES (380, '893483616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893483616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.949569', '2022-12-05 10:42:54.949569');
INSERT INTO public.virksomhet VALUES (381, '891497759', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891497759', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.95401', '2022-12-05 10:42:54.95401');
INSERT INTO public.virksomhet VALUES (382, '888247901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888247901', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.959265', '2022-12-05 10:42:54.959265');
INSERT INTO public.virksomhet VALUES (383, '883590490', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883590490', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.963744', '2022-12-05 10:42:54.963744');
INSERT INTO public.virksomhet VALUES (384, '804908767', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804908767', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.968066', '2022-12-05 10:42:54.968066');
INSERT INTO public.virksomhet VALUES (385, '851919134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851919134', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.973228', '2022-12-05 10:42:54.973228');
INSERT INTO public.virksomhet VALUES (386, '813682750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813682750', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.977774', '2022-12-05 10:42:54.977774');
INSERT INTO public.virksomhet VALUES (387, '875544956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875544956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.981689', '2022-12-05 10:42:54.981689');
INSERT INTO public.virksomhet VALUES (388, '889472231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889472231', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.985971', '2022-12-05 10:42:54.985971');
INSERT INTO public.virksomhet VALUES (389, '875631634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875631634', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.990037', '2022-12-05 10:42:54.990037');
INSERT INTO public.virksomhet VALUES (390, '856007783', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856007783', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.994331', '2022-12-05 10:42:54.994331');
INSERT INTO public.virksomhet VALUES (391, '844760467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844760467', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:54.99859', '2022-12-05 10:42:54.99859');
INSERT INTO public.virksomhet VALUES (392, '863256691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863256691', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.00466', '2022-12-05 10:42:55.00466');
INSERT INTO public.virksomhet VALUES (393, '851705582', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851705582', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.009334', '2022-12-05 10:42:55.009334');
INSERT INTO public.virksomhet VALUES (394, '854298834', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854298834', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.013907', '2022-12-05 10:42:55.013907');
INSERT INTO public.virksomhet VALUES (395, '836216435', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836216435', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.018078', '2022-12-05 10:42:55.018078');
INSERT INTO public.virksomhet VALUES (396, '893017297', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893017297', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.022444', '2022-12-05 10:42:55.022444');
INSERT INTO public.virksomhet VALUES (397, '841372032', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841372032', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.026797', '2022-12-05 10:42:55.026797');
INSERT INTO public.virksomhet VALUES (398, '862589424', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862589424', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.031241', '2022-12-05 10:42:55.031241');
INSERT INTO public.virksomhet VALUES (399, '871501781', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871501781', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.036484', '2022-12-05 10:42:55.036484');
INSERT INTO public.virksomhet VALUES (400, '880977356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880977356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.040769', '2022-12-05 10:42:55.040769');
INSERT INTO public.virksomhet VALUES (401, '859708655', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859708655', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.045559', '2022-12-05 10:42:55.045559');
INSERT INTO public.virksomhet VALUES (402, '837130075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837130075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.050063', '2022-12-05 10:42:55.050063');
INSERT INTO public.virksomhet VALUES (403, '803170681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803170681', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.054398', '2022-12-05 10:42:55.054398');
INSERT INTO public.virksomhet VALUES (404, '875018446', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875018446', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.058729', '2022-12-05 10:42:55.058729');
INSERT INTO public.virksomhet VALUES (405, '872251225', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872251225', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.063005', '2022-12-05 10:42:55.063005');
INSERT INTO public.virksomhet VALUES (406, '889927472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889927472', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.067274', '2022-12-05 10:42:55.067274');
INSERT INTO public.virksomhet VALUES (407, '850310272', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850310272', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.071573', '2022-12-05 10:42:55.071573');
INSERT INTO public.virksomhet VALUES (408, '878277970', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878277970', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.076279', '2022-12-05 10:42:55.076279');
INSERT INTO public.virksomhet VALUES (409, '811324382', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811324382', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.080624', '2022-12-05 10:42:55.080624');
INSERT INTO public.virksomhet VALUES (410, '878265174', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878265174', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.084736', '2022-12-05 10:42:55.084736');
INSERT INTO public.virksomhet VALUES (411, '803799726', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803799726', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.088764', '2022-12-05 10:42:55.088764');
INSERT INTO public.virksomhet VALUES (412, '827344157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827344157', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.092542', '2022-12-05 10:42:55.092542');
INSERT INTO public.virksomhet VALUES (413, '868610918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868610918', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.096371', '2022-12-05 10:42:55.096371');
INSERT INTO public.virksomhet VALUES (414, '891144647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891144647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.100498', '2022-12-05 10:42:55.100498');
INSERT INTO public.virksomhet VALUES (415, '874750888', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874750888', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.104547', '2022-12-05 10:42:55.104547');
INSERT INTO public.virksomhet VALUES (416, '879572863', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879572863', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.108577', '2022-12-05 10:42:55.108577');
INSERT INTO public.virksomhet VALUES (417, '816719384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816719384', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.112426', '2022-12-05 10:42:55.112426');
INSERT INTO public.virksomhet VALUES (418, '823372812', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823372812', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.116423', '2022-12-05 10:42:55.116423');
INSERT INTO public.virksomhet VALUES (419, '872671153', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872671153', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.120323', '2022-12-05 10:42:55.120323');
INSERT INTO public.virksomhet VALUES (420, '837782686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837782686', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.124453', '2022-12-05 10:42:55.124453');
INSERT INTO public.virksomhet VALUES (421, '856373244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856373244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.12871', '2022-12-05 10:42:55.12871');
INSERT INTO public.virksomhet VALUES (422, '802319687', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802319687', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.133308', '2022-12-05 10:42:55.133308');
INSERT INTO public.virksomhet VALUES (423, '882221112', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882221112', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.137788', '2022-12-05 10:42:55.137788');
INSERT INTO public.virksomhet VALUES (424, '825823538', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825823538', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.142171', '2022-12-05 10:42:55.142171');
INSERT INTO public.virksomhet VALUES (425, '840744367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840744367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.146345', '2022-12-05 10:42:55.146345');
INSERT INTO public.virksomhet VALUES (426, '807485242', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807485242', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.150869', '2022-12-05 10:42:55.150869');
INSERT INTO public.virksomhet VALUES (427, '878321914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878321914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.155214', '2022-12-05 10:42:55.155214');
INSERT INTO public.virksomhet VALUES (428, '886892017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886892017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.159673', '2022-12-05 10:42:55.159673');
INSERT INTO public.virksomhet VALUES (429, '871623349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871623349', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.164986', '2022-12-05 10:42:55.164986');
INSERT INTO public.virksomhet VALUES (430, '864986459', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864986459', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.16954', '2022-12-05 10:42:55.16954');
INSERT INTO public.virksomhet VALUES (431, '849227492', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849227492', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.174586', '2022-12-05 10:42:55.174586');
INSERT INTO public.virksomhet VALUES (432, '850910144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850910144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.179162', '2022-12-05 10:42:55.179162');
INSERT INTO public.virksomhet VALUES (433, '869658223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869658223', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.183845', '2022-12-05 10:42:55.183845');
INSERT INTO public.virksomhet VALUES (434, '866431270', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866431270', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.187961', '2022-12-05 10:42:55.187961');
INSERT INTO public.virksomhet VALUES (435, '858356342', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858356342', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.194547', '2022-12-05 10:42:55.194547');
INSERT INTO public.virksomhet VALUES (436, '852467356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852467356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.199251', '2022-12-05 10:42:55.199251');
INSERT INTO public.virksomhet VALUES (437, '898657961', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898657961', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.205315', '2022-12-05 10:42:55.205315');
INSERT INTO public.virksomhet VALUES (438, '846849579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846849579', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.211027', '2022-12-05 10:42:55.211027');
INSERT INTO public.virksomhet VALUES (439, '873579899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873579899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.21576', '2022-12-05 10:42:55.21576');
INSERT INTO public.virksomhet VALUES (440, '843035298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843035298', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.220416', '2022-12-05 10:42:55.220416');
INSERT INTO public.virksomhet VALUES (441, '858836952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858836952', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.224524', '2022-12-05 10:42:55.224524');
INSERT INTO public.virksomhet VALUES (442, '805709917', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805709917', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.228665', '2022-12-05 10:42:55.228665');
INSERT INTO public.virksomhet VALUES (443, '808479485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808479485', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.232799', '2022-12-05 10:42:55.232799');
INSERT INTO public.virksomhet VALUES (444, '838878962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838878962', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.236923', '2022-12-05 10:42:55.236923');
INSERT INTO public.virksomhet VALUES (445, '885625328', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885625328', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.241364', '2022-12-05 10:42:55.241364');
INSERT INTO public.virksomhet VALUES (446, '837527996', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837527996', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.245616', '2022-12-05 10:42:55.245616');
INSERT INTO public.virksomhet VALUES (447, '844848494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844848494', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.250524', '2022-12-05 10:42:55.250524');
INSERT INTO public.virksomhet VALUES (448, '825573136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825573136', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.255269', '2022-12-05 10:42:55.255269');
INSERT INTO public.virksomhet VALUES (449, '809036318', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809036318', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.259835', '2022-12-05 10:42:55.259835');
INSERT INTO public.virksomhet VALUES (450, '800223332', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800223332', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.264457', '2022-12-05 10:42:55.264457');
INSERT INTO public.virksomhet VALUES (451, '878112453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878112453', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.269185', '2022-12-05 10:42:55.269185');
INSERT INTO public.virksomhet VALUES (452, '893781546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893781546', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.27381', '2022-12-05 10:42:55.27381');
INSERT INTO public.virksomhet VALUES (453, '818658010', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818658010', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.278574', '2022-12-05 10:42:55.278574');
INSERT INTO public.virksomhet VALUES (454, '862270603', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862270603', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.282811', '2022-12-05 10:42:55.282811');
INSERT INTO public.virksomhet VALUES (455, '812325897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812325897', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.287803', '2022-12-05 10:42:55.287803');
INSERT INTO public.virksomhet VALUES (456, '817554736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817554736', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.291896', '2022-12-05 10:42:55.291896');
INSERT INTO public.virksomhet VALUES (457, '884291457', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884291457', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.295997', '2022-12-05 10:42:55.295997');
INSERT INTO public.virksomhet VALUES (458, '890910485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890910485', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.301235', '2022-12-05 10:42:55.301235');
INSERT INTO public.virksomhet VALUES (459, '810677960', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810677960', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.305406', '2022-12-05 10:42:55.305406');
INSERT INTO public.virksomhet VALUES (460, '830621787', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830621787', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.310603', '2022-12-05 10:42:55.310603');
INSERT INTO public.virksomhet VALUES (461, '874792210', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874792210', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.315086', '2022-12-05 10:42:55.315086');
INSERT INTO public.virksomhet VALUES (462, '828718942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828718942', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.319373', '2022-12-05 10:42:55.319373');
INSERT INTO public.virksomhet VALUES (463, '846277869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846277869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.323706', '2022-12-05 10:42:55.323706');
INSERT INTO public.virksomhet VALUES (464, '809316543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809316543', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.328025', '2022-12-05 10:42:55.328025');
INSERT INTO public.virksomhet VALUES (465, '846821438', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846821438', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.3319', '2022-12-05 10:42:55.3319');
INSERT INTO public.virksomhet VALUES (466, '836005340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836005340', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.337308', '2022-12-05 10:42:55.337308');
INSERT INTO public.virksomhet VALUES (467, '869069081', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869069081', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.341507', '2022-12-05 10:42:55.341507');
INSERT INTO public.virksomhet VALUES (468, '824870495', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824870495', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.345455', '2022-12-05 10:42:55.345455');
INSERT INTO public.virksomhet VALUES (469, '821850314', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821850314', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.349729', '2022-12-05 10:42:55.349729');
INSERT INTO public.virksomhet VALUES (470, '895629317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895629317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.354519', '2022-12-05 10:42:55.354519');
INSERT INTO public.virksomhet VALUES (471, '854843256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854843256', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.359229', '2022-12-05 10:42:55.359229');
INSERT INTO public.virksomhet VALUES (472, '825397589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825397589', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.363717', '2022-12-05 10:42:55.363717');
INSERT INTO public.virksomhet VALUES (473, '856901774', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856901774', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.368218', '2022-12-05 10:42:55.368218');
INSERT INTO public.virksomhet VALUES (474, '886566656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886566656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.372256', '2022-12-05 10:42:55.372256');
INSERT INTO public.virksomhet VALUES (475, '868634250', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868634250', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.376309', '2022-12-05 10:42:55.376309');
INSERT INTO public.virksomhet VALUES (476, '827178297', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827178297', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.380416', '2022-12-05 10:42:55.380416');
INSERT INTO public.virksomhet VALUES (477, '889901026', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889901026', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.384326', '2022-12-05 10:42:55.384326');
INSERT INTO public.virksomhet VALUES (478, '860932226', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860932226', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.388482', '2022-12-05 10:42:55.388482');
INSERT INTO public.virksomhet VALUES (479, '883640440', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883640440', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.393493', '2022-12-05 10:42:55.393493');
INSERT INTO public.virksomhet VALUES (480, '899511765', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899511765', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.397958', '2022-12-05 10:42:55.397958');
INSERT INTO public.virksomhet VALUES (481, '826671551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826671551', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.402682', '2022-12-05 10:42:55.402682');
INSERT INTO public.virksomhet VALUES (482, '838991015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838991015', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.406555', '2022-12-05 10:42:55.406555');
INSERT INTO public.virksomhet VALUES (483, '831768843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831768843', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.410901', '2022-12-05 10:42:55.410901');
INSERT INTO public.virksomhet VALUES (484, '803324193', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803324193', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.415326', '2022-12-05 10:42:55.415326');
INSERT INTO public.virksomhet VALUES (485, '827269180', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827269180', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.419609', '2022-12-05 10:42:55.419609');
INSERT INTO public.virksomhet VALUES (486, '806938796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806938796', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.423557', '2022-12-05 10:42:55.423557');
INSERT INTO public.virksomhet VALUES (487, '817130185', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817130185', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.428264', '2022-12-05 10:42:55.428264');
INSERT INTO public.virksomhet VALUES (488, '810402680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810402680', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.433628', '2022-12-05 10:42:55.433628');
INSERT INTO public.virksomhet VALUES (489, '887841956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887841956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.438336', '2022-12-05 10:42:55.438336');
INSERT INTO public.virksomhet VALUES (490, '897336611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897336611', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.442822', '2022-12-05 10:42:55.442822');
INSERT INTO public.virksomhet VALUES (491, '858728795', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858728795', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.447369', '2022-12-05 10:42:55.447369');
INSERT INTO public.virksomhet VALUES (492, '880050743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880050743', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.452547', '2022-12-05 10:42:55.452547');
INSERT INTO public.virksomhet VALUES (493, '871161662', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871161662', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.457696', '2022-12-05 10:42:55.457696');
INSERT INTO public.virksomhet VALUES (494, '862924848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862924848', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.462509', '2022-12-05 10:42:55.462509');
INSERT INTO public.virksomhet VALUES (495, '895031114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895031114', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.466666', '2022-12-05 10:42:55.466666');
INSERT INTO public.virksomhet VALUES (496, '815517829', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815517829', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.470876', '2022-12-05 10:42:55.470876');
INSERT INTO public.virksomhet VALUES (497, '836666246', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836666246', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.475114', '2022-12-05 10:42:55.475114');
INSERT INTO public.virksomhet VALUES (498, '845715533', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845715533', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.479472', '2022-12-05 10:42:55.479472');
INSERT INTO public.virksomhet VALUES (499, '897156462', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897156462', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.483894', '2022-12-05 10:42:55.483894');
INSERT INTO public.virksomhet VALUES (500, '890815244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890815244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.488162', '2022-12-05 10:42:55.488162');
INSERT INTO public.virksomhet VALUES (501, '866562589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866562589', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.492909', '2022-12-05 10:42:55.492909');
INSERT INTO public.virksomhet VALUES (502, '875322390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875322390', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.49779', '2022-12-05 10:42:55.49779');
INSERT INTO public.virksomhet VALUES (503, '870376312', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870376312', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.502485', '2022-12-05 10:42:55.502485');
INSERT INTO public.virksomhet VALUES (504, '863074238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863074238', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.50748', '2022-12-05 10:42:55.50748');
INSERT INTO public.virksomhet VALUES (505, '873535604', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873535604', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.512716', '2022-12-05 10:42:55.512716');
INSERT INTO public.virksomhet VALUES (506, '820029647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820029647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.517485', '2022-12-05 10:42:55.517485');
INSERT INTO public.virksomhet VALUES (507, '825514130', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825514130', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.522409', '2022-12-05 10:42:55.522409');
INSERT INTO public.virksomhet VALUES (508, '815801592', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815801592', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.52686', '2022-12-05 10:42:55.52686');
INSERT INTO public.virksomhet VALUES (509, '839528084', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839528084', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.531422', '2022-12-05 10:42:55.531422');
INSERT INTO public.virksomhet VALUES (510, '864571830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864571830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:42:55.53598', '2022-12-05 10:42:55.53598');
INSERT INTO public.virksomhet VALUES (511, '883989256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883989256', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:43:01.547953', '2022-12-05 10:43:01.547953');
INSERT INTO public.virksomhet VALUES (512, '831272011', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '110272138 nvaN', '{adresse}', 'AKTIV', NULL, 831272012, '2022-12-05 10:43:01.554028', '2022-12-05 10:43:06.059319');
INSERT INTO public.virksomhet VALUES (513, '831658088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '880856138 nvaN', '{adresse}', 'AKTIV', NULL, 831658089, '2022-12-05 10:43:01.561788', '2022-12-05 10:43:06.068912');
INSERT INTO public.virksomhet VALUES (514, '802008121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '121800208 nvaN', '{adresse}', 'AKTIV', NULL, 802008122, '2022-12-05 10:43:01.568628', '2022-12-05 10:43:06.076999');
INSERT INTO public.virksomhet VALUES (515, '857721878', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '878127758 nvaN', '{adresse}', 'AKTIV', NULL, 857721879, '2022-12-05 10:43:01.576243', '2022-12-05 10:43:06.091558');
INSERT INTO public.virksomhet VALUES (516, '811747377', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '773747118 nvaN', '{adresse}', 'AKTIV', NULL, 811747378, '2022-12-05 10:43:01.585289', '2022-12-05 10:43:06.095218');
INSERT INTO public.virksomhet VALUES (527, '854032309', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '903230458 nvaN', '{adresse}', 'AKTIV', NULL, 854032310, '2022-12-05 10:43:01.672202', '2022-12-05 10:43:06.101941');
INSERT INTO public.virksomhet VALUES (517, '801396893', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801396893', '{adresse}', 'FJERNET', '2010-07-01', 801396894, '2022-12-05 10:43:01.595345', '2022-12-05 10:43:06.107916');
INSERT INTO public.virksomhet VALUES (518, '885133950', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885133950', '{adresse}', 'FJERNET', '2010-07-01', 885133951, '2022-12-05 10:43:01.605831', '2022-12-05 10:43:06.10943');
INSERT INTO public.virksomhet VALUES (519, '864761302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864761302', '{adresse}', 'FJERNET', '2010-07-01', 864761303, '2022-12-05 10:43:01.614904', '2022-12-05 10:43:06.110688');
INSERT INTO public.virksomhet VALUES (520, '870050263', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870050263', '{adresse}', 'FJERNET', '2010-07-01', 870050264, '2022-12-05 10:43:01.621825', '2022-12-05 10:43:06.112074');
INSERT INTO public.virksomhet VALUES (521, '881536611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881536611', '{adresse}', 'FJERNET', '2010-07-01', 881536612, '2022-12-05 10:43:01.629035', '2022-12-05 10:43:06.113363');
INSERT INTO public.virksomhet VALUES (522, '862811969', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862811969', '{adresse}', 'SLETTET', '2010-07-01', 862811970, '2022-12-05 10:43:01.635607', '2022-12-05 10:43:06.114659');
INSERT INTO public.virksomhet VALUES (523, '892708443', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892708443', '{adresse}', 'SLETTET', '2010-07-01', 892708444, '2022-12-05 10:43:01.641433', '2022-12-05 10:43:06.115866');
INSERT INTO public.virksomhet VALUES (524, '866931781', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866931781', '{adresse}', 'SLETTET', '2010-07-01', 866931782, '2022-12-05 10:43:01.64897', '2022-12-05 10:43:06.11801');
INSERT INTO public.virksomhet VALUES (525, '868378133', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868378133', '{adresse}', 'SLETTET', '2010-07-01', 868378134, '2022-12-05 10:43:01.655622', '2022-12-05 10:43:06.120214');
INSERT INTO public.virksomhet VALUES (526, '872308278', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872308278', '{adresse}', 'SLETTET', '2010-07-01', 872308279, '2022-12-05 10:43:01.664408', '2022-12-05 10:43:06.121815');
INSERT INTO public.virksomhet VALUES (534, '854620752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854620752', '{adresse}', 'AKTIV', NULL, 854620753, '2022-12-05 10:43:06.131699', '2022-12-05 10:43:06.131699');
INSERT INTO public.virksomhet VALUES (535, '813662974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813662974', '{adresse}', 'AKTIV', NULL, 813662975, '2022-12-05 10:43:06.137265', '2022-12-05 10:43:06.137265');
INSERT INTO public.virksomhet VALUES (536, '877870510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877870510', '{adresse}', 'AKTIV', NULL, 877870511, '2022-12-05 10:43:06.143071', '2022-12-05 10:43:06.143071');
INSERT INTO public.virksomhet VALUES (537, '828539481', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828539481', '{adresse}', 'AKTIV', NULL, 828539482, '2022-12-05 10:43:06.145812', '2022-12-05 10:43:06.145812');
INSERT INTO public.virksomhet VALUES (538, '833469738', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833469738', '{adresse}', 'AKTIV', NULL, 833469739, '2022-12-05 10:43:06.148764', '2022-12-05 10:43:06.148764');
INSERT INTO public.virksomhet VALUES (539, '846058502', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846058502', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:43:06.179876', '2022-12-05 10:43:06.179876');
INSERT INTO public.virksomhet VALUES (540, '878151780', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878151780', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-12-05 10:43:06.187051', '2022-12-05 10:43:06.187051');


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
INSERT INTO public.virksomhet_naring VALUES (5, '90.012');
INSERT INTO public.virksomhet_naring VALUES (6, '01.120');
INSERT INTO public.virksomhet_naring VALUES (7, '01.120');
INSERT INTO public.virksomhet_naring VALUES (8, '01.120');
INSERT INTO public.virksomhet_naring VALUES (9, '01.120');
INSERT INTO public.virksomhet_naring VALUES (10, '01.120');
INSERT INTO public.virksomhet_naring VALUES (10, '90.012');
INSERT INTO public.virksomhet_naring VALUES (11, '01.120');
INSERT INTO public.virksomhet_naring VALUES (11, '90.012');
INSERT INTO public.virksomhet_naring VALUES (11, '70.220');
INSERT INTO public.virksomhet_naring VALUES (12, '01.120');
INSERT INTO public.virksomhet_naring VALUES (13, '01.120');
INSERT INTO public.virksomhet_naring VALUES (13, '90.012');
INSERT INTO public.virksomhet_naring VALUES (14, '01.120');
INSERT INTO public.virksomhet_naring VALUES (15, '01.120');
INSERT INTO public.virksomhet_naring VALUES (16, '01.120');
INSERT INTO public.virksomhet_naring VALUES (16, '90.012');
INSERT INTO public.virksomhet_naring VALUES (16, '70.220');
INSERT INTO public.virksomhet_naring VALUES (17, '01.120');
INSERT INTO public.virksomhet_naring VALUES (18, '01.120');
INSERT INTO public.virksomhet_naring VALUES (19, '01.120');
INSERT INTO public.virksomhet_naring VALUES (19, '90.012');
INSERT INTO public.virksomhet_naring VALUES (20, '01.120');
INSERT INTO public.virksomhet_naring VALUES (20, '90.012');
INSERT INTO public.virksomhet_naring VALUES (20, '70.220');
INSERT INTO public.virksomhet_naring VALUES (21, '01.120');
INSERT INTO public.virksomhet_naring VALUES (21, '90.012');
INSERT INTO public.virksomhet_naring VALUES (21, '70.220');
INSERT INTO public.virksomhet_naring VALUES (22, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '90.012');
INSERT INTO public.virksomhet_naring VALUES (24, '01.120');
INSERT INTO public.virksomhet_naring VALUES (24, '90.012');
INSERT INTO public.virksomhet_naring VALUES (25, '01.120');
INSERT INTO public.virksomhet_naring VALUES (26, '01.120');
INSERT INTO public.virksomhet_naring VALUES (26, '90.012');
INSERT INTO public.virksomhet_naring VALUES (27, '01.120');
INSERT INTO public.virksomhet_naring VALUES (28, '01.120');
INSERT INTO public.virksomhet_naring VALUES (29, '01.120');
INSERT INTO public.virksomhet_naring VALUES (30, '01.120');
INSERT INTO public.virksomhet_naring VALUES (30, '90.012');
INSERT INTO public.virksomhet_naring VALUES (31, '01.120');
INSERT INTO public.virksomhet_naring VALUES (32, '01.120');
INSERT INTO public.virksomhet_naring VALUES (33, '01.120');
INSERT INTO public.virksomhet_naring VALUES (33, '90.012');
INSERT INTO public.virksomhet_naring VALUES (34, '01.120');
INSERT INTO public.virksomhet_naring VALUES (34, '90.012');
INSERT INTO public.virksomhet_naring VALUES (35, '01.120');
INSERT INTO public.virksomhet_naring VALUES (35, '90.012');
INSERT INTO public.virksomhet_naring VALUES (36, '01.120');
INSERT INTO public.virksomhet_naring VALUES (36, '90.012');
INSERT INTO public.virksomhet_naring VALUES (37, '01.120');
INSERT INTO public.virksomhet_naring VALUES (37, '90.012');
INSERT INTO public.virksomhet_naring VALUES (37, '70.220');
INSERT INTO public.virksomhet_naring VALUES (38, '01.120');
INSERT INTO public.virksomhet_naring VALUES (38, '90.012');
INSERT INTO public.virksomhet_naring VALUES (38, '70.220');
INSERT INTO public.virksomhet_naring VALUES (39, '01.120');
INSERT INTO public.virksomhet_naring VALUES (39, '90.012');
INSERT INTO public.virksomhet_naring VALUES (40, '01.120');
INSERT INTO public.virksomhet_naring VALUES (40, '90.012');
INSERT INTO public.virksomhet_naring VALUES (40, '70.220');
INSERT INTO public.virksomhet_naring VALUES (41, '01.120');
INSERT INTO public.virksomhet_naring VALUES (42, '01.120');
INSERT INTO public.virksomhet_naring VALUES (42, '90.012');
INSERT INTO public.virksomhet_naring VALUES (42, '70.220');
INSERT INTO public.virksomhet_naring VALUES (43, '01.120');
INSERT INTO public.virksomhet_naring VALUES (43, '90.012');
INSERT INTO public.virksomhet_naring VALUES (44, '01.120');
INSERT INTO public.virksomhet_naring VALUES (44, '90.012');
INSERT INTO public.virksomhet_naring VALUES (45, '01.120');
INSERT INTO public.virksomhet_naring VALUES (45, '90.012');
INSERT INTO public.virksomhet_naring VALUES (46, '01.120');
INSERT INTO public.virksomhet_naring VALUES (47, '01.120');
INSERT INTO public.virksomhet_naring VALUES (47, '90.012');
INSERT INTO public.virksomhet_naring VALUES (48, '01.120');
INSERT INTO public.virksomhet_naring VALUES (48, '90.012');
INSERT INTO public.virksomhet_naring VALUES (48, '70.220');
INSERT INTO public.virksomhet_naring VALUES (49, '01.120');
INSERT INTO public.virksomhet_naring VALUES (50, '01.120');
INSERT INTO public.virksomhet_naring VALUES (50, '90.012');
INSERT INTO public.virksomhet_naring VALUES (50, '70.220');
INSERT INTO public.virksomhet_naring VALUES (51, '01.120');
INSERT INTO public.virksomhet_naring VALUES (52, '01.120');
INSERT INTO public.virksomhet_naring VALUES (53, '01.120');
INSERT INTO public.virksomhet_naring VALUES (54, '01.120');
INSERT INTO public.virksomhet_naring VALUES (55, '01.120');
INSERT INTO public.virksomhet_naring VALUES (56, '01.120');
INSERT INTO public.virksomhet_naring VALUES (57, '01.120');
INSERT INTO public.virksomhet_naring VALUES (57, '90.012');
INSERT INTO public.virksomhet_naring VALUES (57, '70.220');
INSERT INTO public.virksomhet_naring VALUES (58, '01.120');
INSERT INTO public.virksomhet_naring VALUES (58, '90.012');
INSERT INTO public.virksomhet_naring VALUES (58, '70.220');
INSERT INTO public.virksomhet_naring VALUES (59, '01.120');
INSERT INTO public.virksomhet_naring VALUES (59, '90.012');
INSERT INTO public.virksomhet_naring VALUES (59, '70.220');
INSERT INTO public.virksomhet_naring VALUES (60, '01.120');
INSERT INTO public.virksomhet_naring VALUES (60, '90.012');
INSERT INTO public.virksomhet_naring VALUES (61, '01.120');
INSERT INTO public.virksomhet_naring VALUES (61, '90.012');
INSERT INTO public.virksomhet_naring VALUES (61, '70.220');
INSERT INTO public.virksomhet_naring VALUES (62, '01.120');
INSERT INTO public.virksomhet_naring VALUES (63, '01.120');
INSERT INTO public.virksomhet_naring VALUES (64, '01.120');
INSERT INTO public.virksomhet_naring VALUES (64, '90.012');
INSERT INTO public.virksomhet_naring VALUES (65, '01.120');
INSERT INTO public.virksomhet_naring VALUES (65, '90.012');
INSERT INTO public.virksomhet_naring VALUES (66, '01.120');
INSERT INTO public.virksomhet_naring VALUES (67, '01.120');
INSERT INTO public.virksomhet_naring VALUES (68, '01.120');
INSERT INTO public.virksomhet_naring VALUES (69, '01.120');
INSERT INTO public.virksomhet_naring VALUES (70, '01.120');
INSERT INTO public.virksomhet_naring VALUES (70, '90.012');
INSERT INTO public.virksomhet_naring VALUES (71, '01.120');
INSERT INTO public.virksomhet_naring VALUES (71, '90.012');
INSERT INTO public.virksomhet_naring VALUES (71, '70.220');
INSERT INTO public.virksomhet_naring VALUES (72, '01.120');
INSERT INTO public.virksomhet_naring VALUES (73, '01.120');
INSERT INTO public.virksomhet_naring VALUES (74, '01.120');
INSERT INTO public.virksomhet_naring VALUES (75, '01.120');
INSERT INTO public.virksomhet_naring VALUES (76, '01.120');
INSERT INTO public.virksomhet_naring VALUES (76, '90.012');
INSERT INTO public.virksomhet_naring VALUES (77, '01.120');
INSERT INTO public.virksomhet_naring VALUES (78, '01.120');
INSERT INTO public.virksomhet_naring VALUES (79, '01.120');
INSERT INTO public.virksomhet_naring VALUES (79, '90.012');
INSERT INTO public.virksomhet_naring VALUES (80, '01.120');
INSERT INTO public.virksomhet_naring VALUES (81, '01.120');
INSERT INTO public.virksomhet_naring VALUES (82, '01.120');
INSERT INTO public.virksomhet_naring VALUES (82, '90.012');
INSERT INTO public.virksomhet_naring VALUES (82, '70.220');
INSERT INTO public.virksomhet_naring VALUES (83, '01.120');
INSERT INTO public.virksomhet_naring VALUES (83, '90.012');
INSERT INTO public.virksomhet_naring VALUES (83, '70.220');
INSERT INTO public.virksomhet_naring VALUES (84, '01.120');
INSERT INTO public.virksomhet_naring VALUES (85, '01.120');
INSERT INTO public.virksomhet_naring VALUES (85, '90.012');
INSERT INTO public.virksomhet_naring VALUES (86, '01.120');
INSERT INTO public.virksomhet_naring VALUES (87, '01.120');
INSERT INTO public.virksomhet_naring VALUES (88, '01.120');
INSERT INTO public.virksomhet_naring VALUES (89, '01.120');
INSERT INTO public.virksomhet_naring VALUES (90, '01.120');
INSERT INTO public.virksomhet_naring VALUES (91, '01.120');
INSERT INTO public.virksomhet_naring VALUES (91, '90.012');
INSERT INTO public.virksomhet_naring VALUES (91, '70.220');
INSERT INTO public.virksomhet_naring VALUES (92, '01.120');
INSERT INTO public.virksomhet_naring VALUES (93, '01.120');
INSERT INTO public.virksomhet_naring VALUES (94, '01.120');
INSERT INTO public.virksomhet_naring VALUES (95, '01.120');
INSERT INTO public.virksomhet_naring VALUES (96, '01.120');
INSERT INTO public.virksomhet_naring VALUES (96, '90.012');
INSERT INTO public.virksomhet_naring VALUES (97, '01.120');
INSERT INTO public.virksomhet_naring VALUES (98, '01.120');
INSERT INTO public.virksomhet_naring VALUES (99, '01.120');
INSERT INTO public.virksomhet_naring VALUES (100, '01.120');
INSERT INTO public.virksomhet_naring VALUES (100, '90.012');
INSERT INTO public.virksomhet_naring VALUES (101, '01.120');
INSERT INTO public.virksomhet_naring VALUES (101, '90.012');
INSERT INTO public.virksomhet_naring VALUES (102, '01.120');
INSERT INTO public.virksomhet_naring VALUES (102, '90.012');
INSERT INTO public.virksomhet_naring VALUES (102, '70.220');
INSERT INTO public.virksomhet_naring VALUES (103, '01.120');
INSERT INTO public.virksomhet_naring VALUES (104, '01.120');
INSERT INTO public.virksomhet_naring VALUES (104, '90.012');
INSERT INTO public.virksomhet_naring VALUES (104, '70.220');
INSERT INTO public.virksomhet_naring VALUES (105, '01.120');
INSERT INTO public.virksomhet_naring VALUES (105, '90.012');
INSERT INTO public.virksomhet_naring VALUES (105, '70.220');
INSERT INTO public.virksomhet_naring VALUES (106, '01.120');
INSERT INTO public.virksomhet_naring VALUES (107, '01.120');
INSERT INTO public.virksomhet_naring VALUES (107, '90.012');
INSERT INTO public.virksomhet_naring VALUES (108, '01.120');
INSERT INTO public.virksomhet_naring VALUES (109, '01.120');
INSERT INTO public.virksomhet_naring VALUES (110, '01.120');
INSERT INTO public.virksomhet_naring VALUES (110, '90.012');
INSERT INTO public.virksomhet_naring VALUES (110, '70.220');
INSERT INTO public.virksomhet_naring VALUES (111, '01.120');
INSERT INTO public.virksomhet_naring VALUES (112, '01.120');
INSERT INTO public.virksomhet_naring VALUES (112, '90.012');
INSERT INTO public.virksomhet_naring VALUES (113, '01.120');
INSERT INTO public.virksomhet_naring VALUES (114, '01.120');
INSERT INTO public.virksomhet_naring VALUES (114, '90.012');
INSERT INTO public.virksomhet_naring VALUES (115, '01.120');
INSERT INTO public.virksomhet_naring VALUES (116, '01.120');
INSERT INTO public.virksomhet_naring VALUES (117, '01.120');
INSERT INTO public.virksomhet_naring VALUES (117, '90.012');
INSERT INTO public.virksomhet_naring VALUES (117, '70.220');
INSERT INTO public.virksomhet_naring VALUES (118, '01.120');
INSERT INTO public.virksomhet_naring VALUES (118, '90.012');
INSERT INTO public.virksomhet_naring VALUES (119, '01.120');
INSERT INTO public.virksomhet_naring VALUES (119, '90.012');
INSERT INTO public.virksomhet_naring VALUES (120, '01.120');
INSERT INTO public.virksomhet_naring VALUES (121, '01.120');
INSERT INTO public.virksomhet_naring VALUES (122, '01.120');
INSERT INTO public.virksomhet_naring VALUES (122, '90.012');
INSERT INTO public.virksomhet_naring VALUES (123, '01.120');
INSERT INTO public.virksomhet_naring VALUES (124, '01.120');
INSERT INTO public.virksomhet_naring VALUES (125, '01.120');
INSERT INTO public.virksomhet_naring VALUES (126, '01.120');
INSERT INTO public.virksomhet_naring VALUES (126, '90.012');
INSERT INTO public.virksomhet_naring VALUES (127, '01.120');
INSERT INTO public.virksomhet_naring VALUES (128, '01.120');
INSERT INTO public.virksomhet_naring VALUES (129, '01.120');
INSERT INTO public.virksomhet_naring VALUES (129, '90.012');
INSERT INTO public.virksomhet_naring VALUES (130, '01.120');
INSERT INTO public.virksomhet_naring VALUES (130, '90.012');
INSERT INTO public.virksomhet_naring VALUES (131, '01.120');
INSERT INTO public.virksomhet_naring VALUES (131, '90.012');
INSERT INTO public.virksomhet_naring VALUES (131, '70.220');
INSERT INTO public.virksomhet_naring VALUES (132, '01.120');
INSERT INTO public.virksomhet_naring VALUES (132, '90.012');
INSERT INTO public.virksomhet_naring VALUES (133, '01.120');
INSERT INTO public.virksomhet_naring VALUES (134, '01.120');
INSERT INTO public.virksomhet_naring VALUES (135, '01.120');
INSERT INTO public.virksomhet_naring VALUES (136, '01.120');
INSERT INTO public.virksomhet_naring VALUES (136, '90.012');
INSERT INTO public.virksomhet_naring VALUES (136, '70.220');
INSERT INTO public.virksomhet_naring VALUES (137, '01.120');
INSERT INTO public.virksomhet_naring VALUES (137, '90.012');
INSERT INTO public.virksomhet_naring VALUES (137, '70.220');
INSERT INTO public.virksomhet_naring VALUES (138, '01.120');
INSERT INTO public.virksomhet_naring VALUES (138, '90.012');
INSERT INTO public.virksomhet_naring VALUES (139, '01.120');
INSERT INTO public.virksomhet_naring VALUES (140, '01.120');
INSERT INTO public.virksomhet_naring VALUES (140, '90.012');
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
INSERT INTO public.virksomhet_naring VALUES (149, '01.120');
INSERT INTO public.virksomhet_naring VALUES (150, '01.120');
INSERT INTO public.virksomhet_naring VALUES (150, '90.012');
INSERT INTO public.virksomhet_naring VALUES (151, '01.120');
INSERT INTO public.virksomhet_naring VALUES (151, '90.012');
INSERT INTO public.virksomhet_naring VALUES (152, '01.120');
INSERT INTO public.virksomhet_naring VALUES (153, '01.120');
INSERT INTO public.virksomhet_naring VALUES (153, '90.012');
INSERT INTO public.virksomhet_naring VALUES (154, '01.120');
INSERT INTO public.virksomhet_naring VALUES (155, '01.120');
INSERT INTO public.virksomhet_naring VALUES (155, '90.012');
INSERT INTO public.virksomhet_naring VALUES (156, '01.120');
INSERT INTO public.virksomhet_naring VALUES (156, '90.012');
INSERT INTO public.virksomhet_naring VALUES (157, '01.120');
INSERT INTO public.virksomhet_naring VALUES (158, '01.120');
INSERT INTO public.virksomhet_naring VALUES (159, '01.120');
INSERT INTO public.virksomhet_naring VALUES (160, '01.120');
INSERT INTO public.virksomhet_naring VALUES (160, '90.012');
INSERT INTO public.virksomhet_naring VALUES (160, '70.220');
INSERT INTO public.virksomhet_naring VALUES (161, '01.120');
INSERT INTO public.virksomhet_naring VALUES (162, '01.120');
INSERT INTO public.virksomhet_naring VALUES (162, '90.012');
INSERT INTO public.virksomhet_naring VALUES (163, '01.120');
INSERT INTO public.virksomhet_naring VALUES (164, '01.120');
INSERT INTO public.virksomhet_naring VALUES (165, '01.120');
INSERT INTO public.virksomhet_naring VALUES (166, '01.120');
INSERT INTO public.virksomhet_naring VALUES (166, '90.012');
INSERT INTO public.virksomhet_naring VALUES (167, '01.120');
INSERT INTO public.virksomhet_naring VALUES (168, '01.120');
INSERT INTO public.virksomhet_naring VALUES (169, '01.120');
INSERT INTO public.virksomhet_naring VALUES (169, '90.012');
INSERT INTO public.virksomhet_naring VALUES (169, '70.220');
INSERT INTO public.virksomhet_naring VALUES (170, '01.120');
INSERT INTO public.virksomhet_naring VALUES (171, '01.120');
INSERT INTO public.virksomhet_naring VALUES (172, '01.120');
INSERT INTO public.virksomhet_naring VALUES (173, '01.120');
INSERT INTO public.virksomhet_naring VALUES (174, '01.120');
INSERT INTO public.virksomhet_naring VALUES (175, '01.120');
INSERT INTO public.virksomhet_naring VALUES (175, '90.012');
INSERT INTO public.virksomhet_naring VALUES (175, '70.220');
INSERT INTO public.virksomhet_naring VALUES (176, '01.120');
INSERT INTO public.virksomhet_naring VALUES (177, '01.120');
INSERT INTO public.virksomhet_naring VALUES (177, '90.012');
INSERT INTO public.virksomhet_naring VALUES (178, '01.120');
INSERT INTO public.virksomhet_naring VALUES (179, '01.120');
INSERT INTO public.virksomhet_naring VALUES (179, '90.012');
INSERT INTO public.virksomhet_naring VALUES (179, '70.220');
INSERT INTO public.virksomhet_naring VALUES (180, '01.120');
INSERT INTO public.virksomhet_naring VALUES (181, '01.120');
INSERT INTO public.virksomhet_naring VALUES (181, '90.012');
INSERT INTO public.virksomhet_naring VALUES (181, '70.220');
INSERT INTO public.virksomhet_naring VALUES (182, '01.120');
INSERT INTO public.virksomhet_naring VALUES (183, '01.120');
INSERT INTO public.virksomhet_naring VALUES (183, '90.012');
INSERT INTO public.virksomhet_naring VALUES (183, '70.220');
INSERT INTO public.virksomhet_naring VALUES (184, '01.120');
INSERT INTO public.virksomhet_naring VALUES (185, '01.120');
INSERT INTO public.virksomhet_naring VALUES (186, '01.120');
INSERT INTO public.virksomhet_naring VALUES (187, '01.120');
INSERT INTO public.virksomhet_naring VALUES (188, '01.120');
INSERT INTO public.virksomhet_naring VALUES (188, '90.012');
INSERT INTO public.virksomhet_naring VALUES (188, '70.220');
INSERT INTO public.virksomhet_naring VALUES (189, '01.120');
INSERT INTO public.virksomhet_naring VALUES (189, '90.012');
INSERT INTO public.virksomhet_naring VALUES (190, '01.120');
INSERT INTO public.virksomhet_naring VALUES (191, '01.120');
INSERT INTO public.virksomhet_naring VALUES (191, '90.012');
INSERT INTO public.virksomhet_naring VALUES (192, '01.120');
INSERT INTO public.virksomhet_naring VALUES (192, '90.012');
INSERT INTO public.virksomhet_naring VALUES (192, '70.220');
INSERT INTO public.virksomhet_naring VALUES (193, '01.120');
INSERT INTO public.virksomhet_naring VALUES (193, '90.012');
INSERT INTO public.virksomhet_naring VALUES (194, '01.120');
INSERT INTO public.virksomhet_naring VALUES (195, '01.120');
INSERT INTO public.virksomhet_naring VALUES (196, '01.120');
INSERT INTO public.virksomhet_naring VALUES (196, '90.012');
INSERT INTO public.virksomhet_naring VALUES (197, '01.120');
INSERT INTO public.virksomhet_naring VALUES (197, '90.012');
INSERT INTO public.virksomhet_naring VALUES (197, '70.220');
INSERT INTO public.virksomhet_naring VALUES (198, '01.120');
INSERT INTO public.virksomhet_naring VALUES (199, '01.120');
INSERT INTO public.virksomhet_naring VALUES (199, '90.012');
INSERT INTO public.virksomhet_naring VALUES (199, '70.220');
INSERT INTO public.virksomhet_naring VALUES (200, '01.120');
INSERT INTO public.virksomhet_naring VALUES (200, '90.012');
INSERT INTO public.virksomhet_naring VALUES (201, '01.120');
INSERT INTO public.virksomhet_naring VALUES (202, '01.120');
INSERT INTO public.virksomhet_naring VALUES (202, '90.012');
INSERT INTO public.virksomhet_naring VALUES (203, '01.120');
INSERT INTO public.virksomhet_naring VALUES (203, '90.012');
INSERT INTO public.virksomhet_naring VALUES (203, '70.220');
INSERT INTO public.virksomhet_naring VALUES (204, '01.120');
INSERT INTO public.virksomhet_naring VALUES (204, '90.012');
INSERT INTO public.virksomhet_naring VALUES (205, '01.120');
INSERT INTO public.virksomhet_naring VALUES (206, '01.120');
INSERT INTO public.virksomhet_naring VALUES (206, '90.012');
INSERT INTO public.virksomhet_naring VALUES (206, '70.220');
INSERT INTO public.virksomhet_naring VALUES (207, '01.120');
INSERT INTO public.virksomhet_naring VALUES (208, '01.120');
INSERT INTO public.virksomhet_naring VALUES (209, '01.120');
INSERT INTO public.virksomhet_naring VALUES (209, '90.012');
INSERT INTO public.virksomhet_naring VALUES (209, '70.220');
INSERT INTO public.virksomhet_naring VALUES (210, '01.120');
INSERT INTO public.virksomhet_naring VALUES (211, '01.120');
INSERT INTO public.virksomhet_naring VALUES (212, '01.120');
INSERT INTO public.virksomhet_naring VALUES (212, '90.012');
INSERT INTO public.virksomhet_naring VALUES (212, '70.220');
INSERT INTO public.virksomhet_naring VALUES (213, '01.120');
INSERT INTO public.virksomhet_naring VALUES (214, '01.120');
INSERT INTO public.virksomhet_naring VALUES (215, '01.120');
INSERT INTO public.virksomhet_naring VALUES (216, '01.120');
INSERT INTO public.virksomhet_naring VALUES (217, '01.120');
INSERT INTO public.virksomhet_naring VALUES (217, '90.012');
INSERT INTO public.virksomhet_naring VALUES (218, '01.120');
INSERT INTO public.virksomhet_naring VALUES (218, '90.012');
INSERT INTO public.virksomhet_naring VALUES (218, '70.220');
INSERT INTO public.virksomhet_naring VALUES (219, '01.120');
INSERT INTO public.virksomhet_naring VALUES (220, '01.120');
INSERT INTO public.virksomhet_naring VALUES (221, '01.120');
INSERT INTO public.virksomhet_naring VALUES (222, '01.120');
INSERT INTO public.virksomhet_naring VALUES (223, '01.120');
INSERT INTO public.virksomhet_naring VALUES (223, '90.012');
INSERT INTO public.virksomhet_naring VALUES (224, '01.120');
INSERT INTO public.virksomhet_naring VALUES (225, '01.120');
INSERT INTO public.virksomhet_naring VALUES (226, '01.120');
INSERT INTO public.virksomhet_naring VALUES (226, '90.012');
INSERT INTO public.virksomhet_naring VALUES (227, '01.120');
INSERT INTO public.virksomhet_naring VALUES (227, '90.012');
INSERT INTO public.virksomhet_naring VALUES (227, '70.220');
INSERT INTO public.virksomhet_naring VALUES (228, '01.120');
INSERT INTO public.virksomhet_naring VALUES (228, '90.012');
INSERT INTO public.virksomhet_naring VALUES (229, '01.120');
INSERT INTO public.virksomhet_naring VALUES (230, '01.120');
INSERT INTO public.virksomhet_naring VALUES (230, '90.012');
INSERT INTO public.virksomhet_naring VALUES (230, '70.220');
INSERT INTO public.virksomhet_naring VALUES (231, '01.120');
INSERT INTO public.virksomhet_naring VALUES (231, '90.012');
INSERT INTO public.virksomhet_naring VALUES (231, '70.220');
INSERT INTO public.virksomhet_naring VALUES (232, '01.120');
INSERT INTO public.virksomhet_naring VALUES (232, '90.012');
INSERT INTO public.virksomhet_naring VALUES (232, '70.220');
INSERT INTO public.virksomhet_naring VALUES (233, '01.120');
INSERT INTO public.virksomhet_naring VALUES (233, '90.012');
INSERT INTO public.virksomhet_naring VALUES (234, '01.120');
INSERT INTO public.virksomhet_naring VALUES (234, '90.012');
INSERT INTO public.virksomhet_naring VALUES (234, '70.220');
INSERT INTO public.virksomhet_naring VALUES (235, '01.120');
INSERT INTO public.virksomhet_naring VALUES (235, '90.012');
INSERT INTO public.virksomhet_naring VALUES (235, '70.220');
INSERT INTO public.virksomhet_naring VALUES (236, '01.120');
INSERT INTO public.virksomhet_naring VALUES (236, '90.012');
INSERT INTO public.virksomhet_naring VALUES (237, '01.120');
INSERT INTO public.virksomhet_naring VALUES (238, '01.120');
INSERT INTO public.virksomhet_naring VALUES (239, '01.120');
INSERT INTO public.virksomhet_naring VALUES (240, '01.120');
INSERT INTO public.virksomhet_naring VALUES (241, '01.120');
INSERT INTO public.virksomhet_naring VALUES (241, '90.012');
INSERT INTO public.virksomhet_naring VALUES (242, '01.120');
INSERT INTO public.virksomhet_naring VALUES (242, '90.012');
INSERT INTO public.virksomhet_naring VALUES (242, '70.220');
INSERT INTO public.virksomhet_naring VALUES (243, '01.120');
INSERT INTO public.virksomhet_naring VALUES (244, '01.120');
INSERT INTO public.virksomhet_naring VALUES (244, '90.012');
INSERT INTO public.virksomhet_naring VALUES (244, '70.220');
INSERT INTO public.virksomhet_naring VALUES (245, '01.120');
INSERT INTO public.virksomhet_naring VALUES (246, '01.120');
INSERT INTO public.virksomhet_naring VALUES (246, '90.012');
INSERT INTO public.virksomhet_naring VALUES (246, '70.220');
INSERT INTO public.virksomhet_naring VALUES (247, '01.120');
INSERT INTO public.virksomhet_naring VALUES (247, '90.012');
INSERT INTO public.virksomhet_naring VALUES (248, '01.120');
INSERT INTO public.virksomhet_naring VALUES (248, '90.012');
INSERT INTO public.virksomhet_naring VALUES (249, '01.120');
INSERT INTO public.virksomhet_naring VALUES (250, '01.120');
INSERT INTO public.virksomhet_naring VALUES (251, '01.120');
INSERT INTO public.virksomhet_naring VALUES (252, '01.120');
INSERT INTO public.virksomhet_naring VALUES (252, '90.012');
INSERT INTO public.virksomhet_naring VALUES (253, '01.120');
INSERT INTO public.virksomhet_naring VALUES (254, '01.120');
INSERT INTO public.virksomhet_naring VALUES (255, '01.120');
INSERT INTO public.virksomhet_naring VALUES (255, '90.012');
INSERT INTO public.virksomhet_naring VALUES (256, '01.120');
INSERT INTO public.virksomhet_naring VALUES (256, '90.012');
INSERT INTO public.virksomhet_naring VALUES (257, '01.120');
INSERT INTO public.virksomhet_naring VALUES (258, '01.120');
INSERT INTO public.virksomhet_naring VALUES (259, '01.120');
INSERT INTO public.virksomhet_naring VALUES (260, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '90.012');
INSERT INTO public.virksomhet_naring VALUES (262, '01.120');
INSERT INTO public.virksomhet_naring VALUES (262, '90.012');
INSERT INTO public.virksomhet_naring VALUES (263, '01.120');
INSERT INTO public.virksomhet_naring VALUES (264, '01.120');
INSERT INTO public.virksomhet_naring VALUES (265, '01.120');
INSERT INTO public.virksomhet_naring VALUES (266, '01.120');
INSERT INTO public.virksomhet_naring VALUES (267, '01.120');
INSERT INTO public.virksomhet_naring VALUES (268, '01.120');
INSERT INTO public.virksomhet_naring VALUES (269, '01.120');
INSERT INTO public.virksomhet_naring VALUES (269, '90.012');
INSERT INTO public.virksomhet_naring VALUES (270, '01.120');
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
INSERT INTO public.virksomhet_naring VALUES (278, '01.120');
INSERT INTO public.virksomhet_naring VALUES (279, '01.120');
INSERT INTO public.virksomhet_naring VALUES (279, '90.012');
INSERT INTO public.virksomhet_naring VALUES (280, '01.120');
INSERT INTO public.virksomhet_naring VALUES (280, '90.012');
INSERT INTO public.virksomhet_naring VALUES (281, '01.120');
INSERT INTO public.virksomhet_naring VALUES (281, '90.012');
INSERT INTO public.virksomhet_naring VALUES (282, '01.120');
INSERT INTO public.virksomhet_naring VALUES (283, '01.120');
INSERT INTO public.virksomhet_naring VALUES (284, '01.120');
INSERT INTO public.virksomhet_naring VALUES (284, '90.012');
INSERT INTO public.virksomhet_naring VALUES (285, '01.120');
INSERT INTO public.virksomhet_naring VALUES (285, '90.012');
INSERT INTO public.virksomhet_naring VALUES (285, '70.220');
INSERT INTO public.virksomhet_naring VALUES (286, '01.120');
INSERT INTO public.virksomhet_naring VALUES (287, '01.120');
INSERT INTO public.virksomhet_naring VALUES (287, '90.012');
INSERT INTO public.virksomhet_naring VALUES (288, '01.120');
INSERT INTO public.virksomhet_naring VALUES (288, '90.012');
INSERT INTO public.virksomhet_naring VALUES (288, '70.220');
INSERT INTO public.virksomhet_naring VALUES (289, '01.120');
INSERT INTO public.virksomhet_naring VALUES (289, '90.012');
INSERT INTO public.virksomhet_naring VALUES (290, '01.120');
INSERT INTO public.virksomhet_naring VALUES (291, '01.120');
INSERT INTO public.virksomhet_naring VALUES (292, '01.120');
INSERT INTO public.virksomhet_naring VALUES (293, '01.120');
INSERT INTO public.virksomhet_naring VALUES (293, '90.012');
INSERT INTO public.virksomhet_naring VALUES (294, '01.120');
INSERT INTO public.virksomhet_naring VALUES (295, '01.120');
INSERT INTO public.virksomhet_naring VALUES (296, '01.120');
INSERT INTO public.virksomhet_naring VALUES (297, '01.120');
INSERT INTO public.virksomhet_naring VALUES (297, '90.012');
INSERT INTO public.virksomhet_naring VALUES (298, '01.120');
INSERT INTO public.virksomhet_naring VALUES (299, '01.120');
INSERT INTO public.virksomhet_naring VALUES (299, '90.012');
INSERT INTO public.virksomhet_naring VALUES (300, '01.120');
INSERT INTO public.virksomhet_naring VALUES (301, '01.120');
INSERT INTO public.virksomhet_naring VALUES (302, '01.120');
INSERT INTO public.virksomhet_naring VALUES (303, '01.120');
INSERT INTO public.virksomhet_naring VALUES (303, '90.012');
INSERT INTO public.virksomhet_naring VALUES (303, '70.220');
INSERT INTO public.virksomhet_naring VALUES (304, '01.120');
INSERT INTO public.virksomhet_naring VALUES (304, '90.012');
INSERT INTO public.virksomhet_naring VALUES (305, '01.120');
INSERT INTO public.virksomhet_naring VALUES (305, '90.012');
INSERT INTO public.virksomhet_naring VALUES (305, '70.220');
INSERT INTO public.virksomhet_naring VALUES (306, '01.120');
INSERT INTO public.virksomhet_naring VALUES (307, '01.120');
INSERT INTO public.virksomhet_naring VALUES (308, '01.120');
INSERT INTO public.virksomhet_naring VALUES (309, '01.120');
INSERT INTO public.virksomhet_naring VALUES (309, '90.012');
INSERT INTO public.virksomhet_naring VALUES (310, '01.120');
INSERT INTO public.virksomhet_naring VALUES (310, '90.012');
INSERT INTO public.virksomhet_naring VALUES (311, '01.120');
INSERT INTO public.virksomhet_naring VALUES (312, '01.120');
INSERT INTO public.virksomhet_naring VALUES (313, '01.120');
INSERT INTO public.virksomhet_naring VALUES (313, '90.012');
INSERT INTO public.virksomhet_naring VALUES (314, '01.120');
INSERT INTO public.virksomhet_naring VALUES (314, '90.012');
INSERT INTO public.virksomhet_naring VALUES (315, '01.120');
INSERT INTO public.virksomhet_naring VALUES (316, '01.120');
INSERT INTO public.virksomhet_naring VALUES (316, '90.012');
INSERT INTO public.virksomhet_naring VALUES (317, '01.120');
INSERT INTO public.virksomhet_naring VALUES (318, '01.120');
INSERT INTO public.virksomhet_naring VALUES (319, '01.120');
INSERT INTO public.virksomhet_naring VALUES (319, '90.012');
INSERT INTO public.virksomhet_naring VALUES (319, '70.220');
INSERT INTO public.virksomhet_naring VALUES (320, '01.120');
INSERT INTO public.virksomhet_naring VALUES (321, '01.120');
INSERT INTO public.virksomhet_naring VALUES (322, '01.120');
INSERT INTO public.virksomhet_naring VALUES (322, '90.012');
INSERT INTO public.virksomhet_naring VALUES (322, '70.220');
INSERT INTO public.virksomhet_naring VALUES (323, '01.120');
INSERT INTO public.virksomhet_naring VALUES (324, '01.120');
INSERT INTO public.virksomhet_naring VALUES (324, '90.012');
INSERT INTO public.virksomhet_naring VALUES (324, '70.220');
INSERT INTO public.virksomhet_naring VALUES (325, '01.120');
INSERT INTO public.virksomhet_naring VALUES (326, '01.120');
INSERT INTO public.virksomhet_naring VALUES (327, '01.120');
INSERT INTO public.virksomhet_naring VALUES (327, '90.012');
INSERT INTO public.virksomhet_naring VALUES (327, '70.220');
INSERT INTO public.virksomhet_naring VALUES (328, '01.120');
INSERT INTO public.virksomhet_naring VALUES (328, '90.012');
INSERT INTO public.virksomhet_naring VALUES (328, '70.220');
INSERT INTO public.virksomhet_naring VALUES (329, '01.120');
INSERT INTO public.virksomhet_naring VALUES (330, '01.120');
INSERT INTO public.virksomhet_naring VALUES (331, '01.120');
INSERT INTO public.virksomhet_naring VALUES (332, '01.120');
INSERT INTO public.virksomhet_naring VALUES (333, '01.120');
INSERT INTO public.virksomhet_naring VALUES (334, '01.120');
INSERT INTO public.virksomhet_naring VALUES (334, '90.012');
INSERT INTO public.virksomhet_naring VALUES (334, '70.220');
INSERT INTO public.virksomhet_naring VALUES (335, '01.120');
INSERT INTO public.virksomhet_naring VALUES (335, '90.012');
INSERT INTO public.virksomhet_naring VALUES (336, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '90.012');
INSERT INTO public.virksomhet_naring VALUES (338, '01.120');
INSERT INTO public.virksomhet_naring VALUES (338, '90.012');
INSERT INTO public.virksomhet_naring VALUES (339, '01.120');
INSERT INTO public.virksomhet_naring VALUES (340, '01.120');
INSERT INTO public.virksomhet_naring VALUES (341, '01.120');
INSERT INTO public.virksomhet_naring VALUES (342, '01.120');
INSERT INTO public.virksomhet_naring VALUES (342, '90.012');
INSERT INTO public.virksomhet_naring VALUES (343, '01.120');
INSERT INTO public.virksomhet_naring VALUES (344, '01.120');
INSERT INTO public.virksomhet_naring VALUES (344, '90.012');
INSERT INTO public.virksomhet_naring VALUES (345, '01.120');
INSERT INTO public.virksomhet_naring VALUES (345, '90.012');
INSERT INTO public.virksomhet_naring VALUES (345, '70.220');
INSERT INTO public.virksomhet_naring VALUES (346, '01.120');
INSERT INTO public.virksomhet_naring VALUES (347, '01.120');
INSERT INTO public.virksomhet_naring VALUES (348, '01.120');
INSERT INTO public.virksomhet_naring VALUES (349, '01.120');
INSERT INTO public.virksomhet_naring VALUES (350, '01.120');
INSERT INTO public.virksomhet_naring VALUES (351, '01.120');
INSERT INTO public.virksomhet_naring VALUES (352, '01.120');
INSERT INTO public.virksomhet_naring VALUES (353, '01.120');
INSERT INTO public.virksomhet_naring VALUES (353, '90.012');
INSERT INTO public.virksomhet_naring VALUES (353, '70.220');
INSERT INTO public.virksomhet_naring VALUES (354, '01.120');
INSERT INTO public.virksomhet_naring VALUES (355, '01.120');
INSERT INTO public.virksomhet_naring VALUES (355, '90.012');
INSERT INTO public.virksomhet_naring VALUES (355, '70.220');
INSERT INTO public.virksomhet_naring VALUES (356, '01.120');
INSERT INTO public.virksomhet_naring VALUES (357, '01.120');
INSERT INTO public.virksomhet_naring VALUES (357, '90.012');
INSERT INTO public.virksomhet_naring VALUES (358, '01.120');
INSERT INTO public.virksomhet_naring VALUES (359, '01.120');
INSERT INTO public.virksomhet_naring VALUES (359, '90.012');
INSERT INTO public.virksomhet_naring VALUES (360, '01.120');
INSERT INTO public.virksomhet_naring VALUES (360, '90.012');
INSERT INTO public.virksomhet_naring VALUES (361, '01.120');
INSERT INTO public.virksomhet_naring VALUES (362, '01.120');
INSERT INTO public.virksomhet_naring VALUES (362, '90.012');
INSERT INTO public.virksomhet_naring VALUES (363, '01.120');
INSERT INTO public.virksomhet_naring VALUES (363, '90.012');
INSERT INTO public.virksomhet_naring VALUES (364, '01.120');
INSERT INTO public.virksomhet_naring VALUES (364, '90.012');
INSERT INTO public.virksomhet_naring VALUES (364, '70.220');
INSERT INTO public.virksomhet_naring VALUES (365, '01.120');
INSERT INTO public.virksomhet_naring VALUES (365, '90.012');
INSERT INTO public.virksomhet_naring VALUES (366, '01.120');
INSERT INTO public.virksomhet_naring VALUES (366, '90.012');
INSERT INTO public.virksomhet_naring VALUES (366, '70.220');
INSERT INTO public.virksomhet_naring VALUES (367, '01.120');
INSERT INTO public.virksomhet_naring VALUES (367, '90.012');
INSERT INTO public.virksomhet_naring VALUES (368, '01.120');
INSERT INTO public.virksomhet_naring VALUES (368, '90.012');
INSERT INTO public.virksomhet_naring VALUES (369, '01.120');
INSERT INTO public.virksomhet_naring VALUES (369, '90.012');
INSERT INTO public.virksomhet_naring VALUES (370, '01.120');
INSERT INTO public.virksomhet_naring VALUES (371, '01.120');
INSERT INTO public.virksomhet_naring VALUES (371, '90.012');
INSERT INTO public.virksomhet_naring VALUES (371, '70.220');
INSERT INTO public.virksomhet_naring VALUES (372, '01.120');
INSERT INTO public.virksomhet_naring VALUES (372, '90.012');
INSERT INTO public.virksomhet_naring VALUES (373, '01.120');
INSERT INTO public.virksomhet_naring VALUES (374, '01.120');
INSERT INTO public.virksomhet_naring VALUES (375, '01.120');
INSERT INTO public.virksomhet_naring VALUES (375, '90.012');
INSERT INTO public.virksomhet_naring VALUES (376, '01.120');
INSERT INTO public.virksomhet_naring VALUES (377, '01.120');
INSERT INTO public.virksomhet_naring VALUES (378, '01.120');
INSERT INTO public.virksomhet_naring VALUES (378, '90.012');
INSERT INTO public.virksomhet_naring VALUES (379, '01.120');
INSERT INTO public.virksomhet_naring VALUES (379, '90.012');
INSERT INTO public.virksomhet_naring VALUES (380, '01.120');
INSERT INTO public.virksomhet_naring VALUES (381, '01.120');
INSERT INTO public.virksomhet_naring VALUES (381, '90.012');
INSERT INTO public.virksomhet_naring VALUES (382, '01.120');
INSERT INTO public.virksomhet_naring VALUES (382, '90.012');
INSERT INTO public.virksomhet_naring VALUES (382, '70.220');
INSERT INTO public.virksomhet_naring VALUES (383, '01.120');
INSERT INTO public.virksomhet_naring VALUES (383, '90.012');
INSERT INTO public.virksomhet_naring VALUES (384, '01.120');
INSERT INTO public.virksomhet_naring VALUES (384, '90.012');
INSERT INTO public.virksomhet_naring VALUES (384, '70.220');
INSERT INTO public.virksomhet_naring VALUES (385, '01.120');
INSERT INTO public.virksomhet_naring VALUES (385, '90.012');
INSERT INTO public.virksomhet_naring VALUES (386, '01.120');
INSERT INTO public.virksomhet_naring VALUES (387, '01.120');
INSERT INTO public.virksomhet_naring VALUES (388, '01.120');
INSERT INTO public.virksomhet_naring VALUES (389, '01.120');
INSERT INTO public.virksomhet_naring VALUES (389, '90.012');
INSERT INTO public.virksomhet_naring VALUES (390, '01.120');
INSERT INTO public.virksomhet_naring VALUES (391, '01.120');
INSERT INTO public.virksomhet_naring VALUES (391, '90.012');
INSERT INTO public.virksomhet_naring VALUES (391, '70.220');
INSERT INTO public.virksomhet_naring VALUES (392, '01.120');
INSERT INTO public.virksomhet_naring VALUES (393, '01.120');
INSERT INTO public.virksomhet_naring VALUES (393, '90.012');
INSERT INTO public.virksomhet_naring VALUES (394, '01.120');
INSERT INTO public.virksomhet_naring VALUES (394, '90.012');
INSERT INTO public.virksomhet_naring VALUES (395, '01.120');
INSERT INTO public.virksomhet_naring VALUES (396, '01.120');
INSERT INTO public.virksomhet_naring VALUES (397, '01.120');
INSERT INTO public.virksomhet_naring VALUES (397, '90.012');
INSERT INTO public.virksomhet_naring VALUES (398, '01.120');
INSERT INTO public.virksomhet_naring VALUES (398, '90.012');
INSERT INTO public.virksomhet_naring VALUES (398, '70.220');
INSERT INTO public.virksomhet_naring VALUES (399, '01.120');
INSERT INTO public.virksomhet_naring VALUES (399, '90.012');
INSERT INTO public.virksomhet_naring VALUES (400, '01.120');
INSERT INTO public.virksomhet_naring VALUES (401, '01.120');
INSERT INTO public.virksomhet_naring VALUES (402, '01.120');
INSERT INTO public.virksomhet_naring VALUES (402, '90.012');
INSERT INTO public.virksomhet_naring VALUES (402, '70.220');
INSERT INTO public.virksomhet_naring VALUES (403, '01.120');
INSERT INTO public.virksomhet_naring VALUES (404, '01.120');
INSERT INTO public.virksomhet_naring VALUES (404, '90.012');
INSERT INTO public.virksomhet_naring VALUES (404, '70.220');
INSERT INTO public.virksomhet_naring VALUES (405, '01.120');
INSERT INTO public.virksomhet_naring VALUES (406, '01.120');
INSERT INTO public.virksomhet_naring VALUES (407, '01.120');
INSERT INTO public.virksomhet_naring VALUES (408, '01.120');
INSERT INTO public.virksomhet_naring VALUES (408, '90.012');
INSERT INTO public.virksomhet_naring VALUES (409, '01.120');
INSERT INTO public.virksomhet_naring VALUES (409, '90.012');
INSERT INTO public.virksomhet_naring VALUES (410, '01.120');
INSERT INTO public.virksomhet_naring VALUES (410, '90.012');
INSERT INTO public.virksomhet_naring VALUES (410, '70.220');
INSERT INTO public.virksomhet_naring VALUES (411, '01.120');
INSERT INTO public.virksomhet_naring VALUES (411, '90.012');
INSERT INTO public.virksomhet_naring VALUES (412, '01.120');
INSERT INTO public.virksomhet_naring VALUES (412, '90.012');
INSERT INTO public.virksomhet_naring VALUES (413, '01.120');
INSERT INTO public.virksomhet_naring VALUES (413, '90.012');
INSERT INTO public.virksomhet_naring VALUES (413, '70.220');
INSERT INTO public.virksomhet_naring VALUES (414, '01.120');
INSERT INTO public.virksomhet_naring VALUES (414, '90.012');
INSERT INTO public.virksomhet_naring VALUES (414, '70.220');
INSERT INTO public.virksomhet_naring VALUES (415, '01.120');
INSERT INTO public.virksomhet_naring VALUES (415, '90.012');
INSERT INTO public.virksomhet_naring VALUES (416, '01.120');
INSERT INTO public.virksomhet_naring VALUES (416, '90.012');
INSERT INTO public.virksomhet_naring VALUES (416, '70.220');
INSERT INTO public.virksomhet_naring VALUES (417, '01.120');
INSERT INTO public.virksomhet_naring VALUES (418, '01.120');
INSERT INTO public.virksomhet_naring VALUES (419, '01.120');
INSERT INTO public.virksomhet_naring VALUES (420, '01.120');
INSERT INTO public.virksomhet_naring VALUES (420, '90.012');
INSERT INTO public.virksomhet_naring VALUES (420, '70.220');
INSERT INTO public.virksomhet_naring VALUES (421, '01.120');
INSERT INTO public.virksomhet_naring VALUES (422, '01.120');
INSERT INTO public.virksomhet_naring VALUES (423, '01.120');
INSERT INTO public.virksomhet_naring VALUES (424, '01.120');
INSERT INTO public.virksomhet_naring VALUES (424, '90.012');
INSERT INTO public.virksomhet_naring VALUES (424, '70.220');
INSERT INTO public.virksomhet_naring VALUES (425, '01.120');
INSERT INTO public.virksomhet_naring VALUES (425, '90.012');
INSERT INTO public.virksomhet_naring VALUES (426, '01.120');
INSERT INTO public.virksomhet_naring VALUES (426, '90.012');
INSERT INTO public.virksomhet_naring VALUES (427, '01.120');
INSERT INTO public.virksomhet_naring VALUES (427, '90.012');
INSERT INTO public.virksomhet_naring VALUES (427, '70.220');
INSERT INTO public.virksomhet_naring VALUES (428, '01.120');
INSERT INTO public.virksomhet_naring VALUES (429, '01.120');
INSERT INTO public.virksomhet_naring VALUES (430, '01.120');
INSERT INTO public.virksomhet_naring VALUES (431, '01.120');
INSERT INTO public.virksomhet_naring VALUES (431, '90.012');
INSERT INTO public.virksomhet_naring VALUES (431, '70.220');
INSERT INTO public.virksomhet_naring VALUES (432, '01.120');
INSERT INTO public.virksomhet_naring VALUES (433, '01.120');
INSERT INTO public.virksomhet_naring VALUES (434, '01.120');
INSERT INTO public.virksomhet_naring VALUES (434, '90.012');
INSERT INTO public.virksomhet_naring VALUES (435, '01.120');
INSERT INTO public.virksomhet_naring VALUES (435, '90.012');
INSERT INTO public.virksomhet_naring VALUES (436, '01.120');
INSERT INTO public.virksomhet_naring VALUES (437, '01.120');
INSERT INTO public.virksomhet_naring VALUES (437, '90.012');
INSERT INTO public.virksomhet_naring VALUES (437, '70.220');
INSERT INTO public.virksomhet_naring VALUES (438, '01.120');
INSERT INTO public.virksomhet_naring VALUES (439, '01.120');
INSERT INTO public.virksomhet_naring VALUES (440, '01.120');
INSERT INTO public.virksomhet_naring VALUES (440, '90.012');
INSERT INTO public.virksomhet_naring VALUES (440, '70.220');
INSERT INTO public.virksomhet_naring VALUES (441, '01.120');
INSERT INTO public.virksomhet_naring VALUES (442, '01.120');
INSERT INTO public.virksomhet_naring VALUES (443, '01.120');
INSERT INTO public.virksomhet_naring VALUES (444, '01.120');
INSERT INTO public.virksomhet_naring VALUES (444, '90.012');
INSERT INTO public.virksomhet_naring VALUES (445, '01.120');
INSERT INTO public.virksomhet_naring VALUES (445, '90.012');
INSERT INTO public.virksomhet_naring VALUES (445, '70.220');
INSERT INTO public.virksomhet_naring VALUES (446, '01.120');
INSERT INTO public.virksomhet_naring VALUES (447, '01.120');
INSERT INTO public.virksomhet_naring VALUES (447, '90.012');
INSERT INTO public.virksomhet_naring VALUES (448, '01.120');
INSERT INTO public.virksomhet_naring VALUES (448, '90.012');
INSERT INTO public.virksomhet_naring VALUES (448, '70.220');
INSERT INTO public.virksomhet_naring VALUES (449, '01.120');
INSERT INTO public.virksomhet_naring VALUES (449, '90.012');
INSERT INTO public.virksomhet_naring VALUES (450, '01.120');
INSERT INTO public.virksomhet_naring VALUES (450, '90.012');
INSERT INTO public.virksomhet_naring VALUES (451, '01.120');
INSERT INTO public.virksomhet_naring VALUES (452, '01.120');
INSERT INTO public.virksomhet_naring VALUES (452, '90.012');
INSERT INTO public.virksomhet_naring VALUES (453, '01.120');
INSERT INTO public.virksomhet_naring VALUES (453, '90.012');
INSERT INTO public.virksomhet_naring VALUES (454, '01.120');
INSERT INTO public.virksomhet_naring VALUES (455, '01.120');
INSERT INTO public.virksomhet_naring VALUES (455, '90.012');
INSERT INTO public.virksomhet_naring VALUES (456, '01.120');
INSERT INTO public.virksomhet_naring VALUES (457, '01.120');
INSERT INTO public.virksomhet_naring VALUES (458, '01.120');
INSERT INTO public.virksomhet_naring VALUES (459, '01.120');
INSERT INTO public.virksomhet_naring VALUES (459, '90.012');
INSERT INTO public.virksomhet_naring VALUES (459, '70.220');
INSERT INTO public.virksomhet_naring VALUES (460, '01.120');
INSERT INTO public.virksomhet_naring VALUES (460, '90.012');
INSERT INTO public.virksomhet_naring VALUES (461, '01.120');
INSERT INTO public.virksomhet_naring VALUES (462, '01.120');
INSERT INTO public.virksomhet_naring VALUES (463, '01.120');
INSERT INTO public.virksomhet_naring VALUES (463, '90.012');
INSERT INTO public.virksomhet_naring VALUES (464, '01.120');
INSERT INTO public.virksomhet_naring VALUES (465, '01.120');
INSERT INTO public.virksomhet_naring VALUES (466, '01.120');
INSERT INTO public.virksomhet_naring VALUES (466, '90.012');
INSERT INTO public.virksomhet_naring VALUES (467, '01.120');
INSERT INTO public.virksomhet_naring VALUES (467, '90.012');
INSERT INTO public.virksomhet_naring VALUES (468, '01.120');
INSERT INTO public.virksomhet_naring VALUES (468, '90.012');
INSERT INTO public.virksomhet_naring VALUES (469, '01.120');
INSERT INTO public.virksomhet_naring VALUES (470, '01.120');
INSERT INTO public.virksomhet_naring VALUES (470, '90.012');
INSERT INTO public.virksomhet_naring VALUES (470, '70.220');
INSERT INTO public.virksomhet_naring VALUES (471, '01.120');
INSERT INTO public.virksomhet_naring VALUES (471, '90.012');
INSERT INTO public.virksomhet_naring VALUES (471, '70.220');
INSERT INTO public.virksomhet_naring VALUES (472, '01.120');
INSERT INTO public.virksomhet_naring VALUES (472, '90.012');
INSERT INTO public.virksomhet_naring VALUES (473, '01.120');
INSERT INTO public.virksomhet_naring VALUES (473, '90.012');
INSERT INTO public.virksomhet_naring VALUES (474, '01.120');
INSERT INTO public.virksomhet_naring VALUES (474, '90.012');
INSERT INTO public.virksomhet_naring VALUES (475, '01.120');
INSERT INTO public.virksomhet_naring VALUES (475, '90.012');
INSERT INTO public.virksomhet_naring VALUES (476, '01.120');
INSERT INTO public.virksomhet_naring VALUES (477, '01.120');
INSERT INTO public.virksomhet_naring VALUES (478, '01.120');
INSERT INTO public.virksomhet_naring VALUES (478, '90.012');
INSERT INTO public.virksomhet_naring VALUES (479, '01.120');
INSERT INTO public.virksomhet_naring VALUES (479, '90.012');
INSERT INTO public.virksomhet_naring VALUES (479, '70.220');
INSERT INTO public.virksomhet_naring VALUES (480, '01.120');
INSERT INTO public.virksomhet_naring VALUES (480, '90.012');
INSERT INTO public.virksomhet_naring VALUES (481, '01.120');
INSERT INTO public.virksomhet_naring VALUES (481, '90.012');
INSERT INTO public.virksomhet_naring VALUES (482, '01.120');
INSERT INTO public.virksomhet_naring VALUES (482, '90.012');
INSERT INTO public.virksomhet_naring VALUES (482, '70.220');
INSERT INTO public.virksomhet_naring VALUES (483, '01.120');
INSERT INTO public.virksomhet_naring VALUES (483, '90.012');
INSERT INTO public.virksomhet_naring VALUES (483, '70.220');
INSERT INTO public.virksomhet_naring VALUES (484, '01.120');
INSERT INTO public.virksomhet_naring VALUES (484, '90.012');
INSERT INTO public.virksomhet_naring VALUES (485, '01.120');
INSERT INTO public.virksomhet_naring VALUES (486, '01.120');
INSERT INTO public.virksomhet_naring VALUES (486, '90.012');
INSERT INTO public.virksomhet_naring VALUES (487, '01.120');
INSERT INTO public.virksomhet_naring VALUES (487, '90.012');
INSERT INTO public.virksomhet_naring VALUES (488, '01.120');
INSERT INTO public.virksomhet_naring VALUES (489, '01.120');
INSERT INTO public.virksomhet_naring VALUES (490, '01.120');
INSERT INTO public.virksomhet_naring VALUES (491, '01.120');
INSERT INTO public.virksomhet_naring VALUES (492, '01.120');
INSERT INTO public.virksomhet_naring VALUES (492, '90.012');
INSERT INTO public.virksomhet_naring VALUES (492, '70.220');
INSERT INTO public.virksomhet_naring VALUES (493, '01.120');
INSERT INTO public.virksomhet_naring VALUES (493, '90.012');
INSERT INTO public.virksomhet_naring VALUES (493, '70.220');
INSERT INTO public.virksomhet_naring VALUES (494, '01.120');
INSERT INTO public.virksomhet_naring VALUES (495, '01.120');
INSERT INTO public.virksomhet_naring VALUES (496, '01.120');
INSERT INTO public.virksomhet_naring VALUES (496, '90.012');
INSERT INTO public.virksomhet_naring VALUES (496, '70.220');
INSERT INTO public.virksomhet_naring VALUES (497, '01.120');
INSERT INTO public.virksomhet_naring VALUES (497, '90.012');
INSERT INTO public.virksomhet_naring VALUES (497, '70.220');
INSERT INTO public.virksomhet_naring VALUES (498, '01.120');
INSERT INTO public.virksomhet_naring VALUES (498, '90.012');
INSERT INTO public.virksomhet_naring VALUES (498, '70.220');
INSERT INTO public.virksomhet_naring VALUES (499, '01.120');
INSERT INTO public.virksomhet_naring VALUES (499, '90.012');
INSERT INTO public.virksomhet_naring VALUES (500, '01.120');
INSERT INTO public.virksomhet_naring VALUES (500, '90.012');
INSERT INTO public.virksomhet_naring VALUES (501, '01.120');
INSERT INTO public.virksomhet_naring VALUES (502, '01.120');
INSERT INTO public.virksomhet_naring VALUES (502, '90.012');
INSERT INTO public.virksomhet_naring VALUES (502, '70.220');
INSERT INTO public.virksomhet_naring VALUES (503, '01.120');
INSERT INTO public.virksomhet_naring VALUES (504, '01.120');
INSERT INTO public.virksomhet_naring VALUES (505, '01.120');
INSERT INTO public.virksomhet_naring VALUES (505, '90.012');
INSERT INTO public.virksomhet_naring VALUES (506, '01.120');
INSERT INTO public.virksomhet_naring VALUES (507, '01.120');
INSERT INTO public.virksomhet_naring VALUES (508, '01.120');
INSERT INTO public.virksomhet_naring VALUES (508, '90.012');
INSERT INTO public.virksomhet_naring VALUES (509, '01.120');
INSERT INTO public.virksomhet_naring VALUES (509, '90.012');
INSERT INTO public.virksomhet_naring VALUES (510, '01.120');
INSERT INTO public.virksomhet_naring VALUES (510, '90.012');
INSERT INTO public.virksomhet_naring VALUES (511, '01.120');
INSERT INTO public.virksomhet_naring VALUES (517, '01.120');
INSERT INTO public.virksomhet_naring VALUES (517, '90.012');
INSERT INTO public.virksomhet_naring VALUES (518, '01.120');
INSERT INTO public.virksomhet_naring VALUES (518, '90.012');
INSERT INTO public.virksomhet_naring VALUES (518, '70.220');
INSERT INTO public.virksomhet_naring VALUES (519, '01.120');
INSERT INTO public.virksomhet_naring VALUES (520, '01.120');
INSERT INTO public.virksomhet_naring VALUES (521, '01.120');
INSERT INTO public.virksomhet_naring VALUES (522, '01.120');
INSERT INTO public.virksomhet_naring VALUES (522, '90.012');
INSERT INTO public.virksomhet_naring VALUES (523, '01.120');
INSERT INTO public.virksomhet_naring VALUES (524, '01.120');
INSERT INTO public.virksomhet_naring VALUES (524, '90.012');
INSERT INTO public.virksomhet_naring VALUES (525, '01.120');
INSERT INTO public.virksomhet_naring VALUES (525, '90.012');
INSERT INTO public.virksomhet_naring VALUES (526, '01.120');
INSERT INTO public.virksomhet_naring VALUES (526, '90.012');
INSERT INTO public.virksomhet_naring VALUES (512, '01.120');
INSERT INTO public.virksomhet_naring VALUES (512, '90.012');
INSERT INTO public.virksomhet_naring VALUES (513, '01.120');
INSERT INTO public.virksomhet_naring VALUES (513, '90.012');
INSERT INTO public.virksomhet_naring VALUES (514, '01.120');
INSERT INTO public.virksomhet_naring VALUES (515, '01.120');
INSERT INTO public.virksomhet_naring VALUES (515, '90.012');
INSERT INTO public.virksomhet_naring VALUES (516, '01.120');
INSERT INTO public.virksomhet_naring VALUES (527, '01.120');
INSERT INTO public.virksomhet_naring VALUES (527, '01.110');
INSERT INTO public.virksomhet_naring VALUES (527, '70.220');
INSERT INTO public.virksomhet_naring VALUES (534, '01.120');
INSERT INTO public.virksomhet_naring VALUES (535, '01.120');
INSERT INTO public.virksomhet_naring VALUES (536, '01.120');
INSERT INTO public.virksomhet_naring VALUES (537, '01.120');
INSERT INTO public.virksomhet_naring VALUES (538, '01.120');
INSERT INTO public.virksomhet_naring VALUES (538, '90.012');
INSERT INTO public.virksomhet_naring VALUES (539, '01.120');
INSERT INTO public.virksomhet_naring VALUES (540, '01.120');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2022-12-05 10:42:55.730555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2022-12-05 10:42:55.837642');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '555555555', 'VIRKSOMHET', '1', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (6, '881532376', 'VIRKSOMHET', '1', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '883874352', 'VIRKSOMHET', '1', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '848147638', 'VIRKSOMHET', '1', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '876763949', 'VIRKSOMHET', '1', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '871871807', 'VIRKSOMHET', '0', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (15, '864079801', 'VIRKSOMHET', '2', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (16, '836041617', 'VIRKSOMHET', '1', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (17, '857842260', 'VIRKSOMHET', '0', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (18, '885073621', 'VIRKSOMHET', '0', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (19, '864754605', 'VIRKSOMHET', '1', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (20, '846347581', 'VIRKSOMHET', '1', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (21, '824680794', 'VIRKSOMHET', '2', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (22, '839415001', 'VIRKSOMHET', '0', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '861744528', 'VIRKSOMHET', '3', '2022-12-05 10:42:55.907904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '860138909', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.130522');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (25, '843242104', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.130522');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '890093850', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.130522');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (27, '892511017', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.130522');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '842605109', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.130522');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (29, '870491047', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.130522');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '863507760', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.130522');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (31, '817257908', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '809042383', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '810734693', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '804629062', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '873621335', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '835058832', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '803826652', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '874394467', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '838903289', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '882051647', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '879681201', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '852409131', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '808215075', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '865074415', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '836669149', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '884369776', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '873418367', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '802905016', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '885609899', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '860836918', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '829745509', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '844246611', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '867216743', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '890941228', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '838540049', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '809501750', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '844496478', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '863501025', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '839166324', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '879962157', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '848543645', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '880279851', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.198391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '808671188', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '851333885', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '815366017', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '891113900', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '894926128', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '802290404', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '896239097', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '816868949', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '895298219', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '842893897', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '814670938', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '820433803', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '874104569', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '856520283', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.418009');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '879090305', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '809468321', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '826378947', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '866390365', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '862771013', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '864363318', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '896438075', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '829368106', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '867407313', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '896587504', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '847845944', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '826389298', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '848399886', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '854846835', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '800634899', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '857110616', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '808271586', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '819801010', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '848578637', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '827490752', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '835736810', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '857544475', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '847721823', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '862581603', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '810313500', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '885129733', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '898243796', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '887079787', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '861058672', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '876537913', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '890597928', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '842982051', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '842389667', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '820004072', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '897688257', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '837534390', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '808543637', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '870201888', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '817311070', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '868012776', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '896429753', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '851603425', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.543598');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '827443317', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '833362642', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '882069408', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '863878944', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '866558221', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '868767855', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '875885300', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '842216735', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '856920437', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '830858963', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '812434114', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '847041353', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '803269327', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '843457384', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '818306281', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '844449510', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '867177223', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '883963814', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '886253015', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '895281822', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '840533481', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.805072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '839216776', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '803533948', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '827095124', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '808251981', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '817358823', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '871910327', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '866587133', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '842840788', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '812781923', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '804058381', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '811423248', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '840837641', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '818816392', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '806494928', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '893055618', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '875340822', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '818463756', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '884152302', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '849742742', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '804979817', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '814190896', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '822331640', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '862678317', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '831093023', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '874226454', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '832436811', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '838432048', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '870022919', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '879268334', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '806599852', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '863181199', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '863767568', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '844014636', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '866404710', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '833129946', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '846977998', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '811030348', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '890815907', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '822694021', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '852558904', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '822874914', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '866646453', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '881021956', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '899291735', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '867918928', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '823439458', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '837805347', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '805499088', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '845822610', 'VIRKSOMHET', '2', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '841405633', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '889675608', 'VIRKSOMHET', '3', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '899025387', 'VIRKSOMHET', '1', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '863280835', 'VIRKSOMHET', '0', '2022-12-05 10:42:56.958189');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '860629673', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '833667497', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '842471044', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '861459803', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '812926032', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '871631319', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '865439281', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '824210548', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '805486005', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '832448472', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '805820685', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '883768894', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '856903021', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '850012745', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '820149848', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '822705108', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '857573851', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '856078198', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '859225721', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '873879874', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '890065285', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '893423280', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '816273126', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '874977909', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '888632161', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '852452427', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '807389236', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '833163111', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '813080832', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '896489260', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '845881839', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '898157169', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '882940656', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.21877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '887589106', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '856439808', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '869911712', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '836420677', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '810521018', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '863021621', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '846289494', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '834191416', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '837420340', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '871949311', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '821633142', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '893463166', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '833218825', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '807456455', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '821381486', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '814324199', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '805904949', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '813242515', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '839415843', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '804234371', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '816585946', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '824097835', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '880538674', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '875775705', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '877421692', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '871547736', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '857653378', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '829980700', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '852627790', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '865978526', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '840145629', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '875016141', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '869419134', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '813944600', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '885600454', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '877550656', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '804227830', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '858956619', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '865153645', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '817941723', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '811667993', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '859462534', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '822317092', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '877772835', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '846495295', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '804775869', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '831030012', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '802809462', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '896200151', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.391485');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '873610100', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '847931581', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '870810427', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '816457914', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '816760477', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '821449527', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '897412997', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '801856356', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '898170941', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '884390144', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '894424841', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '828972512', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '815082581', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '887159012', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '829493874', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '814929193', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '859907302', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '895124699', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '813239227', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '840430296', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '858726639', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '823234800', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '874361830', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '808481735', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '860499175', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '892697142', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '826727890', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '895582762', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '814663914', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '887191975', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '856729012', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '816248533', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '847253663', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '851556995', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.613799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '897000352', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '891267708', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '868369009', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '836786224', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '800910790', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '847922087', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '882737279', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '817612413', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '857680168', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '878624841', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '867183919', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '824306551', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '812929350', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '890735735', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '894341616', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '845690609', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '884945724', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '820865124', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '870514368', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '833643869', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '807702188', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '820638689', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '843380901', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '832951634', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '833677243', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '873656323', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '859159231', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '868067017', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '856435712', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '888937591', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '873906284', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '855150484', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '836365546', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '822564929', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '833204596', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '863592645', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '865956727', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '807629933', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '832454631', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '823356725', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '800824855', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '894510083', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '815854671', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '876401827', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '845066027', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '815406101', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '866878310', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '830803739', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '805933483', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '868252144', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '828744326', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '830122600', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '813147327', 'VIRKSOMHET', '3', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '846250295', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '898250721', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '813697349', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '863104800', 'VIRKSOMHET', '1', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '897979593', 'VIRKSOMHET', '0', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '860772161', 'VIRKSOMHET', '2', '2022-12-05 10:42:57.790795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '808002552', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '876394411', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '846214156', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '850015354', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '805145991', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '853879838', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '882939801', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '859605190', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '891814367', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '875021136', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '825379831', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '800469195', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '871244244', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '837133219', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '855964219', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '838273484', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '893483616', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '891497759', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '888247901', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '883590490', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '804908767', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '851919134', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '813682750', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '875544956', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '889472231', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '875631634', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '856007783', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '844760467', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '863256691', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '851705582', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '854298834', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '836216435', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '893017297', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.07777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '841372032', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '862589424', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '871501781', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '880977356', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '859708655', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '837130075', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '803170681', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '875018446', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '872251225', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '889927472', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '850310272', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '878277970', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '811324382', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '878265174', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '803799726', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '827344157', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '868610918', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '891144647', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '874750888', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '879572863', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '816719384', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '823372812', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '872671153', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '837782686', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '856373244', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '802319687', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '882221112', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '825823538', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '840744367', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '807485242', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '878321914', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '886892017', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '871623349', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '864986459', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '849227492', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '850910144', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '869658223', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '866431270', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '858356342', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '852467356', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '898657961', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '846849579', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '873579899', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '843035298', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '858836952', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '805709917', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '808479485', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '838878962', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '885625328', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '837527996', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '844848494', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '825573136', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '809036318', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '800223332', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '878112453', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '893781546', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '818658010', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '862270603', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '812325897', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '817554736', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '884291457', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '890910485', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '810677960', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '830621787', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '874792210', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '828718942', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.228161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '846277869', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '809316543', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '846821438', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '836005340', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '869069081', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '824870495', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '821850314', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '895629317', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '854843256', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '825397589', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '856901774', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '886566656', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '868634250', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '827178297', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '889901026', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '860932226', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '883640440', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '899511765', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '826671551', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '838991015', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '831768843', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '803324193', 'VIRKSOMHET', '1', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '827269180', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '806938796', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '817130185', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '810402680', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '887841956', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '897336611', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '858728795', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '880050743', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '871161662', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '862924848', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '895031114', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.521442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '815517829', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '836666246', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '845715533', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '897156462', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '890815244', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '866562589', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '875322390', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '870376312', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '863074238', 'VIRKSOMHET', '3', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '873535604', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '820029647', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '825514130', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '815801592', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '839528084', 'VIRKSOMHET', '2', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '864571830', 'VIRKSOMHET', '0', '2022-12-05 10:42:58.643058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '883989256', 'VIRKSOMHET', '2', '2022-12-05 10:43:01.692503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '831272011', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.716182');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '831658088', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.738881');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '802008121', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.738881');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '857721878', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.738881');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '811747377', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.738881');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '801396893', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.780341');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '885133950', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.780341');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '864761302', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.780341');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '870050263', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.780341');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '881536611', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.817307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '862811969', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.817307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '892708443', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.817307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '866931781', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.817307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '868378133', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.817307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '872308278', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.862091');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '854032309', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.862091');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '842782667', 'VIRKSOMHET', '1', '2022-12-05 10:43:01.862091');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (533, '846058502', 'VIRKSOMHET', '1', '2022-12-05 10:43:06.197956');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (534, '878151780', 'VIRKSOMHET', '1', '2022-12-05 10:43:06.212004');


--
-- Name: sykefravar_statistikk_grunnlag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_grunnlag_id_seq', 1, false);


--
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_kategori_siste_4_kvartal_id_seq', 1, false);


--
-- Name: sykefravar_statistikk_land_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_land_id_seq', 535, true);


--
-- Name: sykefravar_statistikk_naring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_naring_id_seq', 535, true);


--
-- Name: sykefravar_statistikk_naringsundergruppe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_naringsundergruppe_id_seq', 535, true);


--
-- Name: sykefravar_statistikk_sektor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_sektor_id_seq', 535, true);


--
-- Name: sykefravar_statistikk_virksomhet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_virksomhet_id_seq', 535, true);


--
-- Name: sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq', 535, true);


--
-- Name: virksomhet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_id_seq', 540, true);


--
-- Name: virksomhet_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_metadata_id_seq', 535, true);


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
-- Name: sykefravar_statistikk_grunnlag sykefravar_statistikk_grunnlag_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_grunnlag
    ADD CONSTRAINT sykefravar_statistikk_grunnlag_pkey PRIMARY KEY (id);


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
-- Name: idx_sykefravar_statistikk_grunnlag_orgnr; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_sykefravar_statistikk_grunnlag_orgnr ON public.sykefravar_statistikk_grunnlag USING btree (orgnr);


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
-- Name: sykefravar_statistikk_grunnlag fk_sykefravar_statistikk_grunnlag_hendelse; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_grunnlag
    ADD CONSTRAINT fk_sykefravar_statistikk_grunnlag_hendelse FOREIGN KEY (hendelse_id) REFERENCES public.ia_sak_hendelse(id);


--
-- Name: sykefravar_statistikk_grunnlag fk_sykefravar_statistikk_grunnlag_sak; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_grunnlag
    ADD CONSTRAINT fk_sykefravar_statistikk_grunnlag_sak FOREIGN KEY (saksnummer) REFERENCES public.ia_sak(saksnummer);


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
-- Name: TABLE sykefravar_statistikk_grunnlag; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.sykefravar_statistikk_grunnlag TO cloudsqliamuser;


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

