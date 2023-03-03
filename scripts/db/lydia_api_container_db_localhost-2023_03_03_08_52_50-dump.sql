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
ALTER TABLE IF EXISTS ONLY public.modul DROP CONSTRAINT IF EXISTS fk_modul_ia_tjeneste;
ALTER TABLE IF EXISTS ONLY public.iasak_leveranse DROP CONSTRAINT IF EXISTS fk_iasak_leveranse_saksnummer;
ALTER TABLE IF EXISTS ONLY public.iasak_leveranse DROP CONSTRAINT IF EXISTS fk_iasak_leveranse_modul;
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
ALTER TABLE IF EXISTS ONLY public.modul DROP CONSTRAINT IF EXISTS modul_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_land DROP CONSTRAINT IF EXISTS land_periode;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_kategori_siste_4_kvartal DROP CONSTRAINT IF EXISTS kategori_og_kode;
ALTER TABLE IF EXISTS ONLY public.iasak_leveranse DROP CONSTRAINT IF EXISTS iasak_leveranse_unik;
ALTER TABLE IF EXISTS ONLY public.iasak_leveranse DROP CONSTRAINT IF EXISTS iasak_leveranse_pkey;
ALTER TABLE IF EXISTS ONLY public.ia_tjeneste DROP CONSTRAINT IF EXISTS ia_tjeneste_pkey;
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
ALTER TABLE IF EXISTS public.modul ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.iasak_leveranse ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ia_tjeneste ALTER COLUMN id DROP DEFAULT;
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
DROP SEQUENCE IF EXISTS public.modul_id_seq;
DROP TABLE IF EXISTS public.modul;
DROP SEQUENCE IF EXISTS public.iasak_leveranse_id_seq;
DROP TABLE IF EXISTS public.iasak_leveranse;
DROP SEQUENCE IF EXISTS public.ia_tjeneste_id_seq;
DROP TABLE IF EXISTS public.ia_tjeneste;
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
-- Name: ia_tjeneste; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.ia_tjeneste (
    id integer NOT NULL,
    navn character varying NOT NULL
);


ALTER TABLE public.ia_tjeneste OWNER TO test;

--
-- Name: ia_tjeneste_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.ia_tjeneste_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ia_tjeneste_id_seq OWNER TO test;

--
-- Name: ia_tjeneste_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.ia_tjeneste_id_seq OWNED BY public.ia_tjeneste.id;


--
-- Name: iasak_leveranse; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.iasak_leveranse (
    id integer NOT NULL,
    saksnummer character varying(26) NOT NULL,
    modul integer NOT NULL,
    frist date NOT NULL,
    status character varying DEFAULT 'UNDER_ARBEID'::character varying NOT NULL,
    opprettet_av character varying NOT NULL,
    sist_endret timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sist_endret_av character varying NOT NULL,
    fullfort timestamp without time zone
);


ALTER TABLE public.iasak_leveranse OWNER TO test;

--
-- Name: iasak_leveranse_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.iasak_leveranse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.iasak_leveranse_id_seq OWNER TO test;

--
-- Name: iasak_leveranse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.iasak_leveranse_id_seq OWNED BY public.iasak_leveranse.id;


--
-- Name: modul; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.modul (
    id integer NOT NULL,
    ia_tjeneste integer NOT NULL,
    navn character varying NOT NULL
);


ALTER TABLE public.modul OWNER TO test;

--
-- Name: modul_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.modul_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modul_id_seq OWNER TO test;

--
-- Name: modul_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.modul_id_seq OWNED BY public.modul.id;


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
-- Name: ia_tjeneste id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.ia_tjeneste ALTER COLUMN id SET DEFAULT nextval('public.ia_tjeneste_id_seq'::regclass);


--
-- Name: iasak_leveranse id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.iasak_leveranse ALTER COLUMN id SET DEFAULT nextval('public.iasak_leveranse_id_seq'::regclass);


--
-- Name: modul id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.modul ALTER COLUMN id SET DEFAULT nextval('public.modul_id_seq'::regclass);


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

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', 'V1__init.sql', 1782034767, 'test', '2023-03-03 08:49:45.819076', 31, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', 'V2__create_virksomhet_adresse.sql', -64248919, 'test', '2023-03-03 08:49:45.885842', 31, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', 'V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2023-03-03 08:49:45.957256', 13, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', 'V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2023-03-03 08:49:45.998168', 18, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', 'V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2023-03-03 08:49:46.048358', 14, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', 'V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2023-03-03 08:49:46.086394', 11, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', 'V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2023-03-03 08:49:46.117092', 12, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', 'V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2023-03-03 08:49:46.1459', 9, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', 'V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2023-03-03 08:49:46.17234', 16, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', 'V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2023-03-03 08:49:46.207671', 9, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', 'V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2023-03-03 08:49:46.235916', 9, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', 'V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2023-03-03 08:49:46.265117', 14, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', 'V13__ia_prosess.sql', -1755516749, 'test', '2023-03-03 08:49:46.311933', 13, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', 'V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2023-03-03 08:49:46.349265', 14, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', 'V15__endre_saknummer.sql', -1379621340, 'test', '2023-03-03 08:49:46.382238', 10, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', 'V16__ia_sak_hendelse.sql', 586872662, 'test', '2023-03-03 08:49:46.411671', 21, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', 'V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2023-03-03 08:49:46.453275', 9, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', 'V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2023-03-03 08:49:46.482467', 16, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', 'V19__legg_til_begrunnelser.sql', 779259005, 'test', '2023-03-03 08:49:46.518566', 9, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', 'V20__legg_til_flere_indekser.sql', -843857404, 'test', '2023-03-03 08:49:46.547424', 19, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', 'V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2023-03-03 08:49:46.589195', 8, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', 'V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2023-03-03 08:49:46.615924', 10, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', 'V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2023-03-03 08:49:46.64652', 11, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', 'V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2023-03-03 08:49:46.675319', 17, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', 'V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2023-03-03 08:49:46.711949', 28, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', 'V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2023-03-03 08:49:46.760364', 8, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', 'V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2023-03-03 08:49:46.787456', 9, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', 'V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2023-03-03 08:49:46.816249', 9, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', 'V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2023-03-03 08:49:46.846395', 9, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', 'V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2023-03-03 08:49:46.873644', 12, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', 'V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2023-03-03 08:49:46.90757', 11, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', 'V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2023-03-03 08:49:46.936192', 15, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', 'V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2023-03-03 08:49:46.972553', 9, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', 'V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2023-03-03 08:49:47.001318', 13, true);
INSERT INTO public.flyway_schema_history VALUES (35, '35', 'drop sykefravar statistikk grunnlag', 'SQL', 'V35__drop_sykefravar_statistikk_grunnlag.sql', 461103825, 'test', '2023-03-03 08:49:47.033271', 9, true);
INSERT INTO public.flyway_schema_history VALUES (36, '36', 'registrere bistand', 'SQL', 'V36__registrere_bistand.sql', -1365283904, 'test', '2023-03-03 08:49:47.060346', 23, true);
INSERT INTO public.flyway_schema_history VALUES (37, '37', 'fullfoert dato leveranse', 'SQL', 'V37__fullfoert_dato_leveranse.sql', 1621470787, 'test', '2023-03-03 08:49:47.100932', 9, true);
INSERT INTO public.flyway_schema_history VALUES (38, '38', 'oppdatere moduler', 'SQL', 'V38__oppdatere_moduler.sql', -246234034, 'test', '2023-03-03 08:49:47.126709', 9, true);
INSERT INTO public.flyway_schema_history VALUES (39, '39', 'rette iatjeneste på modul', 'SQL', 'V39__rette_iatjeneste_på_modul.sql', -1034067650, 'test', '2023-03-03 08:49:47.153384', 7, true);
INSERT INTO public.flyway_schema_history VALUES (40, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 469189921, 'test', '2023-03-03 08:49:47.177949', 13, true);
INSERT INTO public.flyway_schema_history VALUES (41, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 1120875001, 'test', '2023-03-03 08:50:12.234143', 28, true);


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
-- Data for Name: ia_tjeneste; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.ia_tjeneste VALUES (1, 'Redusere sykefravær');
INSERT INTO public.ia_tjeneste VALUES (2, 'Forebyggende arbeidsmiljøarbeid');
INSERT INTO public.ia_tjeneste VALUES (3, 'HelseIArbeid');


--
-- Data for Name: iasak_leveranse; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: modul; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.modul VALUES (1, 1, 'Videreutvikle sykefraværsrutiner');
INSERT INTO public.modul VALUES (2, 1, 'Oppfølgingssamtalen');
INSERT INTO public.modul VALUES (3, 1, 'Tilretteleggingsplikt og medvirkningsplikt');
INSERT INTO public.modul VALUES (4, 1, 'Langvarige og/eller hyppig gjentakende sykefravær');
INSERT INTO public.modul VALUES (5, 2, 'Utvikle partssamarbeid');
INSERT INTO public.modul VALUES (6, 2, 'Enkel arbeidsmiljøkartlegging');
INSERT INTO public.modul VALUES (7, 2, 'Kontinuerlig (arbeidsmiljø)forbedring');
INSERT INTO public.modul VALUES (8, 2, 'Endring og omstilling');
INSERT INTO public.modul VALUES (9, 2, 'Oppfølging av arbeidsmiljøundersøkelse');
INSERT INTO public.modul VALUES (10, 2, 'Livsfaseorientert personalpolitikk');
INSERT INTO public.modul VALUES (11, 3, 'Muskel- og skjelett');
INSERT INTO public.modul VALUES (12, 3, 'Smertemestring og arbeidsmiljø');
INSERT INTO public.modul VALUES (13, 3, 'Psykisk helse');
INSERT INTO public.modul VALUES (14, 2, 'Sees i morgen');


--
-- Data for Name: naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.naring VALUES ('00.000', 'Uoppgitt', 'Uoppgitt');
INSERT INTO public.naring VALUES ('00', 'Uoppgitt', 'Uoppgitt');
INSERT INTO public.naring VALUES ('01', 'Næring', 'Kortnavn for 01');
INSERT INTO public.naring VALUES ('01.120', 'Dyrking av ris', 'Kortnavn for 01.120');
INSERT INTO public.naring VALUES ('90', 'Næring', 'Kortnavn for 90');
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

INSERT INTO public.sykefravar_statistikk_land VALUES (1, 2022, 4, 'NO', 2500000, 10000000, 500000000, 2, false, '2023-03-03 08:50:19.285638');
INSERT INTO public.sykefravar_statistikk_land VALUES (2, 2022, 3, 'NO', 2500000, 10000000, 500000000, 2, false, '2023-03-03 08:50:19.37852');


--
-- Data for Name: sykefravar_statistikk_naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naring VALUES (1, 2022, 4, '01', 150, 100, 5000, 2, false, '2023-03-03 08:50:19.285638');
INSERT INTO public.sykefravar_statistikk_naring VALUES (2, 2022, 3, '01', 150, 100, 5000, 2, false, '2023-03-03 08:50:19.37852');


--
-- Data for Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naringsundergruppe VALUES (1, 2022, 4, '01.110', 1250, 40, 4000, 1, false, '2023-03-03 08:50:19.285638');
INSERT INTO public.sykefravar_statistikk_naringsundergruppe VALUES (2, 2022, 3, '01.110', 1250, 40, 4000, 1, false, '2023-03-03 08:50:19.37852');


--
-- Data for Name: sykefravar_statistikk_sektor; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_sektor VALUES (1, 2022, 4, '1', 33000, 1340, 8000, 1.5, false, '2023-03-03 08:50:19.285638');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (2, 2022, 3, '1', 33000, 1340, 8000, 1.5, false, '2023-03-03 08:50:19.37852');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (16, 2022, 4, '2', 33000, 1340, 8000, 1.5, false, '2023-03-03 08:50:19.47007');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (17, 2022, 4, '0', 33000, 1340, 8000, 1.5, false, '2023-03-03 08:50:19.47007');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (22, 2022, 4, '3', 33000, 1340, 8000, 1.5, false, '2023-03-03 08:50:19.47007');


