--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-1.pgdg110+1)
-- Dumped by pg_dump version 14.5 (Homebrew)

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
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet DROP CONSTRAINT IF EXISTS sykefravar_statistikk_virksomhet_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_sektor DROP CONSTRAINT IF EXISTS sykefravar_statistikk_sektor_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naringsundergruppe DROP CONSTRAINT IF EXISTS sykefravar_statistikk_naringsundergruppe_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naring DROP CONSTRAINT IF EXISTS sykefravar_statistikk_naring_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_land DROP CONSTRAINT IF EXISTS sykefravar_statistikk_land_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_grunnlag DROP CONSTRAINT IF EXISTS sykefravar_statistikk_grunnlag_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet DROP CONSTRAINT IF EXISTS sykefravar_periode;
ALTER TABLE IF EXISTS ONLY public.sektor DROP CONSTRAINT IF EXISTS sektor_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_sektor DROP CONSTRAINT IF EXISTS sektor_periode;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naringsundergruppe DROP CONSTRAINT IF EXISTS naringsundergruppe_periode;
ALTER TABLE IF EXISTS ONLY public.naring DROP CONSTRAINT IF EXISTS naring_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naring DROP CONSTRAINT IF EXISTS naring_periode;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_land DROP CONSTRAINT IF EXISTS land_periode;
ALTER TABLE IF EXISTS ONLY public.ia_sak DROP CONSTRAINT IF EXISTS ia_sak_pkey;
ALTER TABLE IF EXISTS ONLY public.ia_sak_hendelse DROP CONSTRAINT IF EXISTS ia_sak_hendelse_pkey;
ALTER TABLE IF EXISTS ONLY public.flyway_schema_history DROP CONSTRAINT IF EXISTS flyway_schema_history_pk;
ALTER TABLE IF EXISTS public.virksomhet_statistikk_metadata ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.virksomhet ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_virksomhet ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_sektor ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_naringsundergruppe ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_naring ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_land ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_grunnlag ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS public.virksomhet_naring;
DROP SEQUENCE IF EXISTS public.virksomhet_metadata_id_seq;
DROP TABLE IF EXISTS public.virksomhet_statistikk_metadata;
DROP SEQUENCE IF EXISTS public.virksomhet_id_seq;
DROP TABLE IF EXISTS public.virksomhet;
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

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', 'V1__init.sql', 1782034767, 'test', '2022-09-29 10:20:42.167947', 17, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', 'V2__create_virksomhet_adresse.sql', -64248919, 'test', '2022-09-29 10:20:42.229177', 16, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', 'V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2022-09-29 10:20:42.272349', 5, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', 'V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2022-09-29 10:20:42.294676', 6, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', 'V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2022-09-29 10:20:42.31667', 7, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', 'V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2022-09-29 10:20:42.342175', 6, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', 'V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2022-09-29 10:20:42.363888', 10, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', 'V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2022-09-29 10:20:42.389339', 9, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', 'V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2022-09-29 10:20:42.413972', 11, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', 'V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2022-09-29 10:20:42.445343', 10, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', 'V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2022-09-29 10:20:42.471429', 10, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', 'V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2022-09-29 10:20:42.504118', 9, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', 'V13__ia_prosess.sql', -1755516749, 'test', '2022-09-29 10:20:42.530734', 12, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', 'V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2022-09-29 10:20:42.559088', 12, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', 'V15__endre_saknummer.sql', -1379621340, 'test', '2022-09-29 10:20:42.586868', 5, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', 'V16__ia_sak_hendelse.sql', 586872662, 'test', '2022-09-29 10:20:42.604435', 10, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', 'V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2022-09-29 10:20:42.62694', 5, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', 'V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2022-09-29 10:20:42.643608', 8, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', 'V19__legg_til_begrunnelser.sql', 779259005, 'test', '2022-09-29 10:20:42.663358', 6, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', 'V20__legg_til_flere_indekser.sql', -843857404, 'test', '2022-09-29 10:20:42.682442', 10, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', 'V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2022-09-29 10:20:42.70856', 4, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', 'V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2022-09-29 10:20:42.731621', 7, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', 'V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2022-09-29 10:20:42.75188', 8, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', 'V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2022-09-29 10:20:42.773358', 9, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', 'V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2022-09-29 10:20:42.795267', 18, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', 'V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2022-09-29 10:20:42.827273', 5, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', 'V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2022-09-29 10:20:42.843187', 5, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', 'V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2022-09-29 10:20:42.85955', 4, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', 'V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2022-09-29 10:20:42.874793', 5, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', 'V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2022-09-29 10:20:42.887491', 5, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', 'V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2022-09-29 10:20:42.902516', 6, true);
INSERT INTO public.flyway_schema_history VALUES (32, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -1618384066, 'test', '2022-09-29 10:20:42.915637', 6, true);
INSERT INTO public.flyway_schema_history VALUES (33, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -2084614075, 'test', '2022-09-29 10:20:47.146877', 34, true);


--
-- Data for Name: hendelse_begrunnelse; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.hendelse_begrunnelse VALUES ('01GE45BCHN7DR817VTPNWP08D4', 'Virksomheten har takket nei', 'Virksomheten har ikke tid eller kapasitet nå til å samarbeide med NAV', 'VIRKSOMHETEN_TAKKET_NEI', 'HAR_IKKE_KAPASITET');


--
-- Data for Name: ia_sak; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.ia_sak VALUES ('01GE45BBRVGTGF04KFDN08115V', '878151780', 'IKKE_AKTUELL', 'S54321', '2022-09-29 10:21:00.316872', 'X12345', '2022-09-29 10:21:01.109637', '01GE45BCHN7DR817VTPNWP08D4', 'X12345');
INSERT INTO public.ia_sak VALUES ('01GE45BCKF0VMQ1KB6BS2S0B6H', '878151780', 'VURDERES', 'S54321', '2022-09-29 10:21:01.167863', 'S54321', '2022-09-29 10:21:01.172953', '01GE45BCKMD80G018CB7ST0E0W', NULL);


--
-- Data for Name: ia_sak_hendelse; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.ia_sak_hendelse VALUES ('01GE45BBRVGTGF04KFDN08115V', '01GE45BBRVGTGF04KFDN08115V', '878151780', 'OPPRETT_SAK_FOR_VIRKSOMHET', 'S54321', '2022-09-29 10:21:00.316872');
INSERT INTO public.ia_sak_hendelse VALUES ('01GE45BBW5V7X711B751MB19AX', '01GE45BBRVGTGF04KFDN08115V', '878151780', 'VIRKSOMHET_VURDERES', 'S54321', '2022-09-29 10:21:00.421283');
INSERT INTO public.ia_sak_hendelse VALUES ('01GE45BC9KXCMS10VS989Q14ST', '01GE45BBRVGTGF04KFDN08115V', '878151780', 'TA_EIERSKAP_I_SAK', 'X12345', '2022-09-29 10:21:00.851578');
INSERT INTO public.ia_sak_hendelse VALUES ('01GE45BCCDVNWS16VY68JD0ZMQ', '01GE45BBRVGTGF04KFDN08115V', '878151780', 'VIRKSOMHET_SKAL_KONTAKTES', 'X12345', '2022-09-29 10:21:00.941962');
INSERT INTO public.ia_sak_hendelse VALUES ('01GE45BCDDN69E1NBBE1EB0G61', '01GE45BBRVGTGF04KFDN08115V', '878151780', 'VIRKSOMHET_KARTLEGGES', 'X12345', '2022-09-29 10:21:00.973481');
INSERT INTO public.ia_sak_hendelse VALUES ('01GE45BCG17Y56015MH77T08A3', '01GE45BBRVGTGF04KFDN08115V', '878151780', 'VIRKSOMHET_SKAL_BISTÅS', 'X12345', '2022-09-29 10:21:01.057078');
INSERT INTO public.ia_sak_hendelse VALUES ('01GE45BCHN7DR817VTPNWP08D4', '01GE45BBRVGTGF04KFDN08115V', '878151780', 'VIRKSOMHET_ER_IKKE_AKTUELL', 'X12345', '2022-09-29 10:21:01.109637');
INSERT INTO public.ia_sak_hendelse VALUES ('01GE45BCKF0VMQ1KB6BS2S0B6H', '01GE45BCKF0VMQ1KB6BS2S0B6H', '878151780', 'OPPRETT_SAK_FOR_VIRKSOMHET', 'S54321', '2022-09-29 10:21:01.167863');
INSERT INTO public.ia_sak_hendelse VALUES ('01GE45BCKMD80G018CB7ST0E0W', '01GE45BCKF0VMQ1KB6BS2S0B6H', '878151780', 'VIRKSOMHET_VURDERES', 'S54321', '2022-09-29 10:21:01.172953');


--
-- Data for Name: naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.naring VALUES ('00.000', 'Uoppgitt', 'Uoppgitt');
INSERT INTO public.naring VALUES ('00', 'Uoppgitt', 'Uoppgitt');
INSERT INTO public.naring VALUES ('90', 'Næring', 'Kortnavn for 90');
INSERT INTO public.naring VALUES ('70', 'Næring', 'Kortnavn for 70');
INSERT INTO public.naring VALUES ('90.012', 'Utøvende kunstnere og underholdningsvirksomhet innen scenekunst', 'Kortnavn for 90.012');
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

INSERT INTO public.sykefravar_statistikk_grunnlag VALUES (1, '01GE45BBRVGTGF04KFDN08115V', '01GE45BBW5V7X711B751MB19AX', '878151780', 2022, 2, 769.349164346695, 4587.38914024835, 500, 15, false, '2022-09-29 10:21:00.450975');
INSERT INTO public.sykefravar_statistikk_grunnlag VALUES (2, '01GE45BCKF0VMQ1KB6BS2S0B6H', '01GE45BCKMD80G018CB7ST0E0W', '878151780', 2022, 2, 769.349164346695, 4587.38914024835, 500, 15, false, '2022-09-29 10:21:01.192159');
INSERT INTO public.sykefravar_statistikk_grunnlag VALUES (3, '01GE45BCKF0VMQ1KB6BS2S0B6H', '01GE45BCKMD80G018CB7ST0E0W', '878151780', 2022, 2, 769.349164346695, 4587.38914024835, 500, 15, false, '2022-09-29 10:21:01.192159');


--
-- Data for Name: sykefravar_statistikk_land; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_land VALUES (1, 2022, 2, 'NO', 2500000, 10000000, 500000000, 2, false, '2022-09-29 10:20:52.441869');
INSERT INTO public.sykefravar_statistikk_land VALUES (2, 2022, 1, 'NO', 2500000, 10000000, 500000000, 2, false, '2022-09-29 10:20:52.559454');


--
-- Data for Name: sykefravar_statistikk_naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naring VALUES (1, 2022, 2, '01', 150, 100, 5000, 2, false, '2022-09-29 10:20:52.441869');
INSERT INTO public.sykefravar_statistikk_naring VALUES (2, 2022, 1, '01', 150, 100, 5000, 2, false, '2022-09-29 10:20:52.559454');


--
-- Data for Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naringsundergruppe VALUES (1, 2022, 2, '01.110', 1250, 40, 4000, 1, false, '2022-09-29 10:20:52.441869');
INSERT INTO public.sykefravar_statistikk_naringsundergruppe VALUES (2, 2022, 1, '01.110', 1250, 40, 4000, 1, false, '2022-09-29 10:20:52.559454');


--
-- Data for Name: sykefravar_statistikk_sektor; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_sektor VALUES (1, 2022, 2, '1', 33000, 1340, 8000, 1.5, false, '2022-09-29 10:20:52.441869');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (2, 2022, 1, '1', 33000, 1340, 8000, 1.5, false, '2022-09-29 10:20:52.559454');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (16, 2022, 2, '2', 33000, 1340, 8000, 1.5, false, '2022-09-29 10:20:52.683638');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (19, 2022, 2, '0', 33000, 1340, 8000, 1.5, false, '2022-09-29 10:20:52.683638');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (21, 2022, 2, '3', 33000, 1340, 8000, 1.5, false, '2022-09-29 10:20:52.683638');


