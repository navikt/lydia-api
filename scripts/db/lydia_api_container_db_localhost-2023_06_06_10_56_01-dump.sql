--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-1.pgdg110+1)
-- Dumped by pg_dump version 15.3

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
-- Name: virksomhet_statistikk_metadata id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_statistikk_metadata ALTER COLUMN id SET DEFAULT nextval('public.virksomhet_metadata_id_seq'::regclass);


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', 'V1__init.sql', 1782034767, 'test', '2023-06-06 10:44:53.587897', 36, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', 'V2__create_virksomhet_adresse.sql', -64248919, 'test', '2023-06-06 10:44:53.67329', 36, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', 'V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2023-06-06 10:44:53.87645', 17, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', 'V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2023-06-06 10:44:53.941003', 22, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', 'V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2023-06-06 10:44:54.011387', 29, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', 'V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2023-06-06 10:44:54.088492', 25, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', 'V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2023-06-06 10:44:54.156351', 34, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', 'V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2023-06-06 10:44:54.224498', 21, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', 'V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2023-06-06 10:44:54.293876', 26, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', 'V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2023-06-06 10:44:54.350058', 10, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', 'V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2023-06-06 10:44:54.385591', 12, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', 'V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2023-06-06 10:44:54.424747', 18, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', 'V13__ia_prosess.sql', -1755516749, 'test', '2023-06-06 10:44:54.478253', 14, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', 'V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2023-06-06 10:44:54.523195', 25, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', 'V15__endre_saknummer.sql', -1379621340, 'test', '2023-06-06 10:44:54.582556', 13, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', 'V16__ia_sak_hendelse.sql', 586872662, 'test', '2023-06-06 10:44:54.624184', 43, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', 'V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2023-06-06 10:44:54.702291', 14, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', 'V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2023-06-06 10:44:54.751569', 23, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', 'V19__legg_til_begrunnelser.sql', 779259005, 'test', '2023-06-06 10:44:54.807908', 14, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', 'V20__legg_til_flere_indekser.sql', -843857404, 'test', '2023-06-06 10:44:54.850768', 23, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', 'V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2023-06-06 10:44:54.903556', 12, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', 'V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2023-06-06 10:44:54.950866', 12, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', 'V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2023-06-06 10:44:54.990901', 16, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', 'V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2023-06-06 10:44:55.035245', 19, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', 'V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2023-06-06 10:44:55.082084', 29, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', 'V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2023-06-06 10:44:55.139186', 11, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', 'V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2023-06-06 10:44:55.178136', 15, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', 'V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2023-06-06 10:44:55.220635', 16, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', 'V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2023-06-06 10:44:55.261434', 10, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', 'V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2023-06-06 10:44:55.297596', 11, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', 'V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2023-06-06 10:44:55.332502', 16, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', 'V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2023-06-06 10:44:55.371715', 13, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', 'V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2023-06-06 10:44:55.410325', 9, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', 'V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2023-06-06 10:44:55.446947', 17, true);
INSERT INTO public.flyway_schema_history VALUES (35, '35', 'drop sykefravar statistikk grunnlag', 'SQL', 'V35__drop_sykefravar_statistikk_grunnlag.sql', 461103825, 'test', '2023-06-06 10:44:55.492388', 16, true);
INSERT INTO public.flyway_schema_history VALUES (36, '36', 'registrere bistand', 'SQL', 'V36__registrere_bistand.sql', -1365283904, 'test', '2023-06-06 10:44:55.534752', 35, true);
INSERT INTO public.flyway_schema_history VALUES (37, '37', 'fullfoert dato leveranse', 'SQL', 'V37__fullfoert_dato_leveranse.sql', 1621470787, 'test', '2023-06-06 10:44:55.5999', 12, true);
INSERT INTO public.flyway_schema_history VALUES (38, '38', 'oppdatere moduler', 'SQL', 'V38__oppdatere_moduler.sql', -246234034, 'test', '2023-06-06 10:44:55.638239', 20, true);
INSERT INTO public.flyway_schema_history VALUES (39, '39', 'rette iatjeneste på modul', 'SQL', 'V39__rette_iatjeneste_på_modul.sql', -1034067650, 'test', '2023-06-06 10:44:55.68562', 10, true);
INSERT INTO public.flyway_schema_history VALUES (40, '40', 'legg til rolle ia sak hendelse', 'SQL', 'V40__legg_til_rolle_ia_sak_hendelse.sql', -82283870, 'test', '2023-06-06 10:44:55.721478', 15, true);
INSERT INTO public.flyway_schema_history VALUES (41, '41', 'legg til rolle ia sak leveranse', 'SQL', 'V41__legg_til_rolle_ia_sak_leveranse.sql', -2029318456, 'test', '2023-06-06 10:44:55.77096', 12, true);
INSERT INTO public.flyway_schema_history VALUES (42, '42', 'legg til deaktivert', 'SQL', 'V42__legg_til_deaktivert.sql', 1170357332, 'test', '2023-06-06 10:44:55.811937', 20, true);
INSERT INTO public.flyway_schema_history VALUES (43, '43', 'siste publiseringsinfo tabell', 'SQL', 'V43__siste_publiseringsinfo_tabell.sql', -1555520829, 'test', '2023-06-06 10:44:55.85814', 15, true);
INSERT INTO public.flyway_schema_history VALUES (44, '44', 'hendelse nav enhet', 'SQL', 'V44__hendelse_nav_enhet.sql', -1118774222, 'test', '2023-06-06 10:44:55.897019', 12, true);
INSERT INTO public.flyway_schema_history VALUES (45, '45', 'oppdatere siste publiseringsinfo', 'SQL', 'V45__oppdatere_siste_publiseringsinfo.sql', -1919960111, 'test', '2023-06-06 10:44:55.937491', 10, true);
INSERT INTO public.flyway_schema_history VALUES (46, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 1760553224, 'test', '2023-06-06 10:44:55.968262', 14, true);
INSERT INTO public.flyway_schema_history VALUES (47, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -1079321833, 'test', '2023-06-06 10:45:38.605718', 47, true);


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

INSERT INTO public.siste_publiseringsinfo VALUES (1, 2022, 4, '2023-03-02 00:00:00', '2023-06-01 00:00:00', '2023-06-06 10:44:55.866481');
INSERT INTO public.siste_publiseringsinfo VALUES (2, 2023, 1, '2023-06-01 00:00:00', '2023-09-07 00:00:00', '2023-06-06 10:44:55.946966');


--
-- Data for Name: sykefravar_statistikk_kategori_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_land; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_land VALUES (1, 2023, 1, 'NO', 2500000, 10000000, 500000000, 2, false, '2023-06-06 10:45:46.131236');
INSERT INTO public.sykefravar_statistikk_land VALUES (2, 2022, 4, 'NO', 2500000, 10000000, 500000000, 2, false, '2023-06-06 10:45:46.293074');


--
-- Data for Name: sykefravar_statistikk_naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naring VALUES (1, 2023, 1, '01', 150, 100, 5000, 2, false, '2023-06-06 10:45:46.131236');
INSERT INTO public.sykefravar_statistikk_naring VALUES (2, 2022, 4, '01', 150, 100, 5000, 2, false, '2023-06-06 10:45:46.293074');


--
-- Data for Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naringsundergruppe VALUES (1, 2023, 1, '01.110', 1250, 40, 4000, 1, false, '2023-06-06 10:45:46.131236');
INSERT INTO public.sykefravar_statistikk_naringsundergruppe VALUES (2, 2022, 4, '01.110', 1250, 40, 4000, 1, false, '2023-06-06 10:45:46.293074');


--
-- Data for Name: sykefravar_statistikk_sektor; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_sektor VALUES (1, 2023, 1, '1', 33000, 1340, 8000, 1.5, false, '2023-06-06 10:45:46.131236');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (2, 2022, 4, '1', 33000, 1340, 8000, 1.5, false, '2023-06-06 10:45:46.293074');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (15, 2023, 1, '3', 33000, 1340, 8000, 1.5, false, '2023-06-06 10:45:46.48119');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (17, 2023, 1, '0', 33000, 1340, 8000, 1.5, false, '2023-06-06 10:45:46.48119');
INSERT INTO public.sykefravar_statistikk_sektor VALUES (18, 2023, 1, '2', 33000, 1340, 8000, 1.5, false, '2023-06-06 10:45:46.48119');