--
-- Data for Name: sykefravar_statistikk_virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2022, 4, 6, 6527.42078888379, 500, 6, false, '2023-03-03 08:50:19.285638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2022, 3, 6, 6527.42078888379, 500, 9, false, '2023-03-03 08:50:19.37852', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2022, 4, 891.674198336008, 5797.94180363533, 500, 7, false, '2023-03-03 08:50:19.37852', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2022, 3, 891.674198336008, 5797.94180363533, 500, 7, false, '2023-03-03 08:50:19.37852', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '555555555', 2022, 4, 489.943239402274, 9846.1714180263, 500, 9, false, '2023-03-03 08:50:19.37852', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '881532376', 2022, 4, 955.405347480702, 4803.5127183432, 500, 6, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '881532376', 2022, 3, 955.405347480702, 4803.5127183432, 500, 6, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '883874352', 2022, 4, 42, 8398.56166480652, 500, 6, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '883874352', 2022, 3, 42, 8398.56166480652, 500, 6, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '848147638', 2022, 4, 42, 2301.92528361622, 500, 6, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '848147638', 2022, 3, 42, 2301.92528361622, 500, 6, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '876763949', 2022, 4, 33.9675744017618, 8348.06356964635, 500, 7, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '876763949', 2022, 3, 33.9675744017618, 8348.06356964635, 500, 18, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '871871807', 2022, 4, 351.507950295194, 2862.39102860482, 500, 14, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '864079801', 2022, 4, 610.012376918249, 2995.43961092674, 500, 15, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '836041617', 2022, 4, 931.018860027184, 9841.9392042829, 500, 14, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '857842260', 2022, 4, 409.229700357447, 7296.22754945459, 500, 18, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '885073621', 2022, 4, 836.965156798589, 1274.44430782553, 500, 15, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '864754605', 2022, 4, 943.679752526277, 6751.84615612893, 500, 9, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '846347581', 2022, 4, 878.24154694546, 5606.86050953852, 500, 19, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '824680794', 2022, 4, 397.464026390949, 6951.74858116382, 500, 4, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '839415001', 2022, 4, 297.833182995135, 3187.75565628421, 500, 7, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '861744528', 2022, 4, 423.91113161354, 1979.80365487258, 500, 3, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '860138909', 2022, 4, 46.0177124022341, 3896.85746034128, 500, 3, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '843242104', 2022, 4, 796.731812265275, 6372.15946872143, 500, 9, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '890093850', 2022, 4, 362.863567019362, 7420.61634528547, 500, 14, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '892511017', 2022, 4, 812.472748808226, 7235.56865770029, 500, 3, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '842605109', 2022, 4, 697.911767016559, 5523.71374708133, 500, 11, false, '2023-03-03 08:50:19.47007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '870491047', 2022, 4, 772.363127225249, 5188.66178515282, 500, 3, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '863507760', 2022, 4, 27.4482728498206, 6751.67412100458, 500, 17, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '817257908', 2022, 4, 780.14239857165, 9052.15149215536, 500, 14, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '809042383', 2022, 4, 259.645727346501, 5439.62161347536, 500, 13, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '810734693', 2022, 4, 647.595739733267, 6804.28996148263, 500, 3, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '804629062', 2022, 4, 734.751082347809, 8173.24677492691, 500, 19, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '873621335', 2022, 4, 760.33376113066, 47.1824866458551, 500, 19, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '835058832', 2022, 4, 688.293912951035, 4436.4807780598, 500, 6, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '803826652', 2022, 4, 727.184713707335, 1236.33901075482, 500, 12, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '874394467', 2022, 4, 656.526253165459, 9916.08659752659, 500, 16, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '838903289', 2022, 4, 602.257306478672, 4254.09993637271, 500, 4, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '882051647', 2022, 4, 232.684956427991, 4697.07124995256, 500, 1, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '879681201', 2022, 4, 968.698702569988, 2226.54889261374, 500, 1, false, '2023-03-03 08:50:19.724716', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '852409131', 2022, 4, 156.302646364891, 9971.9085253873, 500, 2, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '808215075', 2022, 4, 193.340872509005, 5363.33326634375, 500, 6, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '865074415', 2022, 4, 275.554214250058, 9520.63694286516, 500, 12, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '836669149', 2022, 4, 96.6842605164525, 1097.89467919733, 500, 20, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '884369776', 2022, 4, 987.014576206439, 7514.42622996764, 500, 4, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '873418367', 2022, 4, 49.5052189948289, 4211.59919776987, 500, 10, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '802905016', 2022, 4, 740.837853203861, 6812.13648826617, 500, 4, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '885609899', 2022, 4, 833.978102083762, 6766.26628283094, 500, 18, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '860836918', 2022, 4, 906.111773779232, 2128.81169072066, 500, 6, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '829745509', 2022, 4, 193.023272216777, 4280.13754950072, 500, 19, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '844246611', 2022, 4, 722.514487206963, 6698.17298668778, 500, 4, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '867216743', 2022, 4, 804.067466095017, 8986.18193454514, 500, 10, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '890941228', 2022, 4, 110.618145530002, 8851.17710886627, 500, 19, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '838540049', 2022, 4, 150.749803148667, 7175.41753130711, 500, 16, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '809501750', 2022, 4, 914.790686070998, 2851.63367819294, 500, 7, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '844496478', 2022, 4, 51.2814928316561, 8437.76366514435, 500, 6, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '863501025', 2022, 4, 412.029918981654, 4062.09609395583, 500, 6, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '839166324', 2022, 4, 12.2174194469189, 4165.59901778674, 500, 1, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '879962157', 2022, 4, 889.252738768844, 2523.38556513241, 500, 19, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '848543645', 2022, 4, 583.541186548085, 7097.46249726053, 500, 14, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '880279851', 2022, 4, 710.953798860611, 2745.38834804767, 500, 11, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '808671188', 2022, 4, 367.283381636904, 3294.20787875431, 500, 7, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '851333885', 2022, 4, 754.49152985173, 5483.8364382197, 500, 8, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '815366017', 2022, 4, 18.9484295982172, 9166.38780237386, 500, 5, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '891113900', 2022, 4, 885.02512269147, 3038.49113686242, 500, 10, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '894926128', 2022, 4, 135.049300596607, 4635.3913919443, 500, 18, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '802290404', 2022, 4, 615.799243785358, 7043.80734327336, 500, 10, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '896239097', 2022, 4, 857.06954200082, 6135.51729118692, 500, 1, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '816868949', 2022, 4, 201.701259694449, 4580.57378935933, 500, 3, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '895298219', 2022, 4, 185.075576114043, 329.870288184419, 500, 17, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '842893897', 2022, 4, 694.584811961111, 2720.4766178312, 500, 5, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '814670938', 2022, 4, 271.689292266357, 496.123865416499, 500, 20, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '820433803', 2022, 4, 655.651008654115, 7204.88421392289, 500, 17, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '874104569', 2022, 4, 643.694617769674, 2720.49992896507, 500, 9, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '856520283', 2022, 4, 349.214350280513, 1365.61267506264, 500, 16, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '879090305', 2022, 4, 664.121896531874, 5391.77466063158, 500, 7, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '809468321', 2022, 4, 480.305666496238, 4926.55061583138, 500, 12, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '826378947', 2022, 4, 345.702025820573, 4129.86965160225, 500, 15, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '866390365', 2022, 4, 193.828173016446, 8932.66460870947, 500, 7, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '862771013', 2022, 4, 174.736359649715, 1852.61854362739, 500, 2, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '864363318', 2022, 4, 545.109722928789, 9454.26589862818, 500, 1, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '896438075', 2022, 4, 908.673448157524, 5890.08934096878, 500, 5, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '829368106', 2022, 4, 388.038045055401, 9139.93087626817, 500, 11, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '867407313', 2022, 4, 40.3830319078585, 2986.21537296626, 500, 19, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '896587504', 2022, 4, 504.473966005044, 622.475739650332, 500, 3, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '847845944', 2022, 4, 417.666338869461, 6784.22574407787, 500, 14, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '826389298', 2022, 4, 646.551685404811, 301.310843015958, 500, 9, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '848399886', 2022, 4, 199.604637245331, 9614.42938306625, 500, 7, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '854846835', 2022, 4, 111.158490134215, 8439.68977195388, 500, 4, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '800634899', 2022, 4, 460.787426716522, 246.320753635999, 500, 4, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '857110616', 2022, 4, 968.611018533505, 561.161922287384, 500, 3, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '808271586', 2022, 4, 664.073218197324, 4181.98741251898, 500, 9, false, '2023-03-03 08:50:19.857593', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '819801010', 2022, 4, 955.017591461109, 6594.69832283687, 500, 20, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '848578637', 2022, 4, 767.734826353386, 868.473690490926, 500, 20, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '827490752', 2022, 4, 699.312233950875, 5747.48234402115, 500, 19, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '835736810', 2022, 4, 832.27895883133, 9219.27296811, 500, 8, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '857544475', 2022, 4, 792.227303392112, 7218.5248669787, 500, 16, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '847721823', 2022, 4, 186.867463814576, 6352.31916067167, 500, 19, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '862581603', 2022, 4, 746.208566046787, 7722.14425077178, 500, 5, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '810313500', 2022, 4, 29.4191845190796, 4359.54502815066, 500, 11, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '885129733', 2022, 4, 936.642924988302, 2075.40843495649, 500, 17, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '898243796', 2022, 4, 149.575712322112, 9262.00181206999, 500, 9, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '887079787', 2022, 4, 922.185141695592, 7244.28241791375, 500, 3, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '861058672', 2022, 4, 757.067419497924, 2385.83026341173, 500, 1, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '876537913', 2022, 4, 401.083510734905, 4477.52520584333, 500, 6, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '890597928', 2022, 4, 633.846915160941, 3431.52278699073, 500, 20, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '842982051', 2022, 4, 650.173719987459, 5655.61713154097, 500, 4, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '842389667', 2022, 4, 451.54280790577, 316.264552677525, 500, 19, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '820004072', 2022, 4, 695.11255616241, 828.4997322786, 500, 9, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '897688257', 2022, 4, 445.078468317142, 5548.53863615577, 500, 11, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '837534390', 2022, 4, 642.619056480461, 2733.00181598242, 500, 12, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '808543637', 2022, 4, 75.8067956310134, 4986.11429750684, 500, 6, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '870201888', 2022, 4, 912.382647710605, 1614.61832623051, 500, 11, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '817311070', 2022, 4, 349.915689821282, 7477.34367030273, 500, 2, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '868012776', 2022, 4, 18.5488810376653, 6732.71900891067, 500, 15, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '896429753', 2022, 4, 233.854645163576, 7075.87728904588, 500, 7, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '851603425', 2022, 4, 695.681107951464, 2157.35054037854, 500, 12, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '827443317', 2022, 4, 66.6044898514446, 3835.54564357088, 500, 5, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '833362642', 2022, 4, 551.728111991878, 6207.53287309159, 500, 19, false, '2023-03-03 08:50:20.187885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '882069408', 2022, 4, 32.7009771850807, 5388.17586595234, 500, 14, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '863878944', 2022, 4, 908.920229314083, 8699.16863809146, 500, 19, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '866558221', 2022, 4, 263.384881810914, 1520.29358016745, 500, 16, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '868767855', 2022, 4, 565.845895269361, 1806.98001799295, 500, 4, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '875885300', 2022, 4, 998.183417938053, 5172.25060866812, 500, 8, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '842216735', 2022, 4, 936.142643323844, 3591.16505868156, 500, 7, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '856920437', 2022, 4, 512.203242953293, 5902.68513009272, 500, 14, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '830858963', 2022, 4, 380.776808321454, 8269.42201071565, 500, 11, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '812434114', 2022, 4, 251.372429565023, 8547.77322973324, 500, 13, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '847041353', 2022, 4, 184.85203051934, 111.100276626581, 500, 2, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '803269327', 2022, 4, 571.056737982937, 6673.88348170606, 500, 15, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '843457384', 2022, 4, 341.213021948027, 5355.05975631696, 500, 15, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '818306281', 2022, 4, 816.211269493186, 639.560801851168, 500, 19, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '844449510', 2022, 4, 190.228032458546, 8287.84569913789, 500, 2, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '867177223', 2022, 4, 972.876714277819, 9836.80068854197, 500, 2, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '883963814', 2022, 4, 946.197081882338, 2014.33374338738, 500, 5, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '886253015', 2022, 4, 671.160602963652, 4591.46476481886, 500, 6, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '895281822', 2022, 4, 103.797999004831, 1762.05242254078, 500, 2, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '840533481', 2022, 4, 92.0184725779419, 9368.34948654156, 500, 15, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '839216776', 2022, 4, 681.507938248385, 5917.5285898869, 500, 1, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '803533948', 2022, 4, 739.57667942767, 8953.18050637431, 500, 14, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '827095124', 2022, 4, 28.4188815380875, 821.796126777901, 500, 12, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '808251981', 2022, 4, 54.1895905276554, 6544.11480897056, 500, 13, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '817358823', 2022, 4, 517.214417421617, 4925.41904099124, 500, 12, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '871910327', 2022, 4, 183.68723081435, 6049.2641131855, 500, 11, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '866587133', 2022, 4, 989.273277990905, 3320.94347350303, 500, 6, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '842840788', 2022, 4, 736.537192759947, 8716.45366964219, 500, 11, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '812781923', 2022, 4, 278.61541203775, 9517.61405375399, 500, 3, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '804058381', 2022, 4, 18.9909950813282, 1221.54276761349, 500, 11, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '811423248', 2022, 4, 856.707616982229, 6262.81938055144, 500, 13, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '840837641', 2022, 4, 677.017625477299, 7746.91199861303, 500, 12, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '818816392', 2022, 4, 770.836384155866, 85.3819616742144, 500, 11, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '806494928', 2022, 4, 612.410011431832, 7340.84395500273, 500, 7, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '893055618', 2022, 4, 786.14201500697, 5237.22280514874, 500, 19, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '875340822', 2022, 4, 505.029890974464, 976.573441960283, 500, 3, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '818463756', 2022, 4, 867.822208544632, 9273.91186929769, 500, 9, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '884152302', 2022, 4, 790.109359394018, 2049.91272641433, 500, 17, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '849742742', 2022, 4, 157.208121833954, 8362.00911908246, 500, 2, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '804979817', 2022, 4, 890.999908492692, 9916.09243849805, 500, 5, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '814190896', 2022, 4, 96.2467035907213, 822.065258736564, 500, 18, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '822331640', 2022, 4, 784.126998109763, 4883.77176577518, 500, 8, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '862678317', 2022, 4, 437.790186692756, 6481.71981271863, 500, 1, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '831093023', 2022, 4, 239.954400967285, 1783.56545325839, 500, 8, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '874226454', 2022, 4, 748.868045970404, 8196.45412273757, 500, 5, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '832436811', 2022, 4, 699.029410733264, 2624.26676517001, 500, 15, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '838432048', 2022, 4, 740.412462019021, 6954.00405847134, 500, 14, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '870022919', 2022, 4, 230.065774112432, 936.451910203078, 500, 14, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '879268334', 2022, 4, 758.944135629292, 4851.12967369989, 500, 11, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '806599852', 2022, 4, 283.392630824436, 2795.94668265785, 500, 13, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '863181199', 2022, 4, 88.7946720563129, 9805.10031453977, 500, 6, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '863767568', 2022, 4, 222.110785251388, 6145.25245384715, 500, 12, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '844014636', 2022, 4, 699.873872507795, 3613.83797987179, 500, 7, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '866404710', 2022, 4, 463.583295801279, 763.472972200633, 500, 1, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '833129946', 2022, 4, 447.895727207569, 780.262035817131, 500, 8, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '846977998', 2022, 4, 681.762493287496, 6751.43585744928, 500, 11, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '811030348', 2022, 4, 652.415870210274, 8459.38641318621, 500, 8, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '890815907', 2022, 4, 108.047015169992, 8196.50079583007, 500, 15, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '822694021', 2022, 4, 774.789153226483, 2822.16714313597, 500, 18, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '852558904', 2022, 4, 455.950377653263, 2962.64452721413, 500, 15, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '822874914', 2022, 4, 309.529628057562, 3967.89455929854, 500, 20, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '866646453', 2022, 4, 681.017128663149, 5881.69965747782, 500, 6, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '881021956', 2022, 4, 169.895139570795, 6354.80257516871, 500, 17, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '899291735', 2022, 4, 177.769179295422, 2463.10692117221, 500, 13, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '867918928', 2022, 4, 526.086195744606, 568.775747442361, 500, 15, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '823439458', 2022, 4, 653.472886987112, 372.463756999449, 500, 5, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '837805347', 2022, 4, 864.722564247063, 9905.51745155715, 500, 20, false, '2023-03-03 08:50:20.384243', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '805499088', 2022, 4, 712.054354520723, 360.186280764673, 500, 19, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '845822610', 2022, 4, 10.1051124521285, 8947.0149310808, 500, 4, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '841405633', 2022, 4, 820.737918885134, 78.7289219504391, 500, 19, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '889675608', 2022, 4, 525.435989754831, 5943.14347824568, 500, 15, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '899025387', 2022, 4, 982.98406096789, 7934.1623189023, 500, 14, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '863280835', 2022, 4, 654.965730853536, 3499.37000094142, 500, 5, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '860629673', 2022, 4, 7.27507780127309, 3023.7654973894, 500, 4, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '833667497', 2022, 4, 976.245656921229, 7284.54103219964, 500, 17, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '842471044', 2022, 4, 944.754881157586, 3126.84104267056, 500, 20, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '861459803', 2022, 4, 752.061333573805, 242.451847397747, 500, 17, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '812926032', 2022, 4, 383.559582668708, 6678.31903612873, 500, 19, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '871631319', 2022, 4, 308.524780532777, 4894.55552702594, 500, 8, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '865439281', 2022, 4, 526.876317770602, 4545.3492205658, 500, 7, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '824210548', 2022, 4, 976.117395953112, 3846.12511960344, 500, 7, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '805486005', 2022, 4, 291.513596064327, 7773.08085930489, 500, 1, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '832448472', 2022, 4, 641.275383194784, 6041.26724558488, 500, 7, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '805820685', 2022, 4, 73.514949360645, 5153.49475005463, 500, 3, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '883768894', 2022, 4, 720.799636042042, 2632.32413733667, 500, 9, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '856903021', 2022, 4, 803.356852140977, 1226.82147768309, 500, 1, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '850012745', 2022, 4, 856.544090426868, 4975.60829712847, 500, 15, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '820149848', 2022, 4, 210.813529864656, 3250.26191140804, 500, 5, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '822705108', 2022, 4, 232.938280376502, 506.04355784533, 500, 20, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '857573851', 2022, 4, 85.3187994923513, 236.106967570407, 500, 16, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '856078198', 2022, 4, 931.397241581551, 9921.98017971798, 500, 11, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '859225721', 2022, 4, 991.129213130404, 6035.1931094995, 500, 13, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '873879874', 2022, 4, 67.6471264277948, 5203.92857808176, 500, 19, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '890065285', 2022, 4, 991.496015352773, 5961.53194920542, 500, 14, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '893423280', 2022, 4, 602.653278734357, 6064.61899183122, 500, 11, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '816273126', 2022, 4, 813.14222278549, 1146.21637950856, 500, 9, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '874977909', 2022, 4, 413.608652447376, 5612.9888887503, 500, 3, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '888632161', 2022, 4, 460.883064351847, 8408.60287982626, 500, 10, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '852452427', 2022, 4, 735.667677323625, 8843.50125911212, 500, 1, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '807389236', 2022, 4, 243.514468596778, 8413.83174881011, 500, 16, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '833163111', 2022, 4, 965.114355414446, 5723.97273485918, 500, 11, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '813080832', 2022, 4, 105.388135409943, 9410.56608676885, 500, 15, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '896489260', 2022, 4, 760.819128439908, 4710.38606843423, 500, 17, false, '2023-03-03 08:50:20.756289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '845881839', 2022, 4, 559.63890479469, 3853.55322374451, 500, 8, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '898157169', 2022, 4, 863.955865580769, 3173.96928129701, 500, 13, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '882940656', 2022, 4, 296.143371400834, 1162.78938200969, 500, 14, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '887589106', 2022, 4, 19.6447493802683, 6043.18897066429, 500, 20, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '856439808', 2022, 4, 371.200873653819, 2603.86980271367, 500, 8, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '869911712', 2022, 4, 435.696773093764, 4680.40735804296, 500, 15, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '836420677', 2022, 4, 344.914952743101, 5573.33143056682, 500, 15, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '810521018', 2022, 4, 963.206644757372, 8341.80024777735, 500, 6, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '863021621', 2022, 4, 249.331619550169, 3736.44565655602, 500, 4, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '846289494', 2022, 4, 673.027193070181, 6233.43253784794, 500, 20, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '834191416', 2022, 4, 398.064409676086, 5521.55428584625, 500, 6, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '837420340', 2022, 4, 165.441640936145, 4399.18241394836, 500, 16, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '871949311', 2022, 4, 471.704456669367, 2730.35605230767, 500, 2, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '821633142', 2022, 4, 113.134104807373, 9191.29343069245, 500, 2, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '893463166', 2022, 4, 410.529847098847, 9662.55707464275, 500, 7, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '833218825', 2022, 4, 625.385567951725, 9429.40764485444, 500, 7, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '807456455', 2022, 4, 882.377585104262, 1948.30987870714, 500, 16, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '821381486', 2022, 4, 69.3687227443002, 8763.53820248297, 500, 4, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '814324199', 2022, 4, 177.719759525426, 8452.93610825574, 500, 10, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '805904949', 2022, 4, 184.80332241563, 8289.8537828658, 500, 6, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '813242515', 2022, 4, 717.058158623417, 3757.16988228098, 500, 13, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '839415843', 2022, 4, 677.225072416084, 9150.07568714459, 500, 13, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '804234371', 2022, 4, 671.193458568954, 8113.82155653349, 500, 14, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '816585946', 2022, 4, 872.873670146671, 9296.50536183486, 500, 9, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '824097835', 2022, 4, 23.5597130665467, 457.110704237551, 500, 4, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '880538674', 2022, 4, 857.096177402841, 9479.14056671883, 500, 16, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '875775705', 2022, 4, 85.8335101508212, 4392.94606979619, 500, 2, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '877421692', 2022, 4, 959.294561747737, 2310.27590010755, 500, 20, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '871547736', 2022, 4, 960.315291447683, 7415.74205001017, 500, 3, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '857653378', 2022, 4, 980.162373230441, 2417.37722383403, 500, 17, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '829980700', 2022, 4, 786.037677357234, 595.496801688239, 500, 1, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '852627790', 2022, 4, 98.6032223110279, 389.909382737813, 500, 19, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '865978526', 2022, 4, 951.002865647298, 7306.65861717765, 500, 13, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '840145629', 2022, 4, 666.671522494074, 2615.87160547758, 500, 8, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '875016141', 2022, 4, 230.132847719287, 9210.86246611267, 500, 9, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '869419134', 2022, 4, 94.785203492013, 8137.61734341648, 500, 7, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '813944600', 2022, 4, 884.355686357846, 714.537265383734, 500, 13, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '885600454', 2022, 4, 504.159384053708, 6476.93133668657, 500, 5, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '877550656', 2022, 4, 901.697655371505, 7023.27561400932, 500, 20, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '804227830', 2022, 4, 935.949258091234, 1414.51003329645, 500, 4, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '858956619', 2022, 4, 598.740050564728, 5684.80143206448, 500, 15, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '865153645', 2022, 4, 822.327519441144, 4678.13692876396, 500, 12, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '817941723', 2022, 4, 827.767001010972, 4330.8938738129, 500, 19, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '811667993', 2022, 4, 571.462315393666, 7981.48696451387, 500, 14, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '859462534', 2022, 4, 33.7669188980748, 5932.19542236881, 500, 11, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '822317092', 2022, 4, 260.830229589487, 323.849916892416, 500, 11, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '877772835', 2022, 4, 303.916321752266, 8139.04644899637, 500, 4, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '846495295', 2022, 4, 410.468350134698, 7656.75421473883, 500, 9, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '804775869', 2022, 4, 365.509426581028, 9341.98202159381, 500, 18, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '831030012', 2022, 4, 168.660407422735, 2860.38073481808, 500, 4, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '802809462', 2022, 4, 961.961603515138, 6383.32428706033, 500, 3, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '896200151', 2022, 4, 956.466199361574, 1306.24743142811, 500, 20, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '873610100', 2022, 4, 499.497979704488, 7729.3240583496, 500, 17, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '847931581', 2022, 4, 293.904872722826, 4610.67998044703, 500, 16, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '870810427', 2022, 4, 683.765011629412, 5167.73393994622, 500, 20, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '816457914', 2022, 4, 979.253279967783, 8974.19381574284, 500, 10, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '816760477', 2022, 4, 103.181999652921, 2968.58860597517, 500, 8, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '821449527', 2022, 4, 200.76948745618, 3417.88172543053, 500, 20, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '897412997', 2022, 4, 452.22299743575, 2706.02943495127, 500, 7, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '801856356', 2022, 4, 378.993625306961, 5470.03149579363, 500, 19, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '898170941', 2022, 4, 82.2893719631845, 1462.19921749636, 500, 20, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '884390144', 2022, 4, 920.576183786699, 6161.92335930637, 500, 2, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '894424841', 2022, 4, 488.443467551726, 7354.03396294472, 500, 5, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '828972512', 2022, 4, 208.806194315178, 7848.43475978192, 500, 3, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '815082581', 2022, 4, 151.28727907557, 177.86198722209, 500, 15, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '887159012', 2022, 4, 82.5898163400886, 9310.13659936114, 500, 4, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '829493874', 2022, 4, 139.049300569111, 4216.65985597777, 500, 7, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '814929193', 2022, 4, 714.029475516165, 942.673703195131, 500, 15, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '859907302', 2022, 4, 957.189084499794, 8566.57327523674, 500, 15, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '895124699', 2022, 4, 400.2493797811, 7725.4554018073, 500, 7, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '813239227', 2022, 4, 704.304837579367, 9795.44430638695, 500, 9, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '840430296', 2022, 4, 155.456565187659, 8754.53962930955, 500, 8, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '858726639', 2022, 4, 119.370540574174, 7529.91576748101, 500, 15, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '823234800', 2022, 4, 95.6923667247289, 5018.14929782543, 500, 9, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '874361830', 2022, 4, 392.099424292804, 8152.28760704628, 500, 1, false, '2023-03-03 08:50:21.023688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '808481735', 2022, 4, 420.093481630596, 7361.15612624996, 500, 1, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '860499175', 2022, 4, 674.669312681414, 6588.31428399103, 500, 12, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '892697142', 2022, 4, 377.693184796675, 2501.02832082138, 500, 12, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '826727890', 2022, 4, 538.865627908427, 9929.10539507139, 500, 2, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '895582762', 2022, 4, 42.5542066131277, 8996.59882826428, 500, 19, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '814663914', 2022, 4, 676.753398948395, 6868.82660285869, 500, 12, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '887191975', 2022, 4, 256.099936988723, 3319.43162126053, 500, 4, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '856729012', 2022, 4, 616.641293004425, 3609.81507429397, 500, 8, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '816248533', 2022, 4, 935.823825614855, 7496.45539344498, 500, 1, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '847253663', 2022, 4, 637.864141338007, 8808.18129987839, 500, 12, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '851556995', 2022, 4, 234.27107198135, 6377.06208859708, 500, 11, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '897000352', 2022, 4, 162.795800988293, 1315.63607828199, 500, 11, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '891267708', 2022, 4, 333.620239322057, 7734.73761157494, 500, 19, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '868369009', 2022, 4, 133.529456113304, 2213.00080319964, 500, 13, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '836786224', 2022, 4, 723.208617417129, 346.737262622978, 500, 15, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '800910790', 2022, 4, 231.91677063477, 8604.22034342448, 500, 9, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '847922087', 2022, 4, 583.968872523481, 9041.82351885308, 500, 17, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '882737279', 2022, 4, 77.1465462021204, 537.569486433219, 500, 13, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '817612413', 2022, 4, 988.681765253334, 1978.13540777306, 500, 17, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '857680168', 2022, 4, 176.725742332155, 3121.58633967204, 500, 17, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '878624841', 2022, 4, 563.550952064996, 7873.70290354648, 500, 17, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '867183919', 2022, 4, 551.830106457763, 3347.91393697681, 500, 8, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '824306551', 2022, 4, 104.914908781164, 518.952047846137, 500, 5, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '812929350', 2022, 4, 92.6903907120543, 4277.22216954122, 500, 10, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '890735735', 2022, 4, 972.016187299997, 6961.04024311767, 500, 3, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '894341616', 2022, 4, 537.55393176856, 4295.77873600935, 500, 11, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '845690609', 2022, 4, 76.6361571400835, 2900.78973817099, 500, 11, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '884945724', 2022, 4, 531.985632518876, 7562.35962986133, 500, 14, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '820865124', 2022, 4, 228.042148777006, 6104.58816907214, 500, 4, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '870514368', 2022, 4, 221.424139885823, 2399.47032575358, 500, 11, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '833643869', 2022, 4, 264.532099695565, 5321.29221750514, 500, 5, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '807702188', 2022, 4, 153.051257979311, 6013.27666985391, 500, 18, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '820638689', 2022, 4, 203.095535746658, 466.673801231138, 500, 18, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '843380901', 2022, 4, 84.6254869432446, 3098.0489141394, 500, 3, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '832951634', 2022, 4, 316.79965319699, 24.057835702987, 500, 20, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '833677243', 2022, 4, 418.566966025351, 3225.32860038767, 500, 8, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '873656323', 2022, 4, 350.988485559943, 1618.68440156386, 500, 6, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '859159231', 2022, 4, 815.668860215756, 1654.9319186562, 500, 17, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '868067017', 2022, 4, 412.515081209309, 2819.06675465167, 500, 15, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '856435712', 2022, 4, 923.007694921857, 175.488797801755, 500, 9, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '888937591', 2022, 4, 7.45537086573473, 6691.46778417148, 500, 1, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '873906284', 2022, 4, 835.114394267639, 4567.89537760729, 500, 19, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '855150484', 2022, 4, 372.910942004332, 9031.71149844616, 500, 2, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '836365546', 2022, 4, 850.370926519485, 1006.94455394795, 500, 12, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '822564929', 2022, 4, 12.462755849285, 218.307010459314, 500, 16, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '833204596', 2022, 4, 609.243847657783, 2222.27396137332, 500, 15, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '863592645', 2022, 4, 822.636325062632, 5607.55445262701, 500, 14, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '865956727', 2022, 4, 45.8158442447626, 9600.31670596436, 500, 17, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '807629933', 2022, 4, 591.499906394495, 4198.63738165739, 500, 16, false, '2023-03-03 08:50:21.392208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '832454631', 2022, 4, 904.961166857202, 4524.08043496453, 500, 6, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '823356725', 2022, 4, 924.762337528938, 1121.42557906823, 500, 12, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '800824855', 2022, 4, 796.022379920659, 6110.75927275404, 500, 12, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '894510083', 2022, 4, 607.135753508597, 8520.45442475975, 500, 11, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '815854671', 2022, 4, 379.616543183422, 6623.24481478135, 500, 3, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '876401827', 2022, 4, 907.018984253696, 4179.95236023624, 500, 12, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '845066027', 2022, 4, 811.654899001406, 3266.17198456574, 500, 2, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '815406101', 2022, 4, 149.445947507512, 4980.98376910871, 500, 17, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '866878310', 2022, 4, 799.00449276792, 9388.91292200527, 500, 6, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '830803739', 2022, 4, 858.118000702907, 9301.25297560852, 500, 6, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '805933483', 2022, 4, 278.868343067209, 7772.97724568649, 500, 18, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '868252144', 2022, 4, 896.230999629213, 3166.1589015995, 500, 14, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '828744326', 2022, 4, 398.259608935882, 6411.74116249489, 500, 4, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '830122600', 2022, 4, 570.028754165774, 2300.25752690375, 500, 7, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '813147327', 2022, 4, 15.5956910277908, 7847.31416790452, 500, 20, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '846250295', 2022, 4, 603.998919546323, 5227.17073790026, 500, 1, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '898250721', 2022, 4, 476.519962482336, 7327.35308845335, 500, 9, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '813697349', 2022, 4, 578.116452633107, 8321.40738724246, 500, 13, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '863104800', 2022, 4, 617.285851052834, 4432.47028789226, 500, 19, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '897979593', 2022, 4, 955.361900582497, 378.764846648099, 500, 20, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '860772161', 2022, 4, 252.972908997049, 6222.40935229069, 500, 15, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '808002552', 2022, 4, 567.367789623048, 7022.07268748462, 500, 2, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '876394411', 2022, 4, 490.366520123965, 4988.4421960922, 500, 4, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '846214156', 2022, 4, 59.9122904073103, 2720.28811002813, 500, 4, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '850015354', 2022, 4, 700.510596720224, 2953.5923209331, 500, 1, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '805145991', 2022, 4, 739.094428443944, 3396.86829213527, 500, 19, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '853879838', 2022, 4, 704.676157762395, 317.817423220294, 500, 17, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '882939801', 2022, 4, 100.324662179634, 6658.44791477037, 500, 5, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '859605190', 2022, 4, 886.781189545164, 9811.31883375077, 500, 18, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '891814367', 2022, 4, 634.615215373253, 1151.29874748105, 500, 5, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '875021136', 2022, 4, 193.448206638873, 46.8218941476108, 500, 11, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '825379831', 2022, 4, 446.347637669896, 5106.39119372587, 500, 20, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '800469195', 2022, 4, 306.176157372391, 7284.66981670935, 500, 19, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '871244244', 2022, 4, 553.017482015802, 8988.84328357645, 500, 18, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '837133219', 2022, 4, 109.102348695395, 3771.75557944125, 500, 2, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '855964219', 2022, 4, 431.077219542779, 3949.68259694164, 500, 16, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '838273484', 2022, 4, 108.145458074944, 154.761751494197, 500, 7, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '893483616', 2022, 4, 123.886271273455, 4409.30472055287, 500, 4, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '891497759', 2022, 4, 122.756578776328, 258.419879008574, 500, 17, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '888247901', 2022, 4, 808.352539141962, 7402.47169406033, 500, 11, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '883590490', 2022, 4, 487.842044075862, 2334.7506446795, 500, 16, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '804908767', 2022, 4, 766.788065037723, 4709.34552072373, 500, 15, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '851919134', 2022, 4, 926.645966348496, 9548.10496781958, 500, 9, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '813682750', 2022, 4, 292.233779292337, 7880.77983124544, 500, 2, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '875544956', 2022, 4, 748.268741961705, 919.032384729618, 500, 11, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '889472231', 2022, 4, 238.497923852611, 6540.89300569302, 500, 10, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '875631634', 2022, 4, 502.464929579347, 8342.18194345836, 500, 16, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '856007783', 2022, 4, 95.9331618200553, 4500.46296570656, 500, 3, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '844760467', 2022, 4, 308.188239625003, 7761.83346301753, 500, 1, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '863256691', 2022, 4, 418.810817589845, 1792.16612290296, 500, 18, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '851705582', 2022, 4, 265.666345147446, 1085.99700798898, 500, 2, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '854298834', 2022, 4, 250.81743438404, 4783.59554094665, 500, 18, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '836216435', 2022, 4, 621.298054504867, 847.003227917661, 500, 10, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '893017297', 2022, 4, 548.983180887751, 3115.48264757916, 500, 15, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '841372032', 2022, 4, 263.592402482278, 1347.28915152546, 500, 10, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '862589424', 2022, 4, 189.345971221802, 2905.08097273635, 500, 12, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '871501781', 2022, 4, 62.90574794039, 6471.74521347452, 500, 18, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '880977356', 2022, 4, 26.2141509346799, 6025.9748955388, 500, 3, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '859708655', 2022, 4, 568.318819798248, 4422.44302650593, 500, 16, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '837130075', 2022, 4, 904.77129215818, 1370.80388905587, 500, 1, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '803170681', 2022, 4, 197.781249437583, 5447.96146550264, 500, 4, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '875018446', 2022, 4, 328.506658531178, 4388.001861535, 500, 17, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '872251225', 2022, 4, 792.428727368534, 3569.89633656704, 500, 14, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '889927472', 2022, 4, 986.139083899666, 5462.85394040996, 500, 2, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '850310272', 2022, 4, 977.236082888309, 6964.43702161141, 500, 1, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '878277970', 2022, 4, 690.320671960281, 2615.97110399076, 500, 3, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '811324382', 2022, 4, 196.97520001653, 8462.224000944, 500, 17, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '878265174', 2022, 4, 546.631230306102, 9445.72766609901, 500, 1, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '803799726', 2022, 4, 751.881912447823, 9795.94992460699, 500, 1, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '827344157', 2022, 4, 57.1820696321613, 1716.70778389586, 500, 13, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '868610918', 2022, 4, 505.638830613892, 9517.62801595481, 500, 6, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '891144647', 2022, 4, 762.794137730646, 2094.60304880088, 500, 1, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '874750888', 2022, 4, 682.547643233927, 968.696897514049, 500, 1, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '879572863', 2022, 4, 583.436411289627, 2048.61864338519, 500, 3, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '816719384', 2022, 4, 123.301755631114, 2498.28222956024, 500, 2, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '823372812', 2022, 4, 227.209961304483, 1467.5868558218, 500, 11, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '872671153', 2022, 4, 980.349051677831, 7915.34844902154, 500, 7, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '837782686', 2022, 4, 457.398553812077, 1920.11710431003, 500, 10, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '856373244', 2022, 4, 797.691140195451, 8805.02238950227, 500, 4, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '802319687', 2022, 4, 197.54227054433, 1524.83047753955, 500, 13, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '882221112', 2022, 4, 478.151970085141, 8847.68945130669, 500, 8, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '825823538', 2022, 4, 573.184202515539, 3340.71736006267, 500, 7, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '840744367', 2022, 4, 197.124928239842, 85.5794292425938, 500, 19, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '807485242', 2022, 4, 637.574348432864, 7412.28561218769, 500, 19, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '878321914', 2022, 4, 909.924335807304, 2608.52672926063, 500, 11, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '886892017', 2022, 4, 569.775618135173, 2555.31827866341, 500, 20, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '871623349', 2022, 4, 177.258892294966, 5708.23992867021, 500, 8, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '864986459', 2022, 4, 127.324866681683, 9809.20286096184, 500, 1, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '849227492', 2022, 4, 633.927466521094, 1417.06993496649, 500, 19, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '850910144', 2022, 4, 615.744633580422, 4540.97718529019, 500, 19, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '869658223', 2022, 4, 770.202971396235, 5978.9406393828, 500, 3, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '866431270', 2022, 4, 404.048389352332, 2192.00321165572, 500, 14, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '858356342', 2022, 4, 314.100449281322, 2168.66622947202, 500, 14, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '852467356', 2022, 4, 629.131630673115, 4650.50119134978, 500, 2, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '898657961', 2022, 4, 904.205880062635, 4718.42170217151, 500, 18, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '846849579', 2022, 4, 453.733264601448, 2747.06570379405, 500, 20, false, '2023-03-03 08:50:21.626595', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '873579899', 2022, 4, 548.770555459392, 9054.30751052167, 500, 13, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '843035298', 2022, 4, 227.854969630975, 3940.77387681933, 500, 12, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '858836952', 2022, 4, 884.452321885328, 121.874723854967, 500, 16, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '805709917', 2022, 4, 65.1344100314345, 1952.70811892944, 500, 6, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '808479485', 2022, 4, 65.1188525093915, 2392.78728233444, 500, 10, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '838878962', 2022, 4, 840.770411746352, 59.1081489917885, 500, 20, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '885625328', 2022, 4, 391.453579405384, 6560.87649916145, 500, 16, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '837527996', 2022, 4, 343.833197954388, 553.101679089846, 500, 9, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '844848494', 2022, 4, 530.590206932427, 3888.34907564867, 500, 12, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '825573136', 2022, 4, 934.014270102152, 6792.05435938477, 500, 8, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '809036318', 2022, 4, 183.638043222036, 1395.56109851109, 500, 20, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '800223332', 2022, 4, 415.709877857463, 8470.38831409283, 500, 15, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '878112453', 2022, 4, 194.144202277973, 1684.93938720661, 500, 10, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '893781546', 2022, 4, 617.106999293265, 1464.16649711201, 500, 12, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '818658010', 2022, 4, 317.535989440225, 2898.45908185938, 500, 14, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '862270603', 2022, 4, 869.62392370889, 8945.59148284873, 500, 17, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '812325897', 2022, 4, 45.0790454779503, 5190.76762065272, 500, 4, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '817554736', 2022, 4, 528.902478012295, 6112.00697647722, 500, 4, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '884291457', 2022, 4, 962.407391459149, 5813.12243195003, 500, 1, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '890910485', 2022, 4, 572.529565579406, 1533.13707511393, 500, 9, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '810677960', 2022, 4, 246.166981328678, 9515.04714791961, 500, 18, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '830621787', 2022, 4, 191.040830067943, 3492.00880095226, 500, 17, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '874792210', 2022, 4, 447.98985048759, 8286.89898806375, 500, 19, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '828718942', 2022, 4, 950.741877382347, 8125.76087558426, 500, 4, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '846277869', 2022, 4, 441.824429329906, 3569.49698227479, 500, 10, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '809316543', 2022, 4, 83.4236757313691, 8200.88119543816, 500, 18, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '846821438', 2022, 4, 17.1365447634456, 7007.88805598044, 500, 12, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '836005340', 2022, 4, 434.613929389058, 6146.29424326633, 500, 19, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '869069081', 2022, 4, 797.539613908282, 1585.81315878526, 500, 18, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '824870495', 2022, 4, 511.426878514794, 2318.69251745488, 500, 5, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '821850314', 2022, 4, 862.890199477915, 6448.27888314133, 500, 13, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '895629317', 2022, 4, 804.631024953606, 8228.10680694783, 500, 11, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '854843256', 2022, 4, 677.436539060886, 2734.67711041079, 500, 15, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '825397589', 2022, 4, 309.134106008925, 7150.65195582787, 500, 10, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '856901774', 2022, 4, 152.748642785735, 358.976747742543, 500, 6, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '886566656', 2022, 4, 264.819743493538, 5071.03580058981, 500, 1, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '868634250', 2022, 4, 475.646172279003, 5250.82696103182, 500, 11, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '827178297', 2022, 4, 462.102295154359, 1084.15857801493, 500, 18, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '889901026', 2022, 4, 109.572086390507, 9943.02312176458, 500, 4, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '860932226', 2022, 4, 36.7319391522324, 269.032294887285, 500, 17, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '883640440', 2022, 4, 675.606501911712, 8008.26735249758, 500, 2, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '899511765', 2022, 4, 717.947140419174, 2461.73032577128, 500, 19, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '826671551', 2022, 4, 865.875107694818, 4307.93070512927, 500, 6, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '838991015', 2022, 4, 426.841948825872, 638.328173913434, 500, 11, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '831768843', 2022, 4, 77.4986883001597, 6011.31717753425, 500, 7, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '803324193', 2022, 4, 611.870040624048, 4593.39386940783, 500, 13, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '827269180', 2022, 4, 240.382735402148, 546.901335862576, 500, 10, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '806938796', 2022, 4, 316.253868505403, 7554.81329742132, 500, 14, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '817130185', 2022, 4, 730.203676889491, 8483.04773490922, 500, 13, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '810402680', 2022, 4, 496.084635085882, 9730.71742773418, 500, 3, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '887841956', 2022, 4, 665.156071933198, 1710.94351361089, 500, 16, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '897336611', 2022, 4, 807.887912000952, 5779.02726637414, 500, 9, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '858728795', 2022, 4, 122.465607400847, 9395.05995311792, 500, 1, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '880050743', 2022, 4, 550.122632806995, 73.7752391634031, 500, 11, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '871161662', 2022, 4, 48.7010070629548, 3900.74404025413, 500, 11, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '862924848', 2022, 4, 225.190673609194, 9758.42324930837, 500, 2, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '895031114', 2022, 4, 267.671306720357, 1817.77550389492, 500, 19, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '815517829', 2022, 4, 101.433766959084, 8082.98522646392, 500, 12, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '836666246', 2022, 4, 993.093445781232, 8732.2045357548, 500, 13, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '845715533', 2022, 4, 364.977944316793, 8861.82250896267, 500, 20, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '897156462', 2022, 4, 533.85877966966, 3633.76345038743, 500, 15, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '890815244', 2022, 4, 590.226531384383, 7513.77202334268, 500, 2, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '866562589', 2022, 4, 222.10597148034, 3392.91952248419, 500, 16, false, '2023-03-03 08:50:22.034801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '875322390', 2022, 4, 237.623265360897, 6413.85289954298, 500, 8, false, '2023-03-03 08:50:22.245694', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '870376312', 2022, 4, 666.992182591228, 9067.22942011163, 500, 13, false, '2023-03-03 08:50:22.245694', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '863074238', 2022, 4, 35.4188366543816, 5943.4219937942, 500, 19, false, '2023-03-03 08:50:22.245694', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '873535604', 2022, 4, 444.291453341787, 1405.41904409945, 500, 17, false, '2023-03-03 08:50:22.245694', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '820029647', 2022, 4, 483.643558633146, 8374.10155871766, 500, 4, false, '2023-03-03 08:50:22.245694', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '825514130', 2022, 4, 530.767587196563, 6421.47294044048, 500, 5, false, '2023-03-03 08:50:22.245694', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '815801592', 2022, 4, 473.546270004152, 5148.89001018046, 500, 20, false, '2023-03-03 08:50:22.245694', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '839528084', 2022, 4, 535.71459316766, 8722.69808956362, 500, 5, false, '2023-03-03 08:50:22.245694', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '864571830', 2022, 4, 277.044001065988, 3642.98035607517, 500, 9, false, '2023-03-03 08:50:22.245694', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '883989256', 2022, 4, 162.044325895059, 42.2992044874267, 500, 16, false, '2023-03-03 08:50:25.103554', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '831272011', 2022, 4, 579.521191583292, 4278.47945989601, 500, 6, false, '2023-03-03 08:50:25.127951', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '831658088', 2022, 4, 977.106950124563, 581.871249070003, 500, 16, false, '2023-03-03 08:50:25.158925', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '802008121', 2022, 4, 469.259738423852, 2861.0714906437, 500, 11, false, '2023-03-03 08:50:25.158925', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '857721878', 2022, 4, 518.041585953404, 1663.08821270368, 500, 4, false, '2023-03-03 08:50:25.158925', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '811747377', 2022, 4, 68.3156997261759, 1395.21014807008, 500, 10, false, '2023-03-03 08:50:25.158925', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '801396893', 2022, 4, 833.490439957656, 2677.35566610335, 500, 10, false, '2023-03-03 08:50:25.158925', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '885133950', 2022, 4, 655.716373711265, 7765.72854980891, 500, 17, false, '2023-03-03 08:50:25.211673', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '864761302', 2022, 4, 331.406763526159, 1874.33397527253, 500, 1, false, '2023-03-03 08:50:25.211673', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '870050263', 2022, 4, 546.194097133704, 5447.70483187223, 500, 8, false, '2023-03-03 08:50:25.25263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '881536611', 2022, 4, 238.697930204872, 2545.51484375631, 500, 18, false, '2023-03-03 08:50:25.25263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '862811969', 2022, 4, 632.154983209144, 3075.14525038457, 500, 14, false, '2023-03-03 08:50:25.25263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '892708443', 2022, 4, 248.282046102249, 9382.72859834264, 500, 9, false, '2023-03-03 08:50:25.25263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '866931781', 2022, 4, 898.447072692973, 447.182163917855, 500, 13, false, '2023-03-03 08:50:25.25263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '868378133', 2022, 4, 889.67887617969, 6304.35290158075, 500, 11, false, '2023-03-03 08:50:25.25263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '872308278', 2022, 4, 656.458351500702, 8205.55379912566, 500, 17, false, '2023-03-03 08:50:25.25263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '854032309', 2022, 4, 200.639509845128, 3613.06447056511, 500, 19, false, '2023-03-03 08:50:25.25263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '842782667', 2022, 4, 90.2780075498439, 9490.68236356214, 500, 2, false, '2023-03-03 08:50:25.25263', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 6527.42078888379, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.37706');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 5797.94180363533, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.37706');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '555555555', 9846.1714180263, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.406072');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '881532376', 4803.5127183432, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.406072');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '883874352', 8398.56166480652, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.406072');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '848147638', 2301.92528361622, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.406072');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '876763949', 8348.06356964635, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.429729');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '871871807', 2862.39102860482, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.429729');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '864079801', 2995.43961092674, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.429729');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '836041617', 9841.9392042829, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.429729');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '857842260', 7296.22754945459, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.457208');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '885073621', 1274.44430782553, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.457208');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '864754605', 6751.84615612893, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.457208');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '846347581', 5606.86050953852, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.476066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '824680794', 6951.74858116382, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.476066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '839415001', 3187.75565628421, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.476066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '861744528', 1979.80365487258, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.493446');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '860138909', 3896.85746034128, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.493446');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '843242104', 6372.15946872143, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.493446');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '890093850', 7420.61634528547, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.512921');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '892511017', 7235.56865770029, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.512921');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '842605109', 5523.71374708133, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.512921');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '870491047', 5188.66178515282, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.512921');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '863507760', 6751.67412100458, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.536263');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '817257908', 9052.15149215536, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.536263');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '809042383', 5439.62161347536, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.55359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '810734693', 6804.28996148263, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.55359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '804629062', 8173.24677492691, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.55359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '873621335', 47.1824866458551, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.55359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '835058832', 4436.4807780598, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.573437');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '803826652', 1236.33901075482, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.573437');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '874394467', 9916.08659752659, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.573437');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '838903289', 4254.09993637271, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.595493');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '882051647', 4697.07124995256, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.595493');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '879681201', 2226.54889261374, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.595493');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '852409131', 9971.9085253873, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.595493');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '808215075', 5363.33326634375, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.627797');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '865074415', 9520.63694286516, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.627797');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '836669149', 1097.89467919733, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.627797');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '884369776', 7514.42622996764, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.627797');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '873418367', 4211.59919776987, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.648881');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '802905016', 6812.13648826617, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.648881');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '885609899', 6766.26628283094, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.648881');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '860836918', 2128.81169072066, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.648881');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '829745509', 4280.13754950072, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.669723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '844246611', 6698.17298668778, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.669723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '867216743', 8986.18193454514, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.669723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '890941228', 8851.17710886627, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.669723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '838540049', 7175.41753130711, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.669723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '809501750', 2851.63367819294, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.669723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '844496478', 8437.76366514435, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.690053');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '863501025', 4062.09609395583, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.690053');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '839166324', 4165.59901778674, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.707632');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '879962157', 2523.38556513241, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.707632');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '848543645', 7097.46249726053, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.707632');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '880279851', 2745.38834804767, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.707632');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '808671188', 3294.20787875431, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.707632');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '851333885', 5483.8364382197, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.72415');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '815366017', 9166.38780237386, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.72415');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '891113900', 3038.49113686242, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.72415');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '894926128', 4635.3913919443, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.738809');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '802290404', 7043.80734327336, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.738809');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '896239097', 6135.51729118692, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.738809');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '816868949', 4580.57378935933, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.756827');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '895298219', 329.870288184419, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.756827');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '842893897', 2720.4766178312, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.756827');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '814670938', 496.123865416499, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.756827');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '820433803', 7204.88421392289, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.772533');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '874104569', 2720.49992896507, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.772533');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '856520283', 1365.61267506264, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.772533');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '879090305', 5391.77466063158, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.787589');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '809468321', 4926.55061583138, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.787589');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '826378947', 4129.86965160225, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.787589');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '866390365', 8932.66460870947, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.787589');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '862771013', 1852.61854362739, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.799106');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '864363318', 9454.26589862818, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.799106');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '896438075', 5890.08934096878, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.822432');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '829368106', 9139.93087626817, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.822432');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '867407313', 2986.21537296626, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.822432');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '896587504', 622.475739650332, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.822432');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '847845944', 6784.22574407787, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.836612');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '826389298', 301.310843015958, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.836612');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '848399886', 9614.42938306625, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.836612');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '854846835', 8439.68977195388, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.836612');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '800634899', 246.320753635999, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.836612');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '857110616', 561.161922287384, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.855876');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '808271586', 4181.98741251898, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.855876');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '819801010', 6594.69832283687, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.855876');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '848578637', 868.473690490926, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.870825');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '827490752', 5747.48234402115, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.870825');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '835736810', 9219.27296811, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.870825');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '857544475', 7218.5248669787, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.870825');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '847721823', 6352.31916067167, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.891022');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '862581603', 7722.14425077178, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.891022');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '810313500', 4359.54502815066, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.891022');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '885129733', 2075.40843495649, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.891022');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '898243796', 9262.00181206999, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.908042');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '887079787', 7244.28241791375, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.908042');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '861058672', 2385.83026341173, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.908042');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '876537913', 4477.52520584333, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.908042');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '890597928', 3431.52278699073, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.908042');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '842982051', 5655.61713154097, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.927974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '842389667', 316.264552677525, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.927974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '820004072', 828.4997322786, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.927974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '897688257', 5548.53863615577, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.943337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '837534390', 2733.00181598242, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.943337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '808543637', 4986.11429750684, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.943337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '870201888', 1614.61832623051, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.943337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '817311070', 7477.34367030273, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.943337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '868012776', 6732.71900891067, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.962668');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '896429753', 7075.87728904588, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.962668');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '851603425', 2157.35054037854, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.962668');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '827443317', 3835.54564357088, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.962668');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '833362642', 6207.53287309159, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.97877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '882069408', 5388.17586595234, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.97877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '863878944', 8699.16863809146, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.97877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '866558221', 1520.29358016745, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.97877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '868767855', 1806.98001799295, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.97877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '875885300', 5172.25060866812, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.996041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '842216735', 3591.16505868156, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:22.996041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '856920437', 5902.68513009272, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.008854');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '830858963', 8269.42201071565, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.008854');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '812434114', 8547.77322973324, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.008854');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '847041353', 111.100276626581, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.008854');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '803269327', 6673.88348170606, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.008854');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '843457384', 5355.05975631696, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.023217');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '818306281', 639.560801851168, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.023217');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '844449510', 8287.84569913789, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.023217');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '867177223', 9836.80068854197, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.035019');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '883963814', 2014.33374338738, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.035019');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '886253015', 4591.46476481886, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.048274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '895281822', 1762.05242254078, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.048274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '840533481', 9368.34948654156, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.059387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '839216776', 5917.5285898869, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.059387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '803533948', 8953.18050637431, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.059387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '827095124', 821.796126777901, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.071948');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '808251981', 6544.11480897056, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.071948');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '817358823', 4925.41904099124, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.071948');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '871910327', 6049.2641131855, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.071948');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '866587133', 3320.94347350303, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.091567');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '842840788', 8716.45366964219, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.105337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '812781923', 9517.61405375399, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.105337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '804058381', 1221.54276761349, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.105337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '811423248', 6262.81938055144, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.105337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '840837641', 7746.91199861303, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.105337');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '818816392', 85.3819616742144, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.139313');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '806494928', 7340.84395500273, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.139313');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '893055618', 5237.22280514874, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.139313');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '875340822', 976.573441960283, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.139313');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '818463756', 9273.91186929769, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.15694');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '884152302', 2049.91272641433, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.15694');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '849742742', 8362.00911908246, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.15694');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '804979817', 9916.09243849805, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.15694');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '814190896', 822.065258736564, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.171254');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '822331640', 4883.77176577518, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.171254');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '862678317', 6481.71981271863, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.171254');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '831093023', 1783.56545325839, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.171254');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '874226454', 8196.45412273757, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.192118');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '832436811', 2624.26676517001, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.192118');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '838432048', 6954.00405847134, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.192118');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '870022919', 936.451910203078, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.192118');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '879268334', 4851.12967369989, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.209836');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '806599852', 2795.94668265785, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.209836');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '863181199', 9805.10031453977, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.209836');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '863767568', 6145.25245384715, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.209836');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '844014636', 3613.83797987179, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.226252');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '866404710', 763.472972200633, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.226252');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '833129946', 780.262035817131, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.226252');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '846977998', 6751.43585744928, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.226252');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '811030348', 8459.38641318621, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.244446');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '890815907', 8196.50079583007, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.244446');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '822694021', 2822.16714313597, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.244446');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '852558904', 2962.64452721413, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.244446');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '822874914', 3967.89455929854, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.259923');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '866646453', 5881.69965747782, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.259923');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '881021956', 6354.80257516871, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.259923');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '899291735', 2463.10692117221, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.259923');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '867918928', 568.775747442361, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.27218');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '823439458', 372.463756999449, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.27218');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '837805347', 9905.51745155715, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.27218');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '805499088', 360.186280764673, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.27218');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '845822610', 8947.0149310808, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.286287');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '841405633', 78.7289219504391, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.286287');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '889675608', 5943.14347824568, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.286287');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '899025387', 7934.1623189023, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.300294');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '863280835', 3499.37000094142, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.300294');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '860629673', 3023.7654973894, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.300294');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '833667497', 7284.54103219964, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.311055');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '842471044', 3126.84104267056, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.311055');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '861459803', 242.451847397747, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.311055');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '812926032', 6678.31903612873, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.311055');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '871631319', 4894.55552702594, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.322408');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '865439281', 4545.3492205658, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.322408');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '824210548', 3846.12511960344, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.33833');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '805486005', 7773.08085930489, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.33833');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '832448472', 6041.26724558488, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.33833');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '805820685', 5153.49475005463, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.357038');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '883768894', 2632.32413733667, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.357038');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '856903021', 1226.82147768309, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.357038');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '850012745', 4975.60829712847, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.357038');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '820149848', 3250.26191140804, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.370278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '822705108', 506.04355784533, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.370278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '857573851', 236.106967570407, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.370278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '856078198', 9921.98017971798, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.370278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '859225721', 6035.1931094995, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.381994');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '873879874', 5203.92857808176, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.381994');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '890065285', 5961.53194920542, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.381994');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '893423280', 6064.61899183122, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.395141');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '816273126', 1146.21637950856, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.395141');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '874977909', 5612.9888887503, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.406592');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '888632161', 8408.60287982626, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.406592');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '852452427', 8843.50125911212, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.406592');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '807389236', 8413.83174881011, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.422067');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '833163111', 5723.97273485918, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.422067');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '813080832', 9410.56608676885, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.422067');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '896489260', 4710.38606843423, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.447677');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '845881839', 3853.55322374451, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.447677');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '898157169', 3173.96928129701, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.447677');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '882940656', 1162.78938200969, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.447677');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '887589106', 6043.18897066429, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.447677');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '856439808', 2603.86980271367, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.462325');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '869911712', 4680.40735804296, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.462325');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '836420677', 5573.33143056682, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.462325');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '810521018', 8341.80024777735, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.462325');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '863021621', 3736.44565655602, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.462325');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '846289494', 6233.43253784794, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.462325');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '834191416', 5521.55428584625, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.462325');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '837420340', 4399.18241394836, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.484608');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '871949311', 2730.35605230767, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.49752');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '821633142', 9191.29343069245, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.49752');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '893463166', 9662.55707464275, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.49752');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '833218825', 9429.40764485444, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.49752');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '807456455', 1948.30987870714, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.49752');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '821381486', 8763.53820248297, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.516031');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '814324199', 8452.93610825574, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.516031');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '805904949', 8289.8537828658, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.516031');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '813242515', 3757.16988228098, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.537942');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '839415843', 9150.07568714459, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.537942');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '804234371', 8113.82155653349, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.537942');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '816585946', 9296.50536183486, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.537942');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '824097835', 457.110704237551, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.558179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '880538674', 9479.14056671883, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.558179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '875775705', 4392.94606979619, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.558179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '877421692', 2310.27590010755, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.558179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '871547736', 7415.74205001017, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.581842');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '857653378', 2417.37722383403, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.581842');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '829980700', 595.496801688239, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.581842');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '852627790', 389.909382737813, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.581842');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '865978526', 7306.65861717765, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.597182');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '840145629', 2615.87160547758, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.597182');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '875016141', 9210.86246611267, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.597182');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '869419134', 8137.61734341648, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.597182');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '813944600', 714.537265383734, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.610177');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '885600454', 6476.93133668657, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.610177');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '877550656', 7023.27561400932, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.626302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '804227830', 1414.51003329645, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.626302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '858956619', 5684.80143206448, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.626302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '865153645', 4678.13692876396, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.640171');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '817941723', 4330.8938738129, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.640171');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '811667993', 7981.48696451387, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.640171');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '859462534', 5932.19542236881, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.656745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '822317092', 323.849916892416, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.656745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '877772835', 8139.04644899637, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.656745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '846495295', 7656.75421473883, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.66777');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '804775869', 9341.98202159381, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.66777');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '831030012', 2860.38073481808, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.66777');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '802809462', 6383.32428706033, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.66777');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '896200151', 1306.24743142811, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.683239');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '873610100', 7729.3240583496, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.683239');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '847931581', 4610.67998044703, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.683239');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '870810427', 5167.73393994622, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.699169');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '816457914', 8974.19381574284, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.699169');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '816760477', 2968.58860597517, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.699169');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '821449527', 3417.88172543053, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.713793');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '897412997', 2706.02943495127, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.713793');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '801856356', 5470.03149579363, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.713793');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '898170941', 1462.19921749636, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.713793');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '884390144', 6161.92335930637, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.725796');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '894424841', 7354.03396294472, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.725796');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '828972512', 7848.43475978192, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.725796');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '815082581', 177.86198722209, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.743348');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '887159012', 9310.13659936114, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.761164');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '829493874', 4216.65985597777, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.761164');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '814929193', 942.673703195131, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.761164');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '859907302', 8566.57327523674, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.782156');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '895124699', 7725.4554018073, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.782156');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '813239227', 9795.44430638695, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.782156');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '840430296', 8754.53962930955, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.798044');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '858726639', 7529.91576748101, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.798044');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '823234800', 5018.14929782543, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.798044');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '874361830', 8152.28760704628, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.798044');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '808481735', 7361.15612624996, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.815199');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '860499175', 6588.31428399103, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.815199');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '892697142', 2501.02832082138, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.827632');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '826727890', 9929.10539507139, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.827632');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '895582762', 8996.59882826428, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.827632');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '814663914', 6868.82660285869, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.827632');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '887191975', 3319.43162126053, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.846513');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '856729012', 3609.81507429397, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.846513');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '816248533', 7496.45539344498, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.846513');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '847253663', 8808.18129987839, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.861015');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '851556995', 6377.06208859708, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.861015');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '897000352', 1315.63607828199, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.861015');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '891267708', 7734.73761157494, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.861015');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '868369009', 2213.00080319964, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.861015');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '836786224', 346.737262622978, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.875758');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '800910790', 8604.22034342448, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.875758');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '847922087', 9041.82351885308, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.875758');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '882737279', 537.569486433219, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.899448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '817612413', 1978.13540777306, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.899448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '857680168', 3121.58633967204, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.899448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '878624841', 7873.70290354648, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.899448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '867183919', 3347.91393697681, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.915297');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '824306551', 518.952047846137, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.915297');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '812929350', 4277.22216954122, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.915297');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '890735735', 6961.04024311767, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.915297');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '894341616', 4295.77873600935, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.915297');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '845690609', 2900.78973817099, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.934026');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '884945724', 7562.35962986133, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.934026');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '820865124', 6104.58816907214, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.94915');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '870514368', 2399.47032575358, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.94915');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '833643869', 5321.29221750514, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.94915');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '807702188', 6013.27666985391, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.94915');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '820638689', 466.673801231138, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.967473');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '843380901', 3098.0489141394, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.967473');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '832951634', 24.057835702987, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.985404');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '833677243', 3225.32860038767, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.985404');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '873656323', 1618.68440156386, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:23.985404');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '859159231', 1654.9319186562, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.007227');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '868067017', 2819.06675465167, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.007227');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '856435712', 175.488797801755, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.007227');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '888937591', 6691.46778417148, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.020445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '873906284', 4567.89537760729, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.020445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '855150484', 9031.71149844616, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.020445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '836365546', 1006.94455394795, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.033916');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '822564929', 218.307010459314, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.033916');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '833204596', 2222.27396137332, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.033916');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '863592645', 5607.55445262701, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.049356');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '865956727', 9600.31670596436, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.049356');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '807629933', 4198.63738165739, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.049356');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '832454631', 4524.08043496453, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.067164');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '823356725', 1121.42557906823, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.067164');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '800824855', 6110.75927275404, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.067164');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '894510083', 8520.45442475975, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.067164');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '815854671', 6623.24481478135, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.067164');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '876401827', 4179.95236023624, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.080624');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '845066027', 3266.17198456574, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.080624');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '815406101', 4980.98376910871, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.080624');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '866878310', 9388.91292200527, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.080624');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '830803739', 9301.25297560852, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.098902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '805933483', 7772.97724568649, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.098902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '868252144', 3166.1589015995, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.098902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '828744326', 6411.74116249489, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.114194');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '830122600', 2300.25752690375, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.114194');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '813147327', 7847.31416790452, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.114194');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '846250295', 5227.17073790026, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.130058');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '898250721', 7327.35308845335, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.130058');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '813697349', 8321.40738724246, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.130058');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '863104800', 4432.47028789226, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.144517');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '897979593', 378.764846648099, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.144517');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '860772161', 6222.40935229069, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.144517');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '808002552', 7022.07268748462, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.157177');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '876394411', 4988.4421960922, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.157177');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '846214156', 2720.28811002813, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.178056');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '850015354', 2953.5923209331, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.178056');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '805145991', 3396.86829213527, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.178056');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '853879838', 317.817423220294, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.193241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '882939801', 6658.44791477037, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.193241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '859605190', 9811.31883375077, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.193241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '891814367', 1151.29874748105, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.193241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '875021136', 46.8218941476108, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.193241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '825379831', 5106.39119372587, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.208908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '800469195', 7284.66981670935, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.208908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '871244244', 8988.84328357645, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.224826');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '837133219', 3771.75557944125, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.224826');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '855964219', 3949.68259694164, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.224826');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '838273484', 154.761751494197, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.24152');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '893483616', 4409.30472055287, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.24152');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '891497759', 258.419879008574, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.256973');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '888247901', 7402.47169406033, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.256973');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '883590490', 2334.7506446795, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.271036');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '804908767', 4709.34552072373, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.271036');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '851919134', 9548.10496781958, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.271036');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '813682750', 7880.77983124544, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.285822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '875544956', 919.032384729618, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.285822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '889472231', 6540.89300569302, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.299936');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '875631634', 8342.18194345836, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.299936');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '856007783', 4500.46296570656, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.299936');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '844760467', 7761.83346301753, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.315315');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '863256691', 1792.16612290296, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.315315');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '851705582', 1085.99700798898, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.315315');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '854298834', 4783.59554094665, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.315315');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '836216435', 847.003227917661, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.328844');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '893017297', 3115.48264757916, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.328844');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '841372032', 1347.28915152546, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.346819');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '862589424', 2905.08097273635, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.346819');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '871501781', 6471.74521347452, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.346819');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '880977356', 6025.9748955388, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.371764');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '859708655', 4422.44302650593, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.371764');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '837130075', 1370.80388905587, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.371764');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '803170681', 5447.96146550264, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.389665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '875018446', 4388.001861535, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.389665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '872251225', 3569.89633656704, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.389665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '889927472', 5462.85394040996, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.389665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '850310272', 6964.43702161141, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.389665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '878277970', 2615.97110399076, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.389665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '811324382', 8462.224000944, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.410704');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '878265174', 9445.72766609901, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.410704');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '803799726', 9795.94992460699, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.426572');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '827344157', 1716.70778389586, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.426572');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '868610918', 9517.62801595481, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.426572');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '891144647', 2094.60304880088, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.426572');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '874750888', 968.696897514049, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.44182');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '879572863', 2048.61864338519, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.44182');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '816719384', 2498.28222956024, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.44182');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '823372812', 1467.5868558218, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.457766');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '872671153', 7915.34844902154, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.457766');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '837782686', 1920.11710431003, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.470977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '856373244', 8805.02238950227, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.470977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '802319687', 1524.83047753955, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.470977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '882221112', 8847.68945130669, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.485881');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '825823538', 3340.71736006267, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.485881');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '840744367', 85.5794292425938, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.498216');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '807485242', 7412.28561218769, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.498216');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '878321914', 2608.52672926063, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.498216');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '886892017', 2555.31827866341, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.516071');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '871623349', 5708.23992867021, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.530656');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '864986459', 9809.20286096184, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.530656');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '849227492', 1417.06993496649, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.530656');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '850910144', 4540.97718529019, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.530656');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '869658223', 5978.9406393828, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.545618');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '866431270', 2192.00321165572, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.545618');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '858356342', 2168.66622947202, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.545618');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '852467356', 4650.50119134978, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.557679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '898657961', 4718.42170217151, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.557679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '846849579', 2747.06570379405, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.557679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '873579899', 9054.30751052167, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.572344');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '843035298', 3940.77387681933, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.583575');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '858836952', 121.874723854967, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.583575');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '805709917', 1952.70811892944, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.583575');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '808479485', 2392.78728233444, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.60067');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '838878962', 59.1081489917885, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.60067');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '885625328', 6560.87649916145, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.60067');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '837527996', 553.101679089846, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.615394');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '844848494', 3888.34907564867, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.615394');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '825573136', 6792.05435938477, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.615394');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '809036318', 1395.56109851109, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.630656');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '800223332', 8470.38831409283, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.630656');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '878112453', 1684.93938720661, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.642569');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '893781546', 1464.16649711201, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.642569');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '818658010', 2898.45908185938, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.642569');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '862270603', 8945.59148284873, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.655606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '812325897', 5190.76762065272, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.655606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '817554736', 6112.00697647722, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.67395');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '884291457', 5813.12243195003, 500, 8, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.67395');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '890910485', 1533.13707511393, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.688123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '810677960', 9515.04714791961, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.688123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '830621787', 3492.00880095226, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.701471');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '874792210', 8286.89898806375, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.701471');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '828718942', 8125.76087558426, 500, 4, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.701471');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '846277869', 3569.49698227479, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.714842');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '809316543', 8200.88119543816, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.714842');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '846821438', 7007.88805598044, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.714842');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '836005340', 6146.29424326633, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.714842');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '869069081', 1585.81315878526, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.725315');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '824870495', 2318.69251745488, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.725315');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '821850314', 6448.27888314133, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.725315');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '895629317', 8228.10680694783, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.725315');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '854843256', 2734.67711041079, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.725315');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '825397589', 7150.65195582787, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.741481');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '856901774', 358.976747742543, 500, 1, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.741481');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '886566656', 5071.03580058981, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.75332');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '868634250', 5250.82696103182, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.75332');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '827178297', 1084.15857801493, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.75332');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '889901026', 9943.02312176458, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.766046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '860932226', 269.032294887285, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.766046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '883640440', 8008.26735249758, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.786436');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '899511765', 2461.73032577128, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.786436');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '826671551', 4307.93070512927, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.786436');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '838991015', 638.328173913434, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.797619');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '831768843', 6011.31717753425, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.797619');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '803324193', 4593.39386940783, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.797619');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '827269180', 546.901335862576, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.809152');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '806938796', 7554.81329742132, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.809152');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '817130185', 8483.04773490922, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.809152');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '810402680', 9730.71742773418, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.809152');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '887841956', 1710.94351361089, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.809152');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '897336611', 5779.02726637414, 500, 13, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.809152');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '858728795', 9395.05995311792, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.824591');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '880050743', 73.7752391634031, 500, 10, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.824591');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '871161662', 3900.74404025413, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.836981');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '862924848', 9758.42324930837, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.836981');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '895031114', 1817.77550389492, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.836981');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '815517829', 8082.98522646392, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.836981');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '836666246', 8732.2045357548, 500, 20, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.836981');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '845715533', 8861.82250896267, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.836981');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '897156462', 3633.76345038743, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.851333');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '890815244', 7513.77202334268, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.851333');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '866562589', 3392.91952248419, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.851333');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '875322390', 6413.85289954298, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.869651');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '870376312', 9067.22942011163, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.869651');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '863074238', 5943.4219937942, 500, 2, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.869651');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '873535604', 1405.41904409945, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.869651');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '820029647', 8374.10155871766, 500, 9, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.888721');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '825514130', 6421.47294044048, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.888721');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '815801592', 5148.89001018046, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.888721');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '839528084', 8722.69808956362, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.904014');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '864571830', 3642.98035607517, 500, 12, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:24.904014');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '883989256', 42.2992044874267, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.327345');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '831272011', 4278.47945989601, 500, 14, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.347136');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '831658088', 581.871249070003, 500, 18, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.355897');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '802008121', 2861.0714906437, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.355897');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '857721878', 1663.08821270368, 500, 19, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.355897');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '811747377', 1395.21014807008, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.355897');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '801396893', 2677.35566610335, 500, 11, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.370118');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '885133950', 7765.72854980891, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.382754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '864761302', 1874.33397527253, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.382754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '870050263', 5447.70483187223, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.382754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '881536611', 2545.51484375631, 500, 15, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.399604');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '862811969', 3075.14525038457, 500, 3, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.399604');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '892708443', 9382.72859834264, 500, 6, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.399604');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '866931781', 447.182163917855, 500, 5, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.399604');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '868378133', 6304.35290158075, 500, 17, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.415811');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '872308278', 8205.55379912566, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.415811');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '854032309', 3613.06447056511, 500, 16, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.429723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '842782667', 9490.68236356214, 500, 7, false, 2, '[{"kvartal": 4, "årstall": 2022}, {"kvartal": 3, "årstall": 2022}]', '2023-03-03 08:50:25.429723');


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.601175', '2023-03-03 08:50:16.601175');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.610539', '2023-03-03 08:50:16.610539');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.616889', '2023-03-03 08:50:16.616889');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.623739', '2023-03-03 08:50:16.623739');
INSERT INTO public.virksomhet VALUES (5, '800061965', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800061965', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.631599', '2023-03-03 08:50:16.631599');
INSERT INTO public.virksomhet VALUES (6, '881532376', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881532376', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.638', '2023-03-03 08:50:16.638');
INSERT INTO public.virksomhet VALUES (7, '883874352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883874352', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.643693', '2023-03-03 08:50:16.643693');
INSERT INTO public.virksomhet VALUES (8, '848147638', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848147638', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.650105', '2023-03-03 08:50:16.650105');
INSERT INTO public.virksomhet VALUES (9, '876763949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876763949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.657873', '2023-03-03 08:50:16.657873');
INSERT INTO public.virksomhet VALUES (10, '871871807', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871871807', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.66342', '2023-03-03 08:50:16.66342');
INSERT INTO public.virksomhet VALUES (11, '864079801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864079801', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.669569', '2023-03-03 08:50:16.669569');
INSERT INTO public.virksomhet VALUES (12, '836041617', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836041617', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.675676', '2023-03-03 08:50:16.675676');
INSERT INTO public.virksomhet VALUES (13, '857842260', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857842260', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.681953', '2023-03-03 08:50:16.681953');
INSERT INTO public.virksomhet VALUES (14, '885073621', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885073621', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.687591', '2023-03-03 08:50:16.687591');
INSERT INTO public.virksomhet VALUES (15, '864754605', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864754605', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.695012', '2023-03-03 08:50:16.695012');
INSERT INTO public.virksomhet VALUES (16, '846347581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846347581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.700062', '2023-03-03 08:50:16.700062');
INSERT INTO public.virksomhet VALUES (17, '824680794', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824680794', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.705168', '2023-03-03 08:50:16.705168');
INSERT INTO public.virksomhet VALUES (18, '839415001', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839415001', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.710805', '2023-03-03 08:50:16.710805');
INSERT INTO public.virksomhet VALUES (19, '861744528', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861744528', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.716435', '2023-03-03 08:50:16.716435');
INSERT INTO public.virksomhet VALUES (20, '860138909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860138909', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.721377', '2023-03-03 08:50:16.721377');
INSERT INTO public.virksomhet VALUES (21, '843242104', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843242104', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.726742', '2023-03-03 08:50:16.726742');
INSERT INTO public.virksomhet VALUES (22, '890093850', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890093850', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.731931', '2023-03-03 08:50:16.731931');
INSERT INTO public.virksomhet VALUES (23, '892511017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892511017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.737071', '2023-03-03 08:50:16.737071');
INSERT INTO public.virksomhet VALUES (24, '842605109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842605109', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.742237', '2023-03-03 08:50:16.742237');
INSERT INTO public.virksomhet VALUES (25, '870491047', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870491047', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.747487', '2023-03-03 08:50:16.747487');
INSERT INTO public.virksomhet VALUES (26, '863507760', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863507760', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.753683', '2023-03-03 08:50:16.753683');
INSERT INTO public.virksomhet VALUES (27, '817257908', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817257908', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.758791', '2023-03-03 08:50:16.758791');
INSERT INTO public.virksomhet VALUES (28, '809042383', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809042383', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.764025', '2023-03-03 08:50:16.764025');
INSERT INTO public.virksomhet VALUES (29, '810734693', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810734693', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.769536', '2023-03-03 08:50:16.769536');
INSERT INTO public.virksomhet VALUES (30, '804629062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804629062', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.774637', '2023-03-03 08:50:16.774637');
INSERT INTO public.virksomhet VALUES (31, '873621335', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873621335', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.780133', '2023-03-03 08:50:16.780133');
INSERT INTO public.virksomhet VALUES (32, '835058832', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835058832', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.786034', '2023-03-03 08:50:16.786034');
INSERT INTO public.virksomhet VALUES (33, '803826652', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803826652', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.791208', '2023-03-03 08:50:16.791208');
INSERT INTO public.virksomhet VALUES (34, '874394467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874394467', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.796665', '2023-03-03 08:50:16.796665');
INSERT INTO public.virksomhet VALUES (35, '838903289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838903289', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.80174', '2023-03-03 08:50:16.80174');
INSERT INTO public.virksomhet VALUES (36, '882051647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882051647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.80686', '2023-03-03 08:50:16.80686');
INSERT INTO public.virksomhet VALUES (37, '879681201', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879681201', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.81251', '2023-03-03 08:50:16.81251');
INSERT INTO public.virksomhet VALUES (38, '852409131', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852409131', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.817501', '2023-03-03 08:50:16.817501');
INSERT INTO public.virksomhet VALUES (39, '808215075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808215075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.822927', '2023-03-03 08:50:16.822927');
INSERT INTO public.virksomhet VALUES (40, '865074415', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865074415', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.828308', '2023-03-03 08:50:16.828308');
INSERT INTO public.virksomhet VALUES (41, '836669149', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836669149', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.833631', '2023-03-03 08:50:16.833631');
INSERT INTO public.virksomhet VALUES (42, '884369776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884369776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.838535', '2023-03-03 08:50:16.838535');
INSERT INTO public.virksomhet VALUES (43, '873418367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873418367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.843707', '2023-03-03 08:50:16.843707');
INSERT INTO public.virksomhet VALUES (44, '802905016', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802905016', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.849061', '2023-03-03 08:50:16.849061');
INSERT INTO public.virksomhet VALUES (45, '885609899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885609899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.85662', '2023-03-03 08:50:16.85662');
INSERT INTO public.virksomhet VALUES (46, '860836918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860836918', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.864043', '2023-03-03 08:50:16.864043');
INSERT INTO public.virksomhet VALUES (47, '829745509', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829745509', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.868756', '2023-03-03 08:50:16.868756');
INSERT INTO public.virksomhet VALUES (48, '844246611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844246611', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.873524', '2023-03-03 08:50:16.873524');
INSERT INTO public.virksomhet VALUES (49, '867216743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867216743', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.878653', '2023-03-03 08:50:16.878653');
INSERT INTO public.virksomhet VALUES (50, '890941228', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890941228', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.883105', '2023-03-03 08:50:16.883105');
INSERT INTO public.virksomhet VALUES (51, '838540049', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838540049', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.889082', '2023-03-03 08:50:16.889082');
INSERT INTO public.virksomhet VALUES (52, '809501750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809501750', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.893721', '2023-03-03 08:50:16.893721');
INSERT INTO public.virksomhet VALUES (53, '844496478', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844496478', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.898126', '2023-03-03 08:50:16.898126');
INSERT INTO public.virksomhet VALUES (54, '863501025', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863501025', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.902519', '2023-03-03 08:50:16.902519');
INSERT INTO public.virksomhet VALUES (55, '839166324', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839166324', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.906956', '2023-03-03 08:50:16.906956');
INSERT INTO public.virksomhet VALUES (56, '879962157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879962157', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.911496', '2023-03-03 08:50:16.911496');
INSERT INTO public.virksomhet VALUES (57, '848543645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848543645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.915699', '2023-03-03 08:50:16.915699');
INSERT INTO public.virksomhet VALUES (58, '880279851', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880279851', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.920931', '2023-03-03 08:50:16.920931');
INSERT INTO public.virksomhet VALUES (59, '808671188', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808671188', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.926469', '2023-03-03 08:50:16.926469');
INSERT INTO public.virksomhet VALUES (60, '851333885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851333885', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.931131', '2023-03-03 08:50:16.931131');
INSERT INTO public.virksomhet VALUES (61, '815366017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815366017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.936069', '2023-03-03 08:50:16.936069');
INSERT INTO public.virksomhet VALUES (62, '891113900', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891113900', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.940974', '2023-03-03 08:50:16.940974');
INSERT INTO public.virksomhet VALUES (63, '894926128', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894926128', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.946085', '2023-03-03 08:50:16.946085');
INSERT INTO public.virksomhet VALUES (64, '802290404', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802290404', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.950657', '2023-03-03 08:50:16.950657');
INSERT INTO public.virksomhet VALUES (65, '896239097', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896239097', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.95513', '2023-03-03 08:50:16.95513');
INSERT INTO public.virksomhet VALUES (66, '816868949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816868949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.960214', '2023-03-03 08:50:16.960214');
INSERT INTO public.virksomhet VALUES (67, '895298219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895298219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.964901', '2023-03-03 08:50:16.964901');
INSERT INTO public.virksomhet VALUES (68, '842893897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842893897', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.969972', '2023-03-03 08:50:16.969972');
INSERT INTO public.virksomhet VALUES (69, '814670938', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814670938', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.974706', '2023-03-03 08:50:16.974706');
INSERT INTO public.virksomhet VALUES (70, '820433803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820433803', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.979005', '2023-03-03 08:50:16.979005');
INSERT INTO public.virksomhet VALUES (71, '874104569', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874104569', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.983165', '2023-03-03 08:50:16.983165');
INSERT INTO public.virksomhet VALUES (72, '856520283', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856520283', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.987849', '2023-03-03 08:50:16.987849');
INSERT INTO public.virksomhet VALUES (73, '879090305', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879090305', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.992282', '2023-03-03 08:50:16.992282');
INSERT INTO public.virksomhet VALUES (74, '809468321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809468321', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:16.997176', '2023-03-03 08:50:16.997176');
INSERT INTO public.virksomhet VALUES (75, '826378947', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826378947', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.002146', '2023-03-03 08:50:17.002146');
INSERT INTO public.virksomhet VALUES (76, '866390365', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866390365', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.012232', '2023-03-03 08:50:17.012232');
INSERT INTO public.virksomhet VALUES (77, '862771013', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862771013', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.018475', '2023-03-03 08:50:17.018475');
INSERT INTO public.virksomhet VALUES (78, '864363318', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864363318', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.024897', '2023-03-03 08:50:17.024897');
INSERT INTO public.virksomhet VALUES (79, '896438075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896438075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.03147', '2023-03-03 08:50:17.03147');
INSERT INTO public.virksomhet VALUES (80, '829368106', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829368106', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.037582', '2023-03-03 08:50:17.037582');
INSERT INTO public.virksomhet VALUES (81, '867407313', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867407313', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.042237', '2023-03-03 08:50:17.042237');
INSERT INTO public.virksomhet VALUES (82, '896587504', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896587504', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.047252', '2023-03-03 08:50:17.047252');
INSERT INTO public.virksomhet VALUES (83, '847845944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847845944', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.051887', '2023-03-03 08:50:17.051887');
INSERT INTO public.virksomhet VALUES (84, '826389298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826389298', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.056725', '2023-03-03 08:50:17.056725');
INSERT INTO public.virksomhet VALUES (85, '848399886', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848399886', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.061846', '2023-03-03 08:50:17.061846');
INSERT INTO public.virksomhet VALUES (86, '854846835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854846835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.066335', '2023-03-03 08:50:17.066335');
INSERT INTO public.virksomhet VALUES (87, '800634899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800634899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.07071', '2023-03-03 08:50:17.07071');
INSERT INTO public.virksomhet VALUES (88, '857110616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857110616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.07522', '2023-03-03 08:50:17.07522');
INSERT INTO public.virksomhet VALUES (89, '808271586', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808271586', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.079887', '2023-03-03 08:50:17.079887');
INSERT INTO public.virksomhet VALUES (90, '819801010', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819801010', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.084464', '2023-03-03 08:50:17.084464');
INSERT INTO public.virksomhet VALUES (91, '848578637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848578637', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.088592', '2023-03-03 08:50:17.088592');
INSERT INTO public.virksomhet VALUES (92, '827490752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827490752', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.093596', '2023-03-03 08:50:17.093596');
INSERT INTO public.virksomhet VALUES (93, '835736810', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835736810', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.09775', '2023-03-03 08:50:17.09775');
INSERT INTO public.virksomhet VALUES (94, '857544475', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857544475', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.101796', '2023-03-03 08:50:17.101796');
INSERT INTO public.virksomhet VALUES (95, '847721823', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847721823', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.106054', '2023-03-03 08:50:17.106054');
INSERT INTO public.virksomhet VALUES (96, '862581603', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862581603', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.110704', '2023-03-03 08:50:17.110704');
INSERT INTO public.virksomhet VALUES (97, '810313500', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810313500', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.115976', '2023-03-03 08:50:17.115976');
INSERT INTO public.virksomhet VALUES (98, '885129733', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885129733', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.120447', '2023-03-03 08:50:17.120447');
INSERT INTO public.virksomhet VALUES (99, '898243796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898243796', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.124949', '2023-03-03 08:50:17.124949');
INSERT INTO public.virksomhet VALUES (100, '887079787', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887079787', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.12906', '2023-03-03 08:50:17.12906');
INSERT INTO public.virksomhet VALUES (101, '861058672', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861058672', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.133441', '2023-03-03 08:50:17.133441');
INSERT INTO public.virksomhet VALUES (102, '876537913', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876537913', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.137936', '2023-03-03 08:50:17.137936');
INSERT INTO public.virksomhet VALUES (103, '890597928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890597928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.142057', '2023-03-03 08:50:17.142057');
INSERT INTO public.virksomhet VALUES (104, '842982051', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842982051', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.146182', '2023-03-03 08:50:17.146182');
INSERT INTO public.virksomhet VALUES (105, '842389667', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842389667', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.150225', '2023-03-03 08:50:17.150225');
INSERT INTO public.virksomhet VALUES (106, '820004072', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820004072', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.154529', '2023-03-03 08:50:17.154529');
INSERT INTO public.virksomhet VALUES (107, '897688257', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897688257', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.158816', '2023-03-03 08:50:17.158816');
INSERT INTO public.virksomhet VALUES (108, '837534390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837534390', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.16346', '2023-03-03 08:50:17.16346');
INSERT INTO public.virksomhet VALUES (109, '808543637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808543637', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.168228', '2023-03-03 08:50:17.168228');
INSERT INTO public.virksomhet VALUES (110, '870201888', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870201888', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.172654', '2023-03-03 08:50:17.172654');
INSERT INTO public.virksomhet VALUES (111, '817311070', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817311070', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.177224', '2023-03-03 08:50:17.177224');
INSERT INTO public.virksomhet VALUES (112, '868012776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868012776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.181749', '2023-03-03 08:50:17.181749');
INSERT INTO public.virksomhet VALUES (113, '896429753', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896429753', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.185747', '2023-03-03 08:50:17.185747');
INSERT INTO public.virksomhet VALUES (114, '851603425', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851603425', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.18984', '2023-03-03 08:50:17.18984');
INSERT INTO public.virksomhet VALUES (115, '827443317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827443317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.194094', '2023-03-03 08:50:17.194094');
INSERT INTO public.virksomhet VALUES (116, '833362642', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833362642', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.198504', '2023-03-03 08:50:17.198504');
INSERT INTO public.virksomhet VALUES (117, '882069408', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882069408', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.202916', '2023-03-03 08:50:17.202916');
INSERT INTO public.virksomhet VALUES (118, '863878944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863878944', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.207411', '2023-03-03 08:50:17.207411');
INSERT INTO public.virksomhet VALUES (119, '866558221', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866558221', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.211822', '2023-03-03 08:50:17.211822');
INSERT INTO public.virksomhet VALUES (120, '868767855', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868767855', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.216591', '2023-03-03 08:50:17.216591');
INSERT INTO public.virksomhet VALUES (121, '875885300', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875885300', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.220624', '2023-03-03 08:50:17.220624');
INSERT INTO public.virksomhet VALUES (122, '842216735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842216735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.226152', '2023-03-03 08:50:17.226152');
INSERT INTO public.virksomhet VALUES (123, '856920437', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856920437', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.230382', '2023-03-03 08:50:17.230382');
INSERT INTO public.virksomhet VALUES (124, '830858963', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830858963', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.234507', '2023-03-03 08:50:17.234507');
INSERT INTO public.virksomhet VALUES (125, '812434114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812434114', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.238885', '2023-03-03 08:50:17.238885');
INSERT INTO public.virksomhet VALUES (126, '847041353', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847041353', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.243434', '2023-03-03 08:50:17.243434');
INSERT INTO public.virksomhet VALUES (127, '803269327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803269327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.24782', '2023-03-03 08:50:17.24782');
INSERT INTO public.virksomhet VALUES (128, '843457384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843457384', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.25181', '2023-03-03 08:50:17.25181');
INSERT INTO public.virksomhet VALUES (129, '818306281', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818306281', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.255857', '2023-03-03 08:50:17.255857');
INSERT INTO public.virksomhet VALUES (130, '844449510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844449510', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.260012', '2023-03-03 08:50:17.260012');
INSERT INTO public.virksomhet VALUES (131, '867177223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867177223', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.263879', '2023-03-03 08:50:17.263879');
INSERT INTO public.virksomhet VALUES (132, '883963814', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883963814', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.268215', '2023-03-03 08:50:17.268215');
INSERT INTO public.virksomhet VALUES (133, '886253015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886253015', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.272663', '2023-03-03 08:50:17.272663');
INSERT INTO public.virksomhet VALUES (134, '895281822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895281822', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.276825', '2023-03-03 08:50:17.276825');
INSERT INTO public.virksomhet VALUES (135, '840533481', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840533481', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.281331', '2023-03-03 08:50:17.281331');
INSERT INTO public.virksomhet VALUES (136, '839216776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839216776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.285694', '2023-03-03 08:50:17.285694');
INSERT INTO public.virksomhet VALUES (137, '803533948', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803533948', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.289916', '2023-03-03 08:50:17.289916');
INSERT INTO public.virksomhet VALUES (138, '827095124', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827095124', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.294393', '2023-03-03 08:50:17.294393');
INSERT INTO public.virksomhet VALUES (139, '808251981', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808251981', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.298659', '2023-03-03 08:50:17.298659');
INSERT INTO public.virksomhet VALUES (140, '817358823', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817358823', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.302975', '2023-03-03 08:50:17.302975');
INSERT INTO public.virksomhet VALUES (141, '871910327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871910327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.307177', '2023-03-03 08:50:17.307177');
INSERT INTO public.virksomhet VALUES (142, '866587133', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866587133', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.311452', '2023-03-03 08:50:17.311452');
INSERT INTO public.virksomhet VALUES (143, '842840788', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842840788', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.31581', '2023-03-03 08:50:17.31581');
INSERT INTO public.virksomhet VALUES (144, '812781923', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812781923', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.319879', '2023-03-03 08:50:17.319879');
INSERT INTO public.virksomhet VALUES (145, '804058381', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804058381', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.323913', '2023-03-03 08:50:17.323913');
INSERT INTO public.virksomhet VALUES (146, '811423248', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811423248', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.328768', '2023-03-03 08:50:17.328768');
INSERT INTO public.virksomhet VALUES (147, '840837641', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840837641', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.333953', '2023-03-03 08:50:17.333953');
INSERT INTO public.virksomhet VALUES (148, '818816392', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818816392', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.33831', '2023-03-03 08:50:17.33831');
INSERT INTO public.virksomhet VALUES (149, '806494928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806494928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.343316', '2023-03-03 08:50:17.343316');
INSERT INTO public.virksomhet VALUES (150, '893055618', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893055618', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.347635', '2023-03-03 08:50:17.347635');
INSERT INTO public.virksomhet VALUES (151, '875340822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875340822', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.352208', '2023-03-03 08:50:17.352208');
INSERT INTO public.virksomhet VALUES (152, '818463756', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818463756', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.357156', '2023-03-03 08:50:17.357156');
INSERT INTO public.virksomhet VALUES (153, '884152302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884152302', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.361804', '2023-03-03 08:50:17.361804');
INSERT INTO public.virksomhet VALUES (154, '849742742', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849742742', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.366684', '2023-03-03 08:50:17.366684');
INSERT INTO public.virksomhet VALUES (155, '804979817', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804979817', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.371215', '2023-03-03 08:50:17.371215');
INSERT INTO public.virksomhet VALUES (156, '814190896', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814190896', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.375852', '2023-03-03 08:50:17.375852');
INSERT INTO public.virksomhet VALUES (157, '822331640', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822331640', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.380136', '2023-03-03 08:50:17.380136');
INSERT INTO public.virksomhet VALUES (158, '862678317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862678317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.384301', '2023-03-03 08:50:17.384301');
INSERT INTO public.virksomhet VALUES (159, '831093023', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831093023', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.388704', '2023-03-03 08:50:17.388704');
INSERT INTO public.virksomhet VALUES (160, '874226454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874226454', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.393272', '2023-03-03 08:50:17.393272');
INSERT INTO public.virksomhet VALUES (161, '832436811', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832436811', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.397534', '2023-03-03 08:50:17.397534');
INSERT INTO public.virksomhet VALUES (162, '838432048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838432048', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.401664', '2023-03-03 08:50:17.401664');
INSERT INTO public.virksomhet VALUES (163, '870022919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870022919', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.405948', '2023-03-03 08:50:17.405948');
INSERT INTO public.virksomhet VALUES (164, '879268334', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879268334', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.410693', '2023-03-03 08:50:17.410693');
INSERT INTO public.virksomhet VALUES (165, '806599852', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806599852', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.415967', '2023-03-03 08:50:17.415967');
INSERT INTO public.virksomhet VALUES (166, '863181199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863181199', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.420506', '2023-03-03 08:50:17.420506');
INSERT INTO public.virksomhet VALUES (167, '863767568', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863767568', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.424861', '2023-03-03 08:50:17.424861');
INSERT INTO public.virksomhet VALUES (168, '844014636', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844014636', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.429146', '2023-03-03 08:50:17.429146');
INSERT INTO public.virksomhet VALUES (169, '866404710', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866404710', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.433818', '2023-03-03 08:50:17.433818');
INSERT INTO public.virksomhet VALUES (170, '833129946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833129946', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.437955', '2023-03-03 08:50:17.437955');
INSERT INTO public.virksomhet VALUES (171, '846977998', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846977998', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.442283', '2023-03-03 08:50:17.442283');
INSERT INTO public.virksomhet VALUES (172, '811030348', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811030348', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.446827', '2023-03-03 08:50:17.446827');
INSERT INTO public.virksomhet VALUES (173, '890815907', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890815907', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.451111', '2023-03-03 08:50:17.451111');
INSERT INTO public.virksomhet VALUES (174, '822694021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822694021', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.455488', '2023-03-03 08:50:17.455488');
INSERT INTO public.virksomhet VALUES (175, '852558904', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852558904', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.459688', '2023-03-03 08:50:17.459688');
INSERT INTO public.virksomhet VALUES (176, '822874914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822874914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.46378', '2023-03-03 08:50:17.46378');
INSERT INTO public.virksomhet VALUES (177, '866646453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866646453', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.467903', '2023-03-03 08:50:17.467903');
INSERT INTO public.virksomhet VALUES (178, '881021956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881021956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.472011', '2023-03-03 08:50:17.472011');
INSERT INTO public.virksomhet VALUES (179, '899291735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899291735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.476288', '2023-03-03 08:50:17.476288');
INSERT INTO public.virksomhet VALUES (180, '867918928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867918928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.480841', '2023-03-03 08:50:17.480841');
INSERT INTO public.virksomhet VALUES (181, '823439458', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823439458', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.484998', '2023-03-03 08:50:17.484998');
INSERT INTO public.virksomhet VALUES (182, '837805347', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837805347', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.489681', '2023-03-03 08:50:17.489681');
INSERT INTO public.virksomhet VALUES (183, '805499088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805499088', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.494434', '2023-03-03 08:50:17.494434');
INSERT INTO public.virksomhet VALUES (184, '845822610', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845822610', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.499243', '2023-03-03 08:50:17.499243');
INSERT INTO public.virksomhet VALUES (185, '841405633', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841405633', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.504545', '2023-03-03 08:50:17.504545');
INSERT INTO public.virksomhet VALUES (186, '889675608', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889675608', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.509376', '2023-03-03 08:50:17.509376');
INSERT INTO public.virksomhet VALUES (187, '899025387', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899025387', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.51375', '2023-03-03 08:50:17.51375');
INSERT INTO public.virksomhet VALUES (188, '863280835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863280835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.518185', '2023-03-03 08:50:17.518185');
INSERT INTO public.virksomhet VALUES (189, '860629673', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860629673', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.523785', '2023-03-03 08:50:17.523785');
INSERT INTO public.virksomhet VALUES (190, '833667497', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833667497', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.530418', '2023-03-03 08:50:17.530418');
INSERT INTO public.virksomhet VALUES (191, '842471044', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842471044', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.535528', '2023-03-03 08:50:17.535528');
INSERT INTO public.virksomhet VALUES (192, '861459803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861459803', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.540032', '2023-03-03 08:50:17.540032');
INSERT INTO public.virksomhet VALUES (193, '812926032', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812926032', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.544471', '2023-03-03 08:50:17.544471');
INSERT INTO public.virksomhet VALUES (194, '871631319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871631319', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.548761', '2023-03-03 08:50:17.548761');
INSERT INTO public.virksomhet VALUES (195, '865439281', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865439281', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.55354', '2023-03-03 08:50:17.55354');
INSERT INTO public.virksomhet VALUES (196, '824210548', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824210548', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.558161', '2023-03-03 08:50:17.558161');
INSERT INTO public.virksomhet VALUES (197, '805486005', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805486005', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.562459', '2023-03-03 08:50:17.562459');
INSERT INTO public.virksomhet VALUES (198, '832448472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832448472', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.567084', '2023-03-03 08:50:17.567084');
INSERT INTO public.virksomhet VALUES (199, '805820685', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805820685', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.572006', '2023-03-03 08:50:17.572006');
INSERT INTO public.virksomhet VALUES (200, '883768894', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883768894', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.576898', '2023-03-03 08:50:17.576898');
INSERT INTO public.virksomhet VALUES (201, '856903021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856903021', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.58147', '2023-03-03 08:50:17.58147');
INSERT INTO public.virksomhet VALUES (202, '850012745', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850012745', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.586485', '2023-03-03 08:50:17.586485');
INSERT INTO public.virksomhet VALUES (203, '820149848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820149848', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.590943', '2023-03-03 08:50:17.590943');
INSERT INTO public.virksomhet VALUES (204, '822705108', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822705108', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.596339', '2023-03-03 08:50:17.596339');
INSERT INTO public.virksomhet VALUES (205, '857573851', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857573851', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.601508', '2023-03-03 08:50:17.601508');
INSERT INTO public.virksomhet VALUES (206, '856078198', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856078198', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.605954', '2023-03-03 08:50:17.605954');
INSERT INTO public.virksomhet VALUES (207, '859225721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859225721', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.610517', '2023-03-03 08:50:17.610517');
INSERT INTO public.virksomhet VALUES (208, '873879874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873879874', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.6151', '2023-03-03 08:50:17.6151');
INSERT INTO public.virksomhet VALUES (209, '890065285', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890065285', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.62029', '2023-03-03 08:50:17.62029');
INSERT INTO public.virksomhet VALUES (210, '893423280', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893423280', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.624536', '2023-03-03 08:50:17.624536');
INSERT INTO public.virksomhet VALUES (211, '816273126', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816273126', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.629411', '2023-03-03 08:50:17.629411');
INSERT INTO public.virksomhet VALUES (212, '874977909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874977909', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.634209', '2023-03-03 08:50:17.634209');
INSERT INTO public.virksomhet VALUES (213, '888632161', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888632161', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.638836', '2023-03-03 08:50:17.638836');
INSERT INTO public.virksomhet VALUES (214, '852452427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852452427', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.643711', '2023-03-03 08:50:17.643711');
INSERT INTO public.virksomhet VALUES (215, '807389236', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807389236', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.648226', '2023-03-03 08:50:17.648226');
INSERT INTO public.virksomhet VALUES (216, '833163111', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833163111', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.652762', '2023-03-03 08:50:17.652762');
INSERT INTO public.virksomhet VALUES (217, '813080832', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813080832', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.656911', '2023-03-03 08:50:17.656911');
INSERT INTO public.virksomhet VALUES (218, '896489260', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896489260', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.660983', '2023-03-03 08:50:17.660983');
INSERT INTO public.virksomhet VALUES (219, '845881839', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845881839', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.665731', '2023-03-03 08:50:17.665731');
INSERT INTO public.virksomhet VALUES (220, '898157169', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898157169', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.67015', '2023-03-03 08:50:17.67015');
INSERT INTO public.virksomhet VALUES (221, '882940656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882940656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.67492', '2023-03-03 08:50:17.67492');
INSERT INTO public.virksomhet VALUES (222, '887589106', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887589106', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.679104', '2023-03-03 08:50:17.679104');
INSERT INTO public.virksomhet VALUES (223, '856439808', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856439808', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.683423', '2023-03-03 08:50:17.683423');
INSERT INTO public.virksomhet VALUES (224, '869911712', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869911712', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.687721', '2023-03-03 08:50:17.687721');
INSERT INTO public.virksomhet VALUES (225, '836420677', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836420677', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.691815', '2023-03-03 08:50:17.691815');
INSERT INTO public.virksomhet VALUES (226, '810521018', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810521018', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.695753', '2023-03-03 08:50:17.695753');
INSERT INTO public.virksomhet VALUES (227, '863021621', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863021621', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.699982', '2023-03-03 08:50:17.699982');
INSERT INTO public.virksomhet VALUES (228, '846289494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846289494', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.704957', '2023-03-03 08:50:17.704957');
INSERT INTO public.virksomhet VALUES (229, '834191416', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834191416', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.70942', '2023-03-03 08:50:17.70942');
INSERT INTO public.virksomhet VALUES (230, '837420340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837420340', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.715609', '2023-03-03 08:50:17.715609');
INSERT INTO public.virksomhet VALUES (231, '871949311', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871949311', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.720868', '2023-03-03 08:50:17.720868');
INSERT INTO public.virksomhet VALUES (232, '821633142', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821633142', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.7264', '2023-03-03 08:50:17.7264');
INSERT INTO public.virksomhet VALUES (233, '893463166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893463166', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.730479', '2023-03-03 08:50:17.730479');
INSERT INTO public.virksomhet VALUES (234, '833218825', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833218825', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.734547', '2023-03-03 08:50:17.734547');
INSERT INTO public.virksomhet VALUES (235, '807456455', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807456455', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.73908', '2023-03-03 08:50:17.73908');
INSERT INTO public.virksomhet VALUES (236, '821381486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821381486', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.743359', '2023-03-03 08:50:17.743359');
INSERT INTO public.virksomhet VALUES (237, '814324199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814324199', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.7484', '2023-03-03 08:50:17.7484');
INSERT INTO public.virksomhet VALUES (238, '805904949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805904949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.753484', '2023-03-03 08:50:17.753484');
INSERT INTO public.virksomhet VALUES (239, '813242515', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813242515', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.758133', '2023-03-03 08:50:17.758133');
INSERT INTO public.virksomhet VALUES (240, '839415843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839415843', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.762777', '2023-03-03 08:50:17.762777');
INSERT INTO public.virksomhet VALUES (241, '804234371', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804234371', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.767136', '2023-03-03 08:50:17.767136');
INSERT INTO public.virksomhet VALUES (242, '816585946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816585946', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.771371', '2023-03-03 08:50:17.771371');
INSERT INTO public.virksomhet VALUES (243, '824097835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824097835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.776155', '2023-03-03 08:50:17.776155');
INSERT INTO public.virksomhet VALUES (244, '880538674', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880538674', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.780729', '2023-03-03 08:50:17.780729');
INSERT INTO public.virksomhet VALUES (245, '875775705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875775705', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.78526', '2023-03-03 08:50:17.78526');
INSERT INTO public.virksomhet VALUES (246, '877421692', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877421692', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.789738', '2023-03-03 08:50:17.789738');
INSERT INTO public.virksomhet VALUES (247, '871547736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871547736', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.794757', '2023-03-03 08:50:17.794757');
INSERT INTO public.virksomhet VALUES (248, '857653378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857653378', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.799399', '2023-03-03 08:50:17.799399');
INSERT INTO public.virksomhet VALUES (249, '829980700', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829980700', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.804027', '2023-03-03 08:50:17.804027');
INSERT INTO public.virksomhet VALUES (250, '852627790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852627790', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.808485', '2023-03-03 08:50:17.808485');
INSERT INTO public.virksomhet VALUES (251, '865978526', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865978526', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.813456', '2023-03-03 08:50:17.813456');
INSERT INTO public.virksomhet VALUES (252, '840145629', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840145629', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.81801', '2023-03-03 08:50:17.81801');
INSERT INTO public.virksomhet VALUES (253, '875016141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875016141', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.822559', '2023-03-03 08:50:17.822559');
INSERT INTO public.virksomhet VALUES (254, '869419134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869419134', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.827364', '2023-03-03 08:50:17.827364');
INSERT INTO public.virksomhet VALUES (255, '813944600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813944600', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.832017', '2023-03-03 08:50:17.832017');
INSERT INTO public.virksomhet VALUES (256, '885600454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885600454', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.836188', '2023-03-03 08:50:17.836188');
INSERT INTO public.virksomhet VALUES (257, '877550656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877550656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.840927', '2023-03-03 08:50:17.840927');
INSERT INTO public.virksomhet VALUES (258, '804227830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804227830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.846166', '2023-03-03 08:50:17.846166');
INSERT INTO public.virksomhet VALUES (259, '858956619', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858956619', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.851244', '2023-03-03 08:50:17.851244');
INSERT INTO public.virksomhet VALUES (260, '865153645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865153645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.85587', '2023-03-03 08:50:17.85587');
INSERT INTO public.virksomhet VALUES (261, '817941723', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817941723', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.860517', '2023-03-03 08:50:17.860517');
INSERT INTO public.virksomhet VALUES (262, '811667993', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811667993', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.864836', '2023-03-03 08:50:17.864836');
INSERT INTO public.virksomhet VALUES (263, '859462534', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859462534', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.868961', '2023-03-03 08:50:17.868961');
INSERT INTO public.virksomhet VALUES (264, '822317092', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822317092', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.873425', '2023-03-03 08:50:17.873425');
INSERT INTO public.virksomhet VALUES (265, '877772835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877772835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.878295', '2023-03-03 08:50:17.878295');
INSERT INTO public.virksomhet VALUES (266, '846495295', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846495295', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.883368', '2023-03-03 08:50:17.883368');
INSERT INTO public.virksomhet VALUES (267, '804775869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804775869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.888504', '2023-03-03 08:50:17.888504');
INSERT INTO public.virksomhet VALUES (268, '831030012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831030012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.892862', '2023-03-03 08:50:17.892862');
INSERT INTO public.virksomhet VALUES (269, '802809462', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802809462', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.897781', '2023-03-03 08:50:17.897781');
INSERT INTO public.virksomhet VALUES (270, '896200151', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896200151', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.902227', '2023-03-03 08:50:17.902227');
INSERT INTO public.virksomhet VALUES (271, '873610100', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873610100', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.906551', '2023-03-03 08:50:17.906551');
INSERT INTO public.virksomhet VALUES (272, '847931581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847931581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.911036', '2023-03-03 08:50:17.911036');
INSERT INTO public.virksomhet VALUES (273, '870810427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870810427', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.915089', '2023-03-03 08:50:17.915089');
INSERT INTO public.virksomhet VALUES (274, '816457914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816457914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.919132', '2023-03-03 08:50:17.919132');
INSERT INTO public.virksomhet VALUES (275, '816760477', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816760477', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.923696', '2023-03-03 08:50:17.923696');
INSERT INTO public.virksomhet VALUES (276, '821449527', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821449527', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.927899', '2023-03-03 08:50:17.927899');
INSERT INTO public.virksomhet VALUES (277, '897412997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897412997', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.932257', '2023-03-03 08:50:17.932257');
INSERT INTO public.virksomhet VALUES (278, '801856356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801856356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.936556', '2023-03-03 08:50:17.936556');
INSERT INTO public.virksomhet VALUES (279, '898170941', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898170941', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.943307', '2023-03-03 08:50:17.943307');
INSERT INTO public.virksomhet VALUES (280, '884390144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884390144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.948754', '2023-03-03 08:50:17.948754');
INSERT INTO public.virksomhet VALUES (281, '894424841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894424841', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.953354', '2023-03-03 08:50:17.953354');
INSERT INTO public.virksomhet VALUES (282, '828972512', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828972512', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.95733', '2023-03-03 08:50:17.95733');
INSERT INTO public.virksomhet VALUES (283, '815082581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815082581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.962441', '2023-03-03 08:50:17.962441');
INSERT INTO public.virksomhet VALUES (284, '887159012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887159012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.967094', '2023-03-03 08:50:17.967094');
INSERT INTO public.virksomhet VALUES (285, '829493874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829493874', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.972356', '2023-03-03 08:50:17.972356');
INSERT INTO public.virksomhet VALUES (286, '814929193', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814929193', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.977307', '2023-03-03 08:50:17.977307');
INSERT INTO public.virksomhet VALUES (287, '859907302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859907302', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.982224', '2023-03-03 08:50:17.982224');
INSERT INTO public.virksomhet VALUES (288, '895124699', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895124699', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.987987', '2023-03-03 08:50:17.987987');
INSERT INTO public.virksomhet VALUES (289, '813239227', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813239227', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.99368', '2023-03-03 08:50:17.99368');
INSERT INTO public.virksomhet VALUES (290, '840430296', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840430296', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:17.999574', '2023-03-03 08:50:17.999574');
INSERT INTO public.virksomhet VALUES (291, '858726639', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858726639', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.004104', '2023-03-03 08:50:18.004104');
INSERT INTO public.virksomhet VALUES (292, '823234800', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823234800', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.010061', '2023-03-03 08:50:18.010061');
INSERT INTO public.virksomhet VALUES (293, '874361830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874361830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.015967', '2023-03-03 08:50:18.015967');
INSERT INTO public.virksomhet VALUES (294, '808481735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808481735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.021181', '2023-03-03 08:50:18.021181');
INSERT INTO public.virksomhet VALUES (295, '860499175', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860499175', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.026376', '2023-03-03 08:50:18.026376');
INSERT INTO public.virksomhet VALUES (296, '892697142', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892697142', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.033675', '2023-03-03 08:50:18.033675');
INSERT INTO public.virksomhet VALUES (297, '826727890', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826727890', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.040519', '2023-03-03 08:50:18.040519');
INSERT INTO public.virksomhet VALUES (298, '895582762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895582762', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.045726', '2023-03-03 08:50:18.045726');
INSERT INTO public.virksomhet VALUES (299, '814663914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814663914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.051445', '2023-03-03 08:50:18.051445');
INSERT INTO public.virksomhet VALUES (300, '887191975', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887191975', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.056272', '2023-03-03 08:50:18.056272');
INSERT INTO public.virksomhet VALUES (301, '856729012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856729012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.060864', '2023-03-03 08:50:18.060864');
INSERT INTO public.virksomhet VALUES (302, '816248533', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816248533', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.064997', '2023-03-03 08:50:18.064997');
INSERT INTO public.virksomhet VALUES (303, '847253663', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847253663', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.068669', '2023-03-03 08:50:18.068669');
INSERT INTO public.virksomhet VALUES (304, '851556995', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851556995', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.072312', '2023-03-03 08:50:18.072312');
INSERT INTO public.virksomhet VALUES (305, '897000352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897000352', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.076289', '2023-03-03 08:50:18.076289');
INSERT INTO public.virksomhet VALUES (306, '891267708', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891267708', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.080163', '2023-03-03 08:50:18.080163');
INSERT INTO public.virksomhet VALUES (307, '868369009', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868369009', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.084357', '2023-03-03 08:50:18.084357');
INSERT INTO public.virksomhet VALUES (308, '836786224', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836786224', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.088232', '2023-03-03 08:50:18.088232');
INSERT INTO public.virksomhet VALUES (309, '800910790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800910790', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.091911', '2023-03-03 08:50:18.091911');
INSERT INTO public.virksomhet VALUES (310, '847922087', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847922087', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.095909', '2023-03-03 08:50:18.095909');
INSERT INTO public.virksomhet VALUES (311, '882737279', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882737279', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.100064', '2023-03-03 08:50:18.100064');
INSERT INTO public.virksomhet VALUES (312, '817612413', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817612413', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.104338', '2023-03-03 08:50:18.104338');
INSERT INTO public.virksomhet VALUES (313, '857680168', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857680168', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.108347', '2023-03-03 08:50:18.108347');
INSERT INTO public.virksomhet VALUES (314, '878624841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878624841', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.11207', '2023-03-03 08:50:18.11207');
INSERT INTO public.virksomhet VALUES (315, '867183919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867183919', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.115944', '2023-03-03 08:50:18.115944');
INSERT INTO public.virksomhet VALUES (316, '824306551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824306551', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.120314', '2023-03-03 08:50:18.120314');
INSERT INTO public.virksomhet VALUES (317, '812929350', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812929350', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.124535', '2023-03-03 08:50:18.124535');
INSERT INTO public.virksomhet VALUES (318, '890735735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890735735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.129096', '2023-03-03 08:50:18.129096');
INSERT INTO public.virksomhet VALUES (319, '894341616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894341616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.133199', '2023-03-03 08:50:18.133199');
INSERT INTO public.virksomhet VALUES (320, '845690609', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845690609', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.137058', '2023-03-03 08:50:18.137058');
INSERT INTO public.virksomhet VALUES (321, '884945724', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884945724', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.142625', '2023-03-03 08:50:18.142625');
INSERT INTO public.virksomhet VALUES (322, '820865124', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820865124', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.147536', '2023-03-03 08:50:18.147536');
INSERT INTO public.virksomhet VALUES (323, '870514368', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870514368', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.15233', '2023-03-03 08:50:18.15233');
INSERT INTO public.virksomhet VALUES (324, '833643869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833643869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.156855', '2023-03-03 08:50:18.156855');
INSERT INTO public.virksomhet VALUES (325, '807702188', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807702188', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.161418', '2023-03-03 08:50:18.161418');
INSERT INTO public.virksomhet VALUES (326, '820638689', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820638689', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.16593', '2023-03-03 08:50:18.16593');
INSERT INTO public.virksomhet VALUES (327, '843380901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843380901', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.169712', '2023-03-03 08:50:18.169712');
INSERT INTO public.virksomhet VALUES (328, '832951634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832951634', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.174394', '2023-03-03 08:50:18.174394');
INSERT INTO public.virksomhet VALUES (329, '833677243', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833677243', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.179046', '2023-03-03 08:50:18.179046');
INSERT INTO public.virksomhet VALUES (330, '873656323', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873656323', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.183231', '2023-03-03 08:50:18.183231');
INSERT INTO public.virksomhet VALUES (331, '859159231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859159231', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.187086', '2023-03-03 08:50:18.187086');
INSERT INTO public.virksomhet VALUES (332, '868067017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868067017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.190968', '2023-03-03 08:50:18.190968');
INSERT INTO public.virksomhet VALUES (333, '856435712', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856435712', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.19521', '2023-03-03 08:50:18.19521');
INSERT INTO public.virksomhet VALUES (334, '888937591', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888937591', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.199634', '2023-03-03 08:50:18.199634');
INSERT INTO public.virksomhet VALUES (335, '873906284', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873906284', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.204344', '2023-03-03 08:50:18.204344');
INSERT INTO public.virksomhet VALUES (336, '855150484', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855150484', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.208484', '2023-03-03 08:50:18.208484');
INSERT INTO public.virksomhet VALUES (337, '836365546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836365546', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.212513', '2023-03-03 08:50:18.212513');
INSERT INTO public.virksomhet VALUES (338, '822564929', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822564929', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.217017', '2023-03-03 08:50:18.217017');
INSERT INTO public.virksomhet VALUES (339, '833204596', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833204596', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.221354', '2023-03-03 08:50:18.221354');
INSERT INTO public.virksomhet VALUES (340, '863592645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863592645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.226772', '2023-03-03 08:50:18.226772');
INSERT INTO public.virksomhet VALUES (341, '865956727', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865956727', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.23269', '2023-03-03 08:50:18.23269');
INSERT INTO public.virksomhet VALUES (342, '807629933', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807629933', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.240364', '2023-03-03 08:50:18.240364');
INSERT INTO public.virksomhet VALUES (343, '832454631', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832454631', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.247524', '2023-03-03 08:50:18.247524');
INSERT INTO public.virksomhet VALUES (344, '823356725', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823356725', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.254035', '2023-03-03 08:50:18.254035');
INSERT INTO public.virksomhet VALUES (345, '800824855', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800824855', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.26124', '2023-03-03 08:50:18.26124');
INSERT INTO public.virksomhet VALUES (346, '894510083', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894510083', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.266749', '2023-03-03 08:50:18.266749');
INSERT INTO public.virksomhet VALUES (347, '815854671', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815854671', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.273067', '2023-03-03 08:50:18.273067');
INSERT INTO public.virksomhet VALUES (348, '876401827', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876401827', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.280367', '2023-03-03 08:50:18.280367');
INSERT INTO public.virksomhet VALUES (349, '845066027', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845066027', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.286996', '2023-03-03 08:50:18.286996');
INSERT INTO public.virksomhet VALUES (350, '815406101', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815406101', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.293956', '2023-03-03 08:50:18.293956');
INSERT INTO public.virksomhet VALUES (351, '866878310', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866878310', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.301363', '2023-03-03 08:50:18.301363');
INSERT INTO public.virksomhet VALUES (352, '830803739', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830803739', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.308578', '2023-03-03 08:50:18.308578');
INSERT INTO public.virksomhet VALUES (353, '805933483', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805933483', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.316294', '2023-03-03 08:50:18.316294');
INSERT INTO public.virksomhet VALUES (354, '868252144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868252144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.324949', '2023-03-03 08:50:18.324949');
INSERT INTO public.virksomhet VALUES (355, '828744326', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828744326', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.331697', '2023-03-03 08:50:18.331697');
INSERT INTO public.virksomhet VALUES (356, '830122600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830122600', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.338962', '2023-03-03 08:50:18.338962');
INSERT INTO public.virksomhet VALUES (357, '813147327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813147327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.346286', '2023-03-03 08:50:18.346286');
INSERT INTO public.virksomhet VALUES (358, '846250295', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846250295', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.354611', '2023-03-03 08:50:18.354611');
INSERT INTO public.virksomhet VALUES (359, '898250721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898250721', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.362416', '2023-03-03 08:50:18.362416');
INSERT INTO public.virksomhet VALUES (360, '813697349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813697349', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.368824', '2023-03-03 08:50:18.368824');
INSERT INTO public.virksomhet VALUES (361, '863104800', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863104800', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.375662', '2023-03-03 08:50:18.375662');
INSERT INTO public.virksomhet VALUES (362, '897979593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897979593', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.382356', '2023-03-03 08:50:18.382356');
INSERT INTO public.virksomhet VALUES (363, '860772161', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860772161', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.389394', '2023-03-03 08:50:18.389394');
INSERT INTO public.virksomhet VALUES (364, '808002552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808002552', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.396856', '2023-03-03 08:50:18.396856');
INSERT INTO public.virksomhet VALUES (365, '876394411', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876394411', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.40405', '2023-03-03 08:50:18.40405');
INSERT INTO public.virksomhet VALUES (366, '846214156', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846214156', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.413157', '2023-03-03 08:50:18.413157');
INSERT INTO public.virksomhet VALUES (367, '850015354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850015354', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.419385', '2023-03-03 08:50:18.419385');
INSERT INTO public.virksomhet VALUES (368, '805145991', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805145991', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.424943', '2023-03-03 08:50:18.424943');
INSERT INTO public.virksomhet VALUES (369, '853879838', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853879838', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.430237', '2023-03-03 08:50:18.430237');
INSERT INTO public.virksomhet VALUES (370, '882939801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882939801', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.435251', '2023-03-03 08:50:18.435251');
INSERT INTO public.virksomhet VALUES (371, '859605190', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859605190', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.440136', '2023-03-03 08:50:18.440136');
INSERT INTO public.virksomhet VALUES (372, '891814367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891814367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.444937', '2023-03-03 08:50:18.444937');
INSERT INTO public.virksomhet VALUES (373, '875021136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875021136', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.449757', '2023-03-03 08:50:18.449757');
INSERT INTO public.virksomhet VALUES (374, '825379831', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825379831', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.454817', '2023-03-03 08:50:18.454817');
INSERT INTO public.virksomhet VALUES (375, '800469195', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800469195', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.459653', '2023-03-03 08:50:18.459653');
INSERT INTO public.virksomhet VALUES (376, '871244244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871244244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.464831', '2023-03-03 08:50:18.464831');
INSERT INTO public.virksomhet VALUES (377, '837133219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837133219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.470201', '2023-03-03 08:50:18.470201');
INSERT INTO public.virksomhet VALUES (378, '855964219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855964219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.475433', '2023-03-03 08:50:18.475433');
INSERT INTO public.virksomhet VALUES (379, '838273484', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838273484', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.480731', '2023-03-03 08:50:18.480731');
INSERT INTO public.virksomhet VALUES (380, '893483616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893483616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.485451', '2023-03-03 08:50:18.485451');
INSERT INTO public.virksomhet VALUES (381, '891497759', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891497759', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.490897', '2023-03-03 08:50:18.490897');
INSERT INTO public.virksomhet VALUES (382, '888247901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888247901', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.495595', '2023-03-03 08:50:18.495595');
INSERT INTO public.virksomhet VALUES (383, '883590490', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883590490', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.500609', '2023-03-03 08:50:18.500609');
INSERT INTO public.virksomhet VALUES (384, '804908767', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804908767', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.505861', '2023-03-03 08:50:18.505861');
INSERT INTO public.virksomhet VALUES (385, '851919134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851919134', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.512016', '2023-03-03 08:50:18.512016');
INSERT INTO public.virksomhet VALUES (386, '813682750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813682750', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.516677', '2023-03-03 08:50:18.516677');
INSERT INTO public.virksomhet VALUES (387, '875544956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875544956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.522274', '2023-03-03 08:50:18.522274');
INSERT INTO public.virksomhet VALUES (388, '889472231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889472231', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.527149', '2023-03-03 08:50:18.527149');
INSERT INTO public.virksomhet VALUES (389, '875631634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875631634', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.531933', '2023-03-03 08:50:18.531933');
INSERT INTO public.virksomhet VALUES (390, '856007783', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856007783', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.537276', '2023-03-03 08:50:18.537276');
INSERT INTO public.virksomhet VALUES (391, '844760467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844760467', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.544907', '2023-03-03 08:50:18.544907');
INSERT INTO public.virksomhet VALUES (392, '863256691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863256691', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.553956', '2023-03-03 08:50:18.553956');
INSERT INTO public.virksomhet VALUES (393, '851705582', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851705582', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.560644', '2023-03-03 08:50:18.560644');
INSERT INTO public.virksomhet VALUES (394, '854298834', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854298834', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.565412', '2023-03-03 08:50:18.565412');
INSERT INTO public.virksomhet VALUES (395, '836216435', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836216435', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.569748', '2023-03-03 08:50:18.569748');
INSERT INTO public.virksomhet VALUES (396, '893017297', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893017297', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.57427', '2023-03-03 08:50:18.57427');
INSERT INTO public.virksomhet VALUES (397, '841372032', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841372032', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.578224', '2023-03-03 08:50:18.578224');
INSERT INTO public.virksomhet VALUES (398, '862589424', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862589424', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.582464', '2023-03-03 08:50:18.582464');
INSERT INTO public.virksomhet VALUES (399, '871501781', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871501781', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.586759', '2023-03-03 08:50:18.586759');
INSERT INTO public.virksomhet VALUES (400, '880977356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880977356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.596636', '2023-03-03 08:50:18.596636');
INSERT INTO public.virksomhet VALUES (401, '859708655', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859708655', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.605253', '2023-03-03 08:50:18.605253');
INSERT INTO public.virksomhet VALUES (402, '837130075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837130075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.61219', '2023-03-03 08:50:18.61219');
INSERT INTO public.virksomhet VALUES (403, '803170681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803170681', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.617213', '2023-03-03 08:50:18.617213');
INSERT INTO public.virksomhet VALUES (404, '875018446', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875018446', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.62167', '2023-03-03 08:50:18.62167');
INSERT INTO public.virksomhet VALUES (405, '872251225', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872251225', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.626284', '2023-03-03 08:50:18.626284');
INSERT INTO public.virksomhet VALUES (406, '889927472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889927472', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.631036', '2023-03-03 08:50:18.631036');
INSERT INTO public.virksomhet VALUES (407, '850310272', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850310272', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.635288', '2023-03-03 08:50:18.635288');
INSERT INTO public.virksomhet VALUES (408, '878277970', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878277970', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.639412', '2023-03-03 08:50:18.639412');
INSERT INTO public.virksomhet VALUES (409, '811324382', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811324382', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.643893', '2023-03-03 08:50:18.643893');
INSERT INTO public.virksomhet VALUES (410, '878265174', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878265174', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.648204', '2023-03-03 08:50:18.648204');
INSERT INTO public.virksomhet VALUES (411, '803799726', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803799726', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.652467', '2023-03-03 08:50:18.652467');
INSERT INTO public.virksomhet VALUES (412, '827344157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827344157', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.6565', '2023-03-03 08:50:18.6565');
INSERT INTO public.virksomhet VALUES (413, '868610918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868610918', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.660752', '2023-03-03 08:50:18.660752');
INSERT INTO public.virksomhet VALUES (414, '891144647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891144647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.665026', '2023-03-03 08:50:18.665026');
INSERT INTO public.virksomhet VALUES (415, '874750888', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874750888', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.669672', '2023-03-03 08:50:18.669672');
INSERT INTO public.virksomhet VALUES (416, '879572863', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879572863', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.675225', '2023-03-03 08:50:18.675225');
INSERT INTO public.virksomhet VALUES (417, '816719384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816719384', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.679947', '2023-03-03 08:50:18.679947');
INSERT INTO public.virksomhet VALUES (418, '823372812', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823372812', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.684094', '2023-03-03 08:50:18.684094');
INSERT INTO public.virksomhet VALUES (419, '872671153', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872671153', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.688336', '2023-03-03 08:50:18.688336');
INSERT INTO public.virksomhet VALUES (420, '837782686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837782686', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.692573', '2023-03-03 08:50:18.692573');
INSERT INTO public.virksomhet VALUES (421, '856373244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856373244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.697226', '2023-03-03 08:50:18.697226');
INSERT INTO public.virksomhet VALUES (422, '802319687', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802319687', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.701385', '2023-03-03 08:50:18.701385');
INSERT INTO public.virksomhet VALUES (423, '882221112', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882221112', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.706183', '2023-03-03 08:50:18.706183');
INSERT INTO public.virksomhet VALUES (424, '825823538', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825823538', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.710829', '2023-03-03 08:50:18.710829');
INSERT INTO public.virksomhet VALUES (425, '840744367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840744367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.715248', '2023-03-03 08:50:18.715248');
INSERT INTO public.virksomhet VALUES (426, '807485242', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807485242', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.719195', '2023-03-03 08:50:18.719195');
INSERT INTO public.virksomhet VALUES (427, '878321914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878321914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.723536', '2023-03-03 08:50:18.723536');
INSERT INTO public.virksomhet VALUES (428, '886892017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886892017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.727822', '2023-03-03 08:50:18.727822');
INSERT INTO public.virksomhet VALUES (429, '871623349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871623349', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.732462', '2023-03-03 08:50:18.732462');
INSERT INTO public.virksomhet VALUES (430, '864986459', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864986459', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.737402', '2023-03-03 08:50:18.737402');
INSERT INTO public.virksomhet VALUES (431, '849227492', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849227492', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.742024', '2023-03-03 08:50:18.742024');
INSERT INTO public.virksomhet VALUES (432, '850910144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850910144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.746538', '2023-03-03 08:50:18.746538');
INSERT INTO public.virksomhet VALUES (433, '869658223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869658223', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.750424', '2023-03-03 08:50:18.750424');
INSERT INTO public.virksomhet VALUES (434, '866431270', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866431270', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.754321', '2023-03-03 08:50:18.754321');
INSERT INTO public.virksomhet VALUES (435, '858356342', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858356342', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.758915', '2023-03-03 08:50:18.758915');
INSERT INTO public.virksomhet VALUES (436, '852467356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852467356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.763221', '2023-03-03 08:50:18.763221');
INSERT INTO public.virksomhet VALUES (437, '898657961', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898657961', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.767494', '2023-03-03 08:50:18.767494');
INSERT INTO public.virksomhet VALUES (438, '846849579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846849579', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.771556', '2023-03-03 08:50:18.771556');
INSERT INTO public.virksomhet VALUES (439, '873579899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873579899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.77577', '2023-03-03 08:50:18.77577');
INSERT INTO public.virksomhet VALUES (440, '843035298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843035298', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.780258', '2023-03-03 08:50:18.780258');
INSERT INTO public.virksomhet VALUES (441, '858836952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858836952', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.784652', '2023-03-03 08:50:18.784652');
INSERT INTO public.virksomhet VALUES (442, '805709917', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805709917', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.788801', '2023-03-03 08:50:18.788801');
INSERT INTO public.virksomhet VALUES (443, '808479485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808479485', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.792984', '2023-03-03 08:50:18.792984');
INSERT INTO public.virksomhet VALUES (444, '838878962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838878962', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.797168', '2023-03-03 08:50:18.797168');
INSERT INTO public.virksomhet VALUES (445, '885625328', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885625328', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.801086', '2023-03-03 08:50:18.801086');
INSERT INTO public.virksomhet VALUES (446, '837527996', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837527996', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.805643', '2023-03-03 08:50:18.805643');
INSERT INTO public.virksomhet VALUES (447, '844848494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844848494', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.810932', '2023-03-03 08:50:18.810932');
INSERT INTO public.virksomhet VALUES (448, '825573136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825573136', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.81603', '2023-03-03 08:50:18.81603');
INSERT INTO public.virksomhet VALUES (449, '809036318', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809036318', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.820683', '2023-03-03 08:50:18.820683');
INSERT INTO public.virksomhet VALUES (450, '800223332', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800223332', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.825398', '2023-03-03 08:50:18.825398');
INSERT INTO public.virksomhet VALUES (451, '878112453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878112453', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.830728', '2023-03-03 08:50:18.830728');
INSERT INTO public.virksomhet VALUES (452, '893781546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893781546', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.835528', '2023-03-03 08:50:18.835528');
INSERT INTO public.virksomhet VALUES (453, '818658010', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818658010', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.840303', '2023-03-03 08:50:18.840303');
INSERT INTO public.virksomhet VALUES (454, '862270603', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862270603', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.845489', '2023-03-03 08:50:18.845489');
INSERT INTO public.virksomhet VALUES (455, '812325897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812325897', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.849979', '2023-03-03 08:50:18.849979');
INSERT INTO public.virksomhet VALUES (456, '817554736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817554736', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.854637', '2023-03-03 08:50:18.854637');
INSERT INTO public.virksomhet VALUES (457, '884291457', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884291457', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.859035', '2023-03-03 08:50:18.859035');
INSERT INTO public.virksomhet VALUES (458, '890910485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890910485', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.863626', '2023-03-03 08:50:18.863626');
INSERT INTO public.virksomhet VALUES (459, '810677960', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810677960', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.868032', '2023-03-03 08:50:18.868032');
INSERT INTO public.virksomhet VALUES (460, '830621787', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830621787', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.872619', '2023-03-03 08:50:18.872619');
INSERT INTO public.virksomhet VALUES (461, '874792210', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874792210', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.876945', '2023-03-03 08:50:18.876945');
INSERT INTO public.virksomhet VALUES (462, '828718942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828718942', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.881916', '2023-03-03 08:50:18.881916');
INSERT INTO public.virksomhet VALUES (463, '846277869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846277869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.886593', '2023-03-03 08:50:18.886593');
INSERT INTO public.virksomhet VALUES (464, '809316543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809316543', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.890919', '2023-03-03 08:50:18.890919');
INSERT INTO public.virksomhet VALUES (465, '846821438', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846821438', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.89542', '2023-03-03 08:50:18.89542');
INSERT INTO public.virksomhet VALUES (466, '836005340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836005340', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.899775', '2023-03-03 08:50:18.899775');
INSERT INTO public.virksomhet VALUES (467, '869069081', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869069081', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.903926', '2023-03-03 08:50:18.903926');
INSERT INTO public.virksomhet VALUES (468, '824870495', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824870495', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.908152', '2023-03-03 08:50:18.908152');
INSERT INTO public.virksomhet VALUES (469, '821850314', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821850314', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.91269', '2023-03-03 08:50:18.91269');
INSERT INTO public.virksomhet VALUES (470, '895629317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895629317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.916858', '2023-03-03 08:50:18.916858');
INSERT INTO public.virksomhet VALUES (471, '854843256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854843256', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.921318', '2023-03-03 08:50:18.921318');
INSERT INTO public.virksomhet VALUES (472, '825397589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825397589', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.926115', '2023-03-03 08:50:18.926115');
INSERT INTO public.virksomhet VALUES (473, '856901774', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856901774', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.93057', '2023-03-03 08:50:18.93057');
INSERT INTO public.virksomhet VALUES (474, '886566656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886566656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.934811', '2023-03-03 08:50:18.934811');
INSERT INTO public.virksomhet VALUES (475, '868634250', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868634250', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.939563', '2023-03-03 08:50:18.939563');
INSERT INTO public.virksomhet VALUES (476, '827178297', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827178297', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.944752', '2023-03-03 08:50:18.944752');
INSERT INTO public.virksomhet VALUES (477, '889901026', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889901026', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.949178', '2023-03-03 08:50:18.949178');
INSERT INTO public.virksomhet VALUES (478, '860932226', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860932226', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.953584', '2023-03-03 08:50:18.953584');
INSERT INTO public.virksomhet VALUES (479, '883640440', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883640440', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.957644', '2023-03-03 08:50:18.957644');
INSERT INTO public.virksomhet VALUES (480, '899511765', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899511765', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.961791', '2023-03-03 08:50:18.961791');
INSERT INTO public.virksomhet VALUES (481, '826671551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826671551', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.966639', '2023-03-03 08:50:18.966639');
INSERT INTO public.virksomhet VALUES (482, '838991015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838991015', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.970548', '2023-03-03 08:50:18.970548');
INSERT INTO public.virksomhet VALUES (483, '831768843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831768843', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.975002', '2023-03-03 08:50:18.975002');
INSERT INTO public.virksomhet VALUES (484, '803324193', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803324193', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.979462', '2023-03-03 08:50:18.979462');
INSERT INTO public.virksomhet VALUES (485, '827269180', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827269180', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.983251', '2023-03-03 08:50:18.983251');
INSERT INTO public.virksomhet VALUES (486, '806938796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806938796', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.987155', '2023-03-03 08:50:18.987155');
INSERT INTO public.virksomhet VALUES (487, '817130185', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817130185', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.990965', '2023-03-03 08:50:18.990965');
INSERT INTO public.virksomhet VALUES (488, '810402680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810402680', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.994926', '2023-03-03 08:50:18.994926');
INSERT INTO public.virksomhet VALUES (489, '887841956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887841956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:18.998736', '2023-03-03 08:50:18.998736');
INSERT INTO public.virksomhet VALUES (490, '897336611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897336611', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.002728', '2023-03-03 08:50:19.002728');
INSERT INTO public.virksomhet VALUES (491, '858728795', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858728795', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.007491', '2023-03-03 08:50:19.007491');
INSERT INTO public.virksomhet VALUES (492, '880050743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880050743', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.012936', '2023-03-03 08:50:19.012936');
INSERT INTO public.virksomhet VALUES (493, '871161662', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871161662', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.017596', '2023-03-03 08:50:19.017596');
INSERT INTO public.virksomhet VALUES (494, '862924848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862924848', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.021882', '2023-03-03 08:50:19.021882');
INSERT INTO public.virksomhet VALUES (495, '895031114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895031114', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.027106', '2023-03-03 08:50:19.027106');
INSERT INTO public.virksomhet VALUES (496, '815517829', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815517829', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.031725', '2023-03-03 08:50:19.031725');
INSERT INTO public.virksomhet VALUES (497, '836666246', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836666246', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.037633', '2023-03-03 08:50:19.037633');
INSERT INTO public.virksomhet VALUES (498, '845715533', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845715533', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.042369', '2023-03-03 08:50:19.042369');
INSERT INTO public.virksomhet VALUES (499, '897156462', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897156462', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.04744', '2023-03-03 08:50:19.04744');
INSERT INTO public.virksomhet VALUES (500, '890815244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890815244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.052094', '2023-03-03 08:50:19.052094');
INSERT INTO public.virksomhet VALUES (501, '866562589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866562589', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.059981', '2023-03-03 08:50:19.059981');
INSERT INTO public.virksomhet VALUES (502, '875322390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875322390', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.065425', '2023-03-03 08:50:19.065425');
INSERT INTO public.virksomhet VALUES (503, '870376312', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870376312', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.069863', '2023-03-03 08:50:19.069863');
INSERT INTO public.virksomhet VALUES (504, '863074238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863074238', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.075202', '2023-03-03 08:50:19.075202');
INSERT INTO public.virksomhet VALUES (505, '873535604', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873535604', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.081882', '2023-03-03 08:50:19.081882');
INSERT INTO public.virksomhet VALUES (506, '820029647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820029647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.086012', '2023-03-03 08:50:19.086012');
INSERT INTO public.virksomhet VALUES (507, '825514130', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825514130', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.089975', '2023-03-03 08:50:19.089975');
INSERT INTO public.virksomhet VALUES (508, '815801592', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815801592', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.094278', '2023-03-03 08:50:19.094278');
INSERT INTO public.virksomhet VALUES (509, '839528084', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839528084', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.098245', '2023-03-03 08:50:19.098245');
INSERT INTO public.virksomhet VALUES (510, '864571830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864571830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:19.1021', '2023-03-03 08:50:19.1021');
INSERT INTO public.virksomhet VALUES (511, '883989256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883989256', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-03-03 08:50:24.954961', '2023-03-03 08:50:24.954961');
INSERT INTO public.virksomhet VALUES (512, '831272011', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '110272138 nvaN', '{adresse}', 'AKTIV', NULL, 831272012, '2023-03-03 08:50:24.963878', '2023-03-03 08:50:30.208189');
INSERT INTO public.virksomhet VALUES (513, '831658088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '880856138 nvaN', '{adresse}', 'AKTIV', NULL, 831658089, '2023-03-03 08:50:24.973626', '2023-03-03 08:50:30.222738');
INSERT INTO public.virksomhet VALUES (514, '802008121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '121800208 nvaN', '{adresse}', 'AKTIV', NULL, 802008122, '2023-03-03 08:50:24.980709', '2023-03-03 08:50:30.231571');
INSERT INTO public.virksomhet VALUES (515, '857721878', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '878127758 nvaN', '{adresse}', 'AKTIV', NULL, 857721879, '2023-03-03 08:50:24.98855', '2023-03-03 08:50:30.237673');
INSERT INTO public.virksomhet VALUES (516, '811747377', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '773747118 nvaN', '{adresse}', 'AKTIV', NULL, 811747378, '2023-03-03 08:50:24.994943', '2023-03-03 08:50:30.246508');
INSERT INTO public.virksomhet VALUES (527, '854032309', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '903230458 nvaN', '{adresse}', 'AKTIV', NULL, 854032310, '2023-03-03 08:50:25.087288', '2023-03-03 08:50:30.253028');
INSERT INTO public.virksomhet VALUES (517, '801396893', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801396893', '{adresse}', 'FJERNET', '2010-07-01', 801396894, '2023-03-03 08:50:25.002823', '2023-03-03 08:50:30.256496');
INSERT INTO public.virksomhet VALUES (518, '885133950', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885133950', '{adresse}', 'FJERNET', '2010-07-01', 885133951, '2023-03-03 08:50:25.009327', '2023-03-03 08:50:30.257908');
INSERT INTO public.virksomhet VALUES (519, '864761302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864761302', '{adresse}', 'FJERNET', '2010-07-01', 864761303, '2023-03-03 08:50:25.018289', '2023-03-03 08:50:30.259375');
INSERT INTO public.virksomhet VALUES (520, '870050263', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870050263', '{adresse}', 'FJERNET', '2010-07-01', 870050264, '2023-03-03 08:50:25.027622', '2023-03-03 08:50:30.262538');
INSERT INTO public.virksomhet VALUES (521, '881536611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881536611', '{adresse}', 'FJERNET', '2010-07-01', 881536612, '2023-03-03 08:50:25.035516', '2023-03-03 08:50:30.264237');
INSERT INTO public.virksomhet VALUES (522, '862811969', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862811969', '{adresse}', 'SLETTET', '2010-07-01', 862811970, '2023-03-03 08:50:25.041356', '2023-03-03 08:50:30.266572');
INSERT INTO public.virksomhet VALUES (523, '892708443', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892708443', '{adresse}', 'SLETTET', '2010-07-01', 892708444, '2023-03-03 08:50:25.050423', '2023-03-03 08:50:30.268067');
INSERT INTO public.virksomhet VALUES (524, '866931781', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866931781', '{adresse}', 'SLETTET', '2010-07-01', 866931782, '2023-03-03 08:50:25.061111', '2023-03-03 08:50:30.26975');
INSERT INTO public.virksomhet VALUES (525, '868378133', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868378133', '{adresse}', 'SLETTET', '2010-07-01', 868378134, '2023-03-03 08:50:25.069857', '2023-03-03 08:50:30.272378');
INSERT INTO public.virksomhet VALUES (526, '872308278', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872308278', '{adresse}', 'SLETTET', '2010-07-01', 872308279, '2023-03-03 08:50:25.078096', '2023-03-03 08:50:30.276546');
INSERT INTO public.virksomhet VALUES (534, '854620752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854620752', '{adresse}', 'AKTIV', NULL, 854620753, '2023-03-03 08:50:30.316257', '2023-03-03 08:50:30.316257');
INSERT INTO public.virksomhet VALUES (535, '813662974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813662974', '{adresse}', 'AKTIV', NULL, 813662975, '2023-03-03 08:50:30.333946', '2023-03-03 08:50:30.333946');
INSERT INTO public.virksomhet VALUES (536, '877870510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877870510', '{adresse}', 'AKTIV', NULL, 877870511, '2023-03-03 08:50:30.337854', '2023-03-03 08:50:30.337854');
INSERT INTO public.virksomhet VALUES (537, '828539481', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828539481', '{adresse}', 'AKTIV', NULL, 828539482, '2023-03-03 08:50:30.342841', '2023-03-03 08:50:30.342841');
INSERT INTO public.virksomhet VALUES (538, '833469738', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833469738', '{adresse}', 'AKTIV', NULL, 833469739, '2023-03-03 08:50:30.347051', '2023-03-03 08:50:30.347051');


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
INSERT INTO public.virksomhet_naring VALUES (7, '90.012');
INSERT INTO public.virksomhet_naring VALUES (7, '70.220');
INSERT INTO public.virksomhet_naring VALUES (8, '01.120');
INSERT INTO public.virksomhet_naring VALUES (8, '90.012');
INSERT INTO public.virksomhet_naring VALUES (8, '70.220');
INSERT INTO public.virksomhet_naring VALUES (9, '01.120');
INSERT INTO public.virksomhet_naring VALUES (10, '01.120');
INSERT INTO public.virksomhet_naring VALUES (10, '90.012');
INSERT INTO public.virksomhet_naring VALUES (11, '01.120');
INSERT INTO public.virksomhet_naring VALUES (12, '01.120');
INSERT INTO public.virksomhet_naring VALUES (12, '90.012');
INSERT INTO public.virksomhet_naring VALUES (12, '70.220');
INSERT INTO public.virksomhet_naring VALUES (13, '01.120');
INSERT INTO public.virksomhet_naring VALUES (14, '01.120');
INSERT INTO public.virksomhet_naring VALUES (15, '01.120');
INSERT INTO public.virksomhet_naring VALUES (16, '01.120');
INSERT INTO public.virksomhet_naring VALUES (17, '01.120');
INSERT INTO public.virksomhet_naring VALUES (18, '01.120');
INSERT INTO public.virksomhet_naring VALUES (18, '90.012');
INSERT INTO public.virksomhet_naring VALUES (18, '70.220');
INSERT INTO public.virksomhet_naring VALUES (19, '01.120');
INSERT INTO public.virksomhet_naring VALUES (19, '90.012');
INSERT INTO public.virksomhet_naring VALUES (19, '70.220');
INSERT INTO public.virksomhet_naring VALUES (20, '01.120');
INSERT INTO public.virksomhet_naring VALUES (21, '01.120');
INSERT INTO public.virksomhet_naring VALUES (22, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '90.012');
INSERT INTO public.virksomhet_naring VALUES (24, '01.120');
INSERT INTO public.virksomhet_naring VALUES (24, '90.012');
INSERT INTO public.virksomhet_naring VALUES (25, '01.120');
INSERT INTO public.virksomhet_naring VALUES (26, '01.120');
INSERT INTO public.virksomhet_naring VALUES (27, '01.120');
INSERT INTO public.virksomhet_naring VALUES (27, '90.012');
INSERT INTO public.virksomhet_naring VALUES (28, '01.120');
INSERT INTO public.virksomhet_naring VALUES (28, '90.012');
INSERT INTO public.virksomhet_naring VALUES (29, '01.120');
INSERT INTO public.virksomhet_naring VALUES (30, '01.120');
INSERT INTO public.virksomhet_naring VALUES (30, '90.012');
INSERT INTO public.virksomhet_naring VALUES (31, '01.120');
INSERT INTO public.virksomhet_naring VALUES (31, '90.012');
INSERT INTO public.virksomhet_naring VALUES (32, '01.120');
INSERT INTO public.virksomhet_naring VALUES (32, '90.012');
INSERT INTO public.virksomhet_naring VALUES (33, '01.120');
INSERT INTO public.virksomhet_naring VALUES (34, '01.120');
INSERT INTO public.virksomhet_naring VALUES (35, '01.120');
INSERT INTO public.virksomhet_naring VALUES (36, '01.120');
INSERT INTO public.virksomhet_naring VALUES (37, '01.120');
INSERT INTO public.virksomhet_naring VALUES (37, '90.012');
INSERT INTO public.virksomhet_naring VALUES (37, '70.220');
INSERT INTO public.virksomhet_naring VALUES (38, '01.120');
INSERT INTO public.virksomhet_naring VALUES (39, '01.120');
INSERT INTO public.virksomhet_naring VALUES (39, '90.012');
INSERT INTO public.virksomhet_naring VALUES (39, '70.220');
INSERT INTO public.virksomhet_naring VALUES (40, '01.120');
INSERT INTO public.virksomhet_naring VALUES (40, '90.012');
INSERT INTO public.virksomhet_naring VALUES (41, '01.120');
INSERT INTO public.virksomhet_naring VALUES (42, '01.120');
INSERT INTO public.virksomhet_naring VALUES (42, '90.012');
INSERT INTO public.virksomhet_naring VALUES (42, '70.220');
INSERT INTO public.virksomhet_naring VALUES (43, '01.120');
INSERT INTO public.virksomhet_naring VALUES (44, '01.120');
INSERT INTO public.virksomhet_naring VALUES (45, '01.120');
INSERT INTO public.virksomhet_naring VALUES (45, '90.012');
INSERT INTO public.virksomhet_naring VALUES (46, '01.120');
INSERT INTO public.virksomhet_naring VALUES (47, '01.120');
INSERT INTO public.virksomhet_naring VALUES (47, '90.012');
INSERT INTO public.virksomhet_naring VALUES (48, '01.120');
INSERT INTO public.virksomhet_naring VALUES (48, '90.012');
INSERT INTO public.virksomhet_naring VALUES (49, '01.120');
INSERT INTO public.virksomhet_naring VALUES (49, '90.012');
INSERT INTO public.virksomhet_naring VALUES (50, '01.120');
INSERT INTO public.virksomhet_naring VALUES (50, '90.012');
INSERT INTO public.virksomhet_naring VALUES (50, '70.220');
INSERT INTO public.virksomhet_naring VALUES (51, '01.120');
INSERT INTO public.virksomhet_naring VALUES (52, '01.120');
INSERT INTO public.virksomhet_naring VALUES (53, '01.120');
INSERT INTO public.virksomhet_naring VALUES (54, '01.120');
INSERT INTO public.virksomhet_naring VALUES (54, '90.012');
INSERT INTO public.virksomhet_naring VALUES (55, '01.120');
INSERT INTO public.virksomhet_naring VALUES (55, '90.012');
INSERT INTO public.virksomhet_naring VALUES (56, '01.120');
INSERT INTO public.virksomhet_naring VALUES (56, '90.012');
INSERT INTO public.virksomhet_naring VALUES (57, '01.120');
INSERT INTO public.virksomhet_naring VALUES (57, '90.012');
INSERT INTO public.virksomhet_naring VALUES (58, '01.120');
INSERT INTO public.virksomhet_naring VALUES (59, '01.120');
INSERT INTO public.virksomhet_naring VALUES (60, '01.120');
INSERT INTO public.virksomhet_naring VALUES (61, '01.120');
INSERT INTO public.virksomhet_naring VALUES (61, '90.012');
INSERT INTO public.virksomhet_naring VALUES (61, '70.220');
INSERT INTO public.virksomhet_naring VALUES (62, '01.120');
INSERT INTO public.virksomhet_naring VALUES (62, '90.012');
INSERT INTO public.virksomhet_naring VALUES (63, '01.120');
INSERT INTO public.virksomhet_naring VALUES (64, '01.120');
INSERT INTO public.virksomhet_naring VALUES (65, '01.120');
INSERT INTO public.virksomhet_naring VALUES (65, '90.012');
INSERT INTO public.virksomhet_naring VALUES (66, '01.120');
INSERT INTO public.virksomhet_naring VALUES (66, '90.012');
INSERT INTO public.virksomhet_naring VALUES (67, '01.120');
INSERT INTO public.virksomhet_naring VALUES (67, '90.012');
INSERT INTO public.virksomhet_naring VALUES (68, '01.120');
INSERT INTO public.virksomhet_naring VALUES (69, '01.120');
INSERT INTO public.virksomhet_naring VALUES (69, '90.012');
INSERT INTO public.virksomhet_naring VALUES (70, '01.120');
INSERT INTO public.virksomhet_naring VALUES (71, '01.120');
INSERT INTO public.virksomhet_naring VALUES (72, '01.120');
INSERT INTO public.virksomhet_naring VALUES (72, '90.012');
INSERT INTO public.virksomhet_naring VALUES (73, '01.120');
INSERT INTO public.virksomhet_naring VALUES (74, '01.120');
INSERT INTO public.virksomhet_naring VALUES (75, '01.120');
INSERT INTO public.virksomhet_naring VALUES (75, '90.012');
INSERT INTO public.virksomhet_naring VALUES (76, '01.120');
INSERT INTO public.virksomhet_naring VALUES (77, '01.120');
INSERT INTO public.virksomhet_naring VALUES (78, '01.120');
INSERT INTO public.virksomhet_naring VALUES (79, '01.120');
INSERT INTO public.virksomhet_naring VALUES (79, '90.012');
INSERT INTO public.virksomhet_naring VALUES (79, '70.220');
INSERT INTO public.virksomhet_naring VALUES (80, '01.120');
INSERT INTO public.virksomhet_naring VALUES (80, '90.012');
INSERT INTO public.virksomhet_naring VALUES (80, '70.220');
INSERT INTO public.virksomhet_naring VALUES (81, '01.120');
INSERT INTO public.virksomhet_naring VALUES (81, '90.012');
INSERT INTO public.virksomhet_naring VALUES (82, '01.120');
INSERT INTO public.virksomhet_naring VALUES (82, '90.012');
INSERT INTO public.virksomhet_naring VALUES (82, '70.220');
INSERT INTO public.virksomhet_naring VALUES (83, '01.120');
INSERT INTO public.virksomhet_naring VALUES (84, '01.120');
INSERT INTO public.virksomhet_naring VALUES (85, '01.120');
INSERT INTO public.virksomhet_naring VALUES (86, '01.120');
INSERT INTO public.virksomhet_naring VALUES (87, '01.120');
INSERT INTO public.virksomhet_naring VALUES (87, '90.012');
INSERT INTO public.virksomhet_naring VALUES (88, '01.120');
INSERT INTO public.virksomhet_naring VALUES (89, '01.120');
INSERT INTO public.virksomhet_naring VALUES (89, '90.012');
INSERT INTO public.virksomhet_naring VALUES (89, '70.220');
INSERT INTO public.virksomhet_naring VALUES (90, '01.120');
INSERT INTO public.virksomhet_naring VALUES (90, '90.012');
INSERT INTO public.virksomhet_naring VALUES (90, '70.220');
INSERT INTO public.virksomhet_naring VALUES (91, '01.120');
INSERT INTO public.virksomhet_naring VALUES (92, '01.120');
INSERT INTO public.virksomhet_naring VALUES (93, '01.120');
INSERT INTO public.virksomhet_naring VALUES (94, '01.120');
INSERT INTO public.virksomhet_naring VALUES (94, '90.012');
INSERT INTO public.virksomhet_naring VALUES (95, '01.120');
INSERT INTO public.virksomhet_naring VALUES (96, '01.120');
INSERT INTO public.virksomhet_naring VALUES (97, '01.120');
INSERT INTO public.virksomhet_naring VALUES (98, '01.120');
INSERT INTO public.virksomhet_naring VALUES (99, '01.120');
INSERT INTO public.virksomhet_naring VALUES (99, '90.012');
INSERT INTO public.virksomhet_naring VALUES (100, '01.120');
INSERT INTO public.virksomhet_naring VALUES (101, '01.120');
INSERT INTO public.virksomhet_naring VALUES (102, '01.120');
INSERT INTO public.virksomhet_naring VALUES (103, '01.120');
INSERT INTO public.virksomhet_naring VALUES (104, '01.120');
INSERT INTO public.virksomhet_naring VALUES (104, '90.012');
INSERT INTO public.virksomhet_naring VALUES (105, '01.120');
INSERT INTO public.virksomhet_naring VALUES (105, '90.012');
INSERT INTO public.virksomhet_naring VALUES (105, '70.220');
INSERT INTO public.virksomhet_naring VALUES (106, '01.120');
INSERT INTO public.virksomhet_naring VALUES (107, '01.120');
INSERT INTO public.virksomhet_naring VALUES (107, '90.012');
INSERT INTO public.virksomhet_naring VALUES (108, '01.120');
INSERT INTO public.virksomhet_naring VALUES (108, '90.012');
INSERT INTO public.virksomhet_naring VALUES (109, '01.120');
INSERT INTO public.virksomhet_naring VALUES (109, '90.012');
INSERT INTO public.virksomhet_naring VALUES (110, '01.120');
INSERT INTO public.virksomhet_naring VALUES (111, '01.120');
INSERT INTO public.virksomhet_naring VALUES (112, '01.120');
INSERT INTO public.virksomhet_naring VALUES (113, '01.120');
INSERT INTO public.virksomhet_naring VALUES (113, '90.012');
INSERT INTO public.virksomhet_naring VALUES (114, '01.120');
INSERT INTO public.virksomhet_naring VALUES (115, '01.120');
INSERT INTO public.virksomhet_naring VALUES (115, '90.012');
INSERT INTO public.virksomhet_naring VALUES (116, '01.120');
INSERT INTO public.virksomhet_naring VALUES (117, '01.120');
INSERT INTO public.virksomhet_naring VALUES (118, '01.120');
INSERT INTO public.virksomhet_naring VALUES (118, '90.012');
INSERT INTO public.virksomhet_naring VALUES (119, '01.120');
INSERT INTO public.virksomhet_naring VALUES (119, '90.012');
INSERT INTO public.virksomhet_naring VALUES (120, '01.120');
INSERT INTO public.virksomhet_naring VALUES (121, '01.120');
INSERT INTO public.virksomhet_naring VALUES (122, '01.120');
INSERT INTO public.virksomhet_naring VALUES (123, '01.120');
INSERT INTO public.virksomhet_naring VALUES (123, '90.012');
INSERT INTO public.virksomhet_naring VALUES (124, '01.120');
INSERT INTO public.virksomhet_naring VALUES (125, '01.120');
INSERT INTO public.virksomhet_naring VALUES (126, '01.120');
INSERT INTO public.virksomhet_naring VALUES (126, '90.012');
INSERT INTO public.virksomhet_naring VALUES (127, '01.120');
INSERT INTO public.virksomhet_naring VALUES (127, '90.012');
INSERT INTO public.virksomhet_naring VALUES (128, '01.120');
INSERT INTO public.virksomhet_naring VALUES (129, '01.120');
INSERT INTO public.virksomhet_naring VALUES (130, '01.120');
INSERT INTO public.virksomhet_naring VALUES (130, '90.012');
INSERT INTO public.virksomhet_naring VALUES (131, '01.120');
INSERT INTO public.virksomhet_naring VALUES (132, '01.120');
INSERT INTO public.virksomhet_naring VALUES (133, '01.120');
INSERT INTO public.virksomhet_naring VALUES (134, '01.120');
INSERT INTO public.virksomhet_naring VALUES (134, '90.012');
INSERT INTO public.virksomhet_naring VALUES (135, '01.120');
INSERT INTO public.virksomhet_naring VALUES (135, '90.012');
INSERT INTO public.virksomhet_naring VALUES (135, '70.220');
INSERT INTO public.virksomhet_naring VALUES (136, '01.120');
INSERT INTO public.virksomhet_naring VALUES (137, '01.120');
INSERT INTO public.virksomhet_naring VALUES (138, '01.120');
INSERT INTO public.virksomhet_naring VALUES (138, '90.012');
INSERT INTO public.virksomhet_naring VALUES (138, '70.220');
INSERT INTO public.virksomhet_naring VALUES (139, '01.120');
INSERT INTO public.virksomhet_naring VALUES (139, '90.012');
INSERT INTO public.virksomhet_naring VALUES (139, '70.220');
INSERT INTO public.virksomhet_naring VALUES (140, '01.120');
INSERT INTO public.virksomhet_naring VALUES (140, '90.012');
INSERT INTO public.virksomhet_naring VALUES (141, '01.120');
INSERT INTO public.virksomhet_naring VALUES (142, '01.120');
INSERT INTO public.virksomhet_naring VALUES (142, '90.012');
INSERT INTO public.virksomhet_naring VALUES (143, '01.120');
INSERT INTO public.virksomhet_naring VALUES (144, '01.120');
INSERT INTO public.virksomhet_naring VALUES (145, '01.120');
INSERT INTO public.virksomhet_naring VALUES (145, '90.012');
INSERT INTO public.virksomhet_naring VALUES (146, '01.120');
INSERT INTO public.virksomhet_naring VALUES (146, '90.012');
INSERT INTO public.virksomhet_naring VALUES (147, '01.120');
INSERT INTO public.virksomhet_naring VALUES (148, '01.120');
INSERT INTO public.virksomhet_naring VALUES (148, '90.012');
INSERT INTO public.virksomhet_naring VALUES (149, '01.120');
INSERT INTO public.virksomhet_naring VALUES (150, '01.120');
INSERT INTO public.virksomhet_naring VALUES (150, '90.012');
INSERT INTO public.virksomhet_naring VALUES (150, '70.220');
INSERT INTO public.virksomhet_naring VALUES (151, '01.120');
INSERT INTO public.virksomhet_naring VALUES (151, '90.012');
INSERT INTO public.virksomhet_naring VALUES (152, '01.120');
INSERT INTO public.virksomhet_naring VALUES (153, '01.120');
INSERT INTO public.virksomhet_naring VALUES (154, '01.120');
INSERT INTO public.virksomhet_naring VALUES (155, '01.120');
INSERT INTO public.virksomhet_naring VALUES (156, '01.120');
INSERT INTO public.virksomhet_naring VALUES (157, '01.120');
INSERT INTO public.virksomhet_naring VALUES (158, '01.120');
INSERT INTO public.virksomhet_naring VALUES (159, '01.120');
INSERT INTO public.virksomhet_naring VALUES (160, '01.120');
INSERT INTO public.virksomhet_naring VALUES (161, '01.120');
INSERT INTO public.virksomhet_naring VALUES (162, '01.120');
INSERT INTO public.virksomhet_naring VALUES (162, '90.012');
INSERT INTO public.virksomhet_naring VALUES (162, '70.220');
INSERT INTO public.virksomhet_naring VALUES (163, '01.120');
INSERT INTO public.virksomhet_naring VALUES (164, '01.120');
INSERT INTO public.virksomhet_naring VALUES (165, '01.120');
INSERT INTO public.virksomhet_naring VALUES (165, '90.012');
INSERT INTO public.virksomhet_naring VALUES (166, '01.120');
INSERT INTO public.virksomhet_naring VALUES (166, '90.012');
INSERT INTO public.virksomhet_naring VALUES (167, '01.120');
INSERT INTO public.virksomhet_naring VALUES (168, '01.120');
INSERT INTO public.virksomhet_naring VALUES (169, '01.120');
INSERT INTO public.virksomhet_naring VALUES (170, '01.120');
INSERT INTO public.virksomhet_naring VALUES (170, '90.012');
INSERT INTO public.virksomhet_naring VALUES (171, '01.120');
INSERT INTO public.virksomhet_naring VALUES (171, '90.012');
INSERT INTO public.virksomhet_naring VALUES (172, '01.120');
INSERT INTO public.virksomhet_naring VALUES (172, '90.012');
INSERT INTO public.virksomhet_naring VALUES (172, '70.220');
INSERT INTO public.virksomhet_naring VALUES (173, '01.120');
INSERT INTO public.virksomhet_naring VALUES (174, '01.120');
INSERT INTO public.virksomhet_naring VALUES (174, '90.012');
INSERT INTO public.virksomhet_naring VALUES (174, '70.220');
INSERT INTO public.virksomhet_naring VALUES (175, '01.120');
INSERT INTO public.virksomhet_naring VALUES (176, '01.120');
INSERT INTO public.virksomhet_naring VALUES (177, '01.120');
INSERT INTO public.virksomhet_naring VALUES (178, '01.120');
INSERT INTO public.virksomhet_naring VALUES (179, '01.120');
INSERT INTO public.virksomhet_naring VALUES (179, '90.012');
INSERT INTO public.virksomhet_naring VALUES (180, '01.120');
INSERT INTO public.virksomhet_naring VALUES (181, '01.120');
INSERT INTO public.virksomhet_naring VALUES (182, '01.120');
INSERT INTO public.virksomhet_naring VALUES (183, '01.120');
INSERT INTO public.virksomhet_naring VALUES (183, '90.012');
INSERT INTO public.virksomhet_naring VALUES (184, '01.120');
INSERT INTO public.virksomhet_naring VALUES (184, '90.012');
INSERT INTO public.virksomhet_naring VALUES (185, '01.120');
INSERT INTO public.virksomhet_naring VALUES (185, '90.012');
INSERT INTO public.virksomhet_naring VALUES (186, '01.120');
INSERT INTO public.virksomhet_naring VALUES (187, '01.120');
INSERT INTO public.virksomhet_naring VALUES (187, '90.012');
INSERT INTO public.virksomhet_naring VALUES (187, '70.220');
INSERT INTO public.virksomhet_naring VALUES (188, '01.120');
INSERT INTO public.virksomhet_naring VALUES (189, '01.120');
INSERT INTO public.virksomhet_naring VALUES (190, '01.120');
INSERT INTO public.virksomhet_naring VALUES (191, '01.120');
INSERT INTO public.virksomhet_naring VALUES (191, '90.012');
INSERT INTO public.virksomhet_naring VALUES (192, '01.120');
INSERT INTO public.virksomhet_naring VALUES (192, '90.012');
INSERT INTO public.virksomhet_naring VALUES (192, '70.220');
INSERT INTO public.virksomhet_naring VALUES (193, '01.120');
INSERT INTO public.virksomhet_naring VALUES (194, '01.120');
INSERT INTO public.virksomhet_naring VALUES (195, '01.120');
INSERT INTO public.virksomhet_naring VALUES (196, '01.120');
INSERT INTO public.virksomhet_naring VALUES (196, '90.012');
INSERT INTO public.virksomhet_naring VALUES (197, '01.120');
INSERT INTO public.virksomhet_naring VALUES (198, '01.120');
INSERT INTO public.virksomhet_naring VALUES (198, '90.012');
INSERT INTO public.virksomhet_naring VALUES (198, '70.220');
INSERT INTO public.virksomhet_naring VALUES (199, '01.120');
INSERT INTO public.virksomhet_naring VALUES (199, '90.012');
INSERT INTO public.virksomhet_naring VALUES (200, '01.120');
INSERT INTO public.virksomhet_naring VALUES (200, '90.012');
INSERT INTO public.virksomhet_naring VALUES (201, '01.120');
INSERT INTO public.virksomhet_naring VALUES (202, '01.120');
INSERT INTO public.virksomhet_naring VALUES (203, '01.120');
INSERT INTO public.virksomhet_naring VALUES (203, '90.012');
INSERT INTO public.virksomhet_naring VALUES (203, '70.220');
INSERT INTO public.virksomhet_naring VALUES (204, '01.120');
INSERT INTO public.virksomhet_naring VALUES (205, '01.120');
INSERT INTO public.virksomhet_naring VALUES (205, '90.012');
INSERT INTO public.virksomhet_naring VALUES (206, '01.120');
INSERT INTO public.virksomhet_naring VALUES (206, '90.012');
INSERT INTO public.virksomhet_naring VALUES (207, '01.120');
INSERT INTO public.virksomhet_naring VALUES (207, '90.012');
INSERT INTO public.virksomhet_naring VALUES (208, '01.120');
INSERT INTO public.virksomhet_naring VALUES (208, '90.012');
INSERT INTO public.virksomhet_naring VALUES (209, '01.120');
INSERT INTO public.virksomhet_naring VALUES (210, '01.120');
INSERT INTO public.virksomhet_naring VALUES (211, '01.120');
INSERT INTO public.virksomhet_naring VALUES (212, '01.120');
INSERT INTO public.virksomhet_naring VALUES (213, '01.120');
INSERT INTO public.virksomhet_naring VALUES (214, '01.120');
INSERT INTO public.virksomhet_naring VALUES (214, '90.012');
INSERT INTO public.virksomhet_naring VALUES (215, '01.120');
INSERT INTO public.virksomhet_naring VALUES (216, '01.120');
INSERT INTO public.virksomhet_naring VALUES (217, '01.120');
INSERT INTO public.virksomhet_naring VALUES (218, '01.120');
INSERT INTO public.virksomhet_naring VALUES (218, '90.012');
INSERT INTO public.virksomhet_naring VALUES (219, '01.120');
INSERT INTO public.virksomhet_naring VALUES (220, '01.120');
INSERT INTO public.virksomhet_naring VALUES (220, '90.012');
INSERT INTO public.virksomhet_naring VALUES (220, '70.220');
INSERT INTO public.virksomhet_naring VALUES (221, '01.120');
INSERT INTO public.virksomhet_naring VALUES (222, '01.120');
INSERT INTO public.virksomhet_naring VALUES (222, '90.012');
INSERT INTO public.virksomhet_naring VALUES (223, '01.120');
INSERT INTO public.virksomhet_naring VALUES (224, '01.120');
INSERT INTO public.virksomhet_naring VALUES (225, '01.120');
INSERT INTO public.virksomhet_naring VALUES (225, '90.012');
INSERT INTO public.virksomhet_naring VALUES (225, '70.220');
INSERT INTO public.virksomhet_naring VALUES (226, '01.120');
INSERT INTO public.virksomhet_naring VALUES (226, '90.012');
INSERT INTO public.virksomhet_naring VALUES (226, '70.220');
INSERT INTO public.virksomhet_naring VALUES (227, '01.120');
INSERT INTO public.virksomhet_naring VALUES (227, '90.012');
INSERT INTO public.virksomhet_naring VALUES (227, '70.220');
INSERT INTO public.virksomhet_naring VALUES (228, '01.120');
INSERT INTO public.virksomhet_naring VALUES (229, '01.120');
INSERT INTO public.virksomhet_naring VALUES (230, '01.120');
INSERT INTO public.virksomhet_naring VALUES (231, '01.120');
INSERT INTO public.virksomhet_naring VALUES (231, '90.012');
INSERT INTO public.virksomhet_naring VALUES (232, '01.120');
INSERT INTO public.virksomhet_naring VALUES (232, '90.012');
INSERT INTO public.virksomhet_naring VALUES (233, '01.120');
INSERT INTO public.virksomhet_naring VALUES (234, '01.120');
INSERT INTO public.virksomhet_naring VALUES (234, '90.012');
INSERT INTO public.virksomhet_naring VALUES (235, '01.120');
INSERT INTO public.virksomhet_naring VALUES (235, '90.012');
INSERT INTO public.virksomhet_naring VALUES (235, '70.220');
INSERT INTO public.virksomhet_naring VALUES (236, '01.120');
INSERT INTO public.virksomhet_naring VALUES (236, '90.012');
INSERT INTO public.virksomhet_naring VALUES (236, '70.220');
INSERT INTO public.virksomhet_naring VALUES (237, '01.120');
INSERT INTO public.virksomhet_naring VALUES (237, '90.012');
INSERT INTO public.virksomhet_naring VALUES (238, '01.120');
INSERT INTO public.virksomhet_naring VALUES (239, '01.120');
INSERT INTO public.virksomhet_naring VALUES (240, '01.120');
INSERT INTO public.virksomhet_naring VALUES (241, '01.120');
INSERT INTO public.virksomhet_naring VALUES (242, '01.120');
INSERT INTO public.virksomhet_naring VALUES (242, '90.012');
INSERT INTO public.virksomhet_naring VALUES (243, '01.120');
INSERT INTO public.virksomhet_naring VALUES (243, '90.012');
INSERT INTO public.virksomhet_naring VALUES (243, '70.220');
INSERT INTO public.virksomhet_naring VALUES (244, '01.120');
INSERT INTO public.virksomhet_naring VALUES (244, '90.012');
INSERT INTO public.virksomhet_naring VALUES (245, '01.120');
INSERT INTO public.virksomhet_naring VALUES (245, '90.012');
INSERT INTO public.virksomhet_naring VALUES (246, '01.120');
INSERT INTO public.virksomhet_naring VALUES (247, '01.120');
INSERT INTO public.virksomhet_naring VALUES (248, '01.120');
INSERT INTO public.virksomhet_naring VALUES (249, '01.120');
INSERT INTO public.virksomhet_naring VALUES (250, '01.120');
INSERT INTO public.virksomhet_naring VALUES (250, '90.012');
INSERT INTO public.virksomhet_naring VALUES (251, '01.120');
INSERT INTO public.virksomhet_naring VALUES (252, '01.120');
INSERT INTO public.virksomhet_naring VALUES (252, '90.012');
INSERT INTO public.virksomhet_naring VALUES (253, '01.120');
INSERT INTO public.virksomhet_naring VALUES (253, '90.012');
INSERT INTO public.virksomhet_naring VALUES (254, '01.120');
INSERT INTO public.virksomhet_naring VALUES (255, '01.120');
INSERT INTO public.virksomhet_naring VALUES (256, '01.120');
INSERT INTO public.virksomhet_naring VALUES (257, '01.120');
INSERT INTO public.virksomhet_naring VALUES (258, '01.120');
INSERT INTO public.virksomhet_naring VALUES (259, '01.120');
INSERT INTO public.virksomhet_naring VALUES (260, '01.120');
INSERT INTO public.virksomhet_naring VALUES (260, '90.012');
INSERT INTO public.virksomhet_naring VALUES (261, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '90.012');
INSERT INTO public.virksomhet_naring VALUES (262, '01.120');
INSERT INTO public.virksomhet_naring VALUES (263, '01.120');
INSERT INTO public.virksomhet_naring VALUES (264, '01.120');
INSERT INTO public.virksomhet_naring VALUES (264, '90.012');
INSERT INTO public.virksomhet_naring VALUES (265, '01.120');
INSERT INTO public.virksomhet_naring VALUES (265, '90.012');
INSERT INTO public.virksomhet_naring VALUES (266, '01.120');
INSERT INTO public.virksomhet_naring VALUES (266, '90.012');
INSERT INTO public.virksomhet_naring VALUES (266, '70.220');
INSERT INTO public.virksomhet_naring VALUES (267, '01.120');
INSERT INTO public.virksomhet_naring VALUES (268, '01.120');
INSERT INTO public.virksomhet_naring VALUES (269, '01.120');
INSERT INTO public.virksomhet_naring VALUES (270, '01.120');
INSERT INTO public.virksomhet_naring VALUES (271, '01.120');
INSERT INTO public.virksomhet_naring VALUES (271, '90.012');
INSERT INTO public.virksomhet_naring VALUES (272, '01.120');
INSERT INTO public.virksomhet_naring VALUES (273, '01.120');
INSERT INTO public.virksomhet_naring VALUES (273, '90.012');
INSERT INTO public.virksomhet_naring VALUES (273, '70.220');
INSERT INTO public.virksomhet_naring VALUES (274, '01.120');
INSERT INTO public.virksomhet_naring VALUES (274, '90.012');
INSERT INTO public.virksomhet_naring VALUES (275, '01.120');
INSERT INTO public.virksomhet_naring VALUES (275, '90.012');
INSERT INTO public.virksomhet_naring VALUES (276, '01.120');
INSERT INTO public.virksomhet_naring VALUES (276, '90.012');
INSERT INTO public.virksomhet_naring VALUES (276, '70.220');
INSERT INTO public.virksomhet_naring VALUES (277, '01.120');
INSERT INTO public.virksomhet_naring VALUES (277, '90.012');
INSERT INTO public.virksomhet_naring VALUES (278, '01.120');
INSERT INTO public.virksomhet_naring VALUES (279, '01.120');
INSERT INTO public.virksomhet_naring VALUES (280, '01.120');
INSERT INTO public.virksomhet_naring VALUES (280, '90.012');
INSERT INTO public.virksomhet_naring VALUES (281, '01.120');
INSERT INTO public.virksomhet_naring VALUES (282, '01.120');
INSERT INTO public.virksomhet_naring VALUES (282, '90.012');
INSERT INTO public.virksomhet_naring VALUES (283, '01.120');
INSERT INTO public.virksomhet_naring VALUES (283, '90.012');
INSERT INTO public.virksomhet_naring VALUES (284, '01.120');
INSERT INTO public.virksomhet_naring VALUES (285, '01.120');
INSERT INTO public.virksomhet_naring VALUES (286, '01.120');
INSERT INTO public.virksomhet_naring VALUES (286, '90.012');
INSERT INTO public.virksomhet_naring VALUES (287, '01.120');
INSERT INTO public.virksomhet_naring VALUES (287, '90.012');
INSERT INTO public.virksomhet_naring VALUES (288, '01.120');
INSERT INTO public.virksomhet_naring VALUES (289, '01.120');
INSERT INTO public.virksomhet_naring VALUES (290, '01.120');
INSERT INTO public.virksomhet_naring VALUES (291, '01.120');
INSERT INTO public.virksomhet_naring VALUES (291, '90.012');
INSERT INTO public.virksomhet_naring VALUES (292, '01.120');
INSERT INTO public.virksomhet_naring VALUES (293, '01.120');
INSERT INTO public.virksomhet_naring VALUES (294, '01.120');
INSERT INTO public.virksomhet_naring VALUES (295, '01.120');
INSERT INTO public.virksomhet_naring VALUES (295, '90.012');
INSERT INTO public.virksomhet_naring VALUES (296, '01.120');
INSERT INTO public.virksomhet_naring VALUES (297, '01.120');
INSERT INTO public.virksomhet_naring VALUES (298, '01.120');
INSERT INTO public.virksomhet_naring VALUES (299, '01.120');
INSERT INTO public.virksomhet_naring VALUES (300, '01.120');
INSERT INTO public.virksomhet_naring VALUES (301, '01.120');
INSERT INTO public.virksomhet_naring VALUES (302, '01.120');
INSERT INTO public.virksomhet_naring VALUES (303, '01.120');
INSERT INTO public.virksomhet_naring VALUES (304, '01.120');
INSERT INTO public.virksomhet_naring VALUES (305, '01.120');
INSERT INTO public.virksomhet_naring VALUES (306, '01.120');
INSERT INTO public.virksomhet_naring VALUES (306, '90.012');
INSERT INTO public.virksomhet_naring VALUES (306, '70.220');
INSERT INTO public.virksomhet_naring VALUES (307, '01.120');
INSERT INTO public.virksomhet_naring VALUES (307, '90.012');
INSERT INTO public.virksomhet_naring VALUES (307, '70.220');
INSERT INTO public.virksomhet_naring VALUES (308, '01.120');
INSERT INTO public.virksomhet_naring VALUES (309, '01.120');
INSERT INTO public.virksomhet_naring VALUES (309, '90.012');
INSERT INTO public.virksomhet_naring VALUES (310, '01.120');
INSERT INTO public.virksomhet_naring VALUES (310, '90.012');
INSERT INTO public.virksomhet_naring VALUES (311, '01.120');
INSERT INTO public.virksomhet_naring VALUES (311, '90.012');
INSERT INTO public.virksomhet_naring VALUES (311, '70.220');
INSERT INTO public.virksomhet_naring VALUES (312, '01.120');
INSERT INTO public.virksomhet_naring VALUES (313, '01.120');
INSERT INTO public.virksomhet_naring VALUES (313, '90.012');
INSERT INTO public.virksomhet_naring VALUES (314, '01.120');
INSERT INTO public.virksomhet_naring VALUES (315, '01.120');
INSERT INTO public.virksomhet_naring VALUES (315, '90.012');
INSERT INTO public.virksomhet_naring VALUES (316, '01.120');
INSERT INTO public.virksomhet_naring VALUES (316, '90.012');
INSERT INTO public.virksomhet_naring VALUES (317, '01.120');
INSERT INTO public.virksomhet_naring VALUES (317, '90.012');
INSERT INTO public.virksomhet_naring VALUES (318, '01.120');
INSERT INTO public.virksomhet_naring VALUES (319, '01.120');
INSERT INTO public.virksomhet_naring VALUES (319, '90.012');
INSERT INTO public.virksomhet_naring VALUES (320, '01.120');
INSERT INTO public.virksomhet_naring VALUES (320, '90.012');
INSERT INTO public.virksomhet_naring VALUES (321, '01.120');
INSERT INTO public.virksomhet_naring VALUES (322, '01.120');
INSERT INTO public.virksomhet_naring VALUES (322, '90.012');
INSERT INTO public.virksomhet_naring VALUES (322, '70.220');
INSERT INTO public.virksomhet_naring VALUES (323, '01.120');
INSERT INTO public.virksomhet_naring VALUES (323, '90.012');
INSERT INTO public.virksomhet_naring VALUES (324, '01.120');
INSERT INTO public.virksomhet_naring VALUES (324, '90.012');
INSERT INTO public.virksomhet_naring VALUES (325, '01.120');
INSERT INTO public.virksomhet_naring VALUES (325, '90.012');
INSERT INTO public.virksomhet_naring VALUES (326, '01.120');
INSERT INTO public.virksomhet_naring VALUES (327, '01.120');
INSERT INTO public.virksomhet_naring VALUES (327, '90.012');
INSERT INTO public.virksomhet_naring VALUES (327, '70.220');
INSERT INTO public.virksomhet_naring VALUES (328, '01.120');
INSERT INTO public.virksomhet_naring VALUES (329, '01.120');
INSERT INTO public.virksomhet_naring VALUES (330, '01.120');
INSERT INTO public.virksomhet_naring VALUES (331, '01.120');
INSERT INTO public.virksomhet_naring VALUES (332, '01.120');
INSERT INTO public.virksomhet_naring VALUES (332, '90.012');
INSERT INTO public.virksomhet_naring VALUES (333, '01.120');
INSERT INTO public.virksomhet_naring VALUES (334, '01.120');
INSERT INTO public.virksomhet_naring VALUES (335, '01.120');
INSERT INTO public.virksomhet_naring VALUES (335, '90.012');
INSERT INTO public.virksomhet_naring VALUES (335, '70.220');
INSERT INTO public.virksomhet_naring VALUES (336, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '90.012');
INSERT INTO public.virksomhet_naring VALUES (338, '01.120');
INSERT INTO public.virksomhet_naring VALUES (339, '01.120');
INSERT INTO public.virksomhet_naring VALUES (340, '01.120');
INSERT INTO public.virksomhet_naring VALUES (340, '90.012');
INSERT INTO public.virksomhet_naring VALUES (340, '70.220');
INSERT INTO public.virksomhet_naring VALUES (341, '01.120');
INSERT INTO public.virksomhet_naring VALUES (341, '90.012');
INSERT INTO public.virksomhet_naring VALUES (341, '70.220');
INSERT INTO public.virksomhet_naring VALUES (342, '01.120');
INSERT INTO public.virksomhet_naring VALUES (343, '01.120');
INSERT INTO public.virksomhet_naring VALUES (344, '01.120');
INSERT INTO public.virksomhet_naring VALUES (344, '90.012');
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
INSERT INTO public.virksomhet_naring VALUES (355, '90.012');
INSERT INTO public.virksomhet_naring VALUES (356, '01.120');
INSERT INTO public.virksomhet_naring VALUES (356, '90.012');
INSERT INTO public.virksomhet_naring VALUES (356, '70.220');
INSERT INTO public.virksomhet_naring VALUES (357, '01.120');
INSERT INTO public.virksomhet_naring VALUES (358, '01.120');
INSERT INTO public.virksomhet_naring VALUES (359, '01.120');
INSERT INTO public.virksomhet_naring VALUES (359, '90.012');
INSERT INTO public.virksomhet_naring VALUES (359, '70.220');
INSERT INTO public.virksomhet_naring VALUES (360, '01.120');
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
INSERT INTO public.virksomhet_naring VALUES (370, '01.120');
INSERT INTO public.virksomhet_naring VALUES (371, '01.120');
INSERT INTO public.virksomhet_naring VALUES (371, '90.012');
INSERT INTO public.virksomhet_naring VALUES (372, '01.120');
INSERT INTO public.virksomhet_naring VALUES (372, '90.012');
INSERT INTO public.virksomhet_naring VALUES (373, '01.120');
INSERT INTO public.virksomhet_naring VALUES (374, '01.120');
INSERT INTO public.virksomhet_naring VALUES (374, '90.012');
INSERT INTO public.virksomhet_naring VALUES (374, '70.220');
INSERT INTO public.virksomhet_naring VALUES (375, '01.120');
INSERT INTO public.virksomhet_naring VALUES (375, '90.012');
INSERT INTO public.virksomhet_naring VALUES (375, '70.220');
INSERT INTO public.virksomhet_naring VALUES (376, '01.120');
INSERT INTO public.virksomhet_naring VALUES (377, '01.120');
INSERT INTO public.virksomhet_naring VALUES (378, '01.120');
INSERT INTO public.virksomhet_naring VALUES (379, '01.120');
INSERT INTO public.virksomhet_naring VALUES (379, '90.012');
INSERT INTO public.virksomhet_naring VALUES (380, '01.120');
INSERT INTO public.virksomhet_naring VALUES (381, '01.120');
INSERT INTO public.virksomhet_naring VALUES (381, '90.012');
INSERT INTO public.virksomhet_naring VALUES (381, '70.220');
INSERT INTO public.virksomhet_naring VALUES (382, '01.120');
INSERT INTO public.virksomhet_naring VALUES (382, '90.012');
INSERT INTO public.virksomhet_naring VALUES (382, '70.220');
INSERT INTO public.virksomhet_naring VALUES (383, '01.120');
INSERT INTO public.virksomhet_naring VALUES (383, '90.012');
INSERT INTO public.virksomhet_naring VALUES (384, '01.120');
INSERT INTO public.virksomhet_naring VALUES (384, '90.012');
INSERT INTO public.virksomhet_naring VALUES (385, '01.120');
INSERT INTO public.virksomhet_naring VALUES (386, '01.120');
INSERT INTO public.virksomhet_naring VALUES (387, '01.120');
INSERT INTO public.virksomhet_naring VALUES (388, '01.120');
INSERT INTO public.virksomhet_naring VALUES (389, '01.120');
INSERT INTO public.virksomhet_naring VALUES (389, '90.012');
INSERT INTO public.virksomhet_naring VALUES (390, '01.120');
INSERT INTO public.virksomhet_naring VALUES (391, '01.120');
INSERT INTO public.virksomhet_naring VALUES (392, '01.120');
INSERT INTO public.virksomhet_naring VALUES (393, '01.120');
INSERT INTO public.virksomhet_naring VALUES (393, '90.012');
INSERT INTO public.virksomhet_naring VALUES (393, '70.220');
INSERT INTO public.virksomhet_naring VALUES (394, '01.120');
INSERT INTO public.virksomhet_naring VALUES (394, '90.012');
INSERT INTO public.virksomhet_naring VALUES (395, '01.120');
INSERT INTO public.virksomhet_naring VALUES (396, '01.120');
INSERT INTO public.virksomhet_naring VALUES (396, '90.012');
INSERT INTO public.virksomhet_naring VALUES (397, '01.120');
INSERT INTO public.virksomhet_naring VALUES (397, '90.012');
INSERT INTO public.virksomhet_naring VALUES (397, '70.220');
INSERT INTO public.virksomhet_naring VALUES (398, '01.120');
INSERT INTO public.virksomhet_naring VALUES (398, '90.012');
INSERT INTO public.virksomhet_naring VALUES (399, '01.120');
INSERT INTO public.virksomhet_naring VALUES (399, '90.012');
INSERT INTO public.virksomhet_naring VALUES (400, '01.120');
INSERT INTO public.virksomhet_naring VALUES (400, '90.012');
INSERT INTO public.virksomhet_naring VALUES (401, '01.120');
INSERT INTO public.virksomhet_naring VALUES (402, '01.120');
INSERT INTO public.virksomhet_naring VALUES (403, '01.120');
INSERT INTO public.virksomhet_naring VALUES (403, '90.012');
INSERT INTO public.virksomhet_naring VALUES (403, '70.220');
INSERT INTO public.virksomhet_naring VALUES (404, '01.120');
INSERT INTO public.virksomhet_naring VALUES (404, '90.012');
INSERT INTO public.virksomhet_naring VALUES (405, '01.120');
INSERT INTO public.virksomhet_naring VALUES (405, '90.012');
INSERT INTO public.virksomhet_naring VALUES (406, '01.120');
INSERT INTO public.virksomhet_naring VALUES (407, '01.120');
INSERT INTO public.virksomhet_naring VALUES (408, '01.120');
INSERT INTO public.virksomhet_naring VALUES (409, '01.120');
INSERT INTO public.virksomhet_naring VALUES (409, '90.012');
INSERT INTO public.virksomhet_naring VALUES (410, '01.120');
INSERT INTO public.virksomhet_naring VALUES (411, '01.120');
INSERT INTO public.virksomhet_naring VALUES (412, '01.120');
INSERT INTO public.virksomhet_naring VALUES (413, '01.120');
INSERT INTO public.virksomhet_naring VALUES (414, '01.120');
INSERT INTO public.virksomhet_naring VALUES (414, '90.012');
INSERT INTO public.virksomhet_naring VALUES (415, '01.120');
INSERT INTO public.virksomhet_naring VALUES (416, '01.120');
INSERT INTO public.virksomhet_naring VALUES (416, '90.012');
INSERT INTO public.virksomhet_naring VALUES (417, '01.120');
INSERT INTO public.virksomhet_naring VALUES (417, '90.012');
INSERT INTO public.virksomhet_naring VALUES (417, '70.220');
INSERT INTO public.virksomhet_naring VALUES (418, '01.120');
INSERT INTO public.virksomhet_naring VALUES (419, '01.120');
INSERT INTO public.virksomhet_naring VALUES (420, '01.120');
INSERT INTO public.virksomhet_naring VALUES (421, '01.120');
INSERT INTO public.virksomhet_naring VALUES (422, '01.120');
INSERT INTO public.virksomhet_naring VALUES (423, '01.120');
INSERT INTO public.virksomhet_naring VALUES (424, '01.120');
INSERT INTO public.virksomhet_naring VALUES (424, '90.012');
INSERT INTO public.virksomhet_naring VALUES (424, '70.220');
INSERT INTO public.virksomhet_naring VALUES (425, '01.120');
INSERT INTO public.virksomhet_naring VALUES (425, '90.012');
INSERT INTO public.virksomhet_naring VALUES (426, '01.120');
INSERT INTO public.virksomhet_naring VALUES (427, '01.120');
INSERT INTO public.virksomhet_naring VALUES (428, '01.120');
INSERT INTO public.virksomhet_naring VALUES (428, '90.012');
INSERT INTO public.virksomhet_naring VALUES (429, '01.120');
INSERT INTO public.virksomhet_naring VALUES (430, '01.120');
INSERT INTO public.virksomhet_naring VALUES (431, '01.120');
INSERT INTO public.virksomhet_naring VALUES (431, '90.012');
INSERT INTO public.virksomhet_naring VALUES (431, '70.220');
INSERT INTO public.virksomhet_naring VALUES (432, '01.120');
INSERT INTO public.virksomhet_naring VALUES (433, '01.120');
INSERT INTO public.virksomhet_naring VALUES (433, '90.012');
INSERT INTO public.virksomhet_naring VALUES (434, '01.120');
INSERT INTO public.virksomhet_naring VALUES (435, '01.120');
INSERT INTO public.virksomhet_naring VALUES (435, '90.012');
INSERT INTO public.virksomhet_naring VALUES (435, '70.220');
INSERT INTO public.virksomhet_naring VALUES (436, '01.120');
INSERT INTO public.virksomhet_naring VALUES (437, '01.120');
INSERT INTO public.virksomhet_naring VALUES (438, '01.120');
INSERT INTO public.virksomhet_naring VALUES (439, '01.120');
INSERT INTO public.virksomhet_naring VALUES (440, '01.120');
INSERT INTO public.virksomhet_naring VALUES (441, '01.120');
INSERT INTO public.virksomhet_naring VALUES (441, '90.012');
INSERT INTO public.virksomhet_naring VALUES (442, '01.120');
INSERT INTO public.virksomhet_naring VALUES (443, '01.120');
INSERT INTO public.virksomhet_naring VALUES (444, '01.120');
INSERT INTO public.virksomhet_naring VALUES (445, '01.120');
INSERT INTO public.virksomhet_naring VALUES (445, '90.012');
INSERT INTO public.virksomhet_naring VALUES (445, '70.220');
INSERT INTO public.virksomhet_naring VALUES (446, '01.120');
INSERT INTO public.virksomhet_naring VALUES (447, '01.120');
INSERT INTO public.virksomhet_naring VALUES (447, '90.012');
INSERT INTO public.virksomhet_naring VALUES (448, '01.120');
INSERT INTO public.virksomhet_naring VALUES (449, '01.120');
INSERT INTO public.virksomhet_naring VALUES (450, '01.120');
INSERT INTO public.virksomhet_naring VALUES (450, '90.012');
INSERT INTO public.virksomhet_naring VALUES (451, '01.120');
INSERT INTO public.virksomhet_naring VALUES (451, '90.012');
INSERT INTO public.virksomhet_naring VALUES (452, '01.120');
INSERT INTO public.virksomhet_naring VALUES (452, '90.012');
INSERT INTO public.virksomhet_naring VALUES (453, '01.120');
INSERT INTO public.virksomhet_naring VALUES (453, '90.012');
INSERT INTO public.virksomhet_naring VALUES (453, '70.220');
INSERT INTO public.virksomhet_naring VALUES (454, '01.120');
INSERT INTO public.virksomhet_naring VALUES (455, '01.120');
INSERT INTO public.virksomhet_naring VALUES (456, '01.120');
INSERT INTO public.virksomhet_naring VALUES (456, '90.012');
INSERT INTO public.virksomhet_naring VALUES (456, '70.220');
INSERT INTO public.virksomhet_naring VALUES (457, '01.120');
INSERT INTO public.virksomhet_naring VALUES (457, '90.012');
INSERT INTO public.virksomhet_naring VALUES (458, '01.120');
INSERT INTO public.virksomhet_naring VALUES (459, '01.120');
INSERT INTO public.virksomhet_naring VALUES (459, '90.012');
INSERT INTO public.virksomhet_naring VALUES (459, '70.220');
INSERT INTO public.virksomhet_naring VALUES (460, '01.120');
INSERT INTO public.virksomhet_naring VALUES (460, '90.012');
INSERT INTO public.virksomhet_naring VALUES (460, '70.220');
INSERT INTO public.virksomhet_naring VALUES (461, '01.120');
INSERT INTO public.virksomhet_naring VALUES (462, '01.120');
INSERT INTO public.virksomhet_naring VALUES (463, '01.120');
INSERT INTO public.virksomhet_naring VALUES (463, '90.012');
INSERT INTO public.virksomhet_naring VALUES (463, '70.220');
INSERT INTO public.virksomhet_naring VALUES (464, '01.120');
INSERT INTO public.virksomhet_naring VALUES (464, '90.012');
INSERT INTO public.virksomhet_naring VALUES (464, '70.220');
INSERT INTO public.virksomhet_naring VALUES (465, '01.120');
INSERT INTO public.virksomhet_naring VALUES (466, '01.120');
INSERT INTO public.virksomhet_naring VALUES (467, '01.120');
INSERT INTO public.virksomhet_naring VALUES (468, '01.120');
INSERT INTO public.virksomhet_naring VALUES (469, '01.120');
INSERT INTO public.virksomhet_naring VALUES (470, '01.120');
INSERT INTO public.virksomhet_naring VALUES (470, '90.012');
INSERT INTO public.virksomhet_naring VALUES (471, '01.120');
INSERT INTO public.virksomhet_naring VALUES (471, '90.012');
INSERT INTO public.virksomhet_naring VALUES (471, '70.220');
INSERT INTO public.virksomhet_naring VALUES (472, '01.120');
INSERT INTO public.virksomhet_naring VALUES (473, '01.120');
INSERT INTO public.virksomhet_naring VALUES (473, '90.012');
INSERT INTO public.virksomhet_naring VALUES (474, '01.120');
INSERT INTO public.virksomhet_naring VALUES (474, '90.012');
INSERT INTO public.virksomhet_naring VALUES (475, '01.120');
INSERT INTO public.virksomhet_naring VALUES (476, '01.120');
INSERT INTO public.virksomhet_naring VALUES (477, '01.120');
INSERT INTO public.virksomhet_naring VALUES (477, '90.012');
INSERT INTO public.virksomhet_naring VALUES (477, '70.220');
INSERT INTO public.virksomhet_naring VALUES (478, '01.120');
INSERT INTO public.virksomhet_naring VALUES (479, '01.120');
INSERT INTO public.virksomhet_naring VALUES (480, '01.120');
INSERT INTO public.virksomhet_naring VALUES (480, '90.012');
INSERT INTO public.virksomhet_naring VALUES (480, '70.220');
INSERT INTO public.virksomhet_naring VALUES (481, '01.120');
INSERT INTO public.virksomhet_naring VALUES (481, '90.012');
INSERT INTO public.virksomhet_naring VALUES (482, '01.120');
INSERT INTO public.virksomhet_naring VALUES (483, '01.120');
INSERT INTO public.virksomhet_naring VALUES (484, '01.120');
INSERT INTO public.virksomhet_naring VALUES (485, '01.120');
INSERT INTO public.virksomhet_naring VALUES (485, '90.012');
INSERT INTO public.virksomhet_naring VALUES (486, '01.120');
INSERT INTO public.virksomhet_naring VALUES (487, '01.120');
INSERT INTO public.virksomhet_naring VALUES (487, '90.012');
INSERT INTO public.virksomhet_naring VALUES (487, '70.220');
INSERT INTO public.virksomhet_naring VALUES (488, '01.120');
INSERT INTO public.virksomhet_naring VALUES (489, '01.120');
INSERT INTO public.virksomhet_naring VALUES (490, '01.120');
INSERT INTO public.virksomhet_naring VALUES (490, '90.012');
INSERT INTO public.virksomhet_naring VALUES (491, '01.120');
INSERT INTO public.virksomhet_naring VALUES (491, '90.012');
INSERT INTO public.virksomhet_naring VALUES (492, '01.120');
INSERT INTO public.virksomhet_naring VALUES (492, '90.012');
INSERT INTO public.virksomhet_naring VALUES (493, '01.120');
INSERT INTO public.virksomhet_naring VALUES (493, '90.012');
INSERT INTO public.virksomhet_naring VALUES (493, '70.220');
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
INSERT INTO public.virksomhet_naring VALUES (500, '90.012');
INSERT INTO public.virksomhet_naring VALUES (501, '01.120');
INSERT INTO public.virksomhet_naring VALUES (502, '01.120');
INSERT INTO public.virksomhet_naring VALUES (502, '90.012');
INSERT INTO public.virksomhet_naring VALUES (503, '01.120');
INSERT INTO public.virksomhet_naring VALUES (503, '90.012');
INSERT INTO public.virksomhet_naring VALUES (504, '01.120');
INSERT INTO public.virksomhet_naring VALUES (504, '90.012');
INSERT INTO public.virksomhet_naring VALUES (505, '01.120');
INSERT INTO public.virksomhet_naring VALUES (506, '01.120');
INSERT INTO public.virksomhet_naring VALUES (506, '90.012');
INSERT INTO public.virksomhet_naring VALUES (507, '01.120');
INSERT INTO public.virksomhet_naring VALUES (508, '01.120');
INSERT INTO public.virksomhet_naring VALUES (508, '90.012');
INSERT INTO public.virksomhet_naring VALUES (509, '01.120');
INSERT INTO public.virksomhet_naring VALUES (510, '01.120');
INSERT INTO public.virksomhet_naring VALUES (510, '90.012');
INSERT INTO public.virksomhet_naring VALUES (511, '01.120');
INSERT INTO public.virksomhet_naring VALUES (517, '01.120');
INSERT INTO public.virksomhet_naring VALUES (517, '90.012');
INSERT INTO public.virksomhet_naring VALUES (517, '70.220');
INSERT INTO public.virksomhet_naring VALUES (518, '01.120');
INSERT INTO public.virksomhet_naring VALUES (519, '01.120');
INSERT INTO public.virksomhet_naring VALUES (520, '01.120');
INSERT INTO public.virksomhet_naring VALUES (520, '90.012');
INSERT INTO public.virksomhet_naring VALUES (521, '01.120');
INSERT INTO public.virksomhet_naring VALUES (521, '90.012');
INSERT INTO public.virksomhet_naring VALUES (521, '70.220');
INSERT INTO public.virksomhet_naring VALUES (522, '01.120');
INSERT INTO public.virksomhet_naring VALUES (523, '01.120');
INSERT INTO public.virksomhet_naring VALUES (523, '90.012');
INSERT INTO public.virksomhet_naring VALUES (523, '70.220');
INSERT INTO public.virksomhet_naring VALUES (524, '01.120');
INSERT INTO public.virksomhet_naring VALUES (524, '90.012');
INSERT INTO public.virksomhet_naring VALUES (524, '70.220');
INSERT INTO public.virksomhet_naring VALUES (525, '01.120');
INSERT INTO public.virksomhet_naring VALUES (526, '01.120');
INSERT INTO public.virksomhet_naring VALUES (512, '01.120');
INSERT INTO public.virksomhet_naring VALUES (513, '01.120');
INSERT INTO public.virksomhet_naring VALUES (513, '90.012');
INSERT INTO public.virksomhet_naring VALUES (514, '01.120');
INSERT INTO public.virksomhet_naring VALUES (514, '90.012');
INSERT INTO public.virksomhet_naring VALUES (514, '70.220');
INSERT INTO public.virksomhet_naring VALUES (515, '01.120');
INSERT INTO public.virksomhet_naring VALUES (515, '90.012');
INSERT INTO public.virksomhet_naring VALUES (516, '01.120');
INSERT INTO public.virksomhet_naring VALUES (527, '01.120');
INSERT INTO public.virksomhet_naring VALUES (527, '01.110');
INSERT INTO public.virksomhet_naring VALUES (527, '70.220');
INSERT INTO public.virksomhet_naring VALUES (534, '01.120');
INSERT INTO public.virksomhet_naring VALUES (535, '01.120');
INSERT INTO public.virksomhet_naring VALUES (535, '90.012');
INSERT INTO public.virksomhet_naring VALUES (535, '70.220');
INSERT INTO public.virksomhet_naring VALUES (536, '01.120');
INSERT INTO public.virksomhet_naring VALUES (536, '90.012');
INSERT INTO public.virksomhet_naring VALUES (537, '01.120');
INSERT INTO public.virksomhet_naring VALUES (537, '90.012');
INSERT INTO public.virksomhet_naring VALUES (537, '70.220');
INSERT INTO public.virksomhet_naring VALUES (538, '01.120');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.285638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.37852');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '555555555', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.37852');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (6, '881532376', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '883874352', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '848147638', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '876763949', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '871871807', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (15, '864079801', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (16, '836041617', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (17, '857842260', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (18, '885073621', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (19, '864754605', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (20, '846347581', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (21, '824680794', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (22, '839415001', 'VIRKSOMHET', '3', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '861744528', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '860138909', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (25, '843242104', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '890093850', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (27, '892511017', 'VIRKSOMHET', '3', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '842605109', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.47007');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (29, '870491047', 'VIRKSOMHET', '3', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '863507760', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (31, '817257908', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '809042383', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '810734693', 'VIRKSOMHET', '3', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '804629062', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '873621335', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '835058832', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '803826652', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '874394467', 'VIRKSOMHET', '3', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '838903289', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '882051647', 'VIRKSOMHET', '3', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '879681201', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.724716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '852409131', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '808215075', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '865074415', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '836669149', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '884369776', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '873418367', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '802905016', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '885609899', 'VIRKSOMHET', '3', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '860836918', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '829745509', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '844246611', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '867216743', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '890941228', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '838540049', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '809501750', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '844496478', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '863501025', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '839166324', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '879962157', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '848543645', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '880279851', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '808671188', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '851333885', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '815366017', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '891113900', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '894926128', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '802290404', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '896239097', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '816868949', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '895298219', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '842893897', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '814670938', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '820433803', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '874104569', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '856520283', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '879090305', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '809468321', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '826378947', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '866390365', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '862771013', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '864363318', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '896438075', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '829368106', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '867407313', 'VIRKSOMHET', '3', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '896587504', 'VIRKSOMHET', '1', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '847845944', 'VIRKSOMHET', '3', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '826389298', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '848399886', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '854846835', 'VIRKSOMHET', '0', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '800634899', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '857110616', 'VIRKSOMHET', '3', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '808271586', 'VIRKSOMHET', '2', '2023-03-03 08:50:19.857593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '819801010', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '848578637', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '827490752', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '835736810', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '857544475', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '847721823', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '862581603', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '810313500', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '885129733', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '898243796', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '887079787', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '861058672', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '876537913', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '890597928', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '842982051', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '842389667', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '820004072', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '897688257', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '837534390', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '808543637', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '870201888', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '817311070', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '868012776', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '896429753', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '851603425', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '827443317', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '833362642', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.187885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '882069408', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '863878944', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '866558221', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '868767855', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '875885300', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '842216735', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '856920437', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '830858963', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '812434114', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '847041353', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '803269327', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '843457384', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '818306281', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '844449510', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '867177223', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '883963814', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '886253015', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '895281822', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '840533481', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '839216776', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '803533948', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '827095124', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '808251981', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '817358823', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '871910327', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '866587133', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '842840788', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '812781923', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '804058381', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '811423248', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '840837641', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '818816392', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '806494928', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '893055618', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '875340822', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '818463756', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '884152302', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '849742742', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '804979817', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '814190896', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '822331640', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '862678317', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '831093023', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '874226454', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '832436811', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '838432048', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '870022919', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '879268334', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '806599852', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '863181199', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '863767568', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '844014636', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '866404710', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '833129946', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '846977998', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '811030348', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '890815907', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '822694021', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '852558904', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '822874914', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '866646453', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '881021956', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '899291735', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '867918928', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '823439458', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '837805347', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.384243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '805499088', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '845822610', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '841405633', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '889675608', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '899025387', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '863280835', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '860629673', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '833667497', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '842471044', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '861459803', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '812926032', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '871631319', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '865439281', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '824210548', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '805486005', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '832448472', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '805820685', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '883768894', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '856903021', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '850012745', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '820149848', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '822705108', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '857573851', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '856078198', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '859225721', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '873879874', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '890065285', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '893423280', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '816273126', 'VIRKSOMHET', '2', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '874977909', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '888632161', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '852452427', 'VIRKSOMHET', '0', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '807389236', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '833163111', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '813080832', 'VIRKSOMHET', '1', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '896489260', 'VIRKSOMHET', '3', '2023-03-03 08:50:20.756289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '845881839', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '898157169', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '882940656', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '887589106', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '856439808', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '869911712', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '836420677', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '810521018', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '863021621', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '846289494', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '834191416', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '837420340', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '871949311', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '821633142', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '893463166', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '833218825', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '807456455', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '821381486', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '814324199', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '805904949', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '813242515', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '839415843', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '804234371', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '816585946', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '824097835', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '880538674', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '875775705', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '877421692', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '871547736', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '857653378', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '829980700', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '852627790', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '865978526', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '840145629', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '875016141', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '869419134', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '813944600', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '885600454', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '877550656', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '804227830', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '858956619', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '865153645', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '817941723', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '811667993', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '859462534', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '822317092', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '877772835', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '846495295', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '804775869', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '831030012', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '802809462', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '896200151', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '873610100', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '847931581', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '870810427', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '816457914', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '816760477', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '821449527', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '897412997', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '801856356', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '898170941', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '884390144', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '894424841', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '828972512', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '815082581', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '887159012', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '829493874', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '814929193', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '859907302', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '895124699', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '813239227', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '840430296', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '858726639', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '823234800', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '874361830', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.023688');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '808481735', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '860499175', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '892697142', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '826727890', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '895582762', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '814663914', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '887191975', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '856729012', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '816248533', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '847253663', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '851556995', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '897000352', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '891267708', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '868369009', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '836786224', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '800910790', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '847922087', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '882737279', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '817612413', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '857680168', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '878624841', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '867183919', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '824306551', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '812929350', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '890735735', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '894341616', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '845690609', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '884945724', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '820865124', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '870514368', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '833643869', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '807702188', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '820638689', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '843380901', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '832951634', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '833677243', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '873656323', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '859159231', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '868067017', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '856435712', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '888937591', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '873906284', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '855150484', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '836365546', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '822564929', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '833204596', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '863592645', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '865956727', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '807629933', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.392208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '832454631', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '823356725', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '800824855', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '894510083', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '815854671', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '876401827', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '845066027', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '815406101', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '866878310', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '830803739', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '805933483', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '868252144', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '828744326', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '830122600', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '813147327', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '846250295', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '898250721', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '813697349', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '863104800', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '897979593', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '860772161', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '808002552', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '876394411', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '846214156', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '850015354', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '805145991', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '853879838', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '882939801', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '859605190', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '891814367', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '875021136', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '825379831', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '800469195', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '871244244', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '837133219', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '855964219', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '838273484', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '893483616', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '891497759', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '888247901', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '883590490', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '804908767', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '851919134', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '813682750', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '875544956', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '889472231', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '875631634', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '856007783', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '844760467', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '863256691', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '851705582', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '854298834', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '836216435', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '893017297', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '841372032', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '862589424', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '871501781', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '880977356', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '859708655', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '837130075', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '803170681', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '875018446', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '872251225', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '889927472', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '850310272', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '878277970', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '811324382', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '878265174', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '803799726', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '827344157', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '868610918', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '891144647', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '874750888', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '879572863', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '816719384', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '823372812', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '872671153', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '837782686', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '856373244', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '802319687', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '882221112', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '825823538', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '840744367', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '807485242', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '878321914', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '886892017', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '871623349', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '864986459', 'VIRKSOMHET', '0', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '849227492', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '850910144', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '869658223', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '866431270', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '858356342', 'VIRKSOMHET', '2', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '852467356', 'VIRKSOMHET', '1', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '898657961', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '846849579', 'VIRKSOMHET', '3', '2023-03-03 08:50:21.626595');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '873579899', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '843035298', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '858836952', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '805709917', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '808479485', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '838878962', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '885625328', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '837527996', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '844848494', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '825573136', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '809036318', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '800223332', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '878112453', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '893781546', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '818658010', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '862270603', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '812325897', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '817554736', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '884291457', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '890910485', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '810677960', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '830621787', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '874792210', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '828718942', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '846277869', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '809316543', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '846821438', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '836005340', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '869069081', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '824870495', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '821850314', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '895629317', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '854843256', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '825397589', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '856901774', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '886566656', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '868634250', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '827178297', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '889901026', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '860932226', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '883640440', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '899511765', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '826671551', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '838991015', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '831768843', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '803324193', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '827269180', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '806938796', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '817130185', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '810402680', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '887841956', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '897336611', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '858728795', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '880050743', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '871161662', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '862924848', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '895031114', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '815517829', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '836666246', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '845715533', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '897156462', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '890815244', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '866562589', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.034801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '875322390', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.245694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '870376312', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.245694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '863074238', 'VIRKSOMHET', '1', '2023-03-03 08:50:22.245694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '873535604', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.245694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '820029647', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.245694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '825514130', 'VIRKSOMHET', '3', '2023-03-03 08:50:22.245694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '815801592', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.245694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '839528084', 'VIRKSOMHET', '0', '2023-03-03 08:50:22.245694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '864571830', 'VIRKSOMHET', '2', '2023-03-03 08:50:22.245694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '883989256', 'VIRKSOMHET', '2', '2023-03-03 08:50:25.103554');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '831272011', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.127951');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '831658088', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.158925');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '802008121', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.158925');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '857721878', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.158925');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '811747377', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.158925');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '801396893', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.158925');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '885133950', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.211673');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '864761302', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.211673');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '870050263', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.25263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '881536611', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.25263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '862811969', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.25263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '892708443', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.25263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '866931781', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.25263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '868378133', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.25263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '872308278', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.25263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '854032309', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.25263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '842782667', 'VIRKSOMHET', '1', '2023-03-03 08:50:25.25263');


--
-- Name: ia_tjeneste_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.ia_tjeneste_id_seq', 1, false);


--
-- Name: iasak_leveranse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.iasak_leveranse_id_seq', 1, false);


--
-- Name: modul_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.modul_id_seq', 1, false);


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
-- Name: ia_tjeneste ia_tjeneste_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.ia_tjeneste
    ADD CONSTRAINT ia_tjeneste_pkey PRIMARY KEY (id);


--
-- Name: iasak_leveranse iasak_leveranse_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.iasak_leveranse
    ADD CONSTRAINT iasak_leveranse_pkey PRIMARY KEY (id);


--
-- Name: iasak_leveranse iasak_leveranse_unik; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.iasak_leveranse
    ADD CONSTRAINT iasak_leveranse_unik UNIQUE (saksnummer, modul);


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
-- Name: modul modul_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.modul
    ADD CONSTRAINT modul_pkey PRIMARY KEY (id);


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
-- Name: iasak_leveranse fk_iasak_leveranse_modul; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.iasak_leveranse
    ADD CONSTRAINT fk_iasak_leveranse_modul FOREIGN KEY (modul) REFERENCES public.modul(id);


--
-- Name: iasak_leveranse fk_iasak_leveranse_saksnummer; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.iasak_leveranse
    ADD CONSTRAINT fk_iasak_leveranse_saksnummer FOREIGN KEY (saksnummer) REFERENCES public.ia_sak(saksnummer);


--
-- Name: modul fk_modul_ia_tjeneste; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.modul
    ADD CONSTRAINT fk_modul_ia_tjeneste FOREIGN KEY (ia_tjeneste) REFERENCES public.ia_tjeneste(id);


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
-- Name: TABLE ia_tjeneste; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.ia_tjeneste TO cloudsqliamuser;


--
-- Name: TABLE iasak_leveranse; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.iasak_leveranse TO cloudsqliamuser;


--
-- Name: TABLE modul; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.modul TO cloudsqliamuser;


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