--
-- Data for Name: sykefravar_statistikk_virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2022, 2, 6, 1662.57217233305, 500, 2, false, '2022-09-29 10:20:52.441869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2022, 1, 6, 1662.57217233305, 500, 2, false, '2022-09-29 10:20:52.559454', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2022, 2, 867.119626659335, 4901.96157625351, 500, 7, false, '2022-09-29 10:20:52.559454', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2022, 1, 867.119626659335, 4901.96157625351, 500, 7, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '984247664', 2022, 2, 1001, 5520.72803816559, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '984247664', 2022, 1, 1001, 5520.72803816559, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '555555555', 2022, 2, 80.3178396202192, 4506.56594547726, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '881532376', 2022, 2, 870.308757173264, 8593.83676321843, 500, 6, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '881532376', 2022, 1, 870.308757173264, 8593.83676321843, 500, 6, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '883874352', 2022, 2, 42, 3248.02213782345, 500, 6, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '883874352', 2022, 1, 42, 3248.02213782345, 500, 6, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '848147638', 2022, 2, 42, 8604.99716055902, 500, 6, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '848147638', 2022, 1, 42, 8604.99716055902, 500, 6, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '876763949', 2022, 2, 547.522850557443, 6861.11661420433, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '876763949', 2022, 1, 547.522850557443, 6861.11661420433, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '871871807', 2022, 2, 192.073166439097, 9339.44325151151, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '864079801', 2022, 2, 866.128147574437, 2487.12071527443, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '836041617', 2022, 2, 465.560984045886, 105.086668131936, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '857842260', 2022, 2, 667.122265135765, 570.874991831817, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '885073621', 2022, 2, 900.875313895363, 1727.01335167005, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '864754605', 2022, 2, 819.775548903124, 7155.03880675182, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '846347581', 2022, 2, 142.239618081847, 6773.076811233, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '824680794', 2022, 2, 444.000956318171, 9166.2700853636, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '839415001', 2022, 2, 987.865543740206, 4084.63923288996, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '861744528', 2022, 2, 921.713950148471, 2528.78325704187, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '860138909', 2022, 2, 595.639378484444, 3721.29630133129, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '843242104', 2022, 2, 81.6150501553844, 1372.15139613848, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '890093850', 2022, 2, 469.446905309303, 8773.97153019909, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '892511017', 2022, 2, 777.752437252183, 4789.5844210668, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '842605109', 2022, 2, 548.687478233797, 9416.21610178916, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '870491047', 2022, 2, 104.055398907014, 1570.76863429004, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '863507760', 2022, 2, 909.288648318639, 1046.39602075633, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '817257908', 2022, 2, 703.868140067157, 2385.24806778223, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '809042383', 2022, 2, 949.08099711354, 7789.48335432647, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '810734693', 2022, 2, 243.906749733793, 5018.59858569277, 500, 2, false, '2022-09-29 10:20:52.683638', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '804629062', 2022, 2, 29.7103529362706, 4164.38331689856, 500, 2, false, '2022-09-29 10:20:53.083044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '873621335', 2022, 2, 57.9468368364351, 9758.64617956887, 500, 2, false, '2022-09-29 10:20:53.083044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '835058832', 2022, 2, 138.876496825947, 6734.48870162856, 500, 2, false, '2022-09-29 10:20:53.083044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '803826652', 2022, 2, 355.990157196717, 6875.86058639891, 500, 2, false, '2022-09-29 10:20:53.083044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '874394467', 2022, 2, 297.253194333504, 3681.13092028731, 500, 2, false, '2022-09-29 10:20:53.083044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '838903289', 2022, 2, 830.524282056457, 1458.17882215442, 500, 2, false, '2022-09-29 10:20:53.083044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '882051647', 2022, 2, 920.839940671325, 5154.20035645455, 500, 2, false, '2022-09-29 10:20:53.083044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '879681201', 2022, 2, 862.594393977418, 7249.77397313648, 500, 2, false, '2022-09-29 10:20:53.083044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '852409131', 2022, 2, 615.087572407826, 518.393585411888, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '808215075', 2022, 2, 915.960486130517, 1287.18393045131, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '865074415', 2022, 2, 30.5570277018023, 1409.45998940933, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '836669149', 2022, 2, 306.825774704666, 2523.91795854722, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '884369776', 2022, 2, 344.629322798091, 147.933154948303, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '873418367', 2022, 2, 306.519501356277, 154.32729965437, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '802905016', 2022, 2, 775.0197111438, 4954.52309183052, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '885609899', 2022, 2, 368.76249428405, 3681.9524265088, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '860836918', 2022, 2, 317.240824394503, 4086.77107341637, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '829745509', 2022, 2, 994.966140407435, 7167.65016912899, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '844246611', 2022, 2, 941.111320619119, 2255.27563341582, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '867216743', 2022, 2, 397.480393893923, 5123.35866152566, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '890941228', 2022, 2, 514.829042922747, 3763.57246728323, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '838540049', 2022, 2, 600.27772254943, 5169.99852458783, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '809501750', 2022, 2, 442.540968191239, 583.288200185103, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '844496478', 2022, 2, 103.87933919193, 220.519678191698, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '863501025', 2022, 2, 138.345672879582, 2308.9116434958, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '839166324', 2022, 2, 667.566651645087, 660.165523623154, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '879962157', 2022, 2, 603.596704470741, 1255.12688496499, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '848543645', 2022, 2, 653.652952725408, 7416.53045832451, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '880279851', 2022, 2, 819.320804144802, 7181.7266335418, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '808671188', 2022, 2, 424.235404126622, 7070.02864322046, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '851333885', 2022, 2, 400.738532452371, 1348.13104176583, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '815366017', 2022, 2, 356.367508354935, 1004.08749289671, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '891113900', 2022, 2, 680.097489694811, 8456.47001335713, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '894926128', 2022, 2, 249.709451492608, 6541.3042868945, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '802290404', 2022, 2, 50.4446130391133, 1293.07167102284, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '896239097', 2022, 2, 394.860595637186, 5606.44376813148, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '816868949', 2022, 2, 711.864174208699, 8715.71541305296, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '895298219', 2022, 2, 305.057271411266, 4645.44339176089, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '842893897', 2022, 2, 605.206079935434, 9363.01010666643, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '814670938', 2022, 2, 279.800076590973, 6037.79249696309, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '820433803', 2022, 2, 897.447472713692, 5658.79275581565, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '874104569', 2022, 2, 667.199460880846, 5206.98106304324, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '856520283', 2022, 2, 9.31315314059652, 448.522798825042, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '879090305', 2022, 2, 897.496804366069, 8451.44531668766, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '809468321', 2022, 2, 744.02422858403, 5004.20204913856, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '826378947', 2022, 2, 127.618178308674, 2223.6826389656, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '866390365', 2022, 2, 594.239707966577, 3867.3396356567, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '862771013', 2022, 2, 827.603363197128, 2797.28090540204, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '864363318', 2022, 2, 544.84382327268, 9732.71658544369, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '896438075', 2022, 2, 643.641437148965, 665.445284751183, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '829368106', 2022, 2, 980.159155766302, 2829.40916899716, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '867407313', 2022, 2, 203.175948800613, 75.7375923828372, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '896587504', 2022, 2, 629.660229376508, 4030.14397138266, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '847845944', 2022, 2, 791.477871873841, 308.602919652502, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '826389298', 2022, 2, 585.494242375558, 1929.82856994377, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '848399886', 2022, 2, 10.3031693841596, 3908.94340138238, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '854846835', 2022, 2, 758.523929345204, 8098.17155967615, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '800634899', 2022, 2, 576.190790683342, 2097.62869010095, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '857110616', 2022, 2, 127.958689368328, 5641.57519253709, 500, 2, false, '2022-09-29 10:20:53.154984', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '808271586', 2022, 2, 470.314386519439, 5189.64800149482, 500, 2, false, '2022-09-29 10:20:53.484332', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '819801010', 2022, 2, 522.557847234916, 3395.28908485276, 500, 2, false, '2022-09-29 10:20:53.484332', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '848578637', 2022, 2, 332.235483085171, 4528.57876759673, 500, 2, false, '2022-09-29 10:20:53.484332', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '827490752', 2022, 2, 613.032723561227, 3462.91016736489, 500, 2, false, '2022-09-29 10:20:53.484332', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '835736810', 2022, 2, 346.960408519413, 83.7787969513768, 500, 2, false, '2022-09-29 10:20:53.484332', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '857544475', 2022, 2, 58.9292420514793, 1331.98550903829, 500, 2, false, '2022-09-29 10:20:53.484332', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '847721823', 2022, 2, 40.9866160091604, 3064.7231387682, 500, 2, false, '2022-09-29 10:20:53.484332', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '862581603', 2022, 2, 428.49110242207, 2044.38539516197, 500, 2, false, '2022-09-29 10:20:53.484332', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '810313500', 2022, 2, 971.133656052511, 5271.90876429445, 500, 2, false, '2022-09-29 10:20:53.484332', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '885129733', 2022, 2, 749.914981116702, 5136.03204406101, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '898243796', 2022, 2, 103.047370483386, 4403.44595276803, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '887079787', 2022, 2, 224.960481291219, 2766.13180893963, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '861058672', 2022, 2, 921.328351572376, 2270.75594150594, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '876537913', 2022, 2, 188.030610823592, 9064.59481335885, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '890597928', 2022, 2, 628.015323039495, 110.705133800128, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '842982051', 2022, 2, 767.711592238215, 2173.56391862361, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '842389667', 2022, 2, 645.359011433664, 9518.12477059086, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '820004072', 2022, 2, 540.68677292166, 9047.06659067522, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '897688257', 2022, 2, 888.7044662503, 4069.88299406182, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '837534390', 2022, 2, 889.593224030025, 177.158792999007, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '808543637', 2022, 2, 350.459210956855, 1625.05607203055, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '870201888', 2022, 2, 346.994306095947, 78.3377703732568, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '817311070', 2022, 2, 968.646461692331, 7288.86052256425, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '868012776', 2022, 2, 391.417278624976, 1916.15851639959, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '896429753', 2022, 2, 870.288360760856, 8520.91511366059, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '851603425', 2022, 2, 589.50528501186, 4534.13435457273, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '827443317', 2022, 2, 352.075544117136, 1906.43510443916, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '833362642', 2022, 2, 684.104959206125, 236.915255265475, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '882069408', 2022, 2, 941.207206716295, 5596.76956257058, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '863878944', 2022, 2, 667.860882842495, 4951.30413688324, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '866558221', 2022, 2, 141.099158270637, 3874.70799531747, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '868767855', 2022, 2, 876.245415864232, 6239.71905290308, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '875885300', 2022, 2, 233.725841315584, 620.908834802491, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '842216735', 2022, 2, 767.109497078735, 4066.03139805608, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '856920437', 2022, 2, 455.488858245033, 1718.43817364479, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '830858963', 2022, 2, 334.676444376281, 2145.76097608487, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '812434114', 2022, 2, 762.181618416555, 75.2738622203602, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '847041353', 2022, 2, 889.156482091538, 1748.8477100117, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '803269327', 2022, 2, 334.761801177392, 9992.21278356036, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '843457384', 2022, 2, 197.802296091741, 8444.62923310344, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '818306281', 2022, 2, 874.600278557932, 390.464294788414, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '844449510', 2022, 2, 233.828696046546, 8750.17649587432, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '867177223', 2022, 2, 318.72454044662, 9185.62435557057, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '883963814', 2022, 2, 868.66245718129, 7880.82719326435, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '886253015', 2022, 2, 831.01492202445, 8510.26155794657, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '895281822', 2022, 2, 294.921062647903, 7968.85403925144, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '840533481', 2022, 2, 361.089121675444, 7556.35236001392, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '839216776', 2022, 2, 574.133468739506, 8565.84742628694, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '803533948', 2022, 2, 135.045445638101, 17.0645245787108, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '827095124', 2022, 2, 124.577891878396, 2303.23256157825, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '808251981', 2022, 2, 407.763672434844, 6457.6012743182, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '817358823', 2022, 2, 330.180142029732, 5651.61232950104, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '871910327', 2022, 2, 645.964718331917, 5852.8667864148, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '866587133', 2022, 2, 995.164033689058, 2034.56942114386, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '842840788', 2022, 2, 461.854447770162, 2167.40049652916, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '812781923', 2022, 2, 219.177913208782, 1438.9177284122, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '804058381', 2022, 2, 299.645739182394, 8704.94151899496, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '811423248', 2022, 2, 283.096494452579, 3680.9245088829, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '840837641', 2022, 2, 411.615225499159, 5241.11595193846, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '818816392', 2022, 2, 360.186700748267, 3043.37885079718, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '806494928', 2022, 2, 747.16420991731, 5801.74876197957, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '893055618', 2022, 2, 910.594982115119, 3878.16890436326, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '875340822', 2022, 2, 107.116818156454, 2468.52285465094, 500, 2, false, '2022-09-29 10:20:53.595516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '818463756', 2022, 2, 835.360117269126, 9704.4216647822, 500, 2, false, '2022-09-29 10:20:53.946831', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '884152302', 2022, 2, 281.913675591195, 2658.84296292821, 500, 2, false, '2022-09-29 10:20:53.946831', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '849742742', 2022, 2, 903.649498707391, 9482.46245202717, 500, 2, false, '2022-09-29 10:20:53.946831', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '804979817', 2022, 2, 900.293892548124, 6053.47500783191, 500, 2, false, '2022-09-29 10:20:53.946831', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '814190896', 2022, 2, 214.73189238954, 5543.39531674244, 500, 2, false, '2022-09-29 10:20:53.946831', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '822331640', 2022, 2, 414.657767313084, 2475.31014794592, 500, 2, false, '2022-09-29 10:20:53.946831', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '862678317', 2022, 2, 830.120929402584, 5842.98093407796, 500, 2, false, '2022-09-29 10:20:53.946831', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '831093023', 2022, 2, 489.192150660243, 6816.1766558898, 500, 2, false, '2022-09-29 10:20:53.946831', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '874226454', 2022, 2, 574.806247325408, 8973.28587506896, 500, 2, false, '2022-09-29 10:20:53.946831', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '832436811', 2022, 2, 819.912430255773, 6708.10418733366, 500, 2, false, '2022-09-29 10:20:53.946831', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '838432048', 2022, 2, 23.7064564750952, 9033.04904392812, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '870022919', 2022, 2, 489.754033704157, 9003.71662198148, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '879268334', 2022, 2, 941.126586807229, 4140.18939407009, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '806599852', 2022, 2, 931.354734804098, 887.704080757954, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '863181199', 2022, 2, 975.216454481006, 9121.19647059238, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '863767568', 2022, 2, 176.16695174069, 1242.36603287581, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '844014636', 2022, 2, 467.283299012515, 3844.29521313924, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '866404710', 2022, 2, 806.870757551859, 7269.26497391292, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '833129946', 2022, 2, 196.513504049967, 8800.50225605435, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '846977998', 2022, 2, 427.733279933527, 80.9821738486235, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '811030348', 2022, 2, 843.011457143306, 8355.34680494784, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '890815907', 2022, 2, 174.984447041575, 6410.07553672138, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '822694021', 2022, 2, 755.523050755373, 684.644877609581, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '852558904', 2022, 2, 459.053017000683, 9224.72509300305, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '822874914', 2022, 2, 140.075084254187, 3723.41027848264, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '866646453', 2022, 2, 782.946866754383, 388.018863826152, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '881021956', 2022, 2, 32.0002834049307, 1887.06800818027, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '899291735', 2022, 2, 73.44096971497, 9079.46920345064, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '867918928', 2022, 2, 386.70385980058, 8105.72803110795, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '823439458', 2022, 2, 92.7532581296217, 6390.5200876981, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '837805347', 2022, 2, 887.890207665432, 9993.5388036346, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '805499088', 2022, 2, 644.078210499104, 2468.47696224532, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '845822610', 2022, 2, 186.448825451126, 700.842386106481, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '841405633', 2022, 2, 46.9421065372083, 3811.63033058541, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '889675608', 2022, 2, 942.083971731757, 211.28152824675, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '899025387', 2022, 2, 21.92558459378, 615.689447735512, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '863280835', 2022, 2, 621.326176788083, 8049.01058310637, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '860629673', 2022, 2, 942.121807385616, 8703.76270515847, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '833667497', 2022, 2, 646.354387054558, 6411.16708948564, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '842471044', 2022, 2, 479.138939593968, 3331.45046344995, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '861459803', 2022, 2, 828.55984667515, 8413.91605706573, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '812926032', 2022, 2, 325.105786993769, 5794.98494642644, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '871631319', 2022, 2, 617.919902921304, 6412.83228649174, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '865439281', 2022, 2, 794.115749389802, 8828.68895338491, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '824210548', 2022, 2, 811.301216090288, 8471.32744155624, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '805486005', 2022, 2, 593.723737906039, 1634.18968497433, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '832448472', 2022, 2, 106.551697508947, 1310.36950687101, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '805820685', 2022, 2, 978.452009398445, 3617.7694517756, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '883768894', 2022, 2, 34.5920613609778, 5898.10946977357, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '856903021', 2022, 2, 344.76003524749, 7264.6682235161, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '850012745', 2022, 2, 479.918949116407, 4095.37365759522, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '820149848', 2022, 2, 339.316643583401, 914.626614108621, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '822705108', 2022, 2, 627.071820574874, 4890.93323612586, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '857573851', 2022, 2, 772.536003920447, 2745.73817259717, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '856078198', 2022, 2, 88.7624875066682, 6997.09470842236, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '859225721', 2022, 2, 82.2875962838113, 3372.67692709347, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '873879874', 2022, 2, 113.514361490601, 1224.99514667477, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '890065285', 2022, 2, 507.652353058203, 4352.28263007688, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '893423280', 2022, 2, 951.097409562001, 6157.46217843612, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '816273126', 2022, 2, 888.830423548727, 7685.86276179176, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '874977909', 2022, 2, 848.023433132842, 5818.12826962395, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '888632161', 2022, 2, 303.004620926363, 1061.2244592876, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '852452427', 2022, 2, 188.820616527628, 1578.22292492484, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '807389236', 2022, 2, 444.357290582476, 8843.90799994005, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '833163111', 2022, 2, 943.865772703631, 9061.44230073257, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '813080832', 2022, 2, 612.407606531521, 1559.55606686325, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '896489260', 2022, 2, 813.500592007111, 1218.94875846325, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '845881839', 2022, 2, 347.657249116709, 9704.59858800677, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '898157169', 2022, 2, 836.483762004952, 3467.42699804979, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '882940656', 2022, 2, 478.245594752764, 9812.29840200635, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '887589106', 2022, 2, 684.823160764607, 5998.06925404169, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '856439808', 2022, 2, 393.198415440791, 8406.36098643549, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '869911712', 2022, 2, 776.861062404169, 5271.23674165325, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '836420677', 2022, 2, 237.552387641291, 2429.37847411915, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '810521018', 2022, 2, 422.472445808967, 6666.26485268115, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '863021621', 2022, 2, 982.054798647739, 3328.72351120111, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '846289494', 2022, 2, 518.063754523117, 5550.52590776327, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '834191416', 2022, 2, 68.542372889635, 4539.78114958952, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '837420340', 2022, 2, 28.822038681183, 7749.44888545539, 500, 2, false, '2022-09-29 10:20:54.016891', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '871949311', 2022, 2, 829.16864432285, 9150.78761309182, 500, 2, false, '2022-09-29 10:20:54.422489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '821633142', 2022, 2, 54.2237031359842, 328.721177384993, 500, 2, false, '2022-09-29 10:20:54.422489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '893463166', 2022, 2, 18.908207855559, 6432.5112067381, 500, 2, false, '2022-09-29 10:20:54.422489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '833218825', 2022, 2, 580.908768731935, 5338.5259109294, 500, 2, false, '2022-09-29 10:20:54.422489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '807456455', 2022, 2, 56.8528090433255, 7312.27468716872, 500, 2, false, '2022-09-29 10:20:54.422489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '821381486', 2022, 2, 407.748204655746, 5451.47359738386, 500, 2, false, '2022-09-29 10:20:54.422489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '814324199', 2022, 2, 906.57503614135, 5701.54856809281, 500, 2, false, '2022-09-29 10:20:54.422489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '805904949', 2022, 2, 303.832101779495, 9795.09100783436, 500, 2, false, '2022-09-29 10:20:54.422489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '813242515', 2022, 2, 246.123121161476, 770.632470326922, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '839415843', 2022, 2, 376.772202234122, 6640.71074311576, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '804234371', 2022, 2, 645.061283184396, 4564.31941457406, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '816585946', 2022, 2, 605.65478689937, 31.2109210311665, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '824097835', 2022, 2, 413.690909149698, 4722.66070671499, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '880538674', 2022, 2, 452.5516482044, 6907.84305514347, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '875775705', 2022, 2, 615.313128242727, 9650.591546129, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '877421692', 2022, 2, 184.887988389884, 354.280621487855, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '871547736', 2022, 2, 829.724252347222, 6436.9002757169, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '857653378', 2022, 2, 167.612628979166, 8348.50101181201, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '829980700', 2022, 2, 959.063224760765, 1143.63277649249, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '852627790', 2022, 2, 890.864482935092, 3338.17574173151, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '865978526', 2022, 2, 646.94496636677, 4980.77009853352, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '840145629', 2022, 2, 883.58222060192, 7335.95356236554, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '875016141', 2022, 2, 701.069448538329, 8002.91285669499, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '869419134', 2022, 2, 367.96371264405, 2611.67659885709, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '813944600', 2022, 2, 19.2501208919632, 8644.52061404167, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '885600454', 2022, 2, 119.384352381103, 1757.58269364383, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '877550656', 2022, 2, 251.787085373007, 3935.82887642592, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '804227830', 2022, 2, 734.590354859009, 8581.44265427372, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '858956619', 2022, 2, 812.806365734309, 1060.91136632368, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '865153645', 2022, 2, 890.139690583551, 6113.48210024534, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '817941723', 2022, 2, 328.305495836184, 2095.50425476082, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '811667993', 2022, 2, 635.865986326446, 2940.1784010939, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '859462534', 2022, 2, 937.373786476326, 5941.94654093621, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '822317092', 2022, 2, 293.497251782434, 8.00325706274968, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '877772835', 2022, 2, 322.115181922454, 3394.36757099991, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '846495295', 2022, 2, 693.502772184402, 426.610092044423, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '804775869', 2022, 2, 980.059274221883, 8494.07604933587, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '831030012', 2022, 2, 209.755951103216, 3383.26717700665, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '802809462', 2022, 2, 299.661257034302, 6365.84941575755, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '896200151', 2022, 2, 519.183393692819, 4505.73635784566, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '873610100', 2022, 2, 518.332101184117, 8340.61008586734, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '847931581', 2022, 2, 961.940568596236, 4612.87789898907, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '870810427', 2022, 2, 81.0456949435025, 5856.30044197296, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '816457914', 2022, 2, 248.163120736453, 8281.47889615596, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '816760477', 2022, 2, 530.352577602285, 8674.96563228249, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '821449527', 2022, 2, 333.257026927041, 1734.4264354612, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '897412997', 2022, 2, 385.333201456305, 6000.88305956246, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '801856356', 2022, 2, 458.314989509272, 1218.83871962516, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '898170941', 2022, 2, 467.671295876077, 7458.76420304298, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '884390144', 2022, 2, 365.467758339461, 7391.50681978546, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '894424841', 2022, 2, 222.149740019635, 1934.89630927938, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '828972512', 2022, 2, 414.893512522063, 3446.66891203291, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '815082581', 2022, 2, 202.73126295699, 774.742690135402, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '887159012', 2022, 2, 436.221292475553, 7430.94816673368, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '829493874', 2022, 2, 564.309833219887, 3747.36918213642, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '814929193', 2022, 2, 141.832942557767, 5701.98636548644, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '859907302', 2022, 2, 564.521159214398, 7076.50700159248, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '895124699', 2022, 2, 795.188125209121, 2964.15782657263, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '813239227', 2022, 2, 585.562670464599, 9164.11724686895, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '840430296', 2022, 2, 734.908417290829, 9144.63801456639, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '858726639', 2022, 2, 777.875766329619, 9309.57182033371, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '823234800', 2022, 2, 431.370138923682, 2032.82333697496, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '874361830', 2022, 2, 441.330603713577, 3363.46087986697, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '808481735', 2022, 2, 928.11710871189, 1531.63323125561, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '860499175', 2022, 2, 807.693104182806, 4271.16170422299, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '892697142', 2022, 2, 320.651654741588, 5954.14412921473, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '826727890', 2022, 2, 146.739956961153, 1054.10425419209, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '895582762', 2022, 2, 999.977944555549, 3433.76873320909, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '814663914', 2022, 2, 280.525323400887, 7106.00871776062, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '887191975', 2022, 2, 476.83490717115, 5614.87290310624, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '856729012', 2022, 2, 763.732278863584, 4212.66016256783, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '816248533', 2022, 2, 613.379615776892, 1953.01929747365, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '847253663', 2022, 2, 156.263217686672, 3437.4286969741, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '851556995', 2022, 2, 347.249685550091, 4960.73515981424, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '897000352', 2022, 2, 379.753027393897, 2964.14868361644, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '891267708', 2022, 2, 524.107691494447, 6593.70385897035, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '868369009', 2022, 2, 758.094060830476, 4245.75343489243, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '836786224', 2022, 2, 976.327817678797, 384.687123691404, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '800910790', 2022, 2, 456.253369353592, 1808.14219534316, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '847922087', 2022, 2, 497.870049949445, 2449.17668529469, 500, 2, false, '2022-09-29 10:20:54.509725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '882737279', 2022, 2, 996.643179343406, 1534.82328038057, 500, 2, false, '2022-09-29 10:20:54.866569', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '817612413', 2022, 2, 915.481731905447, 2621.32631376229, 500, 2, false, '2022-09-29 10:20:54.866569', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '857680168', 2022, 2, 608.796060013304, 9197.25243293067, 500, 2, false, '2022-09-29 10:20:54.866569', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '878624841', 2022, 2, 330.829567855117, 141.28131886658, 500, 2, false, '2022-09-29 10:20:54.866569', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '867183919', 2022, 2, 251.906241962864, 8424.41193770531, 500, 2, false, '2022-09-29 10:20:54.866569', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '824306551', 2022, 2, 35.7886614547424, 3056.65047012715, 500, 2, false, '2022-09-29 10:20:54.866569', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '812929350', 2022, 2, 726.541229134805, 5677.90330506678, 500, 2, false, '2022-09-29 10:20:54.866569', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '890735735', 2022, 2, 682.984839354115, 1694.44376417931, 500, 2, false, '2022-09-29 10:20:54.866569', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '894341616', 2022, 2, 386.861119607075, 3770.79184971496, 500, 2, false, '2022-09-29 10:20:54.866569', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '845690609', 2022, 2, 483.995300766722, 7616.60459070428, 500, 2, false, '2022-09-29 10:20:54.866569', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '884945724', 2022, 2, 886.834860738563, 878.756880888937, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '820865124', 2022, 2, 900.564888576439, 3948.56833192359, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '870514368', 2022, 2, 276.71021392879, 2879.35481686902, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '833643869', 2022, 2, 217.190684937215, 875.212194454038, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '807702188', 2022, 2, 407.083653010591, 2575.32781661255, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '820638689', 2022, 2, 218.223679547724, 2807.19833192765, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '843380901', 2022, 2, 458.985319899902, 9678.37565775875, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '832951634', 2022, 2, 838.777810355881, 7360.26069781577, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '833677243', 2022, 2, 995.329114250995, 6798.8428186884, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '873656323', 2022, 2, 87.778674441873, 7723.30271304732, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '859159231', 2022, 2, 806.497259624269, 8097.52940995904, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '868067017', 2022, 2, 41.1575861305404, 8345.29612105237, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '856435712', 2022, 2, 583.95166915014, 8019.58180081577, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '888937591', 2022, 2, 731.314606414099, 2692.79597282444, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '873906284', 2022, 2, 974.959318748243, 5457.37110046079, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '855150484', 2022, 2, 384.654044373214, 4367.48397316486, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '836365546', 2022, 2, 615.036101965352, 2136.00248568258, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '822564929', 2022, 2, 450.828125169516, 3197.70807611174, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '833204596', 2022, 2, 622.3731503225, 5096.72509455613, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '863592645', 2022, 2, 977.202519114099, 3400.60055832587, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '865956727', 2022, 2, 688.569834042433, 7715.85493760027, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '807629933', 2022, 2, 928.459495590299, 2276.67818110411, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '832454631', 2022, 2, 766.680639544465, 1917.61113303524, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '823356725', 2022, 2, 721.09709476719, 4518.61919657737, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '800824855', 2022, 2, 160.777978717182, 8364.49413138096, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '894510083', 2022, 2, 419.605571119123, 385.059660081721, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '815854671', 2022, 2, 200.15841215833, 5508.61323646516, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '876401827', 2022, 2, 413.888684724991, 3828.50922249956, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '845066027', 2022, 2, 865.97811327221, 1867.58806347831, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '815406101', 2022, 2, 399.283951000548, 1650.06351074782, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '866878310', 2022, 2, 770.522923213682, 5989.67377650467, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '830803739', 2022, 2, 891.266112329402, 5453.529740622, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '805933483', 2022, 2, 325.929683340771, 9212.89585839843, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '868252144', 2022, 2, 652.217085834021, 6143.97643434767, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '828744326', 2022, 2, 990.144874167507, 5596.82848229537, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '830122600', 2022, 2, 313.978030510374, 4351.47338421288, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '813147327', 2022, 2, 33.3156677518955, 4702.4650098312, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '846250295', 2022, 2, 633.807707018792, 8249.51825852579, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '898250721', 2022, 2, 565.10337380955, 789.354678859742, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '813697349', 2022, 2, 818.149979656287, 3650.84864235419, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '863104800', 2022, 2, 465.023921868006, 8431.51449326362, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '897979593', 2022, 2, 728.389962045769, 4212.15075342112, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '860772161', 2022, 2, 924.159544380899, 9181.57042132563, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '808002552', 2022, 2, 727.512191130346, 4365.64773401387, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '876394411', 2022, 2, 903.316997595082, 3980.86341107842, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '846214156', 2022, 2, 921.949197427837, 9659.50818434803, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '850015354', 2022, 2, 684.548547366918, 4005.27791697418, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '805145991', 2022, 2, 758.251957678037, 3049.80878326369, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '853879838', 2022, 2, 877.052591109651, 3379.45777889375, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '882939801', 2022, 2, 630.459175458028, 4563.50784711584, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '859605190', 2022, 2, 665.816377241079, 4637.30817571019, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '891814367', 2022, 2, 452.780869238088, 4179.68444697507, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '875021136', 2022, 2, 517.285629600811, 4868.51757184279, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '825379831', 2022, 2, 791.617647509965, 4207.20327226514, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '800469195', 2022, 2, 440.851916438914, 6058.56755191462, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '871244244', 2022, 2, 449.207872205357, 3579.46461079727, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '837133219', 2022, 2, 380.443845291828, 7872.43512680811, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '855964219', 2022, 2, 809.767298476268, 8970.1660943589, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '838273484', 2022, 2, 99.2039923851798, 8153.74575585767, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '893483616', 2022, 2, 945.034627393651, 1328.58869837518, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '891497759', 2022, 2, 768.232937112269, 3629.2513846631, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '888247901', 2022, 2, 216.046280003413, 8743.3637836932, 500, 2, false, '2022-09-29 10:20:54.935277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '883590490', 2022, 2, 595.524723613779, 5999.98789356619, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '804908767', 2022, 2, 867.220467617724, 1425.45914019611, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '851919134', 2022, 2, 62.4457791067687, 6056.98557559014, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '813682750', 2022, 2, 527.332986301347, 3628.91689304919, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '875544956', 2022, 2, 762.64123645895, 9359.31960406893, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '889472231', 2022, 2, 235.670111505079, 1922.04537908092, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '875631634', 2022, 2, 557.260507406361, 3787.35051285759, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '856007783', 2022, 2, 576.876375205255, 6630.64773449761, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '844760467', 2022, 2, 192.21633662868, 4551.67853064096, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '863256691', 2022, 2, 174.514472732833, 9104.10107321624, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '851705582', 2022, 2, 66.5220332335165, 4407.47496435756, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '854298834', 2022, 2, 341.515131406552, 4507.57428583402, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '836216435', 2022, 2, 508.373585524768, 1370.43538107982, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '893017297', 2022, 2, 164.083176849977, 4145.94136360696, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '841372032', 2022, 2, 816.632286889358, 5446.28544266212, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '862589424', 2022, 2, 367.745753290697, 9102.39851144552, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '871501781', 2022, 2, 180.600187089807, 3058.72847036717, 500, 2, false, '2022-09-29 10:20:55.234844', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '880977356', 2022, 2, 338.058462852945, 5572.75054029388, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '859708655', 2022, 2, 864.36599296341, 367.461208959396, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '837130075', 2022, 2, 558.571880480611, 1372.74803376598, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '803170681', 2022, 2, 520.855462992948, 8240.83999669451, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '875018446', 2022, 2, 355.060838990867, 336.371097150406, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '872251225', 2022, 2, 769.470089100908, 5656.5062478555, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '889927472', 2022, 2, 263.919084382842, 6769.95249189119, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '850310272', 2022, 2, 494.528783480882, 8114.5825117693, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '878277970', 2022, 2, 553.475057743737, 8414.72075657704, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '811324382', 2022, 2, 225.558566062293, 9280.33812244693, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '878265174', 2022, 2, 877.870230061472, 5736.12880990908, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '803799726', 2022, 2, 916.207220156465, 645.93899681452, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '827344157', 2022, 2, 610.979503255856, 583.867782511227, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '868610918', 2022, 2, 30.8862640391975, 4837.51310721735, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '891144647', 2022, 2, 41.6566153318467, 52.4882191860751, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '874750888', 2022, 2, 925.129992610649, 1947.89650422866, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '879572863', 2022, 2, 992.804555622509, 469.057785871404, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '816719384', 2022, 2, 47.4154441548662, 103.033204022831, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '823372812', 2022, 2, 410.603461077214, 5965.43683418658, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '872671153', 2022, 2, 948.511085983615, 7672.11364141848, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '837782686', 2022, 2, 342.615660018289, 7045.8445019432, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '856373244', 2022, 2, 575.540831619413, 1392.04673483531, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '802319687', 2022, 2, 455.37494842858, 3153.02700222903, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '882221112', 2022, 2, 218.281359414327, 1272.16995850025, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '825823538', 2022, 2, 899.260765312299, 7617.47706290543, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '840744367', 2022, 2, 128.128949110487, 7625.05842182361, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '807485242', 2022, 2, 900.280644173878, 986.876621150951, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '878321914', 2022, 2, 701.167163693976, 7019.24273762153, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '886892017', 2022, 2, 570.315382554307, 4708.36835320754, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '871623349', 2022, 2, 426.434067221531, 6475.85357901123, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '864986459', 2022, 2, 489.221377098205, 2435.32349099421, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '849227492', 2022, 2, 414.297120551393, 5165.41251080763, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '850910144', 2022, 2, 505.97131474034, 4142.57934937143, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '869658223', 2022, 2, 854.709639941969, 1493.96518924388, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '866431270', 2022, 2, 994.44514095254, 7449.31600147575, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '858356342', 2022, 2, 587.181111927652, 2162.12581110303, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '852467356', 2022, 2, 276.932298583769, 4018.78596363288, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '898657961', 2022, 2, 790.391235368052, 2971.61829456198, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '846849579', 2022, 2, 386.786244628805, 110.623349315632, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '873579899', 2022, 2, 121.813442069595, 1562.37492545355, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '843035298', 2022, 2, 395.215931433454, 6490.14614715134, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '858836952', 2022, 2, 963.902872586992, 9552.17516530074, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '805709917', 2022, 2, 827.277244004283, 5007.14737935449, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '808479485', 2022, 2, 234.236467436611, 7024.25257087677, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '838878962', 2022, 2, 755.022157600231, 9421.48034847799, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '885625328', 2022, 2, 838.055609758114, 3336.31478099235, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '837527996', 2022, 2, 711.668251460008, 6551.38489599012, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '844848494', 2022, 2, 993.687678031416, 8121.11858371263, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '825573136', 2022, 2, 711.910946296889, 9640.49582569489, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '809036318', 2022, 2, 982.373244776878, 4138.33856401524, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '800223332', 2022, 2, 398.907326085592, 8486.29718945855, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '878112453', 2022, 2, 896.511890256505, 571.242009896525, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '893781546', 2022, 2, 773.12423145358, 5590.22121132968, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '818658010', 2022, 2, 931.867875295585, 1836.09616699284, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '862270603', 2022, 2, 584.196279761312, 7354.12293260762, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '812325897', 2022, 2, 425.379039883505, 3624.42941306868, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '817554736', 2022, 2, 583.578260968152, 9461.53063487818, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '884291457', 2022, 2, 419.291739070827, 4773.21139106323, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '890910485', 2022, 2, 170.730767939483, 7425.12013418383, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '810677960', 2022, 2, 167.594338833731, 5329.08282024607, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '830621787', 2022, 2, 921.487060528919, 2164.03305047664, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '874792210', 2022, 2, 953.633335795171, 9170.33499072014, 500, 2, false, '2022-09-29 10:20:55.333101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '828718942', 2022, 2, 703.069190792259, 839.720342248851, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '846277869', 2022, 2, 769.303510786358, 6228.51119460596, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '809316543', 2022, 2, 131.254926692326, 9460.42928272008, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '846821438', 2022, 2, 448.1340085048, 2042.45772825137, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '836005340', 2022, 2, 296.852257613787, 6932.84560833007, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '869069081', 2022, 2, 258.933815922267, 2125.67055591102, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '824870495', 2022, 2, 86.2130202670594, 5926.4879271805, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '821850314', 2022, 2, 800.44930006884, 3910.89904009565, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '895629317', 2022, 2, 375.311706552901, 879.725396409024, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '854843256', 2022, 2, 104.685395460957, 7182.93697136643, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '825397589', 2022, 2, 792.019965235367, 5363.43199512778, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '856901774', 2022, 2, 210.171607932843, 7665.86310682211, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '886566656', 2022, 2, 85.9808839390255, 3960.42317123678, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '868634250', 2022, 2, 777.582421039285, 7496.91132013646, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '827178297', 2022, 2, 112.981925746964, 7414.91983154656, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '889901026', 2022, 2, 131.140623739394, 5587.33745870762, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '860932226', 2022, 2, 276.193355426762, 2751.44561762854, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '883640440', 2022, 2, 201.624482921012, 8854.64069052404, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '899511765', 2022, 2, 974.870965782294, 7191.20103925625, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '826671551', 2022, 2, 722.328335742094, 9155.20105332815, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '838991015', 2022, 2, 948.461905839073, 2618.34347537707, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '831768843', 2022, 2, 748.330904027141, 7245.30389312044, 500, 2, false, '2022-09-29 10:20:55.590491', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '803324193', 2022, 2, 200.981090731006, 7674.21555775369, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '827269180', 2022, 2, 196.863426900763, 1716.95203035721, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '806938796', 2022, 2, 113.130214140041, 2253.1586930117, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '817130185', 2022, 2, 864.413359986071, 6731.75644262018, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '810402680', 2022, 2, 793.60063538945, 8292.11452603982, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '887841956', 2022, 2, 124.482559983787, 719.223659311418, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '897336611', 2022, 2, 788.760536685244, 4140.44271554957, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '858728795', 2022, 2, 613.940960899611, 6581.1169221178, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '880050743', 2022, 2, 381.844394660726, 4173.61092390333, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '871161662', 2022, 2, 800.222957939618, 2978.85130426805, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '862924848', 2022, 2, 781.884012703216, 9807.93726425601, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '895031114', 2022, 2, 173.550096995465, 2294.97494439634, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '815517829', 2022, 2, 692.97781090853, 3949.27711100082, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '836666246', 2022, 2, 95.3247050641553, 3027.36129205864, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '845715533', 2022, 2, 333.737712982898, 2953.08044147127, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '897156462', 2022, 2, 916.973700457689, 6271.66202110188, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '890815244', 2022, 2, 997.98036272083, 6646.18593187102, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '866562589', 2022, 2, 321.683174961515, 5438.82892570586, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '875322390', 2022, 2, 50.7385699501184, 5154.17400071839, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '870376312', 2022, 2, 872.436277745236, 6906.63623855428, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '863074238', 2022, 2, 754.433474289995, 756.116136316642, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '873535604', 2022, 2, 783.625542830898, 5002.00453815335, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '820029647', 2022, 2, 141.705368789681, 588.732161197892, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '825514130', 2022, 2, 455.294430737889, 6173.87972981041, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '815801592', 2022, 2, 102.433963237592, 2778.03820599664, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '839528084', 2022, 2, 393.278307898664, 9778.17568382612, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '864571830', 2022, 2, 600.081960461816, 4773.4658085526, 500, 2, false, '2022-09-29 10:20:55.691374', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '883989256', 2022, 2, 854.249049056694, 952.591902945937, 500, 2, false, '2022-09-29 10:20:55.930384', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '831272011', 2022, 2, 257.636511069245, 2514.40071043603, 500, 2, false, '2022-09-29 10:20:55.947139', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '831658088', 2022, 2, 130.412375401154, 880.285953441633, 500, 2, false, '2022-09-29 10:20:55.967619', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '802008121', 2022, 2, 710.189673126794, 6549.99451157685, 500, 2, false, '2022-09-29 10:20:55.967619', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '857721878', 2022, 2, 889.795150914071, 2637.83536729051, 500, 2, false, '2022-09-29 10:20:55.967619', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '811747377', 2022, 2, 181.350353304241, 5429.75809037987, 500, 2, false, '2022-09-29 10:20:55.996993', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '801396893', 2022, 2, 863.113101600777, 5077.43349003858, 500, 2, false, '2022-09-29 10:20:55.996993', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '885133950', 2022, 2, 246.827795475741, 756.541358447906, 500, 2, false, '2022-09-29 10:20:55.996993', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '864761302', 2022, 2, 665.140161040219, 2646.29904632127, 500, 2, false, '2022-09-29 10:20:55.996993', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '870050263', 2022, 2, 56.0454775181249, 2963.42629475765, 500, 2, false, '2022-09-29 10:20:55.996993', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '881536611', 2022, 2, 733.225939601403, 5095.95982931819, 500, 2, false, '2022-09-29 10:20:56.03085', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '862811969', 2022, 2, 313.403868133873, 341.901805154919, 500, 2, false, '2022-09-29 10:20:56.03085', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '892708443', 2022, 2, 379.071905240243, 4283.48583550885, 500, 2, false, '2022-09-29 10:20:56.03085', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '866931781', 2022, 2, 347.665605687064, 3489.69910397753, 500, 2, false, '2022-09-29 10:20:56.03085', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '868378133', 2022, 2, 634.842003987914, 8066.96540314107, 500, 2, false, '2022-09-29 10:20:56.03085', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '872308278', 2022, 2, 355.459853926877, 7.01011493551947, 500, 2, false, '2022-09-29 10:20:56.066889', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (533, '854032309', 2022, 2, 475.959241241771, 3920.21489627557, 500, 2, false, '2022-09-29 10:20:56.066889', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (534, '842782667', 2022, 2, 226.289429837014, 8750.65573920642, 500, 2, false, '2022-09-29 10:20:56.066889', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (535, '846058502', 2022, 2, 56.4765017311665, 40.7797460558313, 500, 2, false, '2022-09-29 10:20:59.694179', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (536, '878151780', 2022, 2, 769.349164346695, 4587.38914024835, 500, 15, false, '2022-09-29 10:20:59.713461', NULL);


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.559177', '2022-09-29 10:20:48.559177');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.570795', '2022-09-29 10:20:48.570795');
INSERT INTO public.virksomhet VALUES (3, '984247664', 'Norge', 'NO', '0663', 'Oslo', 'OSLO', '0301', 'NAV Arbeidslivssenter Oslo', '{"C. J. Hambros plass 2","0164 OSLO"}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.582466', '2022-09-29 10:20:48.582466');
INSERT INTO public.virksomhet VALUES (4, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.594279', '2022-09-29 10:20:48.594279');
INSERT INTO public.virksomhet VALUES (5, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.604283', '2022-09-29 10:20:48.604283');
INSERT INTO public.virksomhet VALUES (6, '800061965', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800061965', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.616035', '2022-09-29 10:20:48.616035');
INSERT INTO public.virksomhet VALUES (7, '881532376', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881532376', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.625687', '2022-09-29 10:20:48.625687');
INSERT INTO public.virksomhet VALUES (8, '883874352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883874352', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.634752', '2022-09-29 10:20:48.634752');
INSERT INTO public.virksomhet VALUES (9, '848147638', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848147638', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.643605', '2022-09-29 10:20:48.643605');
INSERT INTO public.virksomhet VALUES (10, '876763949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876763949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.651296', '2022-09-29 10:20:48.651296');
INSERT INTO public.virksomhet VALUES (11, '871871807', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871871807', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.66008', '2022-09-29 10:20:48.66008');
INSERT INTO public.virksomhet VALUES (12, '864079801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864079801', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.667187', '2022-09-29 10:20:48.667187');
INSERT INTO public.virksomhet VALUES (13, '836041617', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836041617', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.674183', '2022-09-29 10:20:48.674183');
INSERT INTO public.virksomhet VALUES (14, '857842260', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857842260', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.681435', '2022-09-29 10:20:48.681435');
INSERT INTO public.virksomhet VALUES (15, '885073621', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885073621', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.689722', '2022-09-29 10:20:48.689722');
INSERT INTO public.virksomhet VALUES (16, '864754605', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864754605', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.697317', '2022-09-29 10:20:48.697317');
INSERT INTO public.virksomhet VALUES (17, '846347581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846347581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.704315', '2022-09-29 10:20:48.704315');
INSERT INTO public.virksomhet VALUES (18, '824680794', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824680794', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.711336', '2022-09-29 10:20:48.711336');
INSERT INTO public.virksomhet VALUES (19, '839415001', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839415001', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.717691', '2022-09-29 10:20:48.717691');
INSERT INTO public.virksomhet VALUES (20, '861744528', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861744528', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.725366', '2022-09-29 10:20:48.725366');
INSERT INTO public.virksomhet VALUES (21, '860138909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860138909', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.732821', '2022-09-29 10:20:48.732821');
INSERT INTO public.virksomhet VALUES (22, '843242104', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843242104', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.739611', '2022-09-29 10:20:48.739611');
INSERT INTO public.virksomhet VALUES (23, '890093850', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890093850', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.746438', '2022-09-29 10:20:48.746438');
INSERT INTO public.virksomhet VALUES (24, '892511017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892511017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.753508', '2022-09-29 10:20:48.753508');
INSERT INTO public.virksomhet VALUES (25, '842605109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842605109', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.760342', '2022-09-29 10:20:48.760342');
INSERT INTO public.virksomhet VALUES (26, '870491047', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870491047', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.76679', '2022-09-29 10:20:48.76679');
INSERT INTO public.virksomhet VALUES (27, '863507760', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863507760', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.772952', '2022-09-29 10:20:48.772952');
INSERT INTO public.virksomhet VALUES (28, '817257908', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817257908', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.779204', '2022-09-29 10:20:48.779204');
INSERT INTO public.virksomhet VALUES (29, '809042383', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809042383', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.784812', '2022-09-29 10:20:48.784812');
INSERT INTO public.virksomhet VALUES (30, '810734693', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810734693', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.791018', '2022-09-29 10:20:48.791018');
INSERT INTO public.virksomhet VALUES (31, '804629062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804629062', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.797899', '2022-09-29 10:20:48.797899');
INSERT INTO public.virksomhet VALUES (32, '873621335', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873621335', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.805918', '2022-09-29 10:20:48.805918');
INSERT INTO public.virksomhet VALUES (33, '835058832', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835058832', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.813785', '2022-09-29 10:20:48.813785');
INSERT INTO public.virksomhet VALUES (34, '803826652', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803826652', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.821723', '2022-09-29 10:20:48.821723');
INSERT INTO public.virksomhet VALUES (35, '874394467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874394467', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.829129', '2022-09-29 10:20:48.829129');
INSERT INTO public.virksomhet VALUES (36, '838903289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838903289', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.835901', '2022-09-29 10:20:48.835901');
INSERT INTO public.virksomhet VALUES (37, '882051647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882051647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.843164', '2022-09-29 10:20:48.843164');
INSERT INTO public.virksomhet VALUES (38, '879681201', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879681201', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.848553', '2022-09-29 10:20:48.848553');
INSERT INTO public.virksomhet VALUES (39, '852409131', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852409131', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.854494', '2022-09-29 10:20:48.854494');
INSERT INTO public.virksomhet VALUES (40, '808215075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808215075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.861843', '2022-09-29 10:20:48.861843');
INSERT INTO public.virksomhet VALUES (41, '865074415', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865074415', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.868226', '2022-09-29 10:20:48.868226');
INSERT INTO public.virksomhet VALUES (42, '836669149', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836669149', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.874647', '2022-09-29 10:20:48.874647');
INSERT INTO public.virksomhet VALUES (43, '884369776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884369776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.880671', '2022-09-29 10:20:48.880671');
INSERT INTO public.virksomhet VALUES (44, '873418367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873418367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.886544', '2022-09-29 10:20:48.886544');
INSERT INTO public.virksomhet VALUES (45, '802905016', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802905016', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.895288', '2022-09-29 10:20:48.895288');
INSERT INTO public.virksomhet VALUES (46, '885609899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885609899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.901199', '2022-09-29 10:20:48.901199');
INSERT INTO public.virksomhet VALUES (47, '860836918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860836918', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.90731', '2022-09-29 10:20:48.90731');
INSERT INTO public.virksomhet VALUES (48, '829745509', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829745509', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.913054', '2022-09-29 10:20:48.913054');
INSERT INTO public.virksomhet VALUES (49, '844246611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844246611', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.918084', '2022-09-29 10:20:48.918084');
INSERT INTO public.virksomhet VALUES (50, '867216743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867216743', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.923703', '2022-09-29 10:20:48.923703');
INSERT INTO public.virksomhet VALUES (51, '890941228', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890941228', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.929899', '2022-09-29 10:20:48.929899');
INSERT INTO public.virksomhet VALUES (52, '838540049', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838540049', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.935291', '2022-09-29 10:20:48.935291');
INSERT INTO public.virksomhet VALUES (53, '809501750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809501750', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.940871', '2022-09-29 10:20:48.940871');
INSERT INTO public.virksomhet VALUES (54, '844496478', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844496478', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.94719', '2022-09-29 10:20:48.94719');
INSERT INTO public.virksomhet VALUES (55, '863501025', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863501025', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.952576', '2022-09-29 10:20:48.952576');
INSERT INTO public.virksomhet VALUES (56, '839166324', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839166324', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.957846', '2022-09-29 10:20:48.957846');
INSERT INTO public.virksomhet VALUES (57, '879962157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879962157', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.963099', '2022-09-29 10:20:48.963099');
INSERT INTO public.virksomhet VALUES (58, '848543645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848543645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.968088', '2022-09-29 10:20:48.968088');
INSERT INTO public.virksomhet VALUES (59, '880279851', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880279851', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.973167', '2022-09-29 10:20:48.973167');
INSERT INTO public.virksomhet VALUES (60, '808671188', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808671188', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.977788', '2022-09-29 10:20:48.977788');
INSERT INTO public.virksomhet VALUES (61, '851333885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851333885', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.982218', '2022-09-29 10:20:48.982218');
INSERT INTO public.virksomhet VALUES (62, '815366017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815366017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.986378', '2022-09-29 10:20:48.986378');
INSERT INTO public.virksomhet VALUES (63, '891113900', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891113900', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.990925', '2022-09-29 10:20:48.990925');
INSERT INTO public.virksomhet VALUES (64, '894926128', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894926128', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.995433', '2022-09-29 10:20:48.995433');
INSERT INTO public.virksomhet VALUES (65, '802290404', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802290404', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:48.999818', '2022-09-29 10:20:48.999818');
INSERT INTO public.virksomhet VALUES (66, '896239097', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896239097', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.004774', '2022-09-29 10:20:49.004774');
INSERT INTO public.virksomhet VALUES (67, '816868949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816868949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.009228', '2022-09-29 10:20:49.009228');
INSERT INTO public.virksomhet VALUES (68, '895298219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895298219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.014236', '2022-09-29 10:20:49.014236');
INSERT INTO public.virksomhet VALUES (69, '842893897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842893897', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.018927', '2022-09-29 10:20:49.018927');
INSERT INTO public.virksomhet VALUES (70, '814670938', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814670938', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.024389', '2022-09-29 10:20:49.024389');
INSERT INTO public.virksomhet VALUES (71, '820433803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820433803', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.02954', '2022-09-29 10:20:49.02954');
INSERT INTO public.virksomhet VALUES (72, '874104569', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874104569', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.035062', '2022-09-29 10:20:49.035062');
INSERT INTO public.virksomhet VALUES (73, '856520283', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856520283', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.040783', '2022-09-29 10:20:49.040783');
INSERT INTO public.virksomhet VALUES (74, '879090305', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879090305', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.045884', '2022-09-29 10:20:49.045884');
INSERT INTO public.virksomhet VALUES (75, '809468321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809468321', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.051072', '2022-09-29 10:20:49.051072');
INSERT INTO public.virksomhet VALUES (76, '826378947', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826378947', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.056747', '2022-09-29 10:20:49.056747');
INSERT INTO public.virksomhet VALUES (77, '866390365', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866390365', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.06188', '2022-09-29 10:20:49.06188');
INSERT INTO public.virksomhet VALUES (78, '862771013', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862771013', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.066817', '2022-09-29 10:20:49.066817');
INSERT INTO public.virksomhet VALUES (79, '864363318', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864363318', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.072615', '2022-09-29 10:20:49.072615');
INSERT INTO public.virksomhet VALUES (80, '896438075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896438075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.078554', '2022-09-29 10:20:49.078554');
INSERT INTO public.virksomhet VALUES (81, '829368106', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829368106', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.08395', '2022-09-29 10:20:49.08395');
INSERT INTO public.virksomhet VALUES (82, '867407313', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867407313', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.090099', '2022-09-29 10:20:49.090099');
INSERT INTO public.virksomhet VALUES (83, '896587504', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896587504', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.095991', '2022-09-29 10:20:49.095991');
INSERT INTO public.virksomhet VALUES (84, '847845944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847845944', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.101352', '2022-09-29 10:20:49.101352');
INSERT INTO public.virksomhet VALUES (85, '826389298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826389298', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.107164', '2022-09-29 10:20:49.107164');
INSERT INTO public.virksomhet VALUES (86, '848399886', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848399886', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.113488', '2022-09-29 10:20:49.113488');
INSERT INTO public.virksomhet VALUES (87, '854846835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854846835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.119117', '2022-09-29 10:20:49.119117');
INSERT INTO public.virksomhet VALUES (88, '800634899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800634899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.125182', '2022-09-29 10:20:49.125182');
INSERT INTO public.virksomhet VALUES (89, '857110616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857110616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.130302', '2022-09-29 10:20:49.130302');
INSERT INTO public.virksomhet VALUES (90, '808271586', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808271586', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.135383', '2022-09-29 10:20:49.135383');
INSERT INTO public.virksomhet VALUES (91, '819801010', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819801010', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.140653', '2022-09-29 10:20:49.140653');
INSERT INTO public.virksomhet VALUES (92, '848578637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848578637', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.146313', '2022-09-29 10:20:49.146313');
INSERT INTO public.virksomhet VALUES (93, '827490752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827490752', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.151566', '2022-09-29 10:20:49.151566');
INSERT INTO public.virksomhet VALUES (94, '835736810', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835736810', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.15629', '2022-09-29 10:20:49.15629');
INSERT INTO public.virksomhet VALUES (95, '857544475', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857544475', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.160862', '2022-09-29 10:20:49.160862');
INSERT INTO public.virksomhet VALUES (96, '847721823', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847721823', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.165627', '2022-09-29 10:20:49.165627');
INSERT INTO public.virksomhet VALUES (97, '862581603', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862581603', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.170303', '2022-09-29 10:20:49.170303');
INSERT INTO public.virksomhet VALUES (98, '810313500', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810313500', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.175089', '2022-09-29 10:20:49.175089');
INSERT INTO public.virksomhet VALUES (99, '885129733', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885129733', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.179624', '2022-09-29 10:20:49.179624');
INSERT INTO public.virksomhet VALUES (100, '898243796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898243796', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.183787', '2022-09-29 10:20:49.183787');
INSERT INTO public.virksomhet VALUES (101, '887079787', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887079787', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.187719', '2022-09-29 10:20:49.187719');
INSERT INTO public.virksomhet VALUES (102, '861058672', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861058672', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.192063', '2022-09-29 10:20:49.192063');
INSERT INTO public.virksomhet VALUES (103, '876537913', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876537913', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.196374', '2022-09-29 10:20:49.196374');
INSERT INTO public.virksomhet VALUES (104, '890597928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890597928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.20071', '2022-09-29 10:20:49.20071');
INSERT INTO public.virksomhet VALUES (105, '842982051', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842982051', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.205248', '2022-09-29 10:20:49.205248');
INSERT INTO public.virksomhet VALUES (106, '842389667', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842389667', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.209693', '2022-09-29 10:20:49.209693');
INSERT INTO public.virksomhet VALUES (107, '820004072', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820004072', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.214142', '2022-09-29 10:20:49.214142');
INSERT INTO public.virksomhet VALUES (108, '897688257', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897688257', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.218525', '2022-09-29 10:20:49.218525');
INSERT INTO public.virksomhet VALUES (109, '837534390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837534390', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.223023', '2022-09-29 10:20:49.223023');
INSERT INTO public.virksomhet VALUES (110, '808543637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808543637', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.227496', '2022-09-29 10:20:49.227496');
INSERT INTO public.virksomhet VALUES (111, '870201888', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870201888', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.231897', '2022-09-29 10:20:49.231897');
INSERT INTO public.virksomhet VALUES (112, '817311070', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817311070', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.236326', '2022-09-29 10:20:49.236326');
INSERT INTO public.virksomhet VALUES (113, '868012776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868012776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.241331', '2022-09-29 10:20:49.241331');
INSERT INTO public.virksomhet VALUES (114, '896429753', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896429753', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.245811', '2022-09-29 10:20:49.245811');
INSERT INTO public.virksomhet VALUES (115, '851603425', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851603425', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.250171', '2022-09-29 10:20:49.250171');
INSERT INTO public.virksomhet VALUES (116, '827443317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827443317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.255132', '2022-09-29 10:20:49.255132');
INSERT INTO public.virksomhet VALUES (117, '833362642', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833362642', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.26022', '2022-09-29 10:20:49.26022');
INSERT INTO public.virksomhet VALUES (118, '882069408', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882069408', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.265388', '2022-09-29 10:20:49.265388');
INSERT INTO public.virksomhet VALUES (119, '863878944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863878944', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.270188', '2022-09-29 10:20:49.270188');
INSERT INTO public.virksomhet VALUES (120, '866558221', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866558221', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.275162', '2022-09-29 10:20:49.275162');
INSERT INTO public.virksomhet VALUES (121, '868767855', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868767855', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.279839', '2022-09-29 10:20:49.279839');
INSERT INTO public.virksomhet VALUES (122, '875885300', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875885300', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.284651', '2022-09-29 10:20:49.284651');
INSERT INTO public.virksomhet VALUES (123, '842216735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842216735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.2896', '2022-09-29 10:20:49.2896');
INSERT INTO public.virksomhet VALUES (124, '856920437', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856920437', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.294677', '2022-09-29 10:20:49.294677');
INSERT INTO public.virksomhet VALUES (125, '830858963', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830858963', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.299501', '2022-09-29 10:20:49.299501');
INSERT INTO public.virksomhet VALUES (126, '812434114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812434114', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.304096', '2022-09-29 10:20:49.304096');
INSERT INTO public.virksomhet VALUES (127, '847041353', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847041353', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.308786', '2022-09-29 10:20:49.308786');
INSERT INTO public.virksomhet VALUES (128, '803269327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803269327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.313961', '2022-09-29 10:20:49.313961');
INSERT INTO public.virksomhet VALUES (129, '843457384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843457384', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.319275', '2022-09-29 10:20:49.319275');
INSERT INTO public.virksomhet VALUES (130, '818306281', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818306281', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.324332', '2022-09-29 10:20:49.324332');
INSERT INTO public.virksomhet VALUES (131, '844449510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844449510', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.328769', '2022-09-29 10:20:49.328769');
INSERT INTO public.virksomhet VALUES (132, '867177223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867177223', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.332833', '2022-09-29 10:20:49.332833');
INSERT INTO public.virksomhet VALUES (133, '883963814', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883963814', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.336911', '2022-09-29 10:20:49.336911');
INSERT INTO public.virksomhet VALUES (134, '886253015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886253015', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.341634', '2022-09-29 10:20:49.341634');
INSERT INTO public.virksomhet VALUES (135, '895281822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895281822', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.346393', '2022-09-29 10:20:49.346393');
INSERT INTO public.virksomhet VALUES (136, '840533481', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840533481', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.351149', '2022-09-29 10:20:49.351149');
INSERT INTO public.virksomhet VALUES (137, '839216776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839216776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.355625', '2022-09-29 10:20:49.355625');
INSERT INTO public.virksomhet VALUES (138, '803533948', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803533948', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.360395', '2022-09-29 10:20:49.360395');
INSERT INTO public.virksomhet VALUES (139, '827095124', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827095124', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.364968', '2022-09-29 10:20:49.364968');
INSERT INTO public.virksomhet VALUES (140, '808251981', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808251981', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.369295', '2022-09-29 10:20:49.369295');
INSERT INTO public.virksomhet VALUES (141, '817358823', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817358823', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.373784', '2022-09-29 10:20:49.373784');
INSERT INTO public.virksomhet VALUES (142, '871910327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871910327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.378252', '2022-09-29 10:20:49.378252');
INSERT INTO public.virksomhet VALUES (143, '866587133', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866587133', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.382924', '2022-09-29 10:20:49.382924');
INSERT INTO public.virksomhet VALUES (144, '842840788', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842840788', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.387267', '2022-09-29 10:20:49.387267');
INSERT INTO public.virksomhet VALUES (145, '812781923', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812781923', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.391992', '2022-09-29 10:20:49.391992');
INSERT INTO public.virksomhet VALUES (146, '804058381', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804058381', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.39875', '2022-09-29 10:20:49.39875');
INSERT INTO public.virksomhet VALUES (147, '811423248', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811423248', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.405925', '2022-09-29 10:20:49.405925');
INSERT INTO public.virksomhet VALUES (148, '840837641', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840837641', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.411249', '2022-09-29 10:20:49.411249');
INSERT INTO public.virksomhet VALUES (149, '818816392', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818816392', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.416367', '2022-09-29 10:20:49.416367');
INSERT INTO public.virksomhet VALUES (150, '806494928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806494928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.42121', '2022-09-29 10:20:49.42121');
INSERT INTO public.virksomhet VALUES (151, '893055618', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893055618', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.426134', '2022-09-29 10:20:49.426134');
INSERT INTO public.virksomhet VALUES (152, '875340822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875340822', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.431127', '2022-09-29 10:20:49.431127');
INSERT INTO public.virksomhet VALUES (153, '818463756', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818463756', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.435938', '2022-09-29 10:20:49.435938');
INSERT INTO public.virksomhet VALUES (154, '884152302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884152302', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.441252', '2022-09-29 10:20:49.441252');
INSERT INTO public.virksomhet VALUES (155, '849742742', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849742742', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.446491', '2022-09-29 10:20:49.446491');
INSERT INTO public.virksomhet VALUES (156, '804979817', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804979817', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.451486', '2022-09-29 10:20:49.451486');
INSERT INTO public.virksomhet VALUES (157, '814190896', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814190896', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.456941', '2022-09-29 10:20:49.456941');
INSERT INTO public.virksomhet VALUES (158, '822331640', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822331640', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.461985', '2022-09-29 10:20:49.461985');
INSERT INTO public.virksomhet VALUES (159, '862678317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862678317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.467367', '2022-09-29 10:20:49.467367');
INSERT INTO public.virksomhet VALUES (160, '831093023', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831093023', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.472065', '2022-09-29 10:20:49.472065');
INSERT INTO public.virksomhet VALUES (161, '874226454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874226454', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.476844', '2022-09-29 10:20:49.476844');
INSERT INTO public.virksomhet VALUES (162, '832436811', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832436811', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.48131', '2022-09-29 10:20:49.48131');
INSERT INTO public.virksomhet VALUES (163, '838432048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838432048', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.485931', '2022-09-29 10:20:49.485931');
INSERT INTO public.virksomhet VALUES (164, '870022919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870022919', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.490572', '2022-09-29 10:20:49.490572');
INSERT INTO public.virksomhet VALUES (165, '879268334', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879268334', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.495132', '2022-09-29 10:20:49.495132');
INSERT INTO public.virksomhet VALUES (166, '806599852', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806599852', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.499709', '2022-09-29 10:20:49.499709');
INSERT INTO public.virksomhet VALUES (167, '863181199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863181199', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.50459', '2022-09-29 10:20:49.50459');
INSERT INTO public.virksomhet VALUES (168, '863767568', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863767568', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.509558', '2022-09-29 10:20:49.509558');
INSERT INTO public.virksomhet VALUES (169, '844014636', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844014636', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.514426', '2022-09-29 10:20:49.514426');
INSERT INTO public.virksomhet VALUES (170, '866404710', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866404710', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.518835', '2022-09-29 10:20:49.518835');
INSERT INTO public.virksomhet VALUES (171, '833129946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833129946', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.523118', '2022-09-29 10:20:49.523118');
INSERT INTO public.virksomhet VALUES (172, '846977998', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846977998', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.527046', '2022-09-29 10:20:49.527046');
INSERT INTO public.virksomhet VALUES (173, '811030348', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811030348', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.531913', '2022-09-29 10:20:49.531913');
INSERT INTO public.virksomhet VALUES (174, '890815907', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890815907', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.536175', '2022-09-29 10:20:49.536175');
INSERT INTO public.virksomhet VALUES (175, '822694021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822694021', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.540878', '2022-09-29 10:20:49.540878');
INSERT INTO public.virksomhet VALUES (176, '852558904', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852558904', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.545043', '2022-09-29 10:20:49.545043');
INSERT INTO public.virksomhet VALUES (177, '822874914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822874914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.549143', '2022-09-29 10:20:49.549143');
INSERT INTO public.virksomhet VALUES (178, '866646453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866646453', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.554091', '2022-09-29 10:20:49.554091');
INSERT INTO public.virksomhet VALUES (179, '881021956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881021956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.558995', '2022-09-29 10:20:49.558995');
INSERT INTO public.virksomhet VALUES (180, '899291735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899291735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.563947', '2022-09-29 10:20:49.563947');
INSERT INTO public.virksomhet VALUES (181, '867918928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867918928', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.568847', '2022-09-29 10:20:49.568847');
INSERT INTO public.virksomhet VALUES (182, '823439458', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823439458', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.575539', '2022-09-29 10:20:49.575539');
INSERT INTO public.virksomhet VALUES (183, '837805347', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837805347', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.580534', '2022-09-29 10:20:49.580534');
INSERT INTO public.virksomhet VALUES (184, '805499088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805499088', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.585849', '2022-09-29 10:20:49.585849');
INSERT INTO public.virksomhet VALUES (185, '845822610', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845822610', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.591081', '2022-09-29 10:20:49.591081');
INSERT INTO public.virksomhet VALUES (186, '841405633', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841405633', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.596472', '2022-09-29 10:20:49.596472');
INSERT INTO public.virksomhet VALUES (187, '889675608', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889675608', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.601496', '2022-09-29 10:20:49.601496');
INSERT INTO public.virksomhet VALUES (188, '899025387', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899025387', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.606599', '2022-09-29 10:20:49.606599');
INSERT INTO public.virksomhet VALUES (189, '863280835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863280835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.611439', '2022-09-29 10:20:49.611439');
INSERT INTO public.virksomhet VALUES (190, '860629673', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860629673', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.61668', '2022-09-29 10:20:49.61668');
INSERT INTO public.virksomhet VALUES (191, '833667497', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833667497', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.621997', '2022-09-29 10:20:49.621997');
INSERT INTO public.virksomhet VALUES (192, '842471044', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842471044', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.62663', '2022-09-29 10:20:49.62663');
INSERT INTO public.virksomhet VALUES (193, '861459803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861459803', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.631145', '2022-09-29 10:20:49.631145');
INSERT INTO public.virksomhet VALUES (194, '812926032', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812926032', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.635954', '2022-09-29 10:20:49.635954');
INSERT INTO public.virksomhet VALUES (195, '871631319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871631319', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.641144', '2022-09-29 10:20:49.641144');
INSERT INTO public.virksomhet VALUES (196, '865439281', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865439281', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.646765', '2022-09-29 10:20:49.646765');
INSERT INTO public.virksomhet VALUES (197, '824210548', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824210548', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.652222', '2022-09-29 10:20:49.652222');
INSERT INTO public.virksomhet VALUES (198, '805486005', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805486005', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.657873', '2022-09-29 10:20:49.657873');
INSERT INTO public.virksomhet VALUES (199, '832448472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832448472', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.663685', '2022-09-29 10:20:49.663685');
INSERT INTO public.virksomhet VALUES (200, '805820685', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805820685', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.66966', '2022-09-29 10:20:49.66966');
INSERT INTO public.virksomhet VALUES (201, '883768894', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883768894', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.675768', '2022-09-29 10:20:49.675768');
INSERT INTO public.virksomhet VALUES (202, '856903021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856903021', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.681289', '2022-09-29 10:20:49.681289');
INSERT INTO public.virksomhet VALUES (203, '850012745', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850012745', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.68673', '2022-09-29 10:20:49.68673');
INSERT INTO public.virksomhet VALUES (204, '820149848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820149848', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.692162', '2022-09-29 10:20:49.692162');
INSERT INTO public.virksomhet VALUES (205, '822705108', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822705108', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.697158', '2022-09-29 10:20:49.697158');
INSERT INTO public.virksomhet VALUES (206, '857573851', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857573851', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.702062', '2022-09-29 10:20:49.702062');
INSERT INTO public.virksomhet VALUES (207, '856078198', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856078198', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.707538', '2022-09-29 10:20:49.707538');
INSERT INTO public.virksomhet VALUES (208, '859225721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859225721', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.712566', '2022-09-29 10:20:49.712566');
INSERT INTO public.virksomhet VALUES (209, '873879874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873879874', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.716789', '2022-09-29 10:20:49.716789');
INSERT INTO public.virksomhet VALUES (210, '890065285', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890065285', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.721258', '2022-09-29 10:20:49.721258');
INSERT INTO public.virksomhet VALUES (211, '893423280', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893423280', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.725899', '2022-09-29 10:20:49.725899');
INSERT INTO public.virksomhet VALUES (212, '816273126', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816273126', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.730133', '2022-09-29 10:20:49.730133');
INSERT INTO public.virksomhet VALUES (213, '874977909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874977909', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.734524', '2022-09-29 10:20:49.734524');
INSERT INTO public.virksomhet VALUES (214, '888632161', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888632161', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.739043', '2022-09-29 10:20:49.739043');
INSERT INTO public.virksomhet VALUES (215, '852452427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852452427', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.744545', '2022-09-29 10:20:49.744545');
INSERT INTO public.virksomhet VALUES (216, '807389236', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807389236', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.749358', '2022-09-29 10:20:49.749358');
INSERT INTO public.virksomhet VALUES (217, '833163111', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833163111', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.754167', '2022-09-29 10:20:49.754167');
INSERT INTO public.virksomhet VALUES (218, '813080832', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813080832', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.758888', '2022-09-29 10:20:49.758888');
INSERT INTO public.virksomhet VALUES (219, '896489260', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896489260', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.76356', '2022-09-29 10:20:49.76356');
INSERT INTO public.virksomhet VALUES (220, '845881839', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845881839', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.767944', '2022-09-29 10:20:49.767944');
INSERT INTO public.virksomhet VALUES (221, '898157169', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898157169', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.772602', '2022-09-29 10:20:49.772602');
INSERT INTO public.virksomhet VALUES (222, '882940656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882940656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.777371', '2022-09-29 10:20:49.777371');
INSERT INTO public.virksomhet VALUES (223, '887589106', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887589106', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.781816', '2022-09-29 10:20:49.781816');
INSERT INTO public.virksomhet VALUES (224, '856439808', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856439808', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.786167', '2022-09-29 10:20:49.786167');
INSERT INTO public.virksomhet VALUES (225, '869911712', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869911712', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.790582', '2022-09-29 10:20:49.790582');
INSERT INTO public.virksomhet VALUES (226, '836420677', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836420677', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.795564', '2022-09-29 10:20:49.795564');
INSERT INTO public.virksomhet VALUES (227, '810521018', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810521018', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.800287', '2022-09-29 10:20:49.800287');
INSERT INTO public.virksomhet VALUES (228, '863021621', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863021621', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.805087', '2022-09-29 10:20:49.805087');
INSERT INTO public.virksomhet VALUES (229, '846289494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846289494', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.810223', '2022-09-29 10:20:49.810223');
INSERT INTO public.virksomhet VALUES (230, '834191416', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834191416', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.815347', '2022-09-29 10:20:49.815347');
INSERT INTO public.virksomhet VALUES (231, '837420340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837420340', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.820324', '2022-09-29 10:20:49.820324');
INSERT INTO public.virksomhet VALUES (232, '871949311', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871949311', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.824839', '2022-09-29 10:20:49.824839');
INSERT INTO public.virksomhet VALUES (233, '821633142', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821633142', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.830075', '2022-09-29 10:20:49.830075');
INSERT INTO public.virksomhet VALUES (234, '893463166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893463166', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.834703', '2022-09-29 10:20:49.834703');
INSERT INTO public.virksomhet VALUES (235, '833218825', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833218825', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.839236', '2022-09-29 10:20:49.839236');
INSERT INTO public.virksomhet VALUES (236, '807456455', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807456455', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.844981', '2022-09-29 10:20:49.844981');
INSERT INTO public.virksomhet VALUES (237, '821381486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821381486', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.849999', '2022-09-29 10:20:49.849999');
INSERT INTO public.virksomhet VALUES (238, '814324199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814324199', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.856239', '2022-09-29 10:20:49.856239');
INSERT INTO public.virksomhet VALUES (239, '805904949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805904949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.862412', '2022-09-29 10:20:49.862412');
INSERT INTO public.virksomhet VALUES (240, '813242515', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813242515', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.868455', '2022-09-29 10:20:49.868455');
INSERT INTO public.virksomhet VALUES (241, '839415843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839415843', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.875153', '2022-09-29 10:20:49.875153');
INSERT INTO public.virksomhet VALUES (242, '804234371', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804234371', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.881645', '2022-09-29 10:20:49.881645');
INSERT INTO public.virksomhet VALUES (243, '816585946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816585946', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.887398', '2022-09-29 10:20:49.887398');
INSERT INTO public.virksomhet VALUES (244, '824097835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824097835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.893551', '2022-09-29 10:20:49.893551');
INSERT INTO public.virksomhet VALUES (245, '880538674', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880538674', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.899313', '2022-09-29 10:20:49.899313');
INSERT INTO public.virksomhet VALUES (246, '875775705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875775705', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.907902', '2022-09-29 10:20:49.907902');
INSERT INTO public.virksomhet VALUES (247, '877421692', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877421692', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.917109', '2022-09-29 10:20:49.917109');
INSERT INTO public.virksomhet VALUES (248, '871547736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871547736', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.924787', '2022-09-29 10:20:49.924787');
INSERT INTO public.virksomhet VALUES (249, '857653378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857653378', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.931188', '2022-09-29 10:20:49.931188');
INSERT INTO public.virksomhet VALUES (250, '829980700', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829980700', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.938309', '2022-09-29 10:20:49.938309');
INSERT INTO public.virksomhet VALUES (251, '852627790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852627790', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.946063', '2022-09-29 10:20:49.946063');
INSERT INTO public.virksomhet VALUES (252, '865978526', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865978526', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.951856', '2022-09-29 10:20:49.951856');
INSERT INTO public.virksomhet VALUES (253, '840145629', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840145629', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.959824', '2022-09-29 10:20:49.959824');
INSERT INTO public.virksomhet VALUES (254, '875016141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875016141', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.966172', '2022-09-29 10:20:49.966172');
INSERT INTO public.virksomhet VALUES (255, '869419134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869419134', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.972852', '2022-09-29 10:20:49.972852');
INSERT INTO public.virksomhet VALUES (256, '813944600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813944600', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.978972', '2022-09-29 10:20:49.978972');
INSERT INTO public.virksomhet VALUES (257, '885600454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885600454', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.985569', '2022-09-29 10:20:49.985569');
INSERT INTO public.virksomhet VALUES (258, '877550656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877550656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.991831', '2022-09-29 10:20:49.991831');
INSERT INTO public.virksomhet VALUES (259, '804227830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804227830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:49.99754', '2022-09-29 10:20:49.99754');
INSERT INTO public.virksomhet VALUES (260, '858956619', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858956619', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.003215', '2022-09-29 10:20:50.003215');
INSERT INTO public.virksomhet VALUES (261, '865153645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865153645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.009705', '2022-09-29 10:20:50.009705');
INSERT INTO public.virksomhet VALUES (262, '817941723', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817941723', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.015656', '2022-09-29 10:20:50.015656');
INSERT INTO public.virksomhet VALUES (263, '811667993', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811667993', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.021015', '2022-09-29 10:20:50.021015');
INSERT INTO public.virksomhet VALUES (264, '859462534', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859462534', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.02747', '2022-09-29 10:20:50.02747');
INSERT INTO public.virksomhet VALUES (265, '822317092', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822317092', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.033254', '2022-09-29 10:20:50.033254');
INSERT INTO public.virksomhet VALUES (266, '877772835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877772835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.039436', '2022-09-29 10:20:50.039436');
INSERT INTO public.virksomhet VALUES (267, '846495295', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846495295', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.045512', '2022-09-29 10:20:50.045512');
INSERT INTO public.virksomhet VALUES (268, '804775869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804775869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.051063', '2022-09-29 10:20:50.051063');
INSERT INTO public.virksomhet VALUES (269, '831030012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831030012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.056353', '2022-09-29 10:20:50.056353');
INSERT INTO public.virksomhet VALUES (270, '802809462', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802809462', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.061678', '2022-09-29 10:20:50.061678');
INSERT INTO public.virksomhet VALUES (271, '896200151', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896200151', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.066517', '2022-09-29 10:20:50.066517');
INSERT INTO public.virksomhet VALUES (272, '873610100', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873610100', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.0709', '2022-09-29 10:20:50.0709');
INSERT INTO public.virksomhet VALUES (273, '847931581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847931581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.07561', '2022-09-29 10:20:50.07561');
INSERT INTO public.virksomhet VALUES (274, '870810427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870810427', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.0801', '2022-09-29 10:20:50.0801');
INSERT INTO public.virksomhet VALUES (275, '816457914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816457914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.084504', '2022-09-29 10:20:50.084504');
INSERT INTO public.virksomhet VALUES (276, '816760477', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816760477', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.089331', '2022-09-29 10:20:50.089331');
INSERT INTO public.virksomhet VALUES (277, '821449527', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821449527', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.094063', '2022-09-29 10:20:50.094063');
INSERT INTO public.virksomhet VALUES (278, '897412997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897412997', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.103093', '2022-09-29 10:20:50.103093');
INSERT INTO public.virksomhet VALUES (279, '801856356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801856356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.109946', '2022-09-29 10:20:50.109946');
INSERT INTO public.virksomhet VALUES (280, '898170941', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898170941', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.121381', '2022-09-29 10:20:50.121381');
INSERT INTO public.virksomhet VALUES (281, '884390144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884390144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.129318', '2022-09-29 10:20:50.129318');
INSERT INTO public.virksomhet VALUES (282, '894424841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894424841', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.135444', '2022-09-29 10:20:50.135444');
INSERT INTO public.virksomhet VALUES (283, '828972512', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828972512', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.142409', '2022-09-29 10:20:50.142409');
INSERT INTO public.virksomhet VALUES (284, '815082581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815082581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.148641', '2022-09-29 10:20:50.148641');
INSERT INTO public.virksomhet VALUES (285, '887159012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887159012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.155175', '2022-09-29 10:20:50.155175');
INSERT INTO public.virksomhet VALUES (286, '829493874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829493874', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.162841', '2022-09-29 10:20:50.162841');
INSERT INTO public.virksomhet VALUES (287, '814929193', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814929193', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.168954', '2022-09-29 10:20:50.168954');
INSERT INTO public.virksomhet VALUES (288, '859907302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859907302', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.175932', '2022-09-29 10:20:50.175932');
INSERT INTO public.virksomhet VALUES (289, '895124699', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895124699', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.18251', '2022-09-29 10:20:50.18251');
INSERT INTO public.virksomhet VALUES (290, '813239227', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813239227', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.188892', '2022-09-29 10:20:50.188892');
INSERT INTO public.virksomhet VALUES (291, '840430296', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840430296', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.196152', '2022-09-29 10:20:50.196152');
INSERT INTO public.virksomhet VALUES (292, '858726639', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858726639', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.2027', '2022-09-29 10:20:50.2027');
INSERT INTO public.virksomhet VALUES (293, '823234800', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823234800', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.208813', '2022-09-29 10:20:50.208813');
INSERT INTO public.virksomhet VALUES (294, '874361830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874361830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.214865', '2022-09-29 10:20:50.214865');
INSERT INTO public.virksomhet VALUES (295, '808481735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808481735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.220558', '2022-09-29 10:20:50.220558');
INSERT INTO public.virksomhet VALUES (296, '860499175', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860499175', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.227264', '2022-09-29 10:20:50.227264');
INSERT INTO public.virksomhet VALUES (297, '892697142', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892697142', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.234124', '2022-09-29 10:20:50.234124');
INSERT INTO public.virksomhet VALUES (298, '826727890', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826727890', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.24137', '2022-09-29 10:20:50.24137');
INSERT INTO public.virksomhet VALUES (299, '895582762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895582762', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.248312', '2022-09-29 10:20:50.248312');
INSERT INTO public.virksomhet VALUES (300, '814663914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814663914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.255169', '2022-09-29 10:20:50.255169');
INSERT INTO public.virksomhet VALUES (301, '887191975', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887191975', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.262143', '2022-09-29 10:20:50.262143');
INSERT INTO public.virksomhet VALUES (302, '856729012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856729012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.269588', '2022-09-29 10:20:50.269588');
INSERT INTO public.virksomhet VALUES (303, '816248533', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816248533', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.276636', '2022-09-29 10:20:50.276636');
INSERT INTO public.virksomhet VALUES (304, '847253663', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847253663', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.282781', '2022-09-29 10:20:50.282781');
INSERT INTO public.virksomhet VALUES (305, '851556995', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851556995', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.289475', '2022-09-29 10:20:50.289475');
INSERT INTO public.virksomhet VALUES (306, '897000352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897000352', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.29696', '2022-09-29 10:20:50.29696');
INSERT INTO public.virksomhet VALUES (307, '891267708', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891267708', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.303015', '2022-09-29 10:20:50.303015');
INSERT INTO public.virksomhet VALUES (308, '868369009', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868369009', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.309307', '2022-09-29 10:20:50.309307');
INSERT INTO public.virksomhet VALUES (309, '836786224', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836786224', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.315732', '2022-09-29 10:20:50.315732');
INSERT INTO public.virksomhet VALUES (310, '800910790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800910790', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.322364', '2022-09-29 10:20:50.322364');
INSERT INTO public.virksomhet VALUES (311, '847922087', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847922087', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.329017', '2022-09-29 10:20:50.329017');
INSERT INTO public.virksomhet VALUES (312, '882737279', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882737279', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.33517', '2022-09-29 10:20:50.33517');
INSERT INTO public.virksomhet VALUES (313, '817612413', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817612413', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.342179', '2022-09-29 10:20:50.342179');
INSERT INTO public.virksomhet VALUES (314, '857680168', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857680168', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.348835', '2022-09-29 10:20:50.348835');
INSERT INTO public.virksomhet VALUES (315, '878624841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878624841', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.355507', '2022-09-29 10:20:50.355507');
INSERT INTO public.virksomhet VALUES (316, '867183919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867183919', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.363169', '2022-09-29 10:20:50.363169');
INSERT INTO public.virksomhet VALUES (317, '824306551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824306551', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.370791', '2022-09-29 10:20:50.370791');
INSERT INTO public.virksomhet VALUES (318, '812929350', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812929350', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.378602', '2022-09-29 10:20:50.378602');
INSERT INTO public.virksomhet VALUES (319, '890735735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890735735', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.385608', '2022-09-29 10:20:50.385608');
INSERT INTO public.virksomhet VALUES (320, '894341616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894341616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.393423', '2022-09-29 10:20:50.393423');
INSERT INTO public.virksomhet VALUES (321, '845690609', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845690609', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.400943', '2022-09-29 10:20:50.400943');
INSERT INTO public.virksomhet VALUES (322, '884945724', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884945724', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.408265', '2022-09-29 10:20:50.408265');
INSERT INTO public.virksomhet VALUES (323, '820865124', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820865124', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.418256', '2022-09-29 10:20:50.418256');
INSERT INTO public.virksomhet VALUES (324, '870514368', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870514368', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.42585', '2022-09-29 10:20:50.42585');
INSERT INTO public.virksomhet VALUES (325, '833643869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833643869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.432538', '2022-09-29 10:20:50.432538');
INSERT INTO public.virksomhet VALUES (326, '807702188', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807702188', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.437923', '2022-09-29 10:20:50.437923');
INSERT INTO public.virksomhet VALUES (327, '820638689', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820638689', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.444468', '2022-09-29 10:20:50.444468');
INSERT INTO public.virksomhet VALUES (328, '843380901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843380901', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.450264', '2022-09-29 10:20:50.450264');
INSERT INTO public.virksomhet VALUES (329, '832951634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832951634', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.457089', '2022-09-29 10:20:50.457089');
INSERT INTO public.virksomhet VALUES (330, '833677243', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833677243', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.463007', '2022-09-29 10:20:50.463007');
INSERT INTO public.virksomhet VALUES (331, '873656323', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873656323', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.468269', '2022-09-29 10:20:50.468269');
INSERT INTO public.virksomhet VALUES (332, '859159231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859159231', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.474228', '2022-09-29 10:20:50.474228');
INSERT INTO public.virksomhet VALUES (333, '868067017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868067017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.480233', '2022-09-29 10:20:50.480233');
INSERT INTO public.virksomhet VALUES (334, '856435712', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856435712', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.486863', '2022-09-29 10:20:50.486863');
INSERT INTO public.virksomhet VALUES (335, '888937591', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888937591', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.493849', '2022-09-29 10:20:50.493849');
INSERT INTO public.virksomhet VALUES (336, '873906284', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873906284', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.501071', '2022-09-29 10:20:50.501071');
INSERT INTO public.virksomhet VALUES (337, '855150484', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855150484', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.506899', '2022-09-29 10:20:50.506899');
INSERT INTO public.virksomhet VALUES (338, '836365546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836365546', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.512538', '2022-09-29 10:20:50.512538');
INSERT INTO public.virksomhet VALUES (339, '822564929', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822564929', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.518931', '2022-09-29 10:20:50.518931');
INSERT INTO public.virksomhet VALUES (340, '833204596', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833204596', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.525145', '2022-09-29 10:20:50.525145');
INSERT INTO public.virksomhet VALUES (341, '863592645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863592645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.531225', '2022-09-29 10:20:50.531225');
INSERT INTO public.virksomhet VALUES (342, '865956727', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865956727', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.537012', '2022-09-29 10:20:50.537012');
INSERT INTO public.virksomhet VALUES (343, '807629933', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807629933', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.543012', '2022-09-29 10:20:50.543012');
INSERT INTO public.virksomhet VALUES (344, '832454631', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832454631', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.548496', '2022-09-29 10:20:50.548496');
INSERT INTO public.virksomhet VALUES (345, '823356725', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823356725', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.55388', '2022-09-29 10:20:50.55388');
INSERT INTO public.virksomhet VALUES (346, '800824855', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800824855', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.558866', '2022-09-29 10:20:50.558866');
INSERT INTO public.virksomhet VALUES (347, '894510083', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894510083', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.563787', '2022-09-29 10:20:50.563787');
INSERT INTO public.virksomhet VALUES (348, '815854671', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815854671', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.568882', '2022-09-29 10:20:50.568882');
INSERT INTO public.virksomhet VALUES (349, '876401827', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876401827', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.574349', '2022-09-29 10:20:50.574349');
INSERT INTO public.virksomhet VALUES (350, '845066027', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845066027', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.579205', '2022-09-29 10:20:50.579205');
INSERT INTO public.virksomhet VALUES (351, '815406101', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815406101', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.583371', '2022-09-29 10:20:50.583371');
INSERT INTO public.virksomhet VALUES (352, '866878310', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866878310', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.587158', '2022-09-29 10:20:50.587158');
INSERT INTO public.virksomhet VALUES (353, '830803739', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830803739', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.591008', '2022-09-29 10:20:50.591008');
INSERT INTO public.virksomhet VALUES (354, '805933483', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805933483', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.595204', '2022-09-29 10:20:50.595204');
INSERT INTO public.virksomhet VALUES (355, '868252144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868252144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.599343', '2022-09-29 10:20:50.599343');
INSERT INTO public.virksomhet VALUES (356, '828744326', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828744326', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.604668', '2022-09-29 10:20:50.604668');
INSERT INTO public.virksomhet VALUES (357, '830122600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830122600', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.610921', '2022-09-29 10:20:50.610921');
INSERT INTO public.virksomhet VALUES (358, '813147327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813147327', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.617619', '2022-09-29 10:20:50.617619');
INSERT INTO public.virksomhet VALUES (359, '846250295', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846250295', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.623114', '2022-09-29 10:20:50.623114');
INSERT INTO public.virksomhet VALUES (360, '898250721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898250721', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.628985', '2022-09-29 10:20:50.628985');
INSERT INTO public.virksomhet VALUES (361, '813697349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813697349', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.635099', '2022-09-29 10:20:50.635099');
INSERT INTO public.virksomhet VALUES (362, '863104800', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863104800', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.640932', '2022-09-29 10:20:50.640932');
INSERT INTO public.virksomhet VALUES (363, '897979593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897979593', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.646971', '2022-09-29 10:20:50.646971');
INSERT INTO public.virksomhet VALUES (364, '860772161', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860772161', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.653573', '2022-09-29 10:20:50.653573');
INSERT INTO public.virksomhet VALUES (365, '808002552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808002552', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.659516', '2022-09-29 10:20:50.659516');
INSERT INTO public.virksomhet VALUES (366, '876394411', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876394411', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.665569', '2022-09-29 10:20:50.665569');
INSERT INTO public.virksomhet VALUES (367, '846214156', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846214156', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.712037', '2022-09-29 10:20:50.712037');
INSERT INTO public.virksomhet VALUES (368, '850015354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850015354', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.719921', '2022-09-29 10:20:50.719921');
INSERT INTO public.virksomhet VALUES (369, '805145991', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805145991', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.729081', '2022-09-29 10:20:50.729081');
INSERT INTO public.virksomhet VALUES (370, '853879838', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853879838', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.735867', '2022-09-29 10:20:50.735867');
INSERT INTO public.virksomhet VALUES (371, '882939801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882939801', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.743452', '2022-09-29 10:20:50.743452');
INSERT INTO public.virksomhet VALUES (372, '859605190', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859605190', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.75009', '2022-09-29 10:20:50.75009');
INSERT INTO public.virksomhet VALUES (373, '891814367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891814367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.756135', '2022-09-29 10:20:50.756135');
INSERT INTO public.virksomhet VALUES (374, '875021136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875021136', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.761857', '2022-09-29 10:20:50.761857');
INSERT INTO public.virksomhet VALUES (375, '825379831', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825379831', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.767008', '2022-09-29 10:20:50.767008');
INSERT INTO public.virksomhet VALUES (376, '800469195', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800469195', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.772428', '2022-09-29 10:20:50.772428');
INSERT INTO public.virksomhet VALUES (377, '871244244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871244244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.777972', '2022-09-29 10:20:50.777972');
INSERT INTO public.virksomhet VALUES (378, '837133219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837133219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.783608', '2022-09-29 10:20:50.783608');
INSERT INTO public.virksomhet VALUES (379, '855964219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855964219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.789258', '2022-09-29 10:20:50.789258');
INSERT INTO public.virksomhet VALUES (380, '838273484', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838273484', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.794856', '2022-09-29 10:20:50.794856');
INSERT INTO public.virksomhet VALUES (381, '893483616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893483616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.800014', '2022-09-29 10:20:50.800014');
INSERT INTO public.virksomhet VALUES (382, '891497759', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891497759', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.804996', '2022-09-29 10:20:50.804996');
INSERT INTO public.virksomhet VALUES (383, '888247901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888247901', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.809116', '2022-09-29 10:20:50.809116');
INSERT INTO public.virksomhet VALUES (384, '883590490', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883590490', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.813476', '2022-09-29 10:20:50.813476');
INSERT INTO public.virksomhet VALUES (385, '804908767', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804908767', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.81769', '2022-09-29 10:20:50.81769');
INSERT INTO public.virksomhet VALUES (386, '851919134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851919134', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.821643', '2022-09-29 10:20:50.821643');
INSERT INTO public.virksomhet VALUES (387, '813682750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813682750', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.825719', '2022-09-29 10:20:50.825719');
INSERT INTO public.virksomhet VALUES (388, '875544956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875544956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.829625', '2022-09-29 10:20:50.829625');
INSERT INTO public.virksomhet VALUES (389, '889472231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889472231', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.834191', '2022-09-29 10:20:50.834191');
INSERT INTO public.virksomhet VALUES (390, '875631634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875631634', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.838579', '2022-09-29 10:20:50.838579');
INSERT INTO public.virksomhet VALUES (391, '856007783', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856007783', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.84307', '2022-09-29 10:20:50.84307');
INSERT INTO public.virksomhet VALUES (392, '844760467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844760467', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.847609', '2022-09-29 10:20:50.847609');
INSERT INTO public.virksomhet VALUES (393, '863256691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863256691', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.852272', '2022-09-29 10:20:50.852272');
INSERT INTO public.virksomhet VALUES (394, '851705582', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851705582', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.85675', '2022-09-29 10:20:50.85675');
INSERT INTO public.virksomhet VALUES (395, '854298834', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854298834', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.861117', '2022-09-29 10:20:50.861117');
INSERT INTO public.virksomhet VALUES (396, '836216435', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836216435', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.86529', '2022-09-29 10:20:50.86529');
INSERT INTO public.virksomhet VALUES (397, '893017297', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893017297', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.869367', '2022-09-29 10:20:50.869367');
INSERT INTO public.virksomhet VALUES (398, '841372032', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841372032', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.873643', '2022-09-29 10:20:50.873643');
INSERT INTO public.virksomhet VALUES (399, '862589424', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862589424', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.877844', '2022-09-29 10:20:50.877844');
INSERT INTO public.virksomhet VALUES (400, '871501781', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871501781', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.881995', '2022-09-29 10:20:50.881995');
INSERT INTO public.virksomhet VALUES (401, '880977356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880977356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.885957', '2022-09-29 10:20:50.885957');
INSERT INTO public.virksomhet VALUES (402, '859708655', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859708655', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.890048', '2022-09-29 10:20:50.890048');
INSERT INTO public.virksomhet VALUES (403, '837130075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837130075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.894243', '2022-09-29 10:20:50.894243');
INSERT INTO public.virksomhet VALUES (404, '803170681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803170681', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.898605', '2022-09-29 10:20:50.898605');
INSERT INTO public.virksomhet VALUES (405, '875018446', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875018446', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.902785', '2022-09-29 10:20:50.902785');
INSERT INTO public.virksomhet VALUES (406, '872251225', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872251225', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.907185', '2022-09-29 10:20:50.907185');
INSERT INTO public.virksomhet VALUES (407, '889927472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889927472', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.911426', '2022-09-29 10:20:50.911426');
INSERT INTO public.virksomhet VALUES (408, '850310272', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850310272', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.917025', '2022-09-29 10:20:50.917025');
INSERT INTO public.virksomhet VALUES (409, '878277970', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878277970', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.924411', '2022-09-29 10:20:50.924411');
INSERT INTO public.virksomhet VALUES (410, '811324382', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811324382', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.933119', '2022-09-29 10:20:50.933119');
INSERT INTO public.virksomhet VALUES (411, '878265174', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878265174', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.937505', '2022-09-29 10:20:50.937505');
INSERT INTO public.virksomhet VALUES (412, '803799726', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803799726', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.942167', '2022-09-29 10:20:50.942167');
INSERT INTO public.virksomhet VALUES (413, '827344157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827344157', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.946391', '2022-09-29 10:20:50.946391');
INSERT INTO public.virksomhet VALUES (414, '868610918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868610918', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.950602', '2022-09-29 10:20:50.950602');
INSERT INTO public.virksomhet VALUES (415, '891144647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891144647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.977962', '2022-09-29 10:20:50.977962');
INSERT INTO public.virksomhet VALUES (416, '874750888', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874750888', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.986924', '2022-09-29 10:20:50.986924');
INSERT INTO public.virksomhet VALUES (417, '879572863', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879572863', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:50.997223', '2022-09-29 10:20:50.997223');
INSERT INTO public.virksomhet VALUES (418, '816719384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816719384', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.007511', '2022-09-29 10:20:51.007511');
INSERT INTO public.virksomhet VALUES (419, '823372812', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823372812', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.017446', '2022-09-29 10:20:51.017446');
INSERT INTO public.virksomhet VALUES (420, '872671153', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872671153', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.026194', '2022-09-29 10:20:51.026194');
INSERT INTO public.virksomhet VALUES (421, '837782686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837782686', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.038675', '2022-09-29 10:20:51.038675');
INSERT INTO public.virksomhet VALUES (422, '856373244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856373244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.049135', '2022-09-29 10:20:51.049135');
INSERT INTO public.virksomhet VALUES (423, '802319687', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802319687', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.058971', '2022-09-29 10:20:51.058971');
INSERT INTO public.virksomhet VALUES (424, '882221112', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882221112', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.070178', '2022-09-29 10:20:51.070178');
INSERT INTO public.virksomhet VALUES (425, '825823538', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825823538', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.080179', '2022-09-29 10:20:51.080179');
INSERT INTO public.virksomhet VALUES (426, '840744367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840744367', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.0897', '2022-09-29 10:20:51.0897');
INSERT INTO public.virksomhet VALUES (427, '807485242', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807485242', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.099258', '2022-09-29 10:20:51.099258');
INSERT INTO public.virksomhet VALUES (428, '878321914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878321914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.107352', '2022-09-29 10:20:51.107352');
INSERT INTO public.virksomhet VALUES (429, '886892017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886892017', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.116401', '2022-09-29 10:20:51.116401');
INSERT INTO public.virksomhet VALUES (430, '871623349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871623349', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.124483', '2022-09-29 10:20:51.124483');
INSERT INTO public.virksomhet VALUES (431, '864986459', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864986459', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.133658', '2022-09-29 10:20:51.133658');
INSERT INTO public.virksomhet VALUES (432, '849227492', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849227492', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.141727', '2022-09-29 10:20:51.141727');
INSERT INTO public.virksomhet VALUES (433, '850910144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850910144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.150541', '2022-09-29 10:20:51.150541');
INSERT INTO public.virksomhet VALUES (434, '869658223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869658223', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.159704', '2022-09-29 10:20:51.159704');
INSERT INTO public.virksomhet VALUES (435, '866431270', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866431270', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.169114', '2022-09-29 10:20:51.169114');
INSERT INTO public.virksomhet VALUES (436, '858356342', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858356342', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.180132', '2022-09-29 10:20:51.180132');
INSERT INTO public.virksomhet VALUES (437, '852467356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852467356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.190528', '2022-09-29 10:20:51.190528');
INSERT INTO public.virksomhet VALUES (438, '898657961', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898657961', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.199135', '2022-09-29 10:20:51.199135');
INSERT INTO public.virksomhet VALUES (439, '846849579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846849579', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.206647', '2022-09-29 10:20:51.206647');
INSERT INTO public.virksomhet VALUES (440, '873579899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873579899', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.216261', '2022-09-29 10:20:51.216261');
INSERT INTO public.virksomhet VALUES (441, '843035298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843035298', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.226941', '2022-09-29 10:20:51.226941');
INSERT INTO public.virksomhet VALUES (442, '858836952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858836952', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.23618', '2022-09-29 10:20:51.23618');
INSERT INTO public.virksomhet VALUES (443, '805709917', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805709917', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.245993', '2022-09-29 10:20:51.245993');
INSERT INTO public.virksomhet VALUES (444, '808479485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808479485', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.255263', '2022-09-29 10:20:51.255263');
INSERT INTO public.virksomhet VALUES (445, '838878962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838878962', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.265387', '2022-09-29 10:20:51.265387');
INSERT INTO public.virksomhet VALUES (446, '885625328', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885625328', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.275651', '2022-09-29 10:20:51.275651');
INSERT INTO public.virksomhet VALUES (447, '837527996', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837527996', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.286031', '2022-09-29 10:20:51.286031');
INSERT INTO public.virksomhet VALUES (448, '844848494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844848494', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.295737', '2022-09-29 10:20:51.295737');
INSERT INTO public.virksomhet VALUES (449, '825573136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825573136', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.304142', '2022-09-29 10:20:51.304142');
INSERT INTO public.virksomhet VALUES (450, '809036318', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809036318', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.312564', '2022-09-29 10:20:51.312564');
INSERT INTO public.virksomhet VALUES (451, '800223332', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800223332', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.322076', '2022-09-29 10:20:51.322076');
INSERT INTO public.virksomhet VALUES (452, '878112453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878112453', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.330961', '2022-09-29 10:20:51.330961');
INSERT INTO public.virksomhet VALUES (453, '893781546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893781546', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.33898', '2022-09-29 10:20:51.33898');
INSERT INTO public.virksomhet VALUES (454, '818658010', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818658010', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.347988', '2022-09-29 10:20:51.347988');
INSERT INTO public.virksomhet VALUES (455, '862270603', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862270603', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.356282', '2022-09-29 10:20:51.356282');
INSERT INTO public.virksomhet VALUES (456, '812325897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812325897', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.367992', '2022-09-29 10:20:51.367992');
INSERT INTO public.virksomhet VALUES (457, '817554736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817554736', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.377897', '2022-09-29 10:20:51.377897');
INSERT INTO public.virksomhet VALUES (458, '884291457', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884291457', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.387824', '2022-09-29 10:20:51.387824');
INSERT INTO public.virksomhet VALUES (459, '890910485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890910485', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.405907', '2022-09-29 10:20:51.405907');
INSERT INTO public.virksomhet VALUES (460, '810677960', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810677960', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.419238', '2022-09-29 10:20:51.419238');
INSERT INTO public.virksomhet VALUES (461, '830621787', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830621787', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.463556', '2022-09-29 10:20:51.463556');
INSERT INTO public.virksomhet VALUES (462, '874792210', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874792210', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.473427', '2022-09-29 10:20:51.473427');
INSERT INTO public.virksomhet VALUES (463, '828718942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828718942', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.485379', '2022-09-29 10:20:51.485379');
INSERT INTO public.virksomhet VALUES (464, '846277869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846277869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.494974', '2022-09-29 10:20:51.494974');
INSERT INTO public.virksomhet VALUES (465, '809316543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809316543', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.503851', '2022-09-29 10:20:51.503851');
INSERT INTO public.virksomhet VALUES (466, '846821438', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846821438', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.513412', '2022-09-29 10:20:51.513412');
INSERT INTO public.virksomhet VALUES (467, '836005340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836005340', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.523432', '2022-09-29 10:20:51.523432');
INSERT INTO public.virksomhet VALUES (468, '869069081', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869069081', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.533802', '2022-09-29 10:20:51.533802');
INSERT INTO public.virksomhet VALUES (469, '824870495', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824870495', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.543176', '2022-09-29 10:20:51.543176');
INSERT INTO public.virksomhet VALUES (470, '821850314', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821850314', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.553415', '2022-09-29 10:20:51.553415');
INSERT INTO public.virksomhet VALUES (471, '895629317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895629317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.563196', '2022-09-29 10:20:51.563196');
INSERT INTO public.virksomhet VALUES (472, '854843256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854843256', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.573214', '2022-09-29 10:20:51.573214');
INSERT INTO public.virksomhet VALUES (473, '825397589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825397589', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.589305', '2022-09-29 10:20:51.589305');
INSERT INTO public.virksomhet VALUES (474, '856901774', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856901774', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.600519', '2022-09-29 10:20:51.600519');
INSERT INTO public.virksomhet VALUES (475, '886566656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886566656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.611348', '2022-09-29 10:20:51.611348');
INSERT INTO public.virksomhet VALUES (476, '868634250', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868634250', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.621154', '2022-09-29 10:20:51.621154');
INSERT INTO public.virksomhet VALUES (477, '827178297', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827178297', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.632291', '2022-09-29 10:20:51.632291');
INSERT INTO public.virksomhet VALUES (478, '889901026', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889901026', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.64525', '2022-09-29 10:20:51.64525');
INSERT INTO public.virksomhet VALUES (479, '860932226', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860932226', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.656181', '2022-09-29 10:20:51.656181');
INSERT INTO public.virksomhet VALUES (480, '883640440', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883640440', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.6664', '2022-09-29 10:20:51.6664');
INSERT INTO public.virksomhet VALUES (481, '899511765', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899511765', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.675987', '2022-09-29 10:20:51.675987');
INSERT INTO public.virksomhet VALUES (482, '826671551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826671551', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.689132', '2022-09-29 10:20:51.689132');
INSERT INTO public.virksomhet VALUES (483, '838991015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838991015', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.700296', '2022-09-29 10:20:51.700296');
INSERT INTO public.virksomhet VALUES (484, '831768843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831768843', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.712174', '2022-09-29 10:20:51.712174');
INSERT INTO public.virksomhet VALUES (485, '803324193', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803324193', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.72282', '2022-09-29 10:20:51.72282');
INSERT INTO public.virksomhet VALUES (486, '827269180', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827269180', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.733267', '2022-09-29 10:20:51.733267');
INSERT INTO public.virksomhet VALUES (487, '806938796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806938796', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.743799', '2022-09-29 10:20:51.743799');
INSERT INTO public.virksomhet VALUES (488, '817130185', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817130185', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.753655', '2022-09-29 10:20:51.753655');
INSERT INTO public.virksomhet VALUES (489, '810402680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810402680', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.765034', '2022-09-29 10:20:51.765034');
INSERT INTO public.virksomhet VALUES (490, '887841956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887841956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.775595', '2022-09-29 10:20:51.775595');
INSERT INTO public.virksomhet VALUES (491, '897336611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897336611', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.786142', '2022-09-29 10:20:51.786142');
INSERT INTO public.virksomhet VALUES (492, '858728795', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858728795', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.797986', '2022-09-29 10:20:51.797986');
INSERT INTO public.virksomhet VALUES (493, '880050743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880050743', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.808014', '2022-09-29 10:20:51.808014');
INSERT INTO public.virksomhet VALUES (494, '871161662', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871161662', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.818701', '2022-09-29 10:20:51.818701');
INSERT INTO public.virksomhet VALUES (495, '862924848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862924848', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.828869', '2022-09-29 10:20:51.828869');
INSERT INTO public.virksomhet VALUES (496, '895031114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895031114', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.839379', '2022-09-29 10:20:51.839379');
INSERT INTO public.virksomhet VALUES (497, '815517829', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815517829', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.847549', '2022-09-29 10:20:51.847549');
INSERT INTO public.virksomhet VALUES (498, '836666246', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836666246', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.853643', '2022-09-29 10:20:51.853643');
INSERT INTO public.virksomhet VALUES (499, '845715533', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845715533', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.860795', '2022-09-29 10:20:51.860795');
INSERT INTO public.virksomhet VALUES (500, '897156462', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897156462', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.86709', '2022-09-29 10:20:51.86709');
INSERT INTO public.virksomhet VALUES (501, '890815244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890815244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.875709', '2022-09-29 10:20:51.875709');
INSERT INTO public.virksomhet VALUES (502, '866562589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866562589', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.884889', '2022-09-29 10:20:51.884889');
INSERT INTO public.virksomhet VALUES (503, '875322390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875322390', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.8947', '2022-09-29 10:20:51.8947');
INSERT INTO public.virksomhet VALUES (504, '870376312', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870376312', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.901099', '2022-09-29 10:20:51.901099');
INSERT INTO public.virksomhet VALUES (505, '863074238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863074238', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.908652', '2022-09-29 10:20:51.908652');
INSERT INTO public.virksomhet VALUES (506, '873535604', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873535604', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.915478', '2022-09-29 10:20:51.915478');
INSERT INTO public.virksomhet VALUES (507, '820029647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820029647', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.921077', '2022-09-29 10:20:51.921077');
INSERT INTO public.virksomhet VALUES (508, '825514130', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825514130', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.930226', '2022-09-29 10:20:51.930226');
INSERT INTO public.virksomhet VALUES (509, '815801592', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815801592', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.937674', '2022-09-29 10:20:51.937674');
INSERT INTO public.virksomhet VALUES (510, '839528084', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839528084', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.945941', '2022-09-29 10:20:51.945941');
INSERT INTO public.virksomhet VALUES (511, '864571830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864571830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:51.95257', '2022-09-29 10:20:51.95257');
INSERT INTO public.virksomhet VALUES (512, '883989256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883989256', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:55.829975', '2022-09-29 10:20:55.829975');
INSERT INTO public.virksomhet VALUES (513, '831272011', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '110272138 nvaN', '{adresse}', 'AKTIV', NULL, 831272012, '2022-09-29 10:20:55.83838', '2022-09-29 10:20:59.513726');
INSERT INTO public.virksomhet VALUES (514, '831658088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '880856138 nvaN', '{adresse}', 'AKTIV', NULL, 831658089, '2022-09-29 10:20:55.846121', '2022-09-29 10:20:59.523556');
INSERT INTO public.virksomhet VALUES (515, '802008121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '121800208 nvaN', '{adresse}', 'AKTIV', NULL, 802008122, '2022-09-29 10:20:55.852256', '2022-09-29 10:20:59.531263');
INSERT INTO public.virksomhet VALUES (516, '857721878', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '878127758 nvaN', '{adresse}', 'AKTIV', NULL, 857721879, '2022-09-29 10:20:55.858608', '2022-09-29 10:20:59.538179');
INSERT INTO public.virksomhet VALUES (517, '811747377', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '773747118 nvaN', '{adresse}', 'AKTIV', NULL, 811747378, '2022-09-29 10:20:55.864539', '2022-09-29 10:20:59.545583');
INSERT INTO public.virksomhet VALUES (528, '854032309', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '903230458 nvaN', '{adresse}', 'AKTIV', NULL, 854032310, '2022-09-29 10:20:55.917902', '2022-09-29 10:20:59.553253');
INSERT INTO public.virksomhet VALUES (518, '801396893', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801396893', '{adresse}', 'FJERNET', '2010-07-01', 801396894, '2022-09-29 10:20:55.869799', '2022-09-29 10:20:59.559254');
INSERT INTO public.virksomhet VALUES (519, '885133950', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885133950', '{adresse}', 'FJERNET', '2010-07-01', 885133951, '2022-09-29 10:20:55.876034', '2022-09-29 10:20:59.561499');
INSERT INTO public.virksomhet VALUES (520, '864761302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864761302', '{adresse}', 'FJERNET', '2010-07-01', 864761303, '2022-09-29 10:20:55.881386', '2022-09-29 10:20:59.563776');
INSERT INTO public.virksomhet VALUES (521, '870050263', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870050263', '{adresse}', 'FJERNET', '2010-07-01', 870050264, '2022-09-29 10:20:55.885889', '2022-09-29 10:20:59.566087');
INSERT INTO public.virksomhet VALUES (522, '881536611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881536611', '{adresse}', 'FJERNET', '2010-07-01', 881536612, '2022-09-29 10:20:55.891222', '2022-09-29 10:20:59.570167');
INSERT INTO public.virksomhet VALUES (523, '862811969', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862811969', '{adresse}', 'SLETTET', '2010-07-01', 862811970, '2022-09-29 10:20:55.895683', '2022-09-29 10:20:59.57285');
INSERT INTO public.virksomhet VALUES (524, '892708443', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892708443', '{adresse}', 'SLETTET', '2010-07-01', 892708444, '2022-09-29 10:20:55.900107', '2022-09-29 10:20:59.5747');
INSERT INTO public.virksomhet VALUES (525, '866931781', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866931781', '{adresse}', 'SLETTET', '2010-07-01', 866931782, '2022-09-29 10:20:55.90435', '2022-09-29 10:20:59.576119');
INSERT INTO public.virksomhet VALUES (526, '868378133', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868378133', '{adresse}', 'SLETTET', '2010-07-01', 868378134, '2022-09-29 10:20:55.9089', '2022-09-29 10:20:59.579502');
INSERT INTO public.virksomhet VALUES (527, '872308278', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872308278', '{adresse}', 'SLETTET', '2010-07-01', 872308279, '2022-09-29 10:20:55.913396', '2022-09-29 10:20:59.582428');
INSERT INTO public.virksomhet VALUES (535, '854620752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854620752', '{adresse}', 'AKTIV', NULL, 854620753, '2022-09-29 10:20:59.597374', '2022-09-29 10:20:59.597374');
INSERT INTO public.virksomhet VALUES (536, '813662974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813662974', '{adresse}', 'AKTIV', NULL, 813662975, '2022-09-29 10:20:59.622314', '2022-09-29 10:20:59.622314');
INSERT INTO public.virksomhet VALUES (537, '877870510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877870510', '{adresse}', 'AKTIV', NULL, 877870511, '2022-09-29 10:20:59.626424', '2022-09-29 10:20:59.626424');
INSERT INTO public.virksomhet VALUES (538, '828539481', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828539481', '{adresse}', 'AKTIV', NULL, 828539482, '2022-09-29 10:20:59.629669', '2022-09-29 10:20:59.629669');
INSERT INTO public.virksomhet VALUES (539, '833469738', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833469738', '{adresse}', 'AKTIV', NULL, 833469739, '2022-09-29 10:20:59.633976', '2022-09-29 10:20:59.633976');
INSERT INTO public.virksomhet VALUES (540, '846058502', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846058502', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:59.671581', '2022-09-29 10:20:59.671581');
INSERT INTO public.virksomhet VALUES (541, '878151780', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878151780', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2022-09-29 10:20:59.677304', '2022-09-29 10:20:59.677304');


--
-- Data for Name: virksomhet_naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_naring VALUES (1, '90.012');
INSERT INTO public.virksomhet_naring VALUES (2, '70.220');
INSERT INTO public.virksomhet_naring VALUES (2, '90.012');
INSERT INTO public.virksomhet_naring VALUES (3, '90.012');
INSERT INTO public.virksomhet_naring VALUES (4, '90.012');
INSERT INTO public.virksomhet_naring VALUES (4, '70.220');
INSERT INTO public.virksomhet_naring VALUES (5, '90.012');
INSERT INTO public.virksomhet_naring VALUES (6, '01.120');
INSERT INTO public.virksomhet_naring VALUES (6, '90.012');
INSERT INTO public.virksomhet_naring VALUES (7, '01.120');
INSERT INTO public.virksomhet_naring VALUES (8, '01.120');
INSERT INTO public.virksomhet_naring VALUES (9, '01.120');
INSERT INTO public.virksomhet_naring VALUES (10, '01.120');
INSERT INTO public.virksomhet_naring VALUES (11, '01.120');
INSERT INTO public.virksomhet_naring VALUES (12, '01.120');
INSERT INTO public.virksomhet_naring VALUES (12, '90.012');
INSERT INTO public.virksomhet_naring VALUES (12, '70.220');
INSERT INTO public.virksomhet_naring VALUES (13, '01.120');
INSERT INTO public.virksomhet_naring VALUES (14, '01.120');
INSERT INTO public.virksomhet_naring VALUES (14, '90.012');
INSERT INTO public.virksomhet_naring VALUES (15, '01.120');
INSERT INTO public.virksomhet_naring VALUES (15, '90.012');
INSERT INTO public.virksomhet_naring VALUES (15, '70.220');
INSERT INTO public.virksomhet_naring VALUES (16, '01.120');
INSERT INTO public.virksomhet_naring VALUES (16, '90.012');
INSERT INTO public.virksomhet_naring VALUES (16, '70.220');
INSERT INTO public.virksomhet_naring VALUES (17, '01.120');
INSERT INTO public.virksomhet_naring VALUES (18, '01.120');
INSERT INTO public.virksomhet_naring VALUES (19, '01.120');
INSERT INTO public.virksomhet_naring VALUES (20, '01.120');
INSERT INTO public.virksomhet_naring VALUES (21, '01.120');
INSERT INTO public.virksomhet_naring VALUES (22, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '90.012');
INSERT INTO public.virksomhet_naring VALUES (24, '01.120');
INSERT INTO public.virksomhet_naring VALUES (25, '01.120');
INSERT INTO public.virksomhet_naring VALUES (25, '90.012');
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
INSERT INTO public.virksomhet_naring VALUES (35, '01.120');
INSERT INTO public.virksomhet_naring VALUES (36, '01.120');
INSERT INTO public.virksomhet_naring VALUES (36, '90.012');
INSERT INTO public.virksomhet_naring VALUES (37, '01.120');
INSERT INTO public.virksomhet_naring VALUES (38, '01.120');
INSERT INTO public.virksomhet_naring VALUES (39, '01.120');
INSERT INTO public.virksomhet_naring VALUES (40, '01.120');
INSERT INTO public.virksomhet_naring VALUES (41, '01.120');
INSERT INTO public.virksomhet_naring VALUES (42, '01.120');
INSERT INTO public.virksomhet_naring VALUES (43, '01.120');
INSERT INTO public.virksomhet_naring VALUES (43, '90.012');
INSERT INTO public.virksomhet_naring VALUES (43, '70.220');
INSERT INTO public.virksomhet_naring VALUES (44, '01.120');
INSERT INTO public.virksomhet_naring VALUES (44, '90.012');
INSERT INTO public.virksomhet_naring VALUES (44, '70.220');
INSERT INTO public.virksomhet_naring VALUES (45, '01.120');
INSERT INTO public.virksomhet_naring VALUES (46, '01.120');
INSERT INTO public.virksomhet_naring VALUES (46, '90.012');
INSERT INTO public.virksomhet_naring VALUES (47, '01.120');
INSERT INTO public.virksomhet_naring VALUES (47, '90.012');
INSERT INTO public.virksomhet_naring VALUES (48, '01.120');
INSERT INTO public.virksomhet_naring VALUES (48, '90.012');
INSERT INTO public.virksomhet_naring VALUES (49, '01.120');
INSERT INTO public.virksomhet_naring VALUES (50, '01.120');
INSERT INTO public.virksomhet_naring VALUES (51, '01.120');
INSERT INTO public.virksomhet_naring VALUES (52, '01.120');
INSERT INTO public.virksomhet_naring VALUES (52, '90.012');
INSERT INTO public.virksomhet_naring VALUES (53, '01.120');
INSERT INTO public.virksomhet_naring VALUES (53, '90.012');
INSERT INTO public.virksomhet_naring VALUES (54, '01.120');
INSERT INTO public.virksomhet_naring VALUES (55, '01.120');
INSERT INTO public.virksomhet_naring VALUES (56, '01.120');
INSERT INTO public.virksomhet_naring VALUES (56, '90.012');
INSERT INTO public.virksomhet_naring VALUES (57, '01.120');
INSERT INTO public.virksomhet_naring VALUES (57, '90.012');
INSERT INTO public.virksomhet_naring VALUES (58, '01.120');
INSERT INTO public.virksomhet_naring VALUES (58, '90.012');
INSERT INTO public.virksomhet_naring VALUES (59, '01.120');
INSERT INTO public.virksomhet_naring VALUES (59, '90.012');
INSERT INTO public.virksomhet_naring VALUES (59, '70.220');
INSERT INTO public.virksomhet_naring VALUES (60, '01.120');
INSERT INTO public.virksomhet_naring VALUES (61, '01.120');
INSERT INTO public.virksomhet_naring VALUES (61, '90.012');
INSERT INTO public.virksomhet_naring VALUES (62, '01.120');
INSERT INTO public.virksomhet_naring VALUES (62, '90.012');
INSERT INTO public.virksomhet_naring VALUES (63, '01.120');
INSERT INTO public.virksomhet_naring VALUES (64, '01.120');
INSERT INTO public.virksomhet_naring VALUES (64, '90.012');
INSERT INTO public.virksomhet_naring VALUES (65, '01.120');
INSERT INTO public.virksomhet_naring VALUES (65, '90.012');
INSERT INTO public.virksomhet_naring VALUES (65, '70.220');
INSERT INTO public.virksomhet_naring VALUES (66, '01.120');
INSERT INTO public.virksomhet_naring VALUES (67, '01.120');
INSERT INTO public.virksomhet_naring VALUES (68, '01.120');
INSERT INTO public.virksomhet_naring VALUES (68, '90.012');
INSERT INTO public.virksomhet_naring VALUES (69, '01.120');
INSERT INTO public.virksomhet_naring VALUES (70, '01.120');
INSERT INTO public.virksomhet_naring VALUES (70, '90.012');
INSERT INTO public.virksomhet_naring VALUES (70, '70.220');
INSERT INTO public.virksomhet_naring VALUES (71, '01.120');
INSERT INTO public.virksomhet_naring VALUES (71, '90.012');
INSERT INTO public.virksomhet_naring VALUES (71, '70.220');
INSERT INTO public.virksomhet_naring VALUES (72, '01.120');
INSERT INTO public.virksomhet_naring VALUES (73, '01.120');
INSERT INTO public.virksomhet_naring VALUES (74, '01.120');
INSERT INTO public.virksomhet_naring VALUES (75, '01.120');
INSERT INTO public.virksomhet_naring VALUES (75, '90.012');
INSERT INTO public.virksomhet_naring VALUES (75, '70.220');
INSERT INTO public.virksomhet_naring VALUES (76, '01.120');
INSERT INTO public.virksomhet_naring VALUES (76, '90.012');
INSERT INTO public.virksomhet_naring VALUES (76, '70.220');
INSERT INTO public.virksomhet_naring VALUES (77, '01.120');
INSERT INTO public.virksomhet_naring VALUES (78, '01.120');
INSERT INTO public.virksomhet_naring VALUES (78, '90.012');
INSERT INTO public.virksomhet_naring VALUES (79, '01.120');
INSERT INTO public.virksomhet_naring VALUES (80, '01.120');
INSERT INTO public.virksomhet_naring VALUES (80, '90.012');
INSERT INTO public.virksomhet_naring VALUES (81, '01.120');
INSERT INTO public.virksomhet_naring VALUES (82, '01.120');
INSERT INTO public.virksomhet_naring VALUES (83, '01.120');
INSERT INTO public.virksomhet_naring VALUES (83, '90.012');
INSERT INTO public.virksomhet_naring VALUES (84, '01.120');
INSERT INTO public.virksomhet_naring VALUES (84, '90.012');
INSERT INTO public.virksomhet_naring VALUES (84, '70.220');
INSERT INTO public.virksomhet_naring VALUES (85, '01.120');
INSERT INTO public.virksomhet_naring VALUES (86, '01.120');
INSERT INTO public.virksomhet_naring VALUES (87, '01.120');
INSERT INTO public.virksomhet_naring VALUES (87, '90.012');
INSERT INTO public.virksomhet_naring VALUES (88, '01.120');
INSERT INTO public.virksomhet_naring VALUES (88, '90.012');
INSERT INTO public.virksomhet_naring VALUES (89, '01.120');
INSERT INTO public.virksomhet_naring VALUES (89, '90.012');
INSERT INTO public.virksomhet_naring VALUES (90, '01.120');
INSERT INTO public.virksomhet_naring VALUES (90, '90.012');
INSERT INTO public.virksomhet_naring VALUES (91, '01.120');
INSERT INTO public.virksomhet_naring VALUES (92, '01.120');
INSERT INTO public.virksomhet_naring VALUES (93, '01.120');
INSERT INTO public.virksomhet_naring VALUES (94, '01.120');
INSERT INTO public.virksomhet_naring VALUES (95, '01.120');
INSERT INTO public.virksomhet_naring VALUES (95, '90.012');
INSERT INTO public.virksomhet_naring VALUES (96, '01.120');
INSERT INTO public.virksomhet_naring VALUES (97, '01.120');
INSERT INTO public.virksomhet_naring VALUES (97, '90.012');
INSERT INTO public.virksomhet_naring VALUES (98, '01.120');
INSERT INTO public.virksomhet_naring VALUES (98, '90.012');
INSERT INTO public.virksomhet_naring VALUES (98, '70.220');
INSERT INTO public.virksomhet_naring VALUES (99, '01.120');
INSERT INTO public.virksomhet_naring VALUES (99, '90.012');
INSERT INTO public.virksomhet_naring VALUES (100, '01.120');
INSERT INTO public.virksomhet_naring VALUES (101, '01.120');
INSERT INTO public.virksomhet_naring VALUES (101, '90.012');
INSERT INTO public.virksomhet_naring VALUES (101, '70.220');
INSERT INTO public.virksomhet_naring VALUES (102, '01.120');
INSERT INTO public.virksomhet_naring VALUES (102, '90.012');
INSERT INTO public.virksomhet_naring VALUES (103, '01.120');
INSERT INTO public.virksomhet_naring VALUES (104, '01.120');
INSERT INTO public.virksomhet_naring VALUES (105, '01.120');
INSERT INTO public.virksomhet_naring VALUES (106, '01.120');
INSERT INTO public.virksomhet_naring VALUES (106, '90.012');
INSERT INTO public.virksomhet_naring VALUES (107, '01.120');
INSERT INTO public.virksomhet_naring VALUES (108, '01.120');
INSERT INTO public.virksomhet_naring VALUES (108, '90.012');
INSERT INTO public.virksomhet_naring VALUES (108, '70.220');
INSERT INTO public.virksomhet_naring VALUES (109, '01.120');
INSERT INTO public.virksomhet_naring VALUES (109, '90.012');
INSERT INTO public.virksomhet_naring VALUES (109, '70.220');
INSERT INTO public.virksomhet_naring VALUES (110, '01.120');
INSERT INTO public.virksomhet_naring VALUES (111, '01.120');
INSERT INTO public.virksomhet_naring VALUES (112, '01.120');
INSERT INTO public.virksomhet_naring VALUES (112, '90.012');
INSERT INTO public.virksomhet_naring VALUES (113, '01.120');
INSERT INTO public.virksomhet_naring VALUES (113, '90.012');
INSERT INTO public.virksomhet_naring VALUES (113, '70.220');
INSERT INTO public.virksomhet_naring VALUES (114, '01.120');
INSERT INTO public.virksomhet_naring VALUES (114, '90.012');
INSERT INTO public.virksomhet_naring VALUES (114, '70.220');
INSERT INTO public.virksomhet_naring VALUES (115, '01.120');
INSERT INTO public.virksomhet_naring VALUES (116, '01.120');
INSERT INTO public.virksomhet_naring VALUES (116, '90.012');
INSERT INTO public.virksomhet_naring VALUES (116, '70.220');
INSERT INTO public.virksomhet_naring VALUES (117, '01.120');
INSERT INTO public.virksomhet_naring VALUES (118, '01.120');
INSERT INTO public.virksomhet_naring VALUES (119, '01.120');
INSERT INTO public.virksomhet_naring VALUES (120, '01.120');
INSERT INTO public.virksomhet_naring VALUES (120, '90.012');
INSERT INTO public.virksomhet_naring VALUES (121, '01.120');
INSERT INTO public.virksomhet_naring VALUES (122, '01.120');
INSERT INTO public.virksomhet_naring VALUES (122, '90.012');
INSERT INTO public.virksomhet_naring VALUES (123, '01.120');
INSERT INTO public.virksomhet_naring VALUES (123, '90.012');
INSERT INTO public.virksomhet_naring VALUES (124, '01.120');
INSERT INTO public.virksomhet_naring VALUES (125, '01.120');
INSERT INTO public.virksomhet_naring VALUES (126, '01.120');
INSERT INTO public.virksomhet_naring VALUES (126, '90.012');
INSERT INTO public.virksomhet_naring VALUES (127, '01.120');
INSERT INTO public.virksomhet_naring VALUES (128, '01.120');
INSERT INTO public.virksomhet_naring VALUES (128, '90.012');
INSERT INTO public.virksomhet_naring VALUES (129, '01.120');
INSERT INTO public.virksomhet_naring VALUES (130, '01.120');
INSERT INTO public.virksomhet_naring VALUES (131, '01.120');
INSERT INTO public.virksomhet_naring VALUES (131, '90.012');
INSERT INTO public.virksomhet_naring VALUES (132, '01.120');
INSERT INTO public.virksomhet_naring VALUES (133, '01.120');
INSERT INTO public.virksomhet_naring VALUES (133, '90.012');
INSERT INTO public.virksomhet_naring VALUES (134, '01.120');
INSERT INTO public.virksomhet_naring VALUES (135, '01.120');
INSERT INTO public.virksomhet_naring VALUES (135, '90.012');
INSERT INTO public.virksomhet_naring VALUES (136, '01.120');
INSERT INTO public.virksomhet_naring VALUES (136, '90.012');
INSERT INTO public.virksomhet_naring VALUES (136, '70.220');
INSERT INTO public.virksomhet_naring VALUES (137, '01.120');
INSERT INTO public.virksomhet_naring VALUES (138, '01.120');
INSERT INTO public.virksomhet_naring VALUES (139, '01.120');
INSERT INTO public.virksomhet_naring VALUES (140, '01.120');
INSERT INTO public.virksomhet_naring VALUES (140, '90.012');
INSERT INTO public.virksomhet_naring VALUES (141, '01.120');
INSERT INTO public.virksomhet_naring VALUES (142, '01.120');
INSERT INTO public.virksomhet_naring VALUES (143, '01.120');
INSERT INTO public.virksomhet_naring VALUES (144, '01.120');
INSERT INTO public.virksomhet_naring VALUES (145, '01.120');
INSERT INTO public.virksomhet_naring VALUES (146, '01.120');
INSERT INTO public.virksomhet_naring VALUES (147, '01.120');
INSERT INTO public.virksomhet_naring VALUES (147, '90.012');
INSERT INTO public.virksomhet_naring VALUES (148, '01.120');
INSERT INTO public.virksomhet_naring VALUES (148, '90.012');
INSERT INTO public.virksomhet_naring VALUES (149, '01.120');
INSERT INTO public.virksomhet_naring VALUES (149, '90.012');
INSERT INTO public.virksomhet_naring VALUES (150, '01.120');
INSERT INTO public.virksomhet_naring VALUES (150, '90.012');
INSERT INTO public.virksomhet_naring VALUES (151, '01.120');
INSERT INTO public.virksomhet_naring VALUES (151, '90.012');
INSERT INTO public.virksomhet_naring VALUES (151, '70.220');
INSERT INTO public.virksomhet_naring VALUES (152, '01.120');
INSERT INTO public.virksomhet_naring VALUES (152, '90.012');
INSERT INTO public.virksomhet_naring VALUES (153, '01.120');
INSERT INTO public.virksomhet_naring VALUES (154, '01.120');
INSERT INTO public.virksomhet_naring VALUES (154, '90.012');
INSERT INTO public.virksomhet_naring VALUES (155, '01.120');
INSERT INTO public.virksomhet_naring VALUES (155, '90.012');
INSERT INTO public.virksomhet_naring VALUES (155, '70.220');
INSERT INTO public.virksomhet_naring VALUES (156, '01.120');
INSERT INTO public.virksomhet_naring VALUES (157, '01.120');
INSERT INTO public.virksomhet_naring VALUES (157, '90.012');
INSERT INTO public.virksomhet_naring VALUES (158, '01.120');
INSERT INTO public.virksomhet_naring VALUES (158, '90.012');
INSERT INTO public.virksomhet_naring VALUES (158, '70.220');
INSERT INTO public.virksomhet_naring VALUES (159, '01.120');
INSERT INTO public.virksomhet_naring VALUES (160, '01.120');
INSERT INTO public.virksomhet_naring VALUES (160, '90.012');
INSERT INTO public.virksomhet_naring VALUES (160, '70.220');
INSERT INTO public.virksomhet_naring VALUES (161, '01.120');
INSERT INTO public.virksomhet_naring VALUES (161, '90.012');
INSERT INTO public.virksomhet_naring VALUES (162, '01.120');
INSERT INTO public.virksomhet_naring VALUES (163, '01.120');
INSERT INTO public.virksomhet_naring VALUES (163, '90.012');
INSERT INTO public.virksomhet_naring VALUES (164, '01.120');
INSERT INTO public.virksomhet_naring VALUES (165, '01.120');
INSERT INTO public.virksomhet_naring VALUES (165, '90.012');
INSERT INTO public.virksomhet_naring VALUES (166, '01.120');
INSERT INTO public.virksomhet_naring VALUES (166, '90.012');
INSERT INTO public.virksomhet_naring VALUES (167, '01.120');
INSERT INTO public.virksomhet_naring VALUES (167, '90.012');
INSERT INTO public.virksomhet_naring VALUES (168, '01.120');
INSERT INTO public.virksomhet_naring VALUES (169, '01.120');
INSERT INTO public.virksomhet_naring VALUES (169, '90.012');
INSERT INTO public.virksomhet_naring VALUES (170, '01.120');
INSERT INTO public.virksomhet_naring VALUES (171, '01.120');
INSERT INTO public.virksomhet_naring VALUES (171, '90.012');
INSERT INTO public.virksomhet_naring VALUES (172, '01.120');
INSERT INTO public.virksomhet_naring VALUES (172, '90.012');
INSERT INTO public.virksomhet_naring VALUES (173, '01.120');
INSERT INTO public.virksomhet_naring VALUES (174, '01.120');
INSERT INTO public.virksomhet_naring VALUES (175, '01.120');
INSERT INTO public.virksomhet_naring VALUES (175, '90.012');
INSERT INTO public.virksomhet_naring VALUES (175, '70.220');
INSERT INTO public.virksomhet_naring VALUES (176, '01.120');
INSERT INTO public.virksomhet_naring VALUES (176, '90.012');
INSERT INTO public.virksomhet_naring VALUES (177, '01.120');
INSERT INTO public.virksomhet_naring VALUES (177, '90.012');
INSERT INTO public.virksomhet_naring VALUES (178, '01.120');
INSERT INTO public.virksomhet_naring VALUES (179, '01.120');
INSERT INTO public.virksomhet_naring VALUES (179, '90.012');
INSERT INTO public.virksomhet_naring VALUES (180, '01.120');
INSERT INTO public.virksomhet_naring VALUES (180, '90.012');
INSERT INTO public.virksomhet_naring VALUES (181, '01.120');
INSERT INTO public.virksomhet_naring VALUES (181, '90.012');
INSERT INTO public.virksomhet_naring VALUES (181, '70.220');
INSERT INTO public.virksomhet_naring VALUES (182, '01.120');
INSERT INTO public.virksomhet_naring VALUES (182, '90.012');
INSERT INTO public.virksomhet_naring VALUES (182, '70.220');
INSERT INTO public.virksomhet_naring VALUES (183, '01.120');
INSERT INTO public.virksomhet_naring VALUES (184, '01.120');
INSERT INTO public.virksomhet_naring VALUES (184, '90.012');
INSERT INTO public.virksomhet_naring VALUES (185, '01.120');
INSERT INTO public.virksomhet_naring VALUES (185, '90.012');
INSERT INTO public.virksomhet_naring VALUES (185, '70.220');
INSERT INTO public.virksomhet_naring VALUES (186, '01.120');
INSERT INTO public.virksomhet_naring VALUES (186, '90.012');
INSERT INTO public.virksomhet_naring VALUES (187, '01.120');
INSERT INTO public.virksomhet_naring VALUES (187, '90.012');
INSERT INTO public.virksomhet_naring VALUES (187, '70.220');
INSERT INTO public.virksomhet_naring VALUES (188, '01.120');
INSERT INTO public.virksomhet_naring VALUES (188, '90.012');
INSERT INTO public.virksomhet_naring VALUES (188, '70.220');
INSERT INTO public.virksomhet_naring VALUES (189, '01.120');
INSERT INTO public.virksomhet_naring VALUES (190, '01.120');
INSERT INTO public.virksomhet_naring VALUES (190, '90.012');
INSERT INTO public.virksomhet_naring VALUES (190, '70.220');
INSERT INTO public.virksomhet_naring VALUES (191, '01.120');
INSERT INTO public.virksomhet_naring VALUES (192, '01.120');
INSERT INTO public.virksomhet_naring VALUES (192, '90.012');
INSERT INTO public.virksomhet_naring VALUES (193, '01.120');
INSERT INTO public.virksomhet_naring VALUES (194, '01.120');
INSERT INTO public.virksomhet_naring VALUES (194, '90.012');
INSERT INTO public.virksomhet_naring VALUES (194, '70.220');
INSERT INTO public.virksomhet_naring VALUES (195, '01.120');
INSERT INTO public.virksomhet_naring VALUES (195, '90.012');
INSERT INTO public.virksomhet_naring VALUES (195, '70.220');
INSERT INTO public.virksomhet_naring VALUES (196, '01.120');
INSERT INTO public.virksomhet_naring VALUES (197, '01.120');
INSERT INTO public.virksomhet_naring VALUES (198, '01.120');
INSERT INTO public.virksomhet_naring VALUES (198, '90.012');
INSERT INTO public.virksomhet_naring VALUES (199, '01.120');
INSERT INTO public.virksomhet_naring VALUES (200, '01.120');
INSERT INTO public.virksomhet_naring VALUES (200, '90.012');
INSERT INTO public.virksomhet_naring VALUES (201, '01.120');
INSERT INTO public.virksomhet_naring VALUES (201, '90.012');
INSERT INTO public.virksomhet_naring VALUES (202, '01.120');
INSERT INTO public.virksomhet_naring VALUES (202, '90.012');
INSERT INTO public.virksomhet_naring VALUES (203, '01.120');
INSERT INTO public.virksomhet_naring VALUES (204, '01.120');
INSERT INTO public.virksomhet_naring VALUES (204, '90.012');
INSERT INTO public.virksomhet_naring VALUES (205, '01.120');
INSERT INTO public.virksomhet_naring VALUES (205, '90.012');
INSERT INTO public.virksomhet_naring VALUES (206, '01.120');
INSERT INTO public.virksomhet_naring VALUES (207, '01.120');
INSERT INTO public.virksomhet_naring VALUES (208, '01.120');
INSERT INTO public.virksomhet_naring VALUES (209, '01.120');
INSERT INTO public.virksomhet_naring VALUES (209, '90.012');
INSERT INTO public.virksomhet_naring VALUES (210, '01.120');
INSERT INTO public.virksomhet_naring VALUES (210, '90.012');
INSERT INTO public.virksomhet_naring VALUES (210, '70.220');
INSERT INTO public.virksomhet_naring VALUES (211, '01.120');
INSERT INTO public.virksomhet_naring VALUES (212, '01.120');
INSERT INTO public.virksomhet_naring VALUES (212, '90.012');
INSERT INTO public.virksomhet_naring VALUES (213, '01.120');
INSERT INTO public.virksomhet_naring VALUES (213, '90.012');
INSERT INTO public.virksomhet_naring VALUES (213, '70.220');
INSERT INTO public.virksomhet_naring VALUES (214, '01.120');
INSERT INTO public.virksomhet_naring VALUES (214, '90.012');
INSERT INTO public.virksomhet_naring VALUES (215, '01.120');
INSERT INTO public.virksomhet_naring VALUES (216, '01.120');
INSERT INTO public.virksomhet_naring VALUES (217, '01.120');
INSERT INTO public.virksomhet_naring VALUES (218, '01.120');
INSERT INTO public.virksomhet_naring VALUES (218, '90.012');
INSERT INTO public.virksomhet_naring VALUES (219, '01.120');
INSERT INTO public.virksomhet_naring VALUES (219, '90.012');
INSERT INTO public.virksomhet_naring VALUES (219, '70.220');
INSERT INTO public.virksomhet_naring VALUES (220, '01.120');
INSERT INTO public.virksomhet_naring VALUES (220, '90.012');
INSERT INTO public.virksomhet_naring VALUES (220, '70.220');
INSERT INTO public.virksomhet_naring VALUES (221, '01.120');
INSERT INTO public.virksomhet_naring VALUES (222, '01.120');
INSERT INTO public.virksomhet_naring VALUES (223, '01.120');
INSERT INTO public.virksomhet_naring VALUES (223, '90.012');
INSERT INTO public.virksomhet_naring VALUES (223, '70.220');
INSERT INTO public.virksomhet_naring VALUES (224, '01.120');
INSERT INTO public.virksomhet_naring VALUES (224, '90.012');
INSERT INTO public.virksomhet_naring VALUES (225, '01.120');
INSERT INTO public.virksomhet_naring VALUES (225, '90.012');
INSERT INTO public.virksomhet_naring VALUES (226, '01.120');
INSERT INTO public.virksomhet_naring VALUES (226, '90.012');
INSERT INTO public.virksomhet_naring VALUES (226, '70.220');
INSERT INTO public.virksomhet_naring VALUES (227, '01.120');
INSERT INTO public.virksomhet_naring VALUES (228, '01.120');
INSERT INTO public.virksomhet_naring VALUES (228, '90.012');
INSERT INTO public.virksomhet_naring VALUES (229, '01.120');
INSERT INTO public.virksomhet_naring VALUES (230, '01.120');
INSERT INTO public.virksomhet_naring VALUES (230, '90.012');
INSERT INTO public.virksomhet_naring VALUES (231, '01.120');
INSERT INTO public.virksomhet_naring VALUES (232, '01.120');
INSERT INTO public.virksomhet_naring VALUES (233, '01.120');
INSERT INTO public.virksomhet_naring VALUES (234, '01.120');
INSERT INTO public.virksomhet_naring VALUES (235, '01.120');
INSERT INTO public.virksomhet_naring VALUES (236, '01.120');
INSERT INTO public.virksomhet_naring VALUES (237, '01.120');
INSERT INTO public.virksomhet_naring VALUES (237, '90.012');
INSERT INTO public.virksomhet_naring VALUES (237, '70.220');
INSERT INTO public.virksomhet_naring VALUES (238, '01.120');
INSERT INTO public.virksomhet_naring VALUES (239, '01.120');
INSERT INTO public.virksomhet_naring VALUES (240, '01.120');
INSERT INTO public.virksomhet_naring VALUES (241, '01.120');
INSERT INTO public.virksomhet_naring VALUES (241, '90.012');
INSERT INTO public.virksomhet_naring VALUES (241, '70.220');
INSERT INTO public.virksomhet_naring VALUES (242, '01.120');
INSERT INTO public.virksomhet_naring VALUES (243, '01.120');
INSERT INTO public.virksomhet_naring VALUES (244, '01.120');
INSERT INTO public.virksomhet_naring VALUES (245, '01.120');
INSERT INTO public.virksomhet_naring VALUES (246, '01.120');
INSERT INTO public.virksomhet_naring VALUES (246, '90.012');
INSERT INTO public.virksomhet_naring VALUES (247, '01.120');
INSERT INTO public.virksomhet_naring VALUES (247, '90.012');
INSERT INTO public.virksomhet_naring VALUES (248, '01.120');
INSERT INTO public.virksomhet_naring VALUES (248, '90.012');
INSERT INTO public.virksomhet_naring VALUES (248, '70.220');
INSERT INTO public.virksomhet_naring VALUES (249, '01.120');
INSERT INTO public.virksomhet_naring VALUES (250, '01.120');
INSERT INTO public.virksomhet_naring VALUES (251, '01.120');
INSERT INTO public.virksomhet_naring VALUES (252, '01.120');
INSERT INTO public.virksomhet_naring VALUES (253, '01.120');
INSERT INTO public.virksomhet_naring VALUES (253, '90.012');
INSERT INTO public.virksomhet_naring VALUES (253, '70.220');
INSERT INTO public.virksomhet_naring VALUES (254, '01.120');
INSERT INTO public.virksomhet_naring VALUES (255, '01.120');
INSERT INTO public.virksomhet_naring VALUES (255, '90.012');
INSERT INTO public.virksomhet_naring VALUES (256, '01.120');
INSERT INTO public.virksomhet_naring VALUES (257, '01.120');
INSERT INTO public.virksomhet_naring VALUES (257, '90.012');
INSERT INTO public.virksomhet_naring VALUES (257, '70.220');
INSERT INTO public.virksomhet_naring VALUES (258, '01.120');
INSERT INTO public.virksomhet_naring VALUES (259, '01.120');
INSERT INTO public.virksomhet_naring VALUES (260, '01.120');
INSERT INTO public.virksomhet_naring VALUES (260, '90.012');
INSERT INTO public.virksomhet_naring VALUES (261, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '90.012');
INSERT INTO public.virksomhet_naring VALUES (262, '01.120');
INSERT INTO public.virksomhet_naring VALUES (263, '01.120');
INSERT INTO public.virksomhet_naring VALUES (264, '01.120');
INSERT INTO public.virksomhet_naring VALUES (265, '01.120');
INSERT INTO public.virksomhet_naring VALUES (266, '01.120');
INSERT INTO public.virksomhet_naring VALUES (267, '01.120');
INSERT INTO public.virksomhet_naring VALUES (268, '01.120');
INSERT INTO public.virksomhet_naring VALUES (268, '90.012');
INSERT INTO public.virksomhet_naring VALUES (268, '70.220');
INSERT INTO public.virksomhet_naring VALUES (269, '01.120');
INSERT INTO public.virksomhet_naring VALUES (269, '90.012');
INSERT INTO public.virksomhet_naring VALUES (270, '01.120');
INSERT INTO public.virksomhet_naring VALUES (271, '01.120');
INSERT INTO public.virksomhet_naring VALUES (272, '01.120');
INSERT INTO public.virksomhet_naring VALUES (272, '90.012');
INSERT INTO public.virksomhet_naring VALUES (273, '01.120');
INSERT INTO public.virksomhet_naring VALUES (274, '01.120');
INSERT INTO public.virksomhet_naring VALUES (275, '01.120');
INSERT INTO public.virksomhet_naring VALUES (275, '90.012');
INSERT INTO public.virksomhet_naring VALUES (275, '70.220');
INSERT INTO public.virksomhet_naring VALUES (276, '01.120');
INSERT INTO public.virksomhet_naring VALUES (277, '01.120');
INSERT INTO public.virksomhet_naring VALUES (278, '01.120');
INSERT INTO public.virksomhet_naring VALUES (278, '90.012');
INSERT INTO public.virksomhet_naring VALUES (279, '01.120');
INSERT INTO public.virksomhet_naring VALUES (280, '01.120');
INSERT INTO public.virksomhet_naring VALUES (280, '90.012');
INSERT INTO public.virksomhet_naring VALUES (280, '70.220');
INSERT INTO public.virksomhet_naring VALUES (281, '01.120');
INSERT INTO public.virksomhet_naring VALUES (282, '01.120');
INSERT INTO public.virksomhet_naring VALUES (283, '01.120');
INSERT INTO public.virksomhet_naring VALUES (283, '90.012');
INSERT INTO public.virksomhet_naring VALUES (283, '70.220');
INSERT INTO public.virksomhet_naring VALUES (284, '01.120');
INSERT INTO public.virksomhet_naring VALUES (284, '90.012');
INSERT INTO public.virksomhet_naring VALUES (284, '70.220');
INSERT INTO public.virksomhet_naring VALUES (285, '01.120');
INSERT INTO public.virksomhet_naring VALUES (285, '90.012');
INSERT INTO public.virksomhet_naring VALUES (285, '70.220');
INSERT INTO public.virksomhet_naring VALUES (286, '01.120');
INSERT INTO public.virksomhet_naring VALUES (286, '90.012');
INSERT INTO public.virksomhet_naring VALUES (286, '70.220');
INSERT INTO public.virksomhet_naring VALUES (287, '01.120');
INSERT INTO public.virksomhet_naring VALUES (288, '01.120');
INSERT INTO public.virksomhet_naring VALUES (289, '01.120');
INSERT INTO public.virksomhet_naring VALUES (290, '01.120');
INSERT INTO public.virksomhet_naring VALUES (291, '01.120');
INSERT INTO public.virksomhet_naring VALUES (291, '90.012');
INSERT INTO public.virksomhet_naring VALUES (291, '70.220');
INSERT INTO public.virksomhet_naring VALUES (292, '01.120');
INSERT INTO public.virksomhet_naring VALUES (293, '01.120');
INSERT INTO public.virksomhet_naring VALUES (294, '01.120');
INSERT INTO public.virksomhet_naring VALUES (294, '90.012');
INSERT INTO public.virksomhet_naring VALUES (294, '70.220');
INSERT INTO public.virksomhet_naring VALUES (295, '01.120');
INSERT INTO public.virksomhet_naring VALUES (296, '01.120');
INSERT INTO public.virksomhet_naring VALUES (296, '90.012');
INSERT INTO public.virksomhet_naring VALUES (297, '01.120');
INSERT INTO public.virksomhet_naring VALUES (297, '90.012');
INSERT INTO public.virksomhet_naring VALUES (298, '01.120');
INSERT INTO public.virksomhet_naring VALUES (298, '90.012');
INSERT INTO public.virksomhet_naring VALUES (298, '70.220');
INSERT INTO public.virksomhet_naring VALUES (299, '01.120');
INSERT INTO public.virksomhet_naring VALUES (299, '90.012');
INSERT INTO public.virksomhet_naring VALUES (299, '70.220');
INSERT INTO public.virksomhet_naring VALUES (300, '01.120');
INSERT INTO public.virksomhet_naring VALUES (300, '90.012');
INSERT INTO public.virksomhet_naring VALUES (301, '01.120');
INSERT INTO public.virksomhet_naring VALUES (301, '90.012');
INSERT INTO public.virksomhet_naring VALUES (302, '01.120');
INSERT INTO public.virksomhet_naring VALUES (303, '01.120');
INSERT INTO public.virksomhet_naring VALUES (303, '90.012');
INSERT INTO public.virksomhet_naring VALUES (304, '01.120');
INSERT INTO public.virksomhet_naring VALUES (304, '90.012');
INSERT INTO public.virksomhet_naring VALUES (305, '01.120');
INSERT INTO public.virksomhet_naring VALUES (305, '90.012');
INSERT INTO public.virksomhet_naring VALUES (306, '01.120');
INSERT INTO public.virksomhet_naring VALUES (307, '01.120');
INSERT INTO public.virksomhet_naring VALUES (307, '90.012');
INSERT INTO public.virksomhet_naring VALUES (308, '01.120');
INSERT INTO public.virksomhet_naring VALUES (308, '90.012');
INSERT INTO public.virksomhet_naring VALUES (309, '01.120');
INSERT INTO public.virksomhet_naring VALUES (310, '01.120');
INSERT INTO public.virksomhet_naring VALUES (311, '01.120');
INSERT INTO public.virksomhet_naring VALUES (311, '90.012');
INSERT INTO public.virksomhet_naring VALUES (312, '01.120');
INSERT INTO public.virksomhet_naring VALUES (313, '01.120');
INSERT INTO public.virksomhet_naring VALUES (313, '90.012');
INSERT INTO public.virksomhet_naring VALUES (313, '70.220');
INSERT INTO public.virksomhet_naring VALUES (314, '01.120');
INSERT INTO public.virksomhet_naring VALUES (315, '01.120');
INSERT INTO public.virksomhet_naring VALUES (315, '90.012');
INSERT INTO public.virksomhet_naring VALUES (316, '01.120');
INSERT INTO public.virksomhet_naring VALUES (316, '90.012');
INSERT INTO public.virksomhet_naring VALUES (317, '01.120');
INSERT INTO public.virksomhet_naring VALUES (318, '01.120');
INSERT INTO public.virksomhet_naring VALUES (319, '01.120');
INSERT INTO public.virksomhet_naring VALUES (320, '01.120');
INSERT INTO public.virksomhet_naring VALUES (321, '01.120');
INSERT INTO public.virksomhet_naring VALUES (321, '90.012');
INSERT INTO public.virksomhet_naring VALUES (322, '01.120');
INSERT INTO public.virksomhet_naring VALUES (322, '90.012');
INSERT INTO public.virksomhet_naring VALUES (323, '01.120');
INSERT INTO public.virksomhet_naring VALUES (324, '01.120');
INSERT INTO public.virksomhet_naring VALUES (325, '01.120');
INSERT INTO public.virksomhet_naring VALUES (326, '01.120');
INSERT INTO public.virksomhet_naring VALUES (326, '90.012');
INSERT INTO public.virksomhet_naring VALUES (326, '70.220');
INSERT INTO public.virksomhet_naring VALUES (327, '01.120');
INSERT INTO public.virksomhet_naring VALUES (328, '01.120');
INSERT INTO public.virksomhet_naring VALUES (328, '90.012');
INSERT INTO public.virksomhet_naring VALUES (328, '70.220');
INSERT INTO public.virksomhet_naring VALUES (329, '01.120');
INSERT INTO public.virksomhet_naring VALUES (329, '90.012');
INSERT INTO public.virksomhet_naring VALUES (329, '70.220');
INSERT INTO public.virksomhet_naring VALUES (330, '01.120');
INSERT INTO public.virksomhet_naring VALUES (331, '01.120');
INSERT INTO public.virksomhet_naring VALUES (332, '01.120');
INSERT INTO public.virksomhet_naring VALUES (332, '90.012');
INSERT INTO public.virksomhet_naring VALUES (333, '01.120');
INSERT INTO public.virksomhet_naring VALUES (333, '90.012');
INSERT INTO public.virksomhet_naring VALUES (333, '70.220');
INSERT INTO public.virksomhet_naring VALUES (334, '01.120');
INSERT INTO public.virksomhet_naring VALUES (334, '90.012');
INSERT INTO public.virksomhet_naring VALUES (334, '70.220');
INSERT INTO public.virksomhet_naring VALUES (335, '01.120');
INSERT INTO public.virksomhet_naring VALUES (335, '90.012');
INSERT INTO public.virksomhet_naring VALUES (335, '70.220');
INSERT INTO public.virksomhet_naring VALUES (336, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '90.012');
INSERT INTO public.virksomhet_naring VALUES (337, '70.220');
INSERT INTO public.virksomhet_naring VALUES (338, '01.120');
INSERT INTO public.virksomhet_naring VALUES (339, '01.120');
INSERT INTO public.virksomhet_naring VALUES (339, '90.012');
INSERT INTO public.virksomhet_naring VALUES (340, '01.120');
INSERT INTO public.virksomhet_naring VALUES (341, '01.120');
INSERT INTO public.virksomhet_naring VALUES (341, '90.012');
INSERT INTO public.virksomhet_naring VALUES (342, '01.120');
INSERT INTO public.virksomhet_naring VALUES (342, '90.012');
INSERT INTO public.virksomhet_naring VALUES (343, '01.120');
INSERT INTO public.virksomhet_naring VALUES (344, '01.120');
INSERT INTO public.virksomhet_naring VALUES (344, '90.012');
INSERT INTO public.virksomhet_naring VALUES (345, '01.120');
INSERT INTO public.virksomhet_naring VALUES (346, '01.120');
INSERT INTO public.virksomhet_naring VALUES (347, '01.120');
INSERT INTO public.virksomhet_naring VALUES (348, '01.120');
INSERT INTO public.virksomhet_naring VALUES (348, '90.012');
INSERT INTO public.virksomhet_naring VALUES (349, '01.120');
INSERT INTO public.virksomhet_naring VALUES (350, '01.120');
INSERT INTO public.virksomhet_naring VALUES (351, '01.120');
INSERT INTO public.virksomhet_naring VALUES (351, '90.012');
INSERT INTO public.virksomhet_naring VALUES (352, '01.120');
INSERT INTO public.virksomhet_naring VALUES (353, '01.120');
INSERT INTO public.virksomhet_naring VALUES (354, '01.120');
INSERT INTO public.virksomhet_naring VALUES (354, '90.012');
INSERT INTO public.virksomhet_naring VALUES (355, '01.120');
INSERT INTO public.virksomhet_naring VALUES (355, '90.012');
INSERT INTO public.virksomhet_naring VALUES (356, '01.120');
INSERT INTO public.virksomhet_naring VALUES (356, '90.012');
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
INSERT INTO public.virksomhet_naring VALUES (363, '01.120');
INSERT INTO public.virksomhet_naring VALUES (364, '01.120');
INSERT INTO public.virksomhet_naring VALUES (365, '01.120');
INSERT INTO public.virksomhet_naring VALUES (365, '90.012');
INSERT INTO public.virksomhet_naring VALUES (366, '01.120');
INSERT INTO public.virksomhet_naring VALUES (366, '90.012');
INSERT INTO public.virksomhet_naring VALUES (367, '01.120');
INSERT INTO public.virksomhet_naring VALUES (367, '90.012');
INSERT INTO public.virksomhet_naring VALUES (368, '01.120');
INSERT INTO public.virksomhet_naring VALUES (369, '01.120');
INSERT INTO public.virksomhet_naring VALUES (369, '90.012');
INSERT INTO public.virksomhet_naring VALUES (370, '01.120');
INSERT INTO public.virksomhet_naring VALUES (370, '90.012');
INSERT INTO public.virksomhet_naring VALUES (370, '70.220');
INSERT INTO public.virksomhet_naring VALUES (371, '01.120');
INSERT INTO public.virksomhet_naring VALUES (372, '01.120');
INSERT INTO public.virksomhet_naring VALUES (373, '01.120');
INSERT INTO public.virksomhet_naring VALUES (374, '01.120');
INSERT INTO public.virksomhet_naring VALUES (374, '90.012');
INSERT INTO public.virksomhet_naring VALUES (374, '70.220');
INSERT INTO public.virksomhet_naring VALUES (375, '01.120');
INSERT INTO public.virksomhet_naring VALUES (376, '01.120');
INSERT INTO public.virksomhet_naring VALUES (376, '90.012');
INSERT INTO public.virksomhet_naring VALUES (376, '70.220');
INSERT INTO public.virksomhet_naring VALUES (377, '01.120');
INSERT INTO public.virksomhet_naring VALUES (377, '90.012');
INSERT INTO public.virksomhet_naring VALUES (377, '70.220');
INSERT INTO public.virksomhet_naring VALUES (378, '01.120');
INSERT INTO public.virksomhet_naring VALUES (378, '90.012');
INSERT INTO public.virksomhet_naring VALUES (379, '01.120');
INSERT INTO public.virksomhet_naring VALUES (380, '01.120');
INSERT INTO public.virksomhet_naring VALUES (380, '90.012');
INSERT INTO public.virksomhet_naring VALUES (380, '70.220');
INSERT INTO public.virksomhet_naring VALUES (381, '01.120');
INSERT INTO public.virksomhet_naring VALUES (382, '01.120');
INSERT INTO public.virksomhet_naring VALUES (383, '01.120');
INSERT INTO public.virksomhet_naring VALUES (383, '90.012');
INSERT INTO public.virksomhet_naring VALUES (384, '01.120');
INSERT INTO public.virksomhet_naring VALUES (384, '90.012');
INSERT INTO public.virksomhet_naring VALUES (384, '70.220');
INSERT INTO public.virksomhet_naring VALUES (385, '01.120');
INSERT INTO public.virksomhet_naring VALUES (386, '01.120');
INSERT INTO public.virksomhet_naring VALUES (386, '90.012');
INSERT INTO public.virksomhet_naring VALUES (386, '70.220');
INSERT INTO public.virksomhet_naring VALUES (387, '01.120');
INSERT INTO public.virksomhet_naring VALUES (388, '01.120');
INSERT INTO public.virksomhet_naring VALUES (388, '90.012');
INSERT INTO public.virksomhet_naring VALUES (388, '70.220');
INSERT INTO public.virksomhet_naring VALUES (389, '01.120');
INSERT INTO public.virksomhet_naring VALUES (389, '90.012');
INSERT INTO public.virksomhet_naring VALUES (390, '01.120');
INSERT INTO public.virksomhet_naring VALUES (391, '01.120');
INSERT INTO public.virksomhet_naring VALUES (391, '90.012');
INSERT INTO public.virksomhet_naring VALUES (391, '70.220');
INSERT INTO public.virksomhet_naring VALUES (392, '01.120');
INSERT INTO public.virksomhet_naring VALUES (392, '90.012');
INSERT INTO public.virksomhet_naring VALUES (392, '70.220');
INSERT INTO public.virksomhet_naring VALUES (393, '01.120');
INSERT INTO public.virksomhet_naring VALUES (393, '90.012');
INSERT INTO public.virksomhet_naring VALUES (394, '01.120');
INSERT INTO public.virksomhet_naring VALUES (394, '90.012');
INSERT INTO public.virksomhet_naring VALUES (395, '01.120');
INSERT INTO public.virksomhet_naring VALUES (396, '01.120');
INSERT INTO public.virksomhet_naring VALUES (396, '90.012');
INSERT INTO public.virksomhet_naring VALUES (397, '01.120');
INSERT INTO public.virksomhet_naring VALUES (397, '90.012');
INSERT INTO public.virksomhet_naring VALUES (398, '01.120');
INSERT INTO public.virksomhet_naring VALUES (398, '90.012');
INSERT INTO public.virksomhet_naring VALUES (399, '01.120');
INSERT INTO public.virksomhet_naring VALUES (400, '01.120');
INSERT INTO public.virksomhet_naring VALUES (401, '01.120');
INSERT INTO public.virksomhet_naring VALUES (401, '90.012');
INSERT INTO public.virksomhet_naring VALUES (402, '01.120');
INSERT INTO public.virksomhet_naring VALUES (403, '01.120');
INSERT INTO public.virksomhet_naring VALUES (404, '01.120');
INSERT INTO public.virksomhet_naring VALUES (405, '01.120');
INSERT INTO public.virksomhet_naring VALUES (405, '90.012');
INSERT INTO public.virksomhet_naring VALUES (406, '01.120');
INSERT INTO public.virksomhet_naring VALUES (407, '01.120');
INSERT INTO public.virksomhet_naring VALUES (408, '01.120');
INSERT INTO public.virksomhet_naring VALUES (409, '01.120');
INSERT INTO public.virksomhet_naring VALUES (409, '90.012');
INSERT INTO public.virksomhet_naring VALUES (410, '01.120');
INSERT INTO public.virksomhet_naring VALUES (410, '90.012');
INSERT INTO public.virksomhet_naring VALUES (411, '01.120');
INSERT INTO public.virksomhet_naring VALUES (412, '01.120');
INSERT INTO public.virksomhet_naring VALUES (412, '90.012');
INSERT INTO public.virksomhet_naring VALUES (413, '01.120');
INSERT INTO public.virksomhet_naring VALUES (413, '90.012');
INSERT INTO public.virksomhet_naring VALUES (414, '01.120');
INSERT INTO public.virksomhet_naring VALUES (414, '90.012');
INSERT INTO public.virksomhet_naring VALUES (414, '70.220');
INSERT INTO public.virksomhet_naring VALUES (415, '01.120');
INSERT INTO public.virksomhet_naring VALUES (415, '90.012');
INSERT INTO public.virksomhet_naring VALUES (415, '70.220');
INSERT INTO public.virksomhet_naring VALUES (416, '01.120');
INSERT INTO public.virksomhet_naring VALUES (417, '01.120');
INSERT INTO public.virksomhet_naring VALUES (417, '90.012');
INSERT INTO public.virksomhet_naring VALUES (417, '70.220');
INSERT INTO public.virksomhet_naring VALUES (418, '01.120');
INSERT INTO public.virksomhet_naring VALUES (418, '90.012');
INSERT INTO public.virksomhet_naring VALUES (418, '70.220');
INSERT INTO public.virksomhet_naring VALUES (419, '01.120');
INSERT INTO public.virksomhet_naring VALUES (419, '90.012');
INSERT INTO public.virksomhet_naring VALUES (420, '01.120');
INSERT INTO public.virksomhet_naring VALUES (420, '90.012');
INSERT INTO public.virksomhet_naring VALUES (421, '01.120');
INSERT INTO public.virksomhet_naring VALUES (422, '01.120');
INSERT INTO public.virksomhet_naring VALUES (422, '90.012');
INSERT INTO public.virksomhet_naring VALUES (423, '01.120');
INSERT INTO public.virksomhet_naring VALUES (423, '90.012');
INSERT INTO public.virksomhet_naring VALUES (424, '01.120');
INSERT INTO public.virksomhet_naring VALUES (425, '01.120');
INSERT INTO public.virksomhet_naring VALUES (425, '90.012');
INSERT INTO public.virksomhet_naring VALUES (426, '01.120');
INSERT INTO public.virksomhet_naring VALUES (426, '90.012');
INSERT INTO public.virksomhet_naring VALUES (427, '01.120');
INSERT INTO public.virksomhet_naring VALUES (427, '90.012');
INSERT INTO public.virksomhet_naring VALUES (428, '01.120');
INSERT INTO public.virksomhet_naring VALUES (428, '90.012');
INSERT INTO public.virksomhet_naring VALUES (429, '01.120');
INSERT INTO public.virksomhet_naring VALUES (429, '90.012');
INSERT INTO public.virksomhet_naring VALUES (429, '70.220');
INSERT INTO public.virksomhet_naring VALUES (430, '01.120');
INSERT INTO public.virksomhet_naring VALUES (430, '90.012');
INSERT INTO public.virksomhet_naring VALUES (431, '01.120');
INSERT INTO public.virksomhet_naring VALUES (431, '90.012');
INSERT INTO public.virksomhet_naring VALUES (432, '01.120');
INSERT INTO public.virksomhet_naring VALUES (433, '01.120');
INSERT INTO public.virksomhet_naring VALUES (434, '01.120');
INSERT INTO public.virksomhet_naring VALUES (434, '90.012');
INSERT INTO public.virksomhet_naring VALUES (435, '01.120');
INSERT INTO public.virksomhet_naring VALUES (435, '90.012');
INSERT INTO public.virksomhet_naring VALUES (436, '01.120');
INSERT INTO public.virksomhet_naring VALUES (436, '90.012');
INSERT INTO public.virksomhet_naring VALUES (436, '70.220');
INSERT INTO public.virksomhet_naring VALUES (437, '01.120');
INSERT INTO public.virksomhet_naring VALUES (437, '90.012');
INSERT INTO public.virksomhet_naring VALUES (437, '70.220');
INSERT INTO public.virksomhet_naring VALUES (438, '01.120');
INSERT INTO public.virksomhet_naring VALUES (438, '90.012');
INSERT INTO public.virksomhet_naring VALUES (439, '01.120');
INSERT INTO public.virksomhet_naring VALUES (439, '90.012');
INSERT INTO public.virksomhet_naring VALUES (439, '70.220');
INSERT INTO public.virksomhet_naring VALUES (440, '01.120');
INSERT INTO public.virksomhet_naring VALUES (440, '90.012');
INSERT INTO public.virksomhet_naring VALUES (440, '70.220');
INSERT INTO public.virksomhet_naring VALUES (441, '01.120');
INSERT INTO public.virksomhet_naring VALUES (442, '01.120');
INSERT INTO public.virksomhet_naring VALUES (442, '90.012');
INSERT INTO public.virksomhet_naring VALUES (443, '01.120');
INSERT INTO public.virksomhet_naring VALUES (443, '90.012');
INSERT INTO public.virksomhet_naring VALUES (444, '01.120');
INSERT INTO public.virksomhet_naring VALUES (445, '01.120');
INSERT INTO public.virksomhet_naring VALUES (445, '90.012');
INSERT INTO public.virksomhet_naring VALUES (446, '01.120');
INSERT INTO public.virksomhet_naring VALUES (446, '90.012');
INSERT INTO public.virksomhet_naring VALUES (446, '70.220');
INSERT INTO public.virksomhet_naring VALUES (447, '01.120');
INSERT INTO public.virksomhet_naring VALUES (447, '90.012');
INSERT INTO public.virksomhet_naring VALUES (448, '01.120');
INSERT INTO public.virksomhet_naring VALUES (449, '01.120');
INSERT INTO public.virksomhet_naring VALUES (449, '90.012');
INSERT INTO public.virksomhet_naring VALUES (450, '01.120');
INSERT INTO public.virksomhet_naring VALUES (451, '01.120');
INSERT INTO public.virksomhet_naring VALUES (451, '90.012');
INSERT INTO public.virksomhet_naring VALUES (451, '70.220');
INSERT INTO public.virksomhet_naring VALUES (452, '01.120');
INSERT INTO public.virksomhet_naring VALUES (452, '90.012');
INSERT INTO public.virksomhet_naring VALUES (453, '01.120');
INSERT INTO public.virksomhet_naring VALUES (453, '90.012');
INSERT INTO public.virksomhet_naring VALUES (454, '01.120');
INSERT INTO public.virksomhet_naring VALUES (455, '01.120');
INSERT INTO public.virksomhet_naring VALUES (456, '01.120');
INSERT INTO public.virksomhet_naring VALUES (457, '01.120');
INSERT INTO public.virksomhet_naring VALUES (457, '90.012');
INSERT INTO public.virksomhet_naring VALUES (458, '01.120');
INSERT INTO public.virksomhet_naring VALUES (459, '01.120');
INSERT INTO public.virksomhet_naring VALUES (459, '90.012');
INSERT INTO public.virksomhet_naring VALUES (460, '01.120');
INSERT INTO public.virksomhet_naring VALUES (461, '01.120');
INSERT INTO public.virksomhet_naring VALUES (462, '01.120');
INSERT INTO public.virksomhet_naring VALUES (462, '90.012');
INSERT INTO public.virksomhet_naring VALUES (463, '01.120');
INSERT INTO public.virksomhet_naring VALUES (463, '90.012');
INSERT INTO public.virksomhet_naring VALUES (464, '01.120');
INSERT INTO public.virksomhet_naring VALUES (465, '01.120');
INSERT INTO public.virksomhet_naring VALUES (465, '90.012');
INSERT INTO public.virksomhet_naring VALUES (466, '01.120');
INSERT INTO public.virksomhet_naring VALUES (467, '01.120');
INSERT INTO public.virksomhet_naring VALUES (467, '90.012');
INSERT INTO public.virksomhet_naring VALUES (467, '70.220');
INSERT INTO public.virksomhet_naring VALUES (468, '01.120');
INSERT INTO public.virksomhet_naring VALUES (468, '90.012');
INSERT INTO public.virksomhet_naring VALUES (469, '01.120');
INSERT INTO public.virksomhet_naring VALUES (469, '90.012');
INSERT INTO public.virksomhet_naring VALUES (469, '70.220');
INSERT INTO public.virksomhet_naring VALUES (470, '01.120');
INSERT INTO public.virksomhet_naring VALUES (470, '90.012');
INSERT INTO public.virksomhet_naring VALUES (471, '01.120');
INSERT INTO public.virksomhet_naring VALUES (472, '01.120');
INSERT INTO public.virksomhet_naring VALUES (472, '90.012');
INSERT INTO public.virksomhet_naring VALUES (473, '01.120');
INSERT INTO public.virksomhet_naring VALUES (474, '01.120');
INSERT INTO public.virksomhet_naring VALUES (475, '01.120');
INSERT INTO public.virksomhet_naring VALUES (476, '01.120');
INSERT INTO public.virksomhet_naring VALUES (476, '90.012');
INSERT INTO public.virksomhet_naring VALUES (476, '70.220');
INSERT INTO public.virksomhet_naring VALUES (477, '01.120');
INSERT INTO public.virksomhet_naring VALUES (478, '01.120');
INSERT INTO public.virksomhet_naring VALUES (478, '90.012');
INSERT INTO public.virksomhet_naring VALUES (479, '01.120');
INSERT INTO public.virksomhet_naring VALUES (480, '01.120');
INSERT INTO public.virksomhet_naring VALUES (480, '90.012');
INSERT INTO public.virksomhet_naring VALUES (480, '70.220');
INSERT INTO public.virksomhet_naring VALUES (481, '01.120');
INSERT INTO public.virksomhet_naring VALUES (481, '90.012');
INSERT INTO public.virksomhet_naring VALUES (481, '70.220');
INSERT INTO public.virksomhet_naring VALUES (482, '01.120');
INSERT INTO public.virksomhet_naring VALUES (483, '01.120');
INSERT INTO public.virksomhet_naring VALUES (483, '90.012');
INSERT INTO public.virksomhet_naring VALUES (483, '70.220');
INSERT INTO public.virksomhet_naring VALUES (484, '01.120');
INSERT INTO public.virksomhet_naring VALUES (485, '01.120');
INSERT INTO public.virksomhet_naring VALUES (485, '90.012');
INSERT INTO public.virksomhet_naring VALUES (486, '01.120');
INSERT INTO public.virksomhet_naring VALUES (487, '01.120');
INSERT INTO public.virksomhet_naring VALUES (487, '90.012');
INSERT INTO public.virksomhet_naring VALUES (488, '01.120');
INSERT INTO public.virksomhet_naring VALUES (488, '90.012');
INSERT INTO public.virksomhet_naring VALUES (488, '70.220');
INSERT INTO public.virksomhet_naring VALUES (489, '01.120');
INSERT INTO public.virksomhet_naring VALUES (489, '90.012');
INSERT INTO public.virksomhet_naring VALUES (490, '01.120');
INSERT INTO public.virksomhet_naring VALUES (491, '01.120');
INSERT INTO public.virksomhet_naring VALUES (492, '01.120');
INSERT INTO public.virksomhet_naring VALUES (493, '01.120');
INSERT INTO public.virksomhet_naring VALUES (493, '90.012');
INSERT INTO public.virksomhet_naring VALUES (494, '01.120');
INSERT INTO public.virksomhet_naring VALUES (495, '01.120');
INSERT INTO public.virksomhet_naring VALUES (496, '01.120');
INSERT INTO public.virksomhet_naring VALUES (497, '01.120');
INSERT INTO public.virksomhet_naring VALUES (498, '01.120');
INSERT INTO public.virksomhet_naring VALUES (499, '01.120');
INSERT INTO public.virksomhet_naring VALUES (499, '90.012');
INSERT INTO public.virksomhet_naring VALUES (500, '01.120');
INSERT INTO public.virksomhet_naring VALUES (500, '90.012');
INSERT INTO public.virksomhet_naring VALUES (500, '70.220');
INSERT INTO public.virksomhet_naring VALUES (501, '01.120');
INSERT INTO public.virksomhet_naring VALUES (501, '90.012');
INSERT INTO public.virksomhet_naring VALUES (502, '01.120');
INSERT INTO public.virksomhet_naring VALUES (502, '90.012');
INSERT INTO public.virksomhet_naring VALUES (502, '70.220');
INSERT INTO public.virksomhet_naring VALUES (503, '01.120');
INSERT INTO public.virksomhet_naring VALUES (504, '01.120');
INSERT INTO public.virksomhet_naring VALUES (505, '01.120');
INSERT INTO public.virksomhet_naring VALUES (506, '01.120');
INSERT INTO public.virksomhet_naring VALUES (506, '90.012');
INSERT INTO public.virksomhet_naring VALUES (507, '01.120');
INSERT INTO public.virksomhet_naring VALUES (508, '01.120');
INSERT INTO public.virksomhet_naring VALUES (509, '01.120');
INSERT INTO public.virksomhet_naring VALUES (510, '01.120');
INSERT INTO public.virksomhet_naring VALUES (510, '90.012');
INSERT INTO public.virksomhet_naring VALUES (510, '70.220');
INSERT INTO public.virksomhet_naring VALUES (511, '01.120');
INSERT INTO public.virksomhet_naring VALUES (511, '90.012');
INSERT INTO public.virksomhet_naring VALUES (511, '70.220');
INSERT INTO public.virksomhet_naring VALUES (512, '01.120');
INSERT INTO public.virksomhet_naring VALUES (512, '90.012');
INSERT INTO public.virksomhet_naring VALUES (512, '70.220');
INSERT INTO public.virksomhet_naring VALUES (518, '01.120');
INSERT INTO public.virksomhet_naring VALUES (519, '01.120');
INSERT INTO public.virksomhet_naring VALUES (520, '01.120');
INSERT INTO public.virksomhet_naring VALUES (520, '90.012');
INSERT INTO public.virksomhet_naring VALUES (520, '70.220');
INSERT INTO public.virksomhet_naring VALUES (521, '01.120');
INSERT INTO public.virksomhet_naring VALUES (522, '01.120');
INSERT INTO public.virksomhet_naring VALUES (522, '90.012');
INSERT INTO public.virksomhet_naring VALUES (523, '01.120');
INSERT INTO public.virksomhet_naring VALUES (524, '01.120');
INSERT INTO public.virksomhet_naring VALUES (525, '01.120');
INSERT INTO public.virksomhet_naring VALUES (525, '90.012');
INSERT INTO public.virksomhet_naring VALUES (526, '01.120');
INSERT INTO public.virksomhet_naring VALUES (527, '01.120');
INSERT INTO public.virksomhet_naring VALUES (513, '01.120');
INSERT INTO public.virksomhet_naring VALUES (513, '90.012');
INSERT INTO public.virksomhet_naring VALUES (514, '01.120');
INSERT INTO public.virksomhet_naring VALUES (515, '01.120');
INSERT INTO public.virksomhet_naring VALUES (515, '90.012');
INSERT INTO public.virksomhet_naring VALUES (516, '01.120');
INSERT INTO public.virksomhet_naring VALUES (517, '01.120');
INSERT INTO public.virksomhet_naring VALUES (517, '90.012');
INSERT INTO public.virksomhet_naring VALUES (517, '70.220');
INSERT INTO public.virksomhet_naring VALUES (528, '01.120');
INSERT INTO public.virksomhet_naring VALUES (528, '01.110');
INSERT INTO public.virksomhet_naring VALUES (528, '70.220');
INSERT INTO public.virksomhet_naring VALUES (535, '01.120');
INSERT INTO public.virksomhet_naring VALUES (536, '01.120');
INSERT INTO public.virksomhet_naring VALUES (536, '90.012');
INSERT INTO public.virksomhet_naring VALUES (536, '70.220');
INSERT INTO public.virksomhet_naring VALUES (537, '01.120');
INSERT INTO public.virksomhet_naring VALUES (537, '90.012');
INSERT INTO public.virksomhet_naring VALUES (538, '01.120');
INSERT INTO public.virksomhet_naring VALUES (539, '01.120');
INSERT INTO public.virksomhet_naring VALUES (539, '90.012');
INSERT INTO public.virksomhet_naring VALUES (539, '70.220');
INSERT INTO public.virksomhet_naring VALUES (540, '01.120');
INSERT INTO public.virksomhet_naring VALUES (541, '01.120');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.441869');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.559454');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '984247664', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (7, '555555555', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '881532376', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '883874352', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '848147638', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '876763949', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (16, '871871807', 'VIRKSOMHET', '2', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (17, '864079801', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (18, '836041617', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (19, '857842260', 'VIRKSOMHET', '0', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (20, '885073621', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (21, '864754605', 'VIRKSOMHET', '3', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (22, '846347581', 'VIRKSOMHET', '3', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '824680794', 'VIRKSOMHET', '0', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '839415001', 'VIRKSOMHET', '2', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (25, '861744528', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '860138909', 'VIRKSOMHET', '0', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (27, '843242104', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '890093850', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (29, '892511017', 'VIRKSOMHET', '2', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '842605109', 'VIRKSOMHET', '3', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (31, '870491047', 'VIRKSOMHET', '1', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '863507760', 'VIRKSOMHET', '3', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '817257908', 'VIRKSOMHET', '0', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '809042383', 'VIRKSOMHET', '0', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '810734693', 'VIRKSOMHET', '2', '2022-09-29 10:20:52.683638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '804629062', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.083044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '873621335', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.083044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '835058832', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.083044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '803826652', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.083044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '874394467', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.083044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '838903289', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.083044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '882051647', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.083044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '879681201', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.083044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '852409131', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '808215075', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '865074415', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '836669149', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '884369776', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '873418367', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '802905016', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '885609899', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '860836918', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '829745509', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '844246611', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '867216743', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '890941228', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '838540049', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '809501750', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '844496478', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '863501025', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '839166324', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '879962157', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '848543645', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '880279851', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '808671188', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '851333885', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '815366017', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '891113900', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '894926128', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '802290404', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '896239097', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '816868949', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '895298219', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '842893897', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '814670938', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '820433803', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '874104569', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '856520283', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '879090305', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '809468321', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '826378947', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '866390365', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '862771013', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '864363318', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '896438075', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '829368106', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '867407313', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '896587504', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '847845944', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '826389298', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '848399886', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '854846835', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '800634899', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '857110616', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.154984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '808271586', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.484332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '819801010', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.484332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '848578637', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.484332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '827490752', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.484332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '835736810', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.484332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '857544475', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.484332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '847721823', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.484332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '862581603', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.484332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '810313500', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.484332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '885129733', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '898243796', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '887079787', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '861058672', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '876537913', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '890597928', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '842982051', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '842389667', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '820004072', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '897688257', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '837534390', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '808543637', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '870201888', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '817311070', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '868012776', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '896429753', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '851603425', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '827443317', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '833362642', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '882069408', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '863878944', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '866558221', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '868767855', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '875885300', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '842216735', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '856920437', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '830858963', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '812434114', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '847041353', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '803269327', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '843457384', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '818306281', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '844449510', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '867177223', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '883963814', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '886253015', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '895281822', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '840533481', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '839216776', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '803533948', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '827095124', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '808251981', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '817358823', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '871910327', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '866587133', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '842840788', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '812781923', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '804058381', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '811423248', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '840837641', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '818816392', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '806494928', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '893055618', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '875340822', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.595516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '818463756', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.946831');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '884152302', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.946831');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '849742742', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.946831');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '804979817', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.946831');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '814190896', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.946831');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '822331640', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.946831');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '862678317', 'VIRKSOMHET', '2', '2022-09-29 10:20:53.946831');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '831093023', 'VIRKSOMHET', '1', '2022-09-29 10:20:53.946831');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '874226454', 'VIRKSOMHET', '3', '2022-09-29 10:20:53.946831');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '832436811', 'VIRKSOMHET', '0', '2022-09-29 10:20:53.946831');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '838432048', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '870022919', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '879268334', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '806599852', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '863181199', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '863767568', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '844014636', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '866404710', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '833129946', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '846977998', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '811030348', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '890815907', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '822694021', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '852558904', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '822874914', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '866646453', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '881021956', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '899291735', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '867918928', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '823439458', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '837805347', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '805499088', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '845822610', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '841405633', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '889675608', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '899025387', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '863280835', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '860629673', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '833667497', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '842471044', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '861459803', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '812926032', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '871631319', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '865439281', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '824210548', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '805486005', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '832448472', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '805820685', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '883768894', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '856903021', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '850012745', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '820149848', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '822705108', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '857573851', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '856078198', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '859225721', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '873879874', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '890065285', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '893423280', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '816273126', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '874977909', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '888632161', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '852452427', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '807389236', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '833163111', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '813080832', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '896489260', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '845881839', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '898157169', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '882940656', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '887589106', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '856439808', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '869911712', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '836420677', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '810521018', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '863021621', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '846289494', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '834191416', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '837420340', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.016891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '871949311', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.422489');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '821633142', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.422489');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '893463166', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.422489');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '833218825', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.422489');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '807456455', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.422489');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '821381486', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.422489');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '814324199', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.422489');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '805904949', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.422489');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '813242515', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '839415843', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '804234371', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '816585946', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '824097835', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '880538674', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '875775705', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '877421692', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '871547736', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '857653378', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '829980700', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '852627790', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '865978526', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '840145629', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '875016141', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '869419134', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '813944600', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '885600454', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '877550656', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '804227830', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '858956619', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '865153645', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '817941723', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '811667993', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '859462534', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '822317092', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '877772835', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '846495295', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '804775869', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '831030012', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '802809462', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '896200151', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '873610100', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '847931581', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '870810427', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '816457914', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '816760477', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '821449527', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '897412997', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '801856356', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '898170941', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '884390144', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '894424841', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '828972512', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '815082581', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '887159012', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '829493874', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '814929193', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '859907302', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '895124699', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '813239227', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '840430296', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '858726639', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '823234800', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '874361830', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '808481735', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '860499175', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '892697142', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '826727890', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '895582762', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '814663914', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '887191975', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '856729012', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '816248533', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '847253663', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '851556995', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '897000352', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '891267708', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '868369009', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '836786224', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '800910790', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '847922087', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.509725');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '882737279', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.866569');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '817612413', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.866569');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '857680168', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.866569');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '878624841', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.866569');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '867183919', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.866569');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '824306551', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.866569');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '812929350', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.866569');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '890735735', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.866569');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '894341616', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.866569');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '845690609', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.866569');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '884945724', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '820865124', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '870514368', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '833643869', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '807702188', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '820638689', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '843380901', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '832951634', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '833677243', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '873656323', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '859159231', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '868067017', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '856435712', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '888937591', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '873906284', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '855150484', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '836365546', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '822564929', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '833204596', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '863592645', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '865956727', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '807629933', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '832454631', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '823356725', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '800824855', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '894510083', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '815854671', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '876401827', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '845066027', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '815406101', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '866878310', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '830803739', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '805933483', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '868252144', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '828744326', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '830122600', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '813147327', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '846250295', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '898250721', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '813697349', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '863104800', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '897979593', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '860772161', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '808002552', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '876394411', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '846214156', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '850015354', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '805145991', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '853879838', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '882939801', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '859605190', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '891814367', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '875021136', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '825379831', 'VIRKSOMHET', '0', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '800469195', 'VIRKSOMHET', '3', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '871244244', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '837133219', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '855964219', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '838273484', 'VIRKSOMHET', '2', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '893483616', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '891497759', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '888247901', 'VIRKSOMHET', '1', '2022-09-29 10:20:54.935277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '883590490', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '804908767', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '851919134', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '813682750', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '875544956', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '889472231', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '875631634', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '856007783', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '844760467', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '863256691', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '851705582', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '854298834', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '836216435', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '893017297', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '841372032', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '862589424', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '871501781', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.234844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '880977356', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '859708655', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '837130075', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '803170681', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '875018446', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '872251225', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '889927472', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '850310272', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '878277970', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '811324382', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '878265174', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '803799726', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '827344157', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '868610918', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '891144647', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '874750888', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '879572863', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '816719384', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '823372812', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '872671153', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '837782686', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '856373244', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '802319687', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '882221112', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '825823538', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '840744367', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '807485242', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '878321914', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '886892017', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '871623349', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '864986459', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '849227492', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '850910144', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '869658223', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '866431270', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '858356342', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '852467356', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '898657961', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '846849579', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '873579899', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '843035298', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '858836952', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '805709917', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '808479485', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '838878962', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '885625328', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '837527996', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '844848494', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '825573136', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '809036318', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '800223332', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '878112453', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '893781546', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '818658010', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '862270603', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '812325897', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '817554736', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '884291457', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '890910485', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '810677960', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '830621787', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '874792210', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.333101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '828718942', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '846277869', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '809316543', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '846821438', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '836005340', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '869069081', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '824870495', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '821850314', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '895629317', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '854843256', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '825397589', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '856901774', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '886566656', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '868634250', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '827178297', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '889901026', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '860932226', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '883640440', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '899511765', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '826671551', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '838991015', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '831768843', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.590491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '803324193', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '827269180', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '806938796', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '817130185', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '810402680', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '887841956', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '897336611', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '858728795', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '880050743', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '871161662', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '862924848', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '895031114', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '815517829', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '836666246', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '845715533', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '897156462', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '890815244', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '866562589', 'VIRKSOMHET', '2', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '875322390', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '870376312', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '863074238', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '873535604', 'VIRKSOMHET', '3', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '820029647', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '825514130', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '815801592', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '839528084', 'VIRKSOMHET', '0', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '864571830', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.691374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '883989256', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.930384');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '831272011', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.947139');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '831658088', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.967619');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '802008121', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.967619');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '857721878', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.967619');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '811747377', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.996993');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '801396893', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.996993');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '885133950', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.996993');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '864761302', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.996993');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '870050263', 'VIRKSOMHET', '1', '2022-09-29 10:20:55.996993');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '881536611', 'VIRKSOMHET', '1', '2022-09-29 10:20:56.03085');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '862811969', 'VIRKSOMHET', '1', '2022-09-29 10:20:56.03085');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '892708443', 'VIRKSOMHET', '1', '2022-09-29 10:20:56.03085');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '866931781', 'VIRKSOMHET', '1', '2022-09-29 10:20:56.03085');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '868378133', 'VIRKSOMHET', '1', '2022-09-29 10:20:56.03085');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '872308278', 'VIRKSOMHET', '1', '2022-09-29 10:20:56.066889');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (533, '854032309', 'VIRKSOMHET', '1', '2022-09-29 10:20:56.066889');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (534, '842782667', 'VIRKSOMHET', '1', '2022-09-29 10:20:56.066889');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (535, '846058502', 'VIRKSOMHET', '3', '2022-09-29 10:20:59.694179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (536, '878151780', 'VIRKSOMHET', '1', '2022-09-29 10:20:59.713461');


--
-- Name: sykefravar_statistikk_grunnlag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_grunnlag_id_seq', 3, true);


--
-- Name: sykefravar_statistikk_land_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_land_id_seq', 536, true);


--
-- Name: sykefravar_statistikk_naring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_naring_id_seq', 536, true);


--
-- Name: sykefravar_statistikk_naringsundergruppe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_naringsundergruppe_id_seq', 536, true);


--
-- Name: sykefravar_statistikk_sektor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_sektor_id_seq', 536, true);


--
-- Name: sykefravar_statistikk_virksomhet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_virksomhet_id_seq', 536, true);


--
-- Name: virksomhet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_id_seq', 541, true);


--
-- Name: virksomhet_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_metadata_id_seq', 536, true);


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