--
-- Data for Name: sykefravar_statistikk_virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2023, 1, 6, 6476.52028313422, 500, 15, false, '2023-06-06 10:45:46.131236', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2022, 4, 6, 6476.52028313422, 500, 2, false, '2023-06-06 10:45:46.293074', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2023, 1, 537.623725879261, 4369.13449874745, 500, 7, false, '2023-06-06 10:45:46.293074', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2022, 4, 537.623725879261, 4369.13449874745, 500, 7, false, '2023-06-06 10:45:46.293074', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '555555555', 2023, 1, 148.046684128494, 9036.32308844725, 500, 14, false, '2023-06-06 10:45:46.293074', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '802206409', 2023, 1, 197.060864731709, 742.407356313841, 500, 6, false, '2023-06-06 10:45:46.293074', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '802206409', 2022, 4, 197.060864731709, 742.407356313841, 500, 6, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '817238182', 2023, 1, 42, 7842.40119583752, 500, 6, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '817238182', 2022, 4, 42, 7842.40119583752, 500, 6, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '833560632', 2023, 1, 42, 4796.59997897486, 500, 6, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '833560632', 2022, 4, 42, 4796.59997897486, 500, 6, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '877816099', 2023, 1, 24.1750969365967, 986.112148662488, 500, 19, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '877816099', 2022, 4, 24.1750969365967, 986.112148662488, 500, 2, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '894512904', 2023, 1, 64.72865657185, 5999.31414838921, 500, 12, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '830314374', 2023, 1, 947.749433394375, 1791.02193005409, 500, 10, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '805214180', 2023, 1, 203.69796846565, 8538.73342732172, 500, 3, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '857899421', 2023, 1, 820.852715741302, 2964.41072544471, 500, 9, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '807598834', 2023, 1, 272.629313559411, 5574.20287152499, 500, 19, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '865882840', 2023, 1, 709.360972869845, 1571.76528849081, 500, 9, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '808703328', 2023, 1, 749.264286739489, 9808.33483838023, 500, 13, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '851321904', 2023, 1, 132.049180945763, 7666.5385525158, 500, 6, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '804091455', 2023, 1, 569.26408758455, 6135.06070610561, 500, 11, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '851037073', 2023, 1, 610.554766821557, 657.654472292478, 500, 17, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '884576933', 2023, 1, 507.560077298127, 171.676158784398, 500, 10, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '831138079', 2023, 1, 501.540777746824, 8223.33040630282, 500, 9, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '814552794', 2023, 1, 189.825991538583, 7211.56711599252, 500, 3, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '830511836', 2023, 1, 138.152939828082, 7822.28863963058, 500, 8, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '859086141', 2023, 1, 346.243297065721, 5607.30663983468, 500, 1, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '839168077', 2023, 1, 391.614043595385, 6000.45700743786, 500, 16, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '874706819', 2023, 1, 296.523723688895, 2349.38023132361, 500, 8, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '884094771', 2023, 1, 422.860849850251, 4038.55264020522, 500, 11, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '899271514', 2023, 1, 64.4307863786791, 8578.45208828314, 500, 2, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '846989088', 2023, 1, 25.4751803466243, 4011.37324884322, 500, 6, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '801686721', 2023, 1, 752.936793381196, 5271.32352264077, 500, 5, false, '2023-06-06 10:45:46.48119', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '861804179', 2023, 1, 646.24497580892, 412.429096919229, 500, 10, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '889949417', 2023, 1, 300.201281286614, 4891.39138846186, 500, 19, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '872469874', 2023, 1, 879.015877739289, 6575.6204006657, 500, 12, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '899093031', 2023, 1, 922.596892535466, 939.206274228541, 500, 19, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '803845912', 2023, 1, 590.518968758291, 265.725466856902, 500, 20, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '833081148', 2023, 1, 541.832307793914, 6175.48088059876, 500, 11, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '830011128', 2023, 1, 103.156485375274, 1541.55499088968, 500, 12, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '822555920', 2023, 1, 485.702157874105, 2991.17784118741, 500, 1, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '877133946', 2023, 1, 644.889811053292, 5831.75325507796, 500, 6, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '828674185', 2023, 1, 242.666612993785, 8701.96289819982, 500, 6, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '832079589', 2023, 1, 557.68226541661, 1144.97386819272, 500, 2, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '875081061', 2023, 1, 320.592921698582, 7453.41873321332, 500, 6, false, '2023-06-06 10:45:46.891184', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '873375519', 2023, 1, 339.63302075157, 9954.66235668007, 500, 19, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '887251443', 2023, 1, 26.1830099618962, 4182.56606853413, 500, 5, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '874646342', 2023, 1, 750.643509699163, 466.166146601204, 500, 4, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '831499694', 2023, 1, 359.222536801613, 601.917574129909, 500, 18, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '822980831', 2023, 1, 618.278013265261, 5475.45795695256, 500, 15, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '830194175', 2023, 1, 457.39426875538, 4925.66982977515, 500, 14, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '827312615', 2023, 1, 477.421246098626, 503.965000688082, 500, 19, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '835878464', 2023, 1, 571.799729708755, 5404.84007400116, 500, 2, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '881680637', 2023, 1, 289.553521635108, 3561.10066249698, 500, 2, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '820135331', 2023, 1, 807.580287839578, 6909.95874512596, 500, 20, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '881400208', 2023, 1, 701.777364777768, 6576.95207022072, 500, 11, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '853050436', 2023, 1, 439.356452682, 2441.99355160438, 500, 4, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '841275516', 2023, 1, 743.879203687301, 7135.1268144685, 500, 19, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '824524816', 2023, 1, 522.139785236167, 949.605399342539, 500, 17, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '814689949', 2023, 1, 441.114439859033, 5983.70533446239, 500, 3, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '827119452', 2023, 1, 557.270186361152, 2964.05386355005, 500, 17, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '863719122', 2023, 1, 859.133794621631, 3711.94077781854, 500, 17, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '822266321', 2023, 1, 48.1445779769834, 3470.51157978126, 500, 1, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '891071007', 2023, 1, 508.32482679574, 1101.93896445042, 500, 19, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '835751993', 2023, 1, 483.631921063017, 8425.06520377728, 500, 17, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '833267554', 2023, 1, 660.694515659051, 8957.43684577703, 500, 10, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '857267460', 2023, 1, 919.809767114024, 2291.74685588613, 500, 18, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '880192549', 2023, 1, 877.035478791506, 1681.1794891786, 500, 6, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '863030247', 2023, 1, 637.423301978752, 5732.36795696516, 500, 5, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '828419851', 2023, 1, 429.125200170877, 3045.92135353722, 500, 13, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '861621931', 2023, 1, 534.385511296286, 2540.61885226531, 500, 5, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '890183280', 2023, 1, 736.631022911968, 6423.81492558929, 500, 6, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '860086485', 2023, 1, 633.983807837818, 5339.29156283644, 500, 2, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '863578303', 2023, 1, 46.2938262477037, 3264.22161626132, 500, 7, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '895892630', 2023, 1, 452.412385281611, 689.218034678826, 500, 11, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '803570351', 2023, 1, 999.083415736892, 2030.16202520357, 500, 9, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '876823186', 2023, 1, 83.0138573863591, 9964.38745844391, 500, 12, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '803808918', 2023, 1, 566.438750342765, 5606.09256072682, 500, 7, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '849083854', 2023, 1, 187.996693583192, 1298.21568931996, 500, 3, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '826475210', 2023, 1, 131.760116558687, 8053.96881062124, 500, 6, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '808599455', 2023, 1, 685.43949398023, 723.163695506587, 500, 5, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '899095286', 2023, 1, 175.576821544509, 6807.73985128734, 500, 10, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '856815634', 2023, 1, 386.208986530317, 6996.81295955283, 500, 9, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '894474489', 2023, 1, 328.148064800961, 3751.95048943212, 500, 1, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '812047191', 2023, 1, 400.203558948569, 2678.01797966444, 500, 6, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '890777552', 2023, 1, 570.413175661974, 5866.05793879398, 500, 9, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '820722587', 2023, 1, 617.085908521535, 7158.55521285522, 500, 15, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '809436178', 2023, 1, 822.656735281282, 7981.57698105306, 500, 17, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '810376980', 2023, 1, 751.156351588298, 9950.54954110613, 500, 4, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '890238030', 2023, 1, 506.558983119226, 5865.63278511257, 500, 14, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '828266999', 2023, 1, 732.352679886976, 2652.65152063747, 500, 6, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '862940033', 2023, 1, 504.445670290074, 4174.79619039244, 500, 9, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '880379202', 2023, 1, 527.304333876631, 8802.55594482565, 500, 5, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '810151455', 2023, 1, 105.467817115091, 9771.76845512679, 500, 12, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '881250314', 2023, 1, 64.4661793682626, 920.834500143511, 500, 20, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '875197324', 2023, 1, 714.674893053679, 2960.33925210185, 500, 15, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '824805720', 2023, 1, 141.933212713558, 9243.65613255343, 500, 5, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '842090861', 2023, 1, 613.451123709448, 5297.63671860464, 500, 16, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '813258691', 2023, 1, 266.752160009487, 3126.14841922406, 500, 7, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '882246146', 2023, 1, 202.374973848745, 8753.04635908237, 500, 13, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '891407332', 2023, 1, 870.819804945466, 7195.46143873603, 500, 15, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '862068389', 2023, 1, 155.644103596014, 728.495446995765, 500, 10, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '820736881', 2023, 1, 475.997873752527, 9787.62244214577, 500, 2, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '860629351', 2023, 1, 302.915358325979, 1218.67204319862, 500, 3, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '872381491', 2023, 1, 320.242314593836, 6415.41609776528, 500, 8, false, '2023-06-06 10:45:47.106162', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '830484510', 2023, 1, 702.363973210205, 617.017388035113, 500, 17, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '861732339', 2023, 1, 242.732720976403, 9609.12300133947, 500, 9, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '813199268', 2023, 1, 97.5845458339209, 2851.19255278897, 500, 15, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '821624303', 2023, 1, 184.298234028806, 5752.96713447464, 500, 10, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '856736407', 2023, 1, 707.137127531573, 4039.9805664242, 500, 4, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '897400542', 2023, 1, 876.021969848468, 2556.22166182627, 500, 17, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '895097486', 2023, 1, 453.046009796079, 8366.88369054478, 500, 19, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '884021287', 2023, 1, 207.721437117605, 9737.30663048436, 500, 15, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '802114238', 2023, 1, 184.755951906232, 2642.5313838239, 500, 5, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '842307904', 2023, 1, 417.683226172205, 7487.79221035843, 500, 8, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '892504040', 2023, 1, 119.758691783615, 7837.80072882639, 500, 13, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '865477980', 2023, 1, 864.52112323855, 9735.02365214535, 500, 20, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '828426342', 2023, 1, 810.860235319644, 2925.75992662001, 500, 5, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '869151445', 2023, 1, 709.610437245442, 5699.08965666138, 500, 6, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '859899076', 2023, 1, 515.575453309437, 9657.88753045316, 500, 17, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '821684747', 2023, 1, 818.131070547678, 6817.12105692536, 500, 15, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '897449659', 2023, 1, 504.042493033193, 952.965583292063, 500, 13, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '878526531', 2023, 1, 570.825452406566, 3597.48243375965, 500, 14, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '855164299', 2023, 1, 606.258440909483, 5644.42225060524, 500, 5, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '855192908', 2023, 1, 540.058177464645, 9866.92089637095, 500, 4, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '806689657', 2023, 1, 185.286538103659, 3905.635326842, 500, 1, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '878761080', 2023, 1, 379.736484395025, 4965.27947112929, 500, 11, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '848968830', 2023, 1, 197.647841982248, 7640.45103576213, 500, 14, false, '2023-06-06 10:45:47.65219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '885536119', 2023, 1, 577.377652316212, 8652.80456277817, 500, 5, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '878526130', 2023, 1, 903.548446726678, 7484.17340199662, 500, 11, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '843341562', 2023, 1, 324.821053017129, 7378.81927880004, 500, 10, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '800736288', 2023, 1, 776.692678874673, 6760.2303043061, 500, 20, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '807244123', 2023, 1, 389.334777506339, 6347.53014978859, 500, 11, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '877731403', 2023, 1, 641.326013569087, 8172.15314732275, 500, 18, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '888781937', 2023, 1, 836.54636523387, 7982.64484673178, 500, 2, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '806466365', 2023, 1, 671.025492285319, 6615.07062732468, 500, 18, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '800646971', 2023, 1, 541.79528358948, 3674.87322455846, 500, 14, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '803919694', 2023, 1, 813.725532705155, 523.61971239828, 500, 5, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '813551155', 2023, 1, 485.121655214867, 134.587302467745, 500, 2, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '824705088', 2023, 1, 704.941485915981, 1735.28298429648, 500, 4, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '823188933', 2023, 1, 34.3925977192317, 180.57318783053, 500, 18, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '808053770', 2023, 1, 272.375689406338, 3807.14425762514, 500, 9, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '837635993', 2023, 1, 510.305094261653, 7261.42577740175, 500, 1, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '823114501', 2023, 1, 62.5751619665807, 1415.83964776622, 500, 7, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '885375930', 2023, 1, 679.762572274501, 4201.82629159779, 500, 2, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '813722685', 2023, 1, 110.702399617544, 7007.06270749825, 500, 10, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '848590489', 2023, 1, 502.466799348234, 4550.64098597615, 500, 6, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '817418290', 2023, 1, 467.88982416791, 4025.27017260201, 500, 19, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '872291593', 2023, 1, 457.013179261356, 9030.86840120268, 500, 11, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '843802830', 2023, 1, 165.163716844132, 6254.09304989802, 500, 20, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '821596869', 2023, 1, 820.979211496915, 9270.70172915567, 500, 15, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '834239593', 2023, 1, 638.074807324917, 9708.16599245152, 500, 9, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '870405555', 2023, 1, 454.763705803166, 9024.95239055414, 500, 3, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '862737958', 2023, 1, 590.520319622533, 5893.14438655108, 500, 18, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '894071655', 2023, 1, 374.047013852326, 5112.76213363162, 500, 6, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '837969510', 2023, 1, 461.905212878607, 8269.09623504651, 500, 20, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '882289746', 2023, 1, 766.473187466665, 7943.39677321412, 500, 20, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '817085642', 2023, 1, 104.803278898928, 1514.6614332339, 500, 1, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '855446362', 2023, 1, 362.235695903931, 9155.18170874991, 500, 3, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '863729203', 2023, 1, 912.153150208257, 8496.15877244848, 500, 10, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '865462877', 2023, 1, 707.018880694461, 7736.43610551802, 500, 15, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '877210079', 2023, 1, 975.677663318543, 2665.44806299076, 500, 14, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '837164320', 2023, 1, 604.865664494219, 6401.68655149526, 500, 20, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '851474063', 2023, 1, 266.861755583789, 4941.50222343366, 500, 2, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '860815002', 2023, 1, 762.817329707226, 770.970217749899, 500, 14, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '862485363', 2023, 1, 232.805055503461, 2488.09305400914, 500, 15, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '849849370', 2023, 1, 831.762698428786, 2459.87524957516, 500, 11, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '873754409', 2023, 1, 984.617316813582, 1503.8327746555, 500, 3, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '873757754', 2023, 1, 782.760325346905, 4026.308169527, 500, 17, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '892804834', 2023, 1, 235.058033993634, 2526.67663854359, 500, 6, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '858511028', 2023, 1, 93.5712293611255, 3271.01545891856, 500, 6, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '883788031', 2023, 1, 441.605903907052, 4981.92588154032, 500, 10, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '831779482', 2023, 1, 312.35470526815, 8192.0320204661, 500, 2, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '850012617', 2023, 1, 112.912844044757, 6290.68862079811, 500, 11, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '843819388', 2023, 1, 779.101106201067, 6111.43306227754, 500, 4, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '884434614', 2023, 1, 273.87067794946, 6191.79184680965, 500, 14, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '824703877', 2023, 1, 852.198579841883, 1594.75102721515, 500, 17, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '820025728', 2023, 1, 162.023515421677, 5432.40692830786, 500, 9, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '898643131', 2023, 1, 634.054246477137, 8563.19490680555, 500, 9, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '807776086', 2023, 1, 532.867865211752, 9268.71776705619, 500, 16, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '869091104', 2023, 1, 736.084526044419, 649.594173796642, 500, 12, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '876709104', 2023, 1, 962.968935025392, 48.8190119426196, 500, 16, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '846022208', 2023, 1, 35.3379286700377, 3256.09725172148, 500, 14, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '849221593', 2023, 1, 706.468731778526, 6238.06671022756, 500, 10, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '803983066', 2023, 1, 214.259748256923, 4029.29205296315, 500, 19, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '852614210', 2023, 1, 803.304357485753, 5068.21315890764, 500, 12, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '807367405', 2023, 1, 989.338782848548, 8449.18656202151, 500, 12, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '818482835', 2023, 1, 670.595281146164, 2778.07085637912, 500, 15, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '843050701', 2023, 1, 421.719318313305, 9371.75927064901, 500, 14, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '828046592', 2023, 1, 529.862190620499, 4512.22792389604, 500, 5, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '867914628', 2023, 1, 204.456426114328, 7319.00045249342, 500, 18, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '806486960', 2023, 1, 771.57572161441, 8031.08143440854, 500, 4, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '854307799', 2023, 1, 406.045351824536, 5776.7278521673, 500, 4, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '898974597', 2023, 1, 482.856095766859, 1604.15120525915, 500, 14, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '823872476', 2023, 1, 209.400420811513, 6353.89406095076, 500, 1, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '890435197', 2023, 1, 148.392503992505, 5763.2286595318, 500, 13, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '846425401', 2023, 1, 322.480331589906, 636.915803039248, 500, 20, false, '2023-06-06 10:45:47.92082', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '852145296', 2023, 1, 236.740326521891, 6088.61973545475, 500, 3, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '862444419', 2023, 1, 48.8785674305947, 6241.99897462651, 500, 8, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '879842491', 2023, 1, 133.146674957258, 2719.53038135161, 500, 12, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '882660143', 2023, 1, 291.131189360463, 3197.94860649463, 500, 3, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '881043298', 2023, 1, 863.649288261597, 7555.99433426711, 500, 20, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '893165291', 2023, 1, 618.232489177475, 663.487480517921, 500, 10, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '827941273', 2023, 1, 959.021275914849, 4808.84086065863, 500, 5, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '861881935', 2023, 1, 323.699163003907, 9643.13823634855, 500, 20, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '802174984', 2023, 1, 126.190974067426, 8512.89295983963, 500, 18, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '858521935', 2023, 1, 859.5115601083, 2390.24949759046, 500, 19, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '818345166', 2023, 1, 360.68292183236, 4473.39918104981, 500, 16, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '810280375', 2023, 1, 708.265164058702, 7766.23487638533, 500, 6, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '882063649', 2023, 1, 966.177952901113, 3874.51044339701, 500, 5, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '880150041', 2023, 1, 664.727411659255, 3525.20871015964, 500, 17, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '815490887', 2023, 1, 223.01891265529, 1124.42130540097, 500, 1, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '839389387', 2023, 1, 679.288618956916, 5418.51290308635, 500, 8, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '884601388', 2023, 1, 493.91688950057, 508.632835570031, 500, 19, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '879432294', 2023, 1, 600.014656055415, 2164.23695138964, 500, 7, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '810840234', 2023, 1, 909.374215719557, 3489.58992923325, 500, 16, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '867469531', 2023, 1, 636.839264143981, 2368.23548123795, 500, 18, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '881832224', 2023, 1, 106.641787852295, 8647.96659946666, 500, 15, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '845694125', 2023, 1, 808.984161532538, 2433.3021942012, 500, 10, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '882816948', 2023, 1, 856.632725023772, 2370.66516368744, 500, 17, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '860781085', 2023, 1, 253.692512753944, 27.1138268512301, 500, 13, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '873714751', 2023, 1, 592.942380369564, 3551.18324164811, 500, 18, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '868280217', 2023, 1, 460.474699359488, 3913.24033981406, 500, 12, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '810425682', 2023, 1, 208.769900506028, 1728.64746274431, 500, 11, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '831398808', 2023, 1, 184.906594580708, 6980.38064078389, 500, 7, false, '2023-06-06 10:45:48.321448', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '864416095', 2023, 1, 483.245571208564, 8394.57662774295, 500, 2, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '817595343', 2023, 1, 931.217597352222, 5469.81457264483, 500, 11, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '813096765', 2023, 1, 733.90488168056, 3063.99137258399, 500, 13, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '874523779', 2023, 1, 67.1824101806578, 9232.81834642925, 500, 8, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '834142018', 2023, 1, 369.893757776789, 814.331075651115, 500, 6, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '859964256', 2023, 1, 353.171022490598, 1688.34306652636, 500, 19, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '867569758', 2023, 1, 746.70447779566, 7360.09853594688, 500, 11, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '892088330', 2023, 1, 10.4660544157069, 5553.49377191572, 500, 3, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '879804077', 2023, 1, 35.6126186739699, 9965.42079038338, 500, 17, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '838407602', 2023, 1, 934.780566322769, 5946.93793090674, 500, 16, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '817713278', 2023, 1, 241.610469221899, 3180.44195544818, 500, 2, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '881609271', 2023, 1, 107.257376870985, 9928.43908077212, 500, 2, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '803204320', 2023, 1, 611.606312096205, 3959.96803347755, 500, 2, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '898881449', 2023, 1, 235.321162107434, 5465.58629590687, 500, 3, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '878218652', 2023, 1, 513.588450074417, 9182.82507559112, 500, 8, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '843707057', 2023, 1, 926.900235490629, 6609.73639555046, 500, 18, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '823280302', 2023, 1, 703.528631387402, 6909.79857797123, 500, 15, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '865097217', 2023, 1, 784.067324130083, 8513.53493501643, 500, 9, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '898114130', 2023, 1, 323.850761076978, 1657.54447445337, 500, 19, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '889994777', 2023, 1, 508.821262462795, 9950.41688251492, 500, 16, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '831772738', 2023, 1, 905.689254259748, 7348.12825400397, 500, 2, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '821965543', 2023, 1, 827.390640382529, 354.382333575036, 500, 17, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '824144039', 2023, 1, 65.521772892945, 9081.95264064434, 500, 20, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '813952219', 2023, 1, 49.4242632851659, 5630.09385455991, 500, 15, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '806033550', 2023, 1, 354.718376869128, 9564.8420485763, 500, 19, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '863033699', 2023, 1, 458.440829884752, 9714.66539764633, 500, 10, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '830460419', 2023, 1, 550.805171858058, 6548.55300271404, 500, 2, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '862572039', 2023, 1, 513.12077569012, 5968.46955833045, 500, 8, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '872881350', 2023, 1, 765.690917838562, 6509.19432808508, 500, 18, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '865076375', 2023, 1, 858.178142814363, 4221.19890064202, 500, 11, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '892105387', 2023, 1, 929.863588899617, 6019.81957973443, 500, 14, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '837331399', 2023, 1, 424.555817811421, 3470.46958357434, 500, 6, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '895071510', 2023, 1, 950.850586929321, 7058.99141801699, 500, 1, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '841293887', 2023, 1, 643.92159926026, 2966.27546872376, 500, 11, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '800500213', 2023, 1, 721.76701565578, 3384.66363746504, 500, 6, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '830955221', 2023, 1, 448.59702323648, 5647.63143547564, 500, 15, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '889579186', 2023, 1, 159.473881146623, 9565.29399345321, 500, 7, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '855457757', 2023, 1, 845.134711968185, 9574.48838134411, 500, 4, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '831090240', 2023, 1, 459.003866901673, 2717.78776089344, 500, 13, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '870649563', 2023, 1, 796.952218949321, 5571.54247321485, 500, 20, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '857087897', 2023, 1, 5.64136947340653, 4929.48994444586, 500, 7, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '801668365', 2023, 1, 493.369041376457, 1116.29117879407, 500, 2, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '843548104', 2023, 1, 815.584954585549, 4612.66069631147, 500, 9, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '843679245', 2023, 1, 595.254266102781, 5649.96660874079, 500, 14, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '856500575', 2023, 1, 609.5052127529, 2587.68281623742, 500, 7, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '856001243', 2023, 1, 7.03343109822486, 2923.08213477647, 500, 12, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '817878762', 2023, 1, 712.989028964968, 482.848021474457, 500, 1, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '838146594', 2023, 1, 618.515900288992, 6945.43261459855, 500, 19, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '840075284', 2023, 1, 111.664614284249, 1357.86500174905, 500, 7, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '821662895', 2023, 1, 346.914346783415, 4953.23411067143, 500, 12, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '843837108', 2023, 1, 819.27401925557, 8918.2822233032, 500, 2, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '845031784', 2023, 1, 37.5762496549959, 7247.89287511243, 500, 20, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '875565818', 2023, 1, 487.398730740448, 6700.86872221433, 500, 17, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '803038597', 2023, 1, 329.954765508724, 8446.36613607184, 500, 20, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '839555854', 2023, 1, 583.2887253084, 5097.03824606834, 500, 20, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '857557135', 2023, 1, 850.643008918404, 9642.79819939732, 500, 4, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '815608021', 2023, 1, 107.6106583203, 1685.61706898382, 500, 20, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '893397601', 2023, 1, 731.14519845145, 4174.14963069448, 500, 15, false, '2023-06-06 10:45:48.504909', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '824822764', 2023, 1, 699.759188261712, 2935.30210094462, 500, 20, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '858635007', 2023, 1, 488.467261052096, 8677.77073505623, 500, 17, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '860185319', 2023, 1, 473.19798274422, 3459.72399692105, 500, 7, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '874789310', 2023, 1, 754.284395506095, 3739.50000927671, 500, 5, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '895950630', 2023, 1, 908.233477488634, 4559.47450725412, 500, 3, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '812733329', 2023, 1, 726.897786758978, 1974.32531850782, 500, 2, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '849504303', 2023, 1, 979.588642159636, 9746.24267919862, 500, 18, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '810836388', 2023, 1, 713.577635657468, 6618.21510163938, 500, 8, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '893711345', 2023, 1, 550.500098984743, 8095.59643732932, 500, 4, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '883273560', 2023, 1, 957.855570714526, 8509.15542964996, 500, 8, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '857320873', 2023, 1, 366.101290045665, 9579.93495878852, 500, 18, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '894715113', 2023, 1, 842.085302017695, 503.997497018983, 500, 13, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '874369743', 2023, 1, 734.382310052603, 454.76974212122, 500, 9, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '859338769', 2023, 1, 653.894204114191, 3743.30247804525, 500, 13, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '822981319', 2023, 1, 740.831074598528, 1256.90165093908, 500, 3, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '894746652', 2023, 1, 484.07228487354, 9622.40300751521, 500, 3, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '820460458', 2023, 1, 199.719995995341, 5842.17865475874, 500, 14, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '836428741', 2023, 1, 207.190409425084, 4517.60254603528, 500, 15, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '808239579', 2023, 1, 924.975474752626, 4498.81939806223, 500, 4, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '853991955', 2023, 1, 794.698098514841, 4876.80595087737, 500, 15, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '821827369', 2023, 1, 80.8566786247291, 9149.97920823335, 500, 20, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '853794730', 2023, 1, 771.677760494492, 2098.27303969314, 500, 10, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '877750244', 2023, 1, 379.078386291887, 8673.93355819231, 500, 5, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '886802160', 2023, 1, 985.768101857862, 3762.26067415787, 500, 9, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '825906262', 2023, 1, 537.145116185747, 6941.23653706205, 500, 18, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '830671460', 2023, 1, 976.570562678349, 7015.40422688013, 500, 8, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '886022624', 2023, 1, 347.842501825479, 4893.3712839386, 500, 10, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '845456654', 2023, 1, 799.217620680956, 5469.16856776812, 500, 10, false, '2023-06-06 10:45:49.159135', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '884934109', 2023, 1, 478.642283183912, 5692.77260748085, 500, 18, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '893013889', 2023, 1, 102.38246191335, 7678.62435471133, 500, 3, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '874793666', 2023, 1, 680.087305793803, 4097.90366170204, 500, 19, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '839840143', 2023, 1, 462.175553175547, 1210.14618884418, 500, 3, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '855087843', 2023, 1, 208.685887690022, 3616.5940196898, 500, 16, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '803909703', 2023, 1, 283.556493075309, 2877.00538886625, 500, 12, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '835613827', 2023, 1, 106.89039066078, 5050.9092029824, 500, 10, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '890368704', 2023, 1, 946.804743046018, 9567.98511194231, 500, 3, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '835188155', 2023, 1, 403.877546534066, 3955.70222087835, 500, 5, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '800268973', 2023, 1, 25.6773923993856, 9021.83641241874, 500, 20, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '823381866', 2023, 1, 42.6084207467099, 4999.80423106925, 500, 14, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '819345705', 2023, 1, 978.289579407251, 373.478677888418, 500, 10, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '858313561', 2023, 1, 955.50721139494, 6100.23496470549, 500, 5, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '807334012', 2023, 1, 789.204344131915, 9557.04250696876, 500, 7, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '896839457', 2023, 1, 444.690199538738, 8993.80689803795, 500, 5, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '893504480', 2023, 1, 498.009907986056, 3997.2656917991, 500, 16, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '811376499', 2023, 1, 562.941278903894, 2539.72332018963, 500, 5, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '839956153', 2023, 1, 310.714940145424, 2016.32560641886, 500, 6, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '880478707', 2023, 1, 245.20914530435, 3948.84735498564, 500, 20, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '885376947', 2023, 1, 10.5151821122896, 477.033303002382, 500, 17, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '872081220', 2023, 1, 408.120864072308, 3736.24200130963, 500, 5, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '822891769', 2023, 1, 336.01444468492, 6491.26311561288, 500, 18, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '805863410', 2023, 1, 762.745114809443, 7647.47334153004, 500, 5, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '863609151', 2023, 1, 762.119229972728, 530.801057698341, 500, 1, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '848216997', 2023, 1, 890.037972338291, 5229.24941730091, 500, 16, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '865120206', 2023, 1, 29.1766478575133, 7387.70062999252, 500, 19, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '866740216', 2023, 1, 785.53506821364, 2724.30025455263, 500, 10, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '864140200', 2023, 1, 775.815488590535, 3991.60301915717, 500, 9, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '897926718', 2023, 1, 566.90646891457, 7751.76880148151, 500, 19, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '884422045', 2023, 1, 788.24565758077, 9205.15674403165, 500, 7, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '820615064', 2023, 1, 997.968417614183, 5481.2344433153, 500, 18, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '864666925', 2023, 1, 842.613469966858, 4461.95063820654, 500, 17, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '835261981', 2023, 1, 922.516258118781, 4831.38050115195, 500, 17, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '881186163', 2023, 1, 424.32887414166, 475.384758315075, 500, 12, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '830886980', 2023, 1, 889.355433514891, 6606.84847420869, 500, 6, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '881297676', 2023, 1, 32.3150978618119, 2520.95719007493, 500, 18, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '846943054', 2023, 1, 699.687207446218, 9814.95003753564, 500, 18, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '858637684', 2023, 1, 450.409313401103, 1718.8574321701, 500, 3, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '808580153', 2023, 1, 495.006796324835, 5330.36709070747, 500, 17, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '831384168', 2023, 1, 667.020670115201, 7149.76793882564, 500, 3, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '826740518', 2023, 1, 839.467726115602, 3143.61350025101, 500, 9, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '801382461', 2023, 1, 241.780614908119, 6464.60658926655, 500, 6, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '873647199', 2023, 1, 943.460879371775, 1651.57059788561, 500, 20, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '895605255', 2023, 1, 855.098005002367, 1538.75046569614, 500, 8, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '870822727', 2023, 1, 241.775906363257, 8170.8195928169, 500, 4, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '893467385', 2023, 1, 430.50721205952, 7355.18163780809, 500, 17, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '890913075', 2023, 1, 733.089528206692, 6113.78306521156, 500, 9, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '831873371', 2023, 1, 573.479436716072, 5763.94878142218, 500, 15, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '861316602', 2023, 1, 419.432179363209, 7123.34433927271, 500, 10, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '892864663', 2023, 1, 986.63127606404, 6892.8040086583, 500, 17, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '845152279', 2023, 1, 855.158507200351, 4176.07090345021, 500, 15, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '897305579', 2023, 1, 70.1338854403314, 2108.01363389198, 500, 1, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '810297653', 2023, 1, 913.586894244962, 8264.53633854176, 500, 7, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '890247793', 2023, 1, 212.762332355024, 3168.61851169722, 500, 17, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '845466381', 2023, 1, 973.674761305822, 8394.95155971417, 500, 19, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '806092322', 2023, 1, 301.356344073067, 197.565173863107, 500, 14, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '829331354', 2023, 1, 780.957797402649, 7176.20943321889, 500, 7, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '891213279', 2023, 1, 557.739321277551, 8810.52352674969, 500, 1, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '849837369', 2023, 1, 808.786683738677, 7195.9071393821, 500, 20, false, '2023-06-06 10:45:49.42322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '803612149', 2023, 1, 801.05924166822, 7733.73292276121, 500, 16, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '825023252', 2023, 1, 599.211937789668, 2169.7986111136, 500, 12, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '846353053', 2023, 1, 776.145986812745, 767.100443375931, 500, 12, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '810258838', 2023, 1, 779.337119563426, 9423.96730075451, 500, 14, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '879431708', 2023, 1, 827.282290194516, 6061.1160219297, 500, 8, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '835156452', 2023, 1, 616.94449512839, 6931.00437536543, 500, 13, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '835423243', 2023, 1, 147.586810442743, 2102.21546248243, 500, 9, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '800507941', 2023, 1, 997.333578307244, 6870.89361415753, 500, 16, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '823546489', 2023, 1, 647.070063723141, 9743.93516363565, 500, 18, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '889415226', 2023, 1, 242.29550990134, 1329.64882272165, 500, 17, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '868514999', 2023, 1, 799.944939367911, 7589.45816311009, 500, 12, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '816785668', 2023, 1, 755.759870380299, 6080.04356376158, 500, 1, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '877477414', 2023, 1, 292.123314120314, 6669.74980527343, 500, 3, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '867399503', 2023, 1, 632.635055228258, 9426.61363173498, 500, 6, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '803782547', 2023, 1, 420.587913394786, 5816.73856831108, 500, 20, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '840591750', 2023, 1, 430.884243050018, 1569.32163968245, 500, 1, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '897874002', 2023, 1, 617.277455198131, 8491.22339926359, 500, 20, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '847726893', 2023, 1, 999.276704387103, 8293.65736353596, 500, 15, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '807440611', 2023, 1, 708.967366942389, 2233.39004547196, 500, 14, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '883830580', 2023, 1, 830.59639055177, 9446.97116095827, 500, 11, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '815955507', 2023, 1, 984.917076375959, 2849.09163251144, 500, 11, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '837470311', 2023, 1, 276.212046638851, 6447.35464930475, 500, 3, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '837256305', 2023, 1, 832.115571715995, 1365.14053604149, 500, 4, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '842747033', 2023, 1, 229.535564853413, 6918.05645279093, 500, 5, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '873819010', 2023, 1, 479.929590121065, 3579.63831731114, 500, 16, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '803549422', 2023, 1, 532.355297388688, 2288.46867436945, 500, 12, false, '2023-06-06 10:45:49.995037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '814219285', 2023, 1, 670.193429500769, 7604.07743831027, 500, 7, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '806755875', 2023, 1, 305.623252678851, 7421.4949063829, 500, 10, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '808335242', 2023, 1, 979.846698054241, 1063.25777969769, 500, 8, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '833332848', 2023, 1, 989.522107998963, 1263.84040262547, 500, 19, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '844409589', 2023, 1, 936.159090800055, 4684.13916002938, 500, 11, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '863230590', 2023, 1, 775.464007543485, 9954.2055401818, 500, 10, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '816633410', 2023, 1, 749.125909302697, 1798.4223458657, 500, 15, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '838405064', 2023, 1, 91.8545528687893, 9911.70795341035, 500, 12, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '818054973', 2023, 1, 555.753827777571, 1355.42216073682, 500, 7, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '822120794', 2023, 1, 676.612803370403, 6884.8467300585, 500, 4, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '803175784', 2023, 1, 167.095730969602, 316.353889057704, 500, 2, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '861389317', 2023, 1, 355.417340173267, 4013.10157824751, 500, 3, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '851061579', 2023, 1, 156.398618794957, 3558.36550886131, 500, 8, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '884377478', 2023, 1, 218.812123171567, 3173.88414558208, 500, 1, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '804695621', 2023, 1, 796.915857960497, 8433.96154683918, 500, 13, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '862776743', 2023, 1, 41.5098813425431, 8056.7072715042, 500, 17, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '824502776', 2023, 1, 619.551944487166, 5862.39454314943, 500, 7, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '801824362', 2023, 1, 48.4627844286728, 3197.31459607655, 500, 6, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '855825895', 2023, 1, 655.672817535036, 669.761886137195, 500, 7, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '806038994', 2023, 1, 447.143837104198, 1653.32056954596, 500, 17, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '887795244', 2023, 1, 321.647755018569, 8290.71656073245, 500, 10, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '816697499', 2023, 1, 743.681662564294, 7648.98045337552, 500, 17, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '851165573', 2023, 1, 629.989370084069, 3205.64499561832, 500, 17, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '899139480', 2023, 1, 341.592737403022, 3207.63303105513, 500, 7, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '843588289', 2023, 1, 523.619767960895, 597.416463237031, 500, 9, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '869634632', 2023, 1, 951.177738390822, 9990.42667783245, 500, 20, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '877345136', 2023, 1, 422.647537258743, 6049.1818842298, 500, 7, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '829442619', 2023, 1, 262.682802028973, 9326.82808660956, 500, 12, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '887417323', 2023, 1, 292.090694229601, 876.424610241374, 500, 19, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '894887962', 2023, 1, 332.100840683392, 8344.09844747466, 500, 4, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '846850436', 2023, 1, 948.897608589272, 5801.01004160464, 500, 5, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '893618876', 2023, 1, 172.736368058677, 9568.74087745821, 500, 15, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '842192541', 2023, 1, 297.749230912653, 281.725260473598, 500, 7, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '812859980', 2023, 1, 678.681390819037, 7735.80958724864, 500, 16, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '854266224', 2023, 1, 959.98098815469, 760.079496000071, 500, 8, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '856588503', 2023, 1, 445.422868244164, 4600.61633930422, 500, 15, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '848336286', 2023, 1, 726.761256798525, 3721.48832803782, 500, 3, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '896802157', 2023, 1, 858.482759286646, 4575.28611261962, 500, 3, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '844933969', 2023, 1, 618.165612092177, 8554.84059247974, 500, 2, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '810623853', 2023, 1, 522.698466289056, 486.023525824937, 500, 5, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '862213656', 2023, 1, 90.6914931875976, 3166.15390115042, 500, 15, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '875365543', 2023, 1, 762.746008797112, 2504.75585114586, 500, 8, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '843459100', 2023, 1, 743.955938884031, 1863.4770361247, 500, 12, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '842552299', 2023, 1, 428.418499053957, 9283.1956851597, 500, 5, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '898017856', 2023, 1, 702.76079600201, 1845.37434300975, 500, 18, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '893101300', 2023, 1, 862.886503972686, 4901.54976702522, 500, 16, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '823158334', 2023, 1, 436.135556479212, 1360.61433711007, 500, 6, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '877940029', 2023, 1, 792.953077650046, 1596.05140291312, 500, 18, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '844999502', 2023, 1, 822.398989137286, 9664.34289263802, 500, 12, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '857539272', 2023, 1, 434.563480368643, 4671.11953154812, 500, 13, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '808770941', 2023, 1, 432.791116557288, 8044.28918917572, 500, 10, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '856491360', 2023, 1, 666.085437928635, 6948.78299097688, 500, 19, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '886740513', 2023, 1, 593.644451061139, 7614.45437373871, 500, 1, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '812672034', 2023, 1, 553.236270468145, 9206.96506323977, 500, 6, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '889929780', 2023, 1, 622.490429683631, 4626.57479776086, 500, 3, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '899700568', 2023, 1, 984.306365035772, 1060.49588598132, 500, 14, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '884630618', 2023, 1, 505.313159710922, 3182.08630417204, 500, 19, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '897345252', 2023, 1, 299.606760186841, 4108.99033209101, 500, 14, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '898834824', 2023, 1, 254.887380298582, 8828.95195682146, 500, 16, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '811318992', 2023, 1, 226.177764511586, 9814.36249219252, 500, 16, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '829482232', 2023, 1, 49.8751401038078, 2082.00328055978, 500, 19, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '869652190', 2023, 1, 874.096070791353, 1816.42969428471, 500, 16, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '831602749', 2023, 1, 757.330128055507, 9768.0283682701, 500, 19, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '827983273', 2023, 1, 447.364466944615, 6941.0845675969, 500, 10, false, '2023-06-06 10:45:50.196594', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '875978285', 2023, 1, 216.248523336292, 2905.44431311439, 500, 16, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '879448319', 2023, 1, 808.163414454892, 5327.6605476101, 500, 13, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '890365662', 2023, 1, 236.609285062449, 6426.97902993491, 500, 5, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '842225948', 2023, 1, 130.451246200784, 751.419690597175, 500, 16, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '894379311', 2023, 1, 607.879531880049, 5932.85548828881, 500, 11, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '816163475', 2023, 1, 447.236164849966, 3025.32251734687, 500, 16, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '840695880', 2023, 1, 380.971909592651, 1818.87952612776, 500, 13, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '858310890', 2023, 1, 370.164070730583, 8490.50264351077, 500, 19, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '822831897', 2023, 1, 390.84978391224, 6405.74008848826, 500, 4, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '823135340', 2023, 1, 424.39829239089, 8131.27159566933, 500, 16, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '854882590', 2023, 1, 198.920965066096, 6903.67888933555, 500, 20, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '878711282', 2023, 1, 545.423494193999, 7978.81598021227, 500, 3, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '826851792', 2023, 1, 549.233163920839, 8531.1987545125, 500, 12, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '843815881', 2023, 1, 438.494029209093, 9213.60178212227, 500, 8, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '873363916', 2023, 1, 692.420614554934, 9638.50946930593, 500, 12, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '837374078', 2023, 1, 214.576371220327, 6275.56419688962, 500, 17, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '884327994', 2023, 1, 20.8452541147259, 2944.8045095773, 500, 13, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '839366397', 2023, 1, 704.172033316667, 9457.70862146848, 500, 13, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '886102255', 2023, 1, 764.110619550249, 2291.73781535007, 500, 6, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '856078205', 2023, 1, 607.585397965996, 2218.72191694959, 500, 16, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '853440141', 2023, 1, 44.9848391626545, 2464.16778978404, 500, 11, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '832737996', 2023, 1, 36.4130581008378, 7826.11598207613, 500, 18, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '868794856', 2023, 1, 489.566752591563, 8179.75455073212, 500, 4, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '806403689', 2023, 1, 278.140461661537, 3571.31086504208, 500, 4, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '895299443', 2023, 1, 647.839976217016, 7772.29247287119, 500, 4, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '846372277', 2023, 1, 794.112294309028, 4548.31007506798, 500, 19, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '833883439', 2023, 1, 879.086763485797, 9324.09488819504, 500, 19, false, '2023-06-06 10:45:50.636203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '841140296', 2023, 1, 710.812555673029, 9229.5524123006, 500, 4, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '884466343', 2023, 1, 435.711511691591, 8435.83949052942, 500, 19, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '849750724', 2023, 1, 663.01202034096, 7445.89978301394, 500, 2, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '894340275', 2023, 1, 289.8644997857, 3836.06455997794, 500, 15, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '814779312', 2023, 1, 874.068114438474, 3038.95917167548, 500, 19, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '879486882', 2023, 1, 658.382590433955, 5003.18599171143, 500, 8, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '888383595', 2023, 1, 431.456305251887, 8987.63528428183, 500, 12, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '858890670', 2023, 1, 578.234514010956, 7597.32008112508, 500, 18, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '812082043', 2023, 1, 294.62492769663, 9595.30831368512, 500, 17, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '823842450', 2023, 1, 250.219809407272, 1110.26717649214, 500, 13, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '880886744', 2023, 1, 278.965839486286, 8477.46765047383, 500, 4, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '839066600', 2023, 1, 781.652447311569, 3861.96357256285, 500, 11, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '888994357', 2023, 1, 388.038944827942, 5298.02219074503, 500, 14, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '851004605', 2023, 1, 370.11790793833, 5633.71361813416, 500, 5, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '805363239', 2023, 1, 424.044574133552, 8845.59335282819, 500, 5, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '819929608', 2023, 1, 169.532893977684, 5676.5620269315, 500, 15, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '827204080', 2023, 1, 75.4690204584241, 4344.04719893951, 500, 18, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '862977616', 2023, 1, 983.598293040605, 7387.88678989141, 500, 18, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '804885788', 2023, 1, 309.512950040002, 9368.46274863703, 500, 14, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '864974024', 2023, 1, 349.271428046932, 8461.2177463921, 500, 9, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '896354155', 2023, 1, 613.177842085916, 4088.40395055771, 500, 6, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '811550861', 2023, 1, 347.782105458917, 7354.0255708847, 500, 9, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '877077716', 2023, 1, 242.390250434605, 1027.60992826436, 500, 16, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '850687115', 2023, 1, 962.095078850235, 2246.22131823272, 500, 5, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '832145659', 2023, 1, 869.017313990499, 9903.47175351272, 500, 16, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '822580377', 2023, 1, 654.803320369744, 9584.30636783691, 500, 19, false, '2023-06-06 10:45:50.85975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '804056550', 2023, 1, 809.744613057928, 9211.98659238602, 500, 20, false, '2023-06-06 10:45:55.345104', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '864991293', 2023, 1, 270.977245690709, 3597.22714052017, 500, 14, false, '2023-06-06 10:45:55.364753', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '853581476', 2023, 1, 829.978220339075, 1884.82364738683, 500, 2, false, '2023-06-06 10:45:55.364753', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '892420960', 2023, 1, 45.5692707632587, 5524.87189464904, 500, 4, false, '2023-06-06 10:45:55.386455', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '881989395', 2023, 1, 273.948661170241, 5806.63015069259, 500, 1, false, '2023-06-06 10:45:55.415642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '802923459', 2023, 1, 164.059864999421, 8026.68815166352, 500, 15, false, '2023-06-06 10:45:55.415642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '898545073', 2023, 1, 527.668415412795, 8517.9557421227, 500, 18, false, '2023-06-06 10:45:55.444466', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '871114158', 2023, 1, 914.715257471803, 5053.88068493428, 500, 20, false, '2023-06-06 10:45:55.444466', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '841627076', 2023, 1, 115.788415915724, 7382.09047949261, 500, 17, false, '2023-06-06 10:45:55.444466', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '849843714', 2023, 1, 351.858153752084, 1024.33203485712, 500, 20, false, '2023-06-06 10:45:55.444466', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '822555289', 2023, 1, 844.640082433573, 689.495312551483, 500, 1, false, '2023-06-06 10:45:55.478183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '899567741', 2023, 1, 172.316580577643, 6727.64035367141, 500, 11, false, '2023-06-06 10:45:55.478183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '886777842', 2023, 1, 180.8970282868, 1647.41981786097, 500, 20, false, '2023-06-06 10:45:55.478183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '865025012', 2023, 1, 29.7812540328891, 8801.24165946032, 500, 1, false, '2023-06-06 10:45:55.478183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '848622181', 2023, 1, 885.569189933658, 3066.18558007512, 500, 2, false, '2023-06-06 10:45:55.478183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '886555703', 2023, 1, 153.594780328646, 337.552609180846, 500, 12, false, '2023-06-06 10:45:55.513951', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '878349119', 2023, 1, 284.574217224504, 7714.78430908317, 500, 8, false, '2023-06-06 10:45:55.513951', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '813897462', 2023, 1, 469.67554855311, 2425.09813382853, 500, 15, false, '2023-06-06 10:45:55.513951', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 6476.52028313422, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.221801');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 4369.13449874745, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.264556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '555555555', 9036.32308844725, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.264556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '802206409', 742.407356313841, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.264556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '817238182', 7842.40119583752, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.264556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '833560632', 4796.59997897486, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.264556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '877816099', 986.112148662488, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.264556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '894512904', 5999.31414838921, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.264556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '830314374', 1791.02193005409, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.264556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '805214180', 8538.73342732172, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.264556');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '857899421', 2964.41072544471, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.319276');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '807598834', 5574.20287152499, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.319276');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '865882840', 1571.76528849081, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.319276');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '808703328', 9808.33483838023, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.319276');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '851321904', 7666.5385525158, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.319276');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '804091455', 6135.06070610561, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.370771');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '851037073', 657.654472292478, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.370771');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '884576933', 171.676158784398, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.370771');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '831138079', 8223.33040630282, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.370771');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '814552794', 7211.56711599252, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.370771');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '830511836', 7822.28863963058, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.370771');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '859086141', 5607.30663983468, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.370771');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '839168077', 6000.45700743786, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.370771');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '874706819', 2349.38023132361, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.370771');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '884094771', 4038.55264020522, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.370771');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '899271514', 8578.45208828314, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.417228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '846989088', 4011.37324884322, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.417228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '801686721', 5271.32352264077, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.417228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '861804179', 412.429096919229, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.417228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '889949417', 4891.39138846186, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.417228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '872469874', 6575.6204006657, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.417228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '899093031', 939.206274228541, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.417228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '803845912', 265.725466856902, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.453681');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '833081148', 6175.48088059876, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.453681');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '830011128', 1541.55499088968, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.453681');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '822555920', 2991.17784118741, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.453681');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '877133946', 5831.75325507796, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.453681');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '828674185', 8701.96289819982, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.453681');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '832079589', 1144.97386819272, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.487513');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '875081061', 7453.41873321332, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.487513');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '873375519', 9954.66235668007, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.487513');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '887251443', 4182.56606853413, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.487513');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '874646342', 466.166146601204, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.511271');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '831499694', 601.917574129909, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.511271');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '822980831', 5475.45795695256, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.511271');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '830194175', 4925.66982977515, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.535228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '827312615', 503.965000688082, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.535228');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '835878464', 5404.84007400116, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.561666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '881680637', 3561.10066249698, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.561666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '820135331', 6909.95874512596, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.561666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '881400208', 6576.95207022072, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.561666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '853050436', 2441.99355160438, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.583723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '841275516', 7135.1268144685, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.583723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '824524816', 949.605399342539, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.583723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '814689949', 5983.70533446239, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.583723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '827119452', 2964.05386355005, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.583723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '863719122', 3711.94077781854, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.583723');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '822266321', 3470.51157978126, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.607408');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '891071007', 1101.93896445042, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.607408');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '835751993', 8425.06520377728, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.630294');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '833267554', 8957.43684577703, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.630294');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '857267460', 2291.74685588613, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.630294');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '880192549', 1681.1794891786, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.655982');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '863030247', 5732.36795696516, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.655982');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '828419851', 3045.92135353722, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.676775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '861621931', 2540.61885226531, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.676775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '890183280', 6423.81492558929, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.676775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '860086485', 5339.29156283644, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.714258');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '863578303', 3264.22161626132, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.714258');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '895892630', 689.218034678826, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.75144');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '803570351', 2030.16202520357, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.75144');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '876823186', 9964.38745844391, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.75144');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '803808918', 5606.09256072682, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.75144');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '849083854', 1298.21568931996, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.832441');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '826475210', 8053.96881062124, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.832441');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '808599455', 723.163695506587, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.832441');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '899095286', 6807.73985128734, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.862264');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '856815634', 6996.81295955283, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.862264');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '894474489', 3751.95048943212, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.862264');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '812047191', 2678.01797966444, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.862264');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '890777552', 5866.05793879398, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.862264');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '820722587', 7158.55521285522, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.862264');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '809436178', 7981.57698105306, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.891147');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '810376980', 9950.54954110613, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.916525');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '890238030', 5865.63278511257, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.916525');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '828266999', 2652.65152063747, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.916525');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '862940033', 4174.79619039244, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.916525');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '880379202', 8802.55594482565, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.950165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '810151455', 9771.76845512679, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.950165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '881250314', 920.834500143511, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.950165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '875197324', 2960.33925210185, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.950165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '824805720', 9243.65613255343, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.987077');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '842090861', 5297.63671860464, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.987077');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '813258691', 3126.14841922406, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.987077');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '882246146', 8753.04635908237, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.987077');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '891407332', 7195.46143873603, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:51.987077');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '862068389', 728.495446995765, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.014745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '820736881', 9787.62244214577, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.037495');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '860629351', 1218.67204319862, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.037495');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '872381491', 6415.41609776528, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.037495');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '830484510', 617.017388035113, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.058578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '861732339', 9609.12300133947, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.058578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '813199268', 2851.19255278897, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.089578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '821624303', 5752.96713447464, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.089578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '856736407', 4039.9805664242, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.089578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '897400542', 2556.22166182627, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.089578');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '895097486', 8366.88369054478, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.119972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '884021287', 9737.30663048436, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.119972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '802114238', 2642.5313838239, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.119972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '842307904', 7487.79221035843, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.119972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '892504040', 7837.80072882639, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.146141');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '865477980', 9735.02365214535, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.146141');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '828426342', 2925.75992662001, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.146141');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '869151445', 5699.08965666138, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.169777');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '859899076', 9657.88753045316, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.169777');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '821684747', 6817.12105692536, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.169777');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '897449659', 952.965583292063, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.169777');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '878526531', 3597.48243375965, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.197574');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '855164299', 5644.42225060524, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.197574');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '855192908', 9866.92089637095, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.197574');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '806689657', 3905.635326842, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.231002');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '878761080', 4965.27947112929, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.231002');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '848968830', 7640.45103576213, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.231002');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '885536119', 8652.80456277817, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.255569');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '878526130', 7484.17340199662, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.270831');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '843341562', 7378.81927880004, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.270831');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '800736288', 6760.2303043061, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.270831');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '807244123', 6347.53014978859, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.270831');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '877731403', 8172.15314732275, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.270831');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '888781937', 7982.64484673178, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.289395');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '806466365', 6615.07062732468, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.289395');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '800646971', 3674.87322455846, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.313084');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '803919694', 523.61971239828, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.339491');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '813551155', 134.587302467745, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.339491');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '824705088', 1735.28298429648, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.358654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '823188933', 180.57318783053, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.358654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '808053770', 3807.14425762514, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.358654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '837635993', 7261.42577740175, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.358654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '823114501', 1415.83964776622, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.380116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '885375930', 4201.82629159779, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.380116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '813722685', 7007.06270749825, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.380116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '848590489', 4550.64098597615, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.380116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '817418290', 4025.27017260201, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.380116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '872291593', 9030.86840120268, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.380116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '843802830', 6254.09304989802, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.380116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '821596869', 9270.70172915567, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.406533');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '834239593', 9708.16599245152, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.406533');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '870405555', 9024.95239055414, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.406533');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '862737958', 5893.14438655108, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.406533');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '894071655', 5112.76213363162, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.406533');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '837969510', 8269.09623504651, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.406533');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '882289746', 7943.39677321412, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.42261');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '817085642', 1514.6614332339, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.42261');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '855446362', 9155.18170874991, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.42261');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '863729203', 8496.15877244848, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.42261');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '865462877', 7736.43610551802, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.441982');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '877210079', 2665.44806299076, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.441982');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '837164320', 6401.68655149526, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.441982');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '851474063', 4941.50222343366, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.441982');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '860815002', 770.970217749899, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.465175');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '862485363', 2488.09305400914, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.465175');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '849849370', 2459.87524957516, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.486795');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '873754409', 1503.8327746555, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.486795');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '873757754', 4026.308169527, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.486795');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '892804834', 2526.67663854359, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.503493');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '858511028', 3271.01545891856, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.520742');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '883788031', 4981.92588154032, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.520742');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '831779482', 8192.0320204661, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.520742');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '850012617', 6290.68862079811, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.541986');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '843819388', 6111.43306227754, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.56374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '884434614', 6191.79184680965, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.56374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '824703877', 1594.75102721515, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.56374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '820025728', 5432.40692830786, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.585156');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '898643131', 8563.19490680555, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.585156');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '807776086', 9268.71776705619, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.585156');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '869091104', 649.594173796642, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.608306');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '876709104', 48.8190119426196, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.608306');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '846022208', 3256.09725172148, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.62894');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '849221593', 6238.06671022756, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.62894');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '803983066', 4029.29205296315, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.62894');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '852614210', 5068.21315890764, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.651979');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '807367405', 8449.18656202151, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.651979');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '818482835', 2778.07085637912, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.672319');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '843050701', 9371.75927064901, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.691674');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '828046592', 4512.22792389604, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.708545');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '867914628', 7319.00045249342, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.708545');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '806486960', 8031.08143440854, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.708545');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '854307799', 5776.7278521673, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.728042');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '898974597', 1604.15120525915, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.753446');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '823872476', 6353.89406095076, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.775433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '890435197', 5763.2286595318, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.775433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '846425401', 636.915803039248, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.775433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '852145296', 6088.61973545475, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.775433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '862444419', 6241.99897462651, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.798281');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '879842491', 2719.53038135161, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.798281');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '882660143', 3197.94860649463, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.83206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '881043298', 7555.99433426711, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.83206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '893165291', 663.487480517921, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.83206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '827941273', 4808.84086065863, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.83206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '861881935', 9643.13823634855, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.83206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '802174984', 8512.89295983963, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.873181');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '858521935', 2390.24949759046, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.873181');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '818345166', 4473.39918104981, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.873181');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '810280375', 7766.23487638533, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.873181');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '882063649', 3874.51044339701, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.873181');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '880150041', 3525.20871015964, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.902222');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '815490887', 1124.42130540097, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.902222');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '839389387', 5418.51290308635, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.928161');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '884601388', 508.632835570031, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.928161');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '879432294', 2164.23695138964, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.928161');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '810840234', 3489.58992923325, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.928161');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '867469531', 2368.23548123795, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.946846');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '881832224', 8647.96659946666, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.946846');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '845694125', 2433.3021942012, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.946846');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '882816948', 2370.66516368744, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.946846');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '860781085', 27.1138268512301, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.946846');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '873714751', 3551.18324164811, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:52.975645');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '868280217', 3913.24033981406, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.001104');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '810425682', 1728.64746274431, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.001104');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '831398808', 6980.38064078389, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.030443');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '864416095', 8394.57662774295, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.030443');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '817595343', 5469.81457264483, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.060858');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '813096765', 3063.99137258399, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.07698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '874523779', 9232.81834642925, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.07698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '834142018', 814.331075651115, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.07698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '859964256', 1688.34306652636, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.101404');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '867569758', 7360.09853594688, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.101404');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '892088330', 5553.49377191572, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.101404');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '879804077', 9965.42079038338, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.126138');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '838407602', 5946.93793090674, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.142374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '817713278', 3180.44195544818, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.142374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '881609271', 9928.43908077212, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.142374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '803204320', 3959.96803347755, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.142374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '898881449', 5465.58629590687, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.142374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '878218652', 9182.82507559112, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.163807');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '843707057', 6609.73639555046, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.163807');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '823280302', 6909.79857797123, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.163807');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '865097217', 8513.53493501643, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.183714');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '898114130', 1657.54447445337, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.198084');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '889994777', 9950.41688251492, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.198084');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '831772738', 7348.12825400397, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.198084');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '821965543', 354.382333575036, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.198084');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '824144039', 9081.95264064434, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.215742');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '813952219', 5630.09385455991, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.240911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '806033550', 9564.8420485763, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.240911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '863033699', 9714.66539764633, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.240911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '830460419', 6548.55300271404, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.260436');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '862572039', 5968.46955833045, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.286488');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '872881350', 6509.19432808508, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.309818');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '865076375', 4221.19890064202, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.309818');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '892105387', 6019.81957973443, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.309818');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '837331399', 3470.46958357434, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.309818');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '895071510', 7058.99141801699, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.331669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '841293887', 2966.27546872376, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.331669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '800500213', 3384.66363746504, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.331669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '830955221', 5647.63143547564, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.331669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '889579186', 9565.29399345321, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.331669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '855457757', 9574.48838134411, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.361731');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '831090240', 2717.78776089344, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.361731');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '870649563', 5571.54247321485, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.377219');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '857087897', 4929.48994444586, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.377219');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '801668365', 1116.29117879407, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.403188');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '843548104', 4612.66069631147, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.403188');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '843679245', 5649.96660874079, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.423801');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '856500575', 2587.68281623742, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.423801');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '856001243', 2923.08213477647, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.423801');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '817878762', 482.848021474457, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.423801');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '838146594', 6945.43261459855, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.45197');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '840075284', 1357.86500174905, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.480585');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '821662895', 4953.23411067143, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.480585');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '843837108', 8918.2822233032, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.493182');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '845031784', 7247.89287511243, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.515162');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '875565818', 6700.86872221433, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.515162');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '803038597', 8446.36613607184, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.515162');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '839555854', 5097.03824606834, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.515162');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '857557135', 9642.79819939732, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.536791');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '815608021', 1685.61706898382, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.536791');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '893397601', 4174.14963069448, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.536791');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '824822764', 2935.30210094462, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.559968');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '858635007', 8677.77073505623, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.559968');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '860185319', 3459.72399692105, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.559968');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '874789310', 3739.50000927671, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.559968');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '895950630', 4559.47450725412, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.559968');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '812733329', 1974.32531850782, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.577308');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '849504303', 9746.24267919862, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.577308');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '810836388', 6618.21510163938, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.577308');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '893711345', 8095.59643732932, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.592819');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '883273560', 8509.15542964996, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.592819');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '857320873', 9579.93495878852, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.592819');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '894715113', 503.997497018983, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.609448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '874369743', 454.76974212122, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.626857');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '859338769', 3743.30247804525, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.626857');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '822981319', 1256.90165093908, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.643211');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '894746652', 9622.40300751521, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.665075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '820460458', 5842.17865475874, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.665075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '836428741', 4517.60254603528, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.665075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '808239579', 4498.81939806223, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.665075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '853991955', 4876.80595087737, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.680746');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '821827369', 9149.97920823335, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.680746');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '853794730', 2098.27303969314, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.680746');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '877750244', 8673.93355819231, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.699775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '886802160', 3762.26067415787, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.699775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '825906262', 6941.23653706205, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.722108');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '830671460', 7015.40422688013, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.722108');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '886022624', 4893.3712839386, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.740131');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '845456654', 5469.16856776812, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.740131');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '884934109', 5692.77260748085, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.766803');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '893013889', 7678.62435471133, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.766803');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '874793666', 4097.90366170204, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.784363');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '839840143', 1210.14618884418, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.784363');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '855087843', 3616.5940196898, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.784363');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '803909703', 2877.00538886625, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.784363');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '835613827', 5050.9092029824, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.802494');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '890368704', 9567.98511194231, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.802494');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '835188155', 3955.70222087835, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.822102');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '800268973', 9021.83641241874, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.837774');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '823381866', 4999.80423106925, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.837774');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '819345705', 373.478677888418, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.854669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '858313561', 6100.23496470549, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.854669');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '807334012', 9557.04250696876, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.876844');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '896839457', 8993.80689803795, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.876844');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '893504480', 3997.2656917991, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.891637');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '811376499', 2539.72332018963, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.891637');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '839956153', 2016.32560641886, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.916795');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '880478707', 3948.84735498564, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.916795');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '885376947', 477.033303002382, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.927143');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '872081220', 3736.24200130963, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.93791');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '822891769', 6491.26311561288, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.953415');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '805863410', 7647.47334153004, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.963395');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '863609151', 530.801057698341, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.983437');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '848216997', 5229.24941730091, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:53.998145');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '865120206', 7387.70062999252, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.013327');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '866740216', 2724.30025455263, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.026836');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '864140200', 3991.60301915717, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.044447');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '897926718', 7751.76880148151, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.06123');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '884422045', 9205.15674403165, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.0772');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '820615064', 5481.2344433153, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.095028');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '864666925', 4461.95063820654, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.095028');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '835261981', 4831.38050115195, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.112562');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '881186163', 475.384758315075, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.112562');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '830886980', 6606.84847420869, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.112562');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '881297676', 2520.95719007493, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.131937');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '846943054', 9814.95003753564, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.131937');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '858637684', 1718.8574321701, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.131937');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '808580153', 5330.36709070747, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.131937');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '831384168', 7149.76793882564, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.153114');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '826740518', 3143.61350025101, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.153114');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '801382461', 6464.60658926655, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.153114');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '873647199', 1651.57059788561, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.153114');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '895605255', 1538.75046569614, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.169558');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '870822727', 8170.8195928169, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.169558');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '893467385', 7355.18163780809, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.169558');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '890913075', 6113.78306521156, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.185339');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '831873371', 5763.94878142218, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.185339');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '861316602', 7123.34433927271, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.185339');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '892864663', 6892.8040086583, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.213942');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '845152279', 4176.07090345021, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.213942');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '897305579', 2108.01363389198, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.231015');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '810297653', 8264.53633854176, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.231015');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '890247793', 3168.61851169722, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.249258');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '845466381', 8394.95155971417, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.249258');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '806092322', 197.565173863107, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.26852');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '829331354', 7176.20943321889, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.26852');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '891213279', 8810.52352674969, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.288332');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '849837369', 7195.9071393821, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.288332');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '803612149', 7733.73292276121, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.304798');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '825023252', 2169.7986111136, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.304798');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '846353053', 767.100443375931, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.304798');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '810258838', 9423.96730075451, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.304798');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '879431708', 6061.1160219297, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.338722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '835156452', 6931.00437536543, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.338722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '835423243', 2102.21546248243, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.338722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '800507941', 6870.89361415753, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.338722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '823546489', 9743.93516363565, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.364726');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '889415226', 1329.64882272165, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.364726');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '868514999', 7589.45816311009, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.364726');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '816785668', 6080.04356376158, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.364726');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '877477414', 6669.74980527343, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.364726');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '867399503', 9426.61363173498, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.364726');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '803782547', 5816.73856831108, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.364726');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '840591750', 1569.32163968245, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.389687');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '897874002', 8491.22339926359, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.389687');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '847726893', 8293.65736353596, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.389687');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '807440611', 2233.39004547196, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.389687');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '883830580', 9446.97116095827, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.389687');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '815955507', 2849.09163251144, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.389687');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '837470311', 6447.35464930475, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.420375');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '837256305', 1365.14053604149, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.420375');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '842747033', 6918.05645279093, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.420375');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '873819010', 3579.63831731114, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.420375');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '803549422', 2288.46867436945, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.432045');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '814219285', 7604.07743831027, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.432045');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '806755875', 7421.4949063829, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.432045');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '808335242', 1063.25777969769, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.432045');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '833332848', 1263.84040262547, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.447878');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '844409589', 4684.13916002938, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.471557');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '863230590', 9954.2055401818, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.471557');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '816633410', 1798.4223458657, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.491118');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '838405064', 9911.70795341035, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.491118');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '818054973', 1355.42216073682, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.491118');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '822120794', 6884.8467300585, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.491118');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '803175784', 316.353889057704, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.511398');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '861389317', 4013.10157824751, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.511398');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '851061579', 3558.36550886131, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.511398');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '884377478', 3173.88414558208, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.530722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '804695621', 8433.96154683918, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.530722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '862776743', 8056.7072715042, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.530722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '824502776', 5862.39454314943, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.530722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '801824362', 3197.31459607655, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.530722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '855825895', 669.761886137195, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.553809');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '806038994', 1653.32056954596, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.553809');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '887795244', 8290.71656073245, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.553809');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '816697499', 7648.98045337552, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.553809');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '851165573', 3205.64499561832, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.573312');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '899139480', 3207.63303105513, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.573312');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '843588289', 597.416463237031, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.573312');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '869634632', 9990.42667783245, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.573312');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '877345136', 6049.1818842298, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.591625');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '829442619', 9326.82808660956, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.591625');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '887417323', 876.424610241374, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.591625');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '894887962', 8344.09844747466, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.619073');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '846850436', 5801.01004160464, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.637466');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '893618876', 9568.74087745821, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.637466');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '842192541', 281.725260473598, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.637466');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '812859980', 7735.80958724864, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.637466');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '854266224', 760.079496000071, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.637466');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '856588503', 4600.61633930422, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.662834');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '848336286', 3721.48832803782, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.662834');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '896802157', 4575.28611261962, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.662834');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '844933969', 8554.84059247974, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.662834');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '810623853', 486.023525824937, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.68359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '862213656', 3166.15390115042, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.68359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '875365543', 2504.75585114586, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.699264');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '843459100', 1863.4770361247, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.699264');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '842552299', 9283.1956851597, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.699264');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '898017856', 1845.37434300975, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.699264');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '893101300', 4901.54976702522, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.71689');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '823158334', 1360.61433711007, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.71689');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '877940029', 1596.05140291312, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.735045');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '844999502', 9664.34289263802, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.735045');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '857539272', 4671.11953154812, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.735045');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '808770941', 8044.28918917572, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.735045');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '856491360', 6948.78299097688, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.752303');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '886740513', 7614.45437373871, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.752303');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '812672034', 9206.96506323977, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.752303');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '889929780', 4626.57479776086, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.752303');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '899700568', 1060.49588598132, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.752303');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '884630618', 3182.08630417204, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.76823');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '897345252', 4108.99033209101, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.76823');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '898834824', 8828.95195682146, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.76823');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '811318992', 9814.36249219252, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.786627');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '829482232', 2082.00328055978, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.786627');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '869652190', 1816.42969428471, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.798656');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '831602749', 9768.0283682701, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.798656');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '827983273', 6941.0845675969, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.798656');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '875978285', 2905.44431311439, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.822253');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '879448319', 5327.6605476101, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.839028');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '890365662', 6426.97902993491, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.839028');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '842225948', 751.419690597175, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.852227');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '894379311', 5932.85548828881, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.852227');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '816163475', 3025.32251734687, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.852227');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '840695880', 1818.87952612776, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.867961');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '858310890', 8490.50264351077, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.867961');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '822831897', 6405.74008848826, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.886961');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '823135340', 8131.27159566933, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.886961');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '854882590', 6903.67888933555, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.905314');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '878711282', 7978.81598021227, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.905314');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '826851792', 8531.1987545125, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.905314');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '843815881', 9213.60178212227, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.905314');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '873363916', 9638.50946930593, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.927687');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '837374078', 6275.56419688962, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.927687');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '884327994', 2944.8045095773, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.948993');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '839366397', 9457.70862146848, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.948993');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '886102255', 2291.73781535007, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.948993');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '856078205', 2218.72191694959, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.970235');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '853440141', 2464.16778978404, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.970235');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '832737996', 7826.11598207613, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.970235');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '868794856', 8179.75455073212, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.987262');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '806403689', 3571.31086504208, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.987262');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '895299443', 7772.29247287119, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:54.987262');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '846372277', 4548.31007506798, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.003767');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '833883439', 9324.09488819504, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.020967');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '841140296', 9229.5524123006, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.037843');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '884466343', 8435.83949052942, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.037843');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '849750724', 7445.89978301394, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.037843');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '894340275', 3836.06455997794, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.037843');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '814779312', 3038.95917167548, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.037843');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '879486882', 5003.18599171143, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.050637');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '888383595', 8987.63528428183, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.050637');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '858890670', 7597.32008112508, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.050637');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '812082043', 9595.30831368512, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.067146');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '823842450', 1110.26717649214, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.085471');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '880886744', 8477.46765047383, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.085471');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '839066600', 3861.96357256285, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.085471');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '888994357', 5298.02219074503, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.111688');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '851004605', 5633.71361813416, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.111688');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '805363239', 8845.59335282819, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.111688');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '819929608', 5676.5620269315, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.133733');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '827204080', 4344.04719893951, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.133733');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '862977616', 7387.88678989141, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.133733');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '804885788', 9368.46274863703, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.133733');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '864974024', 8461.2177463921, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.145647');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '896354155', 4088.40395055771, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.145647');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '811550861', 7354.0255708847, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.145647');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '877077716', 1027.60992826436, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.145647');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '850687115', 2246.22131823272, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.145647');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '832145659', 9903.47175351272, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.145647');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '822580377', 9584.30636783691, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.167072');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '804056550', 9211.98659238602, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.552605');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '864991293', 3597.22714052017, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.574035');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '853581476', 1884.82364738683, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.574035');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '892420960', 5524.87189464904, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.574035');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '881989395', 5806.63015069259, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.601094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '802923459', 8026.68815166352, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.601094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '898545073', 8517.9557421227, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.601094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '871114158', 5053.88068493428, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.617073');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '841627076', 7382.09047949261, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.617073');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '849843714', 1024.33203485712, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.617073');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '822555289', 689.495312551483, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.632125');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '899567741', 6727.64035367141, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.632125');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '886777842', 1647.41981786097, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.649433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '865025012', 8801.24165946032, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.649433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '848622181', 3066.18558007512, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.649433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '886555703', 337.552609180846, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.670947');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '878349119', 7714.78430908317, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.670947');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '813897462', 2425.09813382853, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-06-06 10:45:55.688622');


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.782253', '2023-06-06 10:45:42.782253');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.831344', '2023-06-06 10:45:42.831344');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.839816', '2023-06-06 10:45:42.839816');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.848611', '2023-06-06 10:45:42.848611');
INSERT INTO public.virksomhet VALUES (5, '869191224', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869191224', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.856849', '2023-06-06 10:45:42.856849');
INSERT INTO public.virksomhet VALUES (6, '802206409', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802206409', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.864012', '2023-06-06 10:45:42.864012');
INSERT INTO public.virksomhet VALUES (7, '817238182', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817238182', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.871398', '2023-06-06 10:45:42.871398');
INSERT INTO public.virksomhet VALUES (8, '833560632', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833560632', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.878436', '2023-06-06 10:45:42.878436');
INSERT INTO public.virksomhet VALUES (9, '877816099', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877816099', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.886512', '2023-06-06 10:45:42.886512');
INSERT INTO public.virksomhet VALUES (10, '894512904', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894512904', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.894058', '2023-06-06 10:45:42.894058');
INSERT INTO public.virksomhet VALUES (11, '830314374', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830314374', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.900764', '2023-06-06 10:45:42.900764');
INSERT INTO public.virksomhet VALUES (12, '805214180', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805214180', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.908631', '2023-06-06 10:45:42.908631');
INSERT INTO public.virksomhet VALUES (13, '857899421', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857899421', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.916692', '2023-06-06 10:45:42.916692');
INSERT INTO public.virksomhet VALUES (14, '807598834', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807598834', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.924841', '2023-06-06 10:45:42.924841');
INSERT INTO public.virksomhet VALUES (15, '865882840', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865882840', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.934983', '2023-06-06 10:45:42.934983');
INSERT INTO public.virksomhet VALUES (16, '808703328', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808703328', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.942511', '2023-06-06 10:45:42.942511');
INSERT INTO public.virksomhet VALUES (17, '851321904', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851321904', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.950377', '2023-06-06 10:45:42.950377');
INSERT INTO public.virksomhet VALUES (18, '804091455', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804091455', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.959828', '2023-06-06 10:45:42.959828');
INSERT INTO public.virksomhet VALUES (19, '851037073', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851037073', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.966179', '2023-06-06 10:45:42.966179');
INSERT INTO public.virksomhet VALUES (20, '884576933', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884576933', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.974373', '2023-06-06 10:45:42.974373');
INSERT INTO public.virksomhet VALUES (21, '831138079', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831138079', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.980217', '2023-06-06 10:45:42.980217');
INSERT INTO public.virksomhet VALUES (22, '814552794', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814552794', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.985783', '2023-06-06 10:45:42.985783');
INSERT INTO public.virksomhet VALUES (23, '830511836', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830511836', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:42.993063', '2023-06-06 10:45:42.993063');
INSERT INTO public.virksomhet VALUES (24, '859086141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859086141', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.000094', '2023-06-06 10:45:43.000094');
INSERT INTO public.virksomhet VALUES (25, '839168077', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839168077', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.006771', '2023-06-06 10:45:43.006771');
INSERT INTO public.virksomhet VALUES (26, '874706819', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874706819', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.01429', '2023-06-06 10:45:43.01429');
INSERT INTO public.virksomhet VALUES (27, '884094771', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884094771', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.019921', '2023-06-06 10:45:43.019921');
INSERT INTO public.virksomhet VALUES (28, '899271514', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899271514', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.026677', '2023-06-06 10:45:43.026677');
INSERT INTO public.virksomhet VALUES (29, '846989088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846989088', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.033449', '2023-06-06 10:45:43.033449');
INSERT INTO public.virksomhet VALUES (30, '801686721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801686721', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.039837', '2023-06-06 10:45:43.039837');
INSERT INTO public.virksomhet VALUES (31, '861804179', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861804179', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.04781', '2023-06-06 10:45:43.04781');
INSERT INTO public.virksomhet VALUES (32, '889949417', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889949417', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.05511', '2023-06-06 10:45:43.05511');
INSERT INTO public.virksomhet VALUES (33, '872469874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872469874', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.061939', '2023-06-06 10:45:43.061939');
INSERT INTO public.virksomhet VALUES (34, '899093031', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899093031', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.070527', '2023-06-06 10:45:43.070527');
INSERT INTO public.virksomhet VALUES (35, '803845912', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803845912', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.078167', '2023-06-06 10:45:43.078167');
INSERT INTO public.virksomhet VALUES (36, '833081148', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833081148', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.084387', '2023-06-06 10:45:43.084387');
INSERT INTO public.virksomhet VALUES (37, '830011128', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830011128', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.091285', '2023-06-06 10:45:43.091285');
INSERT INTO public.virksomhet VALUES (38, '822555920', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822555920', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.098191', '2023-06-06 10:45:43.098191');
INSERT INTO public.virksomhet VALUES (39, '877133946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877133946', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.105691', '2023-06-06 10:45:43.105691');
INSERT INTO public.virksomhet VALUES (40, '828674185', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828674185', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.113038', '2023-06-06 10:45:43.113038');
INSERT INTO public.virksomhet VALUES (41, '832079589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832079589', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.119161', '2023-06-06 10:45:43.119161');
INSERT INTO public.virksomhet VALUES (42, '875081061', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875081061', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.125205', '2023-06-06 10:45:43.125205');
INSERT INTO public.virksomhet VALUES (43, '873375519', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873375519', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.130924', '2023-06-06 10:45:43.130924');
INSERT INTO public.virksomhet VALUES (44, '887251443', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887251443', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.136778', '2023-06-06 10:45:43.136778');
INSERT INTO public.virksomhet VALUES (45, '874646342', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874646342', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.143099', '2023-06-06 10:45:43.143099');
INSERT INTO public.virksomhet VALUES (46, '831499694', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831499694', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.149852', '2023-06-06 10:45:43.149852');
INSERT INTO public.virksomhet VALUES (47, '822980831', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822980831', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.158113', '2023-06-06 10:45:43.158113');
INSERT INTO public.virksomhet VALUES (48, '830194175', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830194175', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.164572', '2023-06-06 10:45:43.164572');
INSERT INTO public.virksomhet VALUES (49, '827312615', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827312615', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.170494', '2023-06-06 10:45:43.170494');
INSERT INTO public.virksomhet VALUES (50, '835878464', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835878464', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.175618', '2023-06-06 10:45:43.175618');
INSERT INTO public.virksomhet VALUES (51, '881680637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881680637', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.181801', '2023-06-06 10:45:43.181801');
INSERT INTO public.virksomhet VALUES (52, '820135331', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820135331', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.187668', '2023-06-06 10:45:43.187668');
INSERT INTO public.virksomhet VALUES (53, '881400208', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881400208', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.193778', '2023-06-06 10:45:43.193778');
INSERT INTO public.virksomhet VALUES (54, '853050436', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853050436', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.200431', '2023-06-06 10:45:43.200431');
INSERT INTO public.virksomhet VALUES (55, '841275516', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841275516', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.20684', '2023-06-06 10:45:43.20684');
INSERT INTO public.virksomhet VALUES (56, '824524816', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824524816', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.212439', '2023-06-06 10:45:43.212439');
INSERT INTO public.virksomhet VALUES (57, '814689949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814689949', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.217637', '2023-06-06 10:45:43.217637');
INSERT INTO public.virksomhet VALUES (58, '827119452', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827119452', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.222956', '2023-06-06 10:45:43.222956');
INSERT INTO public.virksomhet VALUES (59, '863719122', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863719122', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.227684', '2023-06-06 10:45:43.227684');
INSERT INTO public.virksomhet VALUES (60, '822266321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822266321', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.234531', '2023-06-06 10:45:43.234531');
INSERT INTO public.virksomhet VALUES (61, '891071007', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891071007', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.239695', '2023-06-06 10:45:43.239695');
INSERT INTO public.virksomhet VALUES (62, '835751993', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835751993', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.244954', '2023-06-06 10:45:43.244954');
INSERT INTO public.virksomhet VALUES (63, '833267554', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833267554', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.250586', '2023-06-06 10:45:43.250586');
INSERT INTO public.virksomhet VALUES (64, '857267460', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857267460', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.25692', '2023-06-06 10:45:43.25692');
INSERT INTO public.virksomhet VALUES (65, '880192549', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880192549', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.261899', '2023-06-06 10:45:43.261899');
INSERT INTO public.virksomhet VALUES (66, '863030247', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863030247', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.26727', '2023-06-06 10:45:43.26727');
INSERT INTO public.virksomhet VALUES (67, '828419851', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828419851', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.272486', '2023-06-06 10:45:43.272486');
INSERT INTO public.virksomhet VALUES (68, '861621931', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861621931', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.277912', '2023-06-06 10:45:43.277912');
INSERT INTO public.virksomhet VALUES (69, '890183280', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890183280', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.283079', '2023-06-06 10:45:43.283079');
INSERT INTO public.virksomhet VALUES (70, '860086485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860086485', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.288316', '2023-06-06 10:45:43.288316');
INSERT INTO public.virksomhet VALUES (71, '863578303', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863578303', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.293701', '2023-06-06 10:45:43.293701');
INSERT INTO public.virksomhet VALUES (72, '895892630', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895892630', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.299242', '2023-06-06 10:45:43.299242');
INSERT INTO public.virksomhet VALUES (73, '803570351', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803570351', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.305472', '2023-06-06 10:45:43.305472');
INSERT INTO public.virksomhet VALUES (74, '876823186', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876823186', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.311233', '2023-06-06 10:45:43.311233');
INSERT INTO public.virksomhet VALUES (75, '803808918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803808918', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.316843', '2023-06-06 10:45:43.316843');
INSERT INTO public.virksomhet VALUES (76, '849083854', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849083854', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.3224', '2023-06-06 10:45:43.3224');
INSERT INTO public.virksomhet VALUES (77, '826475210', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826475210', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.327618', '2023-06-06 10:45:43.327618');
INSERT INTO public.virksomhet VALUES (78, '808599455', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808599455', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.333799', '2023-06-06 10:45:43.333799');
INSERT INTO public.virksomhet VALUES (79, '899095286', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899095286', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.340844', '2023-06-06 10:45:43.340844');
INSERT INTO public.virksomhet VALUES (80, '856815634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856815634', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.356522', '2023-06-06 10:45:43.356522');
INSERT INTO public.virksomhet VALUES (81, '894474489', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894474489', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.363123', '2023-06-06 10:45:43.363123');
INSERT INTO public.virksomhet VALUES (82, '812047191', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812047191', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.371834', '2023-06-06 10:45:43.371834');
INSERT INTO public.virksomhet VALUES (83, '890777552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890777552', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.377171', '2023-06-06 10:45:43.377171');
INSERT INTO public.virksomhet VALUES (84, '820722587', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820722587', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.382543', '2023-06-06 10:45:43.382543');
INSERT INTO public.virksomhet VALUES (85, '809436178', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809436178', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.387534', '2023-06-06 10:45:43.387534');
INSERT INTO public.virksomhet VALUES (86, '810376980', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810376980', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.392624', '2023-06-06 10:45:43.392624');
INSERT INTO public.virksomhet VALUES (87, '890238030', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890238030', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.398934', '2023-06-06 10:45:43.398934');
INSERT INTO public.virksomhet VALUES (88, '828266999', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828266999', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.403626', '2023-06-06 10:45:43.403626');
INSERT INTO public.virksomhet VALUES (89, '862940033', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862940033', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.408711', '2023-06-06 10:45:43.408711');
INSERT INTO public.virksomhet VALUES (90, '880379202', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880379202', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.413971', '2023-06-06 10:45:43.413971');
INSERT INTO public.virksomhet VALUES (91, '810151455', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810151455', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.420293', '2023-06-06 10:45:43.420293');
INSERT INTO public.virksomhet VALUES (92, '881250314', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881250314', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.428268', '2023-06-06 10:45:43.428268');
INSERT INTO public.virksomhet VALUES (93, '875197324', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875197324', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.438243', '2023-06-06 10:45:43.438243');
INSERT INTO public.virksomhet VALUES (94, '824805720', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824805720', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.445626', '2023-06-06 10:45:43.445626');
INSERT INTO public.virksomhet VALUES (95, '842090861', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842090861', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.453809', '2023-06-06 10:45:43.453809');
INSERT INTO public.virksomhet VALUES (96, '813258691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813258691', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.460702', '2023-06-06 10:45:43.460702');
INSERT INTO public.virksomhet VALUES (97, '882246146', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882246146', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.467355', '2023-06-06 10:45:43.467355');
INSERT INTO public.virksomhet VALUES (98, '891407332', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891407332', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.473504', '2023-06-06 10:45:43.473504');
INSERT INTO public.virksomhet VALUES (99, '862068389', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862068389', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.480004', '2023-06-06 10:45:43.480004');
INSERT INTO public.virksomhet VALUES (100, '820736881', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820736881', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.485895', '2023-06-06 10:45:43.485895');
INSERT INTO public.virksomhet VALUES (101, '860629351', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860629351', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.492361', '2023-06-06 10:45:43.492361');
INSERT INTO public.virksomhet VALUES (102, '872381491', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872381491', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.498596', '2023-06-06 10:45:43.498596');
INSERT INTO public.virksomhet VALUES (103, '830484510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830484510', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.504371', '2023-06-06 10:45:43.504371');
INSERT INTO public.virksomhet VALUES (104, '861732339', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861732339', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.510434', '2023-06-06 10:45:43.510434');
INSERT INTO public.virksomhet VALUES (105, '813199268', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813199268', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.518012', '2023-06-06 10:45:43.518012');
INSERT INTO public.virksomhet VALUES (106, '821624303', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821624303', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.523904', '2023-06-06 10:45:43.523904');
INSERT INTO public.virksomhet VALUES (107, '856736407', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856736407', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.532059', '2023-06-06 10:45:43.532059');
INSERT INTO public.virksomhet VALUES (108, '897400542', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897400542', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.53841', '2023-06-06 10:45:43.53841');
INSERT INTO public.virksomhet VALUES (109, '895097486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895097486', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.547634', '2023-06-06 10:45:43.547634');
INSERT INTO public.virksomhet VALUES (110, '884021287', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884021287', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.555617', '2023-06-06 10:45:43.555617');
INSERT INTO public.virksomhet VALUES (111, '802114238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802114238', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.56212', '2023-06-06 10:45:43.56212');
INSERT INTO public.virksomhet VALUES (112, '842307904', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842307904', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.571988', '2023-06-06 10:45:43.571988');
INSERT INTO public.virksomhet VALUES (113, '892504040', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892504040', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.578688', '2023-06-06 10:45:43.578688');
INSERT INTO public.virksomhet VALUES (114, '865477980', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865477980', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.584012', '2023-06-06 10:45:43.584012');
INSERT INTO public.virksomhet VALUES (115, '828426342', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828426342', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.590069', '2023-06-06 10:45:43.590069');
INSERT INTO public.virksomhet VALUES (116, '869151445', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869151445', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.597155', '2023-06-06 10:45:43.597155');
INSERT INTO public.virksomhet VALUES (117, '859899076', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859899076', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.603455', '2023-06-06 10:45:43.603455');
INSERT INTO public.virksomhet VALUES (118, '821684747', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821684747', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.608995', '2023-06-06 10:45:43.608995');
INSERT INTO public.virksomhet VALUES (119, '897449659', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897449659', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.614878', '2023-06-06 10:45:43.614878');
INSERT INTO public.virksomhet VALUES (120, '878526531', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878526531', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.61956', '2023-06-06 10:45:43.61956');
INSERT INTO public.virksomhet VALUES (121, '855164299', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855164299', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.624643', '2023-06-06 10:45:43.624643');
INSERT INTO public.virksomhet VALUES (122, '855192908', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855192908', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.630138', '2023-06-06 10:45:43.630138');
INSERT INTO public.virksomhet VALUES (123, '806689657', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806689657', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.634662', '2023-06-06 10:45:43.634662');
INSERT INTO public.virksomhet VALUES (124, '878761080', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878761080', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.639115', '2023-06-06 10:45:43.639115');
INSERT INTO public.virksomhet VALUES (125, '848968830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848968830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.643552', '2023-06-06 10:45:43.643552');
INSERT INTO public.virksomhet VALUES (126, '885536119', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885536119', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.649766', '2023-06-06 10:45:43.649766');
INSERT INTO public.virksomhet VALUES (127, '878526130', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878526130', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.65464', '2023-06-06 10:45:43.65464');
INSERT INTO public.virksomhet VALUES (128, '843341562', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843341562', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.660854', '2023-06-06 10:45:43.660854');
INSERT INTO public.virksomhet VALUES (129, '800736288', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800736288', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.666213', '2023-06-06 10:45:43.666213');
INSERT INTO public.virksomhet VALUES (130, '807244123', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807244123', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.671728', '2023-06-06 10:45:43.671728');
INSERT INTO public.virksomhet VALUES (131, '877731403', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877731403', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.676293', '2023-06-06 10:45:43.676293');
INSERT INTO public.virksomhet VALUES (132, '888781937', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888781937', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.681401', '2023-06-06 10:45:43.681401');
INSERT INTO public.virksomhet VALUES (133, '806466365', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806466365', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.686016', '2023-06-06 10:45:43.686016');
INSERT INTO public.virksomhet VALUES (134, '800646971', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800646971', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.691081', '2023-06-06 10:45:43.691081');
INSERT INTO public.virksomhet VALUES (135, '803919694', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803919694', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.696157', '2023-06-06 10:45:43.696157');
INSERT INTO public.virksomhet VALUES (136, '813551155', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813551155', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.700624', '2023-06-06 10:45:43.700624');
INSERT INTO public.virksomhet VALUES (137, '824705088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824705088', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.705212', '2023-06-06 10:45:43.705212');
INSERT INTO public.virksomhet VALUES (138, '823188933', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823188933', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.710045', '2023-06-06 10:45:43.710045');
INSERT INTO public.virksomhet VALUES (139, '808053770', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808053770', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.716158', '2023-06-06 10:45:43.716158');
INSERT INTO public.virksomhet VALUES (140, '837635993', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837635993', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.720719', '2023-06-06 10:45:43.720719');
INSERT INTO public.virksomhet VALUES (141, '823114501', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823114501', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.725572', '2023-06-06 10:45:43.725572');
INSERT INTO public.virksomhet VALUES (142, '885375930', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885375930', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.730633', '2023-06-06 10:45:43.730633');
INSERT INTO public.virksomhet VALUES (143, '813722685', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813722685', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.735998', '2023-06-06 10:45:43.735998');
INSERT INTO public.virksomhet VALUES (144, '848590489', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848590489', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.741234', '2023-06-06 10:45:43.741234');
INSERT INTO public.virksomhet VALUES (145, '817418290', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817418290', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.750234', '2023-06-06 10:45:43.750234');
INSERT INTO public.virksomhet VALUES (146, '872291593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872291593', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.759614', '2023-06-06 10:45:43.759614');
INSERT INTO public.virksomhet VALUES (147, '843802830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843802830', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.767983', '2023-06-06 10:45:43.767983');
INSERT INTO public.virksomhet VALUES (148, '821596869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821596869', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.774108', '2023-06-06 10:45:43.774108');
INSERT INTO public.virksomhet VALUES (149, '834239593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834239593', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.779187', '2023-06-06 10:45:43.779187');
INSERT INTO public.virksomhet VALUES (150, '870405555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870405555', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.785017', '2023-06-06 10:45:43.785017');
INSERT INTO public.virksomhet VALUES (151, '862737958', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862737958', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.789466', '2023-06-06 10:45:43.789466');
INSERT INTO public.virksomhet VALUES (152, '894071655', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894071655', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.794196', '2023-06-06 10:45:43.794196');
INSERT INTO public.virksomhet VALUES (153, '837969510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837969510', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.799909', '2023-06-06 10:45:43.799909');
INSERT INTO public.virksomhet VALUES (154, '882289746', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882289746', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.805207', '2023-06-06 10:45:43.805207');
INSERT INTO public.virksomhet VALUES (155, '817085642', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817085642', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.810168', '2023-06-06 10:45:43.810168');
INSERT INTO public.virksomhet VALUES (156, '855446362', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855446362', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.816594', '2023-06-06 10:45:43.816594');
INSERT INTO public.virksomhet VALUES (157, '863729203', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863729203', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.821362', '2023-06-06 10:45:43.821362');
INSERT INTO public.virksomhet VALUES (158, '865462877', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865462877', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.827834', '2023-06-06 10:45:43.827834');
INSERT INTO public.virksomhet VALUES (159, '877210079', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877210079', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.835315', '2023-06-06 10:45:43.835315');
INSERT INTO public.virksomhet VALUES (160, '837164320', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837164320', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.840572', '2023-06-06 10:45:43.840572');
INSERT INTO public.virksomhet VALUES (161, '851474063', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851474063', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.845278', '2023-06-06 10:45:43.845278');
INSERT INTO public.virksomhet VALUES (162, '860815002', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860815002', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.856637', '2023-06-06 10:45:43.856637');
INSERT INTO public.virksomhet VALUES (163, '862485363', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862485363', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.866017', '2023-06-06 10:45:43.866017');
INSERT INTO public.virksomhet VALUES (164, '849849370', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849849370', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.872207', '2023-06-06 10:45:43.872207');
INSERT INTO public.virksomhet VALUES (165, '873754409', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873754409', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.877756', '2023-06-06 10:45:43.877756');
INSERT INTO public.virksomhet VALUES (166, '873757754', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873757754', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.882196', '2023-06-06 10:45:43.882196');
INSERT INTO public.virksomhet VALUES (167, '892804834', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892804834', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.887207', '2023-06-06 10:45:43.887207');
INSERT INTO public.virksomhet VALUES (168, '858511028', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858511028', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.892403', '2023-06-06 10:45:43.892403');
INSERT INTO public.virksomhet VALUES (169, '883788031', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883788031', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.89719', '2023-06-06 10:45:43.89719');
INSERT INTO public.virksomhet VALUES (170, '831779482', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831779482', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.901599', '2023-06-06 10:45:43.901599');
INSERT INTO public.virksomhet VALUES (171, '850012617', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850012617', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.906101', '2023-06-06 10:45:43.906101');
INSERT INTO public.virksomhet VALUES (172, '843819388', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843819388', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.912264', '2023-06-06 10:45:43.912264');
INSERT INTO public.virksomhet VALUES (173, '884434614', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884434614', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.918197', '2023-06-06 10:45:43.918197');
INSERT INTO public.virksomhet VALUES (174, '824703877', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824703877', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.923352', '2023-06-06 10:45:43.923352');
INSERT INTO public.virksomhet VALUES (175, '820025728', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820025728', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.930782', '2023-06-06 10:45:43.930782');
INSERT INTO public.virksomhet VALUES (176, '898643131', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898643131', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.938108', '2023-06-06 10:45:43.938108');
INSERT INTO public.virksomhet VALUES (177, '807776086', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807776086', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.94352', '2023-06-06 10:45:43.94352');
INSERT INTO public.virksomhet VALUES (178, '869091104', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869091104', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.952437', '2023-06-06 10:45:43.952437');
INSERT INTO public.virksomhet VALUES (179, '876709104', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876709104', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.958482', '2023-06-06 10:45:43.958482');
INSERT INTO public.virksomhet VALUES (180, '846022208', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846022208', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.96497', '2023-06-06 10:45:43.96497');
INSERT INTO public.virksomhet VALUES (181, '849221593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849221593', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.971853', '2023-06-06 10:45:43.971853');
INSERT INTO public.virksomhet VALUES (182, '803983066', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803983066', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.977588', '2023-06-06 10:45:43.977588');
INSERT INTO public.virksomhet VALUES (183, '852614210', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852614210', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.989791', '2023-06-06 10:45:43.989791');
INSERT INTO public.virksomhet VALUES (184, '807367405', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807367405', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:43.995518', '2023-06-06 10:45:43.995518');
INSERT INTO public.virksomhet VALUES (185, '818482835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818482835', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.001445', '2023-06-06 10:45:44.001445');
INSERT INTO public.virksomhet VALUES (186, '843050701', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843050701', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.010594', '2023-06-06 10:45:44.010594');
INSERT INTO public.virksomhet VALUES (187, '828046592', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828046592', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.017269', '2023-06-06 10:45:44.017269');
INSERT INTO public.virksomhet VALUES (188, '867914628', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867914628', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.023756', '2023-06-06 10:45:44.023756');
INSERT INTO public.virksomhet VALUES (189, '806486960', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806486960', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.032222', '2023-06-06 10:45:44.032222');
INSERT INTO public.virksomhet VALUES (190, '854307799', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854307799', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.038958', '2023-06-06 10:45:44.038958');
INSERT INTO public.virksomhet VALUES (191, '898974597', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898974597', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.04481', '2023-06-06 10:45:44.04481');
INSERT INTO public.virksomhet VALUES (192, '823872476', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823872476', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.051145', '2023-06-06 10:45:44.051145');
INSERT INTO public.virksomhet VALUES (193, '890435197', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890435197', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.058023', '2023-06-06 10:45:44.058023');
INSERT INTO public.virksomhet VALUES (194, '846425401', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846425401', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.063796', '2023-06-06 10:45:44.063796');
INSERT INTO public.virksomhet VALUES (195, '852145296', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852145296', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.069364', '2023-06-06 10:45:44.069364');
INSERT INTO public.virksomhet VALUES (196, '862444419', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862444419', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.076504', '2023-06-06 10:45:44.076504');
INSERT INTO public.virksomhet VALUES (197, '879842491', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879842491', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.082393', '2023-06-06 10:45:44.082393');
INSERT INTO public.virksomhet VALUES (198, '882660143', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882660143', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.089019', '2023-06-06 10:45:44.089019');
INSERT INTO public.virksomhet VALUES (199, '881043298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881043298', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.096256', '2023-06-06 10:45:44.096256');
INSERT INTO public.virksomhet VALUES (200, '893165291', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893165291', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.102597', '2023-06-06 10:45:44.102597');
INSERT INTO public.virksomhet VALUES (201, '827941273', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827941273', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.108511', '2023-06-06 10:45:44.108511');
INSERT INTO public.virksomhet VALUES (202, '861881935', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861881935', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.115272', '2023-06-06 10:45:44.115272');
INSERT INTO public.virksomhet VALUES (203, '802174984', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802174984', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.120739', '2023-06-06 10:45:44.120739');
INSERT INTO public.virksomhet VALUES (204, '858521935', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858521935', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.126883', '2023-06-06 10:45:44.126883');
INSERT INTO public.virksomhet VALUES (205, '818345166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818345166', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.133075', '2023-06-06 10:45:44.133075');
INSERT INTO public.virksomhet VALUES (206, '810280375', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810280375', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.139115', '2023-06-06 10:45:44.139115');
INSERT INTO public.virksomhet VALUES (207, '882063649', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882063649', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.144907', '2023-06-06 10:45:44.144907');
INSERT INTO public.virksomhet VALUES (208, '880150041', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880150041', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.151408', '2023-06-06 10:45:44.151408');
INSERT INTO public.virksomhet VALUES (209, '815490887', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815490887', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.157192', '2023-06-06 10:45:44.157192');
INSERT INTO public.virksomhet VALUES (210, '839389387', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839389387', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.162815', '2023-06-06 10:45:44.162815');
INSERT INTO public.virksomhet VALUES (211, '884601388', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884601388', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.168351', '2023-06-06 10:45:44.168351');
INSERT INTO public.virksomhet VALUES (212, '879432294', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879432294', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.174503', '2023-06-06 10:45:44.174503');
INSERT INTO public.virksomhet VALUES (213, '810840234', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810840234', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.180383', '2023-06-06 10:45:44.180383');
INSERT INTO public.virksomhet VALUES (214, '867469531', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867469531', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.185416', '2023-06-06 10:45:44.185416');
INSERT INTO public.virksomhet VALUES (215, '881832224', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881832224', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.191581', '2023-06-06 10:45:44.191581');
INSERT INTO public.virksomhet VALUES (216, '845694125', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845694125', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.196705', '2023-06-06 10:45:44.196705');
INSERT INTO public.virksomhet VALUES (217, '882816948', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882816948', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.201033', '2023-06-06 10:45:44.201033');
INSERT INTO public.virksomhet VALUES (218, '860781085', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860781085', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.206412', '2023-06-06 10:45:44.206412');
INSERT INTO public.virksomhet VALUES (219, '873714751', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873714751', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.212393', '2023-06-06 10:45:44.212393');
INSERT INTO public.virksomhet VALUES (220, '868280217', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868280217', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.218247', '2023-06-06 10:45:44.218247');
INSERT INTO public.virksomhet VALUES (221, '810425682', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810425682', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.223788', '2023-06-06 10:45:44.223788');
INSERT INTO public.virksomhet VALUES (222, '831398808', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831398808', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.231153', '2023-06-06 10:45:44.231153');
INSERT INTO public.virksomhet VALUES (223, '864416095', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864416095', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.237524', '2023-06-06 10:45:44.237524');
INSERT INTO public.virksomhet VALUES (224, '817595343', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817595343', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.242945', '2023-06-06 10:45:44.242945');
INSERT INTO public.virksomhet VALUES (225, '813096765', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813096765', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.249556', '2023-06-06 10:45:44.249556');
INSERT INTO public.virksomhet VALUES (226, '874523779', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874523779', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.256554', '2023-06-06 10:45:44.256554');
INSERT INTO public.virksomhet VALUES (227, '834142018', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834142018', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.262807', '2023-06-06 10:45:44.262807');
INSERT INTO public.virksomhet VALUES (228, '859964256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859964256', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.267602', '2023-06-06 10:45:44.267602');
INSERT INTO public.virksomhet VALUES (229, '867569758', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867569758', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.272778', '2023-06-06 10:45:44.272778');
INSERT INTO public.virksomhet VALUES (230, '892088330', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892088330', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.278184', '2023-06-06 10:45:44.278184');
INSERT INTO public.virksomhet VALUES (231, '879804077', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879804077', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.28359', '2023-06-06 10:45:44.28359');
INSERT INTO public.virksomhet VALUES (232, '838407602', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838407602', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.289447', '2023-06-06 10:45:44.289447');
INSERT INTO public.virksomhet VALUES (233, '817713278', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817713278', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.294958', '2023-06-06 10:45:44.294958');
INSERT INTO public.virksomhet VALUES (234, '881609271', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881609271', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.301205', '2023-06-06 10:45:44.301205');
INSERT INTO public.virksomhet VALUES (235, '803204320', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803204320', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.306324', '2023-06-06 10:45:44.306324');
INSERT INTO public.virksomhet VALUES (236, '898881449', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898881449', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.313754', '2023-06-06 10:45:44.313754');
INSERT INTO public.virksomhet VALUES (237, '878218652', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878218652', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.318623', '2023-06-06 10:45:44.318623');
INSERT INTO public.virksomhet VALUES (238, '843707057', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843707057', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.323804', '2023-06-06 10:45:44.323804');
INSERT INTO public.virksomhet VALUES (239, '823280302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823280302', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.332197', '2023-06-06 10:45:44.332197');
INSERT INTO public.virksomhet VALUES (240, '865097217', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865097217', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.337859', '2023-06-06 10:45:44.337859');
INSERT INTO public.virksomhet VALUES (241, '898114130', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898114130', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.343944', '2023-06-06 10:45:44.343944');
INSERT INTO public.virksomhet VALUES (242, '889994777', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889994777', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.350585', '2023-06-06 10:45:44.350585');
INSERT INTO public.virksomhet VALUES (243, '831772738', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831772738', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.371088', '2023-06-06 10:45:44.371088');
INSERT INTO public.virksomhet VALUES (244, '821965543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821965543', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.376669', '2023-06-06 10:45:44.376669');
INSERT INTO public.virksomhet VALUES (245, '824144039', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824144039', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.381608', '2023-06-06 10:45:44.381608');
INSERT INTO public.virksomhet VALUES (246, '813952219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813952219', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.386598', '2023-06-06 10:45:44.386598');
INSERT INTO public.virksomhet VALUES (247, '806033550', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806033550', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.394663', '2023-06-06 10:45:44.394663');
INSERT INTO public.virksomhet VALUES (248, '863033699', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863033699', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.399932', '2023-06-06 10:45:44.399932');
INSERT INTO public.virksomhet VALUES (249, '830460419', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830460419', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.404906', '2023-06-06 10:45:44.404906');
INSERT INTO public.virksomhet VALUES (250, '862572039', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862572039', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.409777', '2023-06-06 10:45:44.409777');
INSERT INTO public.virksomhet VALUES (251, '872881350', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872881350', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.414994', '2023-06-06 10:45:44.414994');
INSERT INTO public.virksomhet VALUES (252, '865076375', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865076375', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.41961', '2023-06-06 10:45:44.41961');
INSERT INTO public.virksomhet VALUES (253, '892105387', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892105387', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.425247', '2023-06-06 10:45:44.425247');
INSERT INTO public.virksomhet VALUES (254, '837331399', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837331399', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.434065', '2023-06-06 10:45:44.434065');
INSERT INTO public.virksomhet VALUES (255, '895071510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895071510', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.441898', '2023-06-06 10:45:44.441898');
INSERT INTO public.virksomhet VALUES (256, '841293887', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841293887', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.449607', '2023-06-06 10:45:44.449607');
INSERT INTO public.virksomhet VALUES (257, '800500213', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800500213', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.457757', '2023-06-06 10:45:44.457757');
INSERT INTO public.virksomhet VALUES (258, '830955221', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830955221', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.463728', '2023-06-06 10:45:44.463728');
INSERT INTO public.virksomhet VALUES (259, '889579186', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889579186', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.470218', '2023-06-06 10:45:44.470218');
INSERT INTO public.virksomhet VALUES (260, '855457757', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855457757', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.474593', '2023-06-06 10:45:44.474593');
INSERT INTO public.virksomhet VALUES (261, '831090240', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831090240', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.479354', '2023-06-06 10:45:44.479354');
INSERT INTO public.virksomhet VALUES (262, '870649563', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870649563', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.483252', '2023-06-06 10:45:44.483252');
INSERT INTO public.virksomhet VALUES (263, '857087897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857087897', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.487561', '2023-06-06 10:45:44.487561');
INSERT INTO public.virksomhet VALUES (264, '801668365', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801668365', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.491591', '2023-06-06 10:45:44.491591');
INSERT INTO public.virksomhet VALUES (265, '843548104', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843548104', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.496051', '2023-06-06 10:45:44.496051');
INSERT INTO public.virksomhet VALUES (266, '843679245', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843679245', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.500099', '2023-06-06 10:45:44.500099');
INSERT INTO public.virksomhet VALUES (267, '856500575', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856500575', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.504857', '2023-06-06 10:45:44.504857');
INSERT INTO public.virksomhet VALUES (268, '856001243', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856001243', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.509037', '2023-06-06 10:45:44.509037');
INSERT INTO public.virksomhet VALUES (269, '817878762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817878762', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.514654', '2023-06-06 10:45:44.514654');
INSERT INTO public.virksomhet VALUES (270, '838146594', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838146594', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.519747', '2023-06-06 10:45:44.519747');
INSERT INTO public.virksomhet VALUES (271, '840075284', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840075284', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.524447', '2023-06-06 10:45:44.524447');
INSERT INTO public.virksomhet VALUES (272, '821662895', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821662895', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.529643', '2023-06-06 10:45:44.529643');
INSERT INTO public.virksomhet VALUES (273, '843837108', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843837108', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.534835', '2023-06-06 10:45:44.534835');
INSERT INTO public.virksomhet VALUES (274, '845031784', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845031784', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.54037', '2023-06-06 10:45:44.54037');
INSERT INTO public.virksomhet VALUES (275, '875565818', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875565818', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.549328', '2023-06-06 10:45:44.549328');
INSERT INTO public.virksomhet VALUES (276, '803038597', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803038597', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.555295', '2023-06-06 10:45:44.555295');
INSERT INTO public.virksomhet VALUES (277, '839555854', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839555854', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.560668', '2023-06-06 10:45:44.560668');
INSERT INTO public.virksomhet VALUES (278, '857557135', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857557135', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.565109', '2023-06-06 10:45:44.565109');
INSERT INTO public.virksomhet VALUES (279, '815608021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815608021', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.570341', '2023-06-06 10:45:44.570341');
INSERT INTO public.virksomhet VALUES (280, '893397601', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893397601', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.576453', '2023-06-06 10:45:44.576453');
INSERT INTO public.virksomhet VALUES (281, '824822764', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824822764', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.581575', '2023-06-06 10:45:44.581575');
INSERT INTO public.virksomhet VALUES (282, '858635007', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858635007', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.587096', '2023-06-06 10:45:44.587096');
INSERT INTO public.virksomhet VALUES (283, '860185319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860185319', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.592198', '2023-06-06 10:45:44.592198');
INSERT INTO public.virksomhet VALUES (284, '874789310', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874789310', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.59733', '2023-06-06 10:45:44.59733');
INSERT INTO public.virksomhet VALUES (285, '895950630', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895950630', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.602245', '2023-06-06 10:45:44.602245');
INSERT INTO public.virksomhet VALUES (286, '812733329', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812733329', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.607327', '2023-06-06 10:45:44.607327');
INSERT INTO public.virksomhet VALUES (287, '849504303', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849504303', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.612565', '2023-06-06 10:45:44.612565');
INSERT INTO public.virksomhet VALUES (288, '810836388', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810836388', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.617951', '2023-06-06 10:45:44.617951');
INSERT INTO public.virksomhet VALUES (289, '893711345', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893711345', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.623454', '2023-06-06 10:45:44.623454');
INSERT INTO public.virksomhet VALUES (290, '883273560', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883273560', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.628702', '2023-06-06 10:45:44.628702');
INSERT INTO public.virksomhet VALUES (291, '857320873', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857320873', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.634325', '2023-06-06 10:45:44.634325');
INSERT INTO public.virksomhet VALUES (292, '894715113', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894715113', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.639151', '2023-06-06 10:45:44.639151');
INSERT INTO public.virksomhet VALUES (293, '874369743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874369743', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.643729', '2023-06-06 10:45:44.643729');
INSERT INTO public.virksomhet VALUES (294, '859338769', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859338769', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.649122', '2023-06-06 10:45:44.649122');
INSERT INTO public.virksomhet VALUES (295, '822981319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822981319', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.653619', '2023-06-06 10:45:44.653619');
INSERT INTO public.virksomhet VALUES (296, '894746652', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894746652', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.658939', '2023-06-06 10:45:44.658939');
INSERT INTO public.virksomhet VALUES (297, '820460458', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820460458', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.664147', '2023-06-06 10:45:44.664147');
INSERT INTO public.virksomhet VALUES (298, '836428741', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836428741', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.669031', '2023-06-06 10:45:44.669031');
INSERT INTO public.virksomhet VALUES (299, '808239579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808239579', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.67442', '2023-06-06 10:45:44.67442');
INSERT INTO public.virksomhet VALUES (300, '853991955', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853991955', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.680282', '2023-06-06 10:45:44.680282');
INSERT INTO public.virksomhet VALUES (301, '821827369', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821827369', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.686215', '2023-06-06 10:45:44.686215');
INSERT INTO public.virksomhet VALUES (302, '853794730', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853794730', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.691965', '2023-06-06 10:45:44.691965');
INSERT INTO public.virksomhet VALUES (303, '877750244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877750244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.69729', '2023-06-06 10:45:44.69729');
INSERT INTO public.virksomhet VALUES (304, '886802160', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886802160', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.702388', '2023-06-06 10:45:44.702388');
INSERT INTO public.virksomhet VALUES (305, '825906262', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825906262', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.708254', '2023-06-06 10:45:44.708254');
INSERT INTO public.virksomhet VALUES (306, '830671460', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830671460', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.714301', '2023-06-06 10:45:44.714301');
INSERT INTO public.virksomhet VALUES (307, '886022624', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886022624', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.720415', '2023-06-06 10:45:44.720415');
INSERT INTO public.virksomhet VALUES (308, '845456654', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845456654', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.726234', '2023-06-06 10:45:44.726234');
INSERT INTO public.virksomhet VALUES (309, '884934109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884934109', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.733765', '2023-06-06 10:45:44.733765');
INSERT INTO public.virksomhet VALUES (310, '893013889', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893013889', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.739459', '2023-06-06 10:45:44.739459');
INSERT INTO public.virksomhet VALUES (311, '874793666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874793666', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.745479', '2023-06-06 10:45:44.745479');
INSERT INTO public.virksomhet VALUES (312, '839840143', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839840143', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.751693', '2023-06-06 10:45:44.751693');
INSERT INTO public.virksomhet VALUES (313, '855087843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855087843', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.758693', '2023-06-06 10:45:44.758693');
INSERT INTO public.virksomhet VALUES (314, '803909703', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803909703', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.763991', '2023-06-06 10:45:44.763991');
INSERT INTO public.virksomhet VALUES (315, '835613827', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835613827', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.769652', '2023-06-06 10:45:44.769652');
INSERT INTO public.virksomhet VALUES (316, '890368704', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890368704', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.775214', '2023-06-06 10:45:44.775214');
INSERT INTO public.virksomhet VALUES (317, '835188155', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835188155', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.780081', '2023-06-06 10:45:44.780081');
INSERT INTO public.virksomhet VALUES (318, '800268973', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800268973', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.784314', '2023-06-06 10:45:44.784314');
INSERT INTO public.virksomhet VALUES (319, '823381866', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823381866', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.789176', '2023-06-06 10:45:44.789176');
INSERT INTO public.virksomhet VALUES (320, '819345705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819345705', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.794165', '2023-06-06 10:45:44.794165');
INSERT INTO public.virksomhet VALUES (321, '858313561', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858313561', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.800291', '2023-06-06 10:45:44.800291');
INSERT INTO public.virksomhet VALUES (322, '807334012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807334012', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.804411', '2023-06-06 10:45:44.804411');
INSERT INTO public.virksomhet VALUES (323, '896839457', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896839457', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.808872', '2023-06-06 10:45:44.808872');
INSERT INTO public.virksomhet VALUES (324, '893504480', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893504480', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.813836', '2023-06-06 10:45:44.813836');
INSERT INTO public.virksomhet VALUES (325, '811376499', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811376499', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.818271', '2023-06-06 10:45:44.818271');
INSERT INTO public.virksomhet VALUES (326, '839956153', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839956153', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.8225', '2023-06-06 10:45:44.8225');
INSERT INTO public.virksomhet VALUES (327, '880478707', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880478707', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.826735', '2023-06-06 10:45:44.826735');
INSERT INTO public.virksomhet VALUES (328, '885376947', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885376947', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.832313', '2023-06-06 10:45:44.832313');
INSERT INTO public.virksomhet VALUES (329, '872081220', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872081220', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.837441', '2023-06-06 10:45:44.837441');
INSERT INTO public.virksomhet VALUES (330, '822891769', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822891769', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.841725', '2023-06-06 10:45:44.841725');
INSERT INTO public.virksomhet VALUES (331, '805863410', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805863410', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.846215', '2023-06-06 10:45:44.846215');
INSERT INTO public.virksomhet VALUES (332, '863609151', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863609151', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.850433', '2023-06-06 10:45:44.850433');
INSERT INTO public.virksomhet VALUES (333, '848216997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848216997', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.85467', '2023-06-06 10:45:44.85467');
INSERT INTO public.virksomhet VALUES (334, '865120206', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865120206', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.859631', '2023-06-06 10:45:44.859631');
INSERT INTO public.virksomhet VALUES (335, '866740216', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866740216', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.870412', '2023-06-06 10:45:44.870412');
INSERT INTO public.virksomhet VALUES (336, '864140200', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864140200', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.881967', '2023-06-06 10:45:44.881967');
INSERT INTO public.virksomhet VALUES (337, '897926718', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897926718', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.886287', '2023-06-06 10:45:44.886287');
INSERT INTO public.virksomhet VALUES (338, '884422045', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884422045', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.891295', '2023-06-06 10:45:44.891295');
INSERT INTO public.virksomhet VALUES (339, '820615064', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820615064', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.89695', '2023-06-06 10:45:44.89695');
INSERT INTO public.virksomhet VALUES (340, '864666925', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864666925', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.906713', '2023-06-06 10:45:44.906713');
INSERT INTO public.virksomhet VALUES (341, '835261981', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835261981', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.911582', '2023-06-06 10:45:44.911582');
INSERT INTO public.virksomhet VALUES (342, '881186163', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881186163', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.917064', '2023-06-06 10:45:44.917064');
INSERT INTO public.virksomhet VALUES (343, '830886980', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830886980', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.921528', '2023-06-06 10:45:44.921528');
INSERT INTO public.virksomhet VALUES (344, '881297676', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881297676', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.926138', '2023-06-06 10:45:44.926138');
INSERT INTO public.virksomhet VALUES (345, '846943054', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846943054', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.933697', '2023-06-06 10:45:44.933697');
INSERT INTO public.virksomhet VALUES (346, '858637684', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858637684', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.940069', '2023-06-06 10:45:44.940069');
INSERT INTO public.virksomhet VALUES (347, '808580153', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808580153', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.944955', '2023-06-06 10:45:44.944955');
INSERT INTO public.virksomhet VALUES (348, '831384168', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831384168', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.950527', '2023-06-06 10:45:44.950527');
INSERT INTO public.virksomhet VALUES (349, '826740518', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826740518', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.955481', '2023-06-06 10:45:44.955481');
INSERT INTO public.virksomhet VALUES (350, '801382461', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801382461', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.959879', '2023-06-06 10:45:44.959879');
INSERT INTO public.virksomhet VALUES (351, '873647199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873647199', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.964658', '2023-06-06 10:45:44.964658');
INSERT INTO public.virksomhet VALUES (352, '895605255', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895605255', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.969538', '2023-06-06 10:45:44.969538');
INSERT INTO public.virksomhet VALUES (353, '870822727', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870822727', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.974226', '2023-06-06 10:45:44.974226');
INSERT INTO public.virksomhet VALUES (354, '893467385', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893467385', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.978977', '2023-06-06 10:45:44.978977');
INSERT INTO public.virksomhet VALUES (355, '890913075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890913075', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.983277', '2023-06-06 10:45:44.983277');
INSERT INTO public.virksomhet VALUES (356, '831873371', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831873371', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.988446', '2023-06-06 10:45:44.988446');
INSERT INTO public.virksomhet VALUES (357, '861316602', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861316602', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.993065', '2023-06-06 10:45:44.993065');
INSERT INTO public.virksomhet VALUES (358, '892864663', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892864663', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:44.998936', '2023-06-06 10:45:44.998936');
INSERT INTO public.virksomhet VALUES (359, '845152279', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845152279', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.003613', '2023-06-06 10:45:45.003613');
INSERT INTO public.virksomhet VALUES (360, '897305579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897305579', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.009008', '2023-06-06 10:45:45.009008');
INSERT INTO public.virksomhet VALUES (361, '810297653', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810297653', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.01447', '2023-06-06 10:45:45.01447');
INSERT INTO public.virksomhet VALUES (362, '890247793', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890247793', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.019375', '2023-06-06 10:45:45.019375');
INSERT INTO public.virksomhet VALUES (363, '845466381', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845466381', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.02494', '2023-06-06 10:45:45.02494');
INSERT INTO public.virksomhet VALUES (364, '806092322', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806092322', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.030842', '2023-06-06 10:45:45.030842');
INSERT INTO public.virksomhet VALUES (365, '829331354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829331354', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.036181', '2023-06-06 10:45:45.036181');
INSERT INTO public.virksomhet VALUES (366, '891213279', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891213279', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.040924', '2023-06-06 10:45:45.040924');
INSERT INTO public.virksomhet VALUES (367, '849837369', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849837369', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.04595', '2023-06-06 10:45:45.04595');
INSERT INTO public.virksomhet VALUES (368, '803612149', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803612149', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.052363', '2023-06-06 10:45:45.052363');
INSERT INTO public.virksomhet VALUES (369, '825023252', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825023252', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.057563', '2023-06-06 10:45:45.057563');
INSERT INTO public.virksomhet VALUES (370, '846353053', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846353053', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.062401', '2023-06-06 10:45:45.062401');
INSERT INTO public.virksomhet VALUES (371, '810258838', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810258838', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.067896', '2023-06-06 10:45:45.067896');
INSERT INTO public.virksomhet VALUES (372, '879431708', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879431708', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.073056', '2023-06-06 10:45:45.073056');
INSERT INTO public.virksomhet VALUES (373, '835156452', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835156452', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.078062', '2023-06-06 10:45:45.078062');
INSERT INTO public.virksomhet VALUES (374, '835423243', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835423243', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.082996', '2023-06-06 10:45:45.082996');
INSERT INTO public.virksomhet VALUES (375, '800507941', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800507941', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.08797', '2023-06-06 10:45:45.08797');
INSERT INTO public.virksomhet VALUES (376, '823546489', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823546489', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.093277', '2023-06-06 10:45:45.093277');
INSERT INTO public.virksomhet VALUES (377, '889415226', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889415226', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.099085', '2023-06-06 10:45:45.099085');
INSERT INTO public.virksomhet VALUES (378, '868514999', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868514999', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.104525', '2023-06-06 10:45:45.104525');
INSERT INTO public.virksomhet VALUES (379, '816785668', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816785668', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.109854', '2023-06-06 10:45:45.109854');
INSERT INTO public.virksomhet VALUES (380, '877477414', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877477414', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.115525', '2023-06-06 10:45:45.115525');
INSERT INTO public.virksomhet VALUES (381, '867399503', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867399503', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.120989', '2023-06-06 10:45:45.120989');
INSERT INTO public.virksomhet VALUES (382, '803782547', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803782547', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.127141', '2023-06-06 10:45:45.127141');
INSERT INTO public.virksomhet VALUES (383, '840591750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840591750', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.134729', '2023-06-06 10:45:45.134729');
INSERT INTO public.virksomhet VALUES (384, '897874002', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897874002', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.141461', '2023-06-06 10:45:45.141461');
INSERT INTO public.virksomhet VALUES (385, '847726893', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847726893', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.147971', '2023-06-06 10:45:45.147971');
INSERT INTO public.virksomhet VALUES (386, '807440611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807440611', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.154936', '2023-06-06 10:45:45.154936');
INSERT INTO public.virksomhet VALUES (387, '883830580', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883830580', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.160546', '2023-06-06 10:45:45.160546');
INSERT INTO public.virksomhet VALUES (388, '815955507', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815955507', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.166369', '2023-06-06 10:45:45.166369');
INSERT INTO public.virksomhet VALUES (389, '837470311', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837470311', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.173041', '2023-06-06 10:45:45.173041');
INSERT INTO public.virksomhet VALUES (390, '837256305', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837256305', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.17849', '2023-06-06 10:45:45.17849');
INSERT INTO public.virksomhet VALUES (391, '842747033', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842747033', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.184288', '2023-06-06 10:45:45.184288');
INSERT INTO public.virksomhet VALUES (392, '873819010', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873819010', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.190703', '2023-06-06 10:45:45.190703');
INSERT INTO public.virksomhet VALUES (393, '803549422', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803549422', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.195761', '2023-06-06 10:45:45.195761');
INSERT INTO public.virksomhet VALUES (394, '814219285', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814219285', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.201796', '2023-06-06 10:45:45.201796');
INSERT INTO public.virksomhet VALUES (395, '806755875', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806755875', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.207867', '2023-06-06 10:45:45.207867');
INSERT INTO public.virksomhet VALUES (396, '808335242', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808335242', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.215588', '2023-06-06 10:45:45.215588');
INSERT INTO public.virksomhet VALUES (397, '833332848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833332848', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.221284', '2023-06-06 10:45:45.221284');
INSERT INTO public.virksomhet VALUES (398, '844409589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844409589', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.226444', '2023-06-06 10:45:45.226444');
INSERT INTO public.virksomhet VALUES (399, '863230590', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863230590', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.233377', '2023-06-06 10:45:45.233377');
INSERT INTO public.virksomhet VALUES (400, '816633410', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816633410', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.238796', '2023-06-06 10:45:45.238796');
INSERT INTO public.virksomhet VALUES (401, '838405064', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838405064', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.243568', '2023-06-06 10:45:45.243568');
INSERT INTO public.virksomhet VALUES (402, '818054973', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818054973', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.249811', '2023-06-06 10:45:45.249811');
INSERT INTO public.virksomhet VALUES (403, '822120794', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822120794', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.254964', '2023-06-06 10:45:45.254964');
INSERT INTO public.virksomhet VALUES (404, '803175784', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803175784', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.259165', '2023-06-06 10:45:45.259165');
INSERT INTO public.virksomhet VALUES (405, '861389317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861389317', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.2659', '2023-06-06 10:45:45.2659');
INSERT INTO public.virksomhet VALUES (406, '851061579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851061579', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.271904', '2023-06-06 10:45:45.271904');
INSERT INTO public.virksomhet VALUES (407, '884377478', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884377478', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.277198', '2023-06-06 10:45:45.277198');
INSERT INTO public.virksomhet VALUES (408, '804695621', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804695621', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.282148', '2023-06-06 10:45:45.282148');
INSERT INTO public.virksomhet VALUES (409, '862776743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862776743', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.287011', '2023-06-06 10:45:45.287011');
INSERT INTO public.virksomhet VALUES (410, '824502776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824502776', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.2911', '2023-06-06 10:45:45.2911');
INSERT INTO public.virksomhet VALUES (411, '801824362', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801824362', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.296436', '2023-06-06 10:45:45.296436');
INSERT INTO public.virksomhet VALUES (412, '855825895', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855825895', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.301137', '2023-06-06 10:45:45.301137');
INSERT INTO public.virksomhet VALUES (413, '806038994', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806038994', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.305366', '2023-06-06 10:45:45.305366');
INSERT INTO public.virksomhet VALUES (414, '887795244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887795244', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.310554', '2023-06-06 10:45:45.310554');
INSERT INTO public.virksomhet VALUES (415, '816697499', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816697499', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.31546', '2023-06-06 10:45:45.31546');
INSERT INTO public.virksomhet VALUES (416, '851165573', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851165573', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.32083', '2023-06-06 10:45:45.32083');
INSERT INTO public.virksomhet VALUES (417, '899139480', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899139480', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.325042', '2023-06-06 10:45:45.325042');
INSERT INTO public.virksomhet VALUES (418, '843588289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843588289', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.330617', '2023-06-06 10:45:45.330617');
INSERT INTO public.virksomhet VALUES (419, '869634632', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869634632', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.33609', '2023-06-06 10:45:45.33609');
INSERT INTO public.virksomhet VALUES (420, '877345136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877345136', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.34066', '2023-06-06 10:45:45.34066');
INSERT INTO public.virksomhet VALUES (421, '829442619', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829442619', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.345827', '2023-06-06 10:45:45.345827');
INSERT INTO public.virksomhet VALUES (422, '887417323', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887417323', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.351631', '2023-06-06 10:45:45.351631');
INSERT INTO public.virksomhet VALUES (423, '894887962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894887962', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.356707', '2023-06-06 10:45:45.356707');
INSERT INTO public.virksomhet VALUES (424, '846850436', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846850436', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.361171', '2023-06-06 10:45:45.361171');
INSERT INTO public.virksomhet VALUES (425, '893618876', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893618876', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.36679', '2023-06-06 10:45:45.36679');
INSERT INTO public.virksomhet VALUES (426, '842192541', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842192541', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.38252', '2023-06-06 10:45:45.38252');
INSERT INTO public.virksomhet VALUES (427, '812859980', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812859980', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.390765', '2023-06-06 10:45:45.390765');
INSERT INTO public.virksomhet VALUES (428, '854266224', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854266224', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.397309', '2023-06-06 10:45:45.397309');
INSERT INTO public.virksomhet VALUES (429, '856588503', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856588503', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.403684', '2023-06-06 10:45:45.403684');
INSERT INTO public.virksomhet VALUES (430, '848336286', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848336286', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.410687', '2023-06-06 10:45:45.410687');
INSERT INTO public.virksomhet VALUES (431, '896802157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896802157', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.418357', '2023-06-06 10:45:45.418357');
INSERT INTO public.virksomhet VALUES (432, '844933969', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844933969', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.424009', '2023-06-06 10:45:45.424009');
INSERT INTO public.virksomhet VALUES (433, '810623853', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810623853', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.433199', '2023-06-06 10:45:45.433199');
INSERT INTO public.virksomhet VALUES (434, '862213656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862213656', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.440063', '2023-06-06 10:45:45.440063');
INSERT INTO public.virksomhet VALUES (435, '875365543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875365543', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.446834', '2023-06-06 10:45:45.446834');
INSERT INTO public.virksomhet VALUES (436, '843459100', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843459100', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.45471', '2023-06-06 10:45:45.45471');
INSERT INTO public.virksomhet VALUES (437, '842552299', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842552299', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.461121', '2023-06-06 10:45:45.461121');
INSERT INTO public.virksomhet VALUES (438, '898017856', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898017856', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.466208', '2023-06-06 10:45:45.466208');
INSERT INTO public.virksomhet VALUES (439, '893101300', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893101300', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.472323', '2023-06-06 10:45:45.472323');
INSERT INTO public.virksomhet VALUES (440, '823158334', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823158334', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.477755', '2023-06-06 10:45:45.477755');
INSERT INTO public.virksomhet VALUES (441, '877940029', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877940029', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.482894', '2023-06-06 10:45:45.482894');
INSERT INTO public.virksomhet VALUES (442, '844999502', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844999502', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.489737', '2023-06-06 10:45:45.489737');
INSERT INTO public.virksomhet VALUES (443, '857539272', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857539272', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.494844', '2023-06-06 10:45:45.494844');
INSERT INTO public.virksomhet VALUES (444, '808770941', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808770941', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.50022', '2023-06-06 10:45:45.50022');
INSERT INTO public.virksomhet VALUES (445, '856491360', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856491360', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.504825', '2023-06-06 10:45:45.504825');
INSERT INTO public.virksomhet VALUES (446, '886740513', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886740513', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.509572', '2023-06-06 10:45:45.509572');
INSERT INTO public.virksomhet VALUES (447, '812672034', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812672034', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.514939', '2023-06-06 10:45:45.514939');
INSERT INTO public.virksomhet VALUES (448, '889929780', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889929780', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.519778', '2023-06-06 10:45:45.519778');
INSERT INTO public.virksomhet VALUES (449, '899700568', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899700568', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.523792', '2023-06-06 10:45:45.523792');
INSERT INTO public.virksomhet VALUES (450, '884630618', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884630618', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.531156', '2023-06-06 10:45:45.531156');
INSERT INTO public.virksomhet VALUES (451, '897345252', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897345252', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.535637', '2023-06-06 10:45:45.535637');
INSERT INTO public.virksomhet VALUES (452, '898834824', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898834824', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.539782', '2023-06-06 10:45:45.539782');
INSERT INTO public.virksomhet VALUES (453, '811318992', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811318992', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.545201', '2023-06-06 10:45:45.545201');
INSERT INTO public.virksomhet VALUES (454, '829482232', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829482232', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.551988', '2023-06-06 10:45:45.551988');
INSERT INTO public.virksomhet VALUES (455, '869652190', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869652190', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.556313', '2023-06-06 10:45:45.556313');
INSERT INTO public.virksomhet VALUES (456, '831602749', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831602749', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.560811', '2023-06-06 10:45:45.560811');
INSERT INTO public.virksomhet VALUES (457, '827983273', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827983273', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.565248', '2023-06-06 10:45:45.565248');
INSERT INTO public.virksomhet VALUES (458, '875978285', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875978285', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.570287', '2023-06-06 10:45:45.570287');
INSERT INTO public.virksomhet VALUES (459, '879448319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879448319', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.57754', '2023-06-06 10:45:45.57754');
INSERT INTO public.virksomhet VALUES (460, '890365662', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890365662', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.581809', '2023-06-06 10:45:45.581809');
INSERT INTO public.virksomhet VALUES (461, '842225948', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842225948', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.58637', '2023-06-06 10:45:45.58637');
INSERT INTO public.virksomhet VALUES (462, '894379311', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894379311', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.590618', '2023-06-06 10:45:45.590618');
INSERT INTO public.virksomhet VALUES (463, '816163475', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816163475', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.595125', '2023-06-06 10:45:45.595125');
INSERT INTO public.virksomhet VALUES (464, '840695880', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840695880', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.599907', '2023-06-06 10:45:45.599907');
INSERT INTO public.virksomhet VALUES (465, '858310890', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858310890', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.604408', '2023-06-06 10:45:45.604408');
INSERT INTO public.virksomhet VALUES (466, '822831897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822831897', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.608733', '2023-06-06 10:45:45.608733');
INSERT INTO public.virksomhet VALUES (467, '823135340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823135340', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.614373', '2023-06-06 10:45:45.614373');
INSERT INTO public.virksomhet VALUES (468, '854882590', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854882590', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.61874', '2023-06-06 10:45:45.61874');
INSERT INTO public.virksomhet VALUES (469, '878711282', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878711282', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.622987', '2023-06-06 10:45:45.622987');
INSERT INTO public.virksomhet VALUES (470, '826851792', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826851792', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.627947', '2023-06-06 10:45:45.627947');
INSERT INTO public.virksomhet VALUES (471, '843815881', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843815881', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.633579', '2023-06-06 10:45:45.633579');
INSERT INTO public.virksomhet VALUES (472, '873363916', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873363916', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.638286', '2023-06-06 10:45:45.638286');
INSERT INTO public.virksomhet VALUES (473, '837374078', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837374078', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.642498', '2023-06-06 10:45:45.642498');
INSERT INTO public.virksomhet VALUES (474, '884327994', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884327994', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.647373', '2023-06-06 10:45:45.647373');
INSERT INTO public.virksomhet VALUES (475, '839366397', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839366397', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.652036', '2023-06-06 10:45:45.652036');
INSERT INTO public.virksomhet VALUES (476, '886102255', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886102255', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.656709', '2023-06-06 10:45:45.656709');
INSERT INTO public.virksomhet VALUES (477, '856078205', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856078205', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.66156', '2023-06-06 10:45:45.66156');
INSERT INTO public.virksomhet VALUES (478, '853440141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853440141', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.666014', '2023-06-06 10:45:45.666014');
INSERT INTO public.virksomhet VALUES (479, '832737996', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832737996', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.670483', '2023-06-06 10:45:45.670483');
INSERT INTO public.virksomhet VALUES (480, '868794856', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868794856', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.676472', '2023-06-06 10:45:45.676472');
INSERT INTO public.virksomhet VALUES (481, '806403689', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806403689', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.682572', '2023-06-06 10:45:45.682572');
INSERT INTO public.virksomhet VALUES (482, '895299443', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895299443', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.689851', '2023-06-06 10:45:45.689851');
INSERT INTO public.virksomhet VALUES (483, '846372277', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846372277', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.695446', '2023-06-06 10:45:45.695446');
INSERT INTO public.virksomhet VALUES (484, '833883439', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833883439', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.700509', '2023-06-06 10:45:45.700509');
INSERT INTO public.virksomhet VALUES (485, '841140296', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841140296', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.704988', '2023-06-06 10:45:45.704988');
INSERT INTO public.virksomhet VALUES (486, '884466343', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884466343', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.710056', '2023-06-06 10:45:45.710056');
INSERT INTO public.virksomhet VALUES (487, '849750724', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849750724', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.715147', '2023-06-06 10:45:45.715147');
INSERT INTO public.virksomhet VALUES (488, '894340275', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894340275', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.720078', '2023-06-06 10:45:45.720078');
INSERT INTO public.virksomhet VALUES (489, '814779312', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814779312', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.724295', '2023-06-06 10:45:45.724295');
INSERT INTO public.virksomhet VALUES (490, '879486882', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879486882', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.72955', '2023-06-06 10:45:45.72955');
INSERT INTO public.virksomhet VALUES (491, '888383595', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888383595', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.734161', '2023-06-06 10:45:45.734161');
INSERT INTO public.virksomhet VALUES (492, '858890670', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858890670', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.738847', '2023-06-06 10:45:45.738847');
INSERT INTO public.virksomhet VALUES (493, '812082043', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812082043', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.743213', '2023-06-06 10:45:45.743213');
INSERT INTO public.virksomhet VALUES (494, '823842450', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823842450', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.748095', '2023-06-06 10:45:45.748095');
INSERT INTO public.virksomhet VALUES (495, '880886744', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880886744', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.753966', '2023-06-06 10:45:45.753966');
INSERT INTO public.virksomhet VALUES (496, '839066600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839066600', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.758521', '2023-06-06 10:45:45.758521');
INSERT INTO public.virksomhet VALUES (497, '888994357', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888994357', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.762872', '2023-06-06 10:45:45.762872');
INSERT INTO public.virksomhet VALUES (498, '851004605', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851004605', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.767408', '2023-06-06 10:45:45.767408');
INSERT INTO public.virksomhet VALUES (499, '805363239', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805363239', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.77218', '2023-06-06 10:45:45.77218');
INSERT INTO public.virksomhet VALUES (500, '819929608', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819929608', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.778238', '2023-06-06 10:45:45.778238');
INSERT INTO public.virksomhet VALUES (501, '827204080', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827204080', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.783842', '2023-06-06 10:45:45.783842');
INSERT INTO public.virksomhet VALUES (502, '862977616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862977616', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.78864', '2023-06-06 10:45:45.78864');
INSERT INTO public.virksomhet VALUES (503, '804885788', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804885788', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.794276', '2023-06-06 10:45:45.794276');
INSERT INTO public.virksomhet VALUES (504, '864974024', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864974024', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.801445', '2023-06-06 10:45:45.801445');
INSERT INTO public.virksomhet VALUES (505, '896354155', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896354155', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.806176', '2023-06-06 10:45:45.806176');
INSERT INTO public.virksomhet VALUES (506, '811550861', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811550861', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.811455', '2023-06-06 10:45:45.811455');
INSERT INTO public.virksomhet VALUES (507, '877077716', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877077716', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.816636', '2023-06-06 10:45:45.816636');
INSERT INTO public.virksomhet VALUES (508, '850687115', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850687115', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.821107', '2023-06-06 10:45:45.821107');
INSERT INTO public.virksomhet VALUES (509, '832145659', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832145659', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.827991', '2023-06-06 10:45:45.827991');
INSERT INTO public.virksomhet VALUES (510, '822580377', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822580377', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:45.834873', '2023-06-06 10:45:45.834873');
INSERT INTO public.virksomhet VALUES (511, '804056550', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804056550', '{adresse}', 'AKTIV', '2010-07-01', NULL, '2023-06-06 10:45:55.245109', '2023-06-06 10:45:55.245109');
INSERT INTO public.virksomhet VALUES (512, '864991293', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '392199468 nvaN', '{adresse}', 'AKTIV', NULL, 864991294, '2023-06-06 10:45:55.253057', '2023-06-06 10:46:01.598588');
INSERT INTO public.virksomhet VALUES (513, '853581476', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '674185358 nvaN', '{adresse}', 'AKTIV', NULL, 853581477, '2023-06-06 10:45:55.25831', '2023-06-06 10:46:01.604934');
INSERT INTO public.virksomhet VALUES (514, '892420960', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '069024298 nvaN', '{adresse}', 'AKTIV', NULL, 892420961, '2023-06-06 10:45:55.263485', '2023-06-06 10:46:01.612377');
INSERT INTO public.virksomhet VALUES (515, '881989395', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '593989188 nvaN', '{adresse}', 'AKTIV', NULL, 881989396, '2023-06-06 10:45:55.268103', '2023-06-06 10:46:01.62091');
INSERT INTO public.virksomhet VALUES (516, '802923459', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '954329208 nvaN', '{adresse}', 'AKTIV', NULL, 802923460, '2023-06-06 10:45:55.27326', '2023-06-06 10:46:01.625548');
INSERT INTO public.virksomhet VALUES (527, '878349119', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '911943878 nvaN', '{adresse}', 'AKTIV', NULL, 878349120, '2023-06-06 10:45:55.330237', '2023-06-06 10:46:01.660422');
INSERT INTO public.virksomhet VALUES (517, '898545073', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898545073', '{adresse}', 'FJERNET', '2010-07-01', 898545074, '2023-06-06 10:45:55.277856', '2023-06-06 10:46:01.6633');
INSERT INTO public.virksomhet VALUES (518, '871114158', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871114158', '{adresse}', 'FJERNET', '2010-07-01', 871114159, '2023-06-06 10:45:55.28219', '2023-06-06 10:46:01.665819');
INSERT INTO public.virksomhet VALUES (519, '841627076', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841627076', '{adresse}', 'FJERNET', '2010-07-01', 841627077, '2023-06-06 10:45:55.28715', '2023-06-06 10:46:01.668458');
INSERT INTO public.virksomhet VALUES (520, '849843714', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849843714', '{adresse}', 'FJERNET', '2010-07-01', 849843715, '2023-06-06 10:45:55.29245', '2023-06-06 10:46:01.67036');
INSERT INTO public.virksomhet VALUES (521, '822555289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822555289', '{adresse}', 'FJERNET', '2010-07-01', 822555290, '2023-06-06 10:45:55.296861', '2023-06-06 10:46:01.672029');
INSERT INTO public.virksomhet VALUES (522, '899567741', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899567741', '{adresse}', 'SLETTET', '2010-07-01', 899567742, '2023-06-06 10:45:55.302724', '2023-06-06 10:46:01.692292');
INSERT INTO public.virksomhet VALUES (523, '886777842', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886777842', '{adresse}', 'SLETTET', '2010-07-01', 886777843, '2023-06-06 10:45:55.308287', '2023-06-06 10:46:01.694421');
INSERT INTO public.virksomhet VALUES (524, '865025012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865025012', '{adresse}', 'SLETTET', '2010-07-01', 865025013, '2023-06-06 10:45:55.314075', '2023-06-06 10:46:01.695527');
INSERT INTO public.virksomhet VALUES (525, '848622181', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848622181', '{adresse}', 'SLETTET', '2010-07-01', 848622182, '2023-06-06 10:45:55.319259', '2023-06-06 10:46:01.696781');
INSERT INTO public.virksomhet VALUES (526, '886555703', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886555703', '{adresse}', 'SLETTET', '2010-07-01', 886555704, '2023-06-06 10:45:55.324501', '2023-06-06 10:46:01.697987');
INSERT INTO public.virksomhet VALUES (534, '868791561', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868791561', '{adresse}', 'AKTIV', NULL, 868791562, '2023-06-06 10:46:01.699852', '2023-06-06 10:46:01.699852');
INSERT INTO public.virksomhet VALUES (535, '845718917', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845718917', '{adresse}', 'AKTIV', NULL, 845718918, '2023-06-06 10:46:01.723218', '2023-06-06 10:46:01.723218');
INSERT INTO public.virksomhet VALUES (536, '816841718', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816841718', '{adresse}', 'AKTIV', NULL, 816841719, '2023-06-06 10:46:01.727439', '2023-06-06 10:46:01.727439');
INSERT INTO public.virksomhet VALUES (537, '823395417', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823395417', '{adresse}', 'AKTIV', NULL, 823395418, '2023-06-06 10:46:01.734541', '2023-06-06 10:46:01.734541');
INSERT INTO public.virksomhet VALUES (538, '813159243', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813159243', '{adresse}', 'AKTIV', NULL, 813159244, '2023-06-06 10:46:01.74013', '2023-06-06 10:46:01.74013');


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
INSERT INTO public.virksomhet_naring VALUES (8, '70.220');
INSERT INTO public.virksomhet_naring VALUES (9, '01.120');
INSERT INTO public.virksomhet_naring VALUES (10, '01.120');
INSERT INTO public.virksomhet_naring VALUES (11, '01.120');
INSERT INTO public.virksomhet_naring VALUES (12, '01.120');
INSERT INTO public.virksomhet_naring VALUES (13, '01.120');
INSERT INTO public.virksomhet_naring VALUES (14, '01.120');
INSERT INTO public.virksomhet_naring VALUES (14, '90.012');
INSERT INTO public.virksomhet_naring VALUES (14, '70.220');
INSERT INTO public.virksomhet_naring VALUES (15, '01.120');
INSERT INTO public.virksomhet_naring VALUES (15, '90.012');
INSERT INTO public.virksomhet_naring VALUES (16, '01.120');
INSERT INTO public.virksomhet_naring VALUES (17, '01.120');
INSERT INTO public.virksomhet_naring VALUES (17, '90.012');
INSERT INTO public.virksomhet_naring VALUES (18, '01.120');
INSERT INTO public.virksomhet_naring VALUES (19, '01.120');
INSERT INTO public.virksomhet_naring VALUES (20, '01.120');
INSERT INTO public.virksomhet_naring VALUES (21, '01.120');
INSERT INTO public.virksomhet_naring VALUES (22, '01.120');
INSERT INTO public.virksomhet_naring VALUES (22, '90.012');
INSERT INTO public.virksomhet_naring VALUES (23, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '90.012');
INSERT INTO public.virksomhet_naring VALUES (23, '70.220');
INSERT INTO public.virksomhet_naring VALUES (24, '01.120');
INSERT INTO public.virksomhet_naring VALUES (25, '01.120');
INSERT INTO public.virksomhet_naring VALUES (25, '90.012');
INSERT INTO public.virksomhet_naring VALUES (26, '01.120');
INSERT INTO public.virksomhet_naring VALUES (26, '90.012');
INSERT INTO public.virksomhet_naring VALUES (27, '01.120');
INSERT INTO public.virksomhet_naring VALUES (27, '90.012');
INSERT INTO public.virksomhet_naring VALUES (27, '70.220');
INSERT INTO public.virksomhet_naring VALUES (28, '01.120');
INSERT INTO public.virksomhet_naring VALUES (29, '01.120');
INSERT INTO public.virksomhet_naring VALUES (30, '01.120');
INSERT INTO public.virksomhet_naring VALUES (31, '01.120');
INSERT INTO public.virksomhet_naring VALUES (32, '01.120');
INSERT INTO public.virksomhet_naring VALUES (33, '01.120');
INSERT INTO public.virksomhet_naring VALUES (33, '90.012');
INSERT INTO public.virksomhet_naring VALUES (33, '70.220');
INSERT INTO public.virksomhet_naring VALUES (34, '01.120');
INSERT INTO public.virksomhet_naring VALUES (34, '90.012');
INSERT INTO public.virksomhet_naring VALUES (35, '01.120');
INSERT INTO public.virksomhet_naring VALUES (36, '01.120');
INSERT INTO public.virksomhet_naring VALUES (36, '90.012');
INSERT INTO public.virksomhet_naring VALUES (37, '01.120');
INSERT INTO public.virksomhet_naring VALUES (37, '90.012');
INSERT INTO public.virksomhet_naring VALUES (37, '70.220');
INSERT INTO public.virksomhet_naring VALUES (38, '01.120');
INSERT INTO public.virksomhet_naring VALUES (38, '90.012');
INSERT INTO public.virksomhet_naring VALUES (39, '01.120');
INSERT INTO public.virksomhet_naring VALUES (40, '01.120');
INSERT INTO public.virksomhet_naring VALUES (40, '90.012');
INSERT INTO public.virksomhet_naring VALUES (40, '70.220');
INSERT INTO public.virksomhet_naring VALUES (41, '01.120');
INSERT INTO public.virksomhet_naring VALUES (41, '90.012');
INSERT INTO public.virksomhet_naring VALUES (42, '01.120');
INSERT INTO public.virksomhet_naring VALUES (42, '90.012');
INSERT INTO public.virksomhet_naring VALUES (43, '01.120');
INSERT INTO public.virksomhet_naring VALUES (44, '01.120');
INSERT INTO public.virksomhet_naring VALUES (45, '01.120');
INSERT INTO public.virksomhet_naring VALUES (45, '90.012');
INSERT INTO public.virksomhet_naring VALUES (46, '01.120');
INSERT INTO public.virksomhet_naring VALUES (47, '01.120');
INSERT INTO public.virksomhet_naring VALUES (48, '01.120');
INSERT INTO public.virksomhet_naring VALUES (49, '01.120');
INSERT INTO public.virksomhet_naring VALUES (50, '01.120');
INSERT INTO public.virksomhet_naring VALUES (50, '90.012');
INSERT INTO public.virksomhet_naring VALUES (50, '70.220');
INSERT INTO public.virksomhet_naring VALUES (51, '01.120');
INSERT INTO public.virksomhet_naring VALUES (52, '01.120');
INSERT INTO public.virksomhet_naring VALUES (53, '01.120');
INSERT INTO public.virksomhet_naring VALUES (53, '90.012');
INSERT INTO public.virksomhet_naring VALUES (54, '01.120');
INSERT INTO public.virksomhet_naring VALUES (55, '01.120');
INSERT INTO public.virksomhet_naring VALUES (55, '90.012');
INSERT INTO public.virksomhet_naring VALUES (56, '01.120');
INSERT INTO public.virksomhet_naring VALUES (57, '01.120');
INSERT INTO public.virksomhet_naring VALUES (58, '01.120');
INSERT INTO public.virksomhet_naring VALUES (58, '90.012');
INSERT INTO public.virksomhet_naring VALUES (59, '01.120');
INSERT INTO public.virksomhet_naring VALUES (59, '90.012');
INSERT INTO public.virksomhet_naring VALUES (60, '01.120');
INSERT INTO public.virksomhet_naring VALUES (60, '90.012');
INSERT INTO public.virksomhet_naring VALUES (61, '01.120');
INSERT INTO public.virksomhet_naring VALUES (62, '01.120');
INSERT INTO public.virksomhet_naring VALUES (62, '90.012');
INSERT INTO public.virksomhet_naring VALUES (63, '01.120');
INSERT INTO public.virksomhet_naring VALUES (64, '01.120');
INSERT INTO public.virksomhet_naring VALUES (65, '01.120');
INSERT INTO public.virksomhet_naring VALUES (65, '90.012');
INSERT INTO public.virksomhet_naring VALUES (66, '01.120');
INSERT INTO public.virksomhet_naring VALUES (67, '01.120');
INSERT INTO public.virksomhet_naring VALUES (67, '90.012');
INSERT INTO public.virksomhet_naring VALUES (68, '01.120');
INSERT INTO public.virksomhet_naring VALUES (68, '90.012');
INSERT INTO public.virksomhet_naring VALUES (68, '70.220');
INSERT INTO public.virksomhet_naring VALUES (69, '01.120');
INSERT INTO public.virksomhet_naring VALUES (69, '90.012');
INSERT INTO public.virksomhet_naring VALUES (70, '01.120');
INSERT INTO public.virksomhet_naring VALUES (71, '01.120');
INSERT INTO public.virksomhet_naring VALUES (71, '90.012');
INSERT INTO public.virksomhet_naring VALUES (72, '01.120');
INSERT INTO public.virksomhet_naring VALUES (72, '90.012');
INSERT INTO public.virksomhet_naring VALUES (73, '01.120');
INSERT INTO public.virksomhet_naring VALUES (73, '90.012');
INSERT INTO public.virksomhet_naring VALUES (74, '01.120');
INSERT INTO public.virksomhet_naring VALUES (74, '90.012');
INSERT INTO public.virksomhet_naring VALUES (75, '01.120');
INSERT INTO public.virksomhet_naring VALUES (75, '90.012');
INSERT INTO public.virksomhet_naring VALUES (76, '01.120');
INSERT INTO public.virksomhet_naring VALUES (76, '90.012');
INSERT INTO public.virksomhet_naring VALUES (77, '01.120');
INSERT INTO public.virksomhet_naring VALUES (77, '90.012');
INSERT INTO public.virksomhet_naring VALUES (77, '70.220');
INSERT INTO public.virksomhet_naring VALUES (78, '01.120');
INSERT INTO public.virksomhet_naring VALUES (79, '01.120');
INSERT INTO public.virksomhet_naring VALUES (79, '90.012');
INSERT INTO public.virksomhet_naring VALUES (80, '01.120');
INSERT INTO public.virksomhet_naring VALUES (80, '90.012');
INSERT INTO public.virksomhet_naring VALUES (81, '01.120');
INSERT INTO public.virksomhet_naring VALUES (81, '90.012');
INSERT INTO public.virksomhet_naring VALUES (81, '70.220');
INSERT INTO public.virksomhet_naring VALUES (82, '01.120');
INSERT INTO public.virksomhet_naring VALUES (83, '01.120');
INSERT INTO public.virksomhet_naring VALUES (84, '01.120');
INSERT INTO public.virksomhet_naring VALUES (84, '90.012');
INSERT INTO public.virksomhet_naring VALUES (84, '70.220');
INSERT INTO public.virksomhet_naring VALUES (85, '01.120');
INSERT INTO public.virksomhet_naring VALUES (86, '01.120');
INSERT INTO public.virksomhet_naring VALUES (87, '01.120');
INSERT INTO public.virksomhet_naring VALUES (88, '01.120');
INSERT INTO public.virksomhet_naring VALUES (89, '01.120');
INSERT INTO public.virksomhet_naring VALUES (90, '01.120');
INSERT INTO public.virksomhet_naring VALUES (91, '01.120');
INSERT INTO public.virksomhet_naring VALUES (92, '01.120');
INSERT INTO public.virksomhet_naring VALUES (93, '01.120');
INSERT INTO public.virksomhet_naring VALUES (93, '90.012');
INSERT INTO public.virksomhet_naring VALUES (93, '70.220');
INSERT INTO public.virksomhet_naring VALUES (94, '01.120');
INSERT INTO public.virksomhet_naring VALUES (95, '01.120');
INSERT INTO public.virksomhet_naring VALUES (95, '90.012');
INSERT INTO public.virksomhet_naring VALUES (96, '01.120');
INSERT INTO public.virksomhet_naring VALUES (96, '90.012');
INSERT INTO public.virksomhet_naring VALUES (97, '01.120');
INSERT INTO public.virksomhet_naring VALUES (98, '01.120');
INSERT INTO public.virksomhet_naring VALUES (99, '01.120');
INSERT INTO public.virksomhet_naring VALUES (100, '01.120');
INSERT INTO public.virksomhet_naring VALUES (101, '01.120');
INSERT INTO public.virksomhet_naring VALUES (101, '90.012');
INSERT INTO public.virksomhet_naring VALUES (102, '01.120');
INSERT INTO public.virksomhet_naring VALUES (102, '90.012');
INSERT INTO public.virksomhet_naring VALUES (103, '01.120');
INSERT INTO public.virksomhet_naring VALUES (103, '90.012');
INSERT INTO public.virksomhet_naring VALUES (103, '70.220');
INSERT INTO public.virksomhet_naring VALUES (104, '01.120');
INSERT INTO public.virksomhet_naring VALUES (104, '90.012');
INSERT INTO public.virksomhet_naring VALUES (105, '01.120');
INSERT INTO public.virksomhet_naring VALUES (106, '01.120');
INSERT INTO public.virksomhet_naring VALUES (107, '01.120');
INSERT INTO public.virksomhet_naring VALUES (108, '01.120');
INSERT INTO public.virksomhet_naring VALUES (108, '90.012');
INSERT INTO public.virksomhet_naring VALUES (109, '01.120');
INSERT INTO public.virksomhet_naring VALUES (109, '90.012');
INSERT INTO public.virksomhet_naring VALUES (110, '01.120');
INSERT INTO public.virksomhet_naring VALUES (111, '01.120');
INSERT INTO public.virksomhet_naring VALUES (111, '90.012');
INSERT INTO public.virksomhet_naring VALUES (112, '01.120');
INSERT INTO public.virksomhet_naring VALUES (112, '90.012');
INSERT INTO public.virksomhet_naring VALUES (113, '01.120');
INSERT INTO public.virksomhet_naring VALUES (114, '01.120');
INSERT INTO public.virksomhet_naring VALUES (115, '01.120');
INSERT INTO public.virksomhet_naring VALUES (115, '90.012');
INSERT INTO public.virksomhet_naring VALUES (116, '01.120');
INSERT INTO public.virksomhet_naring VALUES (117, '01.120');
INSERT INTO public.virksomhet_naring VALUES (117, '90.012');
INSERT INTO public.virksomhet_naring VALUES (117, '70.220');
INSERT INTO public.virksomhet_naring VALUES (118, '01.120');
INSERT INTO public.virksomhet_naring VALUES (118, '90.012');
INSERT INTO public.virksomhet_naring VALUES (118, '70.220');
INSERT INTO public.virksomhet_naring VALUES (119, '01.120');
INSERT INTO public.virksomhet_naring VALUES (119, '90.012');
INSERT INTO public.virksomhet_naring VALUES (119, '70.220');
INSERT INTO public.virksomhet_naring VALUES (120, '01.120');
INSERT INTO public.virksomhet_naring VALUES (120, '90.012');
INSERT INTO public.virksomhet_naring VALUES (121, '01.120');
INSERT INTO public.virksomhet_naring VALUES (121, '90.012');
INSERT INTO public.virksomhet_naring VALUES (121, '70.220');
INSERT INTO public.virksomhet_naring VALUES (122, '01.120');
INSERT INTO public.virksomhet_naring VALUES (122, '90.012');
INSERT INTO public.virksomhet_naring VALUES (123, '01.120');
INSERT INTO public.virksomhet_naring VALUES (124, '01.120');
INSERT INTO public.virksomhet_naring VALUES (124, '90.012');
INSERT INTO public.virksomhet_naring VALUES (125, '01.120');
INSERT INTO public.virksomhet_naring VALUES (126, '01.120');
INSERT INTO public.virksomhet_naring VALUES (127, '01.120');
INSERT INTO public.virksomhet_naring VALUES (128, '01.120');
INSERT INTO public.virksomhet_naring VALUES (129, '01.120');
INSERT INTO public.virksomhet_naring VALUES (129, '90.012');
INSERT INTO public.virksomhet_naring VALUES (130, '01.120');
INSERT INTO public.virksomhet_naring VALUES (130, '90.012');
INSERT INTO public.virksomhet_naring VALUES (131, '01.120');
INSERT INTO public.virksomhet_naring VALUES (131, '90.012');
INSERT INTO public.virksomhet_naring VALUES (132, '01.120');
INSERT INTO public.virksomhet_naring VALUES (133, '01.120');
INSERT INTO public.virksomhet_naring VALUES (134, '01.120');
INSERT INTO public.virksomhet_naring VALUES (134, '90.012');
INSERT INTO public.virksomhet_naring VALUES (134, '70.220');
INSERT INTO public.virksomhet_naring VALUES (135, '01.120');
INSERT INTO public.virksomhet_naring VALUES (136, '01.120');
INSERT INTO public.virksomhet_naring VALUES (137, '01.120');
INSERT INTO public.virksomhet_naring VALUES (137, '90.012');
INSERT INTO public.virksomhet_naring VALUES (138, '01.120');
INSERT INTO public.virksomhet_naring VALUES (138, '90.012');
INSERT INTO public.virksomhet_naring VALUES (139, '01.120');
INSERT INTO public.virksomhet_naring VALUES (139, '90.012');
INSERT INTO public.virksomhet_naring VALUES (140, '01.120');
INSERT INTO public.virksomhet_naring VALUES (140, '90.012');
INSERT INTO public.virksomhet_naring VALUES (140, '70.220');
INSERT INTO public.virksomhet_naring VALUES (141, '01.120');
INSERT INTO public.virksomhet_naring VALUES (142, '01.120');
INSERT INTO public.virksomhet_naring VALUES (142, '90.012');
INSERT INTO public.virksomhet_naring VALUES (143, '01.120');
INSERT INTO public.virksomhet_naring VALUES (144, '01.120');
INSERT INTO public.virksomhet_naring VALUES (145, '01.120');
INSERT INTO public.virksomhet_naring VALUES (146, '01.120');
INSERT INTO public.virksomhet_naring VALUES (147, '01.120');
INSERT INTO public.virksomhet_naring VALUES (148, '01.120');
INSERT INTO public.virksomhet_naring VALUES (149, '01.120');
INSERT INTO public.virksomhet_naring VALUES (149, '90.012');
INSERT INTO public.virksomhet_naring VALUES (150, '01.120');
INSERT INTO public.virksomhet_naring VALUES (150, '90.012');
INSERT INTO public.virksomhet_naring VALUES (151, '01.120');
INSERT INTO public.virksomhet_naring VALUES (152, '01.120');
INSERT INTO public.virksomhet_naring VALUES (153, '01.120');
INSERT INTO public.virksomhet_naring VALUES (153, '90.012');
INSERT INTO public.virksomhet_naring VALUES (153, '70.220');
INSERT INTO public.virksomhet_naring VALUES (154, '01.120');
INSERT INTO public.virksomhet_naring VALUES (154, '90.012');
INSERT INTO public.virksomhet_naring VALUES (154, '70.220');
INSERT INTO public.virksomhet_naring VALUES (155, '01.120');
INSERT INTO public.virksomhet_naring VALUES (155, '90.012');
INSERT INTO public.virksomhet_naring VALUES (156, '01.120');
INSERT INTO public.virksomhet_naring VALUES (157, '01.120');
INSERT INTO public.virksomhet_naring VALUES (158, '01.120');
INSERT INTO public.virksomhet_naring VALUES (158, '90.012');
INSERT INTO public.virksomhet_naring VALUES (159, '01.120');
INSERT INTO public.virksomhet_naring VALUES (159, '90.012');
INSERT INTO public.virksomhet_naring VALUES (159, '70.220');
INSERT INTO public.virksomhet_naring VALUES (160, '01.120');
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
INSERT INTO public.virksomhet_naring VALUES (168, '90.012');
INSERT INTO public.virksomhet_naring VALUES (168, '70.220');
INSERT INTO public.virksomhet_naring VALUES (169, '01.120');
INSERT INTO public.virksomhet_naring VALUES (169, '90.012');
INSERT INTO public.virksomhet_naring VALUES (169, '70.220');
INSERT INTO public.virksomhet_naring VALUES (170, '01.120');
INSERT INTO public.virksomhet_naring VALUES (171, '01.120');
INSERT INTO public.virksomhet_naring VALUES (171, '90.012');
INSERT INTO public.virksomhet_naring VALUES (172, '01.120');
INSERT INTO public.virksomhet_naring VALUES (172, '90.012');
INSERT INTO public.virksomhet_naring VALUES (173, '01.120');
INSERT INTO public.virksomhet_naring VALUES (173, '90.012');
INSERT INTO public.virksomhet_naring VALUES (173, '70.220');
INSERT INTO public.virksomhet_naring VALUES (174, '01.120');
INSERT INTO public.virksomhet_naring VALUES (175, '01.120');
INSERT INTO public.virksomhet_naring VALUES (176, '01.120');
INSERT INTO public.virksomhet_naring VALUES (177, '01.120');
INSERT INTO public.virksomhet_naring VALUES (178, '01.120');
INSERT INTO public.virksomhet_naring VALUES (179, '01.120');
INSERT INTO public.virksomhet_naring VALUES (179, '90.012');
INSERT INTO public.virksomhet_naring VALUES (180, '01.120');
INSERT INTO public.virksomhet_naring VALUES (181, '01.120');
INSERT INTO public.virksomhet_naring VALUES (182, '01.120');
INSERT INTO public.virksomhet_naring VALUES (182, '90.012');
INSERT INTO public.virksomhet_naring VALUES (182, '70.220');
INSERT INTO public.virksomhet_naring VALUES (183, '01.120');
INSERT INTO public.virksomhet_naring VALUES (183, '90.012');
INSERT INTO public.virksomhet_naring VALUES (184, '01.120');
INSERT INTO public.virksomhet_naring VALUES (184, '90.012');
INSERT INTO public.virksomhet_naring VALUES (185, '01.120');
INSERT INTO public.virksomhet_naring VALUES (186, '01.120');
INSERT INTO public.virksomhet_naring VALUES (187, '01.120');
INSERT INTO public.virksomhet_naring VALUES (187, '90.012');
INSERT INTO public.virksomhet_naring VALUES (188, '01.120');
INSERT INTO public.virksomhet_naring VALUES (188, '90.012');
INSERT INTO public.virksomhet_naring VALUES (189, '01.120');
INSERT INTO public.virksomhet_naring VALUES (189, '90.012');
INSERT INTO public.virksomhet_naring VALUES (189, '70.220');
INSERT INTO public.virksomhet_naring VALUES (190, '01.120');
INSERT INTO public.virksomhet_naring VALUES (191, '01.120');
INSERT INTO public.virksomhet_naring VALUES (191, '90.012');
INSERT INTO public.virksomhet_naring VALUES (191, '70.220');
INSERT INTO public.virksomhet_naring VALUES (192, '01.120');
INSERT INTO public.virksomhet_naring VALUES (192, '90.012');
INSERT INTO public.virksomhet_naring VALUES (193, '01.120');
INSERT INTO public.virksomhet_naring VALUES (194, '01.120');
INSERT INTO public.virksomhet_naring VALUES (194, '90.012');
INSERT INTO public.virksomhet_naring VALUES (195, '01.120');
INSERT INTO public.virksomhet_naring VALUES (196, '01.120');
INSERT INTO public.virksomhet_naring VALUES (197, '01.120');
INSERT INTO public.virksomhet_naring VALUES (198, '01.120');
INSERT INTO public.virksomhet_naring VALUES (198, '90.012');
INSERT INTO public.virksomhet_naring VALUES (199, '01.120');
INSERT INTO public.virksomhet_naring VALUES (200, '01.120');
INSERT INTO public.virksomhet_naring VALUES (200, '90.012');
INSERT INTO public.virksomhet_naring VALUES (201, '01.120');
INSERT INTO public.virksomhet_naring VALUES (202, '01.120');
INSERT INTO public.virksomhet_naring VALUES (203, '01.120');
INSERT INTO public.virksomhet_naring VALUES (204, '01.120');
INSERT INTO public.virksomhet_naring VALUES (205, '01.120');
INSERT INTO public.virksomhet_naring VALUES (206, '01.120');
INSERT INTO public.virksomhet_naring VALUES (207, '01.120');
INSERT INTO public.virksomhet_naring VALUES (208, '01.120');
INSERT INTO public.virksomhet_naring VALUES (208, '90.012');
INSERT INTO public.virksomhet_naring VALUES (209, '01.120');
INSERT INTO public.virksomhet_naring VALUES (210, '01.120');
INSERT INTO public.virksomhet_naring VALUES (210, '90.012');
INSERT INTO public.virksomhet_naring VALUES (211, '01.120');
INSERT INTO public.virksomhet_naring VALUES (211, '90.012');
INSERT INTO public.virksomhet_naring VALUES (211, '70.220');
INSERT INTO public.virksomhet_naring VALUES (212, '01.120');
INSERT INTO public.virksomhet_naring VALUES (212, '90.012');
INSERT INTO public.virksomhet_naring VALUES (213, '01.120');
INSERT INTO public.virksomhet_naring VALUES (214, '01.120');
INSERT INTO public.virksomhet_naring VALUES (215, '01.120');
INSERT INTO public.virksomhet_naring VALUES (215, '90.012');
INSERT INTO public.virksomhet_naring VALUES (216, '01.120');
INSERT INTO public.virksomhet_naring VALUES (216, '90.012');
INSERT INTO public.virksomhet_naring VALUES (217, '01.120');
INSERT INTO public.virksomhet_naring VALUES (218, '01.120');
INSERT INTO public.virksomhet_naring VALUES (219, '01.120');
INSERT INTO public.virksomhet_naring VALUES (219, '90.012');
INSERT INTO public.virksomhet_naring VALUES (220, '01.120');
INSERT INTO public.virksomhet_naring VALUES (221, '01.120');
INSERT INTO public.virksomhet_naring VALUES (222, '01.120');
INSERT INTO public.virksomhet_naring VALUES (223, '01.120');
INSERT INTO public.virksomhet_naring VALUES (224, '01.120');
INSERT INTO public.virksomhet_naring VALUES (224, '90.012');
INSERT INTO public.virksomhet_naring VALUES (225, '01.120');
INSERT INTO public.virksomhet_naring VALUES (225, '90.012');
INSERT INTO public.virksomhet_naring VALUES (225, '70.220');
INSERT INTO public.virksomhet_naring VALUES (226, '01.120');
INSERT INTO public.virksomhet_naring VALUES (226, '90.012');
INSERT INTO public.virksomhet_naring VALUES (227, '01.120');
INSERT INTO public.virksomhet_naring VALUES (227, '90.012');
INSERT INTO public.virksomhet_naring VALUES (228, '01.120');
INSERT INTO public.virksomhet_naring VALUES (229, '01.120');
INSERT INTO public.virksomhet_naring VALUES (230, '01.120');
INSERT INTO public.virksomhet_naring VALUES (230, '90.012');
INSERT INTO public.virksomhet_naring VALUES (231, '01.120');
INSERT INTO public.virksomhet_naring VALUES (231, '90.012');
INSERT INTO public.virksomhet_naring VALUES (231, '70.220');
INSERT INTO public.virksomhet_naring VALUES (232, '01.120');
INSERT INTO public.virksomhet_naring VALUES (233, '01.120');
INSERT INTO public.virksomhet_naring VALUES (234, '01.120');
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
INSERT INTO public.virksomhet_naring VALUES (239, '90.012');
INSERT INTO public.virksomhet_naring VALUES (240, '01.120');
INSERT INTO public.virksomhet_naring VALUES (241, '01.120');
INSERT INTO public.virksomhet_naring VALUES (242, '01.120');
INSERT INTO public.virksomhet_naring VALUES (242, '90.012');
INSERT INTO public.virksomhet_naring VALUES (243, '01.120');
INSERT INTO public.virksomhet_naring VALUES (244, '01.120');
INSERT INTO public.virksomhet_naring VALUES (244, '90.012');
INSERT INTO public.virksomhet_naring VALUES (245, '01.120');
INSERT INTO public.virksomhet_naring VALUES (245, '90.012');
INSERT INTO public.virksomhet_naring VALUES (245, '70.220');
INSERT INTO public.virksomhet_naring VALUES (246, '01.120');
INSERT INTO public.virksomhet_naring VALUES (247, '01.120');
INSERT INTO public.virksomhet_naring VALUES (247, '90.012');
INSERT INTO public.virksomhet_naring VALUES (248, '01.120');
INSERT INTO public.virksomhet_naring VALUES (249, '01.120');
INSERT INTO public.virksomhet_naring VALUES (249, '90.012');
INSERT INTO public.virksomhet_naring VALUES (249, '70.220');
INSERT INTO public.virksomhet_naring VALUES (250, '01.120');
INSERT INTO public.virksomhet_naring VALUES (250, '90.012');
INSERT INTO public.virksomhet_naring VALUES (250, '70.220');
INSERT INTO public.virksomhet_naring VALUES (251, '01.120');
INSERT INTO public.virksomhet_naring VALUES (251, '90.012');
INSERT INTO public.virksomhet_naring VALUES (252, '01.120');
INSERT INTO public.virksomhet_naring VALUES (252, '90.012');
INSERT INTO public.virksomhet_naring VALUES (253, '01.120');
INSERT INTO public.virksomhet_naring VALUES (253, '90.012');
INSERT INTO public.virksomhet_naring VALUES (253, '70.220');
INSERT INTO public.virksomhet_naring VALUES (254, '01.120');
INSERT INTO public.virksomhet_naring VALUES (254, '90.012');
INSERT INTO public.virksomhet_naring VALUES (254, '70.220');
INSERT INTO public.virksomhet_naring VALUES (255, '01.120');
INSERT INTO public.virksomhet_naring VALUES (255, '90.012');
INSERT INTO public.virksomhet_naring VALUES (255, '70.220');
INSERT INTO public.virksomhet_naring VALUES (256, '01.120');
INSERT INTO public.virksomhet_naring VALUES (256, '90.012');
INSERT INTO public.virksomhet_naring VALUES (257, '01.120');
INSERT INTO public.virksomhet_naring VALUES (257, '90.012');
INSERT INTO public.virksomhet_naring VALUES (257, '70.220');
INSERT INTO public.virksomhet_naring VALUES (258, '01.120');
INSERT INTO public.virksomhet_naring VALUES (258, '90.012');
INSERT INTO public.virksomhet_naring VALUES (259, '01.120');
INSERT INTO public.virksomhet_naring VALUES (259, '90.012');
INSERT INTO public.virksomhet_naring VALUES (259, '70.220');
INSERT INTO public.virksomhet_naring VALUES (260, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '90.012');
INSERT INTO public.virksomhet_naring VALUES (262, '01.120');
INSERT INTO public.virksomhet_naring VALUES (262, '90.012');
INSERT INTO public.virksomhet_naring VALUES (263, '01.120');
INSERT INTO public.virksomhet_naring VALUES (263, '90.012');
INSERT INTO public.virksomhet_naring VALUES (263, '70.220');
INSERT INTO public.virksomhet_naring VALUES (264, '01.120');
INSERT INTO public.virksomhet_naring VALUES (265, '01.120');
INSERT INTO public.virksomhet_naring VALUES (265, '90.012');
INSERT INTO public.virksomhet_naring VALUES (265, '70.220');
INSERT INTO public.virksomhet_naring VALUES (266, '01.120');
INSERT INTO public.virksomhet_naring VALUES (266, '90.012');
INSERT INTO public.virksomhet_naring VALUES (267, '01.120');
INSERT INTO public.virksomhet_naring VALUES (268, '01.120');
INSERT INTO public.virksomhet_naring VALUES (268, '90.012');
INSERT INTO public.virksomhet_naring VALUES (269, '01.120');
INSERT INTO public.virksomhet_naring VALUES (270, '01.120');
INSERT INTO public.virksomhet_naring VALUES (271, '01.120');
INSERT INTO public.virksomhet_naring VALUES (272, '01.120');
INSERT INTO public.virksomhet_naring VALUES (273, '01.120');
INSERT INTO public.virksomhet_naring VALUES (273, '90.012');
INSERT INTO public.virksomhet_naring VALUES (274, '01.120');
INSERT INTO public.virksomhet_naring VALUES (275, '01.120');
INSERT INTO public.virksomhet_naring VALUES (275, '90.012');
INSERT INTO public.virksomhet_naring VALUES (276, '01.120');
INSERT INTO public.virksomhet_naring VALUES (276, '90.012');
INSERT INTO public.virksomhet_naring VALUES (277, '01.120');
INSERT INTO public.virksomhet_naring VALUES (277, '90.012');
INSERT INTO public.virksomhet_naring VALUES (278, '01.120');
INSERT INTO public.virksomhet_naring VALUES (279, '01.120');
INSERT INTO public.virksomhet_naring VALUES (279, '90.012');
INSERT INTO public.virksomhet_naring VALUES (280, '01.120');
INSERT INTO public.virksomhet_naring VALUES (280, '90.012');
INSERT INTO public.virksomhet_naring VALUES (281, '01.120');
INSERT INTO public.virksomhet_naring VALUES (281, '90.012');
INSERT INTO public.virksomhet_naring VALUES (281, '70.220');
INSERT INTO public.virksomhet_naring VALUES (282, '01.120');
INSERT INTO public.virksomhet_naring VALUES (283, '01.120');
INSERT INTO public.virksomhet_naring VALUES (283, '90.012');
INSERT INTO public.virksomhet_naring VALUES (284, '01.120');
INSERT INTO public.virksomhet_naring VALUES (285, '01.120');
INSERT INTO public.virksomhet_naring VALUES (285, '90.012');
INSERT INTO public.virksomhet_naring VALUES (286, '01.120');
INSERT INTO public.virksomhet_naring VALUES (287, '01.120');
INSERT INTO public.virksomhet_naring VALUES (287, '90.012');
INSERT INTO public.virksomhet_naring VALUES (287, '70.220');
INSERT INTO public.virksomhet_naring VALUES (288, '01.120');
INSERT INTO public.virksomhet_naring VALUES (288, '90.012');
INSERT INTO public.virksomhet_naring VALUES (289, '01.120');
INSERT INTO public.virksomhet_naring VALUES (290, '01.120');
INSERT INTO public.virksomhet_naring VALUES (290, '90.012');
INSERT INTO public.virksomhet_naring VALUES (290, '70.220');
INSERT INTO public.virksomhet_naring VALUES (291, '01.120');
INSERT INTO public.virksomhet_naring VALUES (292, '01.120');
INSERT INTO public.virksomhet_naring VALUES (292, '90.012');
INSERT INTO public.virksomhet_naring VALUES (293, '01.120');
INSERT INTO public.virksomhet_naring VALUES (294, '01.120');
INSERT INTO public.virksomhet_naring VALUES (295, '01.120');
INSERT INTO public.virksomhet_naring VALUES (296, '01.120');
INSERT INTO public.virksomhet_naring VALUES (297, '01.120');
INSERT INTO public.virksomhet_naring VALUES (297, '90.012');
INSERT INTO public.virksomhet_naring VALUES (298, '01.120');
INSERT INTO public.virksomhet_naring VALUES (298, '90.012');
INSERT INTO public.virksomhet_naring VALUES (298, '70.220');
INSERT INTO public.virksomhet_naring VALUES (299, '01.120');
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
INSERT INTO public.virksomhet_naring VALUES (306, '01.120');
INSERT INTO public.virksomhet_naring VALUES (306, '90.012');
INSERT INTO public.virksomhet_naring VALUES (307, '01.120');
INSERT INTO public.virksomhet_naring VALUES (307, '90.012');
INSERT INTO public.virksomhet_naring VALUES (308, '01.120');
INSERT INTO public.virksomhet_naring VALUES (309, '01.120');
INSERT INTO public.virksomhet_naring VALUES (309, '90.012');
INSERT INTO public.virksomhet_naring VALUES (310, '01.120');
INSERT INTO public.virksomhet_naring VALUES (310, '90.012');
INSERT INTO public.virksomhet_naring VALUES (310, '70.220');
INSERT INTO public.virksomhet_naring VALUES (311, '01.120');
INSERT INTO public.virksomhet_naring VALUES (312, '01.120');
INSERT INTO public.virksomhet_naring VALUES (312, '90.012');
INSERT INTO public.virksomhet_naring VALUES (313, '01.120');
INSERT INTO public.virksomhet_naring VALUES (313, '90.012');
INSERT INTO public.virksomhet_naring VALUES (314, '01.120');
INSERT INTO public.virksomhet_naring VALUES (314, '90.012');
INSERT INTO public.virksomhet_naring VALUES (315, '01.120');
INSERT INTO public.virksomhet_naring VALUES (316, '01.120');
INSERT INTO public.virksomhet_naring VALUES (316, '90.012');
INSERT INTO public.virksomhet_naring VALUES (316, '70.220');
INSERT INTO public.virksomhet_naring VALUES (317, '01.120');
INSERT INTO public.virksomhet_naring VALUES (317, '90.012');
INSERT INTO public.virksomhet_naring VALUES (318, '01.120');
INSERT INTO public.virksomhet_naring VALUES (318, '90.012');
INSERT INTO public.virksomhet_naring VALUES (318, '70.220');
INSERT INTO public.virksomhet_naring VALUES (319, '01.120');
INSERT INTO public.virksomhet_naring VALUES (320, '01.120');
INSERT INTO public.virksomhet_naring VALUES (321, '01.120');
INSERT INTO public.virksomhet_naring VALUES (321, '90.012');
INSERT INTO public.virksomhet_naring VALUES (322, '01.120');
INSERT INTO public.virksomhet_naring VALUES (323, '01.120');
INSERT INTO public.virksomhet_naring VALUES (323, '90.012');
INSERT INTO public.virksomhet_naring VALUES (324, '01.120');
INSERT INTO public.virksomhet_naring VALUES (325, '01.120');
INSERT INTO public.virksomhet_naring VALUES (326, '01.120');
INSERT INTO public.virksomhet_naring VALUES (326, '90.012');
INSERT INTO public.virksomhet_naring VALUES (327, '01.120');
INSERT INTO public.virksomhet_naring VALUES (327, '90.012');
INSERT INTO public.virksomhet_naring VALUES (328, '01.120');
INSERT INTO public.virksomhet_naring VALUES (328, '90.012');
INSERT INTO public.virksomhet_naring VALUES (329, '01.120');
INSERT INTO public.virksomhet_naring VALUES (329, '90.012');
INSERT INTO public.virksomhet_naring VALUES (330, '01.120');
INSERT INTO public.virksomhet_naring VALUES (331, '01.120');
INSERT INTO public.virksomhet_naring VALUES (332, '01.120');
INSERT INTO public.virksomhet_naring VALUES (333, '01.120');
INSERT INTO public.virksomhet_naring VALUES (334, '01.120');
INSERT INTO public.virksomhet_naring VALUES (334, '90.012');
INSERT INTO public.virksomhet_naring VALUES (335, '01.120');
INSERT INTO public.virksomhet_naring VALUES (336, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '90.012');
INSERT INTO public.virksomhet_naring VALUES (338, '01.120');
INSERT INTO public.virksomhet_naring VALUES (338, '90.012');
INSERT INTO public.virksomhet_naring VALUES (339, '01.120');
INSERT INTO public.virksomhet_naring VALUES (339, '90.012');
INSERT INTO public.virksomhet_naring VALUES (340, '01.120');
INSERT INTO public.virksomhet_naring VALUES (340, '90.012');
INSERT INTO public.virksomhet_naring VALUES (340, '70.220');
INSERT INTO public.virksomhet_naring VALUES (341, '01.120');
INSERT INTO public.virksomhet_naring VALUES (342, '01.120');
INSERT INTO public.virksomhet_naring VALUES (343, '01.120');
INSERT INTO public.virksomhet_naring VALUES (343, '90.012');
INSERT INTO public.virksomhet_naring VALUES (344, '01.120');
INSERT INTO public.virksomhet_naring VALUES (344, '90.012');
INSERT INTO public.virksomhet_naring VALUES (345, '01.120');
INSERT INTO public.virksomhet_naring VALUES (345, '90.012');
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
INSERT INTO public.virksomhet_naring VALUES (357, '01.120');
INSERT INTO public.virksomhet_naring VALUES (358, '01.120');
INSERT INTO public.virksomhet_naring VALUES (359, '01.120');
INSERT INTO public.virksomhet_naring VALUES (359, '90.012');
INSERT INTO public.virksomhet_naring VALUES (360, '01.120');
INSERT INTO public.virksomhet_naring VALUES (361, '01.120');
INSERT INTO public.virksomhet_naring VALUES (362, '01.120');
INSERT INTO public.virksomhet_naring VALUES (363, '01.120');
INSERT INTO public.virksomhet_naring VALUES (363, '90.012');
INSERT INTO public.virksomhet_naring VALUES (363, '70.220');
INSERT INTO public.virksomhet_naring VALUES (364, '01.120');
INSERT INTO public.virksomhet_naring VALUES (365, '01.120');
INSERT INTO public.virksomhet_naring VALUES (365, '90.012');
INSERT INTO public.virksomhet_naring VALUES (366, '01.120');
INSERT INTO public.virksomhet_naring VALUES (366, '90.012');
INSERT INTO public.virksomhet_naring VALUES (367, '01.120');
INSERT INTO public.virksomhet_naring VALUES (368, '01.120');
INSERT INTO public.virksomhet_naring VALUES (368, '90.012');
INSERT INTO public.virksomhet_naring VALUES (369, '01.120');
INSERT INTO public.virksomhet_naring VALUES (370, '01.120');
INSERT INTO public.virksomhet_naring VALUES (370, '90.012');
INSERT INTO public.virksomhet_naring VALUES (371, '01.120');
INSERT INTO public.virksomhet_naring VALUES (371, '90.012');
INSERT INTO public.virksomhet_naring VALUES (372, '01.120');
INSERT INTO public.virksomhet_naring VALUES (373, '01.120');
INSERT INTO public.virksomhet_naring VALUES (373, '90.012');
INSERT INTO public.virksomhet_naring VALUES (374, '01.120');
INSERT INTO public.virksomhet_naring VALUES (374, '90.012');
INSERT INTO public.virksomhet_naring VALUES (374, '70.220');
INSERT INTO public.virksomhet_naring VALUES (375, '01.120');
INSERT INTO public.virksomhet_naring VALUES (376, '01.120');
INSERT INTO public.virksomhet_naring VALUES (377, '01.120');
INSERT INTO public.virksomhet_naring VALUES (377, '90.012');
INSERT INTO public.virksomhet_naring VALUES (378, '01.120');
INSERT INTO public.virksomhet_naring VALUES (379, '01.120');
INSERT INTO public.virksomhet_naring VALUES (379, '90.012');
INSERT INTO public.virksomhet_naring VALUES (380, '01.120');
INSERT INTO public.virksomhet_naring VALUES (380, '90.012');
INSERT INTO public.virksomhet_naring VALUES (380, '70.220');
INSERT INTO public.virksomhet_naring VALUES (381, '01.120');
INSERT INTO public.virksomhet_naring VALUES (382, '01.120');
INSERT INTO public.virksomhet_naring VALUES (382, '90.012');
INSERT INTO public.virksomhet_naring VALUES (382, '70.220');
INSERT INTO public.virksomhet_naring VALUES (383, '01.120');
INSERT INTO public.virksomhet_naring VALUES (384, '01.120');
INSERT INTO public.virksomhet_naring VALUES (384, '90.012');
INSERT INTO public.virksomhet_naring VALUES (385, '01.120');
INSERT INTO public.virksomhet_naring VALUES (385, '90.012');
INSERT INTO public.virksomhet_naring VALUES (386, '01.120');
INSERT INTO public.virksomhet_naring VALUES (386, '90.012');
INSERT INTO public.virksomhet_naring VALUES (387, '01.120');
INSERT INTO public.virksomhet_naring VALUES (387, '90.012');
INSERT INTO public.virksomhet_naring VALUES (388, '01.120');
INSERT INTO public.virksomhet_naring VALUES (388, '90.012');
INSERT INTO public.virksomhet_naring VALUES (389, '01.120');
INSERT INTO public.virksomhet_naring VALUES (389, '90.012');
INSERT INTO public.virksomhet_naring VALUES (389, '70.220');
INSERT INTO public.virksomhet_naring VALUES (390, '01.120');
INSERT INTO public.virksomhet_naring VALUES (391, '01.120');
INSERT INTO public.virksomhet_naring VALUES (392, '01.120');
INSERT INTO public.virksomhet_naring VALUES (393, '01.120');
INSERT INTO public.virksomhet_naring VALUES (394, '01.120');
INSERT INTO public.virksomhet_naring VALUES (395, '01.120');
INSERT INTO public.virksomhet_naring VALUES (396, '01.120');
INSERT INTO public.virksomhet_naring VALUES (397, '01.120');
INSERT INTO public.virksomhet_naring VALUES (397, '90.012');
INSERT INTO public.virksomhet_naring VALUES (398, '01.120');
INSERT INTO public.virksomhet_naring VALUES (398, '90.012');
INSERT INTO public.virksomhet_naring VALUES (399, '01.120');
INSERT INTO public.virksomhet_naring VALUES (399, '90.012');
INSERT INTO public.virksomhet_naring VALUES (399, '70.220');
INSERT INTO public.virksomhet_naring VALUES (400, '01.120');
INSERT INTO public.virksomhet_naring VALUES (401, '01.120');
INSERT INTO public.virksomhet_naring VALUES (401, '90.012');
INSERT INTO public.virksomhet_naring VALUES (401, '70.220');
INSERT INTO public.virksomhet_naring VALUES (402, '01.120');
INSERT INTO public.virksomhet_naring VALUES (403, '01.120');
INSERT INTO public.virksomhet_naring VALUES (403, '90.012');
INSERT INTO public.virksomhet_naring VALUES (403, '70.220');
INSERT INTO public.virksomhet_naring VALUES (404, '01.120');
INSERT INTO public.virksomhet_naring VALUES (405, '01.120');
INSERT INTO public.virksomhet_naring VALUES (406, '01.120');
INSERT INTO public.virksomhet_naring VALUES (406, '90.012');
INSERT INTO public.virksomhet_naring VALUES (406, '70.220');
INSERT INTO public.virksomhet_naring VALUES (407, '01.120');
INSERT INTO public.virksomhet_naring VALUES (407, '90.012');
INSERT INTO public.virksomhet_naring VALUES (408, '01.120');
INSERT INTO public.virksomhet_naring VALUES (409, '01.120');
INSERT INTO public.virksomhet_naring VALUES (409, '90.012');
INSERT INTO public.virksomhet_naring VALUES (409, '70.220');
INSERT INTO public.virksomhet_naring VALUES (410, '01.120');
INSERT INTO public.virksomhet_naring VALUES (410, '90.012');
INSERT INTO public.virksomhet_naring VALUES (411, '01.120');
INSERT INTO public.virksomhet_naring VALUES (411, '90.012');
INSERT INTO public.virksomhet_naring VALUES (412, '01.120');
INSERT INTO public.virksomhet_naring VALUES (413, '01.120');
INSERT INTO public.virksomhet_naring VALUES (414, '01.120');
INSERT INTO public.virksomhet_naring VALUES (414, '90.012');
INSERT INTO public.virksomhet_naring VALUES (414, '70.220');
INSERT INTO public.virksomhet_naring VALUES (415, '01.120');
INSERT INTO public.virksomhet_naring VALUES (415, '90.012');
INSERT INTO public.virksomhet_naring VALUES (415, '70.220');
INSERT INTO public.virksomhet_naring VALUES (416, '01.120');
INSERT INTO public.virksomhet_naring VALUES (416, '90.012');
INSERT INTO public.virksomhet_naring VALUES (417, '01.120');
INSERT INTO public.virksomhet_naring VALUES (418, '01.120');
INSERT INTO public.virksomhet_naring VALUES (419, '01.120');
INSERT INTO public.virksomhet_naring VALUES (419, '90.012');
INSERT INTO public.virksomhet_naring VALUES (420, '01.120');
INSERT INTO public.virksomhet_naring VALUES (421, '01.120');
INSERT INTO public.virksomhet_naring VALUES (422, '01.120');
INSERT INTO public.virksomhet_naring VALUES (423, '01.120');
INSERT INTO public.virksomhet_naring VALUES (423, '90.012');
INSERT INTO public.virksomhet_naring VALUES (424, '01.120');
INSERT INTO public.virksomhet_naring VALUES (424, '90.012');
INSERT INTO public.virksomhet_naring VALUES (425, '01.120');
INSERT INTO public.virksomhet_naring VALUES (425, '90.012');
INSERT INTO public.virksomhet_naring VALUES (426, '01.120');
INSERT INTO public.virksomhet_naring VALUES (426, '90.012');
INSERT INTO public.virksomhet_naring VALUES (427, '01.120');
INSERT INTO public.virksomhet_naring VALUES (427, '90.012');
INSERT INTO public.virksomhet_naring VALUES (428, '01.120');
INSERT INTO public.virksomhet_naring VALUES (429, '01.120');
INSERT INTO public.virksomhet_naring VALUES (430, '01.120');
INSERT INTO public.virksomhet_naring VALUES (431, '01.120');
INSERT INTO public.virksomhet_naring VALUES (431, '90.012');
INSERT INTO public.virksomhet_naring VALUES (432, '01.120');
INSERT INTO public.virksomhet_naring VALUES (433, '01.120');
INSERT INTO public.virksomhet_naring VALUES (433, '90.012');
INSERT INTO public.virksomhet_naring VALUES (433, '70.220');
INSERT INTO public.virksomhet_naring VALUES (434, '01.120');
INSERT INTO public.virksomhet_naring VALUES (435, '01.120');
INSERT INTO public.virksomhet_naring VALUES (436, '01.120');
INSERT INTO public.virksomhet_naring VALUES (436, '90.012');
INSERT INTO public.virksomhet_naring VALUES (436, '70.220');
INSERT INTO public.virksomhet_naring VALUES (437, '01.120');
INSERT INTO public.virksomhet_naring VALUES (437, '90.012');
INSERT INTO public.virksomhet_naring VALUES (438, '01.120');
INSERT INTO public.virksomhet_naring VALUES (438, '90.012');
INSERT INTO public.virksomhet_naring VALUES (438, '70.220');
INSERT INTO public.virksomhet_naring VALUES (439, '01.120');
INSERT INTO public.virksomhet_naring VALUES (439, '90.012');
INSERT INTO public.virksomhet_naring VALUES (440, '01.120');
INSERT INTO public.virksomhet_naring VALUES (440, '90.012');
INSERT INTO public.virksomhet_naring VALUES (441, '01.120');
INSERT INTO public.virksomhet_naring VALUES (442, '01.120');
INSERT INTO public.virksomhet_naring VALUES (442, '90.012');
INSERT INTO public.virksomhet_naring VALUES (442, '70.220');
INSERT INTO public.virksomhet_naring VALUES (443, '01.120');
INSERT INTO public.virksomhet_naring VALUES (443, '90.012');
INSERT INTO public.virksomhet_naring VALUES (443, '70.220');
INSERT INTO public.virksomhet_naring VALUES (444, '01.120');
INSERT INTO public.virksomhet_naring VALUES (444, '90.012');
INSERT INTO public.virksomhet_naring VALUES (445, '01.120');
INSERT INTO public.virksomhet_naring VALUES (445, '90.012');
INSERT INTO public.virksomhet_naring VALUES (445, '70.220');
INSERT INTO public.virksomhet_naring VALUES (446, '01.120');
INSERT INTO public.virksomhet_naring VALUES (447, '01.120');
INSERT INTO public.virksomhet_naring VALUES (447, '90.012');
INSERT INTO public.virksomhet_naring VALUES (447, '70.220');
INSERT INTO public.virksomhet_naring VALUES (448, '01.120');
INSERT INTO public.virksomhet_naring VALUES (449, '01.120');
INSERT INTO public.virksomhet_naring VALUES (450, '01.120');
INSERT INTO public.virksomhet_naring VALUES (451, '01.120');
INSERT INTO public.virksomhet_naring VALUES (452, '01.120');
INSERT INTO public.virksomhet_naring VALUES (452, '90.012');
INSERT INTO public.virksomhet_naring VALUES (452, '70.220');
INSERT INTO public.virksomhet_naring VALUES (453, '01.120');
INSERT INTO public.virksomhet_naring VALUES (454, '01.120');
INSERT INTO public.virksomhet_naring VALUES (454, '90.012');
INSERT INTO public.virksomhet_naring VALUES (455, '01.120');
INSERT INTO public.virksomhet_naring VALUES (455, '90.012');
INSERT INTO public.virksomhet_naring VALUES (456, '01.120');
INSERT INTO public.virksomhet_naring VALUES (457, '01.120');
INSERT INTO public.virksomhet_naring VALUES (458, '01.120');
INSERT INTO public.virksomhet_naring VALUES (459, '01.120');
INSERT INTO public.virksomhet_naring VALUES (459, '90.012');
INSERT INTO public.virksomhet_naring VALUES (460, '01.120');
INSERT INTO public.virksomhet_naring VALUES (461, '01.120');
INSERT INTO public.virksomhet_naring VALUES (462, '01.120');
INSERT INTO public.virksomhet_naring VALUES (463, '01.120');
INSERT INTO public.virksomhet_naring VALUES (464, '01.120');
INSERT INTO public.virksomhet_naring VALUES (465, '01.120');
INSERT INTO public.virksomhet_naring VALUES (465, '90.012');
INSERT INTO public.virksomhet_naring VALUES (466, '01.120');
INSERT INTO public.virksomhet_naring VALUES (466, '90.012');
INSERT INTO public.virksomhet_naring VALUES (467, '01.120');
INSERT INTO public.virksomhet_naring VALUES (467, '90.012');
INSERT INTO public.virksomhet_naring VALUES (468, '01.120');
INSERT INTO public.virksomhet_naring VALUES (468, '90.012');
INSERT INTO public.virksomhet_naring VALUES (469, '01.120');
INSERT INTO public.virksomhet_naring VALUES (470, '01.120');
INSERT INTO public.virksomhet_naring VALUES (471, '01.120');
INSERT INTO public.virksomhet_naring VALUES (471, '90.012');
INSERT INTO public.virksomhet_naring VALUES (472, '01.120');
INSERT INTO public.virksomhet_naring VALUES (473, '01.120');
INSERT INTO public.virksomhet_naring VALUES (473, '90.012');
INSERT INTO public.virksomhet_naring VALUES (474, '01.120');
INSERT INTO public.virksomhet_naring VALUES (475, '01.120');
INSERT INTO public.virksomhet_naring VALUES (475, '90.012');
INSERT INTO public.virksomhet_naring VALUES (476, '01.120');
INSERT INTO public.virksomhet_naring VALUES (477, '01.120');
INSERT INTO public.virksomhet_naring VALUES (477, '90.012');
INSERT INTO public.virksomhet_naring VALUES (477, '70.220');
INSERT INTO public.virksomhet_naring VALUES (478, '01.120');
INSERT INTO public.virksomhet_naring VALUES (479, '01.120');
INSERT INTO public.virksomhet_naring VALUES (479, '90.012');
INSERT INTO public.virksomhet_naring VALUES (479, '70.220');
INSERT INTO public.virksomhet_naring VALUES (480, '01.120');
INSERT INTO public.virksomhet_naring VALUES (480, '90.012');
INSERT INTO public.virksomhet_naring VALUES (481, '01.120');
INSERT INTO public.virksomhet_naring VALUES (482, '01.120');
INSERT INTO public.virksomhet_naring VALUES (483, '01.120');
INSERT INTO public.virksomhet_naring VALUES (483, '90.012');
INSERT INTO public.virksomhet_naring VALUES (484, '01.120');
INSERT INTO public.virksomhet_naring VALUES (485, '01.120');
INSERT INTO public.virksomhet_naring VALUES (485, '90.012');
INSERT INTO public.virksomhet_naring VALUES (485, '70.220');
INSERT INTO public.virksomhet_naring VALUES (486, '01.120');
INSERT INTO public.virksomhet_naring VALUES (487, '01.120');
INSERT INTO public.virksomhet_naring VALUES (487, '90.012');
INSERT INTO public.virksomhet_naring VALUES (488, '01.120');
INSERT INTO public.virksomhet_naring VALUES (489, '01.120');
INSERT INTO public.virksomhet_naring VALUES (489, '90.012');
INSERT INTO public.virksomhet_naring VALUES (490, '01.120');
INSERT INTO public.virksomhet_naring VALUES (490, '90.012');
INSERT INTO public.virksomhet_naring VALUES (491, '01.120');
INSERT INTO public.virksomhet_naring VALUES (491, '90.012');
INSERT INTO public.virksomhet_naring VALUES (491, '70.220');
INSERT INTO public.virksomhet_naring VALUES (492, '01.120');
INSERT INTO public.virksomhet_naring VALUES (492, '90.012');
INSERT INTO public.virksomhet_naring VALUES (493, '01.120');
INSERT INTO public.virksomhet_naring VALUES (493, '90.012');
INSERT INTO public.virksomhet_naring VALUES (493, '70.220');
INSERT INTO public.virksomhet_naring VALUES (494, '01.120');
INSERT INTO public.virksomhet_naring VALUES (495, '01.120');
INSERT INTO public.virksomhet_naring VALUES (495, '90.012');
INSERT INTO public.virksomhet_naring VALUES (496, '01.120');
INSERT INTO public.virksomhet_naring VALUES (497, '01.120');
INSERT INTO public.virksomhet_naring VALUES (498, '01.120');
INSERT INTO public.virksomhet_naring VALUES (499, '01.120');
INSERT INTO public.virksomhet_naring VALUES (499, '90.012');
INSERT INTO public.virksomhet_naring VALUES (499, '70.220');
INSERT INTO public.virksomhet_naring VALUES (500, '01.120');
INSERT INTO public.virksomhet_naring VALUES (500, '90.012');
INSERT INTO public.virksomhet_naring VALUES (500, '70.220');
INSERT INTO public.virksomhet_naring VALUES (501, '01.120');
INSERT INTO public.virksomhet_naring VALUES (502, '01.120');
INSERT INTO public.virksomhet_naring VALUES (503, '01.120');
INSERT INTO public.virksomhet_naring VALUES (504, '01.120');
INSERT INTO public.virksomhet_naring VALUES (504, '90.012');
INSERT INTO public.virksomhet_naring VALUES (504, '70.220');
INSERT INTO public.virksomhet_naring VALUES (505, '01.120');
INSERT INTO public.virksomhet_naring VALUES (505, '90.012');
INSERT INTO public.virksomhet_naring VALUES (506, '01.120');
INSERT INTO public.virksomhet_naring VALUES (507, '01.120');
INSERT INTO public.virksomhet_naring VALUES (507, '90.012');
INSERT INTO public.virksomhet_naring VALUES (507, '70.220');
INSERT INTO public.virksomhet_naring VALUES (508, '01.120');
INSERT INTO public.virksomhet_naring VALUES (509, '01.120');
INSERT INTO public.virksomhet_naring VALUES (509, '90.012');
INSERT INTO public.virksomhet_naring VALUES (510, '01.120');
INSERT INTO public.virksomhet_naring VALUES (511, '01.120');
INSERT INTO public.virksomhet_naring VALUES (517, '01.120');
INSERT INTO public.virksomhet_naring VALUES (517, '90.012');
INSERT INTO public.virksomhet_naring VALUES (518, '01.120');
INSERT INTO public.virksomhet_naring VALUES (518, '90.012');
INSERT INTO public.virksomhet_naring VALUES (519, '01.120');
INSERT INTO public.virksomhet_naring VALUES (520, '01.120');
INSERT INTO public.virksomhet_naring VALUES (521, '01.120');
INSERT INTO public.virksomhet_naring VALUES (522, '01.120');
INSERT INTO public.virksomhet_naring VALUES (523, '01.120');
INSERT INTO public.virksomhet_naring VALUES (523, '90.012');
INSERT INTO public.virksomhet_naring VALUES (523, '70.220');
INSERT INTO public.virksomhet_naring VALUES (524, '01.120');
INSERT INTO public.virksomhet_naring VALUES (525, '01.120');
INSERT INTO public.virksomhet_naring VALUES (525, '90.012');
INSERT INTO public.virksomhet_naring VALUES (525, '70.220');
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
INSERT INTO public.virksomhet_naring VALUES (534, '90.012');
INSERT INTO public.virksomhet_naring VALUES (534, '70.220');
INSERT INTO public.virksomhet_naring VALUES (535, '01.120');
INSERT INTO public.virksomhet_naring VALUES (536, '01.120');
INSERT INTO public.virksomhet_naring VALUES (536, '90.012');
INSERT INTO public.virksomhet_naring VALUES (537, '01.120');
INSERT INTO public.virksomhet_naring VALUES (537, '90.012');
INSERT INTO public.virksomhet_naring VALUES (538, '01.120');
INSERT INTO public.virksomhet_naring VALUES (538, '90.012');
INSERT INTO public.virksomhet_naring VALUES (538, '70.220');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.131236');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.293074');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '555555555', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.293074');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (6, '802206409', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.293074');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '817238182', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '833560632', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '877816099', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '894512904', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (15, '830314374', 'VIRKSOMHET', '3', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (16, '805214180', 'VIRKSOMHET', '3', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (17, '857899421', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (18, '807598834', 'VIRKSOMHET', '2', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (19, '865882840', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (20, '808703328', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (21, '851321904', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (22, '804091455', 'VIRKSOMHET', '2', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '851037073', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '884576933', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (25, '831138079', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '814552794', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (27, '830511836', 'VIRKSOMHET', '2', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '859086141', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (29, '839168077', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '874706819', 'VIRKSOMHET', '3', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (31, '884094771', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '899271514', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '846989088', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '801686721', 'VIRKSOMHET', '2', '2023-06-06 10:45:46.48119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '861804179', 'VIRKSOMHET', '2', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '889949417', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '872469874', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '899093031', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '803845912', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '833081148', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '830011128', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '822555920', 'VIRKSOMHET', '3', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '877133946', 'VIRKSOMHET', '2', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '828674185', 'VIRKSOMHET', '1', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '832079589', 'VIRKSOMHET', '0', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '875081061', 'VIRKSOMHET', '3', '2023-06-06 10:45:46.891184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '873375519', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '887251443', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '874646342', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '831499694', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '822980831', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '830194175', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '827312615', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '835878464', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '881680637', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '820135331', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '881400208', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '853050436', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '841275516', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '824524816', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '814689949', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '827119452', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '863719122', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '822266321', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '891071007', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '835751993', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '833267554', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '857267460', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '880192549', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '863030247', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '828419851', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '861621931', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '890183280', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '860086485', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '863578303', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '895892630', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '803570351', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '876823186', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '803808918', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '849083854', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '826475210', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '808599455', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '899095286', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '856815634', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '894474489', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '812047191', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '890777552', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '820722587', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '809436178', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '810376980', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '890238030', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '828266999', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '862940033', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '880379202', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '810151455', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '881250314', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '875197324', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '824805720', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '842090861', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '813258691', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '882246146', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '891407332', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '862068389', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '820736881', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '860629351', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '872381491', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.106162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '830484510', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '861732339', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '813199268', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '821624303', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '856736407', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '897400542', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '895097486', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '884021287', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '802114238', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '842307904', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '892504040', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '865477980', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '828426342', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '869151445', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '859899076', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '821684747', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '897449659', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '878526531', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '855164299', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '855192908', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '806689657', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '878761080', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '848968830', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.65219');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '885536119', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '878526130', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '843341562', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '800736288', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '807244123', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '877731403', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '888781937', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '806466365', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '800646971', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '803919694', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '813551155', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '824705088', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '823188933', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '808053770', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '837635993', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '823114501', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '885375930', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '813722685', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '848590489', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '817418290', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '872291593', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '843802830', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '821596869', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '834239593', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '870405555', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '862737958', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '894071655', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '837969510', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '882289746', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '817085642', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '855446362', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '863729203', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '865462877', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '877210079', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '837164320', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '851474063', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '860815002', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '862485363', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '849849370', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '873754409', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '873757754', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '892804834', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '858511028', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '883788031', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '831779482', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '850012617', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '843819388', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '884434614', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '824703877', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '820025728', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '898643131', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '807776086', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '869091104', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '876709104', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '846022208', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '849221593', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '803983066', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '852614210', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '807367405', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '818482835', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '843050701', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '828046592', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '867914628', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '806486960', 'VIRKSOMHET', '2', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '854307799', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '898974597', 'VIRKSOMHET', '3', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '823872476', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '890435197', 'VIRKSOMHET', '0', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '846425401', 'VIRKSOMHET', '1', '2023-06-06 10:45:47.92082');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '852145296', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '862444419', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '879842491', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '882660143', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '881043298', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '893165291', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '827941273', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '861881935', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '802174984', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '858521935', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '818345166', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '810280375', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '882063649', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '880150041', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '815490887', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '839389387', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '884601388', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '879432294', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '810840234', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '867469531', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '881832224', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '845694125', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '882816948', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '860781085', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '873714751', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '868280217', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '810425682', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '831398808', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.321448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '864416095', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '817595343', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '813096765', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '874523779', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '834142018', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '859964256', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '867569758', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '892088330', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '879804077', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '838407602', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '817713278', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '881609271', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '803204320', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '898881449', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '878218652', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '843707057', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '823280302', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '865097217', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '898114130', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '889994777', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '831772738', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '821965543', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '824144039', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '813952219', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '806033550', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '863033699', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '830460419', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '862572039', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '872881350', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '865076375', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '892105387', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '837331399', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '895071510', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '841293887', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '800500213', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '830955221', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '889579186', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '855457757', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '831090240', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '870649563', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '857087897', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '801668365', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '843548104', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '843679245', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '856500575', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '856001243', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '817878762', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '838146594', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '840075284', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '821662895', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '843837108', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '845031784', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '875565818', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '803038597', 'VIRKSOMHET', '0', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '839555854', 'VIRKSOMHET', '1', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '857557135', 'VIRKSOMHET', '3', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '815608021', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '893397601', 'VIRKSOMHET', '2', '2023-06-06 10:45:48.504909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '824822764', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '858635007', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '860185319', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '874789310', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '895950630', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '812733329', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '849504303', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '810836388', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '893711345', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '883273560', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '857320873', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '894715113', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '874369743', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '859338769', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '822981319', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '894746652', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '820460458', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '836428741', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '808239579', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '853991955', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '821827369', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '853794730', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '877750244', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '886802160', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '825906262', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '830671460', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '886022624', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '845456654', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.159135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '884934109', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '893013889', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '874793666', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '839840143', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '855087843', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '803909703', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '835613827', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '890368704', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '835188155', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '800268973', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '823381866', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '819345705', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '858313561', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '807334012', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '896839457', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '893504480', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '811376499', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '839956153', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '880478707', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '885376947', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '872081220', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '822891769', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '805863410', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '863609151', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '848216997', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '865120206', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '866740216', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '864140200', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '897926718', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '884422045', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '820615064', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '864666925', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '835261981', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '881186163', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '830886980', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '881297676', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '846943054', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '858637684', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '808580153', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '831384168', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '826740518', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '801382461', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '873647199', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '895605255', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '870822727', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '893467385', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '890913075', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '831873371', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '861316602', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '892864663', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '845152279', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '897305579', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '810297653', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '890247793', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '845466381', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '806092322', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '829331354', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '891213279', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '849837369', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.42322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '803612149', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '825023252', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '846353053', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '810258838', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '879431708', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '835156452', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '835423243', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '800507941', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '823546489', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '889415226', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '868514999', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '816785668', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '877477414', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '867399503', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '803782547', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '840591750', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '897874002', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '847726893', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '807440611', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '883830580', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '815955507', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '837470311', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '837256305', 'VIRKSOMHET', '1', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '842747033', 'VIRKSOMHET', '3', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '873819010', 'VIRKSOMHET', '0', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '803549422', 'VIRKSOMHET', '2', '2023-06-06 10:45:49.995037');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '814219285', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '806755875', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '808335242', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '833332848', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '844409589', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '863230590', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '816633410', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '838405064', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '818054973', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '822120794', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '803175784', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '861389317', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '851061579', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '884377478', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '804695621', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '862776743', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '824502776', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '801824362', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '855825895', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '806038994', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '887795244', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '816697499', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '851165573', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '899139480', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '843588289', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '869634632', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '877345136', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '829442619', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '887417323', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '894887962', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '846850436', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '893618876', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '842192541', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '812859980', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '854266224', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '856588503', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '848336286', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '896802157', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '844933969', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '810623853', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '862213656', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '875365543', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '843459100', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '842552299', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '898017856', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '893101300', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '823158334', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '877940029', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '844999502', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '857539272', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '808770941', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '856491360', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '886740513', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '812672034', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '889929780', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '899700568', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '884630618', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '897345252', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '898834824', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '811318992', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '829482232', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '869652190', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '831602749', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '827983273', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.196594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '875978285', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '879448319', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '890365662', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '842225948', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '894379311', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '816163475', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '840695880', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '858310890', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '822831897', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '823135340', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '854882590', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '878711282', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '826851792', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '843815881', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '873363916', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '837374078', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '884327994', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '839366397', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '886102255', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '856078205', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '853440141', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '832737996', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '868794856', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '806403689', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '895299443', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '846372277', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '833883439', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.636203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '841140296', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '884466343', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '849750724', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '894340275', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '814779312', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '879486882', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '888383595', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '858890670', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '812082043', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '823842450', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '880886744', 'VIRKSOMHET', '1', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '839066600', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '888994357', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '851004605', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '805363239', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '819929608', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '827204080', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '862977616', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '804885788', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '864974024', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '896354155', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '811550861', 'VIRKSOMHET', '2', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '877077716', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '850687115', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '832145659', 'VIRKSOMHET', '3', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '822580377', 'VIRKSOMHET', '0', '2023-06-06 10:45:50.85975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '804056550', 'VIRKSOMHET', '0', '2023-06-06 10:45:55.345104');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '864991293', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.364753');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '853581476', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.364753');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '892420960', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.386455');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '881989395', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.415642');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '802923459', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.415642');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '898545073', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.444466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '871114158', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.444466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '841627076', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.444466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '849843714', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.444466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '822555289', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.478183');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '899567741', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.478183');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '886777842', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.478183');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '865025012', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.478183');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '848622181', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.478183');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '886555703', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.513951');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '878349119', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.513951');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '813897462', 'VIRKSOMHET', '1', '2023-06-06 10:45:55.513951');


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

SELECT pg_catalog.setval('public.siste_publiseringsinfo_id_seq', 2, true);


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
-- PostgreSQL database dump complete
--

