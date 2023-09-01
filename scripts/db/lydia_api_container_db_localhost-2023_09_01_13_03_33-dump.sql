--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Debian 14.8-1.pgdg120+1)
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

ALTER TABLE IF EXISTS ONLY public.virksomhet_naringsundergrupper DROP CONSTRAINT IF EXISTS fk_virksomhet_naringsundergrupper_virksomhet;
ALTER TABLE IF EXISTS ONLY public.virksomhet_naringsundergrupper DROP CONSTRAINT IF EXISTS fk_virksomhet_naringsundergrupper_naring;
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
DROP INDEX IF EXISTS public.idx_bransje_sykefravar_statistikk_bransje;
DROP INDEX IF EXISTS public.flyway_schema_history_s_idx;
ALTER TABLE IF EXISTS ONLY public.virksomhet DROP CONSTRAINT IF EXISTS virksomhet_unik_orgnr;
ALTER TABLE IF EXISTS ONLY public.virksomhet_statistikk_metadata DROP CONSTRAINT IF EXISTS virksomhet_statistikk_metadata_unik_orgnr;
ALTER TABLE IF EXISTS ONLY public.virksomhet DROP CONSTRAINT IF EXISTS virksomhet_pkey;
ALTER TABLE IF EXISTS ONLY public.virksomhet_naringsundergrupper DROP CONSTRAINT IF EXISTS virksomhet_naringsundergrupper_unik;
ALTER TABLE IF EXISTS ONLY public.virksomhet_naringsundergrupper DROP CONSTRAINT IF EXISTS virksomhet_naringsundergrupper_pkey;
ALTER TABLE IF EXISTS ONLY public.virksomhet_statistikk_metadata DROP CONSTRAINT IF EXISTS virksomhet_metadata_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet_siste_4_kvartal DROP CONSTRAINT IF EXISTS sykefravar_statistikk_virksomhet_siste_4_kvartal_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet_siste_4_kvartal DROP CONSTRAINT IF EXISTS sykefravar_statistikk_virksomhet_siste_4_kvartal_orgnr_key;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet DROP CONSTRAINT IF EXISTS sykefravar_statistikk_virksomhet_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_sektor DROP CONSTRAINT IF EXISTS sykefravar_statistikk_sektor_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naringsundergruppe DROP CONSTRAINT IF EXISTS sykefravar_statistikk_naringsundergruppe_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naring DROP CONSTRAINT IF EXISTS sykefravar_statistikk_naring_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_land DROP CONSTRAINT IF EXISTS sykefravar_statistikk_land_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_kategori_siste_4_kvartal DROP CONSTRAINT IF EXISTS sykefravar_statistikk_kategori_siste_4_kvartal_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_bransje DROP CONSTRAINT IF EXISTS sykefravar_statistikk_bransje_pkey;
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
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_bransje DROP CONSTRAINT IF EXISTS bransje_periode;
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
ALTER TABLE IF EXISTS public.sykefravar_statistikk_bransje ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.siste_publiseringsinfo ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.modul ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.iasak_leveranse ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ia_tjeneste ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.virksomhet_naringsundergrupper_id_seq;
DROP TABLE IF EXISTS public.virksomhet_naringsundergrupper;
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
DROP SEQUENCE IF EXISTS public.sykefravar_statistikk_bransje_id_seq;
DROP TABLE IF EXISTS public.sykefravar_statistikk_bransje;
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
-- Name: sykefravar_statistikk_bransje; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.sykefravar_statistikk_bransje (
    id integer NOT NULL,
    arstall smallint NOT NULL,
    kvartal smallint NOT NULL,
    bransje character varying NOT NULL,
    antall_personer numeric NOT NULL,
    tapte_dagsverk numeric NOT NULL,
    mulige_dagsverk numeric NOT NULL,
    prosent numeric NOT NULL,
    maskert boolean NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sykefravar_statistikk_bransje OWNER TO test;

--
-- Name: sykefravar_statistikk_bransje_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.sykefravar_statistikk_bransje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_bransje_id_seq OWNER TO test;

--
-- Name: sykefravar_statistikk_bransje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.sykefravar_statistikk_bransje_id_seq OWNED BY public.sykefravar_statistikk_bransje.id;


--
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.sykefravar_statistikk_kategori_siste_4_kvartal (
    id integer NOT NULL,
    kategori character varying(20) NOT NULL,
    kode character varying NOT NULL,
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
-- Name: virksomhet_naringsundergrupper; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.virksomhet_naringsundergrupper (
    id integer NOT NULL,
    virksomhet integer NOT NULL,
    naringsundergruppe1 character varying NOT NULL,
    naringsundergruppe2 character varying,
    naringsundergruppe3 character varying,
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
-- Name: sykefravar_statistikk_bransje id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_bransje ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_bransje_id_seq'::regclass);


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

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', 'V1__init.sql', 1782034767, 'test', '2023-09-01 13:01:17.577208', 63, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', 'V2__create_virksomhet_adresse.sql', -64248919, 'test', '2023-09-01 13:01:17.734377', 55, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', 'V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2023-09-01 13:01:17.867447', 18, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', 'V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2023-09-01 13:01:17.931108', 21, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', 'V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2023-09-01 13:01:17.986716', 23, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', 'V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2023-09-01 13:01:18.051989', 16, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', 'V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2023-09-01 13:01:18.102163', 25, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', 'V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2023-09-01 13:01:18.174113', 15, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', 'V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2023-09-01 13:01:18.237173', 35, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', 'V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2023-09-01 13:01:18.305906', 20, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', 'V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2023-09-01 13:01:18.366477', 13, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', 'V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2023-09-01 13:01:18.41517', 15, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', 'V13__ia_prosess.sql', -1755516749, 'test', '2023-09-01 13:01:18.471222', 18, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', 'V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2023-09-01 13:01:18.523784', 51, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', 'V15__endre_saknummer.sql', -1379621340, 'test', '2023-09-01 13:01:18.620899', 18, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', 'V16__ia_sak_hendelse.sql', 586872662, 'test', '2023-09-01 13:01:18.680576', 29, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', 'V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2023-09-01 13:01:18.745948', 16, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', 'V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2023-09-01 13:01:18.798293', 24, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', 'V19__legg_til_begrunnelser.sql', 779259005, 'test', '2023-09-01 13:01:18.852137', 19, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', 'V20__legg_til_flere_indekser.sql', -843857404, 'test', '2023-09-01 13:01:18.897068', 27, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', 'V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2023-09-01 13:01:18.951197', 16, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', 'V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2023-09-01 13:01:19.009006', 12, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', 'V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2023-09-01 13:01:19.054471', 19, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', 'V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2023-09-01 13:01:19.111349', 46, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', 'V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2023-09-01 13:01:19.193504', 42, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', 'V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2023-09-01 13:01:19.273443', 17, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', 'V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2023-09-01 13:01:19.324887', 12, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', 'V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2023-09-01 13:01:19.37498', 12, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', 'V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2023-09-01 13:01:19.416135', 17, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', 'V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2023-09-01 13:01:19.456891', 13, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', 'V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2023-09-01 13:01:19.503025', 18, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', 'V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2023-09-01 13:01:19.571228', 13, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', 'V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2023-09-01 13:01:19.622619', 12, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', 'V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2023-09-01 13:01:19.673794', 121, true);
INSERT INTO public.flyway_schema_history VALUES (35, '35', 'drop sykefravar statistikk grunnlag', 'SQL', 'V35__drop_sykefravar_statistikk_grunnlag.sql', 461103825, 'test', '2023-09-01 13:01:19.871943', 18, true);
INSERT INTO public.flyway_schema_history VALUES (36, '36', 'registrere bistand', 'SQL', 'V36__registrere_bistand.sql', -1365283904, 'test', '2023-09-01 13:01:19.922424', 37, true);
INSERT INTO public.flyway_schema_history VALUES (37, '37', 'fullfoert dato leveranse', 'SQL', 'V37__fullfoert_dato_leveranse.sql', 1621470787, 'test', '2023-09-01 13:01:19.994449', 15, true);
INSERT INTO public.flyway_schema_history VALUES (38, '38', 'oppdatere moduler', 'SQL', 'V38__oppdatere_moduler.sql', -246234034, 'test', '2023-09-01 13:01:20.056943', 16, true);
INSERT INTO public.flyway_schema_history VALUES (39, '39', 'rette iatjeneste på modul', 'SQL', 'V39__rette_iatjeneste_på_modul.sql', -1034067650, 'test', '2023-09-01 13:01:20.109021', 16, true);
INSERT INTO public.flyway_schema_history VALUES (40, '40', 'legg til rolle ia sak hendelse', 'SQL', 'V40__legg_til_rolle_ia_sak_hendelse.sql', -82283870, 'test', '2023-09-01 13:01:20.164883', 12, true);
INSERT INTO public.flyway_schema_history VALUES (41, '41', 'legg til rolle ia sak leveranse', 'SQL', 'V41__legg_til_rolle_ia_sak_leveranse.sql', -2029318456, 'test', '2023-09-01 13:01:20.212948', 12, true);
INSERT INTO public.flyway_schema_history VALUES (42, '42', 'legg til deaktivert', 'SQL', 'V42__legg_til_deaktivert.sql', 1170357332, 'test', '2023-09-01 13:01:20.25169', 15, true);
INSERT INTO public.flyway_schema_history VALUES (43, '43', 'siste publiseringsinfo tabell', 'SQL', 'V43__siste_publiseringsinfo_tabell.sql', -1555520829, 'test', '2023-09-01 13:01:20.292485', 16, true);
INSERT INTO public.flyway_schema_history VALUES (44, '44', 'hendelse nav enhet', 'SQL', 'V44__hendelse_nav_enhet.sql', -1118774222, 'test', '2023-09-01 13:01:20.336013', 30, true);
INSERT INTO public.flyway_schema_history VALUES (45, '45', 'oppdatere siste publiseringsinfo', 'SQL', 'V45__oppdatere_siste_publiseringsinfo.sql', -1919960111, 'test', '2023-09-01 13:01:20.396466', 18, true);
INSERT INTO public.flyway_schema_history VALUES (46, '46', 'populer siste publiseringsdato', 'SQL', 'V46__populer_siste_publiseringsdato.sql', 21300723, 'test', '2023-09-01 13:01:20.452003', 32, true);
INSERT INTO public.flyway_schema_history VALUES (47, '47', 'virksomhet naringsundergrupper tabell', 'SQL', 'V47__virksomhet_naringsundergrupper_tabell.sql', 581614507, 'test', '2023-09-01 13:01:20.518286', 24, true);
INSERT INTO public.flyway_schema_history VALUES (48, '48', 'endre oppdateringsdato', 'SQL', 'V48__endre_oppdateringsdato.sql', 855334580, 'test', '2023-09-01 13:01:20.582001', 22, true);
INSERT INTO public.flyway_schema_history VALUES (49, '49', 'sykefravar statistikk bransje tabell', 'SQL', 'V49__sykefravar_statistikk_bransje_tabell.sql', 1439525146, 'test', '2023-09-01 13:01:20.634205', 21, true);
INSERT INTO public.flyway_schema_history VALUES (50, '50', 'endre kode lengde siste 4 kvartal', 'SQL', 'V50__endre_kode_lengde_siste_4_kvartal.sql', 218855534, 'test', '2023-09-01 13:01:20.68647', 14, true);
INSERT INTO public.flyway_schema_history VALUES (51, '51', 'endre navn fra naeringskode til naringsundergruppe', 'SQL', 'V51__endre_navn_fra_naeringskode_til_naringsundergruppe.sql', 498551672, 'test', '2023-09-01 13:01:20.729386', 18, true);
INSERT INTO public.flyway_schema_history VALUES (52, '52', 'slett virksomhet naring tabell', 'SQL', 'V52__slett_virksomhet_naring_tabell.sql', 1210783708, 'test', '2023-09-01 13:01:20.775919', 13, true);
INSERT INTO public.flyway_schema_history VALUES (53, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 1020275274, 'test', '2023-09-01 13:01:20.819283', 19, true);
INSERT INTO public.flyway_schema_history VALUES (54, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -856479599, 'test', '2023-09-01 13:01:58.340586', 40, true);


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

INSERT INTO public.siste_publiseringsinfo VALUES (1, 2022, 4, '2023-03-02 00:00:00', '2023-06-01 00:00:00', '2023-09-01 13:01:20.302549');
INSERT INTO public.siste_publiseringsinfo VALUES (2, 2023, 1, '2023-06-01 00:00:00', '2023-09-07 00:00:00', '2023-09-01 13:01:20.413001');
INSERT INTO public.siste_publiseringsinfo VALUES (3, 2022, 3, '2022-12-01 00:00:00', '2023-03-02 00:00:00', '2023-09-01 13:01:20.466202');
INSERT INTO public.siste_publiseringsinfo VALUES (4, 2022, 2, '2022-09-08 00:00:00', '2022-12-01 00:00:00', '2023-09-01 13:01:20.466202');
INSERT INTO public.siste_publiseringsinfo VALUES (5, 2022, 1, '2022-06-02 00:00:00', '2022-09-08 00:00:00', '2023-09-01 13:01:20.466202');
INSERT INTO public.siste_publiseringsinfo VALUES (6, 2021, 4, '2022-03-03 00:00:00', '2022-06-02 00:00:00', '2023-09-01 13:01:20.466202');
INSERT INTO public.siste_publiseringsinfo VALUES (7, 2021, 3, '2021-12-02 00:00:00', '2022-03-03 00:00:00', '2023-09-01 13:01:20.466202');


--
-- Data for Name: sykefravar_statistikk_bransje; Type: TABLE DATA; Schema: public; Owner: test
--



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

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2023, 1, 6, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.147066', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2022, 4, 6, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.181356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2023, 1, 650, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2022, 4, 650, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '555555555', 2023, 1, 218, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '840563951', 2023, 1, 959, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '840563951', 2022, 4, 959, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '844028810', 2023, 1, 42, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '844028810', 2022, 4, 42, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '879683085', 2023, 1, 42, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '879683085', 2022, 4, 42, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '846468514', 2023, 1, 61, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '846468514', 2022, 4, 61, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '833092794', 2023, 1, 491, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '817549367', 2023, 1, 232, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '881668649', 2023, 1, 575, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '830704213', 2023, 1, 728, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '828285204', 2023, 1, 54, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '820874281', 2023, 1, 92, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '871838056', 2023, 1, 385, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '801643853', 2023, 1, 249, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '854308980', 2023, 1, 998, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '857012601', 2023, 1, 575, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '848910171', 2023, 1, 638, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '872839692', 2023, 1, 383, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '825863802', 2023, 1, 549, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '817000325', 2023, 1, 212, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.26599', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '839972893', 2023, 1, 456, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.346647', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '832474989', 2023, 1, 20, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.346647', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '896635459', 2023, 1, 347, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.346647', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '886357004', 2023, 1, 563, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.346647', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '885895116', 2023, 1, 754, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '814487750', 2023, 1, 475, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '831093512', 2023, 1, 652, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '873745729', 2023, 1, 275, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '820353273', 2023, 1, 58, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '826836351', 2023, 1, 615, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '856867915', 2023, 1, 386, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '874511382', 2023, 1, 746, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '821330635', 2023, 1, 911, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '846851318', 2023, 1, 101, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '811350402', 2023, 1, 580, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '807612691', 2023, 1, 556, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '850641118', 2023, 1, 708, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '891617166', 2023, 1, 559, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '845818867', 2023, 1, 203, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '894851986', 2023, 1, 474, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '807618154', 2023, 1, 100, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '872517152', 2023, 1, 168, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '892101191', 2023, 1, 647, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '801663204', 2023, 1, 870, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.452347', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '885577241', 2023, 1, 595, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.538976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '826487665', 2023, 1, 697, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.538976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '836121193', 2023, 1, 720, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.538976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '816811477', 2023, 1, 308, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.538976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '895694541', 2023, 1, 944, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.538976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '873767750', 2023, 1, 268, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.538976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '863317728', 2023, 1, 906, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.538976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '843647618', 2023, 1, 857, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '871864762', 2023, 1, 695, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '887286152', 2023, 1, 448, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '849595504', 2023, 1, 645, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '852393167', 2023, 1, 977, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '879883134', 2023, 1, 857, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '866940889', 2023, 1, 616, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '864958773', 2023, 1, 993, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '859959251', 2023, 1, 349, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '838372207', 2023, 1, 423, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '896870431', 2023, 1, 107, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '889345261', 2023, 1, 409, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.608397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '872514008', 2023, 1, 44, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.670796', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '825703551', 2023, 1, 453, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.670796', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '801524565', 2023, 1, 526, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.670796', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '819151355', 2023, 1, 791, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.670796', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '894794240', 2023, 1, 915, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.670796', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '863424096', 2023, 1, 599, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.670796', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '849696997', 2023, 1, 608, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.71384', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '835661484', 2023, 1, 558, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.71384', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '895708763', 2023, 1, 582, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.71384', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '814687293', 2023, 1, 564, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.71384', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '892595718', 2023, 1, 320, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.71384', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '893059597', 2023, 1, 275, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.71384', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '833908963', 2023, 1, 862, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.71384', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '879661736', 2023, 1, 672, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.71384', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '819334264', 2023, 1, 89, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.71384', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '868810378', 2023, 1, 42, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.71384', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '848273724', 2023, 1, 436, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.764629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '856704980', 2023, 1, 247, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.764629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '870186667', 2023, 1, 790, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.764629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '805774066', 2023, 1, 177, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.764629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '866450049', 2023, 1, 930, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.764629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '887994003', 2023, 1, 931, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.764629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '842914169', 2023, 1, 495, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.764629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '848797491', 2023, 1, 32, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.764629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '807813627', 2023, 1, 920, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.80992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '834167604', 2023, 1, 270, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.80992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '874335732', 2023, 1, 636, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.80992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '826915711', 2023, 1, 876, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.80992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '835952962', 2023, 1, 154, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.80992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '830046194', 2023, 1, 479, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.80992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '859514340', 2023, 1, 559, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.80992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '870772243', 2023, 1, 943, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.880064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '801742803', 2023, 1, 29, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.880064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '863629482', 2023, 1, 712, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.880064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '886623437', 2023, 1, 690, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.880064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '879799300', 2023, 1, 819, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.880064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '877281898', 2023, 1, 43, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.880064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '853945949', 2023, 1, 127, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.880064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '894480080', 2023, 1, 287, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.880064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '870642221', 2023, 1, 288, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.880064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '893652131', 2023, 1, 208, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.880064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '878051746', 2023, 1, 985, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.925803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '823152176', 2023, 1, 468, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.925803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '810868617', 2023, 1, 574, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.925803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '850126521', 2023, 1, 794, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.925803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '833180535', 2023, 1, 988, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.925803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '876578552', 2023, 1, 497, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.925803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '847429997', 2023, 1, 543, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.925803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '861795773', 2023, 1, 666, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.925803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '878971899', 2023, 1, 644, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.987642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '816782600', 2023, 1, 650, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.987642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '861430193', 2023, 1, 36, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.987642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '867266177', 2023, 1, 540, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.987642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '877683962', 2023, 1, 114, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.987642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '802258475', 2023, 1, 195, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.987642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '804482256', 2023, 1, 248, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.987642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '852236310', 2023, 1, 135, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.987642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '848766928', 2023, 1, 380, 12.8, 125, 1.5, false, '2023-09-01 13:02:31.987642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '825056986', 2023, 1, 567, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.035187', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '893417017', 2023, 1, 698, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.035187', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '813307155', 2023, 1, 77, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.035187', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '896289587', 2023, 1, 525, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.035187', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '841791511', 2023, 1, 120, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.035187', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '861597616', 2023, 1, 525, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.085376', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '890775982', 2023, 1, 960, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.085376', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '830479135', 2023, 1, 923, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.085376', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '870170432', 2023, 1, 24, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.085376', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '881974816', 2023, 1, 18, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.085376', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '821553355', 2023, 1, 761, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.085376', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '829730277', 2023, 1, 308, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.085376', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '868315277', 2023, 1, 775, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.085376', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '800039249', 2023, 1, 960, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.085376', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '846412706', 2023, 1, 665, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.123127', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '884832900', 2023, 1, 343, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.123127', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '808931289', 2023, 1, 830, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.123127', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '861875368', 2023, 1, 347, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.123127', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '862397552', 2023, 1, 6, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.123127', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '821753952', 2023, 1, 391, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.171457', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '892729481', 2023, 1, 91, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.171457', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '802727698', 2023, 1, 871, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.171457', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '840096162', 2023, 1, 301, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.171457', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '888659470', 2023, 1, 295, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.171457', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '850200327', 2023, 1, 629, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.171457', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '861393944', 2023, 1, 64, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.171457', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '833369082', 2023, 1, 258, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.227868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '899621957', 2023, 1, 304, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.227868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '870923918', 2023, 1, 756, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.227868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '817115960', 2023, 1, 889, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.227868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '872469548', 2023, 1, 462, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.227868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '887868763', 2023, 1, 336, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.227868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '855657326', 2023, 1, 971, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.227868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '860417684', 2023, 1, 48, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.272209', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '868128237', 2023, 1, 834, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.272209', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '857116596', 2023, 1, 323, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.272209', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '895842997', 2023, 1, 728, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.272209', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '801305726', 2023, 1, 387, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.272209', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '892425810', 2023, 1, 202, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.315117', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '835327648', 2023, 1, 17, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.315117', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '853021452', 2023, 1, 74, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.315117', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '837365133', 2023, 1, 528, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.315117', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '800482686', 2023, 1, 787, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.315117', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '897324044', 2023, 1, 714, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.315117', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '835671490', 2023, 1, 327, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.363196', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '897991520', 2023, 1, 874, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.363196', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '876559691', 2023, 1, 70, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.363196', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '891356146', 2023, 1, 987, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.363196', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '892361559', 2023, 1, 401, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.363196', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '812573755', 2023, 1, 505, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.363196', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '846794321', 2023, 1, 241, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.363196', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '836534690', 2023, 1, 354, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.414503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '886609379', 2023, 1, 330, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.414503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '892136879', 2023, 1, 522, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.414503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '841281181', 2023, 1, 459, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.414503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '882825096', 2023, 1, 180, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.414503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '888357366', 2023, 1, 112, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.414503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '855595319', 2023, 1, 306, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.473398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '824600423', 2023, 1, 866, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.473398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '830996379', 2023, 1, 756, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.473398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '825154853', 2023, 1, 916, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.473398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '838584086', 2023, 1, 250, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.473398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '821020415', 2023, 1, 760, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.473398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '808632104', 2023, 1, 875, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.473398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '876011318', 2023, 1, 33, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.544022', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '825580046', 2023, 1, 624, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.544022', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '849162278', 2023, 1, 203, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.544022', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '825633362', 2023, 1, 302, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.544022', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '845385150', 2023, 1, 515, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.544022', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '870882127', 2023, 1, 758, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.544022', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '815492716', 2023, 1, 82, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.544022', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '823633253', 2023, 1, 750, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.583041', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '898182420', 2023, 1, 347, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.583041', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '859741138', 2023, 1, 757, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.583041', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '896451492', 2023, 1, 494, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.583041', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '810860783', 2023, 1, 28, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.583041', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '830535540', 2023, 1, 592, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.583041', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '828662423', 2023, 1, 655, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.583041', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '879730471', 2023, 1, 796, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.632011', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '863677191', 2023, 1, 667, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.632011', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '821212732', 2023, 1, 260, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.632011', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '894678259', 2023, 1, 944, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.632011', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '840608868', 2023, 1, 7, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.632011', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '896187288', 2023, 1, 18, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.632011', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '838721828', 2023, 1, 527, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.632011', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '856189591', 2023, 1, 689, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.632011', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '876273878', 2023, 1, 989, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.683325', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '861845076', 2023, 1, 624, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.683325', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '885168462', 2023, 1, 328, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.683325', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '822194048', 2023, 1, 421, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.683325', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '822247206', 2023, 1, 999, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.683325', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '872772840', 2023, 1, 646, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.683325', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '849349122', 2023, 1, 22, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.731806', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '848678778', 2023, 1, 32, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.731806', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '856425068', 2023, 1, 842, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.731806', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '874049341', 2023, 1, 568, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.731806', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '874858219', 2023, 1, 228, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.731806', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '886351929', 2023, 1, 777, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.731806', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '882682006', 2023, 1, 953, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.731806', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '815979604', 2023, 1, 222, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.781137', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '839386992', 2023, 1, 41, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.781137', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '857404113', 2023, 1, 232, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.781137', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '869983436', 2023, 1, 533, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.781137', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '878032565', 2023, 1, 192, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.781137', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '819705126', 2023, 1, 778, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.781137', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '845287728', 2023, 1, 413, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.821862', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '860837701', 2023, 1, 289, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.821862', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '875842181', 2023, 1, 412, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.821862', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '804699906', 2023, 1, 164, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.821862', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '823614948', 2023, 1, 17, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.821862', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '862500476', 2023, 1, 793, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.821862', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '809412443', 2023, 1, 124, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.867385', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '828229131', 2023, 1, 209, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.867385', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '801498562', 2023, 1, 291, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.867385', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '873369415', 2023, 1, 456, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.867385', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '895611299', 2023, 1, 556, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.867385', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '841020642', 2023, 1, 182, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.867385', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '824842469', 2023, 1, 72, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.934194', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '879641976', 2023, 1, 524, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.934194', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '865456582', 2023, 1, 328, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.934194', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '894482342', 2023, 1, 356, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.934194', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '898371335', 2023, 1, 693, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.934194', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '855496620', 2023, 1, 614, 12.8, 125, 1.5, false, '2023-09-01 13:02:32.934194', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '827673788', 2023, 1, 128, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.023763', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '843554986', 2023, 1, 451, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.023763', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '889779510', 2023, 1, 658, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.023763', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '857354197', 2023, 1, 978, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.023763', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '823773229', 2023, 1, 384, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.023763', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '807707298', 2023, 1, 37, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.023763', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '865421389', 2023, 1, 477, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.023763', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '876063217', 2023, 1, 694, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.097438', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '895621261', 2023, 1, 91, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.097438', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '885492879', 2023, 1, 874, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.097438', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '894782357', 2023, 1, 673, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.097438', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '835084511', 2023, 1, 545, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.097438', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '861993774', 2023, 1, 766, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.097438', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '889170847', 2023, 1, 442, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.097438', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '828494499', 2023, 1, 37, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.139212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '854202196', 2023, 1, 828, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.139212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '802742619', 2023, 1, 909, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.139212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '868404321', 2023, 1, 839, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.139212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '851956311', 2023, 1, 277, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.139212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '823334696', 2023, 1, 654, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.139212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '852790719', 2023, 1, 68, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.139212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '893629730', 2023, 1, 509, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.139212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '863813033', 2023, 1, 375, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.139212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '808618938', 2023, 1, 660, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.172294', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '809260201', 2023, 1, 192, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.172294', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '895819984', 2023, 1, 936, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.172294', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '819657813', 2023, 1, 351, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.172294', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '800224708', 2023, 1, 208, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.172294', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '806669485', 2023, 1, 771, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.211061', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '880734391', 2023, 1, 147, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.211061', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '828568610', 2023, 1, 911, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.211061', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '823138132', 2023, 1, 336, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.211061', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '817989278', 2023, 1, 28, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.211061', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '802713634', 2023, 1, 608, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.211061', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '807804577', 2023, 1, 638, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.211061', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '848323171', 2023, 1, 441, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.211061', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '832865945', 2023, 1, 312, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.243852', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '860309060', 2023, 1, 69, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.243852', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '814889148', 2023, 1, 834, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.243852', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '891572191', 2023, 1, 629, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.243852', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '877218345', 2023, 1, 944, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.243852', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '886724220', 2023, 1, 235, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.291307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '820530610', 2023, 1, 319, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.291307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '837535869', 2023, 1, 11, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.291307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '865065632', 2023, 1, 828, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.291307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '873542190', 2023, 1, 70, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.291307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '814804594', 2023, 1, 560, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.291307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '857056451', 2023, 1, 633, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.291307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '869737356', 2023, 1, 613, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.291307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '848200494', 2023, 1, 887, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.339992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '811656574', 2023, 1, 88, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.339992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '859300392', 2023, 1, 357, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.339992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '888201315', 2023, 1, 295, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.339992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '802642361', 2023, 1, 917, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.382232', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '895927960', 2023, 1, 86, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.382232', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '858574195', 2023, 1, 453, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.382232', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '836046143', 2023, 1, 542, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.382232', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '872682864', 2023, 1, 945, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.382232', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '868541833', 2023, 1, 457, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.382232', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '887162294', 2023, 1, 725, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.382232', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '872722388', 2023, 1, 519, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.382232', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '856110013', 2023, 1, 891, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.382232', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '888356763', 2023, 1, 815, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.432588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '876598168', 2023, 1, 502, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.432588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '898292659', 2023, 1, 685, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.432588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '884348614', 2023, 1, 324, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.432588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '861893059', 2023, 1, 82, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.432588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '813576485', 2023, 1, 397, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.432588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '815615055', 2023, 1, 250, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.482584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '851095336', 2023, 1, 262, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.482584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '839238424', 2023, 1, 19, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.482584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '802413011', 2023, 1, 311, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.482584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '860737507', 2023, 1, 997, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.482584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '870274950', 2023, 1, 71, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.482584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '848225721', 2023, 1, 379, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.482584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '869094505', 2023, 1, 717, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.534864', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '820130498', 2023, 1, 771, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.534864', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '890410982', 2023, 1, 563, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.534864', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '808992454', 2023, 1, 399, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.534864', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '884151600', 2023, 1, 890, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.576276', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '853357327', 2023, 1, 653, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.576276', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '816439848', 2023, 1, 694, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.576276', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '884209909', 2023, 1, 478, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.576276', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '899443571', 2023, 1, 637, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.576276', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '866284751', 2023, 1, 600, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.576276', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '880509861', 2023, 1, 746, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.625846', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '849684760', 2023, 1, 384, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.625846', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '828427862', 2023, 1, 440, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.625846', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '806894844', 2023, 1, 642, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.625846', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '814590821', 2023, 1, 981, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.667516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '837061530', 2023, 1, 845, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.667516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '801554425', 2023, 1, 748, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.667516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '810074954', 2023, 1, 638, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.667516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '859766179', 2023, 1, 361, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.69642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '871799161', 2023, 1, 938, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.69642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '801976897', 2023, 1, 650, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.69642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '802585963', 2023, 1, 765, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.69642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '818337697', 2023, 1, 607, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.69642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '879951937', 2023, 1, 661, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.69642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '831001012', 2023, 1, 979, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.724481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '898847680', 2023, 1, 918, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.724481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '852996781', 2023, 1, 612, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.724481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '859568205', 2023, 1, 112, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.724481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '878298725', 2023, 1, 603, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.76335', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '865500726', 2023, 1, 284, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.76335', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '847800406', 2023, 1, 455, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.76335', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '812585250', 2023, 1, 955, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.76335', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '829630446', 2023, 1, 379, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.76335', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '878665958', 2023, 1, 455, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.76335', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '867338166', 2023, 1, 405, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.801289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '874303897', 2023, 1, 622, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.801289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '815797440', 2023, 1, 344, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.801289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '878302329', 2023, 1, 721, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.801289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '814902719', 2023, 1, 588, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.801289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '861928097', 2023, 1, 932, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.837208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '814214408', 2023, 1, 966, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.837208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '841446216', 2023, 1, 157, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.837208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '880913102', 2023, 1, 253, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.837208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '804954274', 2023, 1, 781, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.837208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '867602272', 2023, 1, 568, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.837208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '890907727', 2023, 1, 901, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.907366', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '896522080', 2023, 1, 924, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.907366', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '805655729', 2023, 1, 474, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.907366', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '839500879', 2023, 1, 601, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.907366', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '885869627', 2023, 1, 592, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.907366', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '875445187', 2023, 1, 861, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.966577', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '813466439', 2023, 1, 212, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.966577', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '896623441', 2023, 1, 906, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.966577', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '808991850', 2023, 1, 988, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.966577', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '829507713', 2023, 1, 158, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.966577', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '833117254', 2023, 1, 791, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.966577', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '837846413', 2023, 1, 835, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.966577', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '869503803', 2023, 1, 790, 12.8, 125, 1.5, false, '2023-09-01 13:02:33.966577', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '883744480', 2023, 1, 153, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.045686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '841681491', 2023, 1, 802, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.045686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '804469736', 2023, 1, 567, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.045686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '842580200', 2023, 1, 784, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.045686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '867939301', 2023, 1, 155, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.096095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '846991517', 2023, 1, 308, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.096095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '849842492', 2023, 1, 330, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.096095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '892824713', 2023, 1, 193, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.096095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '871393874', 2023, 1, 118, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.096095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '838748341', 2023, 1, 183, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.096095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '852620240', 2023, 1, 648, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.096095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '810480871', 2023, 1, 76, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.139288', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '836141850', 2023, 1, 589, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.139288', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '813662987', 2023, 1, 608, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.139288', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '874409446', 2023, 1, 645, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.139288', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '882071110', 2023, 1, 168, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.139288', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '831281285', 2023, 1, 954, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.180822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '812422244', 2023, 1, 462, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.180822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '877641955', 2023, 1, 200, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.180822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '849832913', 2023, 1, 230, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.180822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '878265524', 2023, 1, 943, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.180822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '862385530', 2023, 1, 365, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.180822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '832873358', 2023, 1, 290, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.180822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '865506081', 2023, 1, 546, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.180822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '862694712', 2023, 1, 172, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.220104', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '808556476', 2023, 1, 235, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.220104', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '809785402', 2023, 1, 725, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.220104', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '820464657', 2023, 1, 675, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.220104', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '806453016', 2023, 1, 101, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.220104', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '855109259', 2023, 1, 726, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.260039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '844136610', 2023, 1, 695, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.260039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '868437705', 2023, 1, 225, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.260039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '805414233', 2023, 1, 506, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.260039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '843122242', 2023, 1, 119, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.260039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '880436983', 2023, 1, 969, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.260039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '877619067', 2023, 1, 732, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.260039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '825656069', 2023, 1, 80, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.302751', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '809247535', 2023, 1, 696, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.302751', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '850902238', 2023, 1, 466, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.302751', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '805065367', 2023, 1, 905, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.302751', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '884103260', 2023, 1, 92, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.302751', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '896185086', 2023, 1, 221, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.302751', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '879147472', 2023, 1, 545, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.345835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '859469327', 2023, 1, 246, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.345835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '809021214', 2023, 1, 707, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.345835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '890441272', 2023, 1, 13, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.345835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '843918726', 2023, 1, 490, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.345835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '867010071', 2023, 1, 374, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.345835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '899491325', 2023, 1, 486, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.345835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '817860197', 2023, 1, 869, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.391345', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '894342532', 2023, 1, 387, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.391345', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '832677042', 2023, 1, 9, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.391345', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '886394237', 2023, 1, 60, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.391345', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '872624587', 2023, 1, 968, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.391345', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '898866641', 2023, 1, 450, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.391345', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '884853942', 2023, 1, 569, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.448068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '819545829', 2023, 1, 78, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.448068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '833817902', 2023, 1, 734, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.448068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '885642137', 2023, 1, 737, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.448068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '896711412', 2023, 1, 668, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.448068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '821835062', 2023, 1, 594, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.448068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '870037842', 2023, 1, 144, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.448068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '817185565', 2023, 1, 488, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.488644', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '867521592', 2023, 1, 897, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.488644', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '877585722', 2023, 1, 959, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.488644', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '834435277', 2023, 1, 498, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.488644', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '822051894', 2023, 1, 324, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.488644', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '833917059', 2023, 1, 750, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.532303', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '845980869', 2023, 1, 685, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.532303', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '855519631', 2023, 1, 677, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.532303', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '831415125', 2023, 1, 510, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.532303', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '846728931', 2023, 1, 756, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.532303', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '848471580', 2023, 1, 561, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.584612', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '873734324', 2023, 1, 404, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.584612', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '857680633', 2023, 1, 343, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.584612', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '835913918', 2023, 1, 844, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.584612', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '857383092', 2023, 1, 750, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.636665', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '839907680', 2023, 1, 819, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.636665', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '825019259', 2023, 1, 487, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.636665', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '812484100', 2023, 1, 639, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.636665', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '865749372', 2023, 1, 213, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.636665', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '848145367', 2023, 1, 342, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.636665', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '897513077', 2023, 1, 18, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.70235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '898230296', 2023, 1, 577, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.70235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '830853233', 2023, 1, 986, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.70235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '805517793', 2023, 1, 92, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.70235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '862719356', 2023, 1, 131, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.70235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '868747999', 2023, 1, 339, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.70235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '820061307', 2023, 1, 966, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.70235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '868124354', 2023, 1, 760, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.70235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '816123649', 2023, 1, 790, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.70235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '832157777', 2023, 1, 535, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.750501', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '831381830', 2023, 1, 156, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.750501', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '817029341', 2023, 1, 622, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.750501', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '883702404', 2023, 1, 719, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.750501', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '875251613', 2023, 1, 519, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.750501', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '888916707', 2023, 1, 542, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.750501', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '880687429', 2023, 1, 952, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.750501', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '887053356', 2023, 1, 302, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.813044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '851373027', 2023, 1, 655, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.813044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '884968539', 2023, 1, 832, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.813044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '899921613', 2023, 1, 419, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.813044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '817640200', 2023, 1, 655, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.813044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '869157440', 2023, 1, 369, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.813044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '824996698', 2023, 1, 24, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.813044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '841149048', 2023, 1, 539, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.861974', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '846124562', 2023, 1, 106, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.861974', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '820180026', 2023, 1, 439, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.861974', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '844702533', 2023, 1, 784, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.861974', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '812044855', 2023, 1, 208, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.861974', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '881840088', 2023, 1, 739, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.861974', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '810615966', 2023, 1, 150, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.861974', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '847652861', 2023, 1, 983, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.90954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '810293959', 2023, 1, 85, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.90954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '832883476', 2023, 1, 768, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.90954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '840867285', 2023, 1, 406, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.90954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '873422926', 2023, 1, 643, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.90954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '821884742', 2023, 1, 468, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.90954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '832848887', 2023, 1, 472, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.90954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '814238276', 2023, 1, 153, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.942148', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '806659673', 2023, 1, 148, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.942148', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '877303997', 2023, 1, 845, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.942148', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '809858203', 2023, 1, 462, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.942148', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '853630583', 2023, 1, 224, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.942148', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '897636323', 2023, 1, 264, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.974969', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '857342658', 2023, 1, 542, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.974969', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '852507509', 2023, 1, 507, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.974969', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '882645805', 2023, 1, 860, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.974969', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '875683015', 2023, 1, 879, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.974969', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '847572493', 2023, 1, 72, 12.8, 125, 1.5, false, '2023-09-01 13:02:34.974969', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '899524077', 2023, 1, 991, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.363185', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '825753154', 2023, 1, 388, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.381981', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '800252166', 2023, 1, 915, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.408576', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '822590034', 2023, 1, 175, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.408576', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '895035985', 2023, 1, 264, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.408576', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '843438328', 2023, 1, 988, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.442642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '834834978', 2023, 1, 428, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.442642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '891180633', 2023, 1, 454, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.442642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '830859003', 2023, 1, 196, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.442642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '874375031', 2023, 1, 471, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.475641', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '881509026', 2023, 1, 706, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.475641', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '800184390', 2023, 1, 648, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.475641', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '803113235', 2023, 1, 980, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.475641', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '811074684', 2023, 1, 70, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.475641', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '832601414', 2023, 1, 991, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.515917', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '839233927', 2023, 1, 206, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.515917', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '826379397', 2023, 1, 491, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.515917', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '886623624', 2023, 1, 370, 12.8, 125, 1.5, false, '2023-09-01 13:02:41.515917', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 7207.11265094491, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.174409');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 4868.67492580339, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '555555555', 4447.49440461809, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '840563951', 2709.48986075043, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '844028810', 9229.52350539426, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '879683085', 5374.03258906673, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '846468514', 2744.49521495695, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '833092794', 1935.80403200567, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '817549367', 1758.19608289914, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '881668649', 9894.19011642372, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '830704213', 4379.70188452087, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '828285204', 6551.96755248816, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '820874281', 2881.321078759, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '871838056', 1576.20554348518, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '801643853', 2438.14673912874, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '854308980', 8709.03262887706, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '857012601', 9684.0310104381, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '848910171', 5292.09478634341, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '872839692', 2375.98616844486, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '825863802', 3270.07517747913, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '817000325', 6992.68618423572, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.22305');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '839972893', 4774.56827699842, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.337961');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '832474989', 7081.10528556045, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.337961');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '896635459', 2204.47828562751, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.337961');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '886357004', 1736.53922803715, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.337961');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '885895116', 6748.92320186394, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '814487750', 6113.8240333958, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '831093512', 8930.89368617734, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '873745729', 6551.42777235989, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '820353273', 5250.74771907217, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '826836351', 5002.86307057234, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '856867915', 5951.6523573233, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '874511382', 2881.65618974478, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '821330635', 740.695013996311, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '846851318', 1088.561274705, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '811350402', 8545.69054422432, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '807612691', 2543.72223705782, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '850641118', 6985.45785602055, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '891617166', 8224.20757366051, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '845818867', 5963.3592230025, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '894851986', 516.672423320521, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '807618154', 4819.22065881188, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '872517152', 5184.80916092307, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '892101191', 7579.71354060839, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '801663204', 4970.15138617857, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.390666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '885577241', 2043.09745969543, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.522667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '826487665', 1235.52071134535, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.522667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '836121193', 1692.75493761456, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.522667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '816811477', 2168.12097143556, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.522667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '895694541', 6572.68918935446, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.522667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '873767750', 2556.39735221844, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.522667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '863317728', 3082.57228940223, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.522667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '843647618', 2241.74909189054, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '871864762', 8177.43066303822, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '887286152', 5522.26369217436, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '849595504', 1891.10552511633, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '852393167', 4931.52990135687, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '879883134', 9096.97872409454, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '866940889', 6889.29806561741, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '864958773', 3451.57109561941, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '859959251', 9491.30161505137, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '838372207', 4639.46439864288, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '896870431', 6449.04514611758, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '889345261', 4445.18612026824, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.576586');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '872514008', 6053.62096838948, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.65029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '825703551', 1684.09631680412, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.65029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '801524565', 7467.85930863658, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.65029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '819151355', 5547.73645348121, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.65029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '894794240', 2215.84309857752, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.65029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '863424096', 1787.87783172073, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.65029');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '849696997', 5697.8484027351, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.701074');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '835661484', 8198.12496838753, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.701074');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '895708763', 9285.58054187468, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.701074');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '814687293', 2424.33583627417, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.701074');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '892595718', 3765.81756943908, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.701074');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '893059597', 8947.74516886933, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.701074');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '833908963', 9775.87120683558, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.701074');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '879661736', 4785.33836352207, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.701074');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '819334264', 9815.69699610298, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.701074');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '868810378', 8773.89499366674, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.701074');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '848273724', 363.984063936231, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.750167');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '856704980', 163.643848388317, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.750167');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '870186667', 2501.33733112782, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.750167');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '805774066', 452.574599820718, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.750167');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '866450049', 290.384307257184, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.750167');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '887994003', 5747.95654629768, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.750167');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '842914169', 4367.4380269254, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.750167');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '848797491', 4467.20684123403, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.750167');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '807813627', 8033.32089474663, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.800724');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '834167604', 4209.47074475646, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.800724');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '874335732', 7911.23986683245, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.800724');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '826915711', 9645.30730495782, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.800724');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '835952962', 9019.12420641991, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.800724');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '830046194', 3020.84669274154, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.800724');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '859514340', 8634.12287559884, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.800724');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '870772243', 1093.71138050864, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.837342');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '801742803', 305.869851729829, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.837342');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '863629482', 5726.86787089079, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.837342');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '886623437', 9179.894311757, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.837342');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '879799300', 2900.57979696039, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.837342');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '877281898', 2644.70863474308, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.837342');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '853945949', 5548.92903274458, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.837342');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '894480080', 4016.95427214008, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.837342');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '870642221', 5625.21089068247, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.837342');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '893652131', 3964.19259531011, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.837342');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '878051746', 8935.76616379329, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.90909');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '823152176', 9306.23533459605, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.90909');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '810868617', 8884.51289105853, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.90909');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '850126521', 1412.6619561285, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.90909');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '833180535', 99.1586606542447, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.90909');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '876578552', 7573.18940159073, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.90909');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '847429997', 8765.37390376848, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.90909');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '861795773', 2510.06371194585, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.90909');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '878971899', 9859.46605053653, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.959633');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '816782600', 3976.90344538771, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.959633');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '861430193', 2042.8337602332, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.959633');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '867266177', 8248.51015624921, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.959633');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '877683962', 8456.95547215057, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.959633');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '802258475', 5282.94282075664, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.959633');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '804482256', 213.178466753564, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.959633');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '852236310', 5396.74533908015, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.959633');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '848766928', 2758.69022848896, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:31.959633');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '825056986', 1490.75240136722, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.025003');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '893417017', 5996.9872023014, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.025003');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '813307155', 1491.51659546993, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.025003');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '896289587', 1206.14901600921, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.025003');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '841791511', 9790.90049962468, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.025003');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '861597616', 7627.16561912176, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.069278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '890775982', 3540.26188995611, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.069278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '830479135', 4623.81289197926, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.069278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '870170432', 1182.22406522732, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.069278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '881974816', 6320.16972297967, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.069278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '821553355', 6532.88268612177, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.069278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '829730277', 7594.23979981528, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.069278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '868315277', 7686.24823192499, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.069278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '800039249', 8963.6885138197, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.069278');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '846412706', 775.673321868648, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.114102');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '884832900', 5710.35924328497, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.114102');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '808931289', 3406.16740224404, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.114102');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '861875368', 2467.46712137973, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.114102');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '862397552', 5630.29088575175, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.114102');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '821753952', 3979.10678242129, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.153382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '892729481', 7584.15530861225, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.153382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '802727698', 1845.05718557068, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.153382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '840096162', 4647.39684195855, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.153382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '888659470', 8786.00349896241, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.153382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '850200327', 3718.80288082667, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.153382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '861393944', 3257.33871734951, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.153382');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '833369082', 3752.96787351358, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.207477');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '899621957', 3796.33687914601, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.207477');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '870923918', 4005.73635059475, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.207477');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '817115960', 5799.10732338196, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.207477');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '872469548', 7685.2023926564, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.207477');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '887868763', 4139.05553825211, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.207477');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '855657326', 2709.35812728943, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.207477');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '860417684', 600.165966352139, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.261024');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '868128237', 810.564220962992, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.261024');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '857116596', 1708.27918142933, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.261024');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '895842997', 3994.2570827967, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.261024');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '801305726', 6072.34729708412, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.261024');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '892425810', 9303.88970513701, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.302972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '835327648', 8195.57269614827, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.302972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '853021452', 7772.99536666239, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.302972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '837365133', 149.67065377546, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.302972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '800482686', 1506.9547461036, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.302972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '897324044', 9378.37592796667, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.302972');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '835671490', 5634.96181488547, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.347463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '897991520', 5159.06584207142, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.347463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '876559691', 6231.23709007919, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.347463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '891356146', 5652.48213295242, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.347463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '892361559', 8670.50206688677, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.347463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '812573755', 9490.82434496171, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.347463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '846794321', 7845.74533722, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.347463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '836534690', 3068.10530572388, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.396094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '886609379', 7720.30779117617, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.396094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '892136879', 3808.20093663602, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.396094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '841281181', 129.982854002105, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.396094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '882825096', 9091.30474932254, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.396094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '888357366', 3710.79222553166, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.396094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '855595319', 162.458489483002, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.455619');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '824600423', 7830.08502040302, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.455619');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '830996379', 643.905516946548, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.455619');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '825154853', 4984.2587185776, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.455619');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '838584086', 2642.94675798964, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.455619');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '821020415', 9257.89763596988, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.455619');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '808632104', 4199.18258883366, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.455619');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '876011318', 9658.73436958562, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.515703');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '825580046', 2634.91858601841, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.515703');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '849162278', 2924.83787152085, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.515703');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '825633362', 5304.07395284511, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.515703');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '845385150', 362.97182578506, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.515703');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '870882127', 3275.21765719944, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.515703');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '815492716', 5205.30488161095, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.515703');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '823633253', 3962.16565848115, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.570974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '898182420', 8729.60136345898, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.570974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '859741138', 3989.93850568788, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.570974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '896451492', 508.271709439397, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.570974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '810860783', 7598.68077120879, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.570974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '830535540', 2741.52619711068, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.570974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '828662423', 259.600456277878, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.570974');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '879730471', 3565.66817735122, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.616745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '863677191', 3998.63063595414, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.616745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '821212732', 821.921500017775, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.616745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '894678259', 2064.36246005535, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.616745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '840608868', 5354.99642054249, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.616745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '896187288', 8821.81591741424, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.616745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '838721828', 1802.40870384588, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.616745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '856189591', 4533.30572820693, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.616745');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '876273878', 4634.24936465847, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.668572');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '861845076', 5641.13577184834, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.668572');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '885168462', 551.076028484645, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.668572');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '822194048', 7795.73574795182, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.668572');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '822247206', 6605.12033666423, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.668572');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '872772840', 5250.98061918946, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.668572');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '849349122', 4530.29803516573, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.713469');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '848678778', 1657.0183356228, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.713469');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '856425068', 5189.59871333701, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.713469');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '874049341', 5564.09434226138, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.713469');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '874858219', 3730.84728100862, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.713469');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '886351929', 8476.16923700155, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.713469');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '882682006', 4814.23083183864, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.713469');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '815979604', 6759.64124042431, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.772986');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '839386992', 467.861733605597, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.772986');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '857404113', 8652.53716488885, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.772986');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '869983436', 3680.60062751879, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.772986');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '878032565', 5701.76323974739, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.772986');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '819705126', 2260.21333301761, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.772986');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '845287728', 7472.79975438143, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.809413');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '860837701', 9378.51558274068, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.809413');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '875842181', 4880.69517322703, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.809413');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '804699906', 1272.93389731429, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.809413');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '823614948', 6282.00350587315, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.809413');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '862500476', 2158.86772873518, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.809413');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '809412443', 27.5387156306056, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.845348');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '828229131', 2747.54570651653, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.845348');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '801498562', 1474.22939653094, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.845348');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '873369415', 2709.46919870654, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.845348');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '895611299', 9346.07301523975, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.845348');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '841020642', 1190.38028114138, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.845348');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '824842469', 6577.79374132999, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.914101');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '879641976', 9112.80600956082, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.914101');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '865456582', 732.016835003359, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.914101');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '894482342', 5858.50749468105, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.914101');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '898371335', 8266.23867146333, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.914101');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '855496620', 2429.19916420183, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.914101');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '827673788', 7676.3043212865, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.989848');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '843554986', 9541.53971449057, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.989848');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '889779510', 6361.28311493714, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.989848');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '857354197', 4163.69399548985, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.989848');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '823773229', 6944.04124296491, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.989848');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '807707298', 9677.24141805843, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.989848');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '865421389', 6696.4231127238, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:32.989848');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '876063217', 9961.55513209332, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.077241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '895621261', 5152.72590532422, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.077241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '885492879', 5684.14285975785, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.077241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '894782357', 3318.88834182748, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.077241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '835084511', 3258.9511674395, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.077241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '861993774', 293.775845346327, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.077241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '889170847', 5835.22862251336, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.077241');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '828494499', 570.247697430077, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.124861');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '854202196', 4079.19781329723, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.124861');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '802742619', 1635.36551241403, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.124861');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '868404321', 4788.77621098366, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.124861');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '851956311', 8889.87998025186, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.124861');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '823334696', 1432.97436536591, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.124861');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '852790719', 1580.82908092124, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.124861');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '893629730', 6070.26143997157, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.124861');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '863813033', 7189.92277035891, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.124861');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '808618938', 4099.43340039166, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.164782');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '809260201', 2718.95117132097, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.164782');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '895819984', 2126.6015354889, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.164782');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '819657813', 1487.7614629638, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.164782');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '800224708', 751.892291036513, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.164782');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '806669485', 2986.65625015259, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.188757');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '880734391', 2852.68428701568, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.188757');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '828568610', 5809.72621177541, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.188757');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '823138132', 9902.45739761445, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.188757');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '817989278', 7329.42815390461, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.188757');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '802713634', 4226.43910997884, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.188757');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '807804577', 1993.66029636134, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.188757');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '848323171', 2569.94770497959, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.188757');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '832865945', 4487.1185157031, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.235856');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '860309060', 6192.35501432723, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.235856');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '814889148', 601.230573721849, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.235856');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '891572191', 3119.47466911618, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.235856');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '877218345', 4999.86421974408, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.235856');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '886724220', 1528.97329859356, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.26886');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '820530610', 2107.8528545325, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.26886');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '837535869', 1903.82349872333, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.26886');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '865065632', 7386.3014188506, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.26886');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '873542190', 3331.50690319637, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.26886');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '814804594', 1461.20158091054, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.26886');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '857056451', 5950.06309632666, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.26886');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '869737356', 8083.77866450986, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.26886');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '848200494', 7345.35733948123, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.330652');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '811656574', 2628.86684808615, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.330652');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '859300392', 6961.31831723531, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.330652');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '888201315', 1941.40499325506, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.330652');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '802642361', 9206.34242486147, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.371043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '895927960', 2141.94492806851, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.371043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '858574195', 8294.04574369656, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.371043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '836046143', 7490.24166991641, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.371043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '872682864', 7791.74177331121, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.371043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '868541833', 1064.18979821102, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.371043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '887162294', 179.89174482201, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.371043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '872722388', 6118.79343214556, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.371043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '856110013', 1722.55002008503, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.371043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '888356763', 5946.60555845797, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.421422');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '876598168', 2493.27501153351, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.421422');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '898292659', 4688.12809873523, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.421422');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '884348614', 4042.0430167204, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.421422');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '861893059', 4656.85946870523, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.421422');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '813576485', 8913.56644037636, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.421422');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '815615055', 6047.068250806, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.468585');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '851095336', 7430.31077794488, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.468585');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '839238424', 8576.67912969603, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.468585');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '802413011', 6199.72474767741, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.468585');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '860737507', 3037.95127159672, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.468585');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '870274950', 7705.16260930465, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.468585');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '848225721', 2951.49815313081, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.468585');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '869094505', 8134.45985283067, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.525008');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '820130498', 3753.11978278368, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.525008');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '890410982', 9770.76803257552, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.525008');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '808992454', 3793.82882994891, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.525008');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '884151600', 3767.43526171753, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.556225');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '853357327', 6323.90180869288, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.556225');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '816439848', 9903.53929073044, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.556225');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '884209909', 9669.96401671191, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.556225');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '899443571', 1868.28899686278, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.556225');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '866284751', 6956.14508717536, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.556225');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '880509861', 1284.55288690188, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.615931');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '849684760', 1109.95415529249, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.615931');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '828427862', 1379.40295767605, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.615931');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '806894844', 7865.77299828063, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.615931');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '814590821', 6712.43617197906, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.653327');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '837061530', 189.000315630805, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.653327');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '801554425', 9300.7111115516, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.653327');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '810074954', 6055.83205689456, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.653327');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '859766179', 1748.37078014798, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.681825');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '871799161', 2538.75772380247, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.681825');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '801976897', 2967.77700808578, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.681825');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '802585963', 9318.36757340664, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.681825');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '818337697', 1409.29463595786, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.681825');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '879951937', 1903.10082320503, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.681825');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '831001012', 1730.60940742136, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.714265');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '898847680', 4424.92593524063, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.714265');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '852996781', 9615.40293430829, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.714265');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '859568205', 9293.66359308349, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.714265');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '878298725', 1112.6749656761, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.753347');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '865500726', 2500.05874416487, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.753347');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '847800406', 2838.84357629497, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.753347');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '812585250', 6338.1352210019, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.753347');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '829630446', 908.759685615088, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.753347');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '878665958', 9406.22419469626, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.753347');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '867338166', 4951.31027090818, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.785879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '874303897', 1684.33406012711, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.785879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '815797440', 4854.10859682967, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.785879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '878302329', 7575.56219729996, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.785879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '814902719', 4613.89119618813, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.785879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '861928097', 7405.25178315673, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.823913');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '814214408', 4902.42176381909, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.823913');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '841446216', 2020.13850302499, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.823913');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '880913102', 3098.90933171207, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.823913');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '804954274', 8975.92272116722, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.823913');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '867602272', 4114.22038230144, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.823913');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '890907727', 4095.56318293956, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.887266');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '896522080', 1983.9309065337, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.887266');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '805655729', 9523.81297366581, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.887266');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '839500879', 4530.43005662009, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.887266');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '885869627', 5155.64010739318, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.887266');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '875445187', 9427.52927884841, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.943359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '813466439', 4739.92272670102, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.943359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '896623441', 8340.74913252014, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.943359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '808991850', 4987.4160689086, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.943359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '829507713', 4289.52669049974, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.943359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '833117254', 1842.13501898637, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.943359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '837846413', 3611.96277662936, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.943359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '869503803', 7039.49751420596, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:33.943359');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '883744480', 7542.88281572802, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.035964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '841681491', 4258.70441304202, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.035964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '804469736', 2926.67401795471, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.035964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '842580200', 3239.06661874551, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.035964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '867939301', 2305.26710536568, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.080249');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '846991517', 1223.15529523119, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.080249');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '849842492', 5359.04531932143, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.080249');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '892824713', 1254.25142614247, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.080249');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '871393874', 4569.77807225515, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.080249');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '838748341', 7093.10820394672, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.080249');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '852620240', 7242.34399548535, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.080249');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '810480871', 7030.23907172316, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.131027');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '836141850', 9769.14243870482, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.131027');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '813662987', 2221.93699526101, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.131027');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '874409446', 9600.62082496984, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.131027');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '882071110', 2159.39139010489, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.131027');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '831281285', 8003.1644185144, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.167919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '812422244', 2831.75474849845, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.167919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '877641955', 4260.79694513453, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.167919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '849832913', 7331.74520542692, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.167919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '878265524', 6321.97872684497, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.167919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '862385530', 9338.00107787003, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.167919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '832873358', 5642.07618201137, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.167919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '865506081', 1635.22222153054, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.167919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '862694712', 3378.35555545208, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.207953');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '808556476', 8871.36614207764, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.207953');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '809785402', 3842.72922624408, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.207953');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '820464657', 8416.77664049908, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.207953');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '806453016', 4134.17231591361, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.207953');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '855109259', 3171.9913269831, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.245111');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '844136610', 9718.56620160088, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.245111');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '868437705', 1402.93296962065, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.245111');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '805414233', 8062.4451654961, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.245111');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '843122242', 7589.90538399669, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.245111');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '880436983', 9207.8766335812, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.245111');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '877619067', 456.411004243743, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.245111');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '825656069', 1808.50564999191, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.292372');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '809247535', 2226.13439143525, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.292372');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '850902238', 4336.38882453954, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.292372');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '805065367', 1471.35289681237, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.292372');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '884103260', 3233.3209650742, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.292372');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '896185086', 6156.97418187259, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.292372');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '879147472', 7367.15525110368, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.33194');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '859469327', 9945.53437889386, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.33194');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '809021214', 8007.14625248765, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.33194');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '890441272', 5906.29466341116, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.33194');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '843918726', 7106.82461103549, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.33194');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '867010071', 1215.57697114014, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.33194');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '899491325', 447.298973620569, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.33194');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '817860197', 2198.3220932343, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.381527');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '894342532', 357.84253564273, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.381527');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '832677042', 828.125253435531, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.381527');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '886394237', 5691.08718570497, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.381527');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '872624587', 5050.24457269437, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.381527');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '898866641', 6398.4465750201, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.381527');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '884853942', 5209.44005849804, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.431498');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '819545829', 9594.51209133749, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.431498');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '833817902', 6984.41078927193, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.431498');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '885642137', 5185.6828685393, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.431498');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '896711412', 4717.33130919236, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.431498');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '821835062', 9447.76275917315, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.431498');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '870037842', 6149.22262388847, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.431498');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '817185565', 7445.30954711655, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.480041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '867521592', 2719.73513344567, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.480041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '877585722', 2577.36139249194, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.480041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '834435277', 6509.04064295951, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.480041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '822051894', 2423.76478604533, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.480041');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '833917059', 7333.04554246574, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.516867');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '845980869', 5994.5874643123, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.516867');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '855519631', 6648.31537577839, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.516867');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '831415125', 4431.33525964782, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.516867');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '846728931', 1641.08553663499, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.516867');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '848471580', 2280.39598006695, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.557368');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '873734324', 7364.41067856017, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.557368');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '857680633', 7459.15310229494, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.557368');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '835913918', 4298.38275288992, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.557368');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '857383092', 7358.53817709021, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.630971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '839907680', 8662.00977761075, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.630971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '825019259', 3379.21964420145, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.630971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '812484100', 8994.80329668808, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.630971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '865749372', 5140.01072848646, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.630971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '848145367', 4072.09526114624, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.630971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '897513077', 2373.45318907877, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.684386');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '898230296', 847.341669240057, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.684386');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '830853233', 3365.90315915985, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.684386');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '805517793', 6086.74794077751, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.684386');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '862719356', 1904.93051222307, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.684386');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '868747999', 9202.30629569976, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.684386');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '820061307', 784.388000158571, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.684386');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '868124354', 9345.32341422082, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.684386');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '816123649', 249.90831403026, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.684386');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '832157777', 7018.54980689833, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.731823');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '831381830', 9546.22947269195, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.731823');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '817029341', 9412.46875087504, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.731823');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '883702404', 6820.5769076034, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.731823');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '875251613', 1963.0088773711, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.731823');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '888916707', 1622.63737723855, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.731823');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '880687429', 3157.82077238418, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.731823');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '887053356', 5366.30685357066, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.800542');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '851373027', 5898.6814043815, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.800542');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '884968539', 7430.38193324784, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.800542');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '899921613', 5207.07335244093, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.800542');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '817640200', 927.309548405013, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.800542');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '869157440', 4355.86590877039, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.800542');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '824996698', 5588.66077113539, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.800542');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '841149048', 1659.60205759029, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.851336');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '846124562', 8906.68609226241, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.851336');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '820180026', 8447.87882947857, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.851336');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '844702533', 934.654867452911, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.851336');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '812044855', 2334.47864546589, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.851336');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '881840088', 4756.65977886201, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.851336');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '810615966', 993.247014932985, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.851336');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '847652861', 5204.78139821019, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.894009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '810293959', 927.366889959342, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.894009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '832883476', 1501.08768071247, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.894009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '840867285', 7619.75127833521, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.894009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '873422926', 984.916046208289, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.894009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '821884742', 3783.96793448841, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.894009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '832848887', 572.457950543701, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.894009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '814238276', 3412.78616672242, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.93625');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '806659673', 6921.5296830759, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.93625');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '877303997', 2970.21239197545, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.93625');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '809858203', 8896.90075474299, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.93625');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '853630583', 4455.3316167034, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.93625');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '897636323', 9353.32947320721, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.963195');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '857342658', 8205.03906811837, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.963195');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '852507509', 3204.4146613309, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.963195');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '882645805', 7689.37034973019, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.963195');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '875683015', 8402.30862770067, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.963195');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '847572493', 9093.83672277069, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:34.963195');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '899524077', 2660.45953725699, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.356878');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '825753154', 3564.24370476238, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.377824');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '800252166', 9593.69707411536, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.400261');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '822590034', 9116.31337208233, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.400261');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '895035985', 7991.42845544384, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.400261');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '843438328', 3590.30416011417, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.434173');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '834834978', 7658.93808096819, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.434173');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '891180633', 1961.53181205408, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.434173');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '830859003', 7264.62422206737, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.434173');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '874375031', 2180.24679812913, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.468919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '881509026', 5679.50856976007, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.468919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '800184390', 2124.34749744914, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.468919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '803113235', 4815.45957608487, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.468919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '811074684', 3415.7441962434, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.468919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '832601414', 6931.71614978951, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.503815');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '839233927', 6975.5388497769, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.503815');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '826379397', 857.578227286695, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.503815');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '886623624', 4149.11925341734, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-09-01 13:02:41.503815');


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:05.204569', '2023-09-01 13:02:05.204569');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:05.524951', '2023-09-01 13:02:05.524951');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:05.574158', '2023-09-01 13:02:05.574158');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:05.630712', '2023-09-01 13:02:05.630712');
INSERT INTO public.virksomhet VALUES (5, '847754454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847754454', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:05.942925', '2023-09-01 13:02:05.942925');
INSERT INTO public.virksomhet VALUES (6, '840563951', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840563951', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:05.983813', '2023-09-01 13:02:05.983813');
INSERT INTO public.virksomhet VALUES (7, '844028810', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844028810', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.03394', '2023-09-01 13:02:06.03394');
INSERT INTO public.virksomhet VALUES (8, '879683085', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879683085', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.081666', '2023-09-01 13:02:06.081666');
INSERT INTO public.virksomhet VALUES (9, '846468514', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846468514', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.141524', '2023-09-01 13:02:06.141524');
INSERT INTO public.virksomhet VALUES (10, '833092794', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833092794', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.182563', '2023-09-01 13:02:06.182563');
INSERT INTO public.virksomhet VALUES (11, '817549367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817549367', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.215112', '2023-09-01 13:02:06.215112');
INSERT INTO public.virksomhet VALUES (12, '881668649', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881668649', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.25549', '2023-09-01 13:02:06.25549');
INSERT INTO public.virksomhet VALUES (13, '830704213', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830704213', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.308765', '2023-09-01 13:02:06.308765');
INSERT INTO public.virksomhet VALUES (14, '828285204', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828285204', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.371132', '2023-09-01 13:02:06.371132');
INSERT INTO public.virksomhet VALUES (15, '820874281', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820874281', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.412766', '2023-09-01 13:02:06.412766');
INSERT INTO public.virksomhet VALUES (16, '871838056', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871838056', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.472152', '2023-09-01 13:02:06.472152');
INSERT INTO public.virksomhet VALUES (17, '801643853', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801643853', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.537445', '2023-09-01 13:02:06.537445');
INSERT INTO public.virksomhet VALUES (18, '854308980', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854308980', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.584115', '2023-09-01 13:02:06.584115');
INSERT INTO public.virksomhet VALUES (19, '857012601', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857012601', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.621513', '2023-09-01 13:02:06.621513');
INSERT INTO public.virksomhet VALUES (20, '848910171', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848910171', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.664085', '2023-09-01 13:02:06.664085');
INSERT INTO public.virksomhet VALUES (21, '872839692', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872839692', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.713507', '2023-09-01 13:02:06.713507');
INSERT INTO public.virksomhet VALUES (22, '825863802', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825863802', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.770945', '2023-09-01 13:02:06.770945');
INSERT INTO public.virksomhet VALUES (23, '817000325', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817000325', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.823171', '2023-09-01 13:02:06.823171');
INSERT INTO public.virksomhet VALUES (24, '839972893', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839972893', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.889613', '2023-09-01 13:02:06.889613');
INSERT INTO public.virksomhet VALUES (25, '832474989', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832474989', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.942675', '2023-09-01 13:02:06.942675');
INSERT INTO public.virksomhet VALUES (26, '896635459', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896635459', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:06.989402', '2023-09-01 13:02:06.989402');
INSERT INTO public.virksomhet VALUES (27, '886357004', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886357004', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.040356', '2023-09-01 13:02:07.040356');
INSERT INTO public.virksomhet VALUES (28, '885895116', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885895116', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.084166', '2023-09-01 13:02:07.084166');
INSERT INTO public.virksomhet VALUES (29, '814487750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814487750', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.151291', '2023-09-01 13:02:07.151291');
INSERT INTO public.virksomhet VALUES (30, '831093512', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831093512', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.197195', '2023-09-01 13:02:07.197195');
INSERT INTO public.virksomhet VALUES (31, '873745729', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873745729', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.238565', '2023-09-01 13:02:07.238565');
INSERT INTO public.virksomhet VALUES (32, '820353273', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820353273', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.504244', '2023-09-01 13:02:07.504244');
INSERT INTO public.virksomhet VALUES (33, '826836351', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826836351', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.581122', '2023-09-01 13:02:07.581122');
INSERT INTO public.virksomhet VALUES (34, '856867915', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856867915', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.680213', '2023-09-01 13:02:07.680213');
INSERT INTO public.virksomhet VALUES (35, '874511382', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874511382', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.735043', '2023-09-01 13:02:07.735043');
INSERT INTO public.virksomhet VALUES (36, '821330635', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821330635', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.855308', '2023-09-01 13:02:07.855308');
INSERT INTO public.virksomhet VALUES (37, '846851318', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846851318', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.891987', '2023-09-01 13:02:07.891987');
INSERT INTO public.virksomhet VALUES (38, '811350402', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811350402', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.946799', '2023-09-01 13:02:07.946799');
INSERT INTO public.virksomhet VALUES (39, '807612691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807612691', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:07.982947', '2023-09-01 13:02:07.982947');
INSERT INTO public.virksomhet VALUES (40, '850641118', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850641118', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.025025', '2023-09-01 13:02:08.025025');
INSERT INTO public.virksomhet VALUES (41, '891617166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891617166', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.084397', '2023-09-01 13:02:08.084397');
INSERT INTO public.virksomhet VALUES (42, '845818867', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845818867', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.130935', '2023-09-01 13:02:08.130935');
INSERT INTO public.virksomhet VALUES (43, '894851986', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894851986', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.168509', '2023-09-01 13:02:08.168509');
INSERT INTO public.virksomhet VALUES (44, '807618154', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807618154', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.21847', '2023-09-01 13:02:08.21847');
INSERT INTO public.virksomhet VALUES (45, '872517152', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872517152', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.274653', '2023-09-01 13:02:08.274653');
INSERT INTO public.virksomhet VALUES (46, '892101191', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892101191', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.322345', '2023-09-01 13:02:08.322345');
INSERT INTO public.virksomhet VALUES (47, '801663204', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801663204', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.364245', '2023-09-01 13:02:08.364245');
INSERT INTO public.virksomhet VALUES (48, '885577241', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885577241', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.40312', '2023-09-01 13:02:08.40312');
INSERT INTO public.virksomhet VALUES (49, '826487665', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826487665', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.461972', '2023-09-01 13:02:08.461972');
INSERT INTO public.virksomhet VALUES (50, '836121193', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836121193', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.525679', '2023-09-01 13:02:08.525679');
INSERT INTO public.virksomhet VALUES (51, '816811477', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816811477', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.599933', '2023-09-01 13:02:08.599933');
INSERT INTO public.virksomhet VALUES (52, '895694541', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895694541', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.642612', '2023-09-01 13:02:08.642612');
INSERT INTO public.virksomhet VALUES (53, '873767750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873767750', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.689361', '2023-09-01 13:02:08.689361');
INSERT INTO public.virksomhet VALUES (54, '863317728', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863317728', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.732238', '2023-09-01 13:02:08.732238');
INSERT INTO public.virksomhet VALUES (55, '843647618', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843647618', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.770625', '2023-09-01 13:02:08.770625');
INSERT INTO public.virksomhet VALUES (56, '871864762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871864762', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.815458', '2023-09-01 13:02:08.815458');
INSERT INTO public.virksomhet VALUES (57, '887286152', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887286152', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.86589', '2023-09-01 13:02:08.86589');
INSERT INTO public.virksomhet VALUES (58, '849595504', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849595504', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.900524', '2023-09-01 13:02:08.900524');
INSERT INTO public.virksomhet VALUES (59, '852393167', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852393167', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:08.95116', '2023-09-01 13:02:08.95116');
INSERT INTO public.virksomhet VALUES (60, '879883134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879883134', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.023562', '2023-09-01 13:02:09.023562');
INSERT INTO public.virksomhet VALUES (61, '866940889', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866940889', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.072225', '2023-09-01 13:02:09.072225');
INSERT INTO public.virksomhet VALUES (62, '864958773', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864958773', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.15755', '2023-09-01 13:02:09.15755');
INSERT INTO public.virksomhet VALUES (63, '859959251', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859959251', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.195699', '2023-09-01 13:02:09.195699');
INSERT INTO public.virksomhet VALUES (64, '838372207', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838372207', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.240883', '2023-09-01 13:02:09.240883');
INSERT INTO public.virksomhet VALUES (65, '896870431', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896870431', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.266692', '2023-09-01 13:02:09.266692');
INSERT INTO public.virksomhet VALUES (66, '889345261', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889345261', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.291327', '2023-09-01 13:02:09.291327');
INSERT INTO public.virksomhet VALUES (67, '872514008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872514008', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.331768', '2023-09-01 13:02:09.331768');
INSERT INTO public.virksomhet VALUES (68, '825703551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825703551', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.370524', '2023-09-01 13:02:09.370524');
INSERT INTO public.virksomhet VALUES (69, '801524565', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801524565', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.407343', '2023-09-01 13:02:09.407343');
INSERT INTO public.virksomhet VALUES (70, '819151355', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819151355', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.450794', '2023-09-01 13:02:09.450794');
INSERT INTO public.virksomhet VALUES (71, '894794240', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894794240', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.488262', '2023-09-01 13:02:09.488262');
INSERT INTO public.virksomhet VALUES (72, '863424096', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863424096', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.519809', '2023-09-01 13:02:09.519809');
INSERT INTO public.virksomhet VALUES (73, '849696997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849696997', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.567368', '2023-09-01 13:02:09.567368');
INSERT INTO public.virksomhet VALUES (74, '835661484', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835661484', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.618693', '2023-09-01 13:02:09.618693');
INSERT INTO public.virksomhet VALUES (75, '895708763', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895708763', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.665496', '2023-09-01 13:02:09.665496');
INSERT INTO public.virksomhet VALUES (76, '814687293', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814687293', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.709184', '2023-09-01 13:02:09.709184');
INSERT INTO public.virksomhet VALUES (77, '892595718', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892595718', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.754839', '2023-09-01 13:02:09.754839');
INSERT INTO public.virksomhet VALUES (78, '893059597', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893059597', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.806204', '2023-09-01 13:02:09.806204');
INSERT INTO public.virksomhet VALUES (79, '833908963', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833908963', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.85015', '2023-09-01 13:02:09.85015');
INSERT INTO public.virksomhet VALUES (80, '879661736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879661736', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.885103', '2023-09-01 13:02:09.885103');
INSERT INTO public.virksomhet VALUES (81, '819334264', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819334264', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.936435', '2023-09-01 13:02:09.936435');
INSERT INTO public.virksomhet VALUES (82, '868810378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868810378', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:09.979831', '2023-09-01 13:02:09.979831');
INSERT INTO public.virksomhet VALUES (83, '848273724', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848273724', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.018234', '2023-09-01 13:02:10.018234');
INSERT INTO public.virksomhet VALUES (84, '856704980', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856704980', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.060748', '2023-09-01 13:02:10.060748');
INSERT INTO public.virksomhet VALUES (85, '870186667', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870186667', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.086517', '2023-09-01 13:02:10.086517');
INSERT INTO public.virksomhet VALUES (86, '805774066', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805774066', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.117375', '2023-09-01 13:02:10.117375');
INSERT INTO public.virksomhet VALUES (87, '866450049', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866450049', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.17092', '2023-09-01 13:02:10.17092');
INSERT INTO public.virksomhet VALUES (88, '887994003', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887994003', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.203757', '2023-09-01 13:02:10.203757');
INSERT INTO public.virksomhet VALUES (89, '842914169', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842914169', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.236711', '2023-09-01 13:02:10.236711');
INSERT INTO public.virksomhet VALUES (90, '848797491', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848797491', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.275831', '2023-09-01 13:02:10.275831');
INSERT INTO public.virksomhet VALUES (91, '807813627', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807813627', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.304939', '2023-09-01 13:02:10.304939');
INSERT INTO public.virksomhet VALUES (92, '834167604', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834167604', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.339583', '2023-09-01 13:02:10.339583');
INSERT INTO public.virksomhet VALUES (93, '874335732', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874335732', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.374404', '2023-09-01 13:02:10.374404');
INSERT INTO public.virksomhet VALUES (94, '826915711', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826915711', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.400292', '2023-09-01 13:02:10.400292');
INSERT INTO public.virksomhet VALUES (95, '835952962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835952962', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.43182', '2023-09-01 13:02:10.43182');
INSERT INTO public.virksomhet VALUES (96, '830046194', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830046194', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.454327', '2023-09-01 13:02:10.454327');
INSERT INTO public.virksomhet VALUES (97, '859514340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859514340', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.513195', '2023-09-01 13:02:10.513195');
INSERT INTO public.virksomhet VALUES (98, '870772243', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870772243', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.555873', '2023-09-01 13:02:10.555873');
INSERT INTO public.virksomhet VALUES (99, '801742803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801742803', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.594469', '2023-09-01 13:02:10.594469');
INSERT INTO public.virksomhet VALUES (100, '863629482', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863629482', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.632595', '2023-09-01 13:02:10.632595');
INSERT INTO public.virksomhet VALUES (101, '886623437', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886623437', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.658894', '2023-09-01 13:02:10.658894');
INSERT INTO public.virksomhet VALUES (102, '879799300', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879799300', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.690803', '2023-09-01 13:02:10.690803');
INSERT INTO public.virksomhet VALUES (103, '877281898', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877281898', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.718396', '2023-09-01 13:02:10.718396');
INSERT INTO public.virksomhet VALUES (104, '853945949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853945949', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.751654', '2023-09-01 13:02:10.751654');
INSERT INTO public.virksomhet VALUES (105, '894480080', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894480080', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.782004', '2023-09-01 13:02:10.782004');
INSERT INTO public.virksomhet VALUES (106, '870642221', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870642221', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.828701', '2023-09-01 13:02:10.828701');
INSERT INTO public.virksomhet VALUES (107, '893652131', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893652131', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.859713', '2023-09-01 13:02:10.859713');
INSERT INTO public.virksomhet VALUES (108, '878051746', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878051746', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.895572', '2023-09-01 13:02:10.895572');
INSERT INTO public.virksomhet VALUES (109, '823152176', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823152176', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.934162', '2023-09-01 13:02:10.934162');
INSERT INTO public.virksomhet VALUES (110, '810868617', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810868617', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:10.985271', '2023-09-01 13:02:10.985271');
INSERT INTO public.virksomhet VALUES (111, '850126521', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850126521', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.035241', '2023-09-01 13:02:11.035241');
INSERT INTO public.virksomhet VALUES (112, '833180535', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833180535', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.068984', '2023-09-01 13:02:11.068984');
INSERT INTO public.virksomhet VALUES (113, '876578552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876578552', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.111538', '2023-09-01 13:02:11.111538');
INSERT INTO public.virksomhet VALUES (114, '847429997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847429997', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.155884', '2023-09-01 13:02:11.155884');
INSERT INTO public.virksomhet VALUES (115, '861795773', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861795773', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.197572', '2023-09-01 13:02:11.197572');
INSERT INTO public.virksomhet VALUES (116, '878971899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878971899', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.228702', '2023-09-01 13:02:11.228702');
INSERT INTO public.virksomhet VALUES (117, '816782600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816782600', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.264577', '2023-09-01 13:02:11.264577');
INSERT INTO public.virksomhet VALUES (118, '861430193', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861430193', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.29884', '2023-09-01 13:02:11.29884');
INSERT INTO public.virksomhet VALUES (119, '867266177', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867266177', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.337178', '2023-09-01 13:02:11.337178');
INSERT INTO public.virksomhet VALUES (120, '877683962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877683962', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.375034', '2023-09-01 13:02:11.375034');
INSERT INTO public.virksomhet VALUES (121, '802258475', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802258475', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.421489', '2023-09-01 13:02:11.421489');
INSERT INTO public.virksomhet VALUES (122, '804482256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804482256', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.454938', '2023-09-01 13:02:11.454938');
INSERT INTO public.virksomhet VALUES (123, '852236310', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852236310', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.482177', '2023-09-01 13:02:11.482177');
INSERT INTO public.virksomhet VALUES (124, '848766928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848766928', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.533447', '2023-09-01 13:02:11.533447');
INSERT INTO public.virksomhet VALUES (125, '825056986', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825056986', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.562817', '2023-09-01 13:02:11.562817');
INSERT INTO public.virksomhet VALUES (126, '893417017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893417017', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.602682', '2023-09-01 13:02:11.602682');
INSERT INTO public.virksomhet VALUES (127, '813307155', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813307155', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.636423', '2023-09-01 13:02:11.636423');
INSERT INTO public.virksomhet VALUES (128, '896289587', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896289587', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.689908', '2023-09-01 13:02:11.689908');
INSERT INTO public.virksomhet VALUES (129, '841791511', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841791511', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.733902', '2023-09-01 13:02:11.733902');
INSERT INTO public.virksomhet VALUES (130, '861597616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861597616', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.76597', '2023-09-01 13:02:11.76597');
INSERT INTO public.virksomhet VALUES (131, '890775982', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890775982', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.798674', '2023-09-01 13:02:11.798674');
INSERT INTO public.virksomhet VALUES (132, '830479135', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830479135', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.830855', '2023-09-01 13:02:11.830855');
INSERT INTO public.virksomhet VALUES (133, '870170432', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870170432', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.856582', '2023-09-01 13:02:11.856582');
INSERT INTO public.virksomhet VALUES (134, '881974816', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881974816', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.894304', '2023-09-01 13:02:11.894304');
INSERT INTO public.virksomhet VALUES (135, '821553355', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821553355', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.920527', '2023-09-01 13:02:11.920527');
INSERT INTO public.virksomhet VALUES (136, '829730277', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829730277', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:11.962411', '2023-09-01 13:02:11.962411');
INSERT INTO public.virksomhet VALUES (137, '868315277', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868315277', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.010925', '2023-09-01 13:02:12.010925');
INSERT INTO public.virksomhet VALUES (138, '800039249', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800039249', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.049829', '2023-09-01 13:02:12.049829');
INSERT INTO public.virksomhet VALUES (139, '846412706', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846412706', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.073392', '2023-09-01 13:02:12.073392');
INSERT INTO public.virksomhet VALUES (140, '884832900', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884832900', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.106965', '2023-09-01 13:02:12.106965');
INSERT INTO public.virksomhet VALUES (141, '808931289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808931289', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.168779', '2023-09-01 13:02:12.168779');
INSERT INTO public.virksomhet VALUES (142, '861875368', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861875368', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.207174', '2023-09-01 13:02:12.207174');
INSERT INTO public.virksomhet VALUES (143, '862397552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862397552', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.238983', '2023-09-01 13:02:12.238983');
INSERT INTO public.virksomhet VALUES (144, '821753952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821753952', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.282985', '2023-09-01 13:02:12.282985');
INSERT INTO public.virksomhet VALUES (145, '892729481', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892729481', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.329537', '2023-09-01 13:02:12.329537');
INSERT INTO public.virksomhet VALUES (146, '802727698', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802727698', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.365194', '2023-09-01 13:02:12.365194');
INSERT INTO public.virksomhet VALUES (147, '840096162', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840096162', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.388393', '2023-09-01 13:02:12.388393');
INSERT INTO public.virksomhet VALUES (148, '888659470', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888659470', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.428412', '2023-09-01 13:02:12.428412');
INSERT INTO public.virksomhet VALUES (149, '850200327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850200327', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.480704', '2023-09-01 13:02:12.480704');
INSERT INTO public.virksomhet VALUES (150, '861393944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861393944', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.519816', '2023-09-01 13:02:12.519816');
INSERT INTO public.virksomhet VALUES (151, '833369082', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833369082', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.557955', '2023-09-01 13:02:12.557955');
INSERT INTO public.virksomhet VALUES (152, '899621957', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899621957', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.589365', '2023-09-01 13:02:12.589365');
INSERT INTO public.virksomhet VALUES (153, '870923918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870923918', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.620396', '2023-09-01 13:02:12.620396');
INSERT INTO public.virksomhet VALUES (154, '817115960', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817115960', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.689833', '2023-09-01 13:02:12.689833');
INSERT INTO public.virksomhet VALUES (155, '872469548', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872469548', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.774785', '2023-09-01 13:02:12.774785');
INSERT INTO public.virksomhet VALUES (156, '887868763', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887868763', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.814585', '2023-09-01 13:02:12.814585');
INSERT INTO public.virksomhet VALUES (157, '855657326', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855657326', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.854169', '2023-09-01 13:02:12.854169');
INSERT INTO public.virksomhet VALUES (158, '860417684', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860417684', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.880018', '2023-09-01 13:02:12.880018');
INSERT INTO public.virksomhet VALUES (159, '868128237', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868128237', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.912287', '2023-09-01 13:02:12.912287');
INSERT INTO public.virksomhet VALUES (160, '857116596', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857116596', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.949094', '2023-09-01 13:02:12.949094');
INSERT INTO public.virksomhet VALUES (161, '895842997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895842997', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:12.9988', '2023-09-01 13:02:12.9988');
INSERT INTO public.virksomhet VALUES (162, '801305726', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801305726', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.032273', '2023-09-01 13:02:13.032273');
INSERT INTO public.virksomhet VALUES (163, '892425810', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892425810', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.0586', '2023-09-01 13:02:13.0586');
INSERT INTO public.virksomhet VALUES (164, '835327648', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835327648', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.096759', '2023-09-01 13:02:13.096759');
INSERT INTO public.virksomhet VALUES (165, '853021452', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853021452', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.135543', '2023-09-01 13:02:13.135543');
INSERT INTO public.virksomhet VALUES (166, '837365133', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837365133', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.158656', '2023-09-01 13:02:13.158656');
INSERT INTO public.virksomhet VALUES (167, '800482686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800482686', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.200504', '2023-09-01 13:02:13.200504');
INSERT INTO public.virksomhet VALUES (168, '897324044', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897324044', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.228572', '2023-09-01 13:02:13.228572');
INSERT INTO public.virksomhet VALUES (169, '835671490', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835671490', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.267377', '2023-09-01 13:02:13.267377');
INSERT INTO public.virksomhet VALUES (170, '897991520', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897991520', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.335764', '2023-09-01 13:02:13.335764');
INSERT INTO public.virksomhet VALUES (171, '876559691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876559691', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.405534', '2023-09-01 13:02:13.405534');
INSERT INTO public.virksomhet VALUES (172, '891356146', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891356146', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.472828', '2023-09-01 13:02:13.472828');
INSERT INTO public.virksomhet VALUES (173, '892361559', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892361559', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.520884', '2023-09-01 13:02:13.520884');
INSERT INTO public.virksomhet VALUES (174, '812573755', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812573755', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.576213', '2023-09-01 13:02:13.576213');
INSERT INTO public.virksomhet VALUES (175, '846794321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846794321', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.636604', '2023-09-01 13:02:13.636604');
INSERT INTO public.virksomhet VALUES (176, '836534690', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836534690', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.683009', '2023-09-01 13:02:13.683009');
INSERT INTO public.virksomhet VALUES (177, '886609379', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886609379', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.734881', '2023-09-01 13:02:13.734881');
INSERT INTO public.virksomhet VALUES (178, '892136879', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892136879', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.786795', '2023-09-01 13:02:13.786795');
INSERT INTO public.virksomhet VALUES (179, '841281181', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841281181', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.826177', '2023-09-01 13:02:13.826177');
INSERT INTO public.virksomhet VALUES (180, '882825096', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882825096', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.870082', '2023-09-01 13:02:13.870082');
INSERT INTO public.virksomhet VALUES (181, '888357366', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888357366', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.918299', '2023-09-01 13:02:13.918299');
INSERT INTO public.virksomhet VALUES (182, '855595319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855595319', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:13.97193', '2023-09-01 13:02:13.97193');
INSERT INTO public.virksomhet VALUES (183, '824600423', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824600423', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.056232', '2023-09-01 13:02:14.056232');
INSERT INTO public.virksomhet VALUES (184, '830996379', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830996379', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.117993', '2023-09-01 13:02:14.117993');
INSERT INTO public.virksomhet VALUES (185, '825154853', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825154853', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.182475', '2023-09-01 13:02:14.182475');
INSERT INTO public.virksomhet VALUES (186, '838584086', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838584086', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.352123', '2023-09-01 13:02:14.352123');
INSERT INTO public.virksomhet VALUES (187, '821020415', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821020415', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.450885', '2023-09-01 13:02:14.450885');
INSERT INTO public.virksomhet VALUES (188, '808632104', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808632104', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.590259', '2023-09-01 13:02:14.590259');
INSERT INTO public.virksomhet VALUES (189, '876011318', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876011318', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.682037', '2023-09-01 13:02:14.682037');
INSERT INTO public.virksomhet VALUES (190, '825580046', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825580046', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.726098', '2023-09-01 13:02:14.726098');
INSERT INTO public.virksomhet VALUES (191, '849162278', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849162278', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.776799', '2023-09-01 13:02:14.776799');
INSERT INTO public.virksomhet VALUES (192, '825633362', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825633362', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.830352', '2023-09-01 13:02:14.830352');
INSERT INTO public.virksomhet VALUES (193, '845385150', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845385150', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.883679', '2023-09-01 13:02:14.883679');
INSERT INTO public.virksomhet VALUES (194, '870882127', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870882127', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.936118', '2023-09-01 13:02:14.936118');
INSERT INTO public.virksomhet VALUES (195, '815492716', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815492716', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:14.992103', '2023-09-01 13:02:14.992103');
INSERT INTO public.virksomhet VALUES (196, '823633253', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823633253', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.030716', '2023-09-01 13:02:15.030716');
INSERT INTO public.virksomhet VALUES (197, '898182420', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898182420', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.070158', '2023-09-01 13:02:15.070158');
INSERT INTO public.virksomhet VALUES (198, '859741138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859741138', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.118086', '2023-09-01 13:02:15.118086');
INSERT INTO public.virksomhet VALUES (199, '896451492', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896451492', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.167407', '2023-09-01 13:02:15.167407');
INSERT INTO public.virksomhet VALUES (200, '810860783', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810860783', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.224214', '2023-09-01 13:02:15.224214');
INSERT INTO public.virksomhet VALUES (201, '830535540', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830535540', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.261747', '2023-09-01 13:02:15.261747');
INSERT INTO public.virksomhet VALUES (202, '828662423', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828662423', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.297322', '2023-09-01 13:02:15.297322');
INSERT INTO public.virksomhet VALUES (203, '879730471', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879730471', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.361986', '2023-09-01 13:02:15.361986');
INSERT INTO public.virksomhet VALUES (204, '863677191', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863677191', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.441043', '2023-09-01 13:02:15.441043');
INSERT INTO public.virksomhet VALUES (205, '821212732', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821212732', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.680427', '2023-09-01 13:02:15.680427');
INSERT INTO public.virksomhet VALUES (206, '894678259', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894678259', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.70919', '2023-09-01 13:02:15.70919');
INSERT INTO public.virksomhet VALUES (207, '840608868', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840608868', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.748893', '2023-09-01 13:02:15.748893');
INSERT INTO public.virksomhet VALUES (208, '896187288', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896187288', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.791363', '2023-09-01 13:02:15.791363');
INSERT INTO public.virksomhet VALUES (209, '838721828', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838721828', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.836876', '2023-09-01 13:02:15.836876');
INSERT INTO public.virksomhet VALUES (210, '856189591', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856189591', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.884068', '2023-09-01 13:02:15.884068');
INSERT INTO public.virksomhet VALUES (211, '876273878', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876273878', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.935025', '2023-09-01 13:02:15.935025');
INSERT INTO public.virksomhet VALUES (212, '861845076', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861845076', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:15.984243', '2023-09-01 13:02:15.984243');
INSERT INTO public.virksomhet VALUES (213, '885168462', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885168462', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.018733', '2023-09-01 13:02:16.018733');
INSERT INTO public.virksomhet VALUES (214, '822194048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822194048', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.0665', '2023-09-01 13:02:16.0665');
INSERT INTO public.virksomhet VALUES (215, '822247206', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822247206', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.100134', '2023-09-01 13:02:16.100134');
INSERT INTO public.virksomhet VALUES (216, '872772840', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872772840', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.141745', '2023-09-01 13:02:16.141745');
INSERT INTO public.virksomhet VALUES (217, '849349122', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849349122', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.175498', '2023-09-01 13:02:16.175498');
INSERT INTO public.virksomhet VALUES (218, '848678778', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848678778', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.368102', '2023-09-01 13:02:16.368102');
INSERT INTO public.virksomhet VALUES (219, '856425068', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856425068', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.404222', '2023-09-01 13:02:16.404222');
INSERT INTO public.virksomhet VALUES (220, '874049341', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874049341', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.471529', '2023-09-01 13:02:16.471529');
INSERT INTO public.virksomhet VALUES (221, '874858219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874858219', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.507983', '2023-09-01 13:02:16.507983');
INSERT INTO public.virksomhet VALUES (222, '886351929', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886351929', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.556041', '2023-09-01 13:02:16.556041');
INSERT INTO public.virksomhet VALUES (223, '882682006', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882682006', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.605746', '2023-09-01 13:02:16.605746');
INSERT INTO public.virksomhet VALUES (224, '815979604', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815979604', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.657569', '2023-09-01 13:02:16.657569');
INSERT INTO public.virksomhet VALUES (225, '839386992', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839386992', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.706658', '2023-09-01 13:02:16.706658');
INSERT INTO public.virksomhet VALUES (226, '857404113', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857404113', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.740965', '2023-09-01 13:02:16.740965');
INSERT INTO public.virksomhet VALUES (227, '869983436', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869983436', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.785301', '2023-09-01 13:02:16.785301');
INSERT INTO public.virksomhet VALUES (228, '878032565', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878032565', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.810146', '2023-09-01 13:02:16.810146');
INSERT INTO public.virksomhet VALUES (229, '819705126', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819705126', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.839987', '2023-09-01 13:02:16.839987');
INSERT INTO public.virksomhet VALUES (230, '845287728', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845287728', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.879221', '2023-09-01 13:02:16.879221');
INSERT INTO public.virksomhet VALUES (231, '860837701', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860837701', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.917363', '2023-09-01 13:02:16.917363');
INSERT INTO public.virksomhet VALUES (232, '875842181', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875842181', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.945067', '2023-09-01 13:02:16.945067');
INSERT INTO public.virksomhet VALUES (233, '804699906', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804699906', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:16.995003', '2023-09-01 13:02:16.995003');
INSERT INTO public.virksomhet VALUES (234, '823614948', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823614948', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.053889', '2023-09-01 13:02:17.053889');
INSERT INTO public.virksomhet VALUES (235, '862500476', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862500476', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.087629', '2023-09-01 13:02:17.087629');
INSERT INTO public.virksomhet VALUES (236, '809412443', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809412443', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.124799', '2023-09-01 13:02:17.124799');
INSERT INTO public.virksomhet VALUES (237, '828229131', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828229131', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.147051', '2023-09-01 13:02:17.147051');
INSERT INTO public.virksomhet VALUES (238, '801498562', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801498562', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.192063', '2023-09-01 13:02:17.192063');
INSERT INTO public.virksomhet VALUES (239, '873369415', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873369415', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.241188', '2023-09-01 13:02:17.241188');
INSERT INTO public.virksomhet VALUES (240, '895611299', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895611299', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.296951', '2023-09-01 13:02:17.296951');
INSERT INTO public.virksomhet VALUES (241, '841020642', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841020642', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.343065', '2023-09-01 13:02:17.343065');
INSERT INTO public.virksomhet VALUES (242, '824842469', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824842469', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.385388', '2023-09-01 13:02:17.385388');
INSERT INTO public.virksomhet VALUES (243, '879641976', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879641976', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.430171', '2023-09-01 13:02:17.430171');
INSERT INTO public.virksomhet VALUES (244, '865456582', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865456582', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.489754', '2023-09-01 13:02:17.489754');
INSERT INTO public.virksomhet VALUES (245, '894482342', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894482342', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.545331', '2023-09-01 13:02:17.545331');
INSERT INTO public.virksomhet VALUES (246, '898371335', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898371335', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.581167', '2023-09-01 13:02:17.581167');
INSERT INTO public.virksomhet VALUES (247, '855496620', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855496620', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.612869', '2023-09-01 13:02:17.612869');
INSERT INTO public.virksomhet VALUES (248, '827673788', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827673788', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.665505', '2023-09-01 13:02:17.665505');
INSERT INTO public.virksomhet VALUES (249, '843554986', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843554986', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.730175', '2023-09-01 13:02:17.730175');
INSERT INTO public.virksomhet VALUES (250, '889779510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889779510', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.780317', '2023-09-01 13:02:17.780317');
INSERT INTO public.virksomhet VALUES (251, '857354197', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857354197', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.820494', '2023-09-01 13:02:17.820494');
INSERT INTO public.virksomhet VALUES (252, '823773229', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823773229', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.874573', '2023-09-01 13:02:17.874573');
INSERT INTO public.virksomhet VALUES (253, '807707298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807707298', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.931678', '2023-09-01 13:02:17.931678');
INSERT INTO public.virksomhet VALUES (254, '865421389', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865421389', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:17.989369', '2023-09-01 13:02:17.989369');
INSERT INTO public.virksomhet VALUES (255, '876063217', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876063217', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.041644', '2023-09-01 13:02:18.041644');
INSERT INTO public.virksomhet VALUES (256, '895621261', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895621261', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.08009', '2023-09-01 13:02:18.08009');
INSERT INTO public.virksomhet VALUES (257, '885492879', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885492879', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.118116', '2023-09-01 13:02:18.118116');
INSERT INTO public.virksomhet VALUES (258, '894782357', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894782357', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.156027', '2023-09-01 13:02:18.156027');
INSERT INTO public.virksomhet VALUES (259, '835084511', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835084511', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.201404', '2023-09-01 13:02:18.201404');
INSERT INTO public.virksomhet VALUES (260, '861993774', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861993774', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.233172', '2023-09-01 13:02:18.233172');
INSERT INTO public.virksomhet VALUES (261, '889170847', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889170847', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.257962', '2023-09-01 13:02:18.257962');
INSERT INTO public.virksomhet VALUES (262, '828494499', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828494499', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.303562', '2023-09-01 13:02:18.303562');
INSERT INTO public.virksomhet VALUES (263, '854202196', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854202196', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.357086', '2023-09-01 13:02:18.357086');
INSERT INTO public.virksomhet VALUES (264, '802742619', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802742619', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.409317', '2023-09-01 13:02:18.409317');
INSERT INTO public.virksomhet VALUES (265, '868404321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868404321', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.467181', '2023-09-01 13:02:18.467181');
INSERT INTO public.virksomhet VALUES (266, '851956311', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851956311', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.521788', '2023-09-01 13:02:18.521788');
INSERT INTO public.virksomhet VALUES (267, '823334696', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823334696', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.553334', '2023-09-01 13:02:18.553334');
INSERT INTO public.virksomhet VALUES (268, '852790719', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852790719', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.614126', '2023-09-01 13:02:18.614126');
INSERT INTO public.virksomhet VALUES (269, '893629730', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893629730', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.664505', '2023-09-01 13:02:18.664505');
INSERT INTO public.virksomhet VALUES (270, '863813033', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863813033', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.689604', '2023-09-01 13:02:18.689604');
INSERT INTO public.virksomhet VALUES (271, '808618938', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808618938', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.737787', '2023-09-01 13:02:18.737787');
INSERT INTO public.virksomhet VALUES (272, '809260201', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809260201', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.776807', '2023-09-01 13:02:18.776807');
INSERT INTO public.virksomhet VALUES (273, '895819984', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895819984', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.829309', '2023-09-01 13:02:18.829309');
INSERT INTO public.virksomhet VALUES (274, '819657813', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819657813', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.908004', '2023-09-01 13:02:18.908004');
INSERT INTO public.virksomhet VALUES (275, '800224708', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800224708', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:18.960448', '2023-09-01 13:02:18.960448');
INSERT INTO public.virksomhet VALUES (276, '806669485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806669485', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.009162', '2023-09-01 13:02:19.009162');
INSERT INTO public.virksomhet VALUES (277, '880734391', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880734391', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.065543', '2023-09-01 13:02:19.065543');
INSERT INTO public.virksomhet VALUES (278, '828568610', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828568610', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.105294', '2023-09-01 13:02:19.105294');
INSERT INTO public.virksomhet VALUES (279, '823138132', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823138132', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.143979', '2023-09-01 13:02:19.143979');
INSERT INTO public.virksomhet VALUES (280, '817989278', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817989278', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.200225', '2023-09-01 13:02:19.200225');
INSERT INTO public.virksomhet VALUES (281, '802713634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802713634', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.240357', '2023-09-01 13:02:19.240357');
INSERT INTO public.virksomhet VALUES (282, '807804577', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807804577', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.302105', '2023-09-01 13:02:19.302105');
INSERT INTO public.virksomhet VALUES (283, '848323171', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848323171', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.36389', '2023-09-01 13:02:19.36389');
INSERT INTO public.virksomhet VALUES (284, '832865945', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832865945', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.418619', '2023-09-01 13:02:19.418619');
INSERT INTO public.virksomhet VALUES (285, '860309060', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860309060', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.451555', '2023-09-01 13:02:19.451555');
INSERT INTO public.virksomhet VALUES (286, '814889148', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814889148', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.531327', '2023-09-01 13:02:19.531327');
INSERT INTO public.virksomhet VALUES (287, '891572191', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891572191', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.580321', '2023-09-01 13:02:19.580321');
INSERT INTO public.virksomhet VALUES (288, '877218345', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877218345', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.617746', '2023-09-01 13:02:19.617746');
INSERT INTO public.virksomhet VALUES (289, '886724220', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886724220', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.645886', '2023-09-01 13:02:19.645886');
INSERT INTO public.virksomhet VALUES (290, '820530610', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820530610', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.693256', '2023-09-01 13:02:19.693256');
INSERT INTO public.virksomhet VALUES (291, '837535869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837535869', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.746551', '2023-09-01 13:02:19.746551');
INSERT INTO public.virksomhet VALUES (292, '865065632', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865065632', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.809851', '2023-09-01 13:02:19.809851');
INSERT INTO public.virksomhet VALUES (293, '873542190', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873542190', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.868342', '2023-09-01 13:02:19.868342');
INSERT INTO public.virksomhet VALUES (294, '814804594', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814804594', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.913805', '2023-09-01 13:02:19.913805');
INSERT INTO public.virksomhet VALUES (295, '857056451', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857056451', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:19.968524', '2023-09-01 13:02:19.968524');
INSERT INTO public.virksomhet VALUES (296, '869737356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869737356', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.02355', '2023-09-01 13:02:20.02355');
INSERT INTO public.virksomhet VALUES (297, '848200494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848200494', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.066975', '2023-09-01 13:02:20.066975');
INSERT INTO public.virksomhet VALUES (298, '811656574', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811656574', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.112508', '2023-09-01 13:02:20.112508');
INSERT INTO public.virksomhet VALUES (299, '859300392', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859300392', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.177413', '2023-09-01 13:02:20.177413');
INSERT INTO public.virksomhet VALUES (300, '888201315', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888201315', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.225202', '2023-09-01 13:02:20.225202');
INSERT INTO public.virksomhet VALUES (301, '802642361', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802642361', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.271833', '2023-09-01 13:02:20.271833');
INSERT INTO public.virksomhet VALUES (302, '895927960', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895927960', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.312808', '2023-09-01 13:02:20.312808');
INSERT INTO public.virksomhet VALUES (303, '858574195', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858574195', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.368799', '2023-09-01 13:02:20.368799');
INSERT INTO public.virksomhet VALUES (304, '836046143', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836046143', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.415082', '2023-09-01 13:02:20.415082');
INSERT INTO public.virksomhet VALUES (305, '872682864', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872682864', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.472762', '2023-09-01 13:02:20.472762');
INSERT INTO public.virksomhet VALUES (306, '868541833', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868541833', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.535968', '2023-09-01 13:02:20.535968');
INSERT INTO public.virksomhet VALUES (307, '887162294', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887162294', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.651099', '2023-09-01 13:02:20.651099');
INSERT INTO public.virksomhet VALUES (308, '872722388', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872722388', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.715085', '2023-09-01 13:02:20.715085');
INSERT INTO public.virksomhet VALUES (309, '856110013', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856110013', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.788001', '2023-09-01 13:02:20.788001');
INSERT INTO public.virksomhet VALUES (310, '888356763', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888356763', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.850413', '2023-09-01 13:02:20.850413');
INSERT INTO public.virksomhet VALUES (311, '876598168', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876598168', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:20.916221', '2023-09-01 13:02:20.916221');
INSERT INTO public.virksomhet VALUES (312, '898292659', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898292659', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.007469', '2023-09-01 13:02:21.007469');
INSERT INTO public.virksomhet VALUES (313, '884348614', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884348614', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.046453', '2023-09-01 13:02:21.046453');
INSERT INTO public.virksomhet VALUES (314, '861893059', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861893059', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.089205', '2023-09-01 13:02:21.089205');
INSERT INTO public.virksomhet VALUES (315, '813576485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813576485', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.122877', '2023-09-01 13:02:21.122877');
INSERT INTO public.virksomhet VALUES (316, '815615055', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815615055', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.166573', '2023-09-01 13:02:21.166573');
INSERT INTO public.virksomhet VALUES (317, '851095336', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851095336', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.186414', '2023-09-01 13:02:21.186414');
INSERT INTO public.virksomhet VALUES (318, '839238424', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839238424', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.215118', '2023-09-01 13:02:21.215118');
INSERT INTO public.virksomhet VALUES (319, '802413011', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802413011', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.255581', '2023-09-01 13:02:21.255581');
INSERT INTO public.virksomhet VALUES (320, '860737507', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860737507', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.302388', '2023-09-01 13:02:21.302388');
INSERT INTO public.virksomhet VALUES (321, '870274950', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870274950', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.350296', '2023-09-01 13:02:21.350296');
INSERT INTO public.virksomhet VALUES (322, '848225721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848225721', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.397385', '2023-09-01 13:02:21.397385');
INSERT INTO public.virksomhet VALUES (323, '869094505', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869094505', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.443879', '2023-09-01 13:02:21.443879');
INSERT INTO public.virksomhet VALUES (324, '820130498', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820130498', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.483966', '2023-09-01 13:02:21.483966');
INSERT INTO public.virksomhet VALUES (325, '890410982', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890410982', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.542985', '2023-09-01 13:02:21.542985');
INSERT INTO public.virksomhet VALUES (326, '808992454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808992454', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.591583', '2023-09-01 13:02:21.591583');
INSERT INTO public.virksomhet VALUES (327, '884151600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884151600', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.630733', '2023-09-01 13:02:21.630733');
INSERT INTO public.virksomhet VALUES (328, '853357327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853357327', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.685639', '2023-09-01 13:02:21.685639');
INSERT INTO public.virksomhet VALUES (329, '816439848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816439848', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.716537', '2023-09-01 13:02:21.716537');
INSERT INTO public.virksomhet VALUES (330, '884209909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884209909', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.746915', '2023-09-01 13:02:21.746915');
INSERT INTO public.virksomhet VALUES (331, '899443571', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899443571', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.781854', '2023-09-01 13:02:21.781854');
INSERT INTO public.virksomhet VALUES (332, '866284751', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866284751', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.801506', '2023-09-01 13:02:21.801506');
INSERT INTO public.virksomhet VALUES (333, '880509861', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880509861', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.825846', '2023-09-01 13:02:21.825846');
INSERT INTO public.virksomhet VALUES (334, '849684760', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849684760', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.86872', '2023-09-01 13:02:21.86872');
INSERT INTO public.virksomhet VALUES (335, '828427862', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828427862', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.894453', '2023-09-01 13:02:21.894453');
INSERT INTO public.virksomhet VALUES (336, '806894844', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806894844', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.921341', '2023-09-01 13:02:21.921341');
INSERT INTO public.virksomhet VALUES (337, '814590821', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814590821', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:21.964888', '2023-09-01 13:02:21.964888');
INSERT INTO public.virksomhet VALUES (338, '837061530', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837061530', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.017334', '2023-09-01 13:02:22.017334');
INSERT INTO public.virksomhet VALUES (339, '801554425', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801554425', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.048036', '2023-09-01 13:02:22.048036');
INSERT INTO public.virksomhet VALUES (340, '810074954', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810074954', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.088849', '2023-09-01 13:02:22.088849');
INSERT INTO public.virksomhet VALUES (341, '859766179', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859766179', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.109052', '2023-09-01 13:02:22.109052');
INSERT INTO public.virksomhet VALUES (342, '871799161', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871799161', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.161558', '2023-09-01 13:02:22.161558');
INSERT INTO public.virksomhet VALUES (343, '801976897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801976897', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.208047', '2023-09-01 13:02:22.208047');
INSERT INTO public.virksomhet VALUES (344, '802585963', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802585963', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.263908', '2023-09-01 13:02:22.263908');
INSERT INTO public.virksomhet VALUES (345, '818337697', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818337697', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.305782', '2023-09-01 13:02:22.305782');
INSERT INTO public.virksomhet VALUES (346, '879951937', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879951937', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.335005', '2023-09-01 13:02:22.335005');
INSERT INTO public.virksomhet VALUES (347, '831001012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831001012', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.361839', '2023-09-01 13:02:22.361839');
INSERT INTO public.virksomhet VALUES (348, '898847680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898847680', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.409188', '2023-09-01 13:02:22.409188');
INSERT INTO public.virksomhet VALUES (349, '852996781', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852996781', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.437872', '2023-09-01 13:02:22.437872');
INSERT INTO public.virksomhet VALUES (350, '859568205', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859568205', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.468691', '2023-09-01 13:02:22.468691');
INSERT INTO public.virksomhet VALUES (351, '878298725', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878298725', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.511853', '2023-09-01 13:02:22.511853');
INSERT INTO public.virksomhet VALUES (352, '865500726', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865500726', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.543946', '2023-09-01 13:02:22.543946');
INSERT INTO public.virksomhet VALUES (353, '847800406', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847800406', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.60252', '2023-09-01 13:02:22.60252');
INSERT INTO public.virksomhet VALUES (354, '812585250', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812585250', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.634675', '2023-09-01 13:02:22.634675');
INSERT INTO public.virksomhet VALUES (355, '829630446', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829630446', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.684486', '2023-09-01 13:02:22.684486');
INSERT INTO public.virksomhet VALUES (356, '878665958', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878665958', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.710428', '2023-09-01 13:02:22.710428');
INSERT INTO public.virksomhet VALUES (357, '867338166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867338166', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.736458', '2023-09-01 13:02:22.736458');
INSERT INTO public.virksomhet VALUES (358, '874303897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874303897', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.762958', '2023-09-01 13:02:22.762958');
INSERT INTO public.virksomhet VALUES (359, '815797440', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815797440', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.832351', '2023-09-01 13:02:22.832351');
INSERT INTO public.virksomhet VALUES (360, '878302329', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878302329', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.869806', '2023-09-01 13:02:22.869806');
INSERT INTO public.virksomhet VALUES (361, '814902719', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814902719', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.918046', '2023-09-01 13:02:22.918046');
INSERT INTO public.virksomhet VALUES (362, '861928097', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861928097', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:22.962495', '2023-09-01 13:02:22.962495');
INSERT INTO public.virksomhet VALUES (363, '814214408', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814214408', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.001997', '2023-09-01 13:02:23.001997');
INSERT INTO public.virksomhet VALUES (364, '841446216', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841446216', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.034905', '2023-09-01 13:02:23.034905');
INSERT INTO public.virksomhet VALUES (365, '880913102', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880913102', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.057505', '2023-09-01 13:02:23.057505');
INSERT INTO public.virksomhet VALUES (366, '804954274', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804954274', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.086564', '2023-09-01 13:02:23.086564');
INSERT INTO public.virksomhet VALUES (367, '867602272', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867602272', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.115843', '2023-09-01 13:02:23.115843');
INSERT INTO public.virksomhet VALUES (368, '890907727', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890907727', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.172514', '2023-09-01 13:02:23.172514');
INSERT INTO public.virksomhet VALUES (369, '896522080', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896522080', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.205796', '2023-09-01 13:02:23.205796');
INSERT INTO public.virksomhet VALUES (370, '805655729', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805655729', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.261822', '2023-09-01 13:02:23.261822');
INSERT INTO public.virksomhet VALUES (371, '839500879', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839500879', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.298884', '2023-09-01 13:02:23.298884');
INSERT INTO public.virksomhet VALUES (372, '885869627', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885869627', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.337061', '2023-09-01 13:02:23.337061');
INSERT INTO public.virksomhet VALUES (373, '875445187', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875445187', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.382455', '2023-09-01 13:02:23.382455');
INSERT INTO public.virksomhet VALUES (374, '813466439', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813466439', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.435352', '2023-09-01 13:02:23.435352');
INSERT INTO public.virksomhet VALUES (375, '896623441', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896623441', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.494837', '2023-09-01 13:02:23.494837');
INSERT INTO public.virksomhet VALUES (376, '808991850', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808991850', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.542564', '2023-09-01 13:02:23.542564');
INSERT INTO public.virksomhet VALUES (377, '829507713', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829507713', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.586812', '2023-09-01 13:02:23.586812');
INSERT INTO public.virksomhet VALUES (378, '833117254', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833117254', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.616823', '2023-09-01 13:02:23.616823');
INSERT INTO public.virksomhet VALUES (379, '837846413', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837846413', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.64519', '2023-09-01 13:02:23.64519');
INSERT INTO public.virksomhet VALUES (380, '869503803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869503803', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.682074', '2023-09-01 13:02:23.682074');
INSERT INTO public.virksomhet VALUES (381, '883744480', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883744480', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.70739', '2023-09-01 13:02:23.70739');
INSERT INTO public.virksomhet VALUES (382, '841681491', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841681491', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.743285', '2023-09-01 13:02:23.743285');
INSERT INTO public.virksomhet VALUES (383, '804469736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804469736', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.783123', '2023-09-01 13:02:23.783123');
INSERT INTO public.virksomhet VALUES (384, '842580200', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842580200', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.815463', '2023-09-01 13:02:23.815463');
INSERT INTO public.virksomhet VALUES (385, '867939301', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867939301', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.857243', '2023-09-01 13:02:23.857243');
INSERT INTO public.virksomhet VALUES (386, '846991517', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846991517', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.887363', '2023-09-01 13:02:23.887363');
INSERT INTO public.virksomhet VALUES (387, '849842492', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849842492', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.924908', '2023-09-01 13:02:23.924908');
INSERT INTO public.virksomhet VALUES (388, '892824713', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892824713', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.963534', '2023-09-01 13:02:23.963534');
INSERT INTO public.virksomhet VALUES (389, '871393874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871393874', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:23.985635', '2023-09-01 13:02:23.985635');
INSERT INTO public.virksomhet VALUES (390, '838748341', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838748341', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.018338', '2023-09-01 13:02:24.018338');
INSERT INTO public.virksomhet VALUES (391, '852620240', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852620240', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.041172', '2023-09-01 13:02:24.041172');
INSERT INTO public.virksomhet VALUES (392, '810480871', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810480871', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.068904', '2023-09-01 13:02:24.068904');
INSERT INTO public.virksomhet VALUES (393, '836141850', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836141850', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.105173', '2023-09-01 13:02:24.105173');
INSERT INTO public.virksomhet VALUES (394, '813662987', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813662987', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.135923', '2023-09-01 13:02:24.135923');
INSERT INTO public.virksomhet VALUES (395, '874409446', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874409446', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.152511', '2023-09-01 13:02:24.152511');
INSERT INTO public.virksomhet VALUES (396, '882071110', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882071110', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.174276', '2023-09-01 13:02:24.174276');
INSERT INTO public.virksomhet VALUES (397, '831281285', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831281285', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.193852', '2023-09-01 13:02:24.193852');
INSERT INTO public.virksomhet VALUES (398, '812422244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812422244', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.216792', '2023-09-01 13:02:24.216792');
INSERT INTO public.virksomhet VALUES (399, '877641955', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877641955', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.238031', '2023-09-01 13:02:24.238031');
INSERT INTO public.virksomhet VALUES (400, '849832913', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849832913', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.264306', '2023-09-01 13:02:24.264306');
INSERT INTO public.virksomhet VALUES (401, '878265524', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878265524', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.298004', '2023-09-01 13:02:24.298004');
INSERT INTO public.virksomhet VALUES (402, '862385530', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862385530', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.374562', '2023-09-01 13:02:24.374562');
INSERT INTO public.virksomhet VALUES (403, '832873358', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832873358', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.431334', '2023-09-01 13:02:24.431334');
INSERT INTO public.virksomhet VALUES (404, '865506081', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865506081', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.515239', '2023-09-01 13:02:24.515239');
INSERT INTO public.virksomhet VALUES (405, '862694712', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862694712', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.622476', '2023-09-01 13:02:24.622476');
INSERT INTO public.virksomhet VALUES (406, '808556476', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808556476', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.681377', '2023-09-01 13:02:24.681377');
INSERT INTO public.virksomhet VALUES (407, '809785402', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809785402', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.731921', '2023-09-01 13:02:24.731921');
INSERT INTO public.virksomhet VALUES (408, '820464657', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820464657', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.77578', '2023-09-01 13:02:24.77578');
INSERT INTO public.virksomhet VALUES (409, '806453016', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806453016', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.835636', '2023-09-01 13:02:24.835636');
INSERT INTO public.virksomhet VALUES (410, '855109259', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855109259', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.935397', '2023-09-01 13:02:24.935397');
INSERT INTO public.virksomhet VALUES (411, '844136610', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844136610', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:24.987943', '2023-09-01 13:02:24.987943');
INSERT INTO public.virksomhet VALUES (412, '868437705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868437705', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.063498', '2023-09-01 13:02:25.063498');
INSERT INTO public.virksomhet VALUES (413, '805414233', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805414233', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.108861', '2023-09-01 13:02:25.108861');
INSERT INTO public.virksomhet VALUES (414, '843122242', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843122242', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.163781', '2023-09-01 13:02:25.163781');
INSERT INTO public.virksomhet VALUES (415, '880436983', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880436983', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.264522', '2023-09-01 13:02:25.264522');
INSERT INTO public.virksomhet VALUES (416, '877619067', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877619067', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.324417', '2023-09-01 13:02:25.324417');
INSERT INTO public.virksomhet VALUES (417, '825656069', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825656069', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.370636', '2023-09-01 13:02:25.370636');
INSERT INTO public.virksomhet VALUES (418, '809247535', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809247535', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.417007', '2023-09-01 13:02:25.417007');
INSERT INTO public.virksomhet VALUES (419, '850902238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850902238', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.462025', '2023-09-01 13:02:25.462025');
INSERT INTO public.virksomhet VALUES (420, '805065367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805065367', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.556215', '2023-09-01 13:02:25.556215');
INSERT INTO public.virksomhet VALUES (421, '884103260', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884103260', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.606287', '2023-09-01 13:02:25.606287');
INSERT INTO public.virksomhet VALUES (422, '896185086', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896185086', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.671017', '2023-09-01 13:02:25.671017');
INSERT INTO public.virksomhet VALUES (423, '879147472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879147472', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.785684', '2023-09-01 13:02:25.785684');
INSERT INTO public.virksomhet VALUES (424, '859469327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859469327', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.891127', '2023-09-01 13:02:25.891127');
INSERT INTO public.virksomhet VALUES (425, '809021214', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809021214', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.941218', '2023-09-01 13:02:25.941218');
INSERT INTO public.virksomhet VALUES (426, '890441272', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890441272', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:25.990059', '2023-09-01 13:02:25.990059');
INSERT INTO public.virksomhet VALUES (427, '843918726', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843918726', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:26.264746', '2023-09-01 13:02:26.264746');
INSERT INTO public.virksomhet VALUES (428, '867010071', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867010071', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:26.63047', '2023-09-01 13:02:26.63047');
INSERT INTO public.virksomhet VALUES (429, '899491325', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899491325', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:26.69607', '2023-09-01 13:02:26.69607');
INSERT INTO public.virksomhet VALUES (430, '817860197', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817860197', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:26.79152', '2023-09-01 13:02:26.79152');
INSERT INTO public.virksomhet VALUES (431, '894342532', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894342532', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:26.913308', '2023-09-01 13:02:26.913308');
INSERT INTO public.virksomhet VALUES (432, '832677042', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832677042', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:27.095231', '2023-09-01 13:02:27.095231');
INSERT INTO public.virksomhet VALUES (433, '886394237', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886394237', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:27.168571', '2023-09-01 13:02:27.168571');
INSERT INTO public.virksomhet VALUES (434, '872624587', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872624587', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:27.247097', '2023-09-01 13:02:27.247097');
INSERT INTO public.virksomhet VALUES (435, '898866641', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898866641', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:27.317664', '2023-09-01 13:02:27.317664');
INSERT INTO public.virksomhet VALUES (436, '884853942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884853942', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:27.377606', '2023-09-01 13:02:27.377606');
INSERT INTO public.virksomhet VALUES (437, '819545829', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819545829', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:27.467214', '2023-09-01 13:02:27.467214');
INSERT INTO public.virksomhet VALUES (438, '833817902', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833817902', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:27.574134', '2023-09-01 13:02:27.574134');
INSERT INTO public.virksomhet VALUES (439, '885642137', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885642137', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:27.699301', '2023-09-01 13:02:27.699301');
INSERT INTO public.virksomhet VALUES (440, '896711412', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896711412', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:27.786202', '2023-09-01 13:02:27.786202');
INSERT INTO public.virksomhet VALUES (441, '821835062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821835062', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:27.86085', '2023-09-01 13:02:27.86085');
INSERT INTO public.virksomhet VALUES (442, '870037842', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870037842', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:27.975185', '2023-09-01 13:02:27.975185');
INSERT INTO public.virksomhet VALUES (443, '817185565', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817185565', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.04133', '2023-09-01 13:02:28.04133');
INSERT INTO public.virksomhet VALUES (444, '867521592', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867521592', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.082907', '2023-09-01 13:02:28.082907');
INSERT INTO public.virksomhet VALUES (445, '877585722', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877585722', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.133485', '2023-09-01 13:02:28.133485');
INSERT INTO public.virksomhet VALUES (446, '834435277', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834435277', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.175704', '2023-09-01 13:02:28.175704');
INSERT INTO public.virksomhet VALUES (447, '822051894', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822051894', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.233899', '2023-09-01 13:02:28.233899');
INSERT INTO public.virksomhet VALUES (448, '833917059', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833917059', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.266173', '2023-09-01 13:02:28.266173');
INSERT INTO public.virksomhet VALUES (449, '845980869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845980869', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.295856', '2023-09-01 13:02:28.295856');
INSERT INTO public.virksomhet VALUES (450, '855519631', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855519631', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.329021', '2023-09-01 13:02:28.329021');
INSERT INTO public.virksomhet VALUES (451, '831415125', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831415125', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.375784', '2023-09-01 13:02:28.375784');
INSERT INTO public.virksomhet VALUES (452, '846728931', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846728931', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.417643', '2023-09-01 13:02:28.417643');
INSERT INTO public.virksomhet VALUES (453, '848471580', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848471580', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.457938', '2023-09-01 13:02:28.457938');
INSERT INTO public.virksomhet VALUES (454, '873734324', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873734324', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.512054', '2023-09-01 13:02:28.512054');
INSERT INTO public.virksomhet VALUES (455, '857680633', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857680633', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.548465', '2023-09-01 13:02:28.548465');
INSERT INTO public.virksomhet VALUES (456, '835913918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835913918', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.617776', '2023-09-01 13:02:28.617776');
INSERT INTO public.virksomhet VALUES (457, '857383092', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857383092', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.704682', '2023-09-01 13:02:28.704682');
INSERT INTO public.virksomhet VALUES (458, '839907680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839907680', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.774527', '2023-09-01 13:02:28.774527');
INSERT INTO public.virksomhet VALUES (459, '825019259', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825019259', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.807135', '2023-09-01 13:02:28.807135');
INSERT INTO public.virksomhet VALUES (460, '812484100', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812484100', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.835109', '2023-09-01 13:02:28.835109');
INSERT INTO public.virksomhet VALUES (461, '865749372', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865749372', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.864735', '2023-09-01 13:02:28.864735');
INSERT INTO public.virksomhet VALUES (462, '848145367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848145367', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.902396', '2023-09-01 13:02:28.902396');
INSERT INTO public.virksomhet VALUES (463, '897513077', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897513077', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.935183', '2023-09-01 13:02:28.935183');
INSERT INTO public.virksomhet VALUES (464, '898230296', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898230296', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:28.983577', '2023-09-01 13:02:28.983577');
INSERT INTO public.virksomhet VALUES (465, '830853233', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830853233', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.035848', '2023-09-01 13:02:29.035848');
INSERT INTO public.virksomhet VALUES (466, '805517793', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805517793', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.076285', '2023-09-01 13:02:29.076285');
INSERT INTO public.virksomhet VALUES (467, '862719356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862719356', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.117041', '2023-09-01 13:02:29.117041');
INSERT INTO public.virksomhet VALUES (468, '868747999', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868747999', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.149093', '2023-09-01 13:02:29.149093');
INSERT INTO public.virksomhet VALUES (469, '820061307', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820061307', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.196646', '2023-09-01 13:02:29.196646');
INSERT INTO public.virksomhet VALUES (470, '868124354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868124354', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.364651', '2023-09-01 13:02:29.364651');
INSERT INTO public.virksomhet VALUES (471, '816123649', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816123649', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.413332', '2023-09-01 13:02:29.413332');
INSERT INTO public.virksomhet VALUES (472, '832157777', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832157777', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.464678', '2023-09-01 13:02:29.464678');
INSERT INTO public.virksomhet VALUES (473, '831381830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831381830', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.50711', '2023-09-01 13:02:29.50711');
INSERT INTO public.virksomhet VALUES (474, '817029341', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817029341', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.545104', '2023-09-01 13:02:29.545104');
INSERT INTO public.virksomhet VALUES (475, '883702404', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883702404', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.608355', '2023-09-01 13:02:29.608355');
INSERT INTO public.virksomhet VALUES (476, '875251613', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875251613', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.650368', '2023-09-01 13:02:29.650368');
INSERT INTO public.virksomhet VALUES (477, '888916707', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888916707', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.693563', '2023-09-01 13:02:29.693563');
INSERT INTO public.virksomhet VALUES (478, '880687429', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880687429', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.716804', '2023-09-01 13:02:29.716804');
INSERT INTO public.virksomhet VALUES (479, '887053356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887053356', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.747304', '2023-09-01 13:02:29.747304');
INSERT INTO public.virksomhet VALUES (480, '851373027', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851373027', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.796689', '2023-09-01 13:02:29.796689');
INSERT INTO public.virksomhet VALUES (481, '884968539', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884968539', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.830705', '2023-09-01 13:02:29.830705');
INSERT INTO public.virksomhet VALUES (482, '899921613', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899921613', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.878135', '2023-09-01 13:02:29.878135');
INSERT INTO public.virksomhet VALUES (483, '817640200', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817640200', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.911164', '2023-09-01 13:02:29.911164');
INSERT INTO public.virksomhet VALUES (484, '869157440', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869157440', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:29.954939', '2023-09-01 13:02:29.954939');
INSERT INTO public.virksomhet VALUES (485, '824996698', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824996698', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.002664', '2023-09-01 13:02:30.002664');
INSERT INTO public.virksomhet VALUES (486, '841149048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841149048', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.049333', '2023-09-01 13:02:30.049333');
INSERT INTO public.virksomhet VALUES (487, '846124562', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846124562', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.08709', '2023-09-01 13:02:30.08709');
INSERT INTO public.virksomhet VALUES (488, '820180026', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820180026', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.125332', '2023-09-01 13:02:30.125332');
INSERT INTO public.virksomhet VALUES (489, '844702533', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844702533', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.145371', '2023-09-01 13:02:30.145371');
INSERT INTO public.virksomhet VALUES (490, '812044855', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812044855', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.165849', '2023-09-01 13:02:30.165849');
INSERT INTO public.virksomhet VALUES (491, '881840088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881840088', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.183062', '2023-09-01 13:02:30.183062');
INSERT INTO public.virksomhet VALUES (492, '810615966', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810615966', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.205439', '2023-09-01 13:02:30.205439');
INSERT INTO public.virksomhet VALUES (493, '847652861', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847652861', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.226414', '2023-09-01 13:02:30.226414');
INSERT INTO public.virksomhet VALUES (494, '810293959', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810293959', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.269923', '2023-09-01 13:02:30.269923');
INSERT INTO public.virksomhet VALUES (495, '832883476', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832883476', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.303687', '2023-09-01 13:02:30.303687');
INSERT INTO public.virksomhet VALUES (496, '840867285', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840867285', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.347145', '2023-09-01 13:02:30.347145');
INSERT INTO public.virksomhet VALUES (497, '873422926', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873422926', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.377908', '2023-09-01 13:02:30.377908');
INSERT INTO public.virksomhet VALUES (498, '821884742', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821884742', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.416465', '2023-09-01 13:02:30.416465');
INSERT INTO public.virksomhet VALUES (499, '832848887', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832848887', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.446104', '2023-09-01 13:02:30.446104');
INSERT INTO public.virksomhet VALUES (500, '814238276', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814238276', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.483754', '2023-09-01 13:02:30.483754');
INSERT INTO public.virksomhet VALUES (501, '806659673', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806659673', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.535891', '2023-09-01 13:02:30.535891');
INSERT INTO public.virksomhet VALUES (502, '877303997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877303997', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.686882', '2023-09-01 13:02:30.686882');
INSERT INTO public.virksomhet VALUES (503, '809858203', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809858203', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.737453', '2023-09-01 13:02:30.737453');
INSERT INTO public.virksomhet VALUES (504, '853630583', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853630583', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.762093', '2023-09-01 13:02:30.762093');
INSERT INTO public.virksomhet VALUES (505, '897636323', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897636323', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.798802', '2023-09-01 13:02:30.798802');
INSERT INTO public.virksomhet VALUES (506, '857342658', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857342658', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.82995', '2023-09-01 13:02:30.82995');
INSERT INTO public.virksomhet VALUES (507, '852507509', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852507509', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.861708', '2023-09-01 13:02:30.861708');
INSERT INTO public.virksomhet VALUES (508, '882645805', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882645805', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.899143', '2023-09-01 13:02:30.899143');
INSERT INTO public.virksomhet VALUES (509, '875683015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875683015', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.923294', '2023-09-01 13:02:30.923294');
INSERT INTO public.virksomhet VALUES (510, '847572493', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847572493', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:30.954528', '2023-09-01 13:02:30.954528');
INSERT INTO public.virksomhet VALUES (511, '899524077', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899524077', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-01 13:02:40.53648', '2023-09-01 13:02:40.53648');
INSERT INTO public.virksomhet VALUES (512, '825753154', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '451357528 nvaN', '{adresse}', 'AKTIV', NULL, 825753155, '2023-09-01 13:02:40.583596', '2023-09-01 13:02:47.822872');
INSERT INTO public.virksomhet VALUES (513, '800252166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '661252008 nvaN', '{adresse}', 'AKTIV', NULL, 800252167, '2023-09-01 13:02:40.658229', '2023-09-01 13:02:47.825394');
INSERT INTO public.virksomhet VALUES (514, '822590034', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '430095228 nvaN', '{adresse}', 'AKTIV', NULL, 822590035, '2023-09-01 13:02:40.734052', '2023-09-01 13:02:47.830311');
INSERT INTO public.virksomhet VALUES (515, '895035985', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '589530598 nvaN', '{adresse}', 'AKTIV', NULL, 895035986, '2023-09-01 13:02:40.764735', '2023-09-01 13:02:47.833515');
INSERT INTO public.virksomhet VALUES (516, '843438328', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '823834348 nvaN', '{adresse}', 'AKTIV', NULL, 843438329, '2023-09-01 13:02:40.858017', '2023-09-01 13:02:47.837139');
INSERT INTO public.virksomhet VALUES (527, '826379397', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '793973628 nvaN', '{adresse}', 'AKTIV', NULL, 826379398, '2023-09-01 13:02:41.31298', '2023-09-01 13:02:47.841835');
INSERT INTO public.virksomhet VALUES (517, '834834978', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834834978', '{adresse}', 'FJERNET', '2023-01-01', 834834979, '2023-09-01 13:02:40.930914', '2023-09-01 13:02:47.845409');
INSERT INTO public.virksomhet VALUES (518, '891180633', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891180633', '{adresse}', 'FJERNET', '2023-01-01', 891180634, '2023-09-01 13:02:40.973965', '2023-09-01 13:02:47.846609');
INSERT INTO public.virksomhet VALUES (519, '830859003', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830859003', '{adresse}', 'FJERNET', '2023-01-01', 830859004, '2023-09-01 13:02:41.021847', '2023-09-01 13:02:47.847464');
INSERT INTO public.virksomhet VALUES (520, '874375031', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874375031', '{adresse}', 'FJERNET', '2023-01-01', 874375032, '2023-09-01 13:02:41.095672', '2023-09-01 13:02:47.848169');
INSERT INTO public.virksomhet VALUES (521, '881509026', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881509026', '{adresse}', 'FJERNET', '2023-01-01', 881509027, '2023-09-01 13:02:41.123047', '2023-09-01 13:02:47.850581');
INSERT INTO public.virksomhet VALUES (522, '800184390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800184390', '{adresse}', 'SLETTET', '2023-01-01', 800184391, '2023-09-01 13:02:41.16442', '2023-09-01 13:02:47.851556');
INSERT INTO public.virksomhet VALUES (523, '803113235', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803113235', '{adresse}', 'SLETTET', '2023-01-01', 803113236, '2023-09-01 13:02:41.190959', '2023-09-01 13:02:47.853001');
INSERT INTO public.virksomhet VALUES (524, '811074684', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811074684', '{adresse}', 'SLETTET', '2023-01-01', 811074685, '2023-09-01 13:02:41.228903', '2023-09-01 13:02:47.853874');
INSERT INTO public.virksomhet VALUES (525, '832601414', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832601414', '{adresse}', 'SLETTET', '2023-01-01', 832601415, '2023-09-01 13:02:41.254866', '2023-09-01 13:02:47.854959');
INSERT INTO public.virksomhet VALUES (526, '839233927', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839233927', '{adresse}', 'SLETTET', '2023-01-01', 839233928, '2023-09-01 13:02:41.288216', '2023-09-01 13:02:47.855668');
INSERT INTO public.virksomhet VALUES (534, '897776515', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897776515', '{adresse}', 'AKTIV', NULL, 897776516, '2023-09-01 13:02:47.870946', '2023-09-01 13:02:47.870946');
INSERT INTO public.virksomhet VALUES (535, '852389902', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852389902', '{adresse}', 'AKTIV', NULL, 852389903, '2023-09-01 13:02:47.874526', '2023-09-01 13:02:47.874526');
INSERT INTO public.virksomhet VALUES (536, '888847971', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888847971', '{adresse}', 'AKTIV', NULL, 888847972, '2023-09-01 13:02:47.876998', '2023-09-01 13:02:47.876998');
INSERT INTO public.virksomhet VALUES (537, '822573451', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822573451', '{adresse}', 'AKTIV', NULL, 822573452, '2023-09-01 13:02:47.882015', '2023-09-01 13:02:47.882015');
INSERT INTO public.virksomhet VALUES (538, '823932425', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823932425', '{adresse}', 'AKTIV', NULL, 823932426, '2023-09-01 13:02:47.884792', '2023-09-01 13:02:47.884792');


--
-- Data for Name: virksomhet_naringsundergrupper; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_naringsundergrupper VALUES (1, 1, '90.012', NULL, NULL, '2023-09-01 13:02:05.216671', '2023-09-01 13:02:05.216671');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (2, 2, '70.220', '90.012', NULL, '2023-09-01 13:02:05.531746', '2023-09-01 13:02:05.531746');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (3, 3, '90.012', '70.220', NULL, '2023-09-01 13:02:05.579074', '2023-09-01 13:02:05.579074');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (4, 4, '90.012', NULL, NULL, '2023-09-01 13:02:05.637362', '2023-09-01 13:02:05.637362');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (5, 5, '01.120', NULL, NULL, '2023-09-01 13:02:05.946708', '2023-09-01 13:02:05.946708');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (6, 6, '01.120', '90.012', NULL, '2023-09-01 13:02:05.989728', '2023-09-01 13:02:05.989728');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (7, 7, '01.120', NULL, NULL, '2023-09-01 13:02:06.037117', '2023-09-01 13:02:06.037117');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (8, 8, '01.120', '90.012', NULL, '2023-09-01 13:02:06.086597', '2023-09-01 13:02:06.086597');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (9, 9, '01.120', NULL, NULL, '2023-09-01 13:02:06.147109', '2023-09-01 13:02:06.147109');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (10, 10, '01.120', '90.012', NULL, '2023-09-01 13:02:06.185605', '2023-09-01 13:02:06.185605');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (11, 11, '01.120', '90.012', NULL, '2023-09-01 13:02:06.226577', '2023-09-01 13:02:06.226577');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (12, 12, '01.120', NULL, NULL, '2023-09-01 13:02:06.262614', '2023-09-01 13:02:06.262614');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (13, 13, '01.120', '90.012', NULL, '2023-09-01 13:02:06.31519', '2023-09-01 13:02:06.31519');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (14, 14, '01.120', '90.012', '70.220', '2023-09-01 13:02:06.379192', '2023-09-01 13:02:06.379192');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (15, 15, '01.120', NULL, NULL, '2023-09-01 13:02:06.415759', '2023-09-01 13:02:06.415759');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (16, 16, '01.120', '90.012', '70.220', '2023-09-01 13:02:06.486957', '2023-09-01 13:02:06.486957');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (17, 17, '01.120', NULL, NULL, '2023-09-01 13:02:06.540614', '2023-09-01 13:02:06.540614');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (18, 18, '01.120', NULL, NULL, '2023-09-01 13:02:06.58609', '2023-09-01 13:02:06.58609');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (19, 19, '01.120', '90.012', '70.220', '2023-09-01 13:02:06.629868', '2023-09-01 13:02:06.629868');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (20, 20, '01.120', NULL, NULL, '2023-09-01 13:02:06.67079', '2023-09-01 13:02:06.67079');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (21, 21, '01.120', '90.012', '70.220', '2023-09-01 13:02:06.721749', '2023-09-01 13:02:06.721749');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (22, 22, '01.120', NULL, NULL, '2023-09-01 13:02:06.782692', '2023-09-01 13:02:06.782692');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (23, 23, '01.120', NULL, NULL, '2023-09-01 13:02:06.829875', '2023-09-01 13:02:06.829875');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (24, 24, '01.120', NULL, NULL, '2023-09-01 13:02:06.901477', '2023-09-01 13:02:06.901477');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (25, 25, '01.120', '90.012', NULL, '2023-09-01 13:02:06.948082', '2023-09-01 13:02:06.948082');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (26, 26, '01.120', '90.012', '70.220', '2023-09-01 13:02:06.993663', '2023-09-01 13:02:06.993663');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (27, 27, '01.120', NULL, NULL, '2023-09-01 13:02:07.043591', '2023-09-01 13:02:07.043591');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (28, 28, '01.120', '90.012', NULL, '2023-09-01 13:02:07.08781', '2023-09-01 13:02:07.08781');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (29, 29, '01.120', NULL, NULL, '2023-09-01 13:02:07.155247', '2023-09-01 13:02:07.155247');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (30, 30, '01.120', '90.012', NULL, '2023-09-01 13:02:07.20173', '2023-09-01 13:02:07.20173');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (31, 31, '01.120', '90.012', '70.220', '2023-09-01 13:02:07.246022', '2023-09-01 13:02:07.246022');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (32, 32, '01.120', NULL, NULL, '2023-09-01 13:02:07.506274', '2023-09-01 13:02:07.506274');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (33, 33, '01.120', NULL, NULL, '2023-09-01 13:02:07.591171', '2023-09-01 13:02:07.591171');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (34, 34, '01.120', NULL, NULL, '2023-09-01 13:02:07.684494', '2023-09-01 13:02:07.684494');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (35, 35, '01.120', NULL, NULL, '2023-09-01 13:02:07.737564', '2023-09-01 13:02:07.737564');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (36, 36, '01.120', NULL, NULL, '2023-09-01 13:02:07.860712', '2023-09-01 13:02:07.860712');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (37, 37, '01.120', NULL, NULL, '2023-09-01 13:02:07.901561', '2023-09-01 13:02:07.901561');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (38, 38, '01.120', '90.012', NULL, '2023-09-01 13:02:07.953801', '2023-09-01 13:02:07.953801');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (39, 39, '01.120', '90.012', '70.220', '2023-09-01 13:02:07.986766', '2023-09-01 13:02:07.986766');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (40, 40, '01.120', NULL, NULL, '2023-09-01 13:02:08.030475', '2023-09-01 13:02:08.030475');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (41, 41, '01.120', NULL, NULL, '2023-09-01 13:02:08.087931', '2023-09-01 13:02:08.087931');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (42, 42, '01.120', '90.012', '70.220', '2023-09-01 13:02:08.133249', '2023-09-01 13:02:08.133249');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (43, 43, '01.120', '90.012', NULL, '2023-09-01 13:02:08.173933', '2023-09-01 13:02:08.173933');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (44, 44, '01.120', '90.012', NULL, '2023-09-01 13:02:08.222041', '2023-09-01 13:02:08.222041');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (45, 45, '01.120', NULL, NULL, '2023-09-01 13:02:08.2812', '2023-09-01 13:02:08.2812');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (46, 46, '01.120', '90.012', NULL, '2023-09-01 13:02:08.329428', '2023-09-01 13:02:08.329428');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (47, 47, '01.120', NULL, NULL, '2023-09-01 13:02:08.369587', '2023-09-01 13:02:08.369587');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (48, 48, '01.120', '90.012', '70.220', '2023-09-01 13:02:08.416449', '2023-09-01 13:02:08.416449');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (49, 49, '01.120', '90.012', NULL, '2023-09-01 13:02:08.466972', '2023-09-01 13:02:08.466972');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (50, 50, '01.120', '90.012', '70.220', '2023-09-01 13:02:08.535371', '2023-09-01 13:02:08.535371');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (51, 51, '01.120', NULL, NULL, '2023-09-01 13:02:08.603754', '2023-09-01 13:02:08.603754');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (52, 52, '01.120', NULL, NULL, '2023-09-01 13:02:08.649692', '2023-09-01 13:02:08.649692');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (53, 53, '01.120', '90.012', NULL, '2023-09-01 13:02:08.69573', '2023-09-01 13:02:08.69573');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (54, 54, '01.120', NULL, NULL, '2023-09-01 13:02:08.734751', '2023-09-01 13:02:08.734751');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (55, 55, '01.120', NULL, NULL, '2023-09-01 13:02:08.774705', '2023-09-01 13:02:08.774705');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (56, 56, '01.120', NULL, NULL, '2023-09-01 13:02:08.819934', '2023-09-01 13:02:08.819934');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (57, 57, '01.120', NULL, NULL, '2023-09-01 13:02:08.86974', '2023-09-01 13:02:08.86974');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (58, 58, '01.120', '90.012', NULL, '2023-09-01 13:02:08.902833', '2023-09-01 13:02:08.902833');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (59, 59, '01.120', '90.012', NULL, '2023-09-01 13:02:08.953565', '2023-09-01 13:02:08.953565');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (60, 60, '01.120', NULL, NULL, '2023-09-01 13:02:09.029016', '2023-09-01 13:02:09.029016');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (61, 61, '01.120', '90.012', NULL, '2023-09-01 13:02:09.078789', '2023-09-01 13:02:09.078789');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (62, 62, '01.120', NULL, NULL, '2023-09-01 13:02:09.164461', '2023-09-01 13:02:09.164461');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (63, 63, '01.120', NULL, NULL, '2023-09-01 13:02:09.201171', '2023-09-01 13:02:09.201171');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (64, 64, '01.120', NULL, NULL, '2023-09-01 13:02:09.243965', '2023-09-01 13:02:09.243965');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (65, 65, '01.120', NULL, NULL, '2023-09-01 13:02:09.270071', '2023-09-01 13:02:09.270071');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (66, 66, '01.120', '90.012', NULL, '2023-09-01 13:02:09.295981', '2023-09-01 13:02:09.295981');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (67, 67, '01.120', NULL, NULL, '2023-09-01 13:02:09.333931', '2023-09-01 13:02:09.333931');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (68, 68, '01.120', NULL, NULL, '2023-09-01 13:02:09.372902', '2023-09-01 13:02:09.372902');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (69, 69, '01.120', '90.012', '70.220', '2023-09-01 13:02:09.411922', '2023-09-01 13:02:09.411922');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (70, 70, '01.120', NULL, NULL, '2023-09-01 13:02:09.453119', '2023-09-01 13:02:09.453119');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (71, 71, '01.120', NULL, NULL, '2023-09-01 13:02:09.494194', '2023-09-01 13:02:09.494194');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (72, 72, '01.120', '90.012', NULL, '2023-09-01 13:02:09.53182', '2023-09-01 13:02:09.53182');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (73, 73, '01.120', '90.012', '70.220', '2023-09-01 13:02:09.573479', '2023-09-01 13:02:09.573479');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (74, 74, '01.120', NULL, NULL, '2023-09-01 13:02:09.626037', '2023-09-01 13:02:09.626037');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (75, 75, '01.120', NULL, NULL, '2023-09-01 13:02:09.668952', '2023-09-01 13:02:09.668952');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (76, 76, '01.120', NULL, NULL, '2023-09-01 13:02:09.713076', '2023-09-01 13:02:09.713076');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (77, 77, '01.120', '90.012', NULL, '2023-09-01 13:02:09.762659', '2023-09-01 13:02:09.762659');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (78, 78, '01.120', NULL, NULL, '2023-09-01 13:02:09.810215', '2023-09-01 13:02:09.810215');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (79, 79, '01.120', NULL, NULL, '2023-09-01 13:02:09.852541', '2023-09-01 13:02:09.852541');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (80, 80, '01.120', '90.012', '70.220', '2023-09-01 13:02:09.890532', '2023-09-01 13:02:09.890532');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (81, 81, '01.120', NULL, NULL, '2023-09-01 13:02:09.940186', '2023-09-01 13:02:09.940186');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (82, 82, '01.120', NULL, NULL, '2023-09-01 13:02:09.982339', '2023-09-01 13:02:09.982339');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (83, 83, '01.120', '90.012', NULL, '2023-09-01 13:02:10.021758', '2023-09-01 13:02:10.021758');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (84, 84, '01.120', NULL, NULL, '2023-09-01 13:02:10.063946', '2023-09-01 13:02:10.063946');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (85, 85, '01.120', '90.012', NULL, '2023-09-01 13:02:10.090645', '2023-09-01 13:02:10.090645');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (86, 86, '01.120', '90.012', NULL, '2023-09-01 13:02:10.120516', '2023-09-01 13:02:10.120516');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (87, 87, '01.120', NULL, NULL, '2023-09-01 13:02:10.175069', '2023-09-01 13:02:10.175069');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (88, 88, '01.120', '90.012', '70.220', '2023-09-01 13:02:10.206456', '2023-09-01 13:02:10.206456');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (89, 89, '01.120', '90.012', NULL, '2023-09-01 13:02:10.241646', '2023-09-01 13:02:10.241646');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (90, 90, '01.120', '90.012', NULL, '2023-09-01 13:02:10.279129', '2023-09-01 13:02:10.279129');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (91, 91, '01.120', NULL, NULL, '2023-09-01 13:02:10.307723', '2023-09-01 13:02:10.307723');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (92, 92, '01.120', NULL, NULL, '2023-09-01 13:02:10.342323', '2023-09-01 13:02:10.342323');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (93, 93, '01.120', NULL, NULL, '2023-09-01 13:02:10.37688', '2023-09-01 13:02:10.37688');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (94, 94, '01.120', NULL, NULL, '2023-09-01 13:02:10.404419', '2023-09-01 13:02:10.404419');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (95, 95, '01.120', NULL, NULL, '2023-09-01 13:02:10.434196', '2023-09-01 13:02:10.434196');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (96, 96, '01.120', '90.012', NULL, '2023-09-01 13:02:10.476166', '2023-09-01 13:02:10.476166');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (97, 97, '01.120', NULL, NULL, '2023-09-01 13:02:10.517472', '2023-09-01 13:02:10.517472');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (98, 98, '01.120', '90.012', '70.220', '2023-09-01 13:02:10.563797', '2023-09-01 13:02:10.563797');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (99, 99, '01.120', NULL, NULL, '2023-09-01 13:02:10.598206', '2023-09-01 13:02:10.598206');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (100, 100, '01.120', NULL, NULL, '2023-09-01 13:02:10.634719', '2023-09-01 13:02:10.634719');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (101, 101, '01.120', NULL, NULL, '2023-09-01 13:02:10.663201', '2023-09-01 13:02:10.663201');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (102, 102, '01.120', '90.012', NULL, '2023-09-01 13:02:10.694747', '2023-09-01 13:02:10.694747');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (103, 103, '01.120', NULL, NULL, '2023-09-01 13:02:10.720917', '2023-09-01 13:02:10.720917');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (104, 104, '01.120', NULL, NULL, '2023-09-01 13:02:10.753237', '2023-09-01 13:02:10.753237');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (105, 105, '01.120', '90.012', '70.220', '2023-09-01 13:02:10.784806', '2023-09-01 13:02:10.784806');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (106, 106, '01.120', NULL, NULL, '2023-09-01 13:02:10.831749', '2023-09-01 13:02:10.831749');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (107, 107, '01.120', '90.012', '70.220', '2023-09-01 13:02:10.863845', '2023-09-01 13:02:10.863845');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (108, 108, '01.120', '90.012', NULL, '2023-09-01 13:02:10.89941', '2023-09-01 13:02:10.89941');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (109, 109, '01.120', '90.012', NULL, '2023-09-01 13:02:10.942984', '2023-09-01 13:02:10.942984');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (110, 110, '01.120', '90.012', NULL, '2023-09-01 13:02:10.990604', '2023-09-01 13:02:10.990604');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (111, 111, '01.120', '90.012', NULL, '2023-09-01 13:02:11.037836', '2023-09-01 13:02:11.037836');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (112, 112, '01.120', NULL, NULL, '2023-09-01 13:02:11.071607', '2023-09-01 13:02:11.071607');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (113, 113, '01.120', '90.012', NULL, '2023-09-01 13:02:11.116716', '2023-09-01 13:02:11.116716');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (114, 114, '01.120', '90.012', '70.220', '2023-09-01 13:02:11.157389', '2023-09-01 13:02:11.157389');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (115, 115, '01.120', '90.012', NULL, '2023-09-01 13:02:11.20092', '2023-09-01 13:02:11.20092');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (116, 116, '01.120', '90.012', '70.220', '2023-09-01 13:02:11.231649', '2023-09-01 13:02:11.231649');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (117, 117, '01.120', NULL, NULL, '2023-09-01 13:02:11.268854', '2023-09-01 13:02:11.268854');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (118, 118, '01.120', NULL, NULL, '2023-09-01 13:02:11.302098', '2023-09-01 13:02:11.302098');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (119, 119, '01.120', '90.012', NULL, '2023-09-01 13:02:11.339764', '2023-09-01 13:02:11.339764');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (120, 120, '01.120', NULL, NULL, '2023-09-01 13:02:11.383751', '2023-09-01 13:02:11.383751');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (121, 121, '01.120', NULL, NULL, '2023-09-01 13:02:11.425951', '2023-09-01 13:02:11.425951');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (122, 122, '01.120', '90.012', '70.220', '2023-09-01 13:02:11.458341', '2023-09-01 13:02:11.458341');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (123, 123, '01.120', NULL, NULL, '2023-09-01 13:02:11.484092', '2023-09-01 13:02:11.484092');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (124, 124, '01.120', NULL, NULL, '2023-09-01 13:02:11.537596', '2023-09-01 13:02:11.537596');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (125, 125, '01.120', '90.012', NULL, '2023-09-01 13:02:11.56608', '2023-09-01 13:02:11.56608');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (126, 126, '01.120', '90.012', NULL, '2023-09-01 13:02:11.604699', '2023-09-01 13:02:11.604699');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (127, 127, '01.120', '90.012', '70.220', '2023-09-01 13:02:11.63887', '2023-09-01 13:02:11.63887');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (128, 128, '01.120', '90.012', NULL, '2023-09-01 13:02:11.705187', '2023-09-01 13:02:11.705187');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (129, 129, '01.120', NULL, NULL, '2023-09-01 13:02:11.735977', '2023-09-01 13:02:11.735977');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (130, 130, '01.120', NULL, NULL, '2023-09-01 13:02:11.767894', '2023-09-01 13:02:11.767894');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (131, 131, '01.120', '90.012', '70.220', '2023-09-01 13:02:11.802087', '2023-09-01 13:02:11.802087');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (132, 132, '01.120', NULL, NULL, '2023-09-01 13:02:11.832559', '2023-09-01 13:02:11.832559');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (133, 133, '01.120', NULL, NULL, '2023-09-01 13:02:11.859612', '2023-09-01 13:02:11.859612');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (134, 134, '01.120', '90.012', NULL, '2023-09-01 13:02:11.896754', '2023-09-01 13:02:11.896754');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (135, 135, '01.120', NULL, NULL, '2023-09-01 13:02:11.923488', '2023-09-01 13:02:11.923488');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (136, 136, '01.120', NULL, NULL, '2023-09-01 13:02:11.96508', '2023-09-01 13:02:11.96508');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (137, 137, '01.120', '90.012', '70.220', '2023-09-01 13:02:12.018785', '2023-09-01 13:02:12.018785');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (138, 138, '01.120', '90.012', NULL, '2023-09-01 13:02:12.051687', '2023-09-01 13:02:12.051687');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (139, 139, '01.120', NULL, NULL, '2023-09-01 13:02:12.075857', '2023-09-01 13:02:12.075857');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (140, 140, '01.120', '90.012', NULL, '2023-09-01 13:02:12.114921', '2023-09-01 13:02:12.114921');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (141, 141, '01.120', NULL, NULL, '2023-09-01 13:02:12.171751', '2023-09-01 13:02:12.171751');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (142, 142, '01.120', NULL, NULL, '2023-09-01 13:02:12.211635', '2023-09-01 13:02:12.211635');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (143, 143, '01.120', NULL, NULL, '2023-09-01 13:02:12.241871', '2023-09-01 13:02:12.241871');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (144, 144, '01.120', NULL, NULL, '2023-09-01 13:02:12.285823', '2023-09-01 13:02:12.285823');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (145, 145, '01.120', NULL, NULL, '2023-09-01 13:02:12.333957', '2023-09-01 13:02:12.333957');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (146, 146, '01.120', NULL, NULL, '2023-09-01 13:02:12.368621', '2023-09-01 13:02:12.368621');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (147, 147, '01.120', '90.012', '70.220', '2023-09-01 13:02:12.392296', '2023-09-01 13:02:12.392296');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (148, 148, '01.120', NULL, NULL, '2023-09-01 13:02:12.431828', '2023-09-01 13:02:12.431828');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (149, 149, '01.120', NULL, NULL, '2023-09-01 13:02:12.482705', '2023-09-01 13:02:12.482705');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (150, 150, '01.120', NULL, NULL, '2023-09-01 13:02:12.523993', '2023-09-01 13:02:12.523993');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (151, 151, '01.120', NULL, NULL, '2023-09-01 13:02:12.562639', '2023-09-01 13:02:12.562639');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (152, 152, '01.120', '90.012', NULL, '2023-09-01 13:02:12.591414', '2023-09-01 13:02:12.591414');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (153, 153, '01.120', NULL, NULL, '2023-09-01 13:02:12.630902', '2023-09-01 13:02:12.630902');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (154, 154, '01.120', NULL, NULL, '2023-09-01 13:02:12.710049', '2023-09-01 13:02:12.710049');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (155, 155, '01.120', '90.012', NULL, '2023-09-01 13:02:12.778171', '2023-09-01 13:02:12.778171');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (156, 156, '01.120', '90.012', NULL, '2023-09-01 13:02:12.816746', '2023-09-01 13:02:12.816746');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (157, 157, '01.120', '90.012', NULL, '2023-09-01 13:02:12.860563', '2023-09-01 13:02:12.860563');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (158, 158, '01.120', NULL, NULL, '2023-09-01 13:02:12.882513', '2023-09-01 13:02:12.882513');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (159, 159, '01.120', NULL, NULL, '2023-09-01 13:02:12.915614', '2023-09-01 13:02:12.915614');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (160, 160, '01.120', NULL, NULL, '2023-09-01 13:02:12.97031', '2023-09-01 13:02:12.97031');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (161, 161, '01.120', NULL, NULL, '2023-09-01 13:02:13.002747', '2023-09-01 13:02:13.002747');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (162, 162, '01.120', NULL, NULL, '2023-09-01 13:02:13.035057', '2023-09-01 13:02:13.035057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (163, 163, '01.120', NULL, NULL, '2023-09-01 13:02:13.06602', '2023-09-01 13:02:13.06602');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (164, 164, '01.120', '90.012', NULL, '2023-09-01 13:02:13.102739', '2023-09-01 13:02:13.102739');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (165, 165, '01.120', NULL, NULL, '2023-09-01 13:02:13.13823', '2023-09-01 13:02:13.13823');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (166, 166, '01.120', NULL, NULL, '2023-09-01 13:02:13.172172', '2023-09-01 13:02:13.172172');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (167, 167, '01.120', NULL, NULL, '2023-09-01 13:02:13.204229', '2023-09-01 13:02:13.204229');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (168, 168, '01.120', NULL, NULL, '2023-09-01 13:02:13.231484', '2023-09-01 13:02:13.231484');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (169, 169, '01.120', NULL, NULL, '2023-09-01 13:02:13.271714', '2023-09-01 13:02:13.271714');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (170, 170, '01.120', NULL, NULL, '2023-09-01 13:02:13.341116', '2023-09-01 13:02:13.341116');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (171, 171, '01.120', NULL, NULL, '2023-09-01 13:02:13.410923', '2023-09-01 13:02:13.410923');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (172, 172, '01.120', NULL, NULL, '2023-09-01 13:02:13.475046', '2023-09-01 13:02:13.475046');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (173, 173, '01.120', '90.012', NULL, '2023-09-01 13:02:13.52907', '2023-09-01 13:02:13.52907');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (174, 174, '01.120', NULL, NULL, '2023-09-01 13:02:13.58147', '2023-09-01 13:02:13.58147');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (175, 175, '01.120', '90.012', '70.220', '2023-09-01 13:02:13.639719', '2023-09-01 13:02:13.639719');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (176, 176, '01.120', '90.012', NULL, '2023-09-01 13:02:13.688337', '2023-09-01 13:02:13.688337');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (177, 177, '01.120', NULL, NULL, '2023-09-01 13:02:13.741964', '2023-09-01 13:02:13.741964');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (178, 178, '01.120', NULL, NULL, '2023-09-01 13:02:13.790781', '2023-09-01 13:02:13.790781');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (179, 179, '01.120', '90.012', '70.220', '2023-09-01 13:02:13.830434', '2023-09-01 13:02:13.830434');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (180, 180, '01.120', NULL, NULL, '2023-09-01 13:02:13.877747', '2023-09-01 13:02:13.877747');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (181, 181, '01.120', '90.012', NULL, '2023-09-01 13:02:13.921971', '2023-09-01 13:02:13.921971');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (182, 182, '01.120', NULL, NULL, '2023-09-01 13:02:13.97775', '2023-09-01 13:02:13.97775');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (183, 183, '01.120', '90.012', NULL, '2023-09-01 13:02:14.060743', '2023-09-01 13:02:14.060743');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (184, 184, '01.120', NULL, NULL, '2023-09-01 13:02:14.122219', '2023-09-01 13:02:14.122219');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (185, 185, '01.120', NULL, NULL, '2023-09-01 13:02:14.186302', '2023-09-01 13:02:14.186302');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (186, 186, '01.120', NULL, NULL, '2023-09-01 13:02:14.362211', '2023-09-01 13:02:14.362211');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (187, 187, '01.120', '90.012', '70.220', '2023-09-01 13:02:14.476435', '2023-09-01 13:02:14.476435');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (188, 188, '01.120', '90.012', NULL, '2023-09-01 13:02:14.617489', '2023-09-01 13:02:14.617489');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (189, 189, '01.120', '90.012', NULL, '2023-09-01 13:02:14.685269', '2023-09-01 13:02:14.685269');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (190, 190, '01.120', '90.012', '70.220', '2023-09-01 13:02:14.729344', '2023-09-01 13:02:14.729344');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (191, 191, '01.120', '90.012', '70.220', '2023-09-01 13:02:14.78084', '2023-09-01 13:02:14.78084');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (192, 192, '01.120', NULL, NULL, '2023-09-01 13:02:14.83329', '2023-09-01 13:02:14.83329');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (193, 193, '01.120', NULL, NULL, '2023-09-01 13:02:14.898101', '2023-09-01 13:02:14.898101');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (194, 194, '01.120', NULL, NULL, '2023-09-01 13:02:14.941121', '2023-09-01 13:02:14.941121');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (195, 195, '01.120', '90.012', '70.220', '2023-09-01 13:02:14.998165', '2023-09-01 13:02:14.998165');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (196, 196, '01.120', NULL, NULL, '2023-09-01 13:02:15.034031', '2023-09-01 13:02:15.034031');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (197, 197, '01.120', '90.012', '70.220', '2023-09-01 13:02:15.073356', '2023-09-01 13:02:15.073356');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (198, 198, '01.120', NULL, NULL, '2023-09-01 13:02:15.126189', '2023-09-01 13:02:15.126189');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (199, 199, '01.120', '90.012', NULL, '2023-09-01 13:02:15.170701', '2023-09-01 13:02:15.170701');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (200, 200, '01.120', NULL, NULL, '2023-09-01 13:02:15.229803', '2023-09-01 13:02:15.229803');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (201, 201, '01.120', NULL, NULL, '2023-09-01 13:02:15.264216', '2023-09-01 13:02:15.264216');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (202, 202, '01.120', '90.012', NULL, '2023-09-01 13:02:15.311052', '2023-09-01 13:02:15.311052');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (203, 203, '01.120', NULL, NULL, '2023-09-01 13:02:15.369933', '2023-09-01 13:02:15.369933');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (204, 204, '01.120', NULL, NULL, '2023-09-01 13:02:15.444769', '2023-09-01 13:02:15.444769');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (205, 205, '01.120', '90.012', '70.220', '2023-09-01 13:02:15.682451', '2023-09-01 13:02:15.682451');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (206, 206, '01.120', '90.012', NULL, '2023-09-01 13:02:15.713843', '2023-09-01 13:02:15.713843');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (207, 207, '01.120', '90.012', '70.220', '2023-09-01 13:02:15.752062', '2023-09-01 13:02:15.752062');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (208, 208, '01.120', '90.012', NULL, '2023-09-01 13:02:15.79925', '2023-09-01 13:02:15.79925');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (209, 209, '01.120', '90.012', NULL, '2023-09-01 13:02:15.841827', '2023-09-01 13:02:15.841827');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (210, 210, '01.120', '90.012', NULL, '2023-09-01 13:02:15.886909', '2023-09-01 13:02:15.886909');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (211, 211, '01.120', NULL, NULL, '2023-09-01 13:02:15.940281', '2023-09-01 13:02:15.940281');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (212, 212, '01.120', NULL, NULL, '2023-09-01 13:02:15.986992', '2023-09-01 13:02:15.986992');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (213, 213, '01.120', NULL, NULL, '2023-09-01 13:02:16.024173', '2023-09-01 13:02:16.024173');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (214, 214, '01.120', NULL, NULL, '2023-09-01 13:02:16.069448', '2023-09-01 13:02:16.069448');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (215, 215, '01.120', NULL, NULL, '2023-09-01 13:02:16.104108', '2023-09-01 13:02:16.104108');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (216, 216, '01.120', '90.012', '70.220', '2023-09-01 13:02:16.146327', '2023-09-01 13:02:16.146327');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (217, 217, '01.120', NULL, NULL, '2023-09-01 13:02:16.190731', '2023-09-01 13:02:16.190731');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (218, 218, '01.120', '90.012', '70.220', '2023-09-01 13:02:16.370498', '2023-09-01 13:02:16.370498');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (219, 219, '01.120', '90.012', '70.220', '2023-09-01 13:02:16.407785', '2023-09-01 13:02:16.407785');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (220, 220, '01.120', NULL, NULL, '2023-09-01 13:02:16.474727', '2023-09-01 13:02:16.474727');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (221, 221, '01.120', '90.012', NULL, '2023-09-01 13:02:16.51271', '2023-09-01 13:02:16.51271');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (222, 222, '01.120', '90.012', NULL, '2023-09-01 13:02:16.572263', '2023-09-01 13:02:16.572263');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (223, 223, '01.120', NULL, NULL, '2023-09-01 13:02:16.621528', '2023-09-01 13:02:16.621528');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (224, 224, '01.120', NULL, NULL, '2023-09-01 13:02:16.664148', '2023-09-01 13:02:16.664148');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (225, 225, '01.120', NULL, NULL, '2023-09-01 13:02:16.709451', '2023-09-01 13:02:16.709451');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (226, 226, '01.120', NULL, NULL, '2023-09-01 13:02:16.746644', '2023-09-01 13:02:16.746644');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (227, 227, '01.120', NULL, NULL, '2023-09-01 13:02:16.787505', '2023-09-01 13:02:16.787505');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (228, 228, '01.120', '90.012', NULL, '2023-09-01 13:02:16.813809', '2023-09-01 13:02:16.813809');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (229, 229, '01.120', NULL, NULL, '2023-09-01 13:02:16.84242', '2023-09-01 13:02:16.84242');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (230, 230, '01.120', NULL, NULL, '2023-09-01 13:02:16.884707', '2023-09-01 13:02:16.884707');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (231, 231, '01.120', NULL, NULL, '2023-09-01 13:02:16.9206', '2023-09-01 13:02:16.9206');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (232, 232, '01.120', NULL, NULL, '2023-09-01 13:02:16.951444', '2023-09-01 13:02:16.951444');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (233, 233, '01.120', NULL, NULL, '2023-09-01 13:02:17.007613', '2023-09-01 13:02:17.007613');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (234, 234, '01.120', '90.012', '70.220', '2023-09-01 13:02:17.056867', '2023-09-01 13:02:17.056867');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (235, 235, '01.120', '90.012', NULL, '2023-09-01 13:02:17.091257', '2023-09-01 13:02:17.091257');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (236, 236, '01.120', '90.012', '70.220', '2023-09-01 13:02:17.129048', '2023-09-01 13:02:17.129048');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (237, 237, '01.120', '90.012', NULL, '2023-09-01 13:02:17.151445', '2023-09-01 13:02:17.151445');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (238, 238, '01.120', '90.012', NULL, '2023-09-01 13:02:17.204327', '2023-09-01 13:02:17.204327');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (239, 239, '01.120', NULL, NULL, '2023-09-01 13:02:17.249976', '2023-09-01 13:02:17.249976');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (240, 240, '01.120', NULL, NULL, '2023-09-01 13:02:17.301379', '2023-09-01 13:02:17.301379');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (241, 241, '01.120', NULL, NULL, '2023-09-01 13:02:17.345072', '2023-09-01 13:02:17.345072');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (242, 242, '01.120', NULL, NULL, '2023-09-01 13:02:17.387021', '2023-09-01 13:02:17.387021');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (243, 243, '01.120', NULL, NULL, '2023-09-01 13:02:17.444139', '2023-09-01 13:02:17.444139');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (244, 244, '01.120', '90.012', '70.220', '2023-09-01 13:02:17.499015', '2023-09-01 13:02:17.499015');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (245, 245, '01.120', '90.012', NULL, '2023-09-01 13:02:17.549461', '2023-09-01 13:02:17.549461');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (246, 246, '01.120', '90.012', '70.220', '2023-09-01 13:02:17.583783', '2023-09-01 13:02:17.583783');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (247, 247, '01.120', NULL, NULL, '2023-09-01 13:02:17.617912', '2023-09-01 13:02:17.617912');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (248, 248, '01.120', NULL, NULL, '2023-09-01 13:02:17.671672', '2023-09-01 13:02:17.671672');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (249, 249, '01.120', NULL, NULL, '2023-09-01 13:02:17.732243', '2023-09-01 13:02:17.732243');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (250, 250, '01.120', '90.012', '70.220', '2023-09-01 13:02:17.782352', '2023-09-01 13:02:17.782352');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (251, 251, '01.120', '90.012', '70.220', '2023-09-01 13:02:17.829857', '2023-09-01 13:02:17.829857');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (252, 252, '01.120', NULL, NULL, '2023-09-01 13:02:17.881057', '2023-09-01 13:02:17.881057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (253, 253, '01.120', '90.012', '70.220', '2023-09-01 13:02:17.938297', '2023-09-01 13:02:17.938297');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (254, 254, '01.120', NULL, NULL, '2023-09-01 13:02:17.993242', '2023-09-01 13:02:17.993242');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (255, 255, '01.120', NULL, NULL, '2023-09-01 13:02:18.044711', '2023-09-01 13:02:18.044711');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (256, 256, '01.120', '90.012', NULL, '2023-09-01 13:02:18.082237', '2023-09-01 13:02:18.082237');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (257, 257, '01.120', NULL, NULL, '2023-09-01 13:02:18.12245', '2023-09-01 13:02:18.12245');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (258, 258, '01.120', '90.012', NULL, '2023-09-01 13:02:18.159562', '2023-09-01 13:02:18.159562');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (259, 259, '01.120', NULL, NULL, '2023-09-01 13:02:18.20344', '2023-09-01 13:02:18.20344');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (260, 260, '01.120', '90.012', NULL, '2023-09-01 13:02:18.23571', '2023-09-01 13:02:18.23571');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (261, 261, '01.120', '90.012', '70.220', '2023-09-01 13:02:18.262459', '2023-09-01 13:02:18.262459');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (262, 262, '01.120', '90.012', NULL, '2023-09-01 13:02:18.311656', '2023-09-01 13:02:18.311656');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (263, 263, '01.120', '90.012', '70.220', '2023-09-01 13:02:18.363308', '2023-09-01 13:02:18.363308');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (264, 264, '01.120', NULL, NULL, '2023-09-01 13:02:18.413972', '2023-09-01 13:02:18.413972');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (265, 265, '01.120', '90.012', NULL, '2023-09-01 13:02:18.475739', '2023-09-01 13:02:18.475739');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (266, 266, '01.120', NULL, NULL, '2023-09-01 13:02:18.524875', '2023-09-01 13:02:18.524875');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (267, 267, '01.120', NULL, NULL, '2023-09-01 13:02:18.560544', '2023-09-01 13:02:18.560544');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (268, 268, '01.120', NULL, NULL, '2023-09-01 13:02:18.618399', '2023-09-01 13:02:18.618399');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (269, 269, '01.120', NULL, NULL, '2023-09-01 13:02:18.665882', '2023-09-01 13:02:18.665882');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (270, 270, '01.120', NULL, NULL, '2023-09-01 13:02:18.708233', '2023-09-01 13:02:18.708233');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (271, 271, '01.120', NULL, NULL, '2023-09-01 13:02:18.742812', '2023-09-01 13:02:18.742812');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (272, 272, '01.120', '90.012', NULL, '2023-09-01 13:02:18.782192', '2023-09-01 13:02:18.782192');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (273, 273, '01.120', '90.012', NULL, '2023-09-01 13:02:18.83344', '2023-09-01 13:02:18.83344');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (274, 274, '01.120', '90.012', '70.220', '2023-09-01 13:02:18.91749', '2023-09-01 13:02:18.91749');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (275, 275, '01.120', NULL, NULL, '2023-09-01 13:02:18.965213', '2023-09-01 13:02:18.965213');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (276, 276, '01.120', '90.012', '70.220', '2023-09-01 13:02:19.013005', '2023-09-01 13:02:19.013005');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (277, 277, '01.120', '90.012', NULL, '2023-09-01 13:02:19.068505', '2023-09-01 13:02:19.068505');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (278, 278, '01.120', NULL, NULL, '2023-09-01 13:02:19.108419', '2023-09-01 13:02:19.108419');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (279, 279, '01.120', '90.012', '70.220', '2023-09-01 13:02:19.146071', '2023-09-01 13:02:19.146071');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (280, 280, '01.120', '90.012', NULL, '2023-09-01 13:02:19.203802', '2023-09-01 13:02:19.203802');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (281, 281, '01.120', NULL, NULL, '2023-09-01 13:02:19.243368', '2023-09-01 13:02:19.243368');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (282, 282, '01.120', NULL, NULL, '2023-09-01 13:02:19.311762', '2023-09-01 13:02:19.311762');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (283, 283, '01.120', '90.012', NULL, '2023-09-01 13:02:19.3664', '2023-09-01 13:02:19.3664');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (284, 284, '01.120', NULL, NULL, '2023-09-01 13:02:19.423223', '2023-09-01 13:02:19.423223');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (285, 285, '01.120', '90.012', NULL, '2023-09-01 13:02:19.464693', '2023-09-01 13:02:19.464693');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (286, 286, '01.120', NULL, NULL, '2023-09-01 13:02:19.535379', '2023-09-01 13:02:19.535379');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (287, 287, '01.120', '90.012', NULL, '2023-09-01 13:02:19.583724', '2023-09-01 13:02:19.583724');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (288, 288, '01.120', '90.012', '70.220', '2023-09-01 13:02:19.622315', '2023-09-01 13:02:19.622315');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (289, 289, '01.120', '90.012', NULL, '2023-09-01 13:02:19.649686', '2023-09-01 13:02:19.649686');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (290, 290, '01.120', NULL, NULL, '2023-09-01 13:02:19.698778', '2023-09-01 13:02:19.698778');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (291, 291, '01.120', '90.012', NULL, '2023-09-01 13:02:19.75193', '2023-09-01 13:02:19.75193');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (292, 292, '01.120', '90.012', NULL, '2023-09-01 13:02:19.817946', '2023-09-01 13:02:19.817946');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (293, 293, '01.120', '90.012', '70.220', '2023-09-01 13:02:19.872466', '2023-09-01 13:02:19.872466');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (294, 294, '01.120', '90.012', NULL, '2023-09-01 13:02:19.917552', '2023-09-01 13:02:19.917552');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (295, 295, '01.120', NULL, NULL, '2023-09-01 13:02:19.97513', '2023-09-01 13:02:19.97513');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (296, 296, '01.120', '90.012', NULL, '2023-09-01 13:02:20.026026', '2023-09-01 13:02:20.026026');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (297, 297, '01.120', '90.012', '70.220', '2023-09-01 13:02:20.070433', '2023-09-01 13:02:20.070433');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (298, 298, '01.120', NULL, NULL, '2023-09-01 13:02:20.116791', '2023-09-01 13:02:20.116791');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (299, 299, '01.120', NULL, NULL, '2023-09-01 13:02:20.179867', '2023-09-01 13:02:20.179867');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (300, 300, '01.120', NULL, NULL, '2023-09-01 13:02:20.230987', '2023-09-01 13:02:20.230987');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (301, 301, '01.120', NULL, NULL, '2023-09-01 13:02:20.281024', '2023-09-01 13:02:20.281024');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (302, 302, '01.120', '90.012', NULL, '2023-09-01 13:02:20.31659', '2023-09-01 13:02:20.31659');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (303, 303, '01.120', '90.012', NULL, '2023-09-01 13:02:20.375964', '2023-09-01 13:02:20.375964');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (304, 304, '01.120', NULL, NULL, '2023-09-01 13:02:20.418003', '2023-09-01 13:02:20.418003');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (305, 305, '01.120', NULL, NULL, '2023-09-01 13:02:20.475668', '2023-09-01 13:02:20.475668');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (306, 306, '01.120', '90.012', NULL, '2023-09-01 13:02:20.570029', '2023-09-01 13:02:20.570029');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (307, 307, '01.120', '90.012', '70.220', '2023-09-01 13:02:20.662901', '2023-09-01 13:02:20.662901');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (308, 308, '01.120', NULL, NULL, '2023-09-01 13:02:20.722119', '2023-09-01 13:02:20.722119');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (309, 309, '01.120', NULL, NULL, '2023-09-01 13:02:20.803649', '2023-09-01 13:02:20.803649');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (310, 310, '01.120', NULL, NULL, '2023-09-01 13:02:20.857144', '2023-09-01 13:02:20.857144');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (311, 311, '01.120', NULL, NULL, '2023-09-01 13:02:20.922932', '2023-09-01 13:02:20.922932');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (312, 312, '01.120', '90.012', NULL, '2023-09-01 13:02:21.019627', '2023-09-01 13:02:21.019627');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (313, 313, '01.120', NULL, NULL, '2023-09-01 13:02:21.050861', '2023-09-01 13:02:21.050861');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (314, 314, '01.120', '90.012', NULL, '2023-09-01 13:02:21.091953', '2023-09-01 13:02:21.091953');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (315, 315, '01.120', NULL, NULL, '2023-09-01 13:02:21.125826', '2023-09-01 13:02:21.125826');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (316, 316, '01.120', NULL, NULL, '2023-09-01 13:02:21.169356', '2023-09-01 13:02:21.169356');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (317, 317, '01.120', NULL, NULL, '2023-09-01 13:02:21.189273', '2023-09-01 13:02:21.189273');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (318, 318, '01.120', '90.012', NULL, '2023-09-01 13:02:21.217583', '2023-09-01 13:02:21.217583');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (319, 319, '01.120', NULL, NULL, '2023-09-01 13:02:21.263332', '2023-09-01 13:02:21.263332');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (320, 320, '01.120', NULL, NULL, '2023-09-01 13:02:21.314369', '2023-09-01 13:02:21.314369');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (321, 321, '01.120', '90.012', NULL, '2023-09-01 13:02:21.354193', '2023-09-01 13:02:21.354193');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (322, 322, '01.120', NULL, NULL, '2023-09-01 13:02:21.399657', '2023-09-01 13:02:21.399657');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (323, 323, '01.120', NULL, NULL, '2023-09-01 13:02:21.449325', '2023-09-01 13:02:21.449325');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (324, 324, '01.120', '90.012', NULL, '2023-09-01 13:02:21.487958', '2023-09-01 13:02:21.487958');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (325, 325, '01.120', NULL, NULL, '2023-09-01 13:02:21.547997', '2023-09-01 13:02:21.547997');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (326, 326, '01.120', NULL, NULL, '2023-09-01 13:02:21.596869', '2023-09-01 13:02:21.596869');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (327, 327, '01.120', '90.012', '70.220', '2023-09-01 13:02:21.634314', '2023-09-01 13:02:21.634314');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (328, 328, '01.120', NULL, NULL, '2023-09-01 13:02:21.689835', '2023-09-01 13:02:21.689835');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (329, 329, '01.120', '90.012', NULL, '2023-09-01 13:02:21.723098', '2023-09-01 13:02:21.723098');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (330, 330, '01.120', NULL, NULL, '2023-09-01 13:02:21.74949', '2023-09-01 13:02:21.74949');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (331, 331, '01.120', '90.012', NULL, '2023-09-01 13:02:21.783705', '2023-09-01 13:02:21.783705');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (332, 332, '01.120', NULL, NULL, '2023-09-01 13:02:21.804172', '2023-09-01 13:02:21.804172');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (333, 333, '01.120', NULL, NULL, '2023-09-01 13:02:21.83136', '2023-09-01 13:02:21.83136');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (334, 334, '01.120', NULL, NULL, '2023-09-01 13:02:21.872294', '2023-09-01 13:02:21.872294');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (335, 335, '01.120', '90.012', NULL, '2023-09-01 13:02:21.899907', '2023-09-01 13:02:21.899907');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (336, 336, '01.120', '90.012', NULL, '2023-09-01 13:02:21.929263', '2023-09-01 13:02:21.929263');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (337, 337, '01.120', '90.012', NULL, '2023-09-01 13:02:21.970064', '2023-09-01 13:02:21.970064');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (338, 338, '01.120', '90.012', '70.220', '2023-09-01 13:02:22.022248', '2023-09-01 13:02:22.022248');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (339, 339, '01.120', NULL, NULL, '2023-09-01 13:02:22.052842', '2023-09-01 13:02:22.052842');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (340, 340, '01.120', NULL, NULL, '2023-09-01 13:02:22.091141', '2023-09-01 13:02:22.091141');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (341, 341, '01.120', NULL, NULL, '2023-09-01 13:02:22.113648', '2023-09-01 13:02:22.113648');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (342, 342, '01.120', NULL, NULL, '2023-09-01 13:02:22.166118', '2023-09-01 13:02:22.166118');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (343, 343, '01.120', '90.012', '70.220', '2023-09-01 13:02:22.229825', '2023-09-01 13:02:22.229825');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (344, 344, '01.120', '90.012', NULL, '2023-09-01 13:02:22.265864', '2023-09-01 13:02:22.265864');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (345, 345, '01.120', NULL, NULL, '2023-09-01 13:02:22.308219', '2023-09-01 13:02:22.308219');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (346, 346, '01.120', NULL, NULL, '2023-09-01 13:02:22.340238', '2023-09-01 13:02:22.340238');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (347, 347, '01.120', NULL, NULL, '2023-09-01 13:02:22.366871', '2023-09-01 13:02:22.366871');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (348, 348, '01.120', '90.012', NULL, '2023-09-01 13:02:22.414112', '2023-09-01 13:02:22.414112');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (349, 349, '01.120', '90.012', NULL, '2023-09-01 13:02:22.441556', '2023-09-01 13:02:22.441556');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (350, 350, '01.120', '90.012', '70.220', '2023-09-01 13:02:22.470949', '2023-09-01 13:02:22.470949');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (351, 351, '01.120', '90.012', '70.220', '2023-09-01 13:02:22.515789', '2023-09-01 13:02:22.515789');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (352, 352, '01.120', NULL, NULL, '2023-09-01 13:02:22.54658', '2023-09-01 13:02:22.54658');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (353, 353, '01.120', '90.012', NULL, '2023-09-01 13:02:22.603881', '2023-09-01 13:02:22.603881');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (354, 354, '01.120', NULL, NULL, '2023-09-01 13:02:22.640909', '2023-09-01 13:02:22.640909');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (355, 355, '01.120', NULL, NULL, '2023-09-01 13:02:22.691186', '2023-09-01 13:02:22.691186');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (356, 356, '01.120', '90.012', NULL, '2023-09-01 13:02:22.711978', '2023-09-01 13:02:22.711978');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (357, 357, '01.120', NULL, NULL, '2023-09-01 13:02:22.737831', '2023-09-01 13:02:22.737831');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (358, 358, '01.120', NULL, NULL, '2023-09-01 13:02:22.76486', '2023-09-01 13:02:22.76486');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (359, 359, '01.120', '90.012', NULL, '2023-09-01 13:02:22.83714', '2023-09-01 13:02:22.83714');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (360, 360, '01.120', NULL, NULL, '2023-09-01 13:02:22.873845', '2023-09-01 13:02:22.873845');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (361, 361, '01.120', '90.012', NULL, '2023-09-01 13:02:22.922334', '2023-09-01 13:02:22.922334');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (362, 362, '01.120', '90.012', '70.220', '2023-09-01 13:02:22.966081', '2023-09-01 13:02:22.966081');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (363, 363, '01.120', NULL, NULL, '2023-09-01 13:02:23.006782', '2023-09-01 13:02:23.006782');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (364, 364, '01.120', NULL, NULL, '2023-09-01 13:02:23.036869', '2023-09-01 13:02:23.036869');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (365, 365, '01.120', NULL, NULL, '2023-09-01 13:02:23.063758', '2023-09-01 13:02:23.063758');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (366, 366, '01.120', '90.012', NULL, '2023-09-01 13:02:23.093066', '2023-09-01 13:02:23.093066');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (367, 367, '01.120', NULL, NULL, '2023-09-01 13:02:23.122379', '2023-09-01 13:02:23.122379');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (368, 368, '01.120', '90.012', NULL, '2023-09-01 13:02:23.174433', '2023-09-01 13:02:23.174433');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (369, 369, '01.120', NULL, NULL, '2023-09-01 13:02:23.213829', '2023-09-01 13:02:23.213829');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (370, 370, '01.120', '90.012', NULL, '2023-09-01 13:02:23.26432', '2023-09-01 13:02:23.26432');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (371, 371, '01.120', '90.012', NULL, '2023-09-01 13:02:23.30199', '2023-09-01 13:02:23.30199');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (372, 372, '01.120', '90.012', NULL, '2023-09-01 13:02:23.341504', '2023-09-01 13:02:23.341504');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (373, 373, '01.120', '90.012', '70.220', '2023-09-01 13:02:23.386287', '2023-09-01 13:02:23.386287');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (374, 374, '01.120', '90.012', NULL, '2023-09-01 13:02:23.439694', '2023-09-01 13:02:23.439694');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (375, 375, '01.120', NULL, NULL, '2023-09-01 13:02:23.504893', '2023-09-01 13:02:23.504893');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (376, 376, '01.120', NULL, NULL, '2023-09-01 13:02:23.547587', '2023-09-01 13:02:23.547587');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (377, 377, '01.120', NULL, NULL, '2023-09-01 13:02:23.591215', '2023-09-01 13:02:23.591215');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (378, 378, '01.120', NULL, NULL, '2023-09-01 13:02:23.619088', '2023-09-01 13:02:23.619088');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (379, 379, '01.120', NULL, NULL, '2023-09-01 13:02:23.647858', '2023-09-01 13:02:23.647858');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (380, 380, '01.120', '90.012', NULL, '2023-09-01 13:02:23.685506', '2023-09-01 13:02:23.685506');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (381, 381, '01.120', NULL, NULL, '2023-09-01 13:02:23.711794', '2023-09-01 13:02:23.711794');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (382, 382, '01.120', '90.012', '70.220', '2023-09-01 13:02:23.753404', '2023-09-01 13:02:23.753404');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (383, 383, '01.120', NULL, NULL, '2023-09-01 13:02:23.788841', '2023-09-01 13:02:23.788841');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (384, 384, '01.120', NULL, NULL, '2023-09-01 13:02:23.820265', '2023-09-01 13:02:23.820265');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (385, 385, '01.120', NULL, NULL, '2023-09-01 13:02:23.86137', '2023-09-01 13:02:23.86137');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (386, 386, '01.120', '90.012', NULL, '2023-09-01 13:02:23.899448', '2023-09-01 13:02:23.899448');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (387, 387, '01.120', NULL, NULL, '2023-09-01 13:02:23.92987', '2023-09-01 13:02:23.92987');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (388, 388, '01.120', NULL, NULL, '2023-09-01 13:02:23.965517', '2023-09-01 13:02:23.965517');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (389, 389, '01.120', '90.012', '70.220', '2023-09-01 13:02:23.987581', '2023-09-01 13:02:23.987581');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (390, 390, '01.120', '90.012', '70.220', '2023-09-01 13:02:24.023496', '2023-09-01 13:02:24.023496');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (391, 391, '01.120', '90.012', '70.220', '2023-09-01 13:02:24.045733', '2023-09-01 13:02:24.045733');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (392, 392, '01.120', '90.012', NULL, '2023-09-01 13:02:24.074727', '2023-09-01 13:02:24.074727');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (393, 393, '01.120', '90.012', NULL, '2023-09-01 13:02:24.107443', '2023-09-01 13:02:24.107443');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (394, 394, '01.120', NULL, NULL, '2023-09-01 13:02:24.137929', '2023-09-01 13:02:24.137929');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (395, 395, '01.120', '90.012', NULL, '2023-09-01 13:02:24.154308', '2023-09-01 13:02:24.154308');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (396, 396, '01.120', '90.012', '70.220', '2023-09-01 13:02:24.177498', '2023-09-01 13:02:24.177498');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (397, 397, '01.120', '90.012', '70.220', '2023-09-01 13:02:24.197759', '2023-09-01 13:02:24.197759');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (398, 398, '01.120', '90.012', NULL, '2023-09-01 13:02:24.21922', '2023-09-01 13:02:24.21922');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (399, 399, '01.120', NULL, NULL, '2023-09-01 13:02:24.239917', '2023-09-01 13:02:24.239917');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (400, 400, '01.120', NULL, NULL, '2023-09-01 13:02:24.267601', '2023-09-01 13:02:24.267601');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (401, 401, '01.120', '90.012', '70.220', '2023-09-01 13:02:24.300488', '2023-09-01 13:02:24.300488');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (402, 402, '01.120', '90.012', NULL, '2023-09-01 13:02:24.383643', '2023-09-01 13:02:24.383643');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (403, 403, '01.120', NULL, NULL, '2023-09-01 13:02:24.44236', '2023-09-01 13:02:24.44236');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (404, 404, '01.120', '90.012', NULL, '2023-09-01 13:02:24.542383', '2023-09-01 13:02:24.542383');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (405, 405, '01.120', '90.012', '70.220', '2023-09-01 13:02:24.632158', '2023-09-01 13:02:24.632158');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (406, 406, '01.120', NULL, NULL, '2023-09-01 13:02:24.689273', '2023-09-01 13:02:24.689273');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (407, 407, '01.120', '90.012', NULL, '2023-09-01 13:02:24.733583', '2023-09-01 13:02:24.733583');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (408, 408, '01.120', '90.012', '70.220', '2023-09-01 13:02:24.78058', '2023-09-01 13:02:24.78058');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (409, 409, '01.120', NULL, NULL, '2023-09-01 13:02:24.853049', '2023-09-01 13:02:24.853049');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (410, 410, '01.120', NULL, NULL, '2023-09-01 13:02:24.937057', '2023-09-01 13:02:24.937057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (411, 411, '01.120', '90.012', NULL, '2023-09-01 13:02:25.003484', '2023-09-01 13:02:25.003484');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (412, 412, '01.120', '90.012', NULL, '2023-09-01 13:02:25.068111', '2023-09-01 13:02:25.068111');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (413, 413, '01.120', NULL, NULL, '2023-09-01 13:02:25.111368', '2023-09-01 13:02:25.111368');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (414, 414, '01.120', NULL, NULL, '2023-09-01 13:02:25.168421', '2023-09-01 13:02:25.168421');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (415, 415, '01.120', NULL, NULL, '2023-09-01 13:02:25.27296', '2023-09-01 13:02:25.27296');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (416, 416, '01.120', NULL, NULL, '2023-09-01 13:02:25.329072', '2023-09-01 13:02:25.329072');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (417, 417, '01.120', NULL, NULL, '2023-09-01 13:02:25.375661', '2023-09-01 13:02:25.375661');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (418, 418, '01.120', NULL, NULL, '2023-09-01 13:02:25.422949', '2023-09-01 13:02:25.422949');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (419, 419, '01.120', NULL, NULL, '2023-09-01 13:02:25.465705', '2023-09-01 13:02:25.465705');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (420, 420, '01.120', '90.012', NULL, '2023-09-01 13:02:25.571448', '2023-09-01 13:02:25.571448');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (421, 421, '01.120', NULL, NULL, '2023-09-01 13:02:25.621226', '2023-09-01 13:02:25.621226');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (422, 422, '01.120', NULL, NULL, '2023-09-01 13:02:25.676872', '2023-09-01 13:02:25.676872');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (423, 423, '01.120', NULL, NULL, '2023-09-01 13:02:25.821065', '2023-09-01 13:02:25.821065');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (424, 424, '01.120', '90.012', '70.220', '2023-09-01 13:02:25.897467', '2023-09-01 13:02:25.897467');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (425, 425, '01.120', '90.012', '70.220', '2023-09-01 13:02:25.947984', '2023-09-01 13:02:25.947984');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (426, 426, '01.120', NULL, NULL, '2023-09-01 13:02:26.004341', '2023-09-01 13:02:26.004341');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (427, 427, '01.120', NULL, NULL, '2023-09-01 13:02:26.269203', '2023-09-01 13:02:26.269203');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (428, 428, '01.120', '90.012', NULL, '2023-09-01 13:02:26.637246', '2023-09-01 13:02:26.637246');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (429, 429, '01.120', '90.012', NULL, '2023-09-01 13:02:26.703305', '2023-09-01 13:02:26.703305');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (430, 430, '01.120', NULL, NULL, '2023-09-01 13:02:26.803192', '2023-09-01 13:02:26.803192');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (431, 431, '01.120', NULL, NULL, '2023-09-01 13:02:26.930433', '2023-09-01 13:02:26.930433');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (432, 432, '01.120', '90.012', '70.220', '2023-09-01 13:02:27.100803', '2023-09-01 13:02:27.100803');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (433, 433, '01.120', '90.012', NULL, '2023-09-01 13:02:27.182813', '2023-09-01 13:02:27.182813');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (434, 434, '01.120', NULL, NULL, '2023-09-01 13:02:27.255117', '2023-09-01 13:02:27.255117');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (435, 435, '01.120', NULL, NULL, '2023-09-01 13:02:27.32246', '2023-09-01 13:02:27.32246');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (436, 436, '01.120', '90.012', '70.220', '2023-09-01 13:02:27.388176', '2023-09-01 13:02:27.388176');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (437, 437, '01.120', NULL, NULL, '2023-09-01 13:02:27.473221', '2023-09-01 13:02:27.473221');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (438, 438, '01.120', '90.012', '70.220', '2023-09-01 13:02:27.586072', '2023-09-01 13:02:27.586072');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (439, 439, '01.120', NULL, NULL, '2023-09-01 13:02:27.721457', '2023-09-01 13:02:27.721457');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (440, 440, '01.120', '90.012', NULL, '2023-09-01 13:02:27.798643', '2023-09-01 13:02:27.798643');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (441, 441, '01.120', '90.012', NULL, '2023-09-01 13:02:27.874659', '2023-09-01 13:02:27.874659');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (442, 442, '01.120', NULL, NULL, '2023-09-01 13:02:27.985242', '2023-09-01 13:02:27.985242');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (443, 443, '01.120', NULL, NULL, '2023-09-01 13:02:28.044845', '2023-09-01 13:02:28.044845');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (444, 444, '01.120', NULL, NULL, '2023-09-01 13:02:28.092028', '2023-09-01 13:02:28.092028');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (445, 445, '01.120', '90.012', NULL, '2023-09-01 13:02:28.140169', '2023-09-01 13:02:28.140169');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (446, 446, '01.120', '90.012', NULL, '2023-09-01 13:02:28.182227', '2023-09-01 13:02:28.182227');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (447, 447, '01.120', '90.012', '70.220', '2023-09-01 13:02:28.241345', '2023-09-01 13:02:28.241345');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (448, 448, '01.120', NULL, NULL, '2023-09-01 13:02:28.269731', '2023-09-01 13:02:28.269731');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (449, 449, '01.120', '90.012', '70.220', '2023-09-01 13:02:28.299421', '2023-09-01 13:02:28.299421');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (450, 450, '01.120', NULL, NULL, '2023-09-01 13:02:28.333731', '2023-09-01 13:02:28.333731');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (451, 451, '01.120', NULL, NULL, '2023-09-01 13:02:28.380644', '2023-09-01 13:02:28.380644');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (452, 452, '01.120', '90.012', NULL, '2023-09-01 13:02:28.425016', '2023-09-01 13:02:28.425016');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (453, 453, '01.120', '90.012', NULL, '2023-09-01 13:02:28.465525', '2023-09-01 13:02:28.465525');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (454, 454, '01.120', '90.012', '70.220', '2023-09-01 13:02:28.516409', '2023-09-01 13:02:28.516409');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (455, 455, '01.120', NULL, NULL, '2023-09-01 13:02:28.5618', '2023-09-01 13:02:28.5618');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (456, 456, '01.120', NULL, NULL, '2023-09-01 13:02:28.633393', '2023-09-01 13:02:28.633393');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (457, 457, '01.120', '90.012', NULL, '2023-09-01 13:02:28.735388', '2023-09-01 13:02:28.735388');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (458, 458, '01.120', NULL, NULL, '2023-09-01 13:02:28.777558', '2023-09-01 13:02:28.777558');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (459, 459, '01.120', '90.012', '70.220', '2023-09-01 13:02:28.809159', '2023-09-01 13:02:28.809159');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (460, 460, '01.120', NULL, NULL, '2023-09-01 13:02:28.837802', '2023-09-01 13:02:28.837802');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (461, 461, '01.120', '90.012', NULL, '2023-09-01 13:02:28.867658', '2023-09-01 13:02:28.867658');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (462, 462, '01.120', '90.012', NULL, '2023-09-01 13:02:28.904856', '2023-09-01 13:02:28.904856');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (463, 463, '01.120', '90.012', NULL, '2023-09-01 13:02:28.940752', '2023-09-01 13:02:28.940752');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (464, 464, '01.120', NULL, NULL, '2023-09-01 13:02:28.989422', '2023-09-01 13:02:28.989422');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (465, 465, '01.120', NULL, NULL, '2023-09-01 13:02:29.039989', '2023-09-01 13:02:29.039989');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (466, 466, '01.120', '90.012', '70.220', '2023-09-01 13:02:29.08067', '2023-09-01 13:02:29.08067');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (467, 467, '01.120', NULL, NULL, '2023-09-01 13:02:29.12117', '2023-09-01 13:02:29.12117');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (468, 468, '01.120', '90.012', NULL, '2023-09-01 13:02:29.151403', '2023-09-01 13:02:29.151403');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (469, 469, '01.120', '90.012', NULL, '2023-09-01 13:02:29.202117', '2023-09-01 13:02:29.202117');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (470, 470, '01.120', NULL, NULL, '2023-09-01 13:02:29.376355', '2023-09-01 13:02:29.376355');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (471, 471, '01.120', '90.012', NULL, '2023-09-01 13:02:29.416767', '2023-09-01 13:02:29.416767');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (472, 472, '01.120', '90.012', NULL, '2023-09-01 13:02:29.467999', '2023-09-01 13:02:29.467999');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (473, 473, '01.120', NULL, NULL, '2023-09-01 13:02:29.509904', '2023-09-01 13:02:29.509904');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (474, 474, '01.120', NULL, NULL, '2023-09-01 13:02:29.547957', '2023-09-01 13:02:29.547957');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (475, 475, '01.120', '90.012', NULL, '2023-09-01 13:02:29.623485', '2023-09-01 13:02:29.623485');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (476, 476, '01.120', '90.012', NULL, '2023-09-01 13:02:29.669354', '2023-09-01 13:02:29.669354');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (477, 477, '01.120', NULL, NULL, '2023-09-01 13:02:29.696561', '2023-09-01 13:02:29.696561');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (478, 478, '01.120', NULL, NULL, '2023-09-01 13:02:29.724721', '2023-09-01 13:02:29.724721');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (479, 479, '01.120', '90.012', NULL, '2023-09-01 13:02:29.752498', '2023-09-01 13:02:29.752498');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (480, 480, '01.120', NULL, NULL, '2023-09-01 13:02:29.800318', '2023-09-01 13:02:29.800318');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (481, 481, '01.120', '90.012', NULL, '2023-09-01 13:02:29.835915', '2023-09-01 13:02:29.835915');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (482, 482, '01.120', NULL, NULL, '2023-09-01 13:02:29.8836', '2023-09-01 13:02:29.8836');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (483, 483, '01.120', '90.012', NULL, '2023-09-01 13:02:29.914214', '2023-09-01 13:02:29.914214');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (484, 484, '01.120', '90.012', '70.220', '2023-09-01 13:02:29.959804', '2023-09-01 13:02:29.959804');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (485, 485, '01.120', '90.012', NULL, '2023-09-01 13:02:30.00621', '2023-09-01 13:02:30.00621');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (486, 486, '01.120', NULL, NULL, '2023-09-01 13:02:30.051553', '2023-09-01 13:02:30.051553');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (487, 487, '01.120', '90.012', '70.220', '2023-09-01 13:02:30.093914', '2023-09-01 13:02:30.093914');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (488, 488, '01.120', NULL, NULL, '2023-09-01 13:02:30.128057', '2023-09-01 13:02:30.128057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (489, 489, '01.120', '90.012', '70.220', '2023-09-01 13:02:30.146959', '2023-09-01 13:02:30.146959');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (490, 490, '01.120', NULL, NULL, '2023-09-01 13:02:30.167214', '2023-09-01 13:02:30.167214');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (491, 491, '01.120', NULL, NULL, '2023-09-01 13:02:30.185187', '2023-09-01 13:02:30.185187');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (492, 492, '01.120', NULL, NULL, '2023-09-01 13:02:30.208072', '2023-09-01 13:02:30.208072');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (493, 493, '01.120', '90.012', '70.220', '2023-09-01 13:02:30.229516', '2023-09-01 13:02:30.229516');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (494, 494, '01.120', '90.012', NULL, '2023-09-01 13:02:30.272913', '2023-09-01 13:02:30.272913');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (495, 495, '01.120', '90.012', NULL, '2023-09-01 13:02:30.30588', '2023-09-01 13:02:30.30588');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (496, 496, '01.120', '90.012', NULL, '2023-09-01 13:02:30.349632', '2023-09-01 13:02:30.349632');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (497, 497, '01.120', NULL, NULL, '2023-09-01 13:02:30.381087', '2023-09-01 13:02:30.381087');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (498, 498, '01.120', NULL, NULL, '2023-09-01 13:02:30.419856', '2023-09-01 13:02:30.419856');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (499, 499, '01.120', NULL, NULL, '2023-09-01 13:02:30.447938', '2023-09-01 13:02:30.447938');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (500, 500, '01.120', NULL, NULL, '2023-09-01 13:02:30.485334', '2023-09-01 13:02:30.485334');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (501, 501, '01.120', '90.012', '70.220', '2023-09-01 13:02:30.538938', '2023-09-01 13:02:30.538938');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (502, 502, '01.120', NULL, NULL, '2023-09-01 13:02:30.689979', '2023-09-01 13:02:30.689979');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (503, 503, '01.120', NULL, NULL, '2023-09-01 13:02:30.739785', '2023-09-01 13:02:30.739785');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (504, 504, '01.120', '90.012', NULL, '2023-09-01 13:02:30.765596', '2023-09-01 13:02:30.765596');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (505, 505, '01.120', '90.012', '70.220', '2023-09-01 13:02:30.803549', '2023-09-01 13:02:30.803549');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (506, 506, '01.120', NULL, NULL, '2023-09-01 13:02:30.834246', '2023-09-01 13:02:30.834246');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (507, 507, '01.120', NULL, NULL, '2023-09-01 13:02:30.865364', '2023-09-01 13:02:30.865364');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (508, 508, '01.120', NULL, NULL, '2023-09-01 13:02:30.901461', '2023-09-01 13:02:30.901461');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (509, 509, '01.120', NULL, NULL, '2023-09-01 13:02:30.92905', '2023-09-01 13:02:30.92905');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (510, 510, '01.120', '90.012', '70.220', '2023-09-01 13:02:30.957995', '2023-09-01 13:02:30.957995');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (511, 511, '01.120', NULL, NULL, '2023-09-01 13:02:40.54177', '2023-09-01 13:02:40.54177');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (517, 517, '01.120', NULL, NULL, '2023-09-01 13:02:40.935217', '2023-09-01 13:02:40.935217');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (518, 518, '01.120', '90.012', '70.220', '2023-09-01 13:02:40.979145', '2023-09-01 13:02:40.979145');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (519, 519, '01.120', '90.012', '70.220', '2023-09-01 13:02:41.041056', '2023-09-01 13:02:41.041056');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (520, 520, '01.120', NULL, NULL, '2023-09-01 13:02:41.101247', '2023-09-01 13:02:41.101247');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (521, 521, '01.120', '90.012', NULL, '2023-09-01 13:02:41.124794', '2023-09-01 13:02:41.124794');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (522, 522, '01.120', NULL, NULL, '2023-09-01 13:02:41.167101', '2023-09-01 13:02:41.167101');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (523, 523, '01.120', '90.012', NULL, '2023-09-01 13:02:41.199112', '2023-09-01 13:02:41.199112');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (524, 524, '01.120', '90.012', NULL, '2023-09-01 13:02:41.232928', '2023-09-01 13:02:41.232928');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (525, 525, '01.120', NULL, NULL, '2023-09-01 13:02:41.260711', '2023-09-01 13:02:41.260711');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (526, 526, '01.120', NULL, NULL, '2023-09-01 13:02:41.293769', '2023-09-01 13:02:41.293769');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (512, 512, '01.120', '90.012', NULL, '2023-09-01 13:02:47.824383', '2023-09-01 13:02:40.589298');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (513, 513, '01.120', NULL, NULL, '2023-09-01 13:02:47.828189', '2023-09-01 13:02:40.664858');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (514, 514, '01.120', '90.012', '70.220', '2023-09-01 13:02:47.831944', '2023-09-01 13:02:40.738049');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (515, 515, '01.120', '90.012', '70.220', '2023-09-01 13:02:47.835487', '2023-09-01 13:02:40.780944');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (516, 516, '01.120', '90.012', '70.220', '2023-09-01 13:02:47.838758', '2023-09-01 13:02:40.880632');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (527, 527, '01.120', '01.110', '70.220', '2023-09-01 13:02:47.843545', '2023-09-01 13:02:41.315909');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (534, 534, '01.120', NULL, NULL, '2023-09-01 13:02:47.872995', '2023-09-01 13:02:47.872995');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (535, 535, '01.120', NULL, NULL, '2023-09-01 13:02:47.875308', '2023-09-01 13:02:47.875308');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (536, 536, '01.120', NULL, NULL, '2023-09-01 13:02:47.879138', '2023-09-01 13:02:47.879138');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (537, 537, '01.120', NULL, NULL, '2023-09-01 13:02:47.882927', '2023-09-01 13:02:47.882927');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (538, 538, '01.120', NULL, NULL, '2023-09-01 13:02:47.886974', '2023-09-01 13:02:47.886974');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.067183');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.141327');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '555555555', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.158839');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (6, '840563951', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.158839');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '844028810', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.197329');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '879683085', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.23952');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '846468514', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.30393');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '833092794', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.30393');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (15, '817549367', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.30393');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (16, '881668649', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.333983');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (17, '830704213', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.356042');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (18, '828285204', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.356042');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (19, '820874281', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.356042');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (20, '871838056', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.356042');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (21, '801643853', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.383869');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (22, '854308980', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.431497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '857012601', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.431497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '848910171', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.431497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (25, '872839692', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.476223');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '825863802', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.476223');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (27, '817000325', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.476223');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '839972893', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.476223');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (29, '832474989', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.523266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '896635459', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.523266');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (31, '886357004', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.557417');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '885895116', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.557417');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '814487750', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.557417');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '831093512', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.602588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '873745729', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.602588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '820353273', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.602588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '826836351', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.652319');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '856867915', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.652319');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '874511382', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.652319');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '821330635', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.685298');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '846851318', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.685298');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '811350402', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.715851');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '807612691', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.715851');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '850641118', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.715851');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '891617166', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.739256');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '845818867', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.739256');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '894851986', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.739256');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '807618154', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.763433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '872517152', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.763433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '892101191', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.763433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '801663204', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.799567');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '885577241', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.847579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '826487665', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.847579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '836121193', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.847579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '816811477', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.847579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '895694541', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.888635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '873767750', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.888635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '863317728', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.888635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '843647618', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.888635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '871864762', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.888635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '887286152', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.888635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '849595504', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.939653');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '852393167', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.939653');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '879883134', 'VIRKSOMHET', '1', '2023-09-01 13:02:35.939653');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '866940889', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.982238');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '864958773', 'VIRKSOMHET', '2', '2023-09-01 13:02:35.982238');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '859959251', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.982238');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '838372207', 'VIRKSOMHET', '9', '2023-09-01 13:02:35.982238');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '896870431', 'VIRKSOMHET', '3', '2023-09-01 13:02:35.982238');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '889345261', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.012819');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '872514008', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.012819');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '825703551', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.012819');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '801524565', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.012819');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '819151355', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.012819');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '894794240', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.012819');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '863424096', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.012819');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '849696997', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.047471');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '835661484', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.047471');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '895708763', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.047471');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '814687293', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.075987');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '892595718', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.075987');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '893059597', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.075987');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '833908963', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.102377');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '879661736', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.102377');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '819334264', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.137077');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '868810378', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.137077');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '848273724', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.137077');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '856704980', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.166927');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '870186667', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.166927');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '805774066', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.166927');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '866450049', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.191329');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '887994003', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.213583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '842914169', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.213583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '848797491', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.213583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '807813627', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.213583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '834167604', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.213583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '874335732', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.213583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '826915711', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.245231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '835952962', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.271326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '830046194', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.271326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '859514340', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.271326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '870772243', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.271326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '801742803', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.298331');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '863629482', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.298331');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '886623437', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.298331');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '879799300', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.298331');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '877281898', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.321297');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '853945949', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.336874');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '894480080', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.336874');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '870642221', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.336874');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '893652131', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.362061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '878051746', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.391632');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '823152176', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.430273');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '810868617', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.430273');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '850126521', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.467669');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '833180535', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.467669');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '876578552', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.467669');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '847429997', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.514329');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '861795773', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.514329');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '878971899', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.554502');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '816782600', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.554502');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '861430193', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.596431');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '867266177', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.596431');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '877683962', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.596431');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '802258475', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.644509');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '804482256', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.644509');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '852236310', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.674728');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '848766928', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.674728');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '825056986', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.710063');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '893417017', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.710063');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '813307155', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.710063');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '896289587', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.750654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '841791511', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.750654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '861597616', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.750654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '890775982', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.750654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '830479135', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.780934');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '870170432', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.780934');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '881974816', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.805511');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '821553355', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.805511');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '829730277', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.805511');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '868315277', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.840837');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '800039249', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.840837');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '846412706', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.840837');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '884832900', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.840837');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '808931289', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.877572');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '861875368', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.877572');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '862397552', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.877572');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '821753952', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.877572');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '892729481', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.877572');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '802727698', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.905909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '840096162', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.905909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '888659470', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.905909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '850200327', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.905909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '861393944', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.905909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '833369082', 'VIRKSOMHET', '3', '2023-09-01 13:02:36.935564');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '899621957', 'VIRKSOMHET', '9', '2023-09-01 13:02:36.935564');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '870923918', 'VIRKSOMHET', '2', '2023-09-01 13:02:36.970143');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '817115960', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.970143');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '872469548', 'VIRKSOMHET', '1', '2023-09-01 13:02:36.970143');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '887868763', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.002525');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '855657326', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.002525');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '860417684', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.034902');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '868128237', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.034902');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '857116596', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.034902');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '895842997', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.088101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '801305726', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.088101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '892425810', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.088101');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '835327648', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.118335');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '853021452', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.118335');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '837365133', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.118335');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '800482686', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.118335');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '897324044', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.15764');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '835671490', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.15764');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '897991520', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.15764');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '876559691', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.181872');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '891356146', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.181872');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '892361559', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.181872');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '812573755', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.200131');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '846794321', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.200131');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '836534690', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.200131');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '886609379', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.200131');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '892136879', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.234159');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '841281181', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.234159');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '882825096', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.234159');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '888357366', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.262275');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '855595319', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.262275');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '824600423', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.290205');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '830996379', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.290205');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '825154853', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.290205');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '838584086', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.32263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '821020415', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.32263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '808632104', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.358563');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '876011318', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.358563');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '825580046', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.358563');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '849162278', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.358563');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '825633362', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.358563');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '845385150', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.376345');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '870882127', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.376345');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '815492716', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.376345');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '823633253', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.431826');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '898182420', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.431826');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '859741138', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.431826');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '896451492', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.431826');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '810860783', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.431826');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '830535540', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.491401');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '828662423', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.491401');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '879730471', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.491401');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '863677191', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.491401');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '821212732', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.491401');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '894678259', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.491401');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '840608868', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.535882');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '896187288', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.535882');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '838721828', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.535882');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '856189591', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.535882');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '876273878', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.535882');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '861845076', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.535882');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '885168462', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.572172');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '822194048', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.572172');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '822247206', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.572172');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '872772840', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.572172');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '849349122', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.598767');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '848678778', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.598767');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '856425068', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.639291');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '874049341', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.68056');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '874858219', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.68056');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '886351929', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.68056');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '882682006', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.68056');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '815979604', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.704472');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '839386992', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.704472');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '857404113', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.704472');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '869983436', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.704472');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '878032565', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.723571');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '819705126', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.723571');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '845287728', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.74433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '860837701', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.74433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '875842181', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.74433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '804699906', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.775418');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '823614948', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.775418');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '862500476', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.775418');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '809412443', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.775418');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '828229131', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.800192');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '801498562', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.800192');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '873369415', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.800192');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '895611299', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.800192');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '841020642', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.824361');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '824842469', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.824361');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '879641976', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.824361');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '865456582', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.824361');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '894482342', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.824361');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '898371335', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.848889');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '855496620', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.848889');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '827673788', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.848889');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '843554986', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.848889');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '889779510', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.874654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '857354197', 'VIRKSOMHET', '3', '2023-09-01 13:02:37.874654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '823773229', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.903748');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '807707298', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.929332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '865421389', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.929332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '876063217', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.929332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '895621261', 'VIRKSOMHET', '1', '2023-09-01 13:02:37.954003');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '885492879', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.978217');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '894782357', 'VIRKSOMHET', '2', '2023-09-01 13:02:37.978217');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '835084511', 'VIRKSOMHET', '9', '2023-09-01 13:02:37.978217');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '861993774', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.008089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '889170847', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.008089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '828494499', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.008089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '854202196', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.034955');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '802742619', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.034955');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '868404321', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.055012');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '851956311', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.055012');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '823334696', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.055012');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '852790719', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.055012');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '893629730', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.055012');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '863813033', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.088563');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '808618938', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.088563');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '809260201', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.088563');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '895819984', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.115091');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '819657813', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.115091');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '800224708', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.115091');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '806669485', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.115091');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '880734391', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.137651');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '828568610', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.137651');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '823138132', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.166572');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '817989278', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.166572');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '802713634', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.166572');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '807804577', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.166572');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '848323171', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.200562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '832865945', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.200562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '860309060', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.200562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '814889148', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.230613');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '891572191', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.230613');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '877218345', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.230613');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '886724220', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.230613');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '820530610', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.230613');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '837535869', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.255602');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '865065632', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.255602');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '873542190', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.255602');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '814804594', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.255602');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '857056451', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.287855');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '869737356', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.287855');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '848200494', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.287855');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '811656574', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.31991');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '859300392', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.31991');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '888201315', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.31991');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '802642361', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.31991');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '895927960', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.343895');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '858574195', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.343895');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '836046143', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.343895');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '872682864', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.343895');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '868541833', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.362615');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '887162294', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.362615');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '872722388', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.362615');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '856110013', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.362615');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '888356763', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.375555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '876598168', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.375555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '898292659', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.375555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '884348614', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.391579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '861893059', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.391579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '813576485', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.391579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '815615055', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.414543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '851095336', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.414543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '839238424', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.414543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '802413011', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.414543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '860737507', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.441716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '870274950', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.441716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '848225721', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.467092');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '869094505', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.467092');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '820130498', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.467092');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '890410982', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.497126');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '808992454', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.497126');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '884151600', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.497126');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '853357327', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.534996');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '816439848', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.534996');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '884209909', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.534996');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '899443571', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.564232');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '866284751', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.564232');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '880509861', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.564232');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '849684760', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.564232');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '828427862', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.564232');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '806894844', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.599805');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '814590821', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.599805');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '837061530', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.635404');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '801554425', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.635404');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '810074954', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.635404');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '859766179', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.655877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '871799161', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.655877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '801976897', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.655877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '802585963', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.655877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '818337697', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.655877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '879951937', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.655877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '831001012', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.655877');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '898847680', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.679131');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '852996781', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.679131');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '859568205', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.679131');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '878298725', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.695989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '865500726', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.695989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '847800406', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.71095');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '812585250', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.730113');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '829630446', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.730113');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '878665958', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.745274');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '867338166', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.745274');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '874303897', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.745274');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '815797440', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.745274');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '878302329', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.754653');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '814902719', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.754653');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '861928097', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.769633');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '814214408', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.92289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '841446216', 'VIRKSOMHET', '3', '2023-09-01 13:02:38.92289');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '880913102', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.952404');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '804954274', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.952404');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '867602272', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.952404');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '890907727', 'VIRKSOMHET', '9', '2023-09-01 13:02:38.952404');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '896522080', 'VIRKSOMHET', '2', '2023-09-01 13:02:38.991269');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '805655729', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.991269');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '839500879', 'VIRKSOMHET', '1', '2023-09-01 13:02:38.991269');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '885869627', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.064408');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '875445187', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.064408');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '813466439', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.064408');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '896623441', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.095573');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '808991850', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.095573');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '829507713', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.095573');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '833117254', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.126434');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '837846413', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.150112');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '869503803', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.150112');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '883744480', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.150112');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '841681491', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.172477');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '804469736', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.172477');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '842580200', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.210526');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '867939301', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.210526');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '846991517', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.210526');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '849842492', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.23466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '892824713', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.23466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '871393874', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.23466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '838748341', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.23466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '852620240', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.253761');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '810480871', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.253761');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '836141850', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.27752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '813662987', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.27752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '874409446', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.27752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '882071110', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.27752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '831281285', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.302648');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '812422244', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.302648');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '877641955', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.302648');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '849832913', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.32281');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '878265524', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.32281');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '862385530', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.32281');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '832873358', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.340543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '865506081', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.340543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '862694712', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.340543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '808556476', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.340543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '809785402', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.363567');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '820464657', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.382842');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '806453016', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.382842');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '855109259', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.382842');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '844136610', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.382842');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '868437705', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.42363');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '805414233', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.42363');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '843122242', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.42363');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '880436983', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.464442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '877619067', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.464442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '825656069', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.464442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '809247535', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.464442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '850902238', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.464442');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '805065367', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.48934');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '884103260', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.48934');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '896185086', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.48934');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '879147472', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.530175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '859469327', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.530175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '809021214', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.554911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '890441272', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.554911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '843918726', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.595132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '867010071', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.595132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '899491325', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.595132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '817860197', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.612996');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '894342532', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.612996');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '832677042', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.612996');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '886394237', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.635516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '872624587', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.635516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '898866641', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.635516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '884853942', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.635516');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '819545829', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.654376');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '833817902', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.654376');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '885642137', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.654376');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '896711412', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.678528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '821835062', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.678528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '870037842', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.678528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '817185565', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.710271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '867521592', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.710271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '877585722', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.710271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '834435277', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.747093');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '822051894', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.747093');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '833917059', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.747093');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '845980869', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.773534');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '855519631', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.773534');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '831415125', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.773534');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '846728931', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.801457');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '848471580', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.801457');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '873734324', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.801457');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '857680633', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.823118');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '835913918', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.823118');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '857383092', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.823118');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '839907680', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.844856');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '825019259', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.844856');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '812484100', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.844856');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '865749372', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.844856');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '848145367', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.868032');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '897513077', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.868032');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '898230296', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.891454');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '830853233', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.891454');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '805517793', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.891454');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '862719356', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.891454');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '868747999', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.924846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '820061307', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.946702');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '868124354', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.946702');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '816123649', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.946702');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '832157777', 'VIRKSOMHET', '1', '2023-09-01 13:02:39.946702');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '831381830', 'VIRKSOMHET', '9', '2023-09-01 13:02:39.990171');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '817029341', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.990171');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '883702404', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.990171');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '875251613', 'VIRKSOMHET', '3', '2023-09-01 13:02:39.990171');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '888916707', 'VIRKSOMHET', '2', '2023-09-01 13:02:39.990171');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '880687429', 'VIRKSOMHET', '3', '2023-09-01 13:02:40.017195');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '887053356', 'VIRKSOMHET', '2', '2023-09-01 13:02:40.017195');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '851373027', 'VIRKSOMHET', '1', '2023-09-01 13:02:40.017195');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '884968539', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.017195');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '899921613', 'VIRKSOMHET', '1', '2023-09-01 13:02:40.047305');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '817640200', 'VIRKSOMHET', '1', '2023-09-01 13:02:40.072111');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '869157440', 'VIRKSOMHET', '1', '2023-09-01 13:02:40.072111');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '824996698', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.113596');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '841149048', 'VIRKSOMHET', '3', '2023-09-01 13:02:40.113596');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '846124562', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.113596');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '820180026', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.147812');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '844702533', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.147812');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '812044855', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.147812');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '881840088', 'VIRKSOMHET', '2', '2023-09-01 13:02:40.147812');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '810615966', 'VIRKSOMHET', '3', '2023-09-01 13:02:40.177847');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '847652861', 'VIRKSOMHET', '1', '2023-09-01 13:02:40.177847');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '810293959', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.177847');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '832883476', 'VIRKSOMHET', '2', '2023-09-01 13:02:40.204084');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '840867285', 'VIRKSOMHET', '2', '2023-09-01 13:02:40.204084');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '873422926', 'VIRKSOMHET', '2', '2023-09-01 13:02:40.230804');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '821884742', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.230804');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '832848887', 'VIRKSOMHET', '2', '2023-09-01 13:02:40.275338');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '814238276', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.275338');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '806659673', 'VIRKSOMHET', '1', '2023-09-01 13:02:40.275338');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '877303997', 'VIRKSOMHET', '2', '2023-09-01 13:02:40.308228');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '809858203', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.308228');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '853630583', 'VIRKSOMHET', '1', '2023-09-01 13:02:40.308228');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '897636323', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.308228');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '857342658', 'VIRKSOMHET', '3', '2023-09-01 13:02:40.329639');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '852507509', 'VIRKSOMHET', '9', '2023-09-01 13:02:40.329639');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '882645805', 'VIRKSOMHET', '1', '2023-09-01 13:02:40.351544');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '875683015', 'VIRKSOMHET', '3', '2023-09-01 13:02:40.351544');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '847572493', 'VIRKSOMHET', '3', '2023-09-01 13:02:40.37138');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '899524077', 'VIRKSOMHET', '2', '2023-09-01 13:02:41.560022');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '825753154', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.581447');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '800252166', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.599752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '822590034', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.599752');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '895035985', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.613686');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '843438328', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.613686');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '834834978', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.613686');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '891180633', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.65061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '830859003', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.65061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '874375031', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.67145');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '881509026', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.67145');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '800184390', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.67145');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '803113235', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.693612');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '811074684', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.693612');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '832601414', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.693612');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '839233927', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.711974');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '826379397', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.711974');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '886623624', 'VIRKSOMHET', '1', '2023-09-01 13:02:41.711974');


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
-- Name: sykefravar_statistikk_bransje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_bransje_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.virksomhet_naringsundergrupper_id_seq', 538, true);


--
-- Name: sykefravar_statistikk_bransje bransje_periode; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_bransje
    ADD CONSTRAINT bransje_periode UNIQUE (bransje, arstall, kvartal);


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
-- Name: sykefravar_statistikk_bransje sykefravar_statistikk_bransje_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_bransje
    ADD CONSTRAINT sykefravar_statistikk_bransje_pkey PRIMARY KEY (id);


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
-- Name: idx_bransje_sykefravar_statistikk_bransje; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_bransje_sykefravar_statistikk_bransje ON public.sykefravar_statistikk_bransje USING btree (bransje);


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
-- Name: virksomhet_naringsundergrupper fk_virksomhet_naringsundergrupper_naring; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.virksomhet_naringsundergrupper
    ADD CONSTRAINT fk_virksomhet_naringsundergrupper_naring FOREIGN KEY (naringsundergruppe1) REFERENCES public.naring(kode);


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
-- Name: TABLE sykefravar_statistikk_bransje; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.sykefravar_statistikk_bransje TO cloudsqliamuser;


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
-- Name: TABLE virksomhet_naringsundergrupper; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.virksomhet_naringsundergrupper TO cloudsqliamuser;


--
-- PostgreSQL database dump complete
--

