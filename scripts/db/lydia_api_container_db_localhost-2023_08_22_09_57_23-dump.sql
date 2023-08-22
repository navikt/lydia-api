--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Debian 14.8-1.pgdg120+1)
-- Dumped by pg_dump version 15.4

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

ALTER TABLE IF EXISTS ONLY public.virksomhet_naringsundergrupper DROP CONSTRAINT IF EXISTS fk_virksomhet_naringsundergrupper_virksomhet;
ALTER TABLE IF EXISTS ONLY public.virksomhet_naringsundergrupper DROP CONSTRAINT IF EXISTS fk_virksomhet_naringsundergrupper_naring;
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
ALTER TABLE IF EXISTS ONLY public.virksomhet_naringsundergrupper DROP CONSTRAINT IF EXISTS virksomhet_naringsundergrupper_unik;
ALTER TABLE IF EXISTS ONLY public.virksomhet_naringsundergrupper DROP CONSTRAINT IF EXISTS virksomhet_naringsundergrupper_pkey;
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
ALTER TABLE IF EXISTS ONLY public.siste_publiseringsinfo DROP CONSTRAINT IF EXISTS siste_publiseringsinfo_pkey;
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
ALTER TABLE IF EXISTS public.virksomhet_naringsundergrupper ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.virksomhet ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_virksomhet_siste_4_kvartal ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_virksomhet ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_sektor ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_naringsundergruppe ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_naring ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_land ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sykefravar_statistikk_kategori_siste_4_kvartal ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.siste_publiseringsinfo ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.modul ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.iasak_leveranse ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ia_tjeneste ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.virksomhet_naringsundergrupper_id_seq;
DROP TABLE IF EXISTS public.virksomhet_naringsundergrupper;
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
DROP SEQUENCE IF EXISTS public.siste_publiseringsinfo_id_seq;
DROP TABLE IF EXISTS public.siste_publiseringsinfo;
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
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    opprettet_av_rolle character varying,
    nav_enhet_nummer character varying DEFAULT 'Ukjent'::character varying NOT NULL,
    nav_enhet_navn character varying DEFAULT 'Ukjent'::character varying NOT NULL
);


ALTER TABLE public.ia_sak_hendelse OWNER TO test;

--
-- Name: ia_tjeneste; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.ia_tjeneste (
    id integer NOT NULL,
    navn character varying NOT NULL,
    deaktivert boolean DEFAULT false NOT NULL
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
    fullfort timestamp without time zone,
    sist_endret_av_rolle character varying
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
    navn character varying NOT NULL,
    deaktivert boolean DEFAULT false NOT NULL
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
-- Name: siste_publiseringsinfo; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.siste_publiseringsinfo (
    id integer NOT NULL,
    gjeldende_arstall smallint NOT NULL,
    gjeldende_kvartal smallint NOT NULL,
    siste_publiseringsdato timestamp without time zone,
    neste_publiseringsdato timestamp without time zone,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.siste_publiseringsinfo OWNER TO test;

--
-- Name: siste_publiseringsinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.siste_publiseringsinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.siste_publiseringsinfo_id_seq OWNER TO test;

--
-- Name: siste_publiseringsinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.siste_publiseringsinfo_id_seq OWNED BY public.siste_publiseringsinfo.id;


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
-- Name: virksomhet_naringsundergrupper; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.virksomhet_naringsundergrupper (
    id integer NOT NULL,
    virksomhet integer NOT NULL,
    naeringskode1 character varying NOT NULL,
    naeringskode2 character varying,
    naeringskode3 character varying,
    oppdateringsdato timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.virksomhet_naringsundergrupper OWNER TO test;

--
-- Name: virksomhet_naringsundergrupper_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.virksomhet_naringsundergrupper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.virksomhet_naringsundergrupper_id_seq OWNER TO test;

--
-- Name: virksomhet_naringsundergrupper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.virksomhet_naringsundergrupper_id_seq OWNED BY public.virksomhet_naringsundergrupper.id;


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
-- Name: siste_publiseringsinfo id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.siste_publiseringsinfo ALTER COLUMN id SET DEFAULT nextval('public.siste_publiseringsinfo_id_seq'::regclass);


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
-- Name: virksomhet_naringsundergrupper id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_naringsundergrupper ALTER COLUMN id SET DEFAULT nextval('public.virksomhet_naringsundergrupper_id_seq'::regclass);


--
-- Name: virksomhet_statistikk_metadata id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_statistikk_metadata ALTER COLUMN id SET DEFAULT nextval('public.virksomhet_metadata_id_seq'::regclass);


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', 'V1__init.sql', 1782034767, 'test', '2023-08-22 09:37:33.713407', 23, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', 'V2__create_virksomhet_adresse.sql', -64248919, 'test', '2023-08-22 09:37:33.76539', 16, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', 'V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2023-08-22 09:37:33.799882', 5, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', 'V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2023-08-22 09:37:33.824939', 5, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', 'V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2023-08-22 09:37:33.846066', 10, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', 'V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2023-08-22 09:37:33.871468', 7, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', 'V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2023-08-22 09:37:33.896931', 10, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', 'V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2023-08-22 09:37:33.919898', 5, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', 'V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2023-08-22 09:37:33.937028', 8, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', 'V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2023-08-22 09:37:33.957662', 5, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', 'V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2023-08-22 09:37:33.972313', 4, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', 'V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2023-08-22 09:37:33.986363', 5, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', 'V13__ia_prosess.sql', -1755516749, 'test', '2023-08-22 09:37:34.005905', 6, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', 'V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2023-08-22 09:37:34.024026', 9, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', 'V15__endre_saknummer.sql', -1379621340, 'test', '2023-08-22 09:37:34.045007', 5, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', 'V16__ia_sak_hendelse.sql', 586872662, 'test', '2023-08-22 09:37:34.062185', 12, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', 'V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2023-08-22 09:37:34.087351', 7, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', 'V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2023-08-22 09:37:34.109141', 9, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', 'V19__legg_til_begrunnelser.sql', 779259005, 'test', '2023-08-22 09:37:34.131248', 6, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', 'V20__legg_til_flere_indekser.sql', -843857404, 'test', '2023-08-22 09:37:34.149957', 10, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', 'V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2023-08-22 09:37:34.175272', 5, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', 'V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2023-08-22 09:37:34.192907', 5, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', 'V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2023-08-22 09:37:34.211147', 9, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', 'V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2023-08-22 09:37:34.23378', 9, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', 'V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2023-08-22 09:37:34.257485', 19, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', 'V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2023-08-22 09:37:34.289137', 5, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', 'V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2023-08-22 09:37:34.306133', 5, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', 'V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2023-08-22 09:37:34.325515', 6, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', 'V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2023-08-22 09:37:34.34556', 6, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', 'V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2023-08-22 09:37:34.363292', 6, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', 'V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2023-08-22 09:37:34.38166', 8, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', 'V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2023-08-22 09:37:34.40275', 6, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', 'V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2023-08-22 09:37:34.421663', 4, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', 'V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2023-08-22 09:37:34.438931', 9, true);
INSERT INTO public.flyway_schema_history VALUES (35, '35', 'drop sykefravar statistikk grunnlag', 'SQL', 'V35__drop_sykefravar_statistikk_grunnlag.sql', 461103825, 'test', '2023-08-22 09:37:34.461122', 6, true);
INSERT INTO public.flyway_schema_history VALUES (36, '36', 'registrere bistand', 'SQL', 'V36__registrere_bistand.sql', -1365283904, 'test', '2023-08-22 09:37:34.479494', 15, true);
INSERT INTO public.flyway_schema_history VALUES (37, '37', 'fullfoert dato leveranse', 'SQL', 'V37__fullfoert_dato_leveranse.sql', 1621470787, 'test', '2023-08-22 09:37:34.507858', 6, true);
INSERT INTO public.flyway_schema_history VALUES (38, '38', 'oppdatere moduler', 'SQL', 'V38__oppdatere_moduler.sql', -246234034, 'test', '2023-08-22 09:37:34.52729', 10, true);
INSERT INTO public.flyway_schema_history VALUES (39, '39', 'rette iatjeneste på modul', 'SQL', 'V39__rette_iatjeneste_på_modul.sql', -1034067650, 'test', '2023-08-22 09:37:34.549271', 5, true);
INSERT INTO public.flyway_schema_history VALUES (40, '40', 'legg til rolle ia sak hendelse', 'SQL', 'V40__legg_til_rolle_ia_sak_hendelse.sql', -82283870, 'test', '2023-08-22 09:37:34.567089', 4, true);
INSERT INTO public.flyway_schema_history VALUES (41, '41', 'legg til rolle ia sak leveranse', 'SQL', 'V41__legg_til_rolle_ia_sak_leveranse.sql', -2029318456, 'test', '2023-08-22 09:37:34.583282', 5, true);
INSERT INTO public.flyway_schema_history VALUES (42, '42', 'legg til deaktivert', 'SQL', 'V42__legg_til_deaktivert.sql', 1170357332, 'test', '2023-08-22 09:37:34.599906', 8, true);
INSERT INTO public.flyway_schema_history VALUES (43, '43', 'siste publiseringsinfo tabell', 'SQL', 'V43__siste_publiseringsinfo_tabell.sql', -1555520829, 'test', '2023-08-22 09:37:34.6209', 7, true);
INSERT INTO public.flyway_schema_history VALUES (44, '44', 'hendelse nav enhet', 'SQL', 'V44__hendelse_nav_enhet.sql', -1118774222, 'test', '2023-08-22 09:37:34.642945', 7, true);
INSERT INTO public.flyway_schema_history VALUES (45, '45', 'oppdatere siste publiseringsinfo', 'SQL', 'V45__oppdatere_siste_publiseringsinfo.sql', -1919960111, 'test', '2023-08-22 09:37:34.662641', 7, true);
INSERT INTO public.flyway_schema_history VALUES (46, '46', 'populer siste publiseringsdato', 'SQL', 'V46__populer_siste_publiseringsdato.sql', 21300723, 'test', '2023-08-22 09:37:34.679865', 11, true);
INSERT INTO public.flyway_schema_history VALUES (47, '47', 'virksomhet naringsundergrupper tabell', 'SQL', 'V47__virksomhet_naringsundergrupper_tabell.sql', 581614507, 'test', '2023-08-22 09:37:34.705673', 11, true);
INSERT INTO public.flyway_schema_history VALUES (48, '48', 'endre oppdateringsdato', 'SQL', 'V48__endre_oppdateringsdato.sql', 855334580, 'test', '2023-08-22 09:37:34.73393', 8, true);
INSERT INTO public.flyway_schema_history VALUES (49, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 699954609, 'test', '2023-08-22 09:37:34.757706', 12, true);
INSERT INTO public.flyway_schema_history VALUES (50, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -1145847413, 'test', '2023-08-22 09:37:57.276674', 40, true);


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

INSERT INTO public.ia_tjeneste VALUES (1, 'Redusere sykefravær', false);
INSERT INTO public.ia_tjeneste VALUES (2, 'Forebyggende arbeidsmiljøarbeid', false);
INSERT INTO public.ia_tjeneste VALUES (3, 'HelseIArbeid', false);


--
-- Data for Name: iasak_leveranse; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: modul; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.modul VALUES (1, 1, 'Videreutvikle sykefraværsrutiner', false);
INSERT INTO public.modul VALUES (2, 1, 'Oppfølgingssamtalen', false);
INSERT INTO public.modul VALUES (3, 1, 'Tilretteleggingsplikt og medvirkningsplikt', false);
INSERT INTO public.modul VALUES (4, 1, 'Langvarige og/eller hyppig gjentakende sykefravær', false);
INSERT INTO public.modul VALUES (5, 2, 'Utvikle partssamarbeid', false);
INSERT INTO public.modul VALUES (6, 2, 'Enkel arbeidsmiljøkartlegging', false);
INSERT INTO public.modul VALUES (7, 2, 'Kontinuerlig (arbeidsmiljø)forbedring', false);
INSERT INTO public.modul VALUES (8, 2, 'Endring og omstilling', false);
INSERT INTO public.modul VALUES (9, 2, 'Oppfølging av arbeidsmiljøundersøkelse', false);
INSERT INTO public.modul VALUES (10, 2, 'Livsfaseorientert personalpolitikk', false);
INSERT INTO public.modul VALUES (11, 3, 'Muskel- og skjelett', false);
INSERT INTO public.modul VALUES (12, 3, 'Smertemestring og arbeidsmiljø', false);
INSERT INTO public.modul VALUES (13, 3, 'Psykisk helse', false);
INSERT INTO public.modul VALUES (14, 2, 'Sees i morgen', false);


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
-- Data for Name: siste_publiseringsinfo; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.siste_publiseringsinfo VALUES (1, 2022, 4, '2023-03-02 00:00:00', '2023-06-01 00:00:00', '2023-08-22 09:37:34.626244');
INSERT INTO public.siste_publiseringsinfo VALUES (2, 2023, 1, '2023-06-01 00:00:00', '2023-09-07 00:00:00', '2023-08-22 09:37:34.66736');
INSERT INTO public.siste_publiseringsinfo VALUES (3, 2022, 3, '2022-12-01 00:00:00', '2023-03-02 00:00:00', '2023-08-22 09:37:34.685912');
INSERT INTO public.siste_publiseringsinfo VALUES (4, 2022, 2, '2022-09-08 00:00:00', '2022-12-01 00:00:00', '2023-08-22 09:37:34.685912');
INSERT INTO public.siste_publiseringsinfo VALUES (5, 2022, 1, '2022-06-02 00:00:00', '2022-09-08 00:00:00', '2023-08-22 09:37:34.685912');
INSERT INTO public.siste_publiseringsinfo VALUES (6, 2021, 4, '2022-03-03 00:00:00', '2022-06-02 00:00:00', '2023-08-22 09:37:34.685912');
INSERT INTO public.siste_publiseringsinfo VALUES (7, 2021, 3, '2021-12-02 00:00:00', '2022-03-03 00:00:00', '2023-08-22 09:37:34.685912');


--
-- Data for Name: sykefravar_statistikk_kategori_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_land; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_naring; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2023, 1, 6, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.370917', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2022, 4, 6, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.458224', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2023, 1, 54, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.458224', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2022, 4, 54, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.458224', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '555555555', 2023, 1, 598, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.458224', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '839787744', 2023, 1, 883, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.458224', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '839787744', 2022, 4, 883, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '870786887', 2023, 1, 42, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '870786887', 2022, 4, 42, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '831738310', 2023, 1, 42, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '831738310', 2022, 4, 42, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '852219055', 2023, 1, 322, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '852219055', 2022, 4, 322, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '864901468', 2023, 1, 208, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '841483836', 2023, 1, 451, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '863591192', 2023, 1, 164, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '802027166', 2023, 1, 820, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '836717968', 2023, 1, 823, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '879932797', 2023, 1, 85, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '823296591', 2023, 1, 590, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '820146481', 2023, 1, 99, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '814047931', 2023, 1, 79, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '801322593', 2023, 1, 881, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '847425787', 2023, 1, 802, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.553582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '883001613', 2023, 1, 401, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.667156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '849135518', 2023, 1, 655, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.667156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '895964716', 2023, 1, 380, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.667156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '821516354', 2023, 1, 815, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.667156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '856863238', 2023, 1, 68, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.667156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '880086028', 2023, 1, 207, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.667156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '808068068', 2023, 1, 156, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '806740783', 2023, 1, 178, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '819181541', 2023, 1, 426, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '849679830', 2023, 1, 325, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '841795547', 2023, 1, 662, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '870774269', 2023, 1, 84, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '806732255', 2023, 1, 938, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '865205048', 2023, 1, 920, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '870660141', 2023, 1, 537, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '838898262', 2023, 1, 378, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '873560121', 2023, 1, 467, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '897973008', 2023, 1, 846, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '826616693', 2023, 1, 345, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '823986632', 2023, 1, 890, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '899589058', 2023, 1, 928, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '844668375', 2023, 1, 717, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '886021001', 2023, 1, 853, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '860900169', 2023, 1, 564, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '898803736', 2023, 1, 109, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '828245680', 2023, 1, 175, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '888290779', 2023, 1, 222, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.797396', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '875011973', 2023, 1, 112, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '874365564', 2023, 1, 455, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '858151415', 2023, 1, 38, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '804997375', 2023, 1, 591, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '850040819', 2023, 1, 694, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '840693679', 2023, 1, 786, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '857776986', 2023, 1, 425, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '866036247', 2023, 1, 45, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '850667929', 2023, 1, 160, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '830359127', 2023, 1, 654, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '893044062', 2023, 1, 707, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '829376504', 2023, 1, 62, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.887216', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '893204151', 2023, 1, 432, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '885992292', 2023, 1, 60, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '864187238', 2023, 1, 420, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '852852541', 2023, 1, 841, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '877797046', 2023, 1, 705, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '887069600', 2023, 1, 105, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '878779387', 2023, 1, 983, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '831659231', 2023, 1, 47, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '895594309', 2023, 1, 360, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '825730193', 2023, 1, 807, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '824401768', 2023, 1, 582, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '841900875', 2023, 1, 818, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '859246845', 2023, 1, 155, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '827286077', 2023, 1, 188, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '838729985', 2023, 1, 314, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '813308826', 2023, 1, 359, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '862652308', 2023, 1, 632, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '883198917', 2023, 1, 522, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '848936697', 2023, 1, 136, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '899918594', 2023, 1, 871, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '851430542', 2023, 1, 169, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '854569765', 2023, 1, 582, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '847010118', 2023, 1, 596, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '805454694', 2023, 1, 388, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '817032203', 2023, 1, 106, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '846260715', 2023, 1, 670, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '849843981', 2023, 1, 967, 12.8, 125, 1.5, false, '2023-08-22 09:38:02.971531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '885746164', 2023, 1, 20, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '869690752', 2023, 1, 397, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '881109697', 2023, 1, 177, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '856963365', 2023, 1, 591, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '813477373', 2023, 1, 731, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '832653426', 2023, 1, 641, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '873720295', 2023, 1, 303, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '876366654', 2023, 1, 281, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '879131072', 2023, 1, 662, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '860873225', 2023, 1, 568, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '860689449', 2023, 1, 363, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '809386082', 2023, 1, 132, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '846459403', 2023, 1, 879, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '804071857', 2023, 1, 918, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.07175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '893592256', 2023, 1, 5, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '838582133', 2023, 1, 532, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '837989185', 2023, 1, 989, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '863727804', 2023, 1, 742, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '822296581', 2023, 1, 298, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '858907718', 2023, 1, 256, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '851028383', 2023, 1, 183, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '897073342', 2023, 1, 343, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '886873501', 2023, 1, 136, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '841316984', 2023, 1, 967, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '864172662', 2023, 1, 776, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '822333912', 2023, 1, 976, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '864292919', 2023, 1, 365, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '897716659', 2023, 1, 790, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '827305958', 2023, 1, 385, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '824073012', 2023, 1, 787, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.146331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '891664402', 2023, 1, 954, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '836357240', 2023, 1, 450, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '845772919', 2023, 1, 427, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '847975171', 2023, 1, 152, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '803105560', 2023, 1, 394, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '851855356', 2023, 1, 690, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '805793393', 2023, 1, 582, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '850908478', 2023, 1, 273, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '894204004', 2023, 1, 510, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '843281206', 2023, 1, 155, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '873208866', 2023, 1, 74, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '888855255', 2023, 1, 102, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '837074404', 2023, 1, 220, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '874146343', 2023, 1, 196, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '884843038', 2023, 1, 571, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '897205384', 2023, 1, 110, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.219948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '876100247', 2023, 1, 935, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '866669359', 2023, 1, 84, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '855075099', 2023, 1, 457, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '823666053', 2023, 1, 626, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '869162655', 2023, 1, 19, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '819283001', 2023, 1, 468, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '887367142', 2023, 1, 951, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '838169743', 2023, 1, 69, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '866861430', 2023, 1, 358, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '888586482', 2023, 1, 169, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '800299031', 2023, 1, 174, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '880924690', 2023, 1, 900, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '872907010', 2023, 1, 999, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '889030810', 2023, 1, 52, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '880213795', 2023, 1, 611, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '836943435', 2023, 1, 969, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.283803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '854989189', 2023, 1, 908, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '884956985', 2023, 1, 233, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '803585452', 2023, 1, 559, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '828048373', 2023, 1, 198, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '855981199', 2023, 1, 402, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '810545559', 2023, 1, 768, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '801240374', 2023, 1, 664, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '872788789', 2023, 1, 121, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '812896043', 2023, 1, 266, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '806655101', 2023, 1, 863, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '835554018', 2023, 1, 832, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '807569356', 2023, 1, 111, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '801913253', 2023, 1, 940, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '853829505', 2023, 1, 629, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '828653764', 2023, 1, 158, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '809610826', 2023, 1, 582, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.354086', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '801750564', 2023, 1, 693, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.411367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '850738515', 2023, 1, 876, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.411367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '847076204', 2023, 1, 990, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.411367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '841667843', 2023, 1, 260, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.411367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '866833294', 2023, 1, 919, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.411367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '814886185', 2023, 1, 561, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.411367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '882869883', 2023, 1, 578, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.411367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '855729692', 2023, 1, 130, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.411367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '838927410', 2023, 1, 581, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.411367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '891519611', 2023, 1, 747, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.411367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '865812907', 2023, 1, 9, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.451355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '872252965', 2023, 1, 510, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.451355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '869949742', 2023, 1, 905, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.451355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '878247725', 2023, 1, 976, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.451355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '807556695', 2023, 1, 296, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.451355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '830442467', 2023, 1, 471, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.451355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '812321579', 2023, 1, 42, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.451355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '854539953', 2023, 1, 614, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.451355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '892455454', 2023, 1, 483, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.451355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '841143184', 2023, 1, 346, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.451355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '803837738', 2023, 1, 398, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '851723524', 2023, 1, 404, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '851637526', 2023, 1, 696, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '859482259', 2023, 1, 256, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '861499075', 2023, 1, 555, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '858454370', 2023, 1, 838, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '844838677', 2023, 1, 938, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '879427551', 2023, 1, 992, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '852588360', 2023, 1, 285, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '850788100', 2023, 1, 911, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '886885659', 2023, 1, 36, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '876531713', 2023, 1, 809, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '838695007', 2023, 1, 541, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '834220116', 2023, 1, 465, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '898760777', 2023, 1, 465, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.524356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '817639962', 2023, 1, 899, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.576239', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '873543315', 2023, 1, 880, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.576239', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '826698611', 2023, 1, 221, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.576239', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '841347020', 2023, 1, 748, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.576239', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '851112680', 2023, 1, 868, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.576239', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '827402806', 2023, 1, 839, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.576239', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '897795909', 2023, 1, 686, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.576239', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '881649081', 2023, 1, 258, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.576239', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '869649338', 2023, 1, 56, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.576239', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '882363737', 2023, 1, 842, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.576239', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '852281546', 2023, 1, 364, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.576239', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '868945238', 2023, 1, 372, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.623246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '868130071', 2023, 1, 799, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.623246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '891695786', 2023, 1, 567, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.623246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '825688329', 2023, 1, 755, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.623246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '873346078', 2023, 1, 650, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.623246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '855571872', 2023, 1, 623, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.623246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '842497026', 2023, 1, 209, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '892859837', 2023, 1, 260, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '844168925', 2023, 1, 519, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '844840716', 2023, 1, 713, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '837151949', 2023, 1, 405, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '888797844', 2023, 1, 662, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '838119992', 2023, 1, 564, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '824058909', 2023, 1, 998, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '858060161', 2023, 1, 285, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '817113974', 2023, 1, 818, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '896792641', 2023, 1, 861, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '882919181', 2023, 1, 882, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '834980687', 2023, 1, 157, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.668159', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '883070774', 2023, 1, 966, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.72261', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '852015835', 2023, 1, 432, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.72261', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '848941760', 2023, 1, 383, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.72261', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '822902914', 2023, 1, 460, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.72261', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '832247705', 2023, 1, 959, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.72261', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '882116682', 2023, 1, 230, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.72261', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '802107269', 2023, 1, 339, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.72261', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '846973089', 2023, 1, 629, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.72261', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '864521767', 2023, 1, 614, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '876207858', 2023, 1, 722, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '851863078', 2023, 1, 777, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '820130534', 2023, 1, 556, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '894547365', 2023, 1, 607, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '859881294', 2023, 1, 824, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '844421359', 2023, 1, 735, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '819951285', 2023, 1, 468, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '887136551', 2023, 1, 159, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '871948973', 2023, 1, 895, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '828558357', 2023, 1, 73, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '877775223', 2023, 1, 946, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '899869668', 2023, 1, 422, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.749957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '809075924', 2023, 1, 58, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.781727', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '899323316', 2023, 1, 176, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.781727', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '803918384', 2023, 1, 255, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.781727', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '852164497', 2023, 1, 26, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.781727', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '838184629', 2023, 1, 847, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.781727', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '801125331', 2023, 1, 530, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.781727', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '894607636', 2023, 1, 429, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.781727', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '832830623', 2023, 1, 381, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.842069', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '865596169', 2023, 1, 991, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.842069', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '867396430', 2023, 1, 30, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.842069', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '870249548', 2023, 1, 895, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.842069', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '882495037', 2023, 1, 404, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.842069', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '813457886', 2023, 1, 749, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.842069', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '887694884', 2023, 1, 209, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.842069', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '812928401', 2023, 1, 862, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.919902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '864000437', 2023, 1, 654, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.919902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '807493576', 2023, 1, 261, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.919902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '848550258', 2023, 1, 633, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.919902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '883655830', 2023, 1, 635, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.919902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '868241232', 2023, 1, 313, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.919902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '838173343', 2023, 1, 975, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.919902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '843899976', 2023, 1, 516, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.919902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '834501836', 2023, 1, 711, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.919902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '853773843', 2023, 1, 89, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.919902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '838600216', 2023, 1, 801, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.919902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '865978885', 2023, 1, 819, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.979087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '809387186', 2023, 1, 788, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.979087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '866320682', 2023, 1, 348, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.979087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '846920550', 2023, 1, 458, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.979087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '800313316', 2023, 1, 229, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.979087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '823018348', 2023, 1, 657, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.979087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '868329884', 2023, 1, 423, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.979087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '816305744', 2023, 1, 417, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.979087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '833233885', 2023, 1, 204, 12.8, 125, 1.5, false, '2023-08-22 09:38:03.979087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '894003194', 2023, 1, 917, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.029459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '837604524', 2023, 1, 105, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.029459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '856528107', 2023, 1, 173, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.029459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '819118508', 2023, 1, 28, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.029459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '872433394', 2023, 1, 300, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.029459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '808752793', 2023, 1, 323, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.029459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '890918442', 2023, 1, 712, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.029459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '823701847', 2023, 1, 35, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.029459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '890553994', 2023, 1, 624, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.029459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '877147267', 2023, 1, 198, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.029459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '882140440', 2023, 1, 835, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.073408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '866079795', 2023, 1, 648, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.073408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '898670143', 2023, 1, 49, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.073408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '847521107', 2023, 1, 205, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.073408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '805730956', 2023, 1, 294, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.073408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '827112352', 2023, 1, 561, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.073408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '816675961', 2023, 1, 28, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.073408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '809638937', 2023, 1, 81, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.073408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '863177301', 2023, 1, 838, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.073408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '803140852', 2023, 1, 722, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.11631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '817420715', 2023, 1, 352, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.11631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '813717314', 2023, 1, 328, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.11631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '805132598', 2023, 1, 202, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.11631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '870203996', 2023, 1, 971, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.11631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '821166157', 2023, 1, 768, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.11631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '867550566', 2023, 1, 361, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.11631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '847112310', 2023, 1, 516, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.11631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '817213081', 2023, 1, 398, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.11631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '834337604', 2023, 1, 305, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.11631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '836556691', 2023, 1, 396, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.194553', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '846363486', 2023, 1, 783, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.194553', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '880468621', 2023, 1, 417, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.194553', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '843130803', 2023, 1, 259, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.194553', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '877435097', 2023, 1, 318, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.194553', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '869853760', 2023, 1, 472, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.194553', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '899985690', 2023, 1, 739, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.194553', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '849298231', 2023, 1, 402, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.194553', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '875342026', 2023, 1, 500, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '814946848', 2023, 1, 721, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '885751164', 2023, 1, 238, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '863988704', 2023, 1, 606, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '877946210', 2023, 1, 565, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '888422554', 2023, 1, 23, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '850536419', 2023, 1, 575, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '871739994', 2023, 1, 826, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '888243272', 2023, 1, 994, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '844563328', 2023, 1, 743, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '896798000', 2023, 1, 309, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '834493680', 2023, 1, 185, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '880975000', 2023, 1, 896, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.271787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '891739945', 2023, 1, 612, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.315271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '873468702', 2023, 1, 201, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.315271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '886768356', 2023, 1, 203, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.315271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '889521982', 2023, 1, 630, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.315271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '811700635', 2023, 1, 531, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.315271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '899208586', 2023, 1, 627, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.315271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '841135274', 2023, 1, 475, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.315271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '888077057', 2023, 1, 473, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.315271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '853721121', 2023, 1, 17, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '858401466', 2023, 1, 274, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '843465993', 2023, 1, 818, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '885825004', 2023, 1, 797, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '804570885', 2023, 1, 135, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '835688408', 2023, 1, 643, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '826868461', 2023, 1, 620, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '883284079', 2023, 1, 644, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '866282763', 2023, 1, 723, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '831207270', 2023, 1, 264, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '802454382', 2023, 1, 246, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '895516204', 2023, 1, 345, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '809387257', 2023, 1, 90, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '806667009', 2023, 1, 991, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.389944', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '832374160', 2023, 1, 633, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.440524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '883019749', 2023, 1, 96, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.440524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '834786438', 2023, 1, 598, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.440524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '853515144', 2023, 1, 850, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.440524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '846753798', 2023, 1, 277, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.440524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '848426920', 2023, 1, 790, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.440524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '815576107', 2023, 1, 93, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.440524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '821549476', 2023, 1, 899, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.440524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '864289727', 2023, 1, 985, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '881215018', 2023, 1, 914, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '849154503', 2023, 1, 959, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '881674037', 2023, 1, 262, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '869536069', 2023, 1, 734, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '828365404', 2023, 1, 549, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '875751238', 2023, 1, 215, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '832012047', 2023, 1, 877, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '897744919', 2023, 1, 407, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '846442703', 2023, 1, 475, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '846073105', 2023, 1, 948, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '813477912', 2023, 1, 677, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '821023298', 2023, 1, 189, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '871027853', 2023, 1, 913, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '837899275', 2023, 1, 359, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.493082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '839983895', 2023, 1, 75, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.541982', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '887074481', 2023, 1, 849, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.541982', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '839387187', 2023, 1, 58, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.541982', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '811866255', 2023, 1, 49, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.541982', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '845039819', 2023, 1, 435, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.541982', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '838256772', 2023, 1, 485, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.541982', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '811530068', 2023, 1, 607, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.541982', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '824231431', 2023, 1, 198, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.541982', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '854883634', 2023, 1, 430, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.541982', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '891683605', 2023, 1, 55, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.541982', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '817692705', 2023, 1, 239, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '825648278', 2023, 1, 734, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '822072121', 2023, 1, 797, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '891795852', 2023, 1, 963, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '886715933', 2023, 1, 970, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '837527242', 2023, 1, 723, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '887509502', 2023, 1, 69, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '806643602', 2023, 1, 21, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '860128386', 2023, 1, 488, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '868540232', 2023, 1, 667, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '828233887', 2023, 1, 367, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '876650080', 2023, 1, 471, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.572489', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '882268990', 2023, 1, 585, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.612586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '865065037', 2023, 1, 896, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.612586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '898723823', 2023, 1, 747, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.612586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '881585147', 2023, 1, 800, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.612586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '812154207', 2023, 1, 162, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.612586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '854476118', 2023, 1, 583, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.612586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '842357468', 2023, 1, 199, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.612586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '899607715', 2023, 1, 829, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.612586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '881934239', 2023, 1, 595, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.612586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '826069364', 2023, 1, 594, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.655697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '838438101', 2023, 1, 977, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.655697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '807312765', 2023, 1, 437, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.655697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '815506850', 2023, 1, 291, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.655697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '860169462', 2023, 1, 434, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.655697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '811283959', 2023, 1, 817, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.655697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '851251150', 2023, 1, 653, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.655697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '811375581', 2023, 1, 553, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.655697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '807563163', 2023, 1, 484, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.655697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '892139138', 2023, 1, 402, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.655697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '806180143', 2023, 1, 381, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.678923', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '857528776', 2023, 1, 579, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.678923', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '809175337', 2023, 1, 899, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.678923', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '858613497', 2023, 1, 691, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.678923', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '863004312', 2023, 1, 282, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.678923', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '851277645', 2023, 1, 653, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.678923', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '824590590', 2023, 1, 778, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.678923', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '813048431', 2023, 1, 640, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '811686406', 2023, 1, 142, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '819766970', 2023, 1, 976, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '807328561', 2023, 1, 126, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '894901869', 2023, 1, 208, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '859386741', 2023, 1, 971, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '892071614', 2023, 1, 409, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '832870175', 2023, 1, 873, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '800286644', 2023, 1, 223, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '825426984', 2023, 1, 735, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '853766006', 2023, 1, 674, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '854997008', 2023, 1, 956, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '812886264', 2023, 1, 102, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '884295332', 2023, 1, 373, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.708881', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '810124461', 2023, 1, 703, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.735576', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '834935011', 2023, 1, 440, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.735576', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '807149274', 2023, 1, 247, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.735576', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '854695094', 2023, 1, 622, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.735576', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '845210969', 2023, 1, 508, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.735576', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '869325590', 2023, 1, 751, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.735576', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '871813139', 2023, 1, 670, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.760642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '833231510', 2023, 1, 417, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.760642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '805879875', 2023, 1, 108, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.760642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '888143042', 2023, 1, 773, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.760642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '851539726', 2023, 1, 722, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.760642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '850079442', 2023, 1, 544, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.79663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '810538212', 2023, 1, 332, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.79663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '873092002', 2023, 1, 98, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.79663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '801692952', 2023, 1, 139, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.79663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '802390487', 2023, 1, 219, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.79663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '836739362', 2023, 1, 935, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.79663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '880840776', 2023, 1, 282, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.79663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '880695479', 2023, 1, 114, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.79663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '848667205', 2023, 1, 495, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.79663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '888964420', 2023, 1, 661, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.79663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '857973308', 2023, 1, 668, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.821876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '867639615', 2023, 1, 766, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.821876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '847465324', 2023, 1, 136, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.821876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '809138406', 2023, 1, 172, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.821876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '877543601', 2023, 1, 809, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '806766681', 2023, 1, 520, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '832630464', 2023, 1, 878, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '847297952', 2023, 1, 617, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '857028099', 2023, 1, 582, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '836482812', 2023, 1, 629, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '864369313', 2023, 1, 145, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '894282061', 2023, 1, 23, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '889075473', 2023, 1, 475, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '857951498', 2023, 1, 876, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '883166293', 2023, 1, 716, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '807831211', 2023, 1, 862, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.844473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '825304441', 2023, 1, 272, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.863277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '808236409', 2023, 1, 432, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.863277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '883829150', 2023, 1, 782, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.863277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '885167866', 2023, 1, 748, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.863277', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '898161453', 2023, 1, 754, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.879784', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '869219583', 2023, 1, 331, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.879784', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '838709938', 2023, 1, 645, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.879784', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '880347757', 2023, 1, 239, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.879784', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '822067638', 2023, 1, 839, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.879784', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '823363719', 2023, 1, 546, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.893739', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '806457946', 2023, 1, 217, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.908001', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '853892287', 2023, 1, 750, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.908001', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '840973333', 2023, 1, 305, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.908001', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '866355728', 2023, 1, 592, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.935679', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '875178653', 2023, 1, 139, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.935679', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '860162579', 2023, 1, 329, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.935679', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '801591815', 2023, 1, 687, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.935679', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '892846818', 2023, 1, 217, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.935679', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '804493146', 2023, 1, 658, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.935679', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '818961021', 2023, 1, 379, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.958375', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '848500382', 2023, 1, 272, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.958375', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '869737117', 2023, 1, 463, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.958375', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '883689945', 2023, 1, 34, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.958375', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '853209498', 2023, 1, 83, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.976932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '885018093', 2023, 1, 233, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.976932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '863176447', 2023, 1, 218, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.976932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '828394729', 2023, 1, 19, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.976932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '873835986', 2023, 1, 765, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.976932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '844865841', 2023, 1, 653, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.976932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '871177944', 2023, 1, 517, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.976932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '847752609', 2023, 1, 576, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.994741', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '816190926', 2023, 1, 637, 12.8, 125, 1.5, false, '2023-08-22 09:38:04.994741', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '854682607', 2023, 1, 580, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.362149', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '882017147', 2023, 1, 227, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.385447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '826361592', 2023, 1, 998, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.401936', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '867891072', 2023, 1, 865, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.401936', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '868038487', 2023, 1, 451, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.430957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '836581771', 2023, 1, 693, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.430957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '895255567', 2023, 1, 873, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.430957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '877109551', 2023, 1, 293, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.430957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '867213427', 2023, 1, 375, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.430957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '870402223', 2023, 1, 694, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.430957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '821721410', 2023, 1, 565, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.430957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '896232122', 2023, 1, 782, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.45009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '810726031', 2023, 1, 178, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.45009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '808080705', 2023, 1, 730, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.45009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '860083862', 2023, 1, 735, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.45009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '846160762', 2023, 1, 521, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.45009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '888126407', 2023, 1, 288, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.45009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '899790463', 2023, 1, 701, 12.8, 125, 1.5, false, '2023-08-22 09:38:07.45009', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 4670.44019283264, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.440944');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 965.917591186414, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.440944');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '555555555', 1050.63205754973, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.440944');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '839787744', 1397.14051221141, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '870786887', 1053.69861828559, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '831738310', 7733.43217819715, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '852219055', 6078.40582898461, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '864901468', 4518.52826526067, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '841483836', 7908.06002286517, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '863591192', 3995.65575384395, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '802027166', 3149.901534534, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '836717968', 2876.99588318735, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '879932797', 9382.89707829052, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '823296591', 7910.46130211731, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '820146481', 8371.7514206567, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '814047931', 2865.52319454083, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '801322593', 2753.5664869538, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '847425787', 4683.04604053629, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.507485');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '883001613', 3808.30391854046, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.643906');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '849135518', 3233.55358061327, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.643906');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '895964716', 5854.87657717259, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.643906');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '821516354', 7970.59858918806, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.643906');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '856863238', 9288.34667364408, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.643906');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '880086028', 3234.06456066575, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.643906');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '808068068', 4204.75771052674, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '806740783', 381.47758049719, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '819181541', 8943.10258875997, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '849679830', 505.194752643141, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '841795547', 4690.53445903319, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '870774269', 5771.37952302031, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '806732255', 6533.90315965537, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '865205048', 6634.59686545775, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '870660141', 5947.98217487354, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '838898262', 3027.10587597867, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '873560121', 5811.04980743833, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '897973008', 6425.27629954909, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '826616693', 9298.53997018963, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '823986632', 7645.87289233662, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '899589058', 8036.0750614486, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '844668375', 4805.68370764399, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '886021001', 3963.4635801749, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '860900169', 6916.85455543758, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '898803736', 9866.56684997998, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '828245680', 1710.64663854771, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '888290779', 7816.54925915281, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.751679');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '875011973', 9632.07141341599, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '874365564', 4743.03114541731, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '858151415', 6952.25447726499, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '804997375', 9387.12009734848, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '850040819', 5129.3597079788, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '840693679', 6487.43658454016, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '857776986', 723.394002881157, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '866036247', 2874.66731708977, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '850667929', 9032.11467856461, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '830359127', 3305.79056547652, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '893044062', 5216.87446049831, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '829376504', 9397.53077982816, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.872571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '893204151', 4282.32833729518, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '885992292', 1684.30131197855, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '864187238', 364.001919397355, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '852852541', 7757.67081493229, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '877797046', 2454.84285778513, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '887069600', 1895.89442201959, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '878779387', 850.546407591519, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '831659231', 8080.70920311809, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '895594309', 2463.93923724903, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '825730193', 7430.85393792592, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '824401768', 8537.7149701401, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '841900875', 1911.64272550454, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '859246845', 6180.3082283547, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '827286077', 1198.55150093551, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '838729985', 5574.7726268405, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '813308826', 8809.22135131617, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '862652308', 2167.42417521517, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '883198917', 2036.45186185405, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '848936697', 4639.28172193885, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '899918594', 5916.65140641723, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '851430542', 2223.07181589857, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '854569765', 1605.13685305028, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '847010118', 5386.30466642665, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '805454694', 2059.58795005438, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '817032203', 3136.02692031259, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '846260715', 2875.40775634942, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '849843981', 2979.47378626539, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:02.948357');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '885746164', 7363.72934974113, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '869690752', 4681.69545717924, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '881109697', 138.75499139601, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '856963365', 2647.78737926212, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '813477373', 4329.50644460328, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '832653426', 3529.85863613217, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '873720295', 7319.37834306785, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '876366654', 5225.11134417154, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '879131072', 5165.56078017712, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '860873225', 9627.95332871073, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '860689449', 5000.08675610621, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '809386082', 3189.0506222974, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '846459403', 996.201434609553, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '804071857', 3101.60357846397, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.038124');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '893592256', 1214.04869653655, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '838582133', 6900.3557034564, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '837989185', 876.820508787497, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '863727804', 115.887547609886, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '822296581', 1546.316016803, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '858907718', 2847.5188826825, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '851028383', 6746.22500944642, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '897073342', 6660.01315239193, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '886873501', 1649.38246670407, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '841316984', 1093.74015550462, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '864172662', 3122.65899837724, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '822333912', 2972.69209488304, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '864292919', 5027.24619049636, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '897716659', 4457.45290866662, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '827305958', 5679.43013433327, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '824073012', 7677.28990900749, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.118147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '891664402', 287.34967349332, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '836357240', 1570.1395447396, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '845772919', 6287.22729851799, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '847975171', 9066.4064060728, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '803105560', 8135.58592879146, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '851855356', 5980.92035768771, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '805793393', 8427.22770163017, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '850908478', 2669.3527130394, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '894204004', 1249.47278911231, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '843281206', 1103.40453875878, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '873208866', 5938.19128375759, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '888855255', 2054.00518502591, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '837074404', 4190.2045464374, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '874146343', 5844.87061661111, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '884843038', 1152.23316286832, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '897205384', 5082.32006595617, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.197472');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '876100247', 9499.67807924108, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '866669359', 3006.66553280725, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '855075099', 737.356936640523, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '823666053', 6241.96313034716, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '869162655', 827.667446445897, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '819283001', 8276.73459274058, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '887367142', 1137.78352391028, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '838169743', 973.386744084408, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '866861430', 7371.15097849968, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '888586482', 7013.22201624745, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '800299031', 6266.38928718837, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '880924690', 3435.21549449399, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '872907010', 145.640837567538, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '889030810', 2945.55346975174, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '880213795', 8600.93210590519, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '836943435', 792.008427006932, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.267932');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '854989189', 6783.10496863886, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '884956985', 5377.35234350459, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '803585452', 3347.16554680261, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '828048373', 7901.0048957147, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '855981199', 5936.36738421779, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '810545559', 1562.72299837154, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '801240374', 6946.39336052423, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '872788789', 2770.58951640826, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '812896043', 2178.33399202565, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '806655101', 2818.09026476994, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '835554018', 3007.44250466565, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '807569356', 9662.45187377437, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '801913253', 4687.56892799592, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '853829505', 6731.01962920373, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '828653764', 2661.25909099107, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '809610826', 6674.33896030906, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.330166');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '801750564', 5893.90304754984, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.395678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '850738515', 1166.49329617113, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.395678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '847076204', 4506.04311240806, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.395678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '841667843', 1478.60497292247, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.395678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '866833294', 8518.98325896561, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.395678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '814886185', 6585.31978703908, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.395678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '882869883', 9814.88653927052, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.395678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '855729692', 8974.03972341837, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.395678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '838927410', 9247.19630247017, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.395678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '891519611', 4994.62072913401, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.395678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '865812907', 9942.44710087832, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.443123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '872252965', 5425.74029733245, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.443123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '869949742', 5592.33090587633, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.443123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '878247725', 2570.08215164737, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.443123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '807556695', 6540.16089449651, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.443123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '830442467', 399.344752243121, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.443123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '812321579', 4523.04017947631, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.443123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '854539953', 4919.88136921268, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.443123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '892455454', 1540.88662210817, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.443123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '841143184', 5514.39804104378, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.443123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '803837738', 8944.44043261408, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '851723524', 2439.17140728054, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '851637526', 780.835253213618, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '859482259', 1175.73904175252, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '861499075', 1564.28281884965, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '858454370', 648.620202230973, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '844838677', 6034.5885393259, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '879427551', 8087.68485729294, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '852588360', 1927.98522299498, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '850788100', 3098.3491715659, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '886885659', 4786.55932627715, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '876531713', 512.632274963078, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '838695007', 8459.77483807303, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '834220116', 7153.35979051514, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '898760777', 7280.30799303537, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.50965');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '817639962', 2466.79616893825, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.55754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '873543315', 8962.32660620551, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.55754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '826698611', 3079.5026877123, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.55754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '841347020', 6909.16301535816, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.55754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '851112680', 9184.47334687178, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.55754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '827402806', 2473.04371735647, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.55754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '897795909', 8759.51883226982, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.55754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '881649081', 5588.83290616803, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.55754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '869649338', 3863.73288800373, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.55754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '882363737', 867.0993146613, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.55754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '852281546', 9613.05104473723, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.55754');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '868945238', 8449.69656252552, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.607041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '868130071', 1798.23260755602, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.607041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '891695786', 8144.21872870854, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.607041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '825688329', 5624.77438970949, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.607041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '873346078', 3246.1060253269, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.607041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '855571872', 6778.80889569106, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.607041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '842497026', 2045.47488132962, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '892859837', 3122.31441241787, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '844168925', 9206.64345249269, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '844840716', 6519.06010690467, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '837151949', 8749.04028177409, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '888797844', 9886.82916013941, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '838119992', 1876.30777215319, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '824058909', 6475.39773863997, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '858060161', 1127.60078378837, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '817113974', 1161.77689025936, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '896792641', 1856.27495936541, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '882919181', 4966.5351551192, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '834980687', 7035.98769450551, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.652822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '883070774', 7891.81752541127, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.707535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '852015835', 5887.68645926398, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.707535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '848941760', 590.460448515401, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.707535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '822902914', 8603.80115546186, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.707535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '832247705', 7106.96981479789, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.707535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '882116682', 2946.85198225266, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.707535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '802107269', 1791.69227894761, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.707535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '846973089', 8298.4771433084, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.707535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '864521767', 3449.86824352265, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '876207858', 6145.88061100692, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '851863078', 3922.40939446982, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '820130534', 2167.01863360673, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '894547365', 7243.309408239, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '859881294', 351.748186051854, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '844421359', 8865.24434660574, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '819951285', 2701.89896244696, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '887136551', 2247.51480155026, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '871948973', 4851.56916118029, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '828558357', 137.498034242498, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '877775223', 5244.19607184823, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '899869668', 3717.45635261857, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.737892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '809075924', 7746.6575316416, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.77274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '899323316', 964.669824305403, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.77274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '803918384', 5013.50113768077, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.77274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '852164497', 1310.45841039524, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.77274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '838184629', 8111.62505938312, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.77274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '801125331', 7617.70430393598, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.77274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '894607636', 7462.69565702516, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.77274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '832830623', 327.93396671419, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.818319');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '865596169', 8223.81036994733, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.818319');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '867396430', 9710.86952300742, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.818319');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '870249548', 147.062648620169, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.818319');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '882495037', 8394.9268350114, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.818319');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '813457886', 6995.50703058456, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.818319');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '887694884', 5144.21474740806, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.818319');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '812928401', 9789.2332021403, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.899539');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '864000437', 968.229768797568, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.899539');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '807493576', 6220.29148199292, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.899539');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '848550258', 7200.20432981877, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.899539');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '883655830', 3997.97923496208, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.899539');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '868241232', 5578.32773093915, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.899539');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '838173343', 9503.37634558445, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.899539');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '843899976', 2612.21803295182, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.899539');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '834501836', 9428.25565080952, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.899539');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '853773843', 1814.84242260646, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.899539');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '838600216', 6487.29013046456, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.899539');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '865978885', 2764.62573538718, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.956257');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '809387186', 6711.31919278678, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.956257');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '866320682', 4552.52877765284, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.956257');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '846920550', 8239.1995547561, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.956257');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '800313316', 6780.97188794719, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.956257');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '823018348', 2251.43138277779, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.956257');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '868329884', 4953.86279480545, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.956257');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '816305744', 8082.03333099343, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.956257');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '833233885', 1434.4291053211, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:03.956257');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '894003194', 8694.08736742067, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.008594');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '837604524', 8666.29625095356, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.008594');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '856528107', 3105.61329386906, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.008594');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '819118508', 5371.31597364384, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.008594');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '872433394', 3694.55966861792, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.008594');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '808752793', 5568.61240819046, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.008594');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '890918442', 584.180295009141, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.008594');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '823701847', 9428.80678483819, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.008594');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '890553994', 229.484366656907, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.008594');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '877147267', 9468.89109466813, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.008594');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '882140440', 2974.11915386436, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.056029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '866079795', 2318.23713197282, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.056029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '898670143', 4468.99234211945, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.056029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '847521107', 9783.76822264233, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.056029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '805730956', 9023.53600265042, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.056029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '827112352', 7462.82713836532, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.056029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '816675961', 3350.44537200974, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.056029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '809638937', 9570.06747094496, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.056029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '863177301', 3213.03561141817, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.056029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '803140852', 5671.93745159918, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.096528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '817420715', 4139.59660085513, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.096528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '813717314', 9499.84646331739, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.096528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '805132598', 2445.18782042514, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.096528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '870203996', 2061.12397308445, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.096528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '821166157', 4563.82834170229, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.096528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '867550566', 3827.34269712035, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.096528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '847112310', 3545.59584961605, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.096528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '817213081', 453.466427875361, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.096528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '834337604', 3059.1004525708, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.096528');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '836556691', 8683.13023641036, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.1577');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '846363486', 3867.86834793322, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.1577');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '880468621', 4920.10898237366, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.1577');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '843130803', 8738.03801118734, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.1577');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '877435097', 6953.00300321454, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.1577');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '869853760', 9949.10957450447, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.1577');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '899985690', 7842.67263140817, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.1577');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '849298231', 3835.3036241263, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.1577');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '875342026', 4014.193761777, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '814946848', 1158.20485941328, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '885751164', 6526.27302760667, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '863988704', 283.299918085674, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '877946210', 6263.80041254578, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '888422554', 346.857640497209, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '850536419', 5028.6792247835, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '871739994', 3033.72315892288, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '888243272', 514.257389613016, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '844563328', 5858.48541129931, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '896798000', 6884.74126382228, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '834493680', 873.974438312437, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '880975000', 5334.42188371698, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.240847');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '891739945', 7117.81397930322, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.310657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '873468702', 9327.51713998368, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.310657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '886768356', 7256.90561658188, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.310657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '889521982', 4977.77397653461, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.310657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '811700635', 2583.62810404708, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.310657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '899208586', 6620.43254899646, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.310657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '841135274', 4616.77990925949, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.310657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '888077057', 8739.33815575648, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.310657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '853721121', 6575.22397532939, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '858401466', 3636.76043818117, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '843465993', 2464.94364661687, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '885825004', 5420.97410440296, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '804570885', 6160.19698943321, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '835688408', 8367.80050504922, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '826868461', 4778.87578795336, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '883284079', 7354.72634813975, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '866282763', 1263.09270278931, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '831207270', 7894.21320073233, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '802454382', 7198.23315987431, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '895516204', 4724.8829445148, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '809387257', 5477.21907721849, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '806667009', 3298.12241209468, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.365284');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '832374160', 1391.88813766182, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.426497');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '883019749', 8555.47352726199, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.426497');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '834786438', 9956.72771891577, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.426497');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '853515144', 3469.59379899614, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.426497');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '846753798', 22.2351183693623, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.426497');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '848426920', 9096.59477805082, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.426497');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '815576107', 6158.44936845233, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.426497');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '821549476', 118.274740114851, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.426497');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '864289727', 3746.87887716717, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '881215018', 3170.15120644012, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '849154503', 5780.79732051236, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '881674037', 9558.95812575943, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '869536069', 2119.17300648511, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '828365404', 8082.37427208529, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '875751238', 5060.0892731097, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '832012047', 7559.18826051033, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '897744919', 9674.79653824629, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '846442703', 2512.46830755992, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '846073105', 7101.73731616686, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '813477912', 11.6800039664849, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '821023298', 2126.21241012387, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '871027853', 5707.83162052615, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '837899275', 9918.44285196531, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.472426');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '839983895', 9082.19085312082, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.526908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '887074481', 1071.76321152007, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.526908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '839387187', 294.407007414595, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.526908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '811866255', 6464.08381142339, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.526908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '845039819', 4558.65588737904, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.526908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '838256772', 8265.99980546735, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.526908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '811530068', 2663.50888954318, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.526908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '824231431', 2321.09830040253, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.526908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '854883634', 5873.39610410624, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.526908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '891683605', 5684.26031271598, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.526908');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '817692705', 6540.83383769372, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '825648278', 10.2311563852229, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '822072121', 6543.9451323515, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '891795852', 1710.84639798985, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '886715933', 1540.23236550092, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '837527242', 9722.33115504081, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '887509502', 5521.50698768305, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '806643602', 7176.67787329507, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '860128386', 3983.07912550842, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '868540232', 4364.00609789974, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '828233887', 1536.12871200491, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '876650080', 4949.66939737716, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.563228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '882268990', 1816.09608495682, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.599066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '865065037', 8431.81370741117, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.599066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '898723823', 1363.10390741478, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.599066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '881585147', 8606.5536854048, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.599066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '812154207', 4437.20218930884, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.599066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '854476118', 6397.16452952371, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.599066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '842357468', 8268.31132793111, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.599066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '899607715', 8626.5353129005, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.599066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '881934239', 5244.95876563756, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.599066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '826069364', 6449.97522688665, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.641564');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '838438101', 9547.51986305969, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.641564');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '807312765', 6612.09102672456, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.641564');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '815506850', 3051.15011403315, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.641564');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '860169462', 1067.27191254422, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.641564');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '811283959', 9630.41989556813, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.641564');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '851251150', 7609.58179968609, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.641564');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '811375581', 8117.55562536257, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.641564');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '807563163', 2032.31553565593, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.641564');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '892139138', 6044.09759906914, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.641564');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '806180143', 7324.20882525747, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.675396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '857528776', 825.986391868378, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.675396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '809175337', 3162.46591253473, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.675396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '858613497', 5610.38581478327, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.675396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '863004312', 3202.83638472638, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.675396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '851277645', 5799.68405381267, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.675396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '824590590', 3809.64868926346, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.675396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '813048431', 3996.50802955283, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '811686406', 2265.40051929949, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '819766970', 6401.33906666179, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '807328561', 157.037362609656, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '894901869', 27.6609871443747, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '859386741', 3830.83353461101, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '892071614', 1607.59609344336, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '832870175', 9444.02281013402, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '800286644', 4051.17754287072, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '825426984', 1208.34301722817, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '853766006', 1103.97847064538, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '854997008', 4429.34853241608, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '812886264', 8432.46309185964, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '884295332', 7690.73539853514, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.704133');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '810124461', 3034.2044357177, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.730657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '834935011', 1153.98851755396, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.730657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '807149274', 2803.07485495878, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.730657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '854695094', 8468.8032287221, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.730657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '845210969', 9909.64604946875, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.730657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '869325590', 9734.73172412805, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.730657');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '871813139', 1628.09260875583, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.758142');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '833231510', 6623.94974911604, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.758142');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '805879875', 8786.39215268251, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.758142');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '888143042', 5245.8380297245, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.758142');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '851539726', 1169.32189228312, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.758142');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '850079442', 512.283395962223, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.783508');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '810538212', 6458.91533421838, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.783508');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '873092002', 4014.67696013883, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.783508');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '801692952', 6619.53510887445, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.783508');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '802390487', 3907.38894293987, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.783508');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '836739362', 4604.92330254723, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.783508');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '880840776', 8776.25985955452, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.783508');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '880695479', 9309.18911488593, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.783508');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '848667205', 5548.27138380632, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.783508');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '888964420', 3513.55664196577, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.783508');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '857973308', 8029.68712070818, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.819459');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '867639615', 8508.75768748478, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.819459');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '847465324', 8051.04700838546, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.819459');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '809138406', 1901.33543527597, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.819459');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '877543601', 9142.41632666577, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '806766681', 9065.29796597812, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '832630464', 2056.16301595722, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '847297952', 5839.34311563603, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '857028099', 2575.74991329614, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '836482812', 402.329243390217, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '864369313', 4694.52469461017, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '894282061', 5204.81402039188, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '889075473', 8297.15077319558, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '857951498', 3379.1471516205, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '883166293', 2583.23240136796, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '807831211', 84.7868709682625, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.841179');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '825304441', 7578.52447535967, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.861151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '808236409', 3572.34707025272, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.861151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '883829150', 3196.36128866112, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.861151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '885167866', 2890.93335194284, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.861151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '898161453', 3651.87128962301, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.874274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '869219583', 6317.74794727854, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.874274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '838709938', 2094.94441899157, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.874274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '880347757', 2518.44306006554, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.874274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '822067638', 4032.67890227064, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.874274');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '823363719', 1700.37653427251, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.890399');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '806457946', 5804.08493213058, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.903998');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '853892287', 9322.76622976253, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.903998');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '840973333', 8281.44228105621, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.903998');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '866355728', 279.377457496962, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.926122');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '875178653', 9581.0182765934, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.926122');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '860162579', 3318.24757851292, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.926122');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '801591815', 7618.91486423689, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.926122');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '892846818', 7780.97826833736, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.926122');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '804493146', 1986.05944019429, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.926122');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '818961021', 8933.06849309337, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.953058');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '848500382', 2848.06168039846, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.953058');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '869737117', 7639.75319631421, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.953058');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '883689945', 1608.57147123389, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.953058');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '853209498', 6280.77406985584, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.971917');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '885018093', 8053.34397532764, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.971917');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '863176447', 9829.68112987194, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.971917');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '828394729', 8476.99625045125, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.971917');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '873835986', 1421.3720498068, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.971917');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '844865841', 9447.29032917922, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.971917');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '871177944', 4487.70465992312, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.971917');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '847752609', 5833.42544095076, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.992353');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '816190926', 6243.86733777475, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:04.992353');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '854682607', 9984.90052340026, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.360744');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '882017147', 1622.00760257357, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.384292');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '826361592', 6742.57700465398, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.397223');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '867891072', 5500.76997362717, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.397223');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '868038487', 3597.61029716146, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.427213');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '836581771', 1393.24377445213, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.427213');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '895255567', 451.758536863658, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.427213');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '877109551', 3070.17072627213, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.427213');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '867213427', 1362.06390999859, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.427213');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '870402223', 7093.87227625591, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.427213');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '821721410', 4936.86536190788, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.427213');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '896232122', 2057.09506084919, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.447905');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '810726031', 690.088044309058, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.447905');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '808080705', 3834.28136209818, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.447905');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '860083862', 2356.13067211105, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.447905');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '846160762', 1209.7294897681, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.447905');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '888126407', 953.440216469777, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.447905');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '899790463', 1492.56972654644, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-22 09:38:07.447905');


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.567061', '2023-08-22 09:38:00.567061');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.602178', '2023-08-22 09:38:00.602178');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.608321', '2023-08-22 09:38:00.608321');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.619', '2023-08-22 09:38:00.619');
INSERT INTO public.virksomhet VALUES (5, '847045648', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847045648', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.624489', '2023-08-22 09:38:00.624489');
INSERT INTO public.virksomhet VALUES (6, '839787744', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839787744', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.629135', '2023-08-22 09:38:00.629135');
INSERT INTO public.virksomhet VALUES (7, '870786887', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870786887', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.633997', '2023-08-22 09:38:00.633997');
INSERT INTO public.virksomhet VALUES (8, '831738310', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831738310', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.638347', '2023-08-22 09:38:00.638347');
INSERT INTO public.virksomhet VALUES (9, '852219055', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852219055', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.64355', '2023-08-22 09:38:00.64355');
INSERT INTO public.virksomhet VALUES (10, '864901468', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864901468', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.647121', '2023-08-22 09:38:00.647121');
INSERT INTO public.virksomhet VALUES (11, '841483836', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841483836', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.650873', '2023-08-22 09:38:00.650873');
INSERT INTO public.virksomhet VALUES (12, '863591192', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863591192', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.653975', '2023-08-22 09:38:00.653975');
INSERT INTO public.virksomhet VALUES (13, '802027166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802027166', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.657776', '2023-08-22 09:38:00.657776');
INSERT INTO public.virksomhet VALUES (14, '836717968', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836717968', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.660995', '2023-08-22 09:38:00.660995');
INSERT INTO public.virksomhet VALUES (15, '879932797', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879932797', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.664411', '2023-08-22 09:38:00.664411');
INSERT INTO public.virksomhet VALUES (16, '823296591', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823296591', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.668221', '2023-08-22 09:38:00.668221');
INSERT INTO public.virksomhet VALUES (17, '820146481', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820146481', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.671835', '2023-08-22 09:38:00.671835');
INSERT INTO public.virksomhet VALUES (18, '814047931', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814047931', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.675617', '2023-08-22 09:38:00.675617');
INSERT INTO public.virksomhet VALUES (19, '801322593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801322593', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.679013', '2023-08-22 09:38:00.679013');
INSERT INTO public.virksomhet VALUES (20, '847425787', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847425787', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.682074', '2023-08-22 09:38:00.682074');
INSERT INTO public.virksomhet VALUES (21, '883001613', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883001613', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.68534', '2023-08-22 09:38:00.68534');
INSERT INTO public.virksomhet VALUES (22, '849135518', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849135518', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.688606', '2023-08-22 09:38:00.688606');
INSERT INTO public.virksomhet VALUES (23, '895964716', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895964716', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.691813', '2023-08-22 09:38:00.691813');
INSERT INTO public.virksomhet VALUES (24, '821516354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821516354', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.694866', '2023-08-22 09:38:00.694866');
INSERT INTO public.virksomhet VALUES (25, '856863238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856863238', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.69776', '2023-08-22 09:38:00.69776');
INSERT INTO public.virksomhet VALUES (26, '880086028', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880086028', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.700829', '2023-08-22 09:38:00.700829');
INSERT INTO public.virksomhet VALUES (27, '808068068', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808068068', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.703925', '2023-08-22 09:38:00.703925');
INSERT INTO public.virksomhet VALUES (28, '806740783', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806740783', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.708049', '2023-08-22 09:38:00.708049');
INSERT INTO public.virksomhet VALUES (29, '819181541', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819181541', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.71091', '2023-08-22 09:38:00.71091');
INSERT INTO public.virksomhet VALUES (30, '849679830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849679830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.7135', '2023-08-22 09:38:00.7135');
INSERT INTO public.virksomhet VALUES (31, '841795547', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841795547', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.716241', '2023-08-22 09:38:00.716241');
INSERT INTO public.virksomhet VALUES (32, '870774269', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870774269', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.719172', '2023-08-22 09:38:00.719172');
INSERT INTO public.virksomhet VALUES (33, '806732255', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806732255', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.722595', '2023-08-22 09:38:00.722595');
INSERT INTO public.virksomhet VALUES (34, '865205048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865205048', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.725555', '2023-08-22 09:38:00.725555');
INSERT INTO public.virksomhet VALUES (35, '870660141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870660141', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.728382', '2023-08-22 09:38:00.728382');
INSERT INTO public.virksomhet VALUES (36, '838898262', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838898262', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.731394', '2023-08-22 09:38:00.731394');
INSERT INTO public.virksomhet VALUES (37, '873560121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873560121', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.734803', '2023-08-22 09:38:00.734803');
INSERT INTO public.virksomhet VALUES (38, '897973008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897973008', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.737689', '2023-08-22 09:38:00.737689');
INSERT INTO public.virksomhet VALUES (39, '826616693', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826616693', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.74063', '2023-08-22 09:38:00.74063');
INSERT INTO public.virksomhet VALUES (40, '823986632', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823986632', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.743428', '2023-08-22 09:38:00.743428');
INSERT INTO public.virksomhet VALUES (41, '899589058', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899589058', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.746226', '2023-08-22 09:38:00.746226');
INSERT INTO public.virksomhet VALUES (42, '844668375', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844668375', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.749299', '2023-08-22 09:38:00.749299');
INSERT INTO public.virksomhet VALUES (43, '886021001', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886021001', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.751773', '2023-08-22 09:38:00.751773');
INSERT INTO public.virksomhet VALUES (44, '860900169', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860900169', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.754602', '2023-08-22 09:38:00.754602');
INSERT INTO public.virksomhet VALUES (45, '898803736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898803736', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.758212', '2023-08-22 09:38:00.758212');
INSERT INTO public.virksomhet VALUES (46, '828245680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828245680', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.760906', '2023-08-22 09:38:00.760906');
INSERT INTO public.virksomhet VALUES (47, '888290779', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888290779', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.763646', '2023-08-22 09:38:00.763646');
INSERT INTO public.virksomhet VALUES (48, '875011973', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875011973', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.766606', '2023-08-22 09:38:00.766606');
INSERT INTO public.virksomhet VALUES (49, '874365564', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874365564', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.769216', '2023-08-22 09:38:00.769216');
INSERT INTO public.virksomhet VALUES (50, '858151415', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858151415', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.771899', '2023-08-22 09:38:00.771899');
INSERT INTO public.virksomhet VALUES (51, '804997375', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804997375', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.775448', '2023-08-22 09:38:00.775448');
INSERT INTO public.virksomhet VALUES (52, '850040819', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850040819', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.778364', '2023-08-22 09:38:00.778364');
INSERT INTO public.virksomhet VALUES (53, '840693679', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840693679', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.78123', '2023-08-22 09:38:00.78123');
INSERT INTO public.virksomhet VALUES (54, '857776986', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857776986', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.785202', '2023-08-22 09:38:00.785202');
INSERT INTO public.virksomhet VALUES (55, '866036247', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866036247', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.788673', '2023-08-22 09:38:00.788673');
INSERT INTO public.virksomhet VALUES (56, '850667929', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850667929', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.792187', '2023-08-22 09:38:00.792187');
INSERT INTO public.virksomhet VALUES (57, '830359127', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830359127', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.795575', '2023-08-22 09:38:00.795575');
INSERT INTO public.virksomhet VALUES (58, '893044062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893044062', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.799659', '2023-08-22 09:38:00.799659');
INSERT INTO public.virksomhet VALUES (59, '829376504', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829376504', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.802866', '2023-08-22 09:38:00.802866');
INSERT INTO public.virksomhet VALUES (60, '893204151', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893204151', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.80654', '2023-08-22 09:38:00.80654');
INSERT INTO public.virksomhet VALUES (61, '885992292', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885992292', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.809238', '2023-08-22 09:38:00.809238');
INSERT INTO public.virksomhet VALUES (62, '864187238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864187238', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.811784', '2023-08-22 09:38:00.811784');
INSERT INTO public.virksomhet VALUES (63, '852852541', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852852541', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.81439', '2023-08-22 09:38:00.81439');
INSERT INTO public.virksomhet VALUES (64, '877797046', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877797046', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.817776', '2023-08-22 09:38:00.817776');
INSERT INTO public.virksomhet VALUES (65, '887069600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887069600', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.820455', '2023-08-22 09:38:00.820455');
INSERT INTO public.virksomhet VALUES (66, '878779387', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878779387', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.823638', '2023-08-22 09:38:00.823638');
INSERT INTO public.virksomhet VALUES (67, '831659231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831659231', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.826249', '2023-08-22 09:38:00.826249');
INSERT INTO public.virksomhet VALUES (68, '895594309', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895594309', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.840637', '2023-08-22 09:38:00.840637');
INSERT INTO public.virksomhet VALUES (69, '825730193', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825730193', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.844519', '2023-08-22 09:38:00.844519');
INSERT INTO public.virksomhet VALUES (70, '824401768', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824401768', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.848449', '2023-08-22 09:38:00.848449');
INSERT INTO public.virksomhet VALUES (71, '841900875', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841900875', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.851505', '2023-08-22 09:38:00.851505');
INSERT INTO public.virksomhet VALUES (72, '859246845', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859246845', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.854033', '2023-08-22 09:38:00.854033');
INSERT INTO public.virksomhet VALUES (73, '827286077', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827286077', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.857443', '2023-08-22 09:38:00.857443');
INSERT INTO public.virksomhet VALUES (74, '838729985', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838729985', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.859967', '2023-08-22 09:38:00.859967');
INSERT INTO public.virksomhet VALUES (75, '813308826', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813308826', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.862314', '2023-08-22 09:38:00.862314');
INSERT INTO public.virksomhet VALUES (76, '862652308', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862652308', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.865028', '2023-08-22 09:38:00.865028');
INSERT INTO public.virksomhet VALUES (77, '883198917', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883198917', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.868182', '2023-08-22 09:38:00.868182');
INSERT INTO public.virksomhet VALUES (78, '848936697', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848936697', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.870877', '2023-08-22 09:38:00.870877');
INSERT INTO public.virksomhet VALUES (79, '899918594', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899918594', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.873598', '2023-08-22 09:38:00.873598');
INSERT INTO public.virksomhet VALUES (80, '851430542', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851430542', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.876574', '2023-08-22 09:38:00.876574');
INSERT INTO public.virksomhet VALUES (81, '854569765', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854569765', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.879493', '2023-08-22 09:38:00.879493');
INSERT INTO public.virksomhet VALUES (82, '847010118', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847010118', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.882114', '2023-08-22 09:38:00.882114');
INSERT INTO public.virksomhet VALUES (83, '805454694', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805454694', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.884637', '2023-08-22 09:38:00.884637');
INSERT INTO public.virksomhet VALUES (84, '817032203', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817032203', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.88695', '2023-08-22 09:38:00.88695');
INSERT INTO public.virksomhet VALUES (85, '846260715', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846260715', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.890423', '2023-08-22 09:38:00.890423');
INSERT INTO public.virksomhet VALUES (86, '849843981', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849843981', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.893972', '2023-08-22 09:38:00.893972');
INSERT INTO public.virksomhet VALUES (87, '885746164', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885746164', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.898023', '2023-08-22 09:38:00.898023');
INSERT INTO public.virksomhet VALUES (88, '869690752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869690752', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.901732', '2023-08-22 09:38:00.901732');
INSERT INTO public.virksomhet VALUES (89, '881109697', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881109697', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.905781', '2023-08-22 09:38:00.905781');
INSERT INTO public.virksomhet VALUES (90, '856963365', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856963365', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.9102', '2023-08-22 09:38:00.9102');
INSERT INTO public.virksomhet VALUES (91, '813477373', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813477373', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.912866', '2023-08-22 09:38:00.912866');
INSERT INTO public.virksomhet VALUES (92, '832653426', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832653426', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.915671', '2023-08-22 09:38:00.915671');
INSERT INTO public.virksomhet VALUES (93, '873720295', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873720295', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.919095', '2023-08-22 09:38:00.919095');
INSERT INTO public.virksomhet VALUES (94, '876366654', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876366654', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.922306', '2023-08-22 09:38:00.922306');
INSERT INTO public.virksomhet VALUES (95, '879131072', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879131072', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.926462', '2023-08-22 09:38:00.926462');
INSERT INTO public.virksomhet VALUES (96, '860873225', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860873225', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.928996', '2023-08-22 09:38:00.928996');
INSERT INTO public.virksomhet VALUES (97, '860689449', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860689449', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.932012', '2023-08-22 09:38:00.932012');
INSERT INTO public.virksomhet VALUES (98, '809386082', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809386082', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.934963', '2023-08-22 09:38:00.934963');
INSERT INTO public.virksomhet VALUES (99, '846459403', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846459403', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.93764', '2023-08-22 09:38:00.93764');
INSERT INTO public.virksomhet VALUES (100, '804071857', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804071857', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.941633', '2023-08-22 09:38:00.941633');
INSERT INTO public.virksomhet VALUES (101, '893592256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893592256', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.944389', '2023-08-22 09:38:00.944389');
INSERT INTO public.virksomhet VALUES (102, '838582133', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838582133', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.946782', '2023-08-22 09:38:00.946782');
INSERT INTO public.virksomhet VALUES (103, '837989185', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837989185', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.94941', '2023-08-22 09:38:00.94941');
INSERT INTO public.virksomhet VALUES (104, '863727804', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863727804', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.952095', '2023-08-22 09:38:00.952095');
INSERT INTO public.virksomhet VALUES (105, '822296581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822296581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.954732', '2023-08-22 09:38:00.954732');
INSERT INTO public.virksomhet VALUES (106, '858907718', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858907718', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.958692', '2023-08-22 09:38:00.958692');
INSERT INTO public.virksomhet VALUES (107, '851028383', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851028383', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.961305', '2023-08-22 09:38:00.961305');
INSERT INTO public.virksomhet VALUES (108, '897073342', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897073342', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.963887', '2023-08-22 09:38:00.963887');
INSERT INTO public.virksomhet VALUES (109, '886873501', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886873501', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.967115', '2023-08-22 09:38:00.967115');
INSERT INTO public.virksomhet VALUES (110, '841316984', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841316984', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.969888', '2023-08-22 09:38:00.969888');
INSERT INTO public.virksomhet VALUES (111, '864172662', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864172662', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.974423', '2023-08-22 09:38:00.974423');
INSERT INTO public.virksomhet VALUES (112, '822333912', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822333912', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.977894', '2023-08-22 09:38:00.977894');
INSERT INTO public.virksomhet VALUES (113, '864292919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864292919', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.980423', '2023-08-22 09:38:00.980423');
INSERT INTO public.virksomhet VALUES (114, '897716659', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897716659', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.983052', '2023-08-22 09:38:00.983052');
INSERT INTO public.virksomhet VALUES (115, '827305958', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827305958', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.985693', '2023-08-22 09:38:00.985693');
INSERT INTO public.virksomhet VALUES (116, '824073012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824073012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.988334', '2023-08-22 09:38:00.988334');
INSERT INTO public.virksomhet VALUES (117, '891664402', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891664402', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.991636', '2023-08-22 09:38:00.991636');
INSERT INTO public.virksomhet VALUES (118, '836357240', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836357240', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.994235', '2023-08-22 09:38:00.994235');
INSERT INTO public.virksomhet VALUES (119, '845772919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845772919', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.996621', '2023-08-22 09:38:00.996621');
INSERT INTO public.virksomhet VALUES (120, '847975171', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847975171', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:00.999142', '2023-08-22 09:38:00.999142');
INSERT INTO public.virksomhet VALUES (121, '803105560', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803105560', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.00209', '2023-08-22 09:38:01.00209');
INSERT INTO public.virksomhet VALUES (122, '851855356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851855356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.004778', '2023-08-22 09:38:01.004778');
INSERT INTO public.virksomhet VALUES (123, '805793393', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805793393', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.007883', '2023-08-22 09:38:01.007883');
INSERT INTO public.virksomhet VALUES (124, '850908478', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850908478', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.010547', '2023-08-22 09:38:01.010547');
INSERT INTO public.virksomhet VALUES (125, '894204004', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894204004', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.012988', '2023-08-22 09:38:01.012988');
INSERT INTO public.virksomhet VALUES (126, '843281206', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843281206', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.015609', '2023-08-22 09:38:01.015609');
INSERT INTO public.virksomhet VALUES (127, '873208866', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873208866', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.018372', '2023-08-22 09:38:01.018372');
INSERT INTO public.virksomhet VALUES (128, '888855255', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888855255', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.021008', '2023-08-22 09:38:01.021008');
INSERT INTO public.virksomhet VALUES (129, '837074404', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837074404', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.024149', '2023-08-22 09:38:01.024149');
INSERT INTO public.virksomhet VALUES (130, '874146343', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874146343', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.026832', '2023-08-22 09:38:01.026832');
INSERT INTO public.virksomhet VALUES (131, '884843038', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884843038', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.029191', '2023-08-22 09:38:01.029191');
INSERT INTO public.virksomhet VALUES (132, '897205384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897205384', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.031659', '2023-08-22 09:38:01.031659');
INSERT INTO public.virksomhet VALUES (133, '876100247', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876100247', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.034359', '2023-08-22 09:38:01.034359');
INSERT INTO public.virksomhet VALUES (134, '866669359', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866669359', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.036872', '2023-08-22 09:38:01.036872');
INSERT INTO public.virksomhet VALUES (135, '855075099', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855075099', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.039877', '2023-08-22 09:38:01.039877');
INSERT INTO public.virksomhet VALUES (136, '823666053', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823666053', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.042687', '2023-08-22 09:38:01.042687');
INSERT INTO public.virksomhet VALUES (137, '869162655', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869162655', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.045099', '2023-08-22 09:38:01.045099');
INSERT INTO public.virksomhet VALUES (138, '819283001', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819283001', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.047382', '2023-08-22 09:38:01.047382');
INSERT INTO public.virksomhet VALUES (139, '887367142', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887367142', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.050214', '2023-08-22 09:38:01.050214');
INSERT INTO public.virksomhet VALUES (140, '838169743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838169743', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.053061', '2023-08-22 09:38:01.053061');
INSERT INTO public.virksomhet VALUES (141, '866861430', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866861430', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.056532', '2023-08-22 09:38:01.056532');
INSERT INTO public.virksomhet VALUES (142, '888586482', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888586482', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.059278', '2023-08-22 09:38:01.059278');
INSERT INTO public.virksomhet VALUES (143, '800299031', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800299031', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.06205', '2023-08-22 09:38:01.06205');
INSERT INTO public.virksomhet VALUES (144, '880924690', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880924690', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.064569', '2023-08-22 09:38:01.064569');
INSERT INTO public.virksomhet VALUES (145, '872907010', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872907010', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.067548', '2023-08-22 09:38:01.067548');
INSERT INTO public.virksomhet VALUES (146, '889030810', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889030810', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.070511', '2023-08-22 09:38:01.070511');
INSERT INTO public.virksomhet VALUES (147, '880213795', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880213795', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.074195', '2023-08-22 09:38:01.074195');
INSERT INTO public.virksomhet VALUES (148, '836943435', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836943435', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.077059', '2023-08-22 09:38:01.077059');
INSERT INTO public.virksomhet VALUES (149, '854989189', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854989189', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.079897', '2023-08-22 09:38:01.079897');
INSERT INTO public.virksomhet VALUES (150, '884956985', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884956985', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.082421', '2023-08-22 09:38:01.082421');
INSERT INTO public.virksomhet VALUES (151, '803585452', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803585452', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.08512', '2023-08-22 09:38:01.08512');
INSERT INTO public.virksomhet VALUES (152, '828048373', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828048373', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.087759', '2023-08-22 09:38:01.087759');
INSERT INTO public.virksomhet VALUES (153, '855981199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855981199', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.091391', '2023-08-22 09:38:01.091391');
INSERT INTO public.virksomhet VALUES (154, '810545559', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810545559', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.094036', '2023-08-22 09:38:01.094036');
INSERT INTO public.virksomhet VALUES (155, '801240374', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801240374', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.09769', '2023-08-22 09:38:01.09769');
INSERT INTO public.virksomhet VALUES (156, '872788789', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872788789', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.103231', '2023-08-22 09:38:01.103231');
INSERT INTO public.virksomhet VALUES (157, '812896043', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812896043', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.106053', '2023-08-22 09:38:01.106053');
INSERT INTO public.virksomhet VALUES (158, '806655101', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806655101', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.108665', '2023-08-22 09:38:01.108665');
INSERT INTO public.virksomhet VALUES (159, '835554018', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835554018', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.111328', '2023-08-22 09:38:01.111328');
INSERT INTO public.virksomhet VALUES (160, '807569356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807569356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.11386', '2023-08-22 09:38:01.11386');
INSERT INTO public.virksomhet VALUES (161, '801913253', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801913253', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.116471', '2023-08-22 09:38:01.116471');
INSERT INTO public.virksomhet VALUES (162, '853829505', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853829505', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.126945', '2023-08-22 09:38:01.126945');
INSERT INTO public.virksomhet VALUES (163, '828653764', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828653764', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.130215', '2023-08-22 09:38:01.130215');
INSERT INTO public.virksomhet VALUES (164, '809610826', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809610826', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.133819', '2023-08-22 09:38:01.133819');
INSERT INTO public.virksomhet VALUES (165, '801750564', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801750564', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.137261', '2023-08-22 09:38:01.137261');
INSERT INTO public.virksomhet VALUES (166, '850738515', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850738515', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.140742', '2023-08-22 09:38:01.140742');
INSERT INTO public.virksomhet VALUES (167, '847076204', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847076204', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.143349', '2023-08-22 09:38:01.143349');
INSERT INTO public.virksomhet VALUES (168, '841667843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841667843', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.145931', '2023-08-22 09:38:01.145931');
INSERT INTO public.virksomhet VALUES (169, '866833294', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866833294', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.148425', '2023-08-22 09:38:01.148425');
INSERT INTO public.virksomhet VALUES (170, '814886185', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814886185', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.151641', '2023-08-22 09:38:01.151641');
INSERT INTO public.virksomhet VALUES (171, '882869883', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882869883', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.154816', '2023-08-22 09:38:01.154816');
INSERT INTO public.virksomhet VALUES (172, '855729692', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855729692', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.158633', '2023-08-22 09:38:01.158633');
INSERT INTO public.virksomhet VALUES (173, '838927410', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838927410', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.161408', '2023-08-22 09:38:01.161408');
INSERT INTO public.virksomhet VALUES (174, '891519611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891519611', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.163961', '2023-08-22 09:38:01.163961');
INSERT INTO public.virksomhet VALUES (175, '865812907', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865812907', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.166898', '2023-08-22 09:38:01.166898');
INSERT INTO public.virksomhet VALUES (176, '872252965', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872252965', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.169999', '2023-08-22 09:38:01.169999');
INSERT INTO public.virksomhet VALUES (177, '869949742', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869949742', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.173837', '2023-08-22 09:38:01.173837');
INSERT INTO public.virksomhet VALUES (178, '878247725', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878247725', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.176582', '2023-08-22 09:38:01.176582');
INSERT INTO public.virksomhet VALUES (179, '807556695', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807556695', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.179269', '2023-08-22 09:38:01.179269');
INSERT INTO public.virksomhet VALUES (180, '830442467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830442467', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.182359', '2023-08-22 09:38:01.182359');
INSERT INTO public.virksomhet VALUES (181, '812321579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812321579', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.185763', '2023-08-22 09:38:01.185763');
INSERT INTO public.virksomhet VALUES (182, '854539953', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854539953', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.188786', '2023-08-22 09:38:01.188786');
INSERT INTO public.virksomhet VALUES (183, '892455454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892455454', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.191764', '2023-08-22 09:38:01.191764');
INSERT INTO public.virksomhet VALUES (184, '841143184', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841143184', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.194349', '2023-08-22 09:38:01.194349');
INSERT INTO public.virksomhet VALUES (185, '803837738', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803837738', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.196885', '2023-08-22 09:38:01.196885');
INSERT INTO public.virksomhet VALUES (186, '851723524', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851723524', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.199917', '2023-08-22 09:38:01.199917');
INSERT INTO public.virksomhet VALUES (187, '851637526', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851637526', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.202963', '2023-08-22 09:38:01.202963');
INSERT INTO public.virksomhet VALUES (188, '859482259', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859482259', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.206722', '2023-08-22 09:38:01.206722');
INSERT INTO public.virksomhet VALUES (189, '861499075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861499075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.209798', '2023-08-22 09:38:01.209798');
INSERT INTO public.virksomhet VALUES (190, '858454370', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858454370', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.212789', '2023-08-22 09:38:01.212789');
INSERT INTO public.virksomhet VALUES (191, '844838677', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844838677', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.215899', '2023-08-22 09:38:01.215899');
INSERT INTO public.virksomhet VALUES (192, '879427551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879427551', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.219194', '2023-08-22 09:38:01.219194');
INSERT INTO public.virksomhet VALUES (193, '852588360', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852588360', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.222806', '2023-08-22 09:38:01.222806');
INSERT INTO public.virksomhet VALUES (194, '850788100', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850788100', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.225879', '2023-08-22 09:38:01.225879');
INSERT INTO public.virksomhet VALUES (195, '886885659', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886885659', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.228459', '2023-08-22 09:38:01.228459');
INSERT INTO public.virksomhet VALUES (196, '876531713', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876531713', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.231322', '2023-08-22 09:38:01.231322');
INSERT INTO public.virksomhet VALUES (197, '838695007', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838695007', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.234278', '2023-08-22 09:38:01.234278');
INSERT INTO public.virksomhet VALUES (198, '834220116', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834220116', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.23711', '2023-08-22 09:38:01.23711');
INSERT INTO public.virksomhet VALUES (199, '898760777', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898760777', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.241744', '2023-08-22 09:38:01.241744');
INSERT INTO public.virksomhet VALUES (200, '817639962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817639962', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.244602', '2023-08-22 09:38:01.244602');
INSERT INTO public.virksomhet VALUES (201, '873543315', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873543315', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.247378', '2023-08-22 09:38:01.247378');
INSERT INTO public.virksomhet VALUES (202, '826698611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826698611', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.251115', '2023-08-22 09:38:01.251115');
INSERT INTO public.virksomhet VALUES (203, '841347020', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841347020', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.254064', '2023-08-22 09:38:01.254064');
INSERT INTO public.virksomhet VALUES (204, '851112680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851112680', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.258096', '2023-08-22 09:38:01.258096');
INSERT INTO public.virksomhet VALUES (205, '827402806', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827402806', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.260783', '2023-08-22 09:38:01.260783');
INSERT INTO public.virksomhet VALUES (206, '897795909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897795909', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.263201', '2023-08-22 09:38:01.263201');
INSERT INTO public.virksomhet VALUES (207, '881649081', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881649081', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.266049', '2023-08-22 09:38:01.266049');
INSERT INTO public.virksomhet VALUES (208, '869649338', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869649338', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.269241', '2023-08-22 09:38:01.269241');
INSERT INTO public.virksomhet VALUES (209, '882363737', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882363737', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.272915', '2023-08-22 09:38:01.272915');
INSERT INTO public.virksomhet VALUES (210, '852281546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852281546', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.275924', '2023-08-22 09:38:01.275924');
INSERT INTO public.virksomhet VALUES (211, '868945238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868945238', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.278509', '2023-08-22 09:38:01.278509');
INSERT INTO public.virksomhet VALUES (212, '868130071', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868130071', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.280782', '2023-08-22 09:38:01.280782');
INSERT INTO public.virksomhet VALUES (213, '891695786', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891695786', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.283215', '2023-08-22 09:38:01.283215');
INSERT INTO public.virksomhet VALUES (214, '825688329', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825688329', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.285708', '2023-08-22 09:38:01.285708');
INSERT INTO public.virksomhet VALUES (215, '873346078', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873346078', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.288863', '2023-08-22 09:38:01.288863');
INSERT INTO public.virksomhet VALUES (216, '855571872', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855571872', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.291537', '2023-08-22 09:38:01.291537');
INSERT INTO public.virksomhet VALUES (217, '842497026', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842497026', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.29405', '2023-08-22 09:38:01.29405');
INSERT INTO public.virksomhet VALUES (218, '892859837', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892859837', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.296308', '2023-08-22 09:38:01.296308');
INSERT INTO public.virksomhet VALUES (219, '844168925', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844168925', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.298781', '2023-08-22 09:38:01.298781');
INSERT INTO public.virksomhet VALUES (220, '844840716', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844840716', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.301594', '2023-08-22 09:38:01.301594');
INSERT INTO public.virksomhet VALUES (221, '837151949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837151949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.304423', '2023-08-22 09:38:01.304423');
INSERT INTO public.virksomhet VALUES (222, '888797844', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888797844', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.30838', '2023-08-22 09:38:01.30838');
INSERT INTO public.virksomhet VALUES (223, '838119992', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838119992', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.311045', '2023-08-22 09:38:01.311045');
INSERT INTO public.virksomhet VALUES (224, '824058909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824058909', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.313616', '2023-08-22 09:38:01.313616');
INSERT INTO public.virksomhet VALUES (225, '858060161', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858060161', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.316843', '2023-08-22 09:38:01.316843');
INSERT INTO public.virksomhet VALUES (226, '817113974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817113974', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.319757', '2023-08-22 09:38:01.319757');
INSERT INTO public.virksomhet VALUES (227, '896792641', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896792641', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.323406', '2023-08-22 09:38:01.323406');
INSERT INTO public.virksomhet VALUES (228, '882919181', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882919181', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.326068', '2023-08-22 09:38:01.326068');
INSERT INTO public.virksomhet VALUES (229, '834980687', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834980687', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.328695', '2023-08-22 09:38:01.328695');
INSERT INTO public.virksomhet VALUES (230, '883070774', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883070774', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.331309', '2023-08-22 09:38:01.331309');
INSERT INTO public.virksomhet VALUES (231, '852015835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852015835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.334342', '2023-08-22 09:38:01.334342');
INSERT INTO public.virksomhet VALUES (232, '848941760', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848941760', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.337098', '2023-08-22 09:38:01.337098');
INSERT INTO public.virksomhet VALUES (233, '822902914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822902914', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.341185', '2023-08-22 09:38:01.341185');
INSERT INTO public.virksomhet VALUES (234, '832247705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832247705', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.346263', '2023-08-22 09:38:01.346263');
INSERT INTO public.virksomhet VALUES (235, '882116682', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882116682', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.349443', '2023-08-22 09:38:01.349443');
INSERT INTO public.virksomhet VALUES (236, '802107269', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802107269', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.352658', '2023-08-22 09:38:01.352658');
INSERT INTO public.virksomhet VALUES (237, '846973089', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846973089', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.355997', '2023-08-22 09:38:01.355997');
INSERT INTO public.virksomhet VALUES (238, '864521767', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864521767', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.358787', '2023-08-22 09:38:01.358787');
INSERT INTO public.virksomhet VALUES (239, '876207858', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876207858', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.361513', '2023-08-22 09:38:01.361513');
INSERT INTO public.virksomhet VALUES (240, '851863078', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851863078', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.364047', '2023-08-22 09:38:01.364047');
INSERT INTO public.virksomhet VALUES (241, '820130534', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820130534', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.366613', '2023-08-22 09:38:01.366613');
INSERT INTO public.virksomhet VALUES (242, '894547365', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894547365', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.369123', '2023-08-22 09:38:01.369123');
INSERT INTO public.virksomhet VALUES (243, '859881294', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859881294', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.372227', '2023-08-22 09:38:01.372227');
INSERT INTO public.virksomhet VALUES (244, '844421359', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844421359', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.375305', '2023-08-22 09:38:01.375305');
INSERT INTO public.virksomhet VALUES (245, '819951285', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819951285', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.37851', '2023-08-22 09:38:01.37851');
INSERT INTO public.virksomhet VALUES (246, '887136551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887136551', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.38153', '2023-08-22 09:38:01.38153');
INSERT INTO public.virksomhet VALUES (247, '871948973', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871948973', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.385584', '2023-08-22 09:38:01.385584');
INSERT INTO public.virksomhet VALUES (248, '828558357', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828558357', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.388838', '2023-08-22 09:38:01.388838');
INSERT INTO public.virksomhet VALUES (249, '877775223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877775223', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.392569', '2023-08-22 09:38:01.392569');
INSERT INTO public.virksomhet VALUES (250, '899869668', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899869668', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.396453', '2023-08-22 09:38:01.396453');
INSERT INTO public.virksomhet VALUES (251, '809075924', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809075924', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.399694', '2023-08-22 09:38:01.399694');
INSERT INTO public.virksomhet VALUES (252, '899323316', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899323316', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.402125', '2023-08-22 09:38:01.402125');
INSERT INTO public.virksomhet VALUES (253, '803918384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803918384', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.405102', '2023-08-22 09:38:01.405102');
INSERT INTO public.virksomhet VALUES (254, '852164497', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852164497', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.408336', '2023-08-22 09:38:01.408336');
INSERT INTO public.virksomhet VALUES (255, '838184629', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838184629', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.410959', '2023-08-22 09:38:01.410959');
INSERT INTO public.virksomhet VALUES (256, '801125331', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801125331', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.414873', '2023-08-22 09:38:01.414873');
INSERT INTO public.virksomhet VALUES (257, '894607636', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894607636', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.41849', '2023-08-22 09:38:01.41849');
INSERT INTO public.virksomhet VALUES (258, '832830623', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832830623', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.421282', '2023-08-22 09:38:01.421282');
INSERT INTO public.virksomhet VALUES (259, '865596169', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865596169', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.424584', '2023-08-22 09:38:01.424584');
INSERT INTO public.virksomhet VALUES (260, '867396430', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867396430', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.427454', '2023-08-22 09:38:01.427454');
INSERT INTO public.virksomhet VALUES (261, '870249548', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870249548', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.429764', '2023-08-22 09:38:01.429764');
INSERT INTO public.virksomhet VALUES (262, '882495037', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882495037', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.432188', '2023-08-22 09:38:01.432188');
INSERT INTO public.virksomhet VALUES (263, '813457886', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813457886', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.43486', '2023-08-22 09:38:01.43486');
INSERT INTO public.virksomhet VALUES (264, '887694884', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887694884', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.437342', '2023-08-22 09:38:01.437342');
INSERT INTO public.virksomhet VALUES (265, '812928401', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812928401', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.440751', '2023-08-22 09:38:01.440751');
INSERT INTO public.virksomhet VALUES (266, '864000437', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864000437', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.443056', '2023-08-22 09:38:01.443056');
INSERT INTO public.virksomhet VALUES (267, '807493576', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807493576', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.445461', '2023-08-22 09:38:01.445461');
INSERT INTO public.virksomhet VALUES (268, '848550258', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848550258', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.44804', '2023-08-22 09:38:01.44804');
INSERT INTO public.virksomhet VALUES (269, '883655830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883655830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.450893', '2023-08-22 09:38:01.450893');
INSERT INTO public.virksomhet VALUES (270, '868241232', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868241232', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.45356', '2023-08-22 09:38:01.45356');
INSERT INTO public.virksomhet VALUES (271, '838173343', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838173343', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.456848', '2023-08-22 09:38:01.456848');
INSERT INTO public.virksomhet VALUES (272, '843899976', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843899976', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.459742', '2023-08-22 09:38:01.459742');
INSERT INTO public.virksomhet VALUES (273, '834501836', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834501836', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.462288', '2023-08-22 09:38:01.462288');
INSERT INTO public.virksomhet VALUES (274, '853773843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853773843', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.464724', '2023-08-22 09:38:01.464724');
INSERT INTO public.virksomhet VALUES (275, '838600216', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838600216', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.467596', '2023-08-22 09:38:01.467596');
INSERT INTO public.virksomhet VALUES (276, '865978885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865978885', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.470132', '2023-08-22 09:38:01.470132');
INSERT INTO public.virksomhet VALUES (277, '809387186', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809387186', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.473398', '2023-08-22 09:38:01.473398');
INSERT INTO public.virksomhet VALUES (278, '866320682', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866320682', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.475783', '2023-08-22 09:38:01.475783');
INSERT INTO public.virksomhet VALUES (279, '846920550', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846920550', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.478389', '2023-08-22 09:38:01.478389');
INSERT INTO public.virksomhet VALUES (280, '800313316', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800313316', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.480721', '2023-08-22 09:38:01.480721');
INSERT INTO public.virksomhet VALUES (281, '823018348', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823018348', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.483162', '2023-08-22 09:38:01.483162');
INSERT INTO public.virksomhet VALUES (282, '868329884', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868329884', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.485515', '2023-08-22 09:38:01.485515');
INSERT INTO public.virksomhet VALUES (283, '816305744', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816305744', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.487801', '2023-08-22 09:38:01.487801');
INSERT INTO public.virksomhet VALUES (284, '833233885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833233885', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.49028', '2023-08-22 09:38:01.49028');
INSERT INTO public.virksomhet VALUES (285, '894003194', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894003194', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.49257', '2023-08-22 09:38:01.49257');
INSERT INTO public.virksomhet VALUES (286, '837604524', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837604524', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.494813', '2023-08-22 09:38:01.494813');
INSERT INTO public.virksomhet VALUES (287, '856528107', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856528107', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.497463', '2023-08-22 09:38:01.497463');
INSERT INTO public.virksomhet VALUES (288, '819118508', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819118508', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.500067', '2023-08-22 09:38:01.500067');
INSERT INTO public.virksomhet VALUES (289, '872433394', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872433394', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.502639', '2023-08-22 09:38:01.502639');
INSERT INTO public.virksomhet VALUES (290, '808752793', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808752793', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.505469', '2023-08-22 09:38:01.505469');
INSERT INTO public.virksomhet VALUES (291, '890918442', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890918442', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.508241', '2023-08-22 09:38:01.508241');
INSERT INTO public.virksomhet VALUES (292, '823701847', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823701847', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.510851', '2023-08-22 09:38:01.510851');
INSERT INTO public.virksomhet VALUES (293, '890553994', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890553994', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.51358', '2023-08-22 09:38:01.51358');
INSERT INTO public.virksomhet VALUES (294, '877147267', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877147267', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.516205', '2023-08-22 09:38:01.516205');
INSERT INTO public.virksomhet VALUES (295, '882140440', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882140440', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.519016', '2023-08-22 09:38:01.519016');
INSERT INTO public.virksomhet VALUES (296, '866079795', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866079795', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.522835', '2023-08-22 09:38:01.522835');
INSERT INTO public.virksomhet VALUES (297, '898670143', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898670143', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.526084', '2023-08-22 09:38:01.526084');
INSERT INTO public.virksomhet VALUES (298, '847521107', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847521107', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.528603', '2023-08-22 09:38:01.528603');
INSERT INTO public.virksomhet VALUES (299, '805730956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805730956', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.530952', '2023-08-22 09:38:01.530952');
INSERT INTO public.virksomhet VALUES (300, '827112352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827112352', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.533408', '2023-08-22 09:38:01.533408');
INSERT INTO public.virksomhet VALUES (301, '816675961', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816675961', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.535902', '2023-08-22 09:38:01.535902');
INSERT INTO public.virksomhet VALUES (302, '809638937', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809638937', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.538421', '2023-08-22 09:38:01.538421');
INSERT INTO public.virksomhet VALUES (303, '863177301', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863177301', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.541313', '2023-08-22 09:38:01.541313');
INSERT INTO public.virksomhet VALUES (304, '803140852', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803140852', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.543578', '2023-08-22 09:38:01.543578');
INSERT INTO public.virksomhet VALUES (305, '817420715', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817420715', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.545893', '2023-08-22 09:38:01.545893');
INSERT INTO public.virksomhet VALUES (306, '813717314', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813717314', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.548643', '2023-08-22 09:38:01.548643');
INSERT INTO public.virksomhet VALUES (307, '805132598', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805132598', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.551327', '2023-08-22 09:38:01.551327');
INSERT INTO public.virksomhet VALUES (308, '870203996', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870203996', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.553801', '2023-08-22 09:38:01.553801');
INSERT INTO public.virksomhet VALUES (309, '821166157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821166157', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.556967', '2023-08-22 09:38:01.556967');
INSERT INTO public.virksomhet VALUES (310, '867550566', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867550566', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.559721', '2023-08-22 09:38:01.559721');
INSERT INTO public.virksomhet VALUES (311, '847112310', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847112310', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.561978', '2023-08-22 09:38:01.561978');
INSERT INTO public.virksomhet VALUES (312, '817213081', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817213081', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.564241', '2023-08-22 09:38:01.564241');
INSERT INTO public.virksomhet VALUES (313, '834337604', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834337604', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.566763', '2023-08-22 09:38:01.566763');
INSERT INTO public.virksomhet VALUES (314, '836556691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836556691', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.569327', '2023-08-22 09:38:01.569327');
INSERT INTO public.virksomhet VALUES (315, '846363486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846363486', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.572524', '2023-08-22 09:38:01.572524');
INSERT INTO public.virksomhet VALUES (316, '880468621', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880468621', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.575362', '2023-08-22 09:38:01.575362');
INSERT INTO public.virksomhet VALUES (317, '843130803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843130803', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.577991', '2023-08-22 09:38:01.577991');
INSERT INTO public.virksomhet VALUES (318, '877435097', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877435097', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.580287', '2023-08-22 09:38:01.580287');
INSERT INTO public.virksomhet VALUES (319, '869853760', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869853760', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.582889', '2023-08-22 09:38:01.582889');
INSERT INTO public.virksomhet VALUES (320, '899985690', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899985690', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.585655', '2023-08-22 09:38:01.585655');
INSERT INTO public.virksomhet VALUES (321, '849298231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849298231', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.589514', '2023-08-22 09:38:01.589514');
INSERT INTO public.virksomhet VALUES (322, '875342026', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875342026', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.592711', '2023-08-22 09:38:01.592711');
INSERT INTO public.virksomhet VALUES (323, '814946848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814946848', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.595287', '2023-08-22 09:38:01.595287');
INSERT INTO public.virksomhet VALUES (324, '885751164', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885751164', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.597398', '2023-08-22 09:38:01.597398');
INSERT INTO public.virksomhet VALUES (325, '863988704', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863988704', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.599748', '2023-08-22 09:38:01.599748');
INSERT INTO public.virksomhet VALUES (326, '877946210', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877946210', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.608475', '2023-08-22 09:38:01.608475');
INSERT INTO public.virksomhet VALUES (327, '888422554', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888422554', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.612961', '2023-08-22 09:38:01.612961');
INSERT INTO public.virksomhet VALUES (328, '850536419', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850536419', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.616244', '2023-08-22 09:38:01.616244');
INSERT INTO public.virksomhet VALUES (329, '871739994', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871739994', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.619739', '2023-08-22 09:38:01.619739');
INSERT INTO public.virksomhet VALUES (330, '888243272', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888243272', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.62262', '2023-08-22 09:38:01.62262');
INSERT INTO public.virksomhet VALUES (331, '844563328', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844563328', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.625306', '2023-08-22 09:38:01.625306');
INSERT INTO public.virksomhet VALUES (332, '896798000', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896798000', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.62897', '2023-08-22 09:38:01.62897');
INSERT INTO public.virksomhet VALUES (333, '834493680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834493680', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.632747', '2023-08-22 09:38:01.632747');
INSERT INTO public.virksomhet VALUES (334, '880975000', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880975000', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.63533', '2023-08-22 09:38:01.63533');
INSERT INTO public.virksomhet VALUES (335, '891739945', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891739945', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.637989', '2023-08-22 09:38:01.637989');
INSERT INTO public.virksomhet VALUES (336, '873468702', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873468702', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.641647', '2023-08-22 09:38:01.641647');
INSERT INTO public.virksomhet VALUES (337, '886768356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886768356', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.644646', '2023-08-22 09:38:01.644646');
INSERT INTO public.virksomhet VALUES (338, '889521982', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889521982', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.647018', '2023-08-22 09:38:01.647018');
INSERT INTO public.virksomhet VALUES (339, '811700635', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811700635', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.64986', '2023-08-22 09:38:01.64986');
INSERT INTO public.virksomhet VALUES (340, '899208586', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899208586', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.652569', '2023-08-22 09:38:01.652569');
INSERT INTO public.virksomhet VALUES (341, '841135274', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841135274', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.655382', '2023-08-22 09:38:01.655382');
INSERT INTO public.virksomhet VALUES (342, '888077057', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888077057', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.658153', '2023-08-22 09:38:01.658153');
INSERT INTO public.virksomhet VALUES (343, '853721121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853721121', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.660693', '2023-08-22 09:38:01.660693');
INSERT INTO public.virksomhet VALUES (344, '858401466', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858401466', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.663282', '2023-08-22 09:38:01.663282');
INSERT INTO public.virksomhet VALUES (345, '843465993', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843465993', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.665919', '2023-08-22 09:38:01.665919');
INSERT INTO public.virksomhet VALUES (346, '885825004', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885825004', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.668881', '2023-08-22 09:38:01.668881');
INSERT INTO public.virksomhet VALUES (347, '804570885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804570885', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.671818', '2023-08-22 09:38:01.671818');
INSERT INTO public.virksomhet VALUES (348, '835688408', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835688408', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.674757', '2023-08-22 09:38:01.674757');
INSERT INTO public.virksomhet VALUES (349, '826868461', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826868461', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.677357', '2023-08-22 09:38:01.677357');
INSERT INTO public.virksomhet VALUES (350, '883284079', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883284079', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.680037', '2023-08-22 09:38:01.680037');
INSERT INTO public.virksomhet VALUES (351, '866282763', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866282763', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.682953', '2023-08-22 09:38:01.682953');
INSERT INTO public.virksomhet VALUES (352, '831207270', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831207270', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.685991', '2023-08-22 09:38:01.685991');
INSERT INTO public.virksomhet VALUES (353, '802454382', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802454382', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.689135', '2023-08-22 09:38:01.689135');
INSERT INTO public.virksomhet VALUES (354, '895516204', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895516204', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.691827', '2023-08-22 09:38:01.691827');
INSERT INTO public.virksomhet VALUES (355, '809387257', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809387257', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.694328', '2023-08-22 09:38:01.694328');
INSERT INTO public.virksomhet VALUES (356, '806667009', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806667009', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.696857', '2023-08-22 09:38:01.696857');
INSERT INTO public.virksomhet VALUES (357, '832374160', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832374160', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.699763', '2023-08-22 09:38:01.699763');
INSERT INTO public.virksomhet VALUES (358, '883019749', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883019749', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.7025', '2023-08-22 09:38:01.7025');
INSERT INTO public.virksomhet VALUES (359, '834786438', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834786438', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.706225', '2023-08-22 09:38:01.706225');
INSERT INTO public.virksomhet VALUES (360, '853515144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853515144', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.709264', '2023-08-22 09:38:01.709264');
INSERT INTO public.virksomhet VALUES (361, '846753798', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846753798', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.711897', '2023-08-22 09:38:01.711897');
INSERT INTO public.virksomhet VALUES (362, '848426920', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848426920', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.714791', '2023-08-22 09:38:01.714791');
INSERT INTO public.virksomhet VALUES (363, '815576107', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815576107', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.717855', '2023-08-22 09:38:01.717855');
INSERT INTO public.virksomhet VALUES (364, '821549476', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821549476', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.720569', '2023-08-22 09:38:01.720569');
INSERT INTO public.virksomhet VALUES (365, '864289727', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864289727', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.724245', '2023-08-22 09:38:01.724245');
INSERT INTO public.virksomhet VALUES (366, '881215018', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881215018', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.727107', '2023-08-22 09:38:01.727107');
INSERT INTO public.virksomhet VALUES (367, '849154503', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849154503', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.729791', '2023-08-22 09:38:01.729791');
INSERT INTO public.virksomhet VALUES (368, '881674037', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881674037', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.732638', '2023-08-22 09:38:01.732638');
INSERT INTO public.virksomhet VALUES (369, '869536069', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869536069', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.735952', '2023-08-22 09:38:01.735952');
INSERT INTO public.virksomhet VALUES (370, '828365404', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828365404', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.739425', '2023-08-22 09:38:01.739425');
INSERT INTO public.virksomhet VALUES (371, '875751238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875751238', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.742238', '2023-08-22 09:38:01.742238');
INSERT INTO public.virksomhet VALUES (372, '832012047', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832012047', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.74493', '2023-08-22 09:38:01.74493');
INSERT INTO public.virksomhet VALUES (373, '897744919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897744919', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.747478', '2023-08-22 09:38:01.747478');
INSERT INTO public.virksomhet VALUES (374, '846442703', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846442703', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.750803', '2023-08-22 09:38:01.750803');
INSERT INTO public.virksomhet VALUES (375, '846073105', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846073105', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.753672', '2023-08-22 09:38:01.753672');
INSERT INTO public.virksomhet VALUES (376, '813477912', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813477912', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.757776', '2023-08-22 09:38:01.757776');
INSERT INTO public.virksomhet VALUES (377, '821023298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821023298', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.760932', '2023-08-22 09:38:01.760932');
INSERT INTO public.virksomhet VALUES (378, '871027853', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871027853', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.763734', '2023-08-22 09:38:01.763734');
INSERT INTO public.virksomhet VALUES (379, '837899275', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837899275', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.767544', '2023-08-22 09:38:01.767544');
INSERT INTO public.virksomhet VALUES (380, '839983895', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839983895', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.773006', '2023-08-22 09:38:01.773006');
INSERT INTO public.virksomhet VALUES (381, '887074481', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887074481', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.775961', '2023-08-22 09:38:01.775961');
INSERT INTO public.virksomhet VALUES (382, '839387187', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839387187', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.778748', '2023-08-22 09:38:01.778748');
INSERT INTO public.virksomhet VALUES (383, '811866255', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811866255', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.781823', '2023-08-22 09:38:01.781823');
INSERT INTO public.virksomhet VALUES (384, '845039819', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845039819', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.784628', '2023-08-22 09:38:01.784628');
INSERT INTO public.virksomhet VALUES (385, '838256772', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838256772', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.787828', '2023-08-22 09:38:01.787828');
INSERT INTO public.virksomhet VALUES (386, '811530068', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811530068', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.791522', '2023-08-22 09:38:01.791522');
INSERT INTO public.virksomhet VALUES (387, '824231431', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824231431', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.794532', '2023-08-22 09:38:01.794532');
INSERT INTO public.virksomhet VALUES (388, '854883634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854883634', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.797581', '2023-08-22 09:38:01.797581');
INSERT INTO public.virksomhet VALUES (389, '891683605', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891683605', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.800513', '2023-08-22 09:38:01.800513');
INSERT INTO public.virksomhet VALUES (390, '817692705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817692705', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.803342', '2023-08-22 09:38:01.803342');
INSERT INTO public.virksomhet VALUES (391, '825648278', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825648278', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.806841', '2023-08-22 09:38:01.806841');
INSERT INTO public.virksomhet VALUES (392, '822072121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822072121', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.809566', '2023-08-22 09:38:01.809566');
INSERT INTO public.virksomhet VALUES (393, '891795852', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891795852', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.812026', '2023-08-22 09:38:01.812026');
INSERT INTO public.virksomhet VALUES (394, '886715933', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886715933', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.814482', '2023-08-22 09:38:01.814482');
INSERT INTO public.virksomhet VALUES (395, '837527242', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837527242', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.817169', '2023-08-22 09:38:01.817169');
INSERT INTO public.virksomhet VALUES (396, '887509502', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887509502', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.820116', '2023-08-22 09:38:01.820116');
INSERT INTO public.virksomhet VALUES (397, '806643602', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806643602', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.823202', '2023-08-22 09:38:01.823202');
INSERT INTO public.virksomhet VALUES (398, '860128386', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860128386', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.825737', '2023-08-22 09:38:01.825737');
INSERT INTO public.virksomhet VALUES (399, '868540232', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868540232', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.828213', '2023-08-22 09:38:01.828213');
INSERT INTO public.virksomhet VALUES (400, '828233887', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828233887', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.830719', '2023-08-22 09:38:01.830719');
INSERT INTO public.virksomhet VALUES (401, '876650080', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876650080', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.83345', '2023-08-22 09:38:01.83345');
INSERT INTO public.virksomhet VALUES (402, '882268990', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882268990', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.836007', '2023-08-22 09:38:01.836007');
INSERT INTO public.virksomhet VALUES (403, '865065037', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865065037', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.839752', '2023-08-22 09:38:01.839752');
INSERT INTO public.virksomhet VALUES (404, '898723823', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898723823', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.842452', '2023-08-22 09:38:01.842452');
INSERT INTO public.virksomhet VALUES (405, '881585147', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881585147', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.84791', '2023-08-22 09:38:01.84791');
INSERT INTO public.virksomhet VALUES (406, '812154207', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812154207', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.850832', '2023-08-22 09:38:01.850832');
INSERT INTO public.virksomhet VALUES (407, '854476118', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854476118', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.8537', '2023-08-22 09:38:01.8537');
INSERT INTO public.virksomhet VALUES (408, '842357468', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842357468', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.857073', '2023-08-22 09:38:01.857073');
INSERT INTO public.virksomhet VALUES (409, '899607715', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899607715', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.860258', '2023-08-22 09:38:01.860258');
INSERT INTO public.virksomhet VALUES (410, '881934239', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881934239', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.862644', '2023-08-22 09:38:01.862644');
INSERT INTO public.virksomhet VALUES (411, '826069364', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826069364', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.865066', '2023-08-22 09:38:01.865066');
INSERT INTO public.virksomhet VALUES (412, '838438101', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838438101', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.867766', '2023-08-22 09:38:01.867766');
INSERT INTO public.virksomhet VALUES (413, '807312765', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807312765', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.870214', '2023-08-22 09:38:01.870214');
INSERT INTO public.virksomhet VALUES (414, '815506850', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815506850', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.872826', '2023-08-22 09:38:01.872826');
INSERT INTO public.virksomhet VALUES (415, '860169462', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860169462', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.875303', '2023-08-22 09:38:01.875303');
INSERT INTO public.virksomhet VALUES (416, '811283959', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811283959', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.877816', '2023-08-22 09:38:01.877816');
INSERT INTO public.virksomhet VALUES (417, '851251150', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851251150', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.880296', '2023-08-22 09:38:01.880296');
INSERT INTO public.virksomhet VALUES (418, '811375581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811375581', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.882727', '2023-08-22 09:38:01.882727');
INSERT INTO public.virksomhet VALUES (419, '807563163', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807563163', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.885182', '2023-08-22 09:38:01.885182');
INSERT INTO public.virksomhet VALUES (420, '892139138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892139138', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.888036', '2023-08-22 09:38:01.888036');
INSERT INTO public.virksomhet VALUES (421, '806180143', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806180143', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.890959', '2023-08-22 09:38:01.890959');
INSERT INTO public.virksomhet VALUES (422, '857528776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857528776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.893757', '2023-08-22 09:38:01.893757');
INSERT INTO public.virksomhet VALUES (423, '809175337', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809175337', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.896876', '2023-08-22 09:38:01.896876');
INSERT INTO public.virksomhet VALUES (424, '858613497', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858613497', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.90176', '2023-08-22 09:38:01.90176');
INSERT INTO public.virksomhet VALUES (425, '863004312', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863004312', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.906017', '2023-08-22 09:38:01.906017');
INSERT INTO public.virksomhet VALUES (426, '851277645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851277645', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.909078', '2023-08-22 09:38:01.909078');
INSERT INTO public.virksomhet VALUES (427, '824590590', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824590590', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.9117', '2023-08-22 09:38:01.9117');
INSERT INTO public.virksomhet VALUES (428, '813048431', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813048431', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.914595', '2023-08-22 09:38:01.914595');
INSERT INTO public.virksomhet VALUES (429, '811686406', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811686406', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.917217', '2023-08-22 09:38:01.917217');
INSERT INTO public.virksomhet VALUES (430, '819766970', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819766970', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.921083', '2023-08-22 09:38:01.921083');
INSERT INTO public.virksomhet VALUES (431, '807328561', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807328561', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.924761', '2023-08-22 09:38:01.924761');
INSERT INTO public.virksomhet VALUES (432, '894901869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894901869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.927518', '2023-08-22 09:38:01.927518');
INSERT INTO public.virksomhet VALUES (433, '859386741', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859386741', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.930306', '2023-08-22 09:38:01.930306');
INSERT INTO public.virksomhet VALUES (434, '892071614', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892071614', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.934108', '2023-08-22 09:38:01.934108');
INSERT INTO public.virksomhet VALUES (435, '832870175', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832870175', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.937557', '2023-08-22 09:38:01.937557');
INSERT INTO public.virksomhet VALUES (436, '800286644', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800286644', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.942284', '2023-08-22 09:38:01.942284');
INSERT INTO public.virksomhet VALUES (437, '825426984', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825426984', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.945142', '2023-08-22 09:38:01.945142');
INSERT INTO public.virksomhet VALUES (438, '853766006', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853766006', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.94773', '2023-08-22 09:38:01.94773');
INSERT INTO public.virksomhet VALUES (439, '854997008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854997008', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.951137', '2023-08-22 09:38:01.951137');
INSERT INTO public.virksomhet VALUES (440, '812886264', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812886264', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.953549', '2023-08-22 09:38:01.953549');
INSERT INTO public.virksomhet VALUES (441, '884295332', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884295332', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.956598', '2023-08-22 09:38:01.956598');
INSERT INTO public.virksomhet VALUES (442, '810124461', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810124461', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.959161', '2023-08-22 09:38:01.959161');
INSERT INTO public.virksomhet VALUES (443, '834935011', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834935011', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.961778', '2023-08-22 09:38:01.961778');
INSERT INTO public.virksomhet VALUES (444, '807149274', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807149274', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.964297', '2023-08-22 09:38:01.964297');
INSERT INTO public.virksomhet VALUES (445, '854695094', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854695094', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.96727', '2023-08-22 09:38:01.96727');
INSERT INTO public.virksomhet VALUES (446, '845210969', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845210969', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.969794', '2023-08-22 09:38:01.969794');
INSERT INTO public.virksomhet VALUES (447, '869325590', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869325590', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.973084', '2023-08-22 09:38:01.973084');
INSERT INTO public.virksomhet VALUES (448, '871813139', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871813139', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.975971', '2023-08-22 09:38:01.975971');
INSERT INTO public.virksomhet VALUES (449, '833231510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833231510', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.978886', '2023-08-22 09:38:01.978886');
INSERT INTO public.virksomhet VALUES (450, '805879875', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805879875', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.981713', '2023-08-22 09:38:01.981713');
INSERT INTO public.virksomhet VALUES (451, '888143042', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888143042', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.984736', '2023-08-22 09:38:01.984736');
INSERT INTO public.virksomhet VALUES (452, '851539726', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851539726', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.989334', '2023-08-22 09:38:01.989334');
INSERT INTO public.virksomhet VALUES (453, '850079442', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850079442', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.993251', '2023-08-22 09:38:01.993251');
INSERT INTO public.virksomhet VALUES (454, '810538212', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810538212', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:01.99784', '2023-08-22 09:38:01.99784');
INSERT INTO public.virksomhet VALUES (455, '873092002', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873092002', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.00383', '2023-08-22 09:38:02.00383');
INSERT INTO public.virksomhet VALUES (456, '801692952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801692952', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.008402', '2023-08-22 09:38:02.008402');
INSERT INTO public.virksomhet VALUES (457, '802390487', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802390487', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.012459', '2023-08-22 09:38:02.012459');
INSERT INTO public.virksomhet VALUES (458, '836739362', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836739362', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.016691', '2023-08-22 09:38:02.016691');
INSERT INTO public.virksomhet VALUES (459, '880840776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880840776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.021911', '2023-08-22 09:38:02.021911');
INSERT INTO public.virksomhet VALUES (460, '880695479', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880695479', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.025816', '2023-08-22 09:38:02.025816');
INSERT INTO public.virksomhet VALUES (461, '848667205', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848667205', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.029887', '2023-08-22 09:38:02.029887');
INSERT INTO public.virksomhet VALUES (462, '888964420', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888964420', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.0327', '2023-08-22 09:38:02.0327');
INSERT INTO public.virksomhet VALUES (463, '857973308', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857973308', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.035405', '2023-08-22 09:38:02.035405');
INSERT INTO public.virksomhet VALUES (464, '867639615', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867639615', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.037896', '2023-08-22 09:38:02.037896');
INSERT INTO public.virksomhet VALUES (465, '847465324', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847465324', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.041291', '2023-08-22 09:38:02.041291');
INSERT INTO public.virksomhet VALUES (466, '809138406', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809138406', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.043401', '2023-08-22 09:38:02.043401');
INSERT INTO public.virksomhet VALUES (467, '877543601', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877543601', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.04572', '2023-08-22 09:38:02.04572');
INSERT INTO public.virksomhet VALUES (468, '806766681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806766681', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.048037', '2023-08-22 09:38:02.048037');
INSERT INTO public.virksomhet VALUES (469, '832630464', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832630464', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.050875', '2023-08-22 09:38:02.050875');
INSERT INTO public.virksomhet VALUES (470, '847297952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847297952', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.053176', '2023-08-22 09:38:02.053176');
INSERT INTO public.virksomhet VALUES (471, '857028099', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857028099', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.056289', '2023-08-22 09:38:02.056289');
INSERT INTO public.virksomhet VALUES (472, '836482812', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836482812', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.059032', '2023-08-22 09:38:02.059032');
INSERT INTO public.virksomhet VALUES (473, '864369313', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864369313', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.061732', '2023-08-22 09:38:02.061732');
INSERT INTO public.virksomhet VALUES (474, '894282061', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894282061', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.064164', '2023-08-22 09:38:02.064164');
INSERT INTO public.virksomhet VALUES (475, '889075473', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889075473', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.066926', '2023-08-22 09:38:02.066926');
INSERT INTO public.virksomhet VALUES (476, '857951498', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857951498', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.069608', '2023-08-22 09:38:02.069608');
INSERT INTO public.virksomhet VALUES (477, '883166293', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883166293', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.072532', '2023-08-22 09:38:02.072532');
INSERT INTO public.virksomhet VALUES (478, '807831211', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807831211', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.074796', '2023-08-22 09:38:02.074796');
INSERT INTO public.virksomhet VALUES (479, '825304441', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825304441', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.077024', '2023-08-22 09:38:02.077024');
INSERT INTO public.virksomhet VALUES (480, '808236409', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808236409', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.079093', '2023-08-22 09:38:02.079093');
INSERT INTO public.virksomhet VALUES (481, '883829150', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883829150', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.081379', '2023-08-22 09:38:02.081379');
INSERT INTO public.virksomhet VALUES (482, '885167866', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885167866', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.084096', '2023-08-22 09:38:02.084096');
INSERT INTO public.virksomhet VALUES (483, '898161453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898161453', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.086472', '2023-08-22 09:38:02.086472');
INSERT INTO public.virksomhet VALUES (484, '869219583', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869219583', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.08978', '2023-08-22 09:38:02.08978');
INSERT INTO public.virksomhet VALUES (485, '838709938', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838709938', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.092164', '2023-08-22 09:38:02.092164');
INSERT INTO public.virksomhet VALUES (486, '880347757', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880347757', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.094683', '2023-08-22 09:38:02.094683');
INSERT INTO public.virksomhet VALUES (487, '822067638', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822067638', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.097388', '2023-08-22 09:38:02.097388');
INSERT INTO public.virksomhet VALUES (488, '823363719', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823363719', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.100233', '2023-08-22 09:38:02.100233');
INSERT INTO public.virksomhet VALUES (489, '806457946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806457946', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.1029', '2023-08-22 09:38:02.1029');
INSERT INTO public.virksomhet VALUES (490, '853892287', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853892287', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.106411', '2023-08-22 09:38:02.106411');
INSERT INTO public.virksomhet VALUES (491, '840973333', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840973333', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.11653', '2023-08-22 09:38:02.11653');
INSERT INTO public.virksomhet VALUES (492, '866355728', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866355728', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.119786', '2023-08-22 09:38:02.119786');
INSERT INTO public.virksomhet VALUES (493, '875178653', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875178653', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.123964', '2023-08-22 09:38:02.123964');
INSERT INTO public.virksomhet VALUES (494, '860162579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860162579', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.127509', '2023-08-22 09:38:02.127509');
INSERT INTO public.virksomhet VALUES (495, '801591815', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801591815', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.129972', '2023-08-22 09:38:02.129972');
INSERT INTO public.virksomhet VALUES (496, '892846818', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892846818', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.132773', '2023-08-22 09:38:02.132773');
INSERT INTO public.virksomhet VALUES (497, '804493146', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804493146', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.135702', '2023-08-22 09:38:02.135702');
INSERT INTO public.virksomhet VALUES (498, '818961021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818961021', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.138265', '2023-08-22 09:38:02.138265');
INSERT INTO public.virksomhet VALUES (499, '848500382', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848500382', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.145095', '2023-08-22 09:38:02.145095');
INSERT INTO public.virksomhet VALUES (500, '869737117', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869737117', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.153731', '2023-08-22 09:38:02.153731');
INSERT INTO public.virksomhet VALUES (501, '883689945', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883689945', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.157115', '2023-08-22 09:38:02.157115');
INSERT INTO public.virksomhet VALUES (502, '853209498', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853209498', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.159824', '2023-08-22 09:38:02.159824');
INSERT INTO public.virksomhet VALUES (503, '885018093', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885018093', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.162363', '2023-08-22 09:38:02.162363');
INSERT INTO public.virksomhet VALUES (504, '863176447', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863176447', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.165014', '2023-08-22 09:38:02.165014');
INSERT INTO public.virksomhet VALUES (505, '828394729', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828394729', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.167969', '2023-08-22 09:38:02.167969');
INSERT INTO public.virksomhet VALUES (506, '873835986', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873835986', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.170521', '2023-08-22 09:38:02.170521');
INSERT INTO public.virksomhet VALUES (507, '844865841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844865841', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.173988', '2023-08-22 09:38:02.173988');
INSERT INTO public.virksomhet VALUES (508, '871177944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871177944', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.176825', '2023-08-22 09:38:02.176825');
INSERT INTO public.virksomhet VALUES (509, '847752609', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847752609', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.17963', '2023-08-22 09:38:02.17963');
INSERT INTO public.virksomhet VALUES (510, '816190926', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816190926', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:02.182533', '2023-08-22 09:38:02.182533');
INSERT INTO public.virksomhet VALUES (511, '854682607', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854682607', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-08-22 09:38:07.299853', '2023-08-22 09:38:07.299853');
INSERT INTO public.virksomhet VALUES (512, '882017147', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '741710288 nvaN', '{adresse}', 'AKTIV', NULL, 882017148, '2023-08-22 09:38:07.303784', '2023-08-22 09:38:10.49223');
INSERT INTO public.virksomhet VALUES (513, '826361592', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '295163628 nvaN', '{adresse}', 'AKTIV', NULL, 826361593, '2023-08-22 09:38:07.308314', '2023-08-22 09:38:10.516238');
INSERT INTO public.virksomhet VALUES (514, '867891072', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '270198768 nvaN', '{adresse}', 'AKTIV', NULL, 867891073, '2023-08-22 09:38:07.311611', '2023-08-22 09:38:10.529172');
INSERT INTO public.virksomhet VALUES (515, '868038487', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '784830868 nvaN', '{adresse}', 'AKTIV', NULL, 868038488, '2023-08-22 09:38:07.314963', '2023-08-22 09:38:10.537153');
INSERT INTO public.virksomhet VALUES (516, '836581771', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '177185638 nvaN', '{adresse}', 'AKTIV', NULL, 836581772, '2023-08-22 09:38:07.318484', '2023-08-22 09:38:10.575419');
INSERT INTO public.virksomhet VALUES (527, '888126407', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '704621888 nvaN', '{adresse}', 'AKTIV', NULL, 888126408, '2023-08-22 09:38:07.354379', '2023-08-22 09:38:10.609692');
INSERT INTO public.virksomhet VALUES (517, '895255567', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895255567', '{adresse}', 'FJERNET', '2010-07-01', 895255568, '2023-08-22 09:38:07.322759', '2023-08-22 09:38:10.61897');
INSERT INTO public.virksomhet VALUES (518, '877109551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877109551', '{adresse}', 'FJERNET', '2010-07-01', 877109552, '2023-08-22 09:38:07.326088', '2023-08-22 09:38:10.619904');
INSERT INTO public.virksomhet VALUES (519, '867213427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867213427', '{adresse}', 'FJERNET', '2010-07-01', 867213428, '2023-08-22 09:38:07.328768', '2023-08-22 09:38:10.620452');
INSERT INTO public.virksomhet VALUES (520, '870402223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870402223', '{adresse}', 'FJERNET', '2010-07-01', 870402224, '2023-08-22 09:38:07.331846', '2023-08-22 09:38:10.621394');
INSERT INTO public.virksomhet VALUES (521, '821721410', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821721410', '{adresse}', 'FJERNET', '2010-07-01', 821721411, '2023-08-22 09:38:07.335868', '2023-08-22 09:38:10.621781');
INSERT INTO public.virksomhet VALUES (522, '896232122', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896232122', '{adresse}', 'SLETTET', '2010-07-01', 896232123, '2023-08-22 09:38:07.339554', '2023-08-22 09:38:10.622448');
INSERT INTO public.virksomhet VALUES (523, '810726031', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810726031', '{adresse}', 'SLETTET', '2010-07-01', 810726032, '2023-08-22 09:38:07.342863', '2023-08-22 09:38:10.623064');
INSERT INTO public.virksomhet VALUES (524, '808080705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808080705', '{adresse}', 'SLETTET', '2010-07-01', 808080706, '2023-08-22 09:38:07.345636', '2023-08-22 09:38:10.623601');
INSERT INTO public.virksomhet VALUES (525, '860083862', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860083862', '{adresse}', 'SLETTET', '2010-07-01', 860083863, '2023-08-22 09:38:07.348506', '2023-08-22 09:38:10.62479');
INSERT INTO public.virksomhet VALUES (526, '846160762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846160762', '{adresse}', 'SLETTET', '2010-07-01', 846160763, '2023-08-22 09:38:07.351569', '2023-08-22 09:38:10.625126');
INSERT INTO public.virksomhet VALUES (534, '843675911', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843675911', '{adresse}', 'AKTIV', NULL, 843675912, '2023-08-22 09:38:10.62628', '2023-08-22 09:38:10.62628');
INSERT INTO public.virksomhet VALUES (535, '879304789', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879304789', '{adresse}', 'AKTIV', NULL, 879304790, '2023-08-22 09:38:10.628561', '2023-08-22 09:38:10.628561');
INSERT INTO public.virksomhet VALUES (536, '844186327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844186327', '{adresse}', 'AKTIV', NULL, 844186328, '2023-08-22 09:38:10.654329', '2023-08-22 09:38:10.654329');
INSERT INTO public.virksomhet VALUES (537, '809342694', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809342694', '{adresse}', 'AKTIV', NULL, 809342695, '2023-08-22 09:38:10.65814', '2023-08-22 09:38:10.65814');
INSERT INTO public.virksomhet VALUES (538, '874432730', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874432730', '{adresse}', 'AKTIV', NULL, 874432731, '2023-08-22 09:38:10.661902', '2023-08-22 09:38:10.661902');


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
INSERT INTO public.virksomhet_naring VALUES (8, '90.012');
INSERT INTO public.virksomhet_naring VALUES (9, '01.120');
INSERT INTO public.virksomhet_naring VALUES (10, '01.120');
INSERT INTO public.virksomhet_naring VALUES (11, '01.120');
INSERT INTO public.virksomhet_naring VALUES (12, '01.120');
INSERT INTO public.virksomhet_naring VALUES (12, '90.012');
INSERT INTO public.virksomhet_naring VALUES (13, '01.120');
INSERT INTO public.virksomhet_naring VALUES (13, '90.012');
INSERT INTO public.virksomhet_naring VALUES (14, '01.120');
INSERT INTO public.virksomhet_naring VALUES (14, '90.012');
INSERT INTO public.virksomhet_naring VALUES (15, '01.120');
INSERT INTO public.virksomhet_naring VALUES (16, '01.120');
INSERT INTO public.virksomhet_naring VALUES (16, '90.012');
INSERT INTO public.virksomhet_naring VALUES (17, '01.120');
INSERT INTO public.virksomhet_naring VALUES (18, '01.120');
INSERT INTO public.virksomhet_naring VALUES (18, '90.012');
INSERT INTO public.virksomhet_naring VALUES (19, '01.120');
INSERT INTO public.virksomhet_naring VALUES (19, '90.012');
INSERT INTO public.virksomhet_naring VALUES (20, '01.120');
INSERT INTO public.virksomhet_naring VALUES (21, '01.120');
INSERT INTO public.virksomhet_naring VALUES (22, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '01.120');
INSERT INTO public.virksomhet_naring VALUES (24, '01.120');
INSERT INTO public.virksomhet_naring VALUES (25, '01.120');
INSERT INTO public.virksomhet_naring VALUES (26, '01.120');
INSERT INTO public.virksomhet_naring VALUES (27, '01.120');
INSERT INTO public.virksomhet_naring VALUES (27, '90.012');
INSERT INTO public.virksomhet_naring VALUES (28, '01.120');
INSERT INTO public.virksomhet_naring VALUES (28, '90.012');
INSERT INTO public.virksomhet_naring VALUES (29, '01.120');
INSERT INTO public.virksomhet_naring VALUES (30, '01.120');
INSERT INTO public.virksomhet_naring VALUES (31, '01.120');
INSERT INTO public.virksomhet_naring VALUES (31, '90.012');
INSERT INTO public.virksomhet_naring VALUES (32, '01.120');
INSERT INTO public.virksomhet_naring VALUES (32, '90.012');
INSERT INTO public.virksomhet_naring VALUES (32, '70.220');
INSERT INTO public.virksomhet_naring VALUES (33, '01.120');
INSERT INTO public.virksomhet_naring VALUES (33, '90.012');
INSERT INTO public.virksomhet_naring VALUES (34, '01.120');
INSERT INTO public.virksomhet_naring VALUES (34, '90.012');
INSERT INTO public.virksomhet_naring VALUES (35, '01.120');
INSERT INTO public.virksomhet_naring VALUES (35, '90.012');
INSERT INTO public.virksomhet_naring VALUES (35, '70.220');
INSERT INTO public.virksomhet_naring VALUES (36, '01.120');
INSERT INTO public.virksomhet_naring VALUES (37, '01.120');
INSERT INTO public.virksomhet_naring VALUES (38, '01.120');
INSERT INTO public.virksomhet_naring VALUES (39, '01.120');
INSERT INTO public.virksomhet_naring VALUES (40, '01.120');
INSERT INTO public.virksomhet_naring VALUES (40, '90.012');
INSERT INTO public.virksomhet_naring VALUES (41, '01.120');
INSERT INTO public.virksomhet_naring VALUES (41, '90.012');
INSERT INTO public.virksomhet_naring VALUES (41, '70.220');
INSERT INTO public.virksomhet_naring VALUES (42, '01.120');
INSERT INTO public.virksomhet_naring VALUES (43, '01.120');
INSERT INTO public.virksomhet_naring VALUES (43, '90.012');
INSERT INTO public.virksomhet_naring VALUES (44, '01.120');
INSERT INTO public.virksomhet_naring VALUES (45, '01.120');
INSERT INTO public.virksomhet_naring VALUES (46, '01.120');
INSERT INTO public.virksomhet_naring VALUES (46, '90.012');
INSERT INTO public.virksomhet_naring VALUES (47, '01.120');
INSERT INTO public.virksomhet_naring VALUES (47, '90.012');
INSERT INTO public.virksomhet_naring VALUES (47, '70.220');
INSERT INTO public.virksomhet_naring VALUES (48, '01.120');
INSERT INTO public.virksomhet_naring VALUES (48, '90.012');
INSERT INTO public.virksomhet_naring VALUES (49, '01.120');
INSERT INTO public.virksomhet_naring VALUES (49, '90.012');
INSERT INTO public.virksomhet_naring VALUES (50, '01.120');
INSERT INTO public.virksomhet_naring VALUES (51, '01.120');
INSERT INTO public.virksomhet_naring VALUES (51, '90.012');
INSERT INTO public.virksomhet_naring VALUES (51, '70.220');
INSERT INTO public.virksomhet_naring VALUES (52, '01.120');
INSERT INTO public.virksomhet_naring VALUES (53, '01.120');
INSERT INTO public.virksomhet_naring VALUES (53, '90.012');
INSERT INTO public.virksomhet_naring VALUES (54, '01.120');
INSERT INTO public.virksomhet_naring VALUES (55, '01.120');
INSERT INTO public.virksomhet_naring VALUES (55, '90.012');
INSERT INTO public.virksomhet_naring VALUES (56, '01.120');
INSERT INTO public.virksomhet_naring VALUES (56, '90.012');
INSERT INTO public.virksomhet_naring VALUES (57, '01.120');
INSERT INTO public.virksomhet_naring VALUES (57, '90.012');
INSERT INTO public.virksomhet_naring VALUES (58, '01.120');
INSERT INTO public.virksomhet_naring VALUES (58, '90.012');
INSERT INTO public.virksomhet_naring VALUES (58, '70.220');
INSERT INTO public.virksomhet_naring VALUES (59, '01.120');
INSERT INTO public.virksomhet_naring VALUES (59, '90.012');
INSERT INTO public.virksomhet_naring VALUES (59, '70.220');
INSERT INTO public.virksomhet_naring VALUES (60, '01.120');
INSERT INTO public.virksomhet_naring VALUES (61, '01.120');
INSERT INTO public.virksomhet_naring VALUES (62, '01.120');
INSERT INTO public.virksomhet_naring VALUES (62, '90.012');
INSERT INTO public.virksomhet_naring VALUES (62, '70.220');
INSERT INTO public.virksomhet_naring VALUES (63, '01.120');
INSERT INTO public.virksomhet_naring VALUES (63, '90.012');
INSERT INTO public.virksomhet_naring VALUES (63, '70.220');
INSERT INTO public.virksomhet_naring VALUES (64, '01.120');
INSERT INTO public.virksomhet_naring VALUES (65, '01.120');
INSERT INTO public.virksomhet_naring VALUES (66, '01.120');
INSERT INTO public.virksomhet_naring VALUES (67, '01.120');
INSERT INTO public.virksomhet_naring VALUES (67, '90.012');
INSERT INTO public.virksomhet_naring VALUES (68, '01.120');
INSERT INTO public.virksomhet_naring VALUES (68, '90.012');
INSERT INTO public.virksomhet_naring VALUES (69, '01.120');
INSERT INTO public.virksomhet_naring VALUES (69, '90.012');
INSERT INTO public.virksomhet_naring VALUES (70, '01.120');
INSERT INTO public.virksomhet_naring VALUES (71, '01.120');
INSERT INTO public.virksomhet_naring VALUES (72, '01.120');
INSERT INTO public.virksomhet_naring VALUES (73, '01.120');
INSERT INTO public.virksomhet_naring VALUES (74, '01.120');
INSERT INTO public.virksomhet_naring VALUES (74, '90.012');
INSERT INTO public.virksomhet_naring VALUES (75, '01.120');
INSERT INTO public.virksomhet_naring VALUES (75, '90.012');
INSERT INTO public.virksomhet_naring VALUES (75, '70.220');
INSERT INTO public.virksomhet_naring VALUES (76, '01.120');
INSERT INTO public.virksomhet_naring VALUES (77, '01.120');
INSERT INTO public.virksomhet_naring VALUES (78, '01.120');
INSERT INTO public.virksomhet_naring VALUES (79, '01.120');
INSERT INTO public.virksomhet_naring VALUES (79, '90.012');
INSERT INTO public.virksomhet_naring VALUES (79, '70.220');
INSERT INTO public.virksomhet_naring VALUES (80, '01.120');
INSERT INTO public.virksomhet_naring VALUES (81, '01.120');
INSERT INTO public.virksomhet_naring VALUES (82, '01.120');
INSERT INTO public.virksomhet_naring VALUES (82, '90.012');
INSERT INTO public.virksomhet_naring VALUES (83, '01.120');
INSERT INTO public.virksomhet_naring VALUES (84, '01.120');
INSERT INTO public.virksomhet_naring VALUES (85, '01.120');
INSERT INTO public.virksomhet_naring VALUES (85, '90.012');
INSERT INTO public.virksomhet_naring VALUES (85, '70.220');
INSERT INTO public.virksomhet_naring VALUES (86, '01.120');
INSERT INTO public.virksomhet_naring VALUES (87, '01.120');
INSERT INTO public.virksomhet_naring VALUES (87, '90.012');
INSERT INTO public.virksomhet_naring VALUES (88, '01.120');
INSERT INTO public.virksomhet_naring VALUES (88, '90.012');
INSERT INTO public.virksomhet_naring VALUES (89, '01.120');
INSERT INTO public.virksomhet_naring VALUES (89, '90.012');
INSERT INTO public.virksomhet_naring VALUES (90, '01.120');
INSERT INTO public.virksomhet_naring VALUES (91, '01.120');
INSERT INTO public.virksomhet_naring VALUES (91, '90.012');
INSERT INTO public.virksomhet_naring VALUES (92, '01.120');
INSERT INTO public.virksomhet_naring VALUES (92, '90.012');
INSERT INTO public.virksomhet_naring VALUES (92, '70.220');
INSERT INTO public.virksomhet_naring VALUES (93, '01.120');
INSERT INTO public.virksomhet_naring VALUES (94, '01.120');
INSERT INTO public.virksomhet_naring VALUES (95, '01.120');
INSERT INTO public.virksomhet_naring VALUES (95, '90.012');
INSERT INTO public.virksomhet_naring VALUES (95, '70.220');
INSERT INTO public.virksomhet_naring VALUES (96, '01.120');
INSERT INTO public.virksomhet_naring VALUES (96, '90.012');
INSERT INTO public.virksomhet_naring VALUES (97, '01.120');
INSERT INTO public.virksomhet_naring VALUES (97, '90.012');
INSERT INTO public.virksomhet_naring VALUES (98, '01.120');
INSERT INTO public.virksomhet_naring VALUES (99, '01.120');
INSERT INTO public.virksomhet_naring VALUES (99, '90.012');
INSERT INTO public.virksomhet_naring VALUES (100, '01.120');
INSERT INTO public.virksomhet_naring VALUES (100, '90.012');
INSERT INTO public.virksomhet_naring VALUES (101, '01.120');
INSERT INTO public.virksomhet_naring VALUES (102, '01.120');
INSERT INTO public.virksomhet_naring VALUES (103, '01.120');
INSERT INTO public.virksomhet_naring VALUES (104, '01.120');
INSERT INTO public.virksomhet_naring VALUES (105, '01.120');
INSERT INTO public.virksomhet_naring VALUES (105, '90.012');
INSERT INTO public.virksomhet_naring VALUES (106, '01.120');
INSERT INTO public.virksomhet_naring VALUES (107, '01.120');
INSERT INTO public.virksomhet_naring VALUES (108, '01.120');
INSERT INTO public.virksomhet_naring VALUES (108, '90.012');
INSERT INTO public.virksomhet_naring VALUES (109, '01.120');
INSERT INTO public.virksomhet_naring VALUES (109, '90.012');
INSERT INTO public.virksomhet_naring VALUES (110, '01.120');
INSERT INTO public.virksomhet_naring VALUES (110, '90.012');
INSERT INTO public.virksomhet_naring VALUES (110, '70.220');
INSERT INTO public.virksomhet_naring VALUES (111, '01.120');
INSERT INTO public.virksomhet_naring VALUES (112, '01.120');
INSERT INTO public.virksomhet_naring VALUES (113, '01.120');
INSERT INTO public.virksomhet_naring VALUES (114, '01.120');
INSERT INTO public.virksomhet_naring VALUES (114, '90.012');
INSERT INTO public.virksomhet_naring VALUES (115, '01.120');
INSERT INTO public.virksomhet_naring VALUES (116, '01.120');
INSERT INTO public.virksomhet_naring VALUES (117, '01.120');
INSERT INTO public.virksomhet_naring VALUES (118, '01.120');
INSERT INTO public.virksomhet_naring VALUES (118, '90.012');
INSERT INTO public.virksomhet_naring VALUES (119, '01.120');
INSERT INTO public.virksomhet_naring VALUES (119, '90.012');
INSERT INTO public.virksomhet_naring VALUES (120, '01.120');
INSERT INTO public.virksomhet_naring VALUES (120, '90.012');
INSERT INTO public.virksomhet_naring VALUES (120, '70.220');
INSERT INTO public.virksomhet_naring VALUES (121, '01.120');
INSERT INTO public.virksomhet_naring VALUES (122, '01.120');
INSERT INTO public.virksomhet_naring VALUES (123, '01.120');
INSERT INTO public.virksomhet_naring VALUES (124, '01.120');
INSERT INTO public.virksomhet_naring VALUES (125, '01.120');
INSERT INTO public.virksomhet_naring VALUES (126, '01.120');
INSERT INTO public.virksomhet_naring VALUES (127, '01.120');
INSERT INTO public.virksomhet_naring VALUES (127, '90.012');
INSERT INTO public.virksomhet_naring VALUES (128, '01.120');
INSERT INTO public.virksomhet_naring VALUES (129, '01.120');
INSERT INTO public.virksomhet_naring VALUES (129, '90.012');
INSERT INTO public.virksomhet_naring VALUES (129, '70.220');
INSERT INTO public.virksomhet_naring VALUES (130, '01.120');
INSERT INTO public.virksomhet_naring VALUES (130, '90.012');
INSERT INTO public.virksomhet_naring VALUES (130, '70.220');
INSERT INTO public.virksomhet_naring VALUES (131, '01.120');
INSERT INTO public.virksomhet_naring VALUES (131, '90.012');
INSERT INTO public.virksomhet_naring VALUES (132, '01.120');
INSERT INTO public.virksomhet_naring VALUES (132, '90.012');
INSERT INTO public.virksomhet_naring VALUES (133, '01.120');
INSERT INTO public.virksomhet_naring VALUES (134, '01.120');
INSERT INTO public.virksomhet_naring VALUES (135, '01.120');
INSERT INTO public.virksomhet_naring VALUES (135, '90.012');
INSERT INTO public.virksomhet_naring VALUES (135, '70.220');
INSERT INTO public.virksomhet_naring VALUES (136, '01.120');
INSERT INTO public.virksomhet_naring VALUES (136, '90.012');
INSERT INTO public.virksomhet_naring VALUES (137, '01.120');
INSERT INTO public.virksomhet_naring VALUES (137, '90.012');
INSERT INTO public.virksomhet_naring VALUES (138, '01.120');
INSERT INTO public.virksomhet_naring VALUES (139, '01.120');
INSERT INTO public.virksomhet_naring VALUES (139, '90.012');
INSERT INTO public.virksomhet_naring VALUES (140, '01.120');
INSERT INTO public.virksomhet_naring VALUES (140, '90.012');
INSERT INTO public.virksomhet_naring VALUES (140, '70.220');
INSERT INTO public.virksomhet_naring VALUES (141, '01.120');
INSERT INTO public.virksomhet_naring VALUES (142, '01.120');
INSERT INTO public.virksomhet_naring VALUES (143, '01.120');
INSERT INTO public.virksomhet_naring VALUES (143, '90.012');
INSERT INTO public.virksomhet_naring VALUES (143, '70.220');
INSERT INTO public.virksomhet_naring VALUES (144, '01.120');
INSERT INTO public.virksomhet_naring VALUES (144, '90.012');
INSERT INTO public.virksomhet_naring VALUES (145, '01.120');
INSERT INTO public.virksomhet_naring VALUES (146, '01.120');
INSERT INTO public.virksomhet_naring VALUES (146, '90.012');
INSERT INTO public.virksomhet_naring VALUES (146, '70.220');
INSERT INTO public.virksomhet_naring VALUES (147, '01.120');
INSERT INTO public.virksomhet_naring VALUES (147, '90.012');
INSERT INTO public.virksomhet_naring VALUES (147, '70.220');
INSERT INTO public.virksomhet_naring VALUES (148, '01.120');
INSERT INTO public.virksomhet_naring VALUES (148, '90.012');
INSERT INTO public.virksomhet_naring VALUES (149, '01.120');
INSERT INTO public.virksomhet_naring VALUES (149, '90.012');
INSERT INTO public.virksomhet_naring VALUES (150, '01.120');
INSERT INTO public.virksomhet_naring VALUES (150, '90.012');
INSERT INTO public.virksomhet_naring VALUES (151, '01.120');
INSERT INTO public.virksomhet_naring VALUES (151, '90.012');
INSERT INTO public.virksomhet_naring VALUES (152, '01.120');
INSERT INTO public.virksomhet_naring VALUES (153, '01.120');
INSERT INTO public.virksomhet_naring VALUES (153, '90.012');
INSERT INTO public.virksomhet_naring VALUES (154, '01.120');
INSERT INTO public.virksomhet_naring VALUES (154, '90.012');
INSERT INTO public.virksomhet_naring VALUES (154, '70.220');
INSERT INTO public.virksomhet_naring VALUES (155, '01.120');
INSERT INTO public.virksomhet_naring VALUES (156, '01.120');
INSERT INTO public.virksomhet_naring VALUES (156, '90.012');
INSERT INTO public.virksomhet_naring VALUES (157, '01.120');
INSERT INTO public.virksomhet_naring VALUES (158, '01.120');
INSERT INTO public.virksomhet_naring VALUES (159, '01.120');
INSERT INTO public.virksomhet_naring VALUES (159, '90.012');
INSERT INTO public.virksomhet_naring VALUES (160, '01.120');
INSERT INTO public.virksomhet_naring VALUES (160, '90.012');
INSERT INTO public.virksomhet_naring VALUES (161, '01.120');
INSERT INTO public.virksomhet_naring VALUES (161, '90.012');
INSERT INTO public.virksomhet_naring VALUES (162, '01.120');
INSERT INTO public.virksomhet_naring VALUES (163, '01.120');
INSERT INTO public.virksomhet_naring VALUES (163, '90.012');
INSERT INTO public.virksomhet_naring VALUES (163, '70.220');
INSERT INTO public.virksomhet_naring VALUES (164, '01.120');
INSERT INTO public.virksomhet_naring VALUES (165, '01.120');
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
INSERT INTO public.virksomhet_naring VALUES (171, '70.220');
INSERT INTO public.virksomhet_naring VALUES (172, '01.120');
INSERT INTO public.virksomhet_naring VALUES (173, '01.120');
INSERT INTO public.virksomhet_naring VALUES (174, '01.120');
INSERT INTO public.virksomhet_naring VALUES (175, '01.120');
INSERT INTO public.virksomhet_naring VALUES (176, '01.120');
INSERT INTO public.virksomhet_naring VALUES (177, '01.120');
INSERT INTO public.virksomhet_naring VALUES (178, '01.120');
INSERT INTO public.virksomhet_naring VALUES (178, '90.012');
INSERT INTO public.virksomhet_naring VALUES (179, '01.120');
INSERT INTO public.virksomhet_naring VALUES (180, '01.120');
INSERT INTO public.virksomhet_naring VALUES (180, '90.012');
INSERT INTO public.virksomhet_naring VALUES (181, '01.120');
INSERT INTO public.virksomhet_naring VALUES (182, '01.120');
INSERT INTO public.virksomhet_naring VALUES (183, '01.120');
INSERT INTO public.virksomhet_naring VALUES (184, '01.120');
INSERT INTO public.virksomhet_naring VALUES (184, '90.012');
INSERT INTO public.virksomhet_naring VALUES (185, '01.120');
INSERT INTO public.virksomhet_naring VALUES (185, '90.012');
INSERT INTO public.virksomhet_naring VALUES (186, '01.120');
INSERT INTO public.virksomhet_naring VALUES (187, '01.120');
INSERT INTO public.virksomhet_naring VALUES (188, '01.120');
INSERT INTO public.virksomhet_naring VALUES (189, '01.120');
INSERT INTO public.virksomhet_naring VALUES (189, '90.012');
INSERT INTO public.virksomhet_naring VALUES (190, '01.120');
INSERT INTO public.virksomhet_naring VALUES (191, '01.120');
INSERT INTO public.virksomhet_naring VALUES (192, '01.120');
INSERT INTO public.virksomhet_naring VALUES (193, '01.120');
INSERT INTO public.virksomhet_naring VALUES (194, '01.120');
INSERT INTO public.virksomhet_naring VALUES (194, '90.012');
INSERT INTO public.virksomhet_naring VALUES (195, '01.120');
INSERT INTO public.virksomhet_naring VALUES (195, '90.012');
INSERT INTO public.virksomhet_naring VALUES (195, '70.220');
INSERT INTO public.virksomhet_naring VALUES (196, '01.120');
INSERT INTO public.virksomhet_naring VALUES (196, '90.012');
INSERT INTO public.virksomhet_naring VALUES (196, '70.220');
INSERT INTO public.virksomhet_naring VALUES (197, '01.120');
INSERT INTO public.virksomhet_naring VALUES (197, '90.012');
INSERT INTO public.virksomhet_naring VALUES (198, '01.120');
INSERT INTO public.virksomhet_naring VALUES (198, '90.012');
INSERT INTO public.virksomhet_naring VALUES (199, '01.120');
INSERT INTO public.virksomhet_naring VALUES (200, '01.120');
INSERT INTO public.virksomhet_naring VALUES (201, '01.120');
INSERT INTO public.virksomhet_naring VALUES (201, '90.012');
INSERT INTO public.virksomhet_naring VALUES (202, '01.120');
INSERT INTO public.virksomhet_naring VALUES (202, '90.012');
INSERT INTO public.virksomhet_naring VALUES (203, '01.120');
INSERT INTO public.virksomhet_naring VALUES (203, '90.012');
INSERT INTO public.virksomhet_naring VALUES (203, '70.220');
INSERT INTO public.virksomhet_naring VALUES (204, '01.120');
INSERT INTO public.virksomhet_naring VALUES (204, '90.012');
INSERT INTO public.virksomhet_naring VALUES (205, '01.120');
INSERT INTO public.virksomhet_naring VALUES (205, '90.012');
INSERT INTO public.virksomhet_naring VALUES (206, '01.120');
INSERT INTO public.virksomhet_naring VALUES (207, '01.120');
INSERT INTO public.virksomhet_naring VALUES (208, '01.120');
INSERT INTO public.virksomhet_naring VALUES (208, '90.012');
INSERT INTO public.virksomhet_naring VALUES (208, '70.220');
INSERT INTO public.virksomhet_naring VALUES (209, '01.120');
INSERT INTO public.virksomhet_naring VALUES (209, '90.012');
INSERT INTO public.virksomhet_naring VALUES (209, '70.220');
INSERT INTO public.virksomhet_naring VALUES (210, '01.120');
INSERT INTO public.virksomhet_naring VALUES (210, '90.012');
INSERT INTO public.virksomhet_naring VALUES (211, '01.120');
INSERT INTO public.virksomhet_naring VALUES (211, '90.012');
INSERT INTO public.virksomhet_naring VALUES (212, '01.120');
INSERT INTO public.virksomhet_naring VALUES (212, '90.012');
INSERT INTO public.virksomhet_naring VALUES (213, '01.120');
INSERT INTO public.virksomhet_naring VALUES (213, '90.012');
INSERT INTO public.virksomhet_naring VALUES (213, '70.220');
INSERT INTO public.virksomhet_naring VALUES (214, '01.120');
INSERT INTO public.virksomhet_naring VALUES (214, '90.012');
INSERT INTO public.virksomhet_naring VALUES (215, '01.120');
INSERT INTO public.virksomhet_naring VALUES (215, '90.012');
INSERT INTO public.virksomhet_naring VALUES (216, '01.120');
INSERT INTO public.virksomhet_naring VALUES (216, '90.012');
INSERT INTO public.virksomhet_naring VALUES (217, '01.120');
INSERT INTO public.virksomhet_naring VALUES (218, '01.120');
INSERT INTO public.virksomhet_naring VALUES (219, '01.120');
INSERT INTO public.virksomhet_naring VALUES (220, '01.120');
INSERT INTO public.virksomhet_naring VALUES (220, '90.012');
INSERT INTO public.virksomhet_naring VALUES (220, '70.220');
INSERT INTO public.virksomhet_naring VALUES (221, '01.120');
INSERT INTO public.virksomhet_naring VALUES (221, '90.012');
INSERT INTO public.virksomhet_naring VALUES (221, '70.220');
INSERT INTO public.virksomhet_naring VALUES (222, '01.120');
INSERT INTO public.virksomhet_naring VALUES (223, '01.120');
INSERT INTO public.virksomhet_naring VALUES (224, '01.120');
INSERT INTO public.virksomhet_naring VALUES (225, '01.120');
INSERT INTO public.virksomhet_naring VALUES (226, '01.120');
INSERT INTO public.virksomhet_naring VALUES (227, '01.120');
INSERT INTO public.virksomhet_naring VALUES (228, '01.120');
INSERT INTO public.virksomhet_naring VALUES (228, '90.012');
INSERT INTO public.virksomhet_naring VALUES (228, '70.220');
INSERT INTO public.virksomhet_naring VALUES (229, '01.120');
INSERT INTO public.virksomhet_naring VALUES (229, '90.012');
INSERT INTO public.virksomhet_naring VALUES (230, '01.120');
INSERT INTO public.virksomhet_naring VALUES (231, '01.120');
INSERT INTO public.virksomhet_naring VALUES (231, '90.012');
INSERT INTO public.virksomhet_naring VALUES (232, '01.120');
INSERT INTO public.virksomhet_naring VALUES (233, '01.120');
INSERT INTO public.virksomhet_naring VALUES (234, '01.120');
INSERT INTO public.virksomhet_naring VALUES (235, '01.120');
INSERT INTO public.virksomhet_naring VALUES (236, '01.120');
INSERT INTO public.virksomhet_naring VALUES (236, '90.012');
INSERT INTO public.virksomhet_naring VALUES (236, '70.220');
INSERT INTO public.virksomhet_naring VALUES (237, '01.120');
INSERT INTO public.virksomhet_naring VALUES (237, '90.012');
INSERT INTO public.virksomhet_naring VALUES (238, '01.120');
INSERT INTO public.virksomhet_naring VALUES (239, '01.120');
INSERT INTO public.virksomhet_naring VALUES (239, '90.012');
INSERT INTO public.virksomhet_naring VALUES (239, '70.220');
INSERT INTO public.virksomhet_naring VALUES (240, '01.120');
INSERT INTO public.virksomhet_naring VALUES (240, '90.012');
INSERT INTO public.virksomhet_naring VALUES (241, '01.120');
INSERT INTO public.virksomhet_naring VALUES (241, '90.012');
INSERT INTO public.virksomhet_naring VALUES (242, '01.120');
INSERT INTO public.virksomhet_naring VALUES (242, '90.012');
INSERT INTO public.virksomhet_naring VALUES (243, '01.120');
INSERT INTO public.virksomhet_naring VALUES (243, '90.012');
INSERT INTO public.virksomhet_naring VALUES (244, '01.120');
INSERT INTO public.virksomhet_naring VALUES (245, '01.120');
INSERT INTO public.virksomhet_naring VALUES (246, '01.120');
INSERT INTO public.virksomhet_naring VALUES (247, '01.120');
INSERT INTO public.virksomhet_naring VALUES (247, '90.012');
INSERT INTO public.virksomhet_naring VALUES (248, '01.120');
INSERT INTO public.virksomhet_naring VALUES (248, '90.012');
INSERT INTO public.virksomhet_naring VALUES (249, '01.120');
INSERT INTO public.virksomhet_naring VALUES (250, '01.120');
INSERT INTO public.virksomhet_naring VALUES (250, '90.012');
INSERT INTO public.virksomhet_naring VALUES (251, '01.120');
INSERT INTO public.virksomhet_naring VALUES (252, '01.120');
INSERT INTO public.virksomhet_naring VALUES (252, '90.012');
INSERT INTO public.virksomhet_naring VALUES (252, '70.220');
INSERT INTO public.virksomhet_naring VALUES (253, '01.120');
INSERT INTO public.virksomhet_naring VALUES (254, '01.120');
INSERT INTO public.virksomhet_naring VALUES (254, '90.012');
INSERT INTO public.virksomhet_naring VALUES (254, '70.220');
INSERT INTO public.virksomhet_naring VALUES (255, '01.120');
INSERT INTO public.virksomhet_naring VALUES (255, '90.012');
INSERT INTO public.virksomhet_naring VALUES (255, '70.220');
INSERT INTO public.virksomhet_naring VALUES (256, '01.120');
INSERT INTO public.virksomhet_naring VALUES (257, '01.120');
INSERT INTO public.virksomhet_naring VALUES (257, '90.012');
INSERT INTO public.virksomhet_naring VALUES (258, '01.120');
INSERT INTO public.virksomhet_naring VALUES (259, '01.120');
INSERT INTO public.virksomhet_naring VALUES (259, '90.012');
INSERT INTO public.virksomhet_naring VALUES (259, '70.220');
INSERT INTO public.virksomhet_naring VALUES (260, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '90.012');
INSERT INTO public.virksomhet_naring VALUES (262, '01.120');
INSERT INTO public.virksomhet_naring VALUES (262, '90.012');
INSERT INTO public.virksomhet_naring VALUES (262, '70.220');
INSERT INTO public.virksomhet_naring VALUES (263, '01.120');
INSERT INTO public.virksomhet_naring VALUES (263, '90.012');
INSERT INTO public.virksomhet_naring VALUES (264, '01.120');
INSERT INTO public.virksomhet_naring VALUES (264, '90.012');
INSERT INTO public.virksomhet_naring VALUES (264, '70.220');
INSERT INTO public.virksomhet_naring VALUES (265, '01.120');
INSERT INTO public.virksomhet_naring VALUES (265, '90.012');
INSERT INTO public.virksomhet_naring VALUES (266, '01.120');
INSERT INTO public.virksomhet_naring VALUES (266, '90.012');
INSERT INTO public.virksomhet_naring VALUES (267, '01.120');
INSERT INTO public.virksomhet_naring VALUES (268, '01.120');
INSERT INTO public.virksomhet_naring VALUES (268, '90.012');
INSERT INTO public.virksomhet_naring VALUES (268, '70.220');
INSERT INTO public.virksomhet_naring VALUES (269, '01.120');
INSERT INTO public.virksomhet_naring VALUES (270, '01.120');
INSERT INTO public.virksomhet_naring VALUES (271, '01.120');
INSERT INTO public.virksomhet_naring VALUES (272, '01.120');
INSERT INTO public.virksomhet_naring VALUES (273, '01.120');
INSERT INTO public.virksomhet_naring VALUES (273, '90.012');
INSERT INTO public.virksomhet_naring VALUES (274, '01.120');
INSERT INTO public.virksomhet_naring VALUES (274, '90.012');
INSERT INTO public.virksomhet_naring VALUES (275, '01.120');
INSERT INTO public.virksomhet_naring VALUES (275, '90.012');
INSERT INTO public.virksomhet_naring VALUES (276, '01.120');
INSERT INTO public.virksomhet_naring VALUES (277, '01.120');
INSERT INTO public.virksomhet_naring VALUES (278, '01.120');
INSERT INTO public.virksomhet_naring VALUES (279, '01.120');
INSERT INTO public.virksomhet_naring VALUES (280, '01.120');
INSERT INTO public.virksomhet_naring VALUES (281, '01.120');
INSERT INTO public.virksomhet_naring VALUES (281, '90.012');
INSERT INTO public.virksomhet_naring VALUES (281, '70.220');
INSERT INTO public.virksomhet_naring VALUES (282, '01.120');
INSERT INTO public.virksomhet_naring VALUES (282, '90.012');
INSERT INTO public.virksomhet_naring VALUES (282, '70.220');
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
INSERT INTO public.virksomhet_naring VALUES (289, '90.012');
INSERT INTO public.virksomhet_naring VALUES (289, '70.220');
INSERT INTO public.virksomhet_naring VALUES (290, '01.120');
INSERT INTO public.virksomhet_naring VALUES (290, '90.012');
INSERT INTO public.virksomhet_naring VALUES (290, '70.220');
INSERT INTO public.virksomhet_naring VALUES (291, '01.120');
INSERT INTO public.virksomhet_naring VALUES (291, '90.012');
INSERT INTO public.virksomhet_naring VALUES (292, '01.120');
INSERT INTO public.virksomhet_naring VALUES (292, '90.012');
INSERT INTO public.virksomhet_naring VALUES (292, '70.220');
INSERT INTO public.virksomhet_naring VALUES (293, '01.120');
INSERT INTO public.virksomhet_naring VALUES (293, '90.012');
INSERT INTO public.virksomhet_naring VALUES (294, '01.120');
INSERT INTO public.virksomhet_naring VALUES (294, '90.012');
INSERT INTO public.virksomhet_naring VALUES (295, '01.120');
INSERT INTO public.virksomhet_naring VALUES (296, '01.120');
INSERT INTO public.virksomhet_naring VALUES (296, '90.012');
INSERT INTO public.virksomhet_naring VALUES (297, '01.120');
INSERT INTO public.virksomhet_naring VALUES (298, '01.120');
INSERT INTO public.virksomhet_naring VALUES (299, '01.120');
INSERT INTO public.virksomhet_naring VALUES (300, '01.120');
INSERT INTO public.virksomhet_naring VALUES (301, '01.120');
INSERT INTO public.virksomhet_naring VALUES (302, '01.120');
INSERT INTO public.virksomhet_naring VALUES (303, '01.120');
INSERT INTO public.virksomhet_naring VALUES (303, '90.012');
INSERT INTO public.virksomhet_naring VALUES (304, '01.120');
INSERT INTO public.virksomhet_naring VALUES (305, '01.120');
INSERT INTO public.virksomhet_naring VALUES (306, '01.120');
INSERT INTO public.virksomhet_naring VALUES (306, '90.012');
INSERT INTO public.virksomhet_naring VALUES (306, '70.220');
INSERT INTO public.virksomhet_naring VALUES (307, '01.120');
INSERT INTO public.virksomhet_naring VALUES (308, '01.120');
INSERT INTO public.virksomhet_naring VALUES (309, '01.120');
INSERT INTO public.virksomhet_naring VALUES (309, '90.012');
INSERT INTO public.virksomhet_naring VALUES (309, '70.220');
INSERT INTO public.virksomhet_naring VALUES (310, '01.120');
INSERT INTO public.virksomhet_naring VALUES (311, '01.120');
INSERT INTO public.virksomhet_naring VALUES (311, '90.012');
INSERT INTO public.virksomhet_naring VALUES (312, '01.120');
INSERT INTO public.virksomhet_naring VALUES (312, '90.012');
INSERT INTO public.virksomhet_naring VALUES (313, '01.120');
INSERT INTO public.virksomhet_naring VALUES (314, '01.120');
INSERT INTO public.virksomhet_naring VALUES (315, '01.120');
INSERT INTO public.virksomhet_naring VALUES (315, '90.012');
INSERT INTO public.virksomhet_naring VALUES (315, '70.220');
INSERT INTO public.virksomhet_naring VALUES (316, '01.120');
INSERT INTO public.virksomhet_naring VALUES (317, '01.120');
INSERT INTO public.virksomhet_naring VALUES (318, '01.120');
INSERT INTO public.virksomhet_naring VALUES (318, '90.012');
INSERT INTO public.virksomhet_naring VALUES (319, '01.120');
INSERT INTO public.virksomhet_naring VALUES (319, '90.012');
INSERT INTO public.virksomhet_naring VALUES (319, '70.220');
INSERT INTO public.virksomhet_naring VALUES (320, '01.120');
INSERT INTO public.virksomhet_naring VALUES (320, '90.012');
INSERT INTO public.virksomhet_naring VALUES (321, '01.120');
INSERT INTO public.virksomhet_naring VALUES (322, '01.120');
INSERT INTO public.virksomhet_naring VALUES (323, '01.120');
INSERT INTO public.virksomhet_naring VALUES (324, '01.120');
INSERT INTO public.virksomhet_naring VALUES (325, '01.120');
INSERT INTO public.virksomhet_naring VALUES (326, '01.120');
INSERT INTO public.virksomhet_naring VALUES (326, '90.012');
INSERT INTO public.virksomhet_naring VALUES (326, '70.220');
INSERT INTO public.virksomhet_naring VALUES (327, '01.120');
INSERT INTO public.virksomhet_naring VALUES (328, '01.120');
INSERT INTO public.virksomhet_naring VALUES (328, '90.012');
INSERT INTO public.virksomhet_naring VALUES (329, '01.120');
INSERT INTO public.virksomhet_naring VALUES (329, '90.012');
INSERT INTO public.virksomhet_naring VALUES (330, '01.120');
INSERT INTO public.virksomhet_naring VALUES (330, '90.012');
INSERT INTO public.virksomhet_naring VALUES (331, '01.120');
INSERT INTO public.virksomhet_naring VALUES (331, '90.012');
INSERT INTO public.virksomhet_naring VALUES (332, '01.120');
INSERT INTO public.virksomhet_naring VALUES (333, '01.120');
INSERT INTO public.virksomhet_naring VALUES (334, '01.120');
INSERT INTO public.virksomhet_naring VALUES (334, '90.012');
INSERT INTO public.virksomhet_naring VALUES (334, '70.220');
INSERT INTO public.virksomhet_naring VALUES (335, '01.120');
INSERT INTO public.virksomhet_naring VALUES (336, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '90.012');
INSERT INTO public.virksomhet_naring VALUES (337, '70.220');
INSERT INTO public.virksomhet_naring VALUES (338, '01.120');
INSERT INTO public.virksomhet_naring VALUES (338, '90.012');
INSERT INTO public.virksomhet_naring VALUES (338, '70.220');
INSERT INTO public.virksomhet_naring VALUES (339, '01.120');
INSERT INTO public.virksomhet_naring VALUES (339, '90.012');
INSERT INTO public.virksomhet_naring VALUES (339, '70.220');
INSERT INTO public.virksomhet_naring VALUES (340, '01.120');
INSERT INTO public.virksomhet_naring VALUES (340, '90.012');
INSERT INTO public.virksomhet_naring VALUES (341, '01.120');
INSERT INTO public.virksomhet_naring VALUES (341, '90.012');
INSERT INTO public.virksomhet_naring VALUES (341, '70.220');
INSERT INTO public.virksomhet_naring VALUES (342, '01.120');
INSERT INTO public.virksomhet_naring VALUES (343, '01.120');
INSERT INTO public.virksomhet_naring VALUES (344, '01.120');
INSERT INTO public.virksomhet_naring VALUES (344, '90.012');
INSERT INTO public.virksomhet_naring VALUES (345, '01.120');
INSERT INTO public.virksomhet_naring VALUES (345, '90.012');
INSERT INTO public.virksomhet_naring VALUES (346, '01.120');
INSERT INTO public.virksomhet_naring VALUES (346, '90.012');
INSERT INTO public.virksomhet_naring VALUES (346, '70.220');
INSERT INTO public.virksomhet_naring VALUES (347, '01.120');
INSERT INTO public.virksomhet_naring VALUES (348, '01.120');
INSERT INTO public.virksomhet_naring VALUES (349, '01.120');
INSERT INTO public.virksomhet_naring VALUES (349, '90.012');
INSERT INTO public.virksomhet_naring VALUES (350, '01.120');
INSERT INTO public.virksomhet_naring VALUES (351, '01.120');
INSERT INTO public.virksomhet_naring VALUES (351, '90.012');
INSERT INTO public.virksomhet_naring VALUES (351, '70.220');
INSERT INTO public.virksomhet_naring VALUES (352, '01.120');
INSERT INTO public.virksomhet_naring VALUES (352, '90.012');
INSERT INTO public.virksomhet_naring VALUES (353, '01.120');
INSERT INTO public.virksomhet_naring VALUES (354, '01.120');
INSERT INTO public.virksomhet_naring VALUES (355, '01.120');
INSERT INTO public.virksomhet_naring VALUES (356, '01.120');
INSERT INTO public.virksomhet_naring VALUES (356, '90.012');
INSERT INTO public.virksomhet_naring VALUES (356, '70.220');
INSERT INTO public.virksomhet_naring VALUES (357, '01.120');
INSERT INTO public.virksomhet_naring VALUES (357, '90.012');
INSERT INTO public.virksomhet_naring VALUES (358, '01.120');
INSERT INTO public.virksomhet_naring VALUES (358, '90.012');
INSERT INTO public.virksomhet_naring VALUES (358, '70.220');
INSERT INTO public.virksomhet_naring VALUES (359, '01.120');
INSERT INTO public.virksomhet_naring VALUES (359, '90.012');
INSERT INTO public.virksomhet_naring VALUES (360, '01.120');
INSERT INTO public.virksomhet_naring VALUES (361, '01.120');
INSERT INTO public.virksomhet_naring VALUES (361, '90.012');
INSERT INTO public.virksomhet_naring VALUES (362, '01.120');
INSERT INTO public.virksomhet_naring VALUES (363, '01.120');
INSERT INTO public.virksomhet_naring VALUES (364, '01.120');
INSERT INTO public.virksomhet_naring VALUES (365, '01.120');
INSERT INTO public.virksomhet_naring VALUES (366, '01.120');
INSERT INTO public.virksomhet_naring VALUES (366, '90.012');
INSERT INTO public.virksomhet_naring VALUES (367, '01.120');
INSERT INTO public.virksomhet_naring VALUES (368, '01.120');
INSERT INTO public.virksomhet_naring VALUES (368, '90.012');
INSERT INTO public.virksomhet_naring VALUES (369, '01.120');
INSERT INTO public.virksomhet_naring VALUES (369, '90.012');
INSERT INTO public.virksomhet_naring VALUES (369, '70.220');
INSERT INTO public.virksomhet_naring VALUES (370, '01.120');
INSERT INTO public.virksomhet_naring VALUES (371, '01.120');
INSERT INTO public.virksomhet_naring VALUES (371, '90.012');
INSERT INTO public.virksomhet_naring VALUES (372, '01.120');
INSERT INTO public.virksomhet_naring VALUES (373, '01.120');
INSERT INTO public.virksomhet_naring VALUES (373, '90.012');
INSERT INTO public.virksomhet_naring VALUES (373, '70.220');
INSERT INTO public.virksomhet_naring VALUES (374, '01.120');
INSERT INTO public.virksomhet_naring VALUES (375, '01.120');
INSERT INTO public.virksomhet_naring VALUES (375, '90.012');
INSERT INTO public.virksomhet_naring VALUES (376, '01.120');
INSERT INTO public.virksomhet_naring VALUES (376, '90.012');
INSERT INTO public.virksomhet_naring VALUES (377, '01.120');
INSERT INTO public.virksomhet_naring VALUES (377, '90.012');
INSERT INTO public.virksomhet_naring VALUES (378, '01.120');
INSERT INTO public.virksomhet_naring VALUES (378, '90.012');
INSERT INTO public.virksomhet_naring VALUES (379, '01.120');
INSERT INTO public.virksomhet_naring VALUES (380, '01.120');
INSERT INTO public.virksomhet_naring VALUES (381, '01.120');
INSERT INTO public.virksomhet_naring VALUES (382, '01.120');
INSERT INTO public.virksomhet_naring VALUES (383, '01.120');
INSERT INTO public.virksomhet_naring VALUES (384, '01.120');
INSERT INTO public.virksomhet_naring VALUES (385, '01.120');
INSERT INTO public.virksomhet_naring VALUES (385, '90.012');
INSERT INTO public.virksomhet_naring VALUES (385, '70.220');
INSERT INTO public.virksomhet_naring VALUES (386, '01.120');
INSERT INTO public.virksomhet_naring VALUES (386, '90.012');
INSERT INTO public.virksomhet_naring VALUES (386, '70.220');
INSERT INTO public.virksomhet_naring VALUES (387, '01.120');
INSERT INTO public.virksomhet_naring VALUES (388, '01.120');
INSERT INTO public.virksomhet_naring VALUES (389, '01.120');
INSERT INTO public.virksomhet_naring VALUES (389, '90.012');
INSERT INTO public.virksomhet_naring VALUES (390, '01.120');
INSERT INTO public.virksomhet_naring VALUES (390, '90.012');
INSERT INTO public.virksomhet_naring VALUES (391, '01.120');
INSERT INTO public.virksomhet_naring VALUES (392, '01.120');
INSERT INTO public.virksomhet_naring VALUES (392, '90.012');
INSERT INTO public.virksomhet_naring VALUES (393, '01.120');
INSERT INTO public.virksomhet_naring VALUES (394, '01.120');
INSERT INTO public.virksomhet_naring VALUES (395, '01.120');
INSERT INTO public.virksomhet_naring VALUES (396, '01.120');
INSERT INTO public.virksomhet_naring VALUES (396, '90.012');
INSERT INTO public.virksomhet_naring VALUES (397, '01.120');
INSERT INTO public.virksomhet_naring VALUES (397, '90.012');
INSERT INTO public.virksomhet_naring VALUES (397, '70.220');
INSERT INTO public.virksomhet_naring VALUES (398, '01.120');
INSERT INTO public.virksomhet_naring VALUES (398, '90.012');
INSERT INTO public.virksomhet_naring VALUES (399, '01.120');
INSERT INTO public.virksomhet_naring VALUES (400, '01.120');
INSERT INTO public.virksomhet_naring VALUES (401, '01.120');
INSERT INTO public.virksomhet_naring VALUES (401, '90.012');
INSERT INTO public.virksomhet_naring VALUES (402, '01.120');
INSERT INTO public.virksomhet_naring VALUES (403, '01.120');
INSERT INTO public.virksomhet_naring VALUES (403, '90.012');
INSERT INTO public.virksomhet_naring VALUES (403, '70.220');
INSERT INTO public.virksomhet_naring VALUES (404, '01.120');
INSERT INTO public.virksomhet_naring VALUES (405, '01.120');
INSERT INTO public.virksomhet_naring VALUES (406, '01.120');
INSERT INTO public.virksomhet_naring VALUES (406, '90.012');
INSERT INTO public.virksomhet_naring VALUES (407, '01.120');
INSERT INTO public.virksomhet_naring VALUES (407, '90.012');
INSERT INTO public.virksomhet_naring VALUES (407, '70.220');
INSERT INTO public.virksomhet_naring VALUES (408, '01.120');
INSERT INTO public.virksomhet_naring VALUES (408, '90.012');
INSERT INTO public.virksomhet_naring VALUES (409, '01.120');
INSERT INTO public.virksomhet_naring VALUES (410, '01.120');
INSERT INTO public.virksomhet_naring VALUES (411, '01.120');
INSERT INTO public.virksomhet_naring VALUES (412, '01.120');
INSERT INTO public.virksomhet_naring VALUES (413, '01.120');
INSERT INTO public.virksomhet_naring VALUES (414, '01.120');
INSERT INTO public.virksomhet_naring VALUES (415, '01.120');
INSERT INTO public.virksomhet_naring VALUES (416, '01.120');
INSERT INTO public.virksomhet_naring VALUES (417, '01.120');
INSERT INTO public.virksomhet_naring VALUES (417, '90.012');
INSERT INTO public.virksomhet_naring VALUES (417, '70.220');
INSERT INTO public.virksomhet_naring VALUES (418, '01.120');
INSERT INTO public.virksomhet_naring VALUES (418, '90.012');
INSERT INTO public.virksomhet_naring VALUES (418, '70.220');
INSERT INTO public.virksomhet_naring VALUES (419, '01.120');
INSERT INTO public.virksomhet_naring VALUES (420, '01.120');
INSERT INTO public.virksomhet_naring VALUES (420, '90.012');
INSERT INTO public.virksomhet_naring VALUES (421, '01.120');
INSERT INTO public.virksomhet_naring VALUES (422, '01.120');
INSERT INTO public.virksomhet_naring VALUES (423, '01.120');
INSERT INTO public.virksomhet_naring VALUES (424, '01.120');
INSERT INTO public.virksomhet_naring VALUES (424, '90.012');
INSERT INTO public.virksomhet_naring VALUES (425, '01.120');
INSERT INTO public.virksomhet_naring VALUES (425, '90.012');
INSERT INTO public.virksomhet_naring VALUES (425, '70.220');
INSERT INTO public.virksomhet_naring VALUES (426, '01.120');
INSERT INTO public.virksomhet_naring VALUES (427, '01.120');
INSERT INTO public.virksomhet_naring VALUES (427, '90.012');
INSERT INTO public.virksomhet_naring VALUES (427, '70.220');
INSERT INTO public.virksomhet_naring VALUES (428, '01.120');
INSERT INTO public.virksomhet_naring VALUES (428, '90.012');
INSERT INTO public.virksomhet_naring VALUES (429, '01.120');
INSERT INTO public.virksomhet_naring VALUES (430, '01.120');
INSERT INTO public.virksomhet_naring VALUES (430, '90.012');
INSERT INTO public.virksomhet_naring VALUES (431, '01.120');
INSERT INTO public.virksomhet_naring VALUES (432, '01.120');
INSERT INTO public.virksomhet_naring VALUES (432, '90.012');
INSERT INTO public.virksomhet_naring VALUES (433, '01.120');
INSERT INTO public.virksomhet_naring VALUES (433, '90.012');
INSERT INTO public.virksomhet_naring VALUES (434, '01.120');
INSERT INTO public.virksomhet_naring VALUES (434, '90.012');
INSERT INTO public.virksomhet_naring VALUES (435, '01.120');
INSERT INTO public.virksomhet_naring VALUES (436, '01.120');
INSERT INTO public.virksomhet_naring VALUES (437, '01.120');
INSERT INTO public.virksomhet_naring VALUES (437, '90.012');
INSERT INTO public.virksomhet_naring VALUES (438, '01.120');
INSERT INTO public.virksomhet_naring VALUES (439, '01.120');
INSERT INTO public.virksomhet_naring VALUES (439, '90.012');
INSERT INTO public.virksomhet_naring VALUES (440, '01.120');
INSERT INTO public.virksomhet_naring VALUES (440, '90.012');
INSERT INTO public.virksomhet_naring VALUES (441, '01.120');
INSERT INTO public.virksomhet_naring VALUES (441, '90.012');
INSERT INTO public.virksomhet_naring VALUES (442, '01.120');
INSERT INTO public.virksomhet_naring VALUES (442, '90.012');
INSERT INTO public.virksomhet_naring VALUES (443, '01.120');
INSERT INTO public.virksomhet_naring VALUES (443, '90.012');
INSERT INTO public.virksomhet_naring VALUES (444, '01.120');
INSERT INTO public.virksomhet_naring VALUES (445, '01.120');
INSERT INTO public.virksomhet_naring VALUES (446, '01.120');
INSERT INTO public.virksomhet_naring VALUES (446, '90.012');
INSERT INTO public.virksomhet_naring VALUES (447, '01.120');
INSERT INTO public.virksomhet_naring VALUES (448, '01.120');
INSERT INTO public.virksomhet_naring VALUES (449, '01.120');
INSERT INTO public.virksomhet_naring VALUES (449, '90.012');
INSERT INTO public.virksomhet_naring VALUES (450, '01.120');
INSERT INTO public.virksomhet_naring VALUES (450, '90.012');
INSERT INTO public.virksomhet_naring VALUES (451, '01.120');
INSERT INTO public.virksomhet_naring VALUES (452, '01.120');
INSERT INTO public.virksomhet_naring VALUES (453, '01.120');
INSERT INTO public.virksomhet_naring VALUES (454, '01.120');
INSERT INTO public.virksomhet_naring VALUES (454, '90.012');
INSERT INTO public.virksomhet_naring VALUES (455, '01.120');
INSERT INTO public.virksomhet_naring VALUES (455, '90.012');
INSERT INTO public.virksomhet_naring VALUES (455, '70.220');
INSERT INTO public.virksomhet_naring VALUES (456, '01.120');
INSERT INTO public.virksomhet_naring VALUES (457, '01.120');
INSERT INTO public.virksomhet_naring VALUES (457, '90.012');
INSERT INTO public.virksomhet_naring VALUES (458, '01.120');
INSERT INTO public.virksomhet_naring VALUES (459, '01.120');
INSERT INTO public.virksomhet_naring VALUES (460, '01.120');
INSERT INTO public.virksomhet_naring VALUES (461, '01.120');
INSERT INTO public.virksomhet_naring VALUES (462, '01.120');
INSERT INTO public.virksomhet_naring VALUES (463, '01.120');
INSERT INTO public.virksomhet_naring VALUES (463, '90.012');
INSERT INTO public.virksomhet_naring VALUES (463, '70.220');
INSERT INTO public.virksomhet_naring VALUES (464, '01.120');
INSERT INTO public.virksomhet_naring VALUES (465, '01.120');
INSERT INTO public.virksomhet_naring VALUES (465, '90.012');
INSERT INTO public.virksomhet_naring VALUES (466, '01.120');
INSERT INTO public.virksomhet_naring VALUES (466, '90.012');
INSERT INTO public.virksomhet_naring VALUES (467, '01.120');
INSERT INTO public.virksomhet_naring VALUES (467, '90.012');
INSERT INTO public.virksomhet_naring VALUES (467, '70.220');
INSERT INTO public.virksomhet_naring VALUES (468, '01.120');
INSERT INTO public.virksomhet_naring VALUES (469, '01.120');
INSERT INTO public.virksomhet_naring VALUES (469, '90.012');
INSERT INTO public.virksomhet_naring VALUES (470, '01.120');
INSERT INTO public.virksomhet_naring VALUES (471, '01.120');
INSERT INTO public.virksomhet_naring VALUES (471, '90.012');
INSERT INTO public.virksomhet_naring VALUES (472, '01.120');
INSERT INTO public.virksomhet_naring VALUES (473, '01.120');
INSERT INTO public.virksomhet_naring VALUES (473, '90.012');
INSERT INTO public.virksomhet_naring VALUES (474, '01.120');
INSERT INTO public.virksomhet_naring VALUES (475, '01.120');
INSERT INTO public.virksomhet_naring VALUES (476, '01.120');
INSERT INTO public.virksomhet_naring VALUES (477, '01.120');
INSERT INTO public.virksomhet_naring VALUES (478, '01.120');
INSERT INTO public.virksomhet_naring VALUES (479, '01.120');
INSERT INTO public.virksomhet_naring VALUES (480, '01.120');
INSERT INTO public.virksomhet_naring VALUES (480, '90.012');
INSERT INTO public.virksomhet_naring VALUES (481, '01.120');
INSERT INTO public.virksomhet_naring VALUES (481, '90.012');
INSERT INTO public.virksomhet_naring VALUES (482, '01.120');
INSERT INTO public.virksomhet_naring VALUES (483, '01.120');
INSERT INTO public.virksomhet_naring VALUES (484, '01.120');
INSERT INTO public.virksomhet_naring VALUES (485, '01.120');
INSERT INTO public.virksomhet_naring VALUES (485, '90.012');
INSERT INTO public.virksomhet_naring VALUES (486, '01.120');
INSERT INTO public.virksomhet_naring VALUES (487, '01.120');
INSERT INTO public.virksomhet_naring VALUES (488, '01.120');
INSERT INTO public.virksomhet_naring VALUES (488, '90.012');
INSERT INTO public.virksomhet_naring VALUES (488, '70.220');
INSERT INTO public.virksomhet_naring VALUES (489, '01.120');
INSERT INTO public.virksomhet_naring VALUES (490, '01.120');
INSERT INTO public.virksomhet_naring VALUES (491, '01.120');
INSERT INTO public.virksomhet_naring VALUES (491, '90.012');
INSERT INTO public.virksomhet_naring VALUES (491, '70.220');
INSERT INTO public.virksomhet_naring VALUES (492, '01.120');
INSERT INTO public.virksomhet_naring VALUES (492, '90.012');
INSERT INTO public.virksomhet_naring VALUES (493, '01.120');
INSERT INTO public.virksomhet_naring VALUES (493, '90.012');
INSERT INTO public.virksomhet_naring VALUES (494, '01.120');
INSERT INTO public.virksomhet_naring VALUES (494, '90.012');
INSERT INTO public.virksomhet_naring VALUES (494, '70.220');
INSERT INTO public.virksomhet_naring VALUES (495, '01.120');
INSERT INTO public.virksomhet_naring VALUES (495, '90.012');
INSERT INTO public.virksomhet_naring VALUES (495, '70.220');
INSERT INTO public.virksomhet_naring VALUES (496, '01.120');
INSERT INTO public.virksomhet_naring VALUES (496, '90.012');
INSERT INTO public.virksomhet_naring VALUES (496, '70.220');
INSERT INTO public.virksomhet_naring VALUES (497, '01.120');
INSERT INTO public.virksomhet_naring VALUES (497, '90.012');
INSERT INTO public.virksomhet_naring VALUES (498, '01.120');
INSERT INTO public.virksomhet_naring VALUES (499, '01.120');
INSERT INTO public.virksomhet_naring VALUES (500, '01.120');
INSERT INTO public.virksomhet_naring VALUES (501, '01.120');
INSERT INTO public.virksomhet_naring VALUES (501, '90.012');
INSERT INTO public.virksomhet_naring VALUES (502, '01.120');
INSERT INTO public.virksomhet_naring VALUES (502, '90.012');
INSERT INTO public.virksomhet_naring VALUES (503, '01.120');
INSERT INTO public.virksomhet_naring VALUES (503, '90.012');
INSERT INTO public.virksomhet_naring VALUES (504, '01.120');
INSERT INTO public.virksomhet_naring VALUES (505, '01.120');
INSERT INTO public.virksomhet_naring VALUES (505, '90.012');
INSERT INTO public.virksomhet_naring VALUES (506, '01.120');
INSERT INTO public.virksomhet_naring VALUES (506, '90.012');
INSERT INTO public.virksomhet_naring VALUES (506, '70.220');
INSERT INTO public.virksomhet_naring VALUES (507, '01.120');
INSERT INTO public.virksomhet_naring VALUES (507, '90.012');
INSERT INTO public.virksomhet_naring VALUES (508, '01.120');
INSERT INTO public.virksomhet_naring VALUES (508, '90.012');
INSERT INTO public.virksomhet_naring VALUES (508, '70.220');
INSERT INTO public.virksomhet_naring VALUES (509, '01.120');
INSERT INTO public.virksomhet_naring VALUES (509, '90.012');
INSERT INTO public.virksomhet_naring VALUES (510, '01.120');
INSERT INTO public.virksomhet_naring VALUES (510, '90.012');
INSERT INTO public.virksomhet_naring VALUES (510, '70.220');
INSERT INTO public.virksomhet_naring VALUES (511, '01.120');
INSERT INTO public.virksomhet_naring VALUES (517, '01.120');
INSERT INTO public.virksomhet_naring VALUES (518, '01.120');
INSERT INTO public.virksomhet_naring VALUES (518, '90.012');
INSERT INTO public.virksomhet_naring VALUES (518, '70.220');
INSERT INTO public.virksomhet_naring VALUES (519, '01.120');
INSERT INTO public.virksomhet_naring VALUES (520, '01.120');
INSERT INTO public.virksomhet_naring VALUES (520, '90.012');
INSERT INTO public.virksomhet_naring VALUES (520, '70.220');
INSERT INTO public.virksomhet_naring VALUES (521, '01.120');
INSERT INTO public.virksomhet_naring VALUES (522, '01.120');
INSERT INTO public.virksomhet_naring VALUES (523, '01.120');
INSERT INTO public.virksomhet_naring VALUES (524, '01.120');
INSERT INTO public.virksomhet_naring VALUES (525, '01.120');
INSERT INTO public.virksomhet_naring VALUES (526, '01.120');
INSERT INTO public.virksomhet_naring VALUES (526, '90.012');
INSERT INTO public.virksomhet_naring VALUES (512, '01.120');
INSERT INTO public.virksomhet_naring VALUES (512, '90.012');
INSERT INTO public.virksomhet_naring VALUES (513, '01.120');
INSERT INTO public.virksomhet_naring VALUES (514, '01.120');
INSERT INTO public.virksomhet_naring VALUES (514, '90.012');
INSERT INTO public.virksomhet_naring VALUES (514, '70.220');
INSERT INTO public.virksomhet_naring VALUES (515, '01.120');
INSERT INTO public.virksomhet_naring VALUES (516, '01.120');
INSERT INTO public.virksomhet_naring VALUES (516, '90.012');
INSERT INTO public.virksomhet_naring VALUES (516, '70.220');
INSERT INTO public.virksomhet_naring VALUES (527, '01.120');
INSERT INTO public.virksomhet_naring VALUES (527, '01.110');
INSERT INTO public.virksomhet_naring VALUES (527, '70.220');
INSERT INTO public.virksomhet_naring VALUES (534, '01.120');
INSERT INTO public.virksomhet_naring VALUES (535, '01.120');
INSERT INTO public.virksomhet_naring VALUES (535, '90.012');
INSERT INTO public.virksomhet_naring VALUES (535, '70.220');
INSERT INTO public.virksomhet_naring VALUES (536, '01.120');
INSERT INTO public.virksomhet_naring VALUES (537, '01.120');
INSERT INTO public.virksomhet_naring VALUES (537, '90.012');
INSERT INTO public.virksomhet_naring VALUES (538, '01.120');


--
-- Data for Name: virksomhet_naringsundergrupper; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_naringsundergrupper VALUES (1, 512, '01.120', '90.012', NULL, '2023-08-22 09:38:10.510526', '2023-08-22 09:38:10.510526');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (2, 513, '01.120', NULL, NULL, '2023-08-22 09:38:10.522795', '2023-08-22 09:38:10.522795');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (3, 514, '01.120', '90.012', '70.220', '2023-08-22 09:38:10.53282', '2023-08-22 09:38:10.53282');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (4, 515, '01.120', NULL, NULL, '2023-08-22 09:38:10.551582', '2023-08-22 09:38:10.551582');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (5, 516, '01.120', '90.012', '70.220', '2023-08-22 09:38:10.578526', '2023-08-22 09:38:10.578526');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (6, 527, '01.120', '01.110', '70.220', '2023-08-22 09:38:10.61807', '2023-08-22 09:38:10.61807');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (7, 534, '01.120', NULL, NULL, '2023-08-22 09:38:10.627405', '2023-08-22 09:38:10.627405');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (8, 535, '01.120', '90.012', '70.220', '2023-08-22 09:38:10.6361', '2023-08-22 09:38:10.6361');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (9, 536, '01.120', NULL, NULL, '2023-08-22 09:38:10.656054', '2023-08-22 09:38:10.656054');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (10, 537, '01.120', '90.012', NULL, '2023-08-22 09:38:10.660114', '2023-08-22 09:38:10.660114');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (11, 538, '01.120', NULL, NULL, '2023-08-22 09:38:10.663072', '2023-08-22 09:38:10.663072');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.032968');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.062638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '555555555', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.062638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (6, '839787744', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.062638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '870786887', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.075589');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '831738310', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.075589');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '852219055', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.087555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '864901468', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.117419');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (15, '841483836', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.117419');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (16, '863591192', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.133004');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (17, '802027166', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.133004');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (18, '836717968', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.133004');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (19, '879932797', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.133004');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (20, '823296591', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.148821');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (21, '820146481', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.148821');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (22, '814047931', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.148821');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '801322593', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.148821');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '847425787', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.162322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (25, '883001613', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.162322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '849135518', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.17299');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (27, '895964716', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.17299');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '821516354', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.183172');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (29, '856863238', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.183172');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '880086028', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.192823');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (31, '808068068', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.192823');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '806740783', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.192823');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '819181541', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.207988');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '849679830', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.207988');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '841795547', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.223514');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '870774269', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.231694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '806732255', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.231694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '865205048', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.231694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '870660141', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.231694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '838898262', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.231694');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '873560121', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.242178');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '897973008', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.242178');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '826616693', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.253952');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '823986632', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.264972');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '899589058', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.264972');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '844668375', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.264972');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '886021001', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.275279');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '860900169', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.275279');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '898803736', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.275279');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '828245680', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.298506');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '888290779', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.298506');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '875011973', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.314793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '874365564', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.314793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '858151415', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.314793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '804997375', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.314793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '850040819', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.314793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '840693679', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.314793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '857776986', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.314793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '866036247', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.314793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '850667929', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.314793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '830359127', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.332905');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '893044062', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.332905');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '829376504', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.332905');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '893204151', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.332905');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '885992292', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.332905');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '864187238', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.332905');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '852852541', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.332905');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '877797046', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.347727');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '887069600', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.347727');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '878779387', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.347727');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '831659231', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.347727');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '895594309', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.347727');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '825730193', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.347727');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '824401768', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.363274');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '841900875', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.363274');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '859246845', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.363274');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '827286077', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.363274');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '838729985', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.363274');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '813308826', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.37658');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '862652308', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.37658');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '883198917', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.37658');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '848936697', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.37658');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '899918594', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.395517');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '851430542', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.395517');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '854569765', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.395517');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '847010118', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.395517');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '805454694', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.412259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '817032203', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.412259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '846260715', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.412259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '849843981', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.412259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '885746164', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.412259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '869690752', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.412259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '881109697', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.428031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '856963365', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.428031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '813477373', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.428031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '832653426', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.428031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '873720295', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.428031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '876366654', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.428031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '879131072', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.441703');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '860873225', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.441703');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '860689449', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.461474');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '809386082', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.461474');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '846459403', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.461474');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '804071857', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.461474');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '893592256', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.475901');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '838582133', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.475901');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '837989185', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.475901');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '863727804', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.484528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '822296581', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.484528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '858907718', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.484528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '851028383', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.484528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '897073342', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.484528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '886873501', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.484528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '841316984', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.484528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '864172662', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.484528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '822333912', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.496997');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '864292919', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.496997');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '897716659', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.509215');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '827305958', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.509215');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '824073012', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.521244');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '891664402', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.521244');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '836357240', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.521244');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '845772919', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.542582');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '847975171', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.542582');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '803105560', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.552186');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '851855356', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.567333');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '805793393', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.567333');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '850908478', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.567333');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '894204004', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.567333');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '843281206', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.575641');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '873208866', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.575641');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '888855255', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.575641');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '837074404', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.575641');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '874146343', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.575641');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '884843038', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.575641');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '897205384', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.575641');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '876100247', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.583349');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '866669359', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.583349');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '855075099', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.591276');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '823666053', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.591276');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '869162655', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.597639');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '819283001', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.597639');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '887367142', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.597639');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '838169743', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.609207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '866861430', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.609207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '888586482', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.619063');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '800299031', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.619063');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '880924690', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.635884');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '872907010', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.649695');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '889030810', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.666407');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '880213795', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.666407');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '836943435', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.666407');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '854989189', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.689106');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '884956985', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.689106');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '803585452', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.689106');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '828048373', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.689106');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '855981199', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.70344');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '810545559', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.70344');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '801240374', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.70344');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '872788789', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.70344');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '812896043', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.725139');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '806655101', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.725139');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '835554018', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.725139');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '807569356', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.725139');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '801913253', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.737423');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '853829505', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.737423');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '828653764', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.749752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '809610826', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.749752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '801750564', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.749752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '850738515', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.759698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '847076204', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.759698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '841667843', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.770304');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '866833294', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.780061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '814886185', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.780061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '882869883', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.780061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '855729692', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.793089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '838927410', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.801044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '891519611', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.801044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '865812907', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.801044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '872252965', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.814611');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '869949742', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.82405');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '878247725', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.82405');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '807556695', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.82405');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '830442467', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.833614');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '812321579', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.84271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '854539953', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.84271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '892455454', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.84271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '841143184', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.85278');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '803837738', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.863582');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '851723524', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.863582');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '851637526', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.863582');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '859482259', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.874004');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '861499075', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.890453');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '858454370', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.890453');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '844838677', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.890453');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '879427551', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.890453');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '852588360', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.911822');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '850788100', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.911822');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '886885659', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.911822');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '876531713', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.92906');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '838695007', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.92906');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '834220116', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.92906');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '898760777', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.92906');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '817639962', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.92906');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '873543315', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.950692');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '826698611', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.950692');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '841347020', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.950692');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '851112680', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.950692');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '827402806', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.950692');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '897795909', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.96556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '881649081', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.96556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '869649338', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.96556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '882363737', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.96556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '852281546', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.96556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '868945238', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.96556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '868130071', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.96556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '891695786', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.980701');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '825688329', 'VIRKSOMHET', '2', '2023-08-22 09:38:05.980701');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '873346078', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.980701');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '855571872', 'VIRKSOMHET', '1', '2023-08-22 09:38:05.980701');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '842497026', 'VIRKSOMHET', '3', '2023-08-22 09:38:05.980701');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '892859837', 'VIRKSOMHET', '9', '2023-08-22 09:38:05.998307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '844168925', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.015528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '844840716', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.015528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '837151949', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.015528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '888797844', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.029973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '838119992', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.029973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '824058909', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.041081');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '858060161', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.051494');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '817113974', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.051494');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '896792641', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.051494');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '882919181', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.051494');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '834980687', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.063607');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '883070774', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.063607');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '852015835', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.063607');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '848941760', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.075056');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '822902914', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.075056');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '832247705', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.090935');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '882116682', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.090935');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '802107269', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.090935');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '846973089', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.107596');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '864521767', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.107596');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '876207858', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.107596');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '851863078', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.130141');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '820130534', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.130141');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '894547365', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.130141');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '859881294', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.14209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '844421359', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.14209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '819951285', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.14209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '887136551', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.14209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '871948973', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.14209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '828558357', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.14209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '877775223', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.14209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '899869668', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.153586');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '809075924', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.153586');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '899323316', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.153586');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '803918384', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.153586');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '852164497', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.153586');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '838184629', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.153586');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '801125331', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.164628');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '894607636', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.164628');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '832830623', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.164628');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '865596169', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.164628');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '867396430', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.164628');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '870249548', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.172818');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '882495037', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.172818');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '813457886', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.182377');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '887694884', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.195323');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '812928401', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.195323');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '864000437', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.195323');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '807493576', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.212117');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '848550258', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.212117');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '883655830', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.212117');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '868241232', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.22515');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '838173343', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.22515');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '843899976', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.22515');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '834501836', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.22515');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '853773843', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.22515');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '838600216', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.22515');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '865978885', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.236287');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '809387186', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.236287');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '866320682', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.236287');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '846920550', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.236287');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '800313316', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.247435');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '823018348', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.247435');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '868329884', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.247435');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '816305744', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.260119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '833233885', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.260119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '894003194', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.260119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '837604524', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.267301');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '856528107', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.267301');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '819118508', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.267301');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '872433394', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.275544');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '808752793', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.275544');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '890918442', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.282101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '823701847', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.282101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '890553994', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.298473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '877147267', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.298473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '882140440', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.298473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '866079795', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.309045');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '898670143', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.309045');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '847521107', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.309045');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '805730956', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.320996');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '827112352', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.320996');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '816675961', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.335365');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '809638937', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.347295');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '863177301', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.347295');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '803140852', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.358717');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '817420715', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.358717');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '813717314', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.370111');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '805132598', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.381231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '870203996', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.395778');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '821166157', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.395778');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '867550566', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.395778');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '847112310', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.406848');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '817213081', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.406848');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '834337604', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.406848');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '836556691', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.406848');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '846363486', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.415606');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '880468621', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.415606');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '843130803', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.426398');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '877435097', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.426398');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '869853760', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.435347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '899985690', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.435347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '849298231', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.435347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '875342026', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.435347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '814946848', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.450719');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '885751164', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.450719');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '863988704', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.450719');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '877946210', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.458433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '888422554', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.458433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '850536419', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.458433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '871739994', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.458433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '888243272', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.473339');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '844563328', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.473339');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '896798000', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.473339');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '834493680', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.473339');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '880975000', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.484062');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '891739945', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.484062');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '873468702', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.484062');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '886768356', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.484062');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '889521982', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.484062');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '811700635', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.496492');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '899208586', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.496492');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '841135274', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.510384');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '888077057', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.520599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '853721121', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.520599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '858401466', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.536264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '843465993', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.536264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '885825004', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.536264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '804570885', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.536264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '835688408', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.536264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '826868461', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.546626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '883284079', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.546626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '866282763', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.557435');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '831207270', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.557435');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '802454382', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.557435');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '895516204', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.566833');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '809387257', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.577935');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '806667009', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.577935');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '832374160', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.585536');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '883019749', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.585536');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '834786438', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.598201');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '853515144', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.598201');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '846753798', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.598201');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '848426920', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.610775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '815576107', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.610775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '821549476', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.610775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '864289727', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.610775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '881215018', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.610775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '849154503', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.610775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '881674037', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.635673');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '869536069', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.635673');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '828365404', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.653225');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '875751238', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.653225');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '832012047', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.653225');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '897744919', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.653225');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '846442703', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.653225');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '846073105', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.653225');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '813477912', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.671148');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '821023298', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.671148');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '871027853', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.671148');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '837899275', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.671148');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '839983895', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.671148');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '887074481', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.671148');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '839387187', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.671148');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '811866255', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.684683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '845039819', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.684683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '838256772', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.684683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '811530068', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.684683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '824231431', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.684683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '854883634', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.684683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '891683605', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.697928');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '817692705', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.697928');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '825648278', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.697928');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '822072121', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.697928');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '891795852', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.697928');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '886715933', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.697928');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '837527242', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.707737');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '887509502', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.707737');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '806643602', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.713896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '860128386', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.713896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '868540232', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.713896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '828233887', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.713896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '876650080', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.724705');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '882268990', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.724705');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '865065037', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.743011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '898723823', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.743011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '881585147', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.743011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '812154207', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.758412');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '854476118', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.758412');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '842357468', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.765629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '899607715', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.765629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '881934239', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.765629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '826069364', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.765629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '838438101', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.765629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '807312765', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.765629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '815506850', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.765629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '860169462', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.765629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '811283959', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.776805');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '851251150', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.776805');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '811375581', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.776805');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '807563163', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.799659');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '892139138', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.799659');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '806180143', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.799659');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '857528776', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.815803');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '809175337', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.815803');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '858613497', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.832931');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '863004312', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.832931');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '851277645', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.832931');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '824590590', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.89576');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '813048431', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.89576');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '811686406', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.907999');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '819766970', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.926548');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '807328561', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.946759');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '894901869', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.946759');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '859386741', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.946759');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '892071614', 'VIRKSOMHET', '3', '2023-08-22 09:38:06.946759');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '832870175', 'VIRKSOMHET', '9', '2023-08-22 09:38:06.963428');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '800286644', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.963428');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '825426984', 'VIRKSOMHET', '1', '2023-08-22 09:38:06.982524');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '853766006', 'VIRKSOMHET', '2', '2023-08-22 09:38:06.982524');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '854997008', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.009588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '812886264', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.009588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '884295332', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.009588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '810124461', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.023237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '834935011', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.023237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '807149274', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.023237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '854695094', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.023237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '845210969', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.023237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '869325590', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.023237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '871813139', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.041036');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '833231510', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.041036');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '805879875', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.041036');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '888143042', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.041036');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '851539726', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.049433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '850079442', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.049433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '810538212', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.049433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '873092002', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.049433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '801692952', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.049433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '802390487', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.062306');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '836739362', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.062306');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '880840776', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.062306');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '880695479', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.072752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '848667205', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.072752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '888964420', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.072752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '857973308', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.072752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '867639615', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.080845');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '847465324', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.080845');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '809138406', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.080845');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '877543601', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.089703');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '806766681', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.089703');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '832630464', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.0986');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '847297952', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.0986');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '857028099', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.0986');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '836482812', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.105036');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '864369313', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.105036');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '894282061', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.110857');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '889075473', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.110857');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '857951498', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.110857');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '883166293', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.116154');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '807831211', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.125981');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '825304441', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.13175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '808236409', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.13175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '883829150', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.13175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '885167866', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.139874');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '898161453', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.1453');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '869219583', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.1453');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '838709938', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.151969');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '880347757', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.151969');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '822067638', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.162653');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '823363719', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.162653');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '806457946', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.169929');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '853892287', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.169929');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '840973333', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.177635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '866355728', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.177635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '875178653', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.195164');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '860162579', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.195164');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '801591815', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.204567');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '892846818', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.204567');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '804493146', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.204567');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '818961021', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.204567');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '848500382', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.21744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '869737117', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.21744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '883689945', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.226294');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '853209498', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.226294');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '885018093', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.226294');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '863176447', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.235143');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '828394729', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.246235');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '873835986', 'VIRKSOMHET', '9', '2023-08-22 09:38:07.246235');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '844865841', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.252989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '871177944', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.252989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '847752609', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.252989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '816190926', 'VIRKSOMHET', '2', '2023-08-22 09:38:07.252989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '854682607', 'VIRKSOMHET', '3', '2023-08-22 09:38:07.470079');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '882017147', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.480318');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '826361592', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.480318');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '867891072', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.480318');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '868038487', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.491003');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '836581771', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.491003');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '895255567', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.491003');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '877109551', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.501119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '867213427', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.501119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '870402223', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.501119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '821721410', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.509919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '896232122', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.523447');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '810726031', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.523447');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '808080705', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.523447');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '860083862', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.523447');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '846160762', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.53593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '888126407', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.53593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '899790463', 'VIRKSOMHET', '1', '2023-08-22 09:38:07.543759');


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
-- Name: siste_publiseringsinfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.siste_publiseringsinfo_id_seq', 7, true);


--
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_kategori_siste_4_kvartal_id_seq', 1, false);


--
-- Name: sykefravar_statistikk_land_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_land_id_seq', 1, false);


--
-- Name: sykefravar_statistikk_naring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_naring_id_seq', 1, false);


--
-- Name: sykefravar_statistikk_naringsundergruppe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_naringsundergruppe_id_seq', 1, false);


--
-- Name: sykefravar_statistikk_sektor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_sektor_id_seq', 1, false);


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
-- Name: virksomhet_naringsundergrupper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_naringsundergrupper_id_seq', 11, true);


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
-- Name: siste_publiseringsinfo siste_publiseringsinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.siste_publiseringsinfo
    ADD CONSTRAINT siste_publiseringsinfo_pkey PRIMARY KEY (id);


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
-- Name: virksomhet_naringsundergrupper virksomhet_naringsundergrupper_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_naringsundergrupper
    ADD CONSTRAINT virksomhet_naringsundergrupper_pkey PRIMARY KEY (id);


--
-- Name: virksomhet_naringsundergrupper virksomhet_naringsundergrupper_unik; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_naringsundergrupper
    ADD CONSTRAINT virksomhet_naringsundergrupper_unik UNIQUE (virksomhet);


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
-- Name: virksomhet_naringsundergrupper fk_virksomhet_naringsundergrupper_naring; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_naringsundergrupper
    ADD CONSTRAINT fk_virksomhet_naringsundergrupper_naring FOREIGN KEY (naeringskode1) REFERENCES public.naring(kode);


--
-- Name: virksomhet_naringsundergrupper fk_virksomhet_naringsundergrupper_virksomhet; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_naringsundergrupper
    ADD CONSTRAINT fk_virksomhet_naringsundergrupper_virksomhet FOREIGN KEY (virksomhet) REFERENCES public.virksomhet(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: test
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


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
-- Name: TABLE siste_publiseringsinfo; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.siste_publiseringsinfo TO cloudsqliamuser;


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
-- Name: TABLE virksomhet_naringsundergrupper; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.virksomhet_naringsundergrupper TO cloudsqliamuser;


--
-- PostgreSQL database dump complete
--

