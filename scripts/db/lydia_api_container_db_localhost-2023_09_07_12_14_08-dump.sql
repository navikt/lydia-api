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

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', 'V1__init.sql', 1782034767, 'test', '2023-09-07 12:09:06.744717', 51, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', 'V2__create_virksomhet_adresse.sql', -64248919, 'test', '2023-09-07 12:09:06.862371', 43, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', 'V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2023-09-07 12:09:06.979917', 39, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', 'V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2023-09-07 12:09:07.067922', 15, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', 'V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2023-09-07 12:09:07.121581', 19, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', 'V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2023-09-07 12:09:07.175999', 12, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', 'V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2023-09-07 12:09:07.220078', 19, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', 'V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2023-09-07 12:09:07.269596', 15, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', 'V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2023-09-07 12:09:07.315468', 27, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', 'V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2023-09-07 12:09:07.382192', 12, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', 'V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2023-09-07 12:09:07.429621', 13, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', 'V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2023-09-07 12:09:07.469459', 12, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', 'V13__ia_prosess.sql', -1755516749, 'test', '2023-09-07 12:09:07.508485', 14, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', 'V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2023-09-07 12:09:07.552994', 23, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', 'V15__endre_saknummer.sql', -1379621340, 'test', '2023-09-07 12:09:07.620758', 16, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', 'V16__ia_sak_hendelse.sql', 586872662, 'test', '2023-09-07 12:09:07.667108', 26, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', 'V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2023-09-07 12:09:07.722603', 10, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', 'V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2023-09-07 12:09:07.760289', 22, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', 'V19__legg_til_begrunnelser.sql', 779259005, 'test', '2023-09-07 12:09:07.818085', 17, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', 'V20__legg_til_flere_indekser.sql', -843857404, 'test', '2023-09-07 12:09:07.869223', 24, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', 'V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2023-09-07 12:09:07.925238', 12, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', 'V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2023-09-07 12:09:07.967759', 12, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', 'V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2023-09-07 12:09:08.007749', 15, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', 'V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2023-09-07 12:09:08.051665', 19, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', 'V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2023-09-07 12:09:08.099911', 32, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', 'V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2023-09-07 12:09:08.15975', 16, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', 'V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2023-09-07 12:09:08.201867', 13, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', 'V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2023-09-07 12:09:08.237977', 10, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', 'V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2023-09-07 12:09:08.276094', 17, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', 'V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2023-09-07 12:09:08.328263', 16, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', 'V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2023-09-07 12:09:08.384019', 19, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', 'V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2023-09-07 12:09:08.440046', 18, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', 'V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2023-09-07 12:09:08.494694', 19, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', 'V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2023-09-07 12:09:08.570084', 26, true);
INSERT INTO public.flyway_schema_history VALUES (35, '35', 'drop sykefravar statistikk grunnlag', 'SQL', 'V35__drop_sykefravar_statistikk_grunnlag.sql', 461103825, 'test', '2023-09-07 12:09:08.644372', 20, true);
INSERT INTO public.flyway_schema_history VALUES (36, '36', 'registrere bistand', 'SQL', 'V36__registrere_bistand.sql', -1365283904, 'test', '2023-09-07 12:09:08.707675', 41, true);
INSERT INTO public.flyway_schema_history VALUES (37, '37', 'fullfoert dato leveranse', 'SQL', 'V37__fullfoert_dato_leveranse.sql', 1621470787, 'test', '2023-09-07 12:09:08.783694', 18, true);
INSERT INTO public.flyway_schema_history VALUES (38, '38', 'oppdatere moduler', 'SQL', 'V38__oppdatere_moduler.sql', -246234034, 'test', '2023-09-07 12:09:08.841541', 23, true);
INSERT INTO public.flyway_schema_history VALUES (39, '39', 'rette iatjeneste på modul', 'SQL', 'V39__rette_iatjeneste_på_modul.sql', -1034067650, 'test', '2023-09-07 12:09:08.911852', 23, true);
INSERT INTO public.flyway_schema_history VALUES (40, '40', 'legg til rolle ia sak hendelse', 'SQL', 'V40__legg_til_rolle_ia_sak_hendelse.sql', -82283870, 'test', '2023-09-07 12:09:08.976303', 15, true);
INSERT INTO public.flyway_schema_history VALUES (41, '41', 'legg til rolle ia sak leveranse', 'SQL', 'V41__legg_til_rolle_ia_sak_leveranse.sql', -2029318456, 'test', '2023-09-07 12:09:09.020347', 13, true);
INSERT INTO public.flyway_schema_history VALUES (42, '42', 'legg til deaktivert', 'SQL', 'V42__legg_til_deaktivert.sql', 1170357332, 'test', '2023-09-07 12:09:09.073486', 18, true);
INSERT INTO public.flyway_schema_history VALUES (43, '43', 'siste publiseringsinfo tabell', 'SQL', 'V43__siste_publiseringsinfo_tabell.sql', -1555520829, 'test', '2023-09-07 12:09:09.124583', 20, true);
INSERT INTO public.flyway_schema_history VALUES (44, '44', 'hendelse nav enhet', 'SQL', 'V44__hendelse_nav_enhet.sql', -1118774222, 'test', '2023-09-07 12:09:09.173384', 22, true);
INSERT INTO public.flyway_schema_history VALUES (45, '45', 'oppdatere siste publiseringsinfo', 'SQL', 'V45__oppdatere_siste_publiseringsinfo.sql', -1919960111, 'test', '2023-09-07 12:09:09.226494', 16, true);
INSERT INTO public.flyway_schema_history VALUES (46, '46', 'populer siste publiseringsdato', 'SQL', 'V46__populer_siste_publiseringsdato.sql', 21300723, 'test', '2023-09-07 12:09:09.280019', 25, true);
INSERT INTO public.flyway_schema_history VALUES (47, '47', 'virksomhet naringsundergrupper tabell', 'SQL', 'V47__virksomhet_naringsundergrupper_tabell.sql', 581614507, 'test', '2023-09-07 12:09:09.344773', 17, true);
INSERT INTO public.flyway_schema_history VALUES (48, '48', 'endre oppdateringsdato', 'SQL', 'V48__endre_oppdateringsdato.sql', 855334580, 'test', '2023-09-07 12:09:09.395269', 14, true);
INSERT INTO public.flyway_schema_history VALUES (49, '49', 'sykefravar statistikk bransje tabell', 'SQL', 'V49__sykefravar_statistikk_bransje_tabell.sql', 1439525146, 'test', '2023-09-07 12:09:09.440916', 18, true);
INSERT INTO public.flyway_schema_history VALUES (50, '50', 'endre kode lengde siste 4 kvartal', 'SQL', 'V50__endre_kode_lengde_siste_4_kvartal.sql', 218855534, 'test', '2023-09-07 12:09:09.490247', 16, true);
INSERT INTO public.flyway_schema_history VALUES (51, '51', 'endre navn fra naeringskode til naringsundergruppe', 'SQL', 'V51__endre_navn_fra_naeringskode_til_naringsundergruppe.sql', 498551672, 'test', '2023-09-07 12:09:09.541864', 27, true);
INSERT INTO public.flyway_schema_history VALUES (52, '52', 'slett virksomhet naring tabell', 'SQL', 'V52__slett_virksomhet_naring_tabell.sql', 1210783708, 'test', '2023-09-07 12:09:09.602492', 16, true);
INSERT INTO public.flyway_schema_history VALUES (53, '53', 'oppdatere siste publiseringsinfo Q2 2023', 'SQL', 'V53__oppdatere_siste_publiseringsinfo_Q2_2023.sql', -100876903, 'test', '2023-09-07 12:09:09.64888', 11, true);
INSERT INTO public.flyway_schema_history VALUES (54, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -1707980373, 'test', '2023-09-07 12:09:09.69013', 31, true);
INSERT INTO public.flyway_schema_history VALUES (55, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 1064561831, 'test', '2023-09-07 12:09:36.9844', 78, true);


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
INSERT INTO public.naring VALUES ('90', 'Næring', 'Kortnavn for 90');
INSERT INTO public.naring VALUES ('70', 'Næring', 'Kortnavn for 70');
INSERT INTO public.naring VALUES ('01.120', 'Dyrking av ris', 'Kortnavn for 01.120');
INSERT INTO public.naring VALUES ('90.012', 'Utøvende kunstnere og underholdningsvirksomhet innen scenekunst', 'Kortnavn for 90.012');
INSERT INTO public.naring VALUES ('70.220', 'Bedriftsrådgivning og annen administrativ rådgivning', 'Kortnavn for 70.220');
INSERT INTO public.naring VALUES ('01.110', 'Dyrking av korn, unntatt ris', 'Kortnavn for 01.110');


--
-- Data for Name: sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: siste_publiseringsinfo; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.siste_publiseringsinfo VALUES (1, 2022, 4, '2023-03-02 00:00:00', '2023-06-01 00:00:00', '2023-09-07 12:09:09.136408');
INSERT INTO public.siste_publiseringsinfo VALUES (2, 2023, 1, '2023-06-01 00:00:00', '2023-09-07 00:00:00', '2023-09-07 12:09:09.238479');
INSERT INTO public.siste_publiseringsinfo VALUES (3, 2022, 3, '2022-12-01 00:00:00', '2023-03-02 00:00:00', '2023-09-07 12:09:09.294535');
INSERT INTO public.siste_publiseringsinfo VALUES (4, 2022, 2, '2022-09-08 00:00:00', '2022-12-01 00:00:00', '2023-09-07 12:09:09.294535');
INSERT INTO public.siste_publiseringsinfo VALUES (5, 2022, 1, '2022-06-02 00:00:00', '2022-09-08 00:00:00', '2023-09-07 12:09:09.294535');
INSERT INTO public.siste_publiseringsinfo VALUES (6, 2021, 4, '2022-03-03 00:00:00', '2022-06-02 00:00:00', '2023-09-07 12:09:09.294535');
INSERT INTO public.siste_publiseringsinfo VALUES (7, 2021, 3, '2021-12-02 00:00:00', '2022-03-03 00:00:00', '2023-09-07 12:09:09.294535');
INSERT INTO public.siste_publiseringsinfo VALUES (8, 2023, 2, '2023-09-07 00:00:00', '2023-11-30 00:00:00', '2023-09-07 12:09:09.659725');


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

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2023, 2, 6, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.213199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2023, 1, 6, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.275623', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2023, 2, 5, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2023, 1, 5, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '555555555', 2023, 2, 86, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '892399737', 2023, 2, 980, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '892399737', 2023, 1, 980, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '826590600', 2023, 2, 42, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '826590600', 2023, 1, 42, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '831268381', 2023, 2, 42, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '831268381', 2023, 1, 42, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '895089382', 2023, 2, 855, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '895089382', 2023, 1, 855, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '853015007', 2023, 2, 395, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '825079892', 2023, 2, 347, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '860686834', 2023, 2, 426, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '874808559', 2023, 2, 787, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '898523088', 2023, 2, 721, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '885058584', 2023, 2, 579, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '851282088', 2023, 2, 114, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '877208213', 2023, 2, 282, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '842272409', 2023, 2, 996, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '829660290', 2023, 2, 732, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '899090884', 2023, 2, 404, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '848928047', 2023, 2, 976, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '871424742', 2023, 2, 625, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '886017047', 2023, 2, 466, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.448223', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '833439299', 2023, 2, 591, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.570868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '897462626', 2023, 2, 436, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.570868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '802345222', 2023, 2, 788, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.570868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '820451130', 2023, 2, 688, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.570868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '831580863', 2023, 2, 341, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.570868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '833761548', 2023, 2, 949, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.570868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '890808319', 2023, 2, 778, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '823222591', 2023, 2, 88, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '819370689', 2023, 2, 861, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '877074185', 2023, 2, 230, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '877076454', 2023, 2, 853, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '817705715', 2023, 2, 952, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '898846403', 2023, 2, 933, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '873361735', 2023, 2, 813, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '868944192', 2023, 2, 948, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '884366382', 2023, 2, 696, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '802244769', 2023, 2, 702, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '876487875', 2023, 2, 282, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '835982972', 2023, 2, 422, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '895727413', 2023, 2, 942, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '884201205', 2023, 2, 525, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '883177876', 2023, 2, 782, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '867694191', 2023, 2, 224, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '852811561', 2023, 2, 975, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '886557526', 2023, 2, 901, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '876660082', 2023, 2, 573, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '834218334', 2023, 2, 954, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '851696278', 2023, 2, 199, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '879389524', 2023, 2, 472, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.662156', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '858910824', 2023, 2, 356, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.738046', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '804672944', 2023, 2, 12, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.738046', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '863104947', 2023, 2, 967, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.738046', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '896697110', 2023, 2, 749, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.738046', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '853727860', 2023, 2, 821, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.738046', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '802940728', 2023, 2, 694, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.738046', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '836011249', 2023, 2, 94, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.738046', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '842449018', 2023, 2, 746, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.738046', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '880726000', 2023, 2, 868, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '848129204', 2023, 2, 827, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '818713664', 2023, 2, 131, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '853176413', 2023, 2, 142, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '823756322', 2023, 2, 725, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '881363295', 2023, 2, 501, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '805152073', 2023, 2, 835, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '825084231', 2023, 2, 708, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '880791986', 2023, 2, 64, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '852913999', 2023, 2, 311, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '802850977', 2023, 2, 728, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '841747129', 2023, 2, 714, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '844487259', 2023, 2, 787, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '890392943', 2023, 2, 136, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '804733585', 2023, 2, 636, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '826874776', 2023, 2, 492, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '814797885', 2023, 2, 320, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.804996', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '881250910', 2023, 2, 704, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.891886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '869292565', 2023, 2, 760, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.891886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '891967915', 2023, 2, 268, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.891886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '823567033', 2023, 2, 60, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.891886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '804739623', 2023, 2, 579, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.891886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '809157105', 2023, 2, 698, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.891886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '818314307', 2023, 2, 969, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.891886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '873865403', 2023, 2, 478, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '872220974', 2023, 2, 750, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '871740960', 2023, 2, 285, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '839209391', 2023, 2, 457, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '845126466', 2023, 2, 629, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '823308255', 2023, 2, 610, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '838170047', 2023, 2, 297, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '898389901', 2023, 2, 175, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '839244653', 2023, 2, 840, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '888286666', 2023, 2, 33, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '818063008', 2023, 2, 611, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '837482396', 2023, 2, 658, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '887156552', 2023, 2, 557, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '806165288', 2023, 2, 633, 12.8, 125, 1.5, false, '2023-09-07 12:10:12.947522', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '868645574', 2023, 2, 363, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.019014', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '883595681', 2023, 2, 610, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.019014', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '814308411', 2023, 2, 472, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.019014', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '811454092', 2023, 2, 747, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.019014', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '841274453', 2023, 2, 857, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.019014', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '876450529', 2023, 2, 419, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.019014', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '832025086', 2023, 2, 340, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.019014', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '876040207', 2023, 2, 185, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.019014', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '808044969', 2023, 2, 834, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.019014', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '815657103', 2023, 2, 813, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.059436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '806207908', 2023, 2, 534, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.059436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '863372662', 2023, 2, 564, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.059436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '816502624', 2023, 2, 731, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.059436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '852986256', 2023, 2, 629, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.059436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '853555598', 2023, 2, 867, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.059436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '835392717', 2023, 2, 538, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.059436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '817070709', 2023, 2, 172, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.059436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '810311994', 2023, 2, 888, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.059436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '850022448', 2023, 2, 594, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.059436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '806685779', 2023, 2, 63, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.108728', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '803687989', 2023, 2, 701, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.108728', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '853443507', 2023, 2, 212, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.108728', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '845560676', 2023, 2, 169, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.108728', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '827358643', 2023, 2, 219, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.108728', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '874825286', 2023, 2, 663, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.157226', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '880253499', 2023, 2, 526, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.157226', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '835809313', 2023, 2, 718, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.157226', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '896901593', 2023, 2, 394, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.157226', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '802899775', 2023, 2, 631, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.157226', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '838961590', 2023, 2, 298, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.199992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '892373226', 2023, 2, 275, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.199992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '841507581', 2023, 2, 667, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.199992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '861604952', 2023, 2, 38, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.199992', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '854358127', 2023, 2, 849, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.242519', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '852267877', 2023, 2, 280, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.242519', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '847360475', 2023, 2, 496, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.242519', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '853302353', 2023, 2, 707, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.242519', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '808758602', 2023, 2, 281, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.242519', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '881135497', 2023, 2, 761, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.242519', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '883221257', 2023, 2, 547, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.242519', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '829482164', 2023, 2, 771, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.242519', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '856230051', 2023, 2, 606, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.28274', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '810249268', 2023, 2, 127, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.28274', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '892788724', 2023, 2, 198, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.28274', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '840025055', 2023, 2, 269, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.28274', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '821348427', 2023, 2, 901, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.317629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '807977696', 2023, 2, 697, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.317629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '879659474', 2023, 2, 883, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.317629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '897882038', 2023, 2, 448, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.317629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '828677735', 2023, 2, 67, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.317629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '879034952', 2023, 2, 755, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.317629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '865949769', 2023, 2, 610, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.317629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '847877290', 2023, 2, 815, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.317629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '850257793', 2023, 2, 745, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.317629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '830101038', 2023, 2, 192, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.382629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '823151420', 2023, 2, 45, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.382629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '809286516', 2023, 2, 912, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.382629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '819145900', 2023, 2, 656, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.382629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '863874454', 2023, 2, 464, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.382629', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '884217469', 2023, 2, 809, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.442866', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '867258510', 2023, 2, 451, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.442866', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '897988683', 2023, 2, 906, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.442866', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '844667733', 2023, 2, 99, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.442866', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '844723188', 2023, 2, 958, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.442866', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '818141808', 2023, 2, 307, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.442866', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '859165386', 2023, 2, 359, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.442866', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '865504204', 2023, 2, 575, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.49861', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '898737040', 2023, 2, 664, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.49861', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '891816187', 2023, 2, 171, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.49861', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '816256086', 2023, 2, 280, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.49861', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '877756065', 2023, 2, 621, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.49861', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '828223293', 2023, 2, 601, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.545664', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '846339829', 2023, 2, 10, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.545664', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '850152691', 2023, 2, 54, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.545664', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '890037539', 2023, 2, 518, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.545664', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '822458792', 2023, 2, 23, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.545664', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '809266951', 2023, 2, 487, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.545664', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '899886628', 2023, 2, 605, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.545664', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '886901775', 2023, 2, 121, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.545664', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '886470266', 2023, 2, 491, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.584424', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '811210451', 2023, 2, 117, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.584424', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '888988714', 2023, 2, 598, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.584424', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '826324969', 2023, 2, 96, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.584424', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '807828501', 2023, 2, 280, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.625476', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '892008639', 2023, 2, 773, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.625476', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '888721551', 2023, 2, 141, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.625476', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '879069742', 2023, 2, 338, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.625476', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '808964650', 2023, 2, 142, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.625476', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '884187399', 2023, 2, 601, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.625476', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '824468605', 2023, 2, 618, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.659007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '888257410', 2023, 2, 754, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.659007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '854254584', 2023, 2, 974, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.659007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '862727618', 2023, 2, 501, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.659007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '835427889', 2023, 2, 889, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.705021', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '820294549', 2023, 2, 510, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.705021', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '806377882', 2023, 2, 579, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.705021', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '845531199', 2023, 2, 726, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.705021', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '830603806', 2023, 2, 367, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.705021', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '804075321', 2023, 2, 910, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.705021', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '891705500', 2023, 2, 811, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.705021', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '805367803', 2023, 2, 853, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.75072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '883071436', 2023, 2, 524, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.75072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '846197303', 2023, 2, 29, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.75072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '868131855', 2023, 2, 380, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.75072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '811538812', 2023, 2, 536, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.806459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '835595464', 2023, 2, 932, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.806459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '852912939', 2023, 2, 671, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.806459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '890193691', 2023, 2, 886, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.806459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '834044439', 2023, 2, 595, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.806459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '801308434', 2023, 2, 582, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.806459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '895387215', 2023, 2, 134, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.806459', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '803097144', 2023, 2, 334, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.84582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '820460681', 2023, 2, 645, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.84582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '893391635', 2023, 2, 122, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.84582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '803964775', 2023, 2, 744, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.84582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '830940695', 2023, 2, 581, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.895835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '821384683', 2023, 2, 169, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.895835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '816338918', 2023, 2, 85, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.895835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '858327975', 2023, 2, 478, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.895835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '814845704', 2023, 2, 554, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.895835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '807845910', 2023, 2, 480, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.895835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '870936597', 2023, 2, 790, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.895835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '837540796', 2023, 2, 857, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.895835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '865165723', 2023, 2, 274, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.895835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '809257693', 2023, 2, 811, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.937133', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '889852300', 2023, 2, 258, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.937133', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '824510214', 2023, 2, 755, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.937133', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '878219794', 2023, 2, 643, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.937133', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '833777549', 2023, 2, 39, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.969744', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '855806194', 2023, 2, 511, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.969744', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '857619997', 2023, 2, 268, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.969744', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '855072065', 2023, 2, 786, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.969744', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '873994005', 2023, 2, 705, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.969744', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '831772492', 2023, 2, 860, 12.8, 125, 1.5, false, '2023-09-07 12:10:13.969744', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '859319655', 2023, 2, 775, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.015572', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '829583457', 2023, 2, 749, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.015572', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '863035762', 2023, 2, 61, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.015572', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '818423659', 2023, 2, 357, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.015572', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '833484882', 2023, 2, 87, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.015572', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '811684284', 2023, 2, 417, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.075552', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '879108983', 2023, 2, 530, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.075552', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '896403945', 2023, 2, 708, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.075552', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '890608443', 2023, 2, 446, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.075552', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '809234560', 2023, 2, 150, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.075552', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '860066709', 2023, 2, 149, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.075552', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '863069895', 2023, 2, 190, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.075552', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '822751051', 2023, 2, 622, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.118811', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '831730651', 2023, 2, 982, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.118811', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '810588854', 2023, 2, 735, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.118811', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '889005244', 2023, 2, 109, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.118811', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '848905304', 2023, 2, 389, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.118811', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '840918223', 2023, 2, 57, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.162895', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '837610672', 2023, 2, 869, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.162895', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '813600293', 2023, 2, 133, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.162895', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '814308550', 2023, 2, 515, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.162895', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '875518774', 2023, 2, 447, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.162895', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '825806596', 2023, 2, 419, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.162895', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '891741795', 2023, 2, 255, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.162895', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '898153558', 2023, 2, 804, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.162895', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '808363965', 2023, 2, 460, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.212455', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '899444179', 2023, 2, 281, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.212455', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '818741759', 2023, 2, 342, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.212455', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '804864157', 2023, 2, 927, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.212455', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '864337109', 2023, 2, 562, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.212455', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '886504008', 2023, 2, 625, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.248272', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '862771443', 2023, 2, 729, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.248272', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '891584063', 2023, 2, 122, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.248272', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '857560571', 2023, 2, 500, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.288888', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '839718758', 2023, 2, 154, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.288888', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '823097522', 2023, 2, 225, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.288888', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '813365991', 2023, 2, 280, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.288888', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '804699305', 2023, 2, 146, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.288888', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '830939342', 2023, 2, 762, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.347624', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '816881589', 2023, 2, 639, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.347624', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '803971965', 2023, 2, 186, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.347624', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '874766433', 2023, 2, 279, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.347624', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '829427942', 2023, 2, 182, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.347624', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '865465487', 2023, 2, 716, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.347624', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '824353324', 2023, 2, 268, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.392328', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '852649392', 2023, 2, 926, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.392328', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '819691341', 2023, 2, 432, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.392328', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '841800300', 2023, 2, 419, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.392328', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '875827788', 2023, 2, 153, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.442933', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '873346928', 2023, 2, 445, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.442933', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '874317099', 2023, 2, 423, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.442933', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '824511321', 2023, 2, 900, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.442933', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '893389196', 2023, 2, 375, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.442933', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '891901556', 2023, 2, 666, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.442933', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '897591139', 2023, 2, 753, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.442933', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '821796054', 2023, 2, 714, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.442933', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '866749820', 2023, 2, 124, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.442933', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '853653798', 2023, 2, 456, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.442933', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '810148394', 2023, 2, 842, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.496252', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '815156970', 2023, 2, 208, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.496252', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '884757541', 2023, 2, 602, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.496252', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '898222657', 2023, 2, 923, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.496252', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '896030179', 2023, 2, 507, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.496252', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '864599907', 2023, 2, 897, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.496252', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '809618719', 2023, 2, 973, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.496252', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '866797297', 2023, 2, 772, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.552503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '894566254', 2023, 2, 274, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.552503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '847700913', 2023, 2, 678, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.552503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '887886764', 2023, 2, 397, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.552503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '846277149', 2023, 2, 690, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.552503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '832188723', 2023, 2, 349, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.552503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '891532355', 2023, 2, 646, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.552503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '812694935', 2023, 2, 705, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.552503', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '827754082', 2023, 2, 115, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.604785', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '810338095', 2023, 2, 390, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.604785', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '895262637', 2023, 2, 870, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.604785', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '876398349', 2023, 2, 631, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.604785', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '806767601', 2023, 2, 970, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.604785', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '802475579', 2023, 2, 705, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.604785', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '883219495', 2023, 2, 147, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.641204', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '879154973', 2023, 2, 159, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.641204', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '827809774', 2023, 2, 606, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.641204', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '861106891', 2023, 2, 488, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.641204', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '820860873', 2023, 2, 96, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.641204', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '833723531', 2023, 2, 649, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.641204', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '891420050', 2023, 2, 577, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.641204', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '881294356', 2023, 2, 724, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.673065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '878113186', 2023, 2, 937, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.673065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '879974330', 2023, 2, 47, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.673065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '802186110', 2023, 2, 684, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.673065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '839798432', 2023, 2, 780, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.673065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '839394527', 2023, 2, 378, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.673065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '822630771', 2023, 2, 749, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.673065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '820632732', 2023, 2, 286, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.710723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '895663536', 2023, 2, 57, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.710723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '810464549', 2023, 2, 829, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.710723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '810038015', 2023, 2, 820, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.710723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '831640932', 2023, 2, 636, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.710723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '826636164', 2023, 2, 845, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.710723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '871242919', 2023, 2, 117, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.745325', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '827203144', 2023, 2, 978, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.745325', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '818201399', 2023, 2, 951, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.745325', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '842767011', 2023, 2, 102, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.745325', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '871226849', 2023, 2, 79, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.745325', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '828877547', 2023, 2, 759, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.787099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '803598115', 2023, 2, 77, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.787099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '841405627', 2023, 2, 766, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.787099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '881613172', 2023, 2, 119, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.787099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '856589401', 2023, 2, 670, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.787099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '863700769', 2023, 2, 69, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.787099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '881862150', 2023, 2, 477, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.825292', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '817192943', 2023, 2, 934, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.825292', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '865004722', 2023, 2, 565, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.825292', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '867448417', 2023, 2, 613, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.825292', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '849474678', 2023, 2, 8, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.825292', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '847693270', 2023, 2, 349, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.864941', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '841607636', 2023, 2, 102, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.864941', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '807202254', 2023, 2, 980, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.864941', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '865346587', 2023, 2, 830, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.864941', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '803797113', 2023, 2, 935, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.864941', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '859015070', 2023, 2, 782, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.864941', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '831988569', 2023, 2, 80, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.912892', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '817536912', 2023, 2, 592, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.912892', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '815652536', 2023, 2, 289, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.912892', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '820854735', 2023, 2, 995, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.912892', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '845223389', 2023, 2, 593, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.912892', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '822319019', 2023, 2, 571, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.912892', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '890009028', 2023, 2, 420, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.955707', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '800496904', 2023, 2, 847, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.955707', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '817109970', 2023, 2, 953, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.955707', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '895079930', 2023, 2, 882, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.955707', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '875821555', 2023, 2, 943, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.955707', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '850014769', 2023, 2, 334, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.955707', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '885587354', 2023, 2, 393, 12.8, 125, 1.5, false, '2023-09-07 12:10:14.955707', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '857586849', 2023, 2, 10, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.006362', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '839952701', 2023, 2, 874, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.006362', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '803031804', 2023, 2, 235, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.006362', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '875659837', 2023, 2, 958, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.006362', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '832650403', 2023, 2, 559, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.006362', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '883770442', 2023, 2, 860, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.006362', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '845481784', 2023, 2, 460, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.006362', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '854542822', 2023, 2, 235, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.047251', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '835249198', 2023, 2, 999, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.047251', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '813953566', 2023, 2, 442, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.047251', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '850540874', 2023, 2, 171, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.047251', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '858828188', 2023, 2, 350, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.047251', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '864210989', 2023, 2, 48, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.088263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '839996129', 2023, 2, 855, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.088263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '864263901', 2023, 2, 865, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.088263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '803135962', 2023, 2, 878, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.088263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '870314786', 2023, 2, 403, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.088263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '863760146', 2023, 2, 84, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.088263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '861668570', 2023, 2, 586, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.088263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '830704856', 2023, 2, 914, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.088263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '889855312', 2023, 2, 148, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.088263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '863259727', 2023, 2, 628, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.15527', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '840135251', 2023, 2, 591, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.15527', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '864494818', 2023, 2, 453, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.15527', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '825695325', 2023, 2, 18, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.15527', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '836073862', 2023, 2, 838, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.15527', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '840058730', 2023, 2, 178, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.15527', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '846660938', 2023, 2, 670, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.228902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '898659607', 2023, 2, 795, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.228902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '854921842', 2023, 2, 588, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.228902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '873055761', 2023, 2, 971, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.228902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '805992114', 2023, 2, 535, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.228902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '851892457', 2023, 2, 969, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.228902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '814941134', 2023, 2, 308, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.228902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '888656414', 2023, 2, 586, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.228902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '800959797', 2023, 2, 221, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.285026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '850493038', 2023, 2, 212, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.285026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '882620191', 2023, 2, 292, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.285026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '854180739', 2023, 2, 974, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.285026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '886068919', 2023, 2, 650, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.285026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '833662587', 2023, 2, 89, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.285026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '873385075', 2023, 2, 456, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.285026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '843099645', 2023, 2, 518, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.285026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '825885334', 2023, 2, 248, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.285026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '872228537', 2023, 2, 769, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.285026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '852201319', 2023, 2, 314, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.397649', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '890363371', 2023, 2, 160, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.397649', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '815843495', 2023, 2, 21, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.397649', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '852930359', 2023, 2, 226, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.397649', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '837843994', 2023, 2, 662, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.397649', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '806010146', 2023, 2, 133, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.397649', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '886905862', 2023, 2, 654, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.397649', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '835407686', 2023, 2, 344, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.397649', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '840931417', 2023, 2, 543, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.45631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '867005478', 2023, 2, 594, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.45631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '878801449', 2023, 2, 580, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.45631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '892032684', 2023, 2, 63, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.45631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '860955788', 2023, 2, 172, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.45631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '843920371', 2023, 2, 524, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.45631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '882995152', 2023, 2, 663, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.45631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '887827580', 2023, 2, 949, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.45631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '826333991', 2023, 2, 147, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.45631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '867611681', 2023, 2, 519, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.45631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '815182148', 2023, 2, 589, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.514747', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '873874881', 2023, 2, 614, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.514747', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '882455206', 2023, 2, 415, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.514747', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '845232041', 2023, 2, 375, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.514747', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '882850737', 2023, 2, 812, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.514747', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '865259870', 2023, 2, 284, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.514747', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '828007957', 2023, 2, 952, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.514747', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '808270377', 2023, 2, 59, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.542853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '851384052', 2023, 2, 869, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.542853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '898600714', 2023, 2, 121, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.542853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '839935652', 2023, 2, 970, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.542853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '810141839', 2023, 2, 61, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.542853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '891333152', 2023, 2, 586, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.542853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '805164879', 2023, 2, 469, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.580896', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '824498308', 2023, 2, 230, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.580896', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '844282783', 2023, 2, 952, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.580896', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '817531159', 2023, 2, 250, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.580896', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '855550271', 2023, 2, 881, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.580896', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '869652681', 2023, 2, 654, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.611952', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '898751589', 2023, 2, 125, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.611952', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '878967112', 2023, 2, 934, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.611952', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '864003987', 2023, 2, 631, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.611952', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '832458613', 2023, 2, 607, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.611952', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '806008111', 2023, 2, 214, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.677147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '850214782', 2023, 2, 54, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.677147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '803104220', 2023, 2, 762, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.677147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '850426549', 2023, 2, 355, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.677147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '848391514', 2023, 2, 887, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.677147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '885388008', 2023, 2, 709, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.677147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '822821338', 2023, 2, 123, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.722657', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '822030521', 2023, 2, 543, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.722657', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '875874693', 2023, 2, 351, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.722657', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '812765101', 2023, 2, 122, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.722657', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '838926551', 2023, 2, 487, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.722657', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '899799563', 2023, 2, 368, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.722657', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '809015209', 2023, 2, 986, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.776436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '820034238', 2023, 2, 955, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.776436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '895498055', 2023, 2, 150, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.776436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '828601859', 2023, 2, 725, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.776436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '801604353', 2023, 2, 980, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.776436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '800776323', 2023, 2, 904, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.776436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '844347164', 2023, 2, 367, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.776436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '818219358', 2023, 2, 981, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.776436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '823902704', 2023, 2, 245, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.776436', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '883162812', 2023, 2, 574, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.818006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '889910960', 2023, 2, 774, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.818006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '865749324', 2023, 2, 778, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.818006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '850763986', 2023, 2, 664, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.818006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '880519699', 2023, 2, 590, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.818006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '852625515', 2023, 2, 671, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.818006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '861045673', 2023, 2, 49, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.855771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '833793182', 2023, 2, 528, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.855771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '831330573', 2023, 2, 961, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.855771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '861523860', 2023, 2, 993, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.855771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '824098672', 2023, 2, 825, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.855771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '823778083', 2023, 2, 719, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.855771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '809293796', 2023, 2, 426, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.855771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '833398283', 2023, 2, 263, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.894432', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '850432266', 2023, 2, 571, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.894432', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '881380147', 2023, 2, 979, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.894432', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '863782541', 2023, 2, 420, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.894432', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '853151041', 2023, 2, 64, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.894432', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '802050060', 2023, 2, 678, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.894432', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '853061189', 2023, 2, 114, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.934801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '839895479', 2023, 2, 178, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.934801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '850029414', 2023, 2, 530, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.934801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '850745866', 2023, 2, 207, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.934801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '862302999', 2023, 2, 976, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.934801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '838387901', 2023, 2, 959, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.934801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '893095117', 2023, 2, 84, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.934801', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '891087784', 2023, 2, 138, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.979905', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '814614016', 2023, 2, 95, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.979905', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '808055576', 2023, 2, 904, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.979905', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '807375408', 2023, 2, 924, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.979905', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '812020182', 2023, 2, 56, 12.8, 125, 1.5, false, '2023-09-07 12:10:15.979905', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '813691924', 2023, 2, 241, 12.8, 125, 1.5, false, '2023-09-07 12:10:16.014822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '889537777', 2023, 2, 691, 12.8, 125, 1.5, false, '2023-09-07 12:10:16.014822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '889923016', 2023, 2, 719, 12.8, 125, 1.5, false, '2023-09-07 12:10:16.014822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '883410497', 2023, 2, 74, 12.8, 125, 1.5, false, '2023-09-07 12:10:16.014822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '859214047', 2023, 2, 194, 12.8, 125, 1.5, false, '2023-09-07 12:10:16.014822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '899398352', 2023, 2, 503, 12.8, 125, 1.5, false, '2023-09-07 12:10:16.037768', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '888885608', 2023, 2, 204, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.408535', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '886738603', 2023, 2, 444, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.425749', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '824252875', 2023, 2, 175, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.4508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '815130751', 2023, 2, 619, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.4508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '807181403', 2023, 2, 48, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.4508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '825701028', 2023, 2, 648, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.4508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '880991109', 2023, 2, 315, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.484765', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '863223995', 2023, 2, 265, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.484765', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '855193175', 2023, 2, 655, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.484765', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '851914695', 2023, 2, 301, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.484765', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '860138637', 2023, 2, 232, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.514301', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '842209425', 2023, 2, 91, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.514301', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '886312075', 2023, 2, 950, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.514301', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '806191555', 2023, 2, 92, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.514301', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '812570442', 2023, 2, 717, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.514301', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '842756602', 2023, 2, 261, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.514301', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '864760613', 2023, 2, 861, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.514301', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '861707783', 2023, 2, 618, 12.8, 125, 1.5, false, '2023-09-07 12:10:21.543445', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 1091.15654766699, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.263476');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 8290.5430443085, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '555555555', 8626.61359284948, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '892399737', 2520.95835459255, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '826590600', 6340.25164779914, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '831268381', 319.802775219683, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '895089382', 798.619035897727, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '853015007', 2789.25283711888, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '825079892', 7999.50654307729, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '860686834', 686.506094856629, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '874808559', 2209.50901240174, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '898523088', 8300.81166523864, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '885058584', 6392.43580172511, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '851282088', 7434.97821810892, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '877208213', 8778.40782620337, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '842272409', 976.583224922371, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '829660290', 1271.13342719504, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '899090884', 4445.20729202623, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '848928047', 6726.83883600107, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '871424742', 4710.3723573204, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '886017047', 2997.09315142723, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.351433');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '833439299', 4232.44209249935, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.554609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '897462626', 2081.92743325918, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.554609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '802345222', 2273.95804487854, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.554609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '820451130', 3971.11807672704, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.554609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '831580863', 7786.21953542864, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.554609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '833761548', 2863.21115905685, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.554609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '890808319', 8311.67953854746, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '823222591', 583.921621539689, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '819370689', 4101.31384956864, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '877074185', 3693.41856203245, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '877076454', 6792.23111673008, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '817705715', 7957.64753163463, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '898846403', 816.603060867967, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '873361735', 2695.08361794032, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '868944192', 6153.50970472623, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '884366382', 6030.06567207624, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '802244769', 8133.77393631005, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '876487875', 9202.11806165347, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '835982972', 5805.75582419624, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '895727413', 9824.41558406666, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '884201205', 7292.18950625954, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '883177876', 3238.76292283919, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '867694191', 9957.64508521838, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '852811561', 1092.90244203255, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '886557526', 8122.5033341973, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '876660082', 2455.02829053318, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '834218334', 1714.0822807825, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '851696278', 3611.32185948982, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '879389524', 8043.85024015213, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.62206');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '858910824', 6422.01537107418, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.723665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '804672944', 4489.73459984092, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.723665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '863104947', 3590.03026548437, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.723665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '896697110', 2864.80822472553, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.723665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '853727860', 9239.38790899344, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.723665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '802940728', 8111.28576641521, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.723665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '836011249', 1335.52239556035, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.723665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '842449018', 4740.54370296796, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.723665');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '880726000', 7236.18220596051, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '848129204', 588.78355533922, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '818713664', 5076.81778973198, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '853176413', 8748.31022601702, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '823756322', 1018.65658274674, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '881363295', 3086.81791914653, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '805152073', 1226.12565400352, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '825084231', 7589.20959026373, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '880791986', 8184.35321359329, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '852913999', 9966.93675027632, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '802850977', 4514.88099063023, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '841747129', 1460.90568653598, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '844487259', 2556.54174486719, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '890392943', 6677.5381905938, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '804733585', 2785.8363300054, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '826874776', 5968.18208704505, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '814797885', 8341.03677903291, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.78043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '881250910', 145.516552949645, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.874603');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '869292565', 6227.33482811097, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.874603');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '891967915', 595.392886362729, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.874603');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '823567033', 6111.78538412831, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.874603');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '804739623', 4199.66121527064, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.874603');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '809157105', 2958.01129768125, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.874603');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '818314307', 1950.27654462205, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.874603');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '873865403', 796.533557545383, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '872220974', 6738.3872611197, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '871740960', 735.714342644657, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '839209391', 5733.44808181201, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '845126466', 36.4627822280093, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '823308255', 1080.62745171185, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '838170047', 5406.14803874188, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '898389901', 5561.53395114159, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '839244653', 8431.38469305309, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '888286666', 8642.77334407975, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '818063008', 9730.64549259312, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '837482396', 9516.70608618889, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '887156552', 5861.16106505178, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '806165288', 40.4570234143585, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.924911');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '868645574', 394.720555765037, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.996448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '883595681', 9824.62964838205, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.996448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '814308411', 9156.06847669231, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.996448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '811454092', 6101.31848182813, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.996448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '841274453', 4946.09288569159, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.996448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '876450529', 9276.64987392102, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.996448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '832025086', 6014.81399334178, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.996448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '876040207', 9501.14984317019, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.996448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '808044969', 5035.90911690545, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:12.996448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '815657103', 3844.65010034629, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.044201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '806207908', 8634.95464413638, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.044201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '863372662', 6310.87467048033, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.044201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '816502624', 9772.33359360968, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.044201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '852986256', 7010.78879451361, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.044201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '853555598', 9183.4286840458, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.044201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '835392717', 7363.67812988336, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.044201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '817070709', 7389.96096647197, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.044201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '810311994', 5563.44609606753, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.044201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '850022448', 4919.35115471229, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.044201');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '806685779', 2585.58457723069, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.096066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '803687989', 4358.70624746328, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.096066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '853443507', 307.871581330167, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.096066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '845560676', 6675.6812826941, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.096066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '827358643', 9326.37799956247, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.096066');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '874825286', 4595.51378239944, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.133546');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '880253499', 7577.16432670714, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.133546');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '835809313', 631.998125723772, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.133546');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '896901593', 7501.91389919707, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.133546');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '802899775', 2243.25336989414, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.133546');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '838961590', 8089.14939412636, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.190746');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '892373226', 3365.53833109947, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.190746');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '841507581', 4216.70014892859, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.190746');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '861604952', 2969.40139928952, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.190746');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '854358127', 3319.42453038755, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.224165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '852267877', 2307.18128367359, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.224165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '847360475', 8306.14809739184, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.224165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '853302353', 8762.81699456123, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.224165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '808758602', 5934.00811934917, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.224165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '881135497', 9596.41806802507, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.224165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '883221257', 8333.19456803899, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.224165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '829482164', 7088.52263380096, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.224165');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '856230051', 8704.44480250942, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.272271');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '810249268', 612.550251993815, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.272271');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '892788724', 3050.79895390923, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.272271');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '840025055', 2744.36928221453, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.272271');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '821348427', 3371.34837167411, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.303992');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '807977696', 9988.0046864597, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.303992');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '879659474', 3738.44676386159, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.303992');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '897882038', 9932.36587886324, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.303992');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '828677735', 5633.74115929201, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.303992');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '879034952', 4007.69855891736, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.303992');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '865949769', 2463.97318764422, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.303992');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '847877290', 9632.35133256708, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.303992');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '850257793', 2627.57982808979, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.303992');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '830101038', 134.662235881563, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.361492');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '823151420', 394.546816685252, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.361492');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '809286516', 6178.65583626451, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.361492');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '819145900', 7440.73888474731, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.361492');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '863874454', 6841.68635140321, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.361492');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '884217469', 8986.234015465, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.431199');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '867258510', 4516.51347888705, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.431199');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '897988683', 5682.71996126043, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.431199');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '844667733', 6148.64880811066, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.431199');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '844723188', 330.998305554583, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.431199');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '818141808', 7397.41821049056, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.431199');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '859165386', 856.642360098479, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.431199');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '865504204', 616.226339456745, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.486146');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '898737040', 7908.99351963745, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.486146');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '891816187', 8173.02674584639, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.486146');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '816256086', 4627.32981485344, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.486146');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '877756065', 9397.29481504295, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.486146');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '828223293', 9646.89072177541, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.52892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '846339829', 5607.22878712191, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.52892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '850152691', 957.35460907342, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.52892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '890037539', 7036.85311272998, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.52892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '822458792', 5488.40466676293, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.52892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '809266951', 9225.52629518071, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.52892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '899886628', 2180.36417878558, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.52892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '886901775', 1199.04888223359, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.52892');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '886470266', 3224.37832785114, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.569571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '811210451', 8691.30268091204, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.569571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '888988714', 5574.12855763484, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.569571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '826324969', 5472.01626806844, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.569571');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '807828501', 9422.58809451865, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.609465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '892008639', 2736.01616618792, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.609465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '888721551', 8594.28990225378, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.609465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '879069742', 2544.90383643992, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.609465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '808964650', 6478.27864712344, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.609465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '884187399', 8397.02124076566, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.609465');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '824468605', 3255.33702393404, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.647784');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '888257410', 1296.96030373365, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.647784');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '854254584', 4423.83082694118, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.647784');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '862727618', 1668.06537930908, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.647784');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '835427889', 9014.83940219837, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.681948');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '820294549', 7543.43787528127, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.681948');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '806377882', 5956.1708731346, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.681948');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '845531199', 2853.31533082652, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.681948');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '830603806', 5607.57828142823, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.681948');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '804075321', 1686.77220508566, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.681948');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '891705500', 5128.47051074976, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.681948');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '805367803', 8000.14548974575, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.734535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '883071436', 6446.38893071558, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.734535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '846197303', 3894.03513483755, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.734535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '868131855', 9822.00983143333, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.734535');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '811538812', 8776.74853284505, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.784403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '835595464', 2194.57316919311, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.784403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '852912939', 7734.84949667719, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.784403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '890193691', 8829.25168002929, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.784403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '834044439', 6924.95182268283, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.784403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '801308434', 9653.72283106023, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.784403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '895387215', 9236.29488318449, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.784403');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '803097144', 3672.34057800705, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.838762');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '820460681', 3337.02408757268, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.838762');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '893391635', 3034.09279459178, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.838762');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '803964775', 2514.31805303886, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.838762');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '830940695', 8611.5893135337, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.8813');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '821384683', 3272.98671466373, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.8813');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '816338918', 5945.4731455984, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.8813');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '858327975', 817.663650738495, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.8813');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '814845704', 7321.62923768525, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.8813');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '807845910', 6016.87850591467, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.8813');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '870936597', 798.207924502892, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.8813');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '837540796', 7918.54452518195, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.8813');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '865165723', 9423.44679114981, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.8813');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '809257693', 3466.0597436656, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.93112');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '889852300', 5392.65002853153, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.93112');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '824510214', 8431.77548755077, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.93112');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '878219794', 8321.48296190339, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.93112');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '833777549', 1435.590613861, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.958065');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '855806194', 1110.04701580581, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.958065');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '857619997', 3090.67633657335, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.958065');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '855072065', 3948.25293421961, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.958065');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '873994005', 9279.42691475819, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.958065');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '831772492', 9780.2320717058, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:13.958065');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '859319655', 8170.27898605924, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.004162');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '829583457', 1318.27788809967, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.004162');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '863035762', 2380.22271237854, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.004162');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '818423659', 7915.75700916532, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.004162');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '833484882', 8538.01950549077, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.004162');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '811684284', 5117.58280091124, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.05196');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '879108983', 7096.87739731287, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.05196');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '896403945', 572.687244415619, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.05196');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '890608443', 5849.04901778337, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.05196');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '809234560', 6194.86576806121, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.05196');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '860066709', 9926.47652061878, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.05196');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '863069895', 6188.67025847644, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.05196');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '822751051', 230.336508312253, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.112354');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '831730651', 719.209824829211, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.112354');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '810588854', 2044.96960109677, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.112354');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '889005244', 4459.18290890651, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.112354');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '848905304', 9023.57535643196, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.112354');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '840918223', 4207.09632496419, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.149899');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '837610672', 6916.42335833519, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.149899');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '813600293', 2887.76945263614, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.149899');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '814308550', 7721.98749996147, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.149899');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '875518774', 7573.95459015504, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.149899');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '825806596', 7208.88915892615, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.149899');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '891741795', 9907.89841042771, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.149899');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '898153558', 4926.55597744622, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.149899');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '808363965', 4788.81477474114, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.202275');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '899444179', 2903.00948649116, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.202275');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '818741759', 4366.0103158867, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.202275');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '804864157', 9295.25800228192, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.202275');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '864337109', 6688.4945727082, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.202275');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '886504008', 8266.5604542682, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.238515');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '862771443', 8455.5684952976, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.238515');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '891584063', 4594.17591571507, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.238515');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '857560571', 357.606799937646, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.277598');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '839718758', 728.040952161228, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.277598');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '823097522', 3869.13345737421, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.277598');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '813365991', 6703.12160326563, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.277598');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '804699305', 343.924998850314, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.277598');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '830939342', 8328.47000509887, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.329879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '816881589', 4171.93858265151, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.329879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '803971965', 2096.35905678279, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.329879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '874766433', 5143.44499244901, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.329879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '829427942', 4771.02525220663, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.329879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '865465487', 4625.79864958253, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.329879');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '824353324', 3304.12674273795, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.371613');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '852649392', 4957.623371261, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.371613');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '819691341', 7586.87430753588, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.371613');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '841800300', 6220.68149216332, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.371613');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '875827788', 1829.22082051712, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.414902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '873346928', 1750.74796751307, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.414902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '874317099', 1323.10525995808, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.414902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '824511321', 7294.63526523144, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.414902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '893389196', 496.682389059677, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.414902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '891901556', 3209.20681860286, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.414902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '897591139', 2423.14881777137, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.414902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '821796054', 872.799866804955, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.414902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '866749820', 2467.36678923119, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.414902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '853653798', 3999.35884693545, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.414902');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '810148394', 1038.13746751273, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.476851');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '815156970', 2791.86558210003, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.476851');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '884757541', 9808.38906738658, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.476851');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '898222657', 728.899446247918, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.476851');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '896030179', 9575.80073354856, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.476851');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '864599907', 1904.02687847116, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.476851');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '809618719', 9849.18955306231, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.476851');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '866797297', 3318.36552547802, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.533046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '894566254', 2763.83423253833, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.533046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '847700913', 2798.17726292598, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.533046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '887886764', 503.615939786434, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.533046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '846277149', 7140.61231721918, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.533046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '832188723', 5023.92422413345, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.533046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '891532355', 3731.81728419892, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.533046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '812694935', 2176.3605836068, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.533046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '827754082', 1336.63409571769, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.592898');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '810338095', 8973.98257259004, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.592898');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '895262637', 3587.5894817188, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.592898');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '876398349', 245.444420252385, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.592898');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '806767601', 1305.54885277992, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.592898');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '802475579', 1051.13699548094, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.592898');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '883219495', 3104.22604192202, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.628698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '879154973', 3431.07951738676, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.628698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '827809774', 7955.08078193025, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.628698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '861106891', 5925.53875202348, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.628698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '820860873', 1995.75268934876, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.628698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '833723531', 2380.34127629732, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.628698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '891420050', 2325.96051969902, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.628698');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '881294356', 3812.36027848785, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.662872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '878113186', 8121.97929994237, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.662872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '879974330', 6826.38056718489, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.662872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '802186110', 4469.78789034109, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.662872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '839798432', 6418.37712972025, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.662872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '839394527', 865.667638924137, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.662872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '822630771', 8111.33073336176, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.662872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '820632732', 4746.77985862996, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.695509');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '895663536', 763.61864941426, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.695509');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '810464549', 3503.9382349874, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.695509');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '810038015', 5175.64746106236, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.695509');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '831640932', 1946.29260831207, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.695509');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '826636164', 8927.09924144908, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.695509');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '871242919', 3328.40392859057, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.734');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '827203144', 2717.7235363473, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.734');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '818201399', 9685.03202698261, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.734');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '842767011', 5399.0365795073, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.734');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '871226849', 3226.13314603734, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.734');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '828877547', 8396.05638844705, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.767642');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '803598115', 4399.13585719186, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.767642');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '841405627', 9281.26128207294, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.767642');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '881613172', 3362.28114390373, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.767642');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '856589401', 1367.04186923056, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.767642');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '863700769', 8929.90021775209, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.767642');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '881862150', 918.205657456094, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.816135');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '817192943', 3783.48182799301, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.816135');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '865004722', 6503.68325573826, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.816135');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '867448417', 9692.35606873609, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.816135');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '849474678', 3090.41993606179, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.816135');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '847693270', 2004.86321025606, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.853012');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '841607636', 4953.82728645118, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.853012');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '807202254', 3080.86588504033, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.853012');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '865346587', 1322.69463745738, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.853012');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '803797113', 5880.11198041658, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.853012');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '859015070', 1539.08985796849, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.853012');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '831988569', 3729.68719903741, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.89405');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '817536912', 2645.89257800996, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.89405');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '815652536', 5126.02842225104, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.89405');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '820854735', 6540.8343867555, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.89405');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '845223389', 5860.5817946938, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.89405');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '822319019', 8716.27319049874, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.89405');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '890009028', 3618.44145726344, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.946116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '800496904', 5709.76214626031, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.946116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '817109970', 6391.85003323635, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.946116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '895079930', 9602.9049781166, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.946116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '875821555', 6656.88431971422, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.946116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '850014769', 4850.49890678321, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.946116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '885587354', 1282.29524084801, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.946116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '857586849', 7810.74664544147, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.985208');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '839952701', 6404.7063762044, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.985208');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '803031804', 3031.55283520359, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.985208');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '875659837', 2552.9985155905, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.985208');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '832650403', 1144.50572268901, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.985208');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '883770442', 7209.94971982239, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.985208');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '845481784', 1491.03518439747, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:14.985208');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '854542822', 947.068685022733, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.031943');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '835249198', 7148.85203530439, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.031943');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '813953566', 2641.6863985954, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.031943');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '850540874', 5544.75571266341, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.031943');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '858828188', 5739.23870844093, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.031943');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '864210989', 3370.15962695779, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.07611');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '839996129', 6206.61494538544, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.07611');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '864263901', 1486.62582079713, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.07611');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '803135962', 3723.85073028701, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.07611');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '870314786', 1370.80525503275, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.07611');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '863760146', 7915.4931119943, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.07611');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '861668570', 8581.37657867069, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.07611');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '830704856', 9341.18060405899, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.07611');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '889855312', 9743.54891828212, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.07611');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '863259727', 8176.15989180881, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.133246');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '840135251', 1463.1903569421, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.133246');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '864494818', 6982.28362305634, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.133246');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '825695325', 1734.30588420981, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.133246');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '836073862', 1459.35009551517, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.133246');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '840058730', 4116.38580862584, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.133246');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '846660938', 3809.11557087103, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.211445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '898659607', 1527.20440483843, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.211445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '854921842', 4813.21188970248, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.211445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '873055761', 1972.8007241893, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.211445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '805992114', 2392.13708889368, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.211445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '851892457', 6064.02286046017, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.211445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '814941134', 8981.53647156524, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.211445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '888656414', 5679.08024457442, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.211445');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '800959797', 3874.77578513741, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.262289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '850493038', 3680.4425842568, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.262289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '882620191', 1397.01851453721, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.262289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '854180739', 7291.70485273098, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.262289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '886068919', 9640.76070660533, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.262289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '833662587', 6884.82185220281, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.262289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '873385075', 4814.42849679778, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.262289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '843099645', 824.73349613701, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.262289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '825885334', 2072.88662513089, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.262289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '872228537', 9683.40643368358, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.262289');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '852201319', 3204.36731434206, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.351693');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '890363371', 1914.06630608055, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.351693');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '815843495', 5210.0582726215, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.351693');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '852930359', 4056.71068315284, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.351693');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '837843994', 1404.60119918385, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.351693');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '806010146', 7524.10338529058, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.351693');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '886905862', 3472.12230160361, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.351693');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '835407686', 9328.93424519137, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.351693');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '840931417', 7483.30670292218, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.441964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '867005478', 1521.53041791163, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.441964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '878801449', 1663.03366404085, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.441964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '892032684', 7578.13786181096, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.441964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '860955788', 383.365856638626, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.441964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '843920371', 602.725154110976, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.441964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '882995152', 1509.66642552897, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.441964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '887827580', 5505.36786234837, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.441964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '826333991', 5426.74060868293, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.441964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '867611681', 3440.55835517992, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.441964');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '815182148', 3729.38316177679, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.501');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '873874881', 1320.16162435922, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.501');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '882455206', 1670.6075409654, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.501');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '845232041', 4966.16430082542, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.501');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '882850737', 4650.9406784109, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.501');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '865259870', 2825.15900749561, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.501');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '828007957', 4707.99510923756, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.501');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '808270377', 8017.76191080265, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.536259');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '851384052', 7239.1613543189, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.536259');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '898600714', 2717.62419806377, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.536259');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '839935652', 6162.38163697374, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.536259');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '810141839', 8232.87745044523, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.536259');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '891333152', 4111.12942624139, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.536259');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '805164879', 358.006434002956, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.567121');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '824498308', 9587.42826012579, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.567121');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '844282783', 2203.52480125372, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.567121');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '817531159', 5421.47873058647, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.567121');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '855550271', 47.3905062993247, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.567121');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '869652681', 3220.7431625872, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.600158');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '898751589', 9853.97351310391, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.600158');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '878967112', 2145.17111642689, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.600158');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '864003987', 3922.36504100645, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.600158');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '832458613', 8836.13415896571, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.600158');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '806008111', 1440.55915543078, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.661126');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '850214782', 8729.31736068146, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.661126');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '803104220', 5913.27423097405, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.661126');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '850426549', 3165.07571084216, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.661126');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '848391514', 1773.71007445374, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.661126');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '885388008', 8019.52408351388, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.661126');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '822821338', 9473.0713162895, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.707537');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '822030521', 924.937644455661, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.707537');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '875874693', 9106.34251548536, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.707537');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '812765101', 5887.26316569989, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.707537');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '838926551', 1444.84205097353, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.707537');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '899799563', 1443.17434185055, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.707537');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '809015209', 5360.87290543624, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.759975');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '820034238', 1949.10980849988, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.759975');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '895498055', 951.328708042529, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.759975');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '828601859', 6180.3066773338, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.759975');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '801604353', 3636.01822174653, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.759975');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '800776323', 5885.03502638982, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.759975');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '844347164', 3672.93444939424, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.759975');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '818219358', 6256.70389473755, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.759975');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '823902704', 3326.8168111203, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.759975');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '883162812', 4668.4474196992, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.806941');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '889910960', 4226.5895805101, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.806941');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '865749324', 7960.80841328798, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.806941');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '850763986', 4730.12514586461, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.806941');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '880519699', 2954.85382125127, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.806941');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '852625515', 3547.90272645991, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.806941');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '861045673', 3451.13302348401, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.84107');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '833793182', 8456.67715828312, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.84107');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '831330573', 2523.35237902716, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.84107');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '861523860', 5779.04454560496, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.84107');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '824098672', 9500.53279597018, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.84107');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '823778083', 1963.11284053219, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.84107');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '809293796', 8159.60561478604, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.84107');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '833398283', 7107.74563642302, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.876454');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '850432266', 1793.87185801331, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.876454');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '881380147', 3848.76536304467, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.876454');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '863782541', 7222.31865231139, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.876454');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '853151041', 9994.38314040033, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.876454');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '802050060', 3062.16059574985, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.876454');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '853061189', 6585.98229801163, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.921046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '839895479', 5259.17707746163, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.921046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '850029414', 1869.80027984345, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.921046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '850745866', 2187.34459398124, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.921046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '862302999', 1036.32880745023, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.921046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '838387901', 616.329866781859, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.921046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '893095117', 7442.14669248092, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.921046');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '891087784', 7248.48643433755, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.966415');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '814614016', 8072.07126229859, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.966415');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '808055576', 7122.68536361658, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.966415');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '807375408', 9900.41020352905, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.966415');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '812020182', 7379.17949892621, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.966415');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '813691924', 210.624842582751, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.998659');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '889537777', 992.062534203702, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.998659');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '889923016', 1203.64232348712, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.998659');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '883410497', 8119.04260314323, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.998659');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '859214047', 7779.84499361354, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:15.998659');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '899398352', 155.984885039701, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:16.033108');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '888885608', 4164.05433670267, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.401107');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '886738603', 656.993759524841, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.421656');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '824252875', 3362.87608578737, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.444009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '815130751', 8135.29512187115, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.444009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '807181403', 6250.81862862571, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.444009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '825701028', 6209.79136180211, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.444009');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '880991109', 3729.82585060857, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.477279');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '863223995', 5882.83635481715, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.477279');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '855193175', 8285.41201490279, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.477279');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '851914695', 9926.78965640774, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.477279');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '860138637', 7877.51534121635, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.503434');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '842209425', 2968.38655111615, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.503434');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '886312075', 3948.71516069296, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.503434');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '806191555', 1750.49534593331, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.503434');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '812570442', 3963.79766294868, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.503434');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '842756602', 9357.8780885358, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.503434');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '864760613', 663.30379228792, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.503434');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '861707783', 6844.0251784477, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-07 12:10:21.538491');


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:46.345842', '2023-09-07 12:09:46.345842');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:46.490595', '2023-09-07 12:09:46.490595');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:46.560725', '2023-09-07 12:09:46.560725');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:46.620027', '2023-09-07 12:09:46.620027');
INSERT INTO public.virksomhet VALUES (5, '898923784', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898923784', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:46.906747', '2023-09-07 12:09:46.906747');
INSERT INTO public.virksomhet VALUES (6, '892399737', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892399737', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:46.961687', '2023-09-07 12:09:46.961687');
INSERT INTO public.virksomhet VALUES (7, '826590600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826590600', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.010642', '2023-09-07 12:09:47.010642');
INSERT INTO public.virksomhet VALUES (8, '831268381', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831268381', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.053523', '2023-09-07 12:09:47.053523');
INSERT INTO public.virksomhet VALUES (9, '895089382', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895089382', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.123721', '2023-09-07 12:09:47.123721');
INSERT INTO public.virksomhet VALUES (10, '853015007', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853015007', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.182146', '2023-09-07 12:09:47.182146');
INSERT INTO public.virksomhet VALUES (11, '825079892', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825079892', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.247736', '2023-09-07 12:09:47.247736');
INSERT INTO public.virksomhet VALUES (12, '860686834', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860686834', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.306073', '2023-09-07 12:09:47.306073');
INSERT INTO public.virksomhet VALUES (13, '874808559', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874808559', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.367058', '2023-09-07 12:09:47.367058');
INSERT INTO public.virksomhet VALUES (14, '898523088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898523088', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.43089', '2023-09-07 12:09:47.43089');
INSERT INTO public.virksomhet VALUES (15, '885058584', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885058584', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.486442', '2023-09-07 12:09:47.486442');
INSERT INTO public.virksomhet VALUES (16, '851282088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851282088', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.545148', '2023-09-07 12:09:47.545148');
INSERT INTO public.virksomhet VALUES (17, '877208213', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877208213', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.596463', '2023-09-07 12:09:47.596463');
INSERT INTO public.virksomhet VALUES (18, '842272409', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842272409', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.656496', '2023-09-07 12:09:47.656496');
INSERT INTO public.virksomhet VALUES (19, '829660290', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829660290', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.708804', '2023-09-07 12:09:47.708804');
INSERT INTO public.virksomhet VALUES (20, '899090884', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899090884', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.76439', '2023-09-07 12:09:47.76439');
INSERT INTO public.virksomhet VALUES (21, '848928047', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848928047', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.827478', '2023-09-07 12:09:47.827478');
INSERT INTO public.virksomhet VALUES (22, '871424742', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871424742', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.869484', '2023-09-07 12:09:47.869484');
INSERT INTO public.virksomhet VALUES (23, '886017047', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886017047', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.932037', '2023-09-07 12:09:47.932037');
INSERT INTO public.virksomhet VALUES (24, '833439299', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833439299', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:47.987341', '2023-09-07 12:09:47.987341');
INSERT INTO public.virksomhet VALUES (25, '897462626', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897462626', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.041161', '2023-09-07 12:09:48.041161');
INSERT INTO public.virksomhet VALUES (26, '802345222', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802345222', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.092953', '2023-09-07 12:09:48.092953');
INSERT INTO public.virksomhet VALUES (27, '820451130', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820451130', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.145012', '2023-09-07 12:09:48.145012');
INSERT INTO public.virksomhet VALUES (28, '831580863', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831580863', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.198527', '2023-09-07 12:09:48.198527');
INSERT INTO public.virksomhet VALUES (29, '833761548', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833761548', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.250245', '2023-09-07 12:09:48.250245');
INSERT INTO public.virksomhet VALUES (30, '890808319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890808319', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.303684', '2023-09-07 12:09:48.303684');
INSERT INTO public.virksomhet VALUES (31, '823222591', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823222591', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.370602', '2023-09-07 12:09:48.370602');
INSERT INTO public.virksomhet VALUES (32, '819370689', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819370689', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.442259', '2023-09-07 12:09:48.442259');
INSERT INTO public.virksomhet VALUES (33, '877074185', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877074185', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.502218', '2023-09-07 12:09:48.502218');
INSERT INTO public.virksomhet VALUES (34, '877076454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877076454', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.570045', '2023-09-07 12:09:48.570045');
INSERT INTO public.virksomhet VALUES (35, '817705715', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817705715', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.617993', '2023-09-07 12:09:48.617993');
INSERT INTO public.virksomhet VALUES (36, '898846403', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898846403', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.668214', '2023-09-07 12:09:48.668214');
INSERT INTO public.virksomhet VALUES (37, '873361735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873361735', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.711073', '2023-09-07 12:09:48.711073');
INSERT INTO public.virksomhet VALUES (38, '868944192', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868944192', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.75533', '2023-09-07 12:09:48.75533');
INSERT INTO public.virksomhet VALUES (39, '884366382', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884366382', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.79792', '2023-09-07 12:09:48.79792');
INSERT INTO public.virksomhet VALUES (40, '802244769', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802244769', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.837153', '2023-09-07 12:09:48.837153');
INSERT INTO public.virksomhet VALUES (41, '876487875', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876487875', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.897109', '2023-09-07 12:09:48.897109');
INSERT INTO public.virksomhet VALUES (42, '835982972', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835982972', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:48.958214', '2023-09-07 12:09:48.958214');
INSERT INTO public.virksomhet VALUES (43, '895727413', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895727413', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.008207', '2023-09-07 12:09:49.008207');
INSERT INTO public.virksomhet VALUES (44, '884201205', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884201205', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.054591', '2023-09-07 12:09:49.054591');
INSERT INTO public.virksomhet VALUES (45, '883177876', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883177876', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.097026', '2023-09-07 12:09:49.097026');
INSERT INTO public.virksomhet VALUES (46, '867694191', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867694191', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.152181', '2023-09-07 12:09:49.152181');
INSERT INTO public.virksomhet VALUES (47, '852811561', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852811561', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.191571', '2023-09-07 12:09:49.191571');
INSERT INTO public.virksomhet VALUES (48, '886557526', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886557526', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.224878', '2023-09-07 12:09:49.224878');
INSERT INTO public.virksomhet VALUES (49, '876660082', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876660082', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.277051', '2023-09-07 12:09:49.277051');
INSERT INTO public.virksomhet VALUES (50, '834218334', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834218334', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.319605', '2023-09-07 12:09:49.319605');
INSERT INTO public.virksomhet VALUES (51, '851696278', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851696278', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.359163', '2023-09-07 12:09:49.359163');
INSERT INTO public.virksomhet VALUES (52, '879389524', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879389524', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.407871', '2023-09-07 12:09:49.407871');
INSERT INTO public.virksomhet VALUES (53, '858910824', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858910824', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.470627', '2023-09-07 12:09:49.470627');
INSERT INTO public.virksomhet VALUES (54, '804672944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804672944', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.514356', '2023-09-07 12:09:49.514356');
INSERT INTO public.virksomhet VALUES (55, '863104947', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863104947', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.5411', '2023-09-07 12:09:49.5411');
INSERT INTO public.virksomhet VALUES (56, '896697110', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896697110', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.571364', '2023-09-07 12:09:49.571364');
INSERT INTO public.virksomhet VALUES (57, '853727860', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853727860', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.621255', '2023-09-07 12:09:49.621255');
INSERT INTO public.virksomhet VALUES (58, '802940728', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802940728', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.654819', '2023-09-07 12:09:49.654819');
INSERT INTO public.virksomhet VALUES (59, '836011249', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836011249', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.698123', '2023-09-07 12:09:49.698123');
INSERT INTO public.virksomhet VALUES (60, '842449018', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842449018', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.746161', '2023-09-07 12:09:49.746161');
INSERT INTO public.virksomhet VALUES (61, '880726000', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880726000', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.800202', '2023-09-07 12:09:49.800202');
INSERT INTO public.virksomhet VALUES (62, '848129204', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848129204', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.843806', '2023-09-07 12:09:49.843806');
INSERT INTO public.virksomhet VALUES (63, '818713664', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818713664', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.889623', '2023-09-07 12:09:49.889623');
INSERT INTO public.virksomhet VALUES (64, '853176413', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853176413', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.933406', '2023-09-07 12:09:49.933406');
INSERT INTO public.virksomhet VALUES (65, '823756322', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823756322', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:49.985906', '2023-09-07 12:09:49.985906');
INSERT INTO public.virksomhet VALUES (66, '881363295', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881363295', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.048071', '2023-09-07 12:09:50.048071');
INSERT INTO public.virksomhet VALUES (67, '805152073', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805152073', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.107207', '2023-09-07 12:09:50.107207');
INSERT INTO public.virksomhet VALUES (68, '825084231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825084231', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.161998', '2023-09-07 12:09:50.161998');
INSERT INTO public.virksomhet VALUES (69, '880791986', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880791986', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.197045', '2023-09-07 12:09:50.197045');
INSERT INTO public.virksomhet VALUES (70, '852913999', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852913999', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.225047', '2023-09-07 12:09:50.225047');
INSERT INTO public.virksomhet VALUES (71, '802850977', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802850977', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.280463', '2023-09-07 12:09:50.280463');
INSERT INTO public.virksomhet VALUES (72, '841747129', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841747129', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.352818', '2023-09-07 12:09:50.352818');
INSERT INTO public.virksomhet VALUES (73, '844487259', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844487259', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.402871', '2023-09-07 12:09:50.402871');
INSERT INTO public.virksomhet VALUES (74, '890392943', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890392943', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.456269', '2023-09-07 12:09:50.456269');
INSERT INTO public.virksomhet VALUES (75, '804733585', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804733585', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.49537', '2023-09-07 12:09:50.49537');
INSERT INTO public.virksomhet VALUES (76, '826874776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826874776', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.537562', '2023-09-07 12:09:50.537562');
INSERT INTO public.virksomhet VALUES (77, '814797885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814797885', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.565524', '2023-09-07 12:09:50.565524');
INSERT INTO public.virksomhet VALUES (78, '881250910', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881250910', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.614961', '2023-09-07 12:09:50.614961');
INSERT INTO public.virksomhet VALUES (79, '869292565', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869292565', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.675233', '2023-09-07 12:09:50.675233');
INSERT INTO public.virksomhet VALUES (80, '891967915', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891967915', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.724698', '2023-09-07 12:09:50.724698');
INSERT INTO public.virksomhet VALUES (81, '823567033', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823567033', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.765282', '2023-09-07 12:09:50.765282');
INSERT INTO public.virksomhet VALUES (82, '804739623', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804739623', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.815148', '2023-09-07 12:09:50.815148');
INSERT INTO public.virksomhet VALUES (83, '809157105', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809157105', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.865106', '2023-09-07 12:09:50.865106');
INSERT INTO public.virksomhet VALUES (84, '818314307', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818314307', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.911142', '2023-09-07 12:09:50.911142');
INSERT INTO public.virksomhet VALUES (85, '873865403', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873865403', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:50.97514', '2023-09-07 12:09:50.97514');
INSERT INTO public.virksomhet VALUES (86, '872220974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872220974', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.008665', '2023-09-07 12:09:51.008665');
INSERT INTO public.virksomhet VALUES (87, '871740960', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871740960', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.041403', '2023-09-07 12:09:51.041403');
INSERT INTO public.virksomhet VALUES (88, '839209391', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839209391', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.080778', '2023-09-07 12:09:51.080778');
INSERT INTO public.virksomhet VALUES (89, '845126466', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845126466', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.124423', '2023-09-07 12:09:51.124423');
INSERT INTO public.virksomhet VALUES (90, '823308255', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823308255', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.198278', '2023-09-07 12:09:51.198278');
INSERT INTO public.virksomhet VALUES (91, '838170047', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838170047', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.24857', '2023-09-07 12:09:51.24857');
INSERT INTO public.virksomhet VALUES (92, '898389901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898389901', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.297087', '2023-09-07 12:09:51.297087');
INSERT INTO public.virksomhet VALUES (93, '839244653', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839244653', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.335099', '2023-09-07 12:09:51.335099');
INSERT INTO public.virksomhet VALUES (94, '888286666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888286666', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.355673', '2023-09-07 12:09:51.355673');
INSERT INTO public.virksomhet VALUES (95, '818063008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818063008', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.396324', '2023-09-07 12:09:51.396324');
INSERT INTO public.virksomhet VALUES (96, '837482396', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837482396', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.453344', '2023-09-07 12:09:51.453344');
INSERT INTO public.virksomhet VALUES (97, '887156552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887156552', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.513425', '2023-09-07 12:09:51.513425');
INSERT INTO public.virksomhet VALUES (98, '806165288', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806165288', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.606968', '2023-09-07 12:09:51.606968');
INSERT INTO public.virksomhet VALUES (99, '868645574', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868645574', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.68309', '2023-09-07 12:09:51.68309');
INSERT INTO public.virksomhet VALUES (100, '883595681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883595681', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.729754', '2023-09-07 12:09:51.729754');
INSERT INTO public.virksomhet VALUES (101, '814308411', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814308411', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.789034', '2023-09-07 12:09:51.789034');
INSERT INTO public.virksomhet VALUES (102, '811454092', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811454092', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.862552', '2023-09-07 12:09:51.862552');
INSERT INTO public.virksomhet VALUES (103, '841274453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841274453', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.906555', '2023-09-07 12:09:51.906555');
INSERT INTO public.virksomhet VALUES (104, '876450529', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876450529', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.951532', '2023-09-07 12:09:51.951532');
INSERT INTO public.virksomhet VALUES (105, '832025086', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832025086', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:51.99315', '2023-09-07 12:09:51.99315');
INSERT INTO public.virksomhet VALUES (106, '876040207', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876040207', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.043987', '2023-09-07 12:09:52.043987');
INSERT INTO public.virksomhet VALUES (107, '808044969', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808044969', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.089103', '2023-09-07 12:09:52.089103');
INSERT INTO public.virksomhet VALUES (108, '815657103', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815657103', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.121601', '2023-09-07 12:09:52.121601');
INSERT INTO public.virksomhet VALUES (109, '806207908', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806207908', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.16055', '2023-09-07 12:09:52.16055');
INSERT INTO public.virksomhet VALUES (110, '863372662', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863372662', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.203353', '2023-09-07 12:09:52.203353');
INSERT INTO public.virksomhet VALUES (111, '816502624', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816502624', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.246742', '2023-09-07 12:09:52.246742');
INSERT INTO public.virksomhet VALUES (112, '852986256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852986256', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.290755', '2023-09-07 12:09:52.290755');
INSERT INTO public.virksomhet VALUES (113, '853555598', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853555598', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.336318', '2023-09-07 12:09:52.336318');
INSERT INTO public.virksomhet VALUES (114, '835392717', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835392717', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.403031', '2023-09-07 12:09:52.403031');
INSERT INTO public.virksomhet VALUES (115, '817070709', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817070709', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.446306', '2023-09-07 12:09:52.446306');
INSERT INTO public.virksomhet VALUES (116, '810311994', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810311994', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.486282', '2023-09-07 12:09:52.486282');
INSERT INTO public.virksomhet VALUES (117, '850022448', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850022448', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.543085', '2023-09-07 12:09:52.543085');
INSERT INTO public.virksomhet VALUES (118, '806685779', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806685779', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.684647', '2023-09-07 12:09:52.684647');
INSERT INTO public.virksomhet VALUES (119, '803687989', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803687989', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.808141', '2023-09-07 12:09:52.808141');
INSERT INTO public.virksomhet VALUES (120, '853443507', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853443507', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.885395', '2023-09-07 12:09:52.885395');
INSERT INTO public.virksomhet VALUES (121, '845560676', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845560676', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.93765', '2023-09-07 12:09:52.93765');
INSERT INTO public.virksomhet VALUES (122, '827358643', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827358643', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:52.99304', '2023-09-07 12:09:52.99304');
INSERT INTO public.virksomhet VALUES (123, '874825286', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874825286', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.060711', '2023-09-07 12:09:53.060711');
INSERT INTO public.virksomhet VALUES (124, '880253499', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880253499', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.147776', '2023-09-07 12:09:53.147776');
INSERT INTO public.virksomhet VALUES (125, '835809313', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835809313', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.196034', '2023-09-07 12:09:53.196034');
INSERT INTO public.virksomhet VALUES (126, '896901593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896901593', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.288658', '2023-09-07 12:09:53.288658');
INSERT INTO public.virksomhet VALUES (127, '802899775', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802899775', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.364807', '2023-09-07 12:09:53.364807');
INSERT INTO public.virksomhet VALUES (128, '838961590', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838961590', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.433676', '2023-09-07 12:09:53.433676');
INSERT INTO public.virksomhet VALUES (129, '892373226', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892373226', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.51031', '2023-09-07 12:09:53.51031');
INSERT INTO public.virksomhet VALUES (130, '841507581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841507581', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.574809', '2023-09-07 12:09:53.574809');
INSERT INTO public.virksomhet VALUES (131, '861604952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861604952', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.642543', '2023-09-07 12:09:53.642543');
INSERT INTO public.virksomhet VALUES (132, '854358127', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854358127', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.688906', '2023-09-07 12:09:53.688906');
INSERT INTO public.virksomhet VALUES (133, '852267877', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852267877', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.749601', '2023-09-07 12:09:53.749601');
INSERT INTO public.virksomhet VALUES (134, '847360475', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847360475', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.822768', '2023-09-07 12:09:53.822768');
INSERT INTO public.virksomhet VALUES (135, '853302353', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853302353', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.876356', '2023-09-07 12:09:53.876356');
INSERT INTO public.virksomhet VALUES (136, '808758602', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808758602', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.933529', '2023-09-07 12:09:53.933529');
INSERT INTO public.virksomhet VALUES (137, '881135497', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881135497', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:53.991749', '2023-09-07 12:09:53.991749');
INSERT INTO public.virksomhet VALUES (138, '883221257', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883221257', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.086857', '2023-09-07 12:09:54.086857');
INSERT INTO public.virksomhet VALUES (139, '829482164', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829482164', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.183876', '2023-09-07 12:09:54.183876');
INSERT INTO public.virksomhet VALUES (140, '856230051', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856230051', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.254464', '2023-09-07 12:09:54.254464');
INSERT INTO public.virksomhet VALUES (141, '810249268', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810249268', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.310833', '2023-09-07 12:09:54.310833');
INSERT INTO public.virksomhet VALUES (142, '892788724', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892788724', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.358178', '2023-09-07 12:09:54.358178');
INSERT INTO public.virksomhet VALUES (143, '840025055', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840025055', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.414806', '2023-09-07 12:09:54.414806');
INSERT INTO public.virksomhet VALUES (144, '821348427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821348427', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.45387', '2023-09-07 12:09:54.45387');
INSERT INTO public.virksomhet VALUES (145, '807977696', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807977696', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.491468', '2023-09-07 12:09:54.491468');
INSERT INTO public.virksomhet VALUES (146, '879659474', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879659474', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.526325', '2023-09-07 12:09:54.526325');
INSERT INTO public.virksomhet VALUES (147, '897882038', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897882038', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.57527', '2023-09-07 12:09:54.57527');
INSERT INTO public.virksomhet VALUES (148, '828677735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828677735', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.612931', '2023-09-07 12:09:54.612931');
INSERT INTO public.virksomhet VALUES (149, '879034952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879034952', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.673198', '2023-09-07 12:09:54.673198');
INSERT INTO public.virksomhet VALUES (150, '865949769', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865949769', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.724243', '2023-09-07 12:09:54.724243');
INSERT INTO public.virksomhet VALUES (151, '847877290', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847877290', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.762576', '2023-09-07 12:09:54.762576');
INSERT INTO public.virksomhet VALUES (152, '850257793', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850257793', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.789933', '2023-09-07 12:09:54.789933');
INSERT INTO public.virksomhet VALUES (153, '830101038', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830101038', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.831591', '2023-09-07 12:09:54.831591');
INSERT INTO public.virksomhet VALUES (154, '823151420', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823151420', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.862267', '2023-09-07 12:09:54.862267');
INSERT INTO public.virksomhet VALUES (155, '809286516', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809286516', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.895517', '2023-09-07 12:09:54.895517');
INSERT INTO public.virksomhet VALUES (156, '819145900', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819145900', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.95358', '2023-09-07 12:09:54.95358');
INSERT INTO public.virksomhet VALUES (157, '863874454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863874454', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:54.995438', '2023-09-07 12:09:54.995438');
INSERT INTO public.virksomhet VALUES (158, '884217469', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884217469', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.041171', '2023-09-07 12:09:55.041171');
INSERT INTO public.virksomhet VALUES (159, '867258510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867258510', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.082437', '2023-09-07 12:09:55.082437');
INSERT INTO public.virksomhet VALUES (160, '897988683', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897988683', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.108341', '2023-09-07 12:09:55.108341');
INSERT INTO public.virksomhet VALUES (161, '844667733', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844667733', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.145513', '2023-09-07 12:09:55.145513');
INSERT INTO public.virksomhet VALUES (162, '844723188', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844723188', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.176833', '2023-09-07 12:09:55.176833');
INSERT INTO public.virksomhet VALUES (163, '818141808', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818141808', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.213502', '2023-09-07 12:09:55.213502');
INSERT INTO public.virksomhet VALUES (164, '859165386', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859165386', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.245988', '2023-09-07 12:09:55.245988');
INSERT INTO public.virksomhet VALUES (165, '865504204', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865504204', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.281247', '2023-09-07 12:09:55.281247');
INSERT INTO public.virksomhet VALUES (166, '898737040', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898737040', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.330335', '2023-09-07 12:09:55.330335');
INSERT INTO public.virksomhet VALUES (167, '891816187', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891816187', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.3775', '2023-09-07 12:09:55.3775');
INSERT INTO public.virksomhet VALUES (168, '816256086', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816256086', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.416485', '2023-09-07 12:09:55.416485');
INSERT INTO public.virksomhet VALUES (169, '877756065', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877756065', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.450101', '2023-09-07 12:09:55.450101');
INSERT INTO public.virksomhet VALUES (170, '828223293', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828223293', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.490925', '2023-09-07 12:09:55.490925');
INSERT INTO public.virksomhet VALUES (171, '846339829', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846339829', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.5347', '2023-09-07 12:09:55.5347');
INSERT INTO public.virksomhet VALUES (172, '850152691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850152691', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.562989', '2023-09-07 12:09:55.562989');
INSERT INTO public.virksomhet VALUES (173, '890037539', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890037539', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.615123', '2023-09-07 12:09:55.615123');
INSERT INTO public.virksomhet VALUES (174, '822458792', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822458792', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.687501', '2023-09-07 12:09:55.687501');
INSERT INTO public.virksomhet VALUES (175, '809266951', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809266951', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.72139', '2023-09-07 12:09:55.72139');
INSERT INTO public.virksomhet VALUES (176, '899886628', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899886628', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.75947', '2023-09-07 12:09:55.75947');
INSERT INTO public.virksomhet VALUES (177, '886901775', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886901775', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.790576', '2023-09-07 12:09:55.790576');
INSERT INTO public.virksomhet VALUES (178, '886470266', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886470266', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.81517', '2023-09-07 12:09:55.81517');
INSERT INTO public.virksomhet VALUES (179, '811210451', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811210451', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.844223', '2023-09-07 12:09:55.844223');
INSERT INTO public.virksomhet VALUES (180, '888988714', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888988714', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.876885', '2023-09-07 12:09:55.876885');
INSERT INTO public.virksomhet VALUES (181, '826324969', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826324969', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.917591', '2023-09-07 12:09:55.917591');
INSERT INTO public.virksomhet VALUES (182, '807828501', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807828501', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.947445', '2023-09-07 12:09:55.947445');
INSERT INTO public.virksomhet VALUES (183, '892008639', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892008639', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:55.993977', '2023-09-07 12:09:55.993977');
INSERT INTO public.virksomhet VALUES (184, '888721551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888721551', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.03565', '2023-09-07 12:09:56.03565');
INSERT INTO public.virksomhet VALUES (185, '879069742', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879069742', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.073018', '2023-09-07 12:09:56.073018');
INSERT INTO public.virksomhet VALUES (186, '808964650', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808964650', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.107794', '2023-09-07 12:09:56.107794');
INSERT INTO public.virksomhet VALUES (187, '884187399', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884187399', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.138995', '2023-09-07 12:09:56.138995');
INSERT INTO public.virksomhet VALUES (188, '824468605', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824468605', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.185022', '2023-09-07 12:09:56.185022');
INSERT INTO public.virksomhet VALUES (189, '888257410', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888257410', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.216918', '2023-09-07 12:09:56.216918');
INSERT INTO public.virksomhet VALUES (190, '854254584', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854254584', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.267614', '2023-09-07 12:09:56.267614');
INSERT INTO public.virksomhet VALUES (191, '862727618', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862727618', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.327925', '2023-09-07 12:09:56.327925');
INSERT INTO public.virksomhet VALUES (192, '835427889', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835427889', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.375978', '2023-09-07 12:09:56.375978');
INSERT INTO public.virksomhet VALUES (193, '820294549', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820294549', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.452337', '2023-09-07 12:09:56.452337');
INSERT INTO public.virksomhet VALUES (194, '806377882', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806377882', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.511664', '2023-09-07 12:09:56.511664');
INSERT INTO public.virksomhet VALUES (195, '845531199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845531199', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.563965', '2023-09-07 12:09:56.563965');
INSERT INTO public.virksomhet VALUES (196, '830603806', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830603806', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.605999', '2023-09-07 12:09:56.605999');
INSERT INTO public.virksomhet VALUES (197, '804075321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804075321', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.653389', '2023-09-07 12:09:56.653389');
INSERT INTO public.virksomhet VALUES (198, '891705500', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891705500', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.689236', '2023-09-07 12:09:56.689236');
INSERT INTO public.virksomhet VALUES (199, '805367803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805367803', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.724125', '2023-09-07 12:09:56.724125');
INSERT INTO public.virksomhet VALUES (200, '883071436', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883071436', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.755931', '2023-09-07 12:09:56.755931');
INSERT INTO public.virksomhet VALUES (201, '846197303', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846197303', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.802993', '2023-09-07 12:09:56.802993');
INSERT INTO public.virksomhet VALUES (202, '868131855', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868131855', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.834935', '2023-09-07 12:09:56.834935');
INSERT INTO public.virksomhet VALUES (203, '811538812', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811538812', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.893165', '2023-09-07 12:09:56.893165');
INSERT INTO public.virksomhet VALUES (204, '835595464', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835595464', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:56.962117', '2023-09-07 12:09:56.962117');
INSERT INTO public.virksomhet VALUES (205, '852912939', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852912939', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.032197', '2023-09-07 12:09:57.032197');
INSERT INTO public.virksomhet VALUES (206, '890193691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890193691', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.075262', '2023-09-07 12:09:57.075262');
INSERT INTO public.virksomhet VALUES (207, '834044439', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834044439', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.127531', '2023-09-07 12:09:57.127531');
INSERT INTO public.virksomhet VALUES (208, '801308434', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801308434', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.159709', '2023-09-07 12:09:57.159709');
INSERT INTO public.virksomhet VALUES (209, '895387215', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895387215', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.193699', '2023-09-07 12:09:57.193699');
INSERT INTO public.virksomhet VALUES (210, '803097144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803097144', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.219175', '2023-09-07 12:09:57.219175');
INSERT INTO public.virksomhet VALUES (211, '820460681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820460681', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.243212', '2023-09-07 12:09:57.243212');
INSERT INTO public.virksomhet VALUES (212, '893391635', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893391635', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.284296', '2023-09-07 12:09:57.284296');
INSERT INTO public.virksomhet VALUES (213, '803964775', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803964775', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.307848', '2023-09-07 12:09:57.307848');
INSERT INTO public.virksomhet VALUES (214, '830940695', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830940695', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.346092', '2023-09-07 12:09:57.346092');
INSERT INTO public.virksomhet VALUES (215, '821384683', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821384683', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.3812', '2023-09-07 12:09:57.3812');
INSERT INTO public.virksomhet VALUES (216, '816338918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816338918', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.412555', '2023-09-07 12:09:57.412555');
INSERT INTO public.virksomhet VALUES (217, '858327975', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858327975', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.452904', '2023-09-07 12:09:57.452904');
INSERT INTO public.virksomhet VALUES (218, '814845704', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814845704', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.487748', '2023-09-07 12:09:57.487748');
INSERT INTO public.virksomhet VALUES (219, '807845910', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807845910', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.52603', '2023-09-07 12:09:57.52603');
INSERT INTO public.virksomhet VALUES (220, '870936597', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870936597', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.555142', '2023-09-07 12:09:57.555142');
INSERT INTO public.virksomhet VALUES (221, '837540796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837540796', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.579328', '2023-09-07 12:09:57.579328');
INSERT INTO public.virksomhet VALUES (222, '865165723', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865165723', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.616338', '2023-09-07 12:09:57.616338');
INSERT INTO public.virksomhet VALUES (223, '809257693', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809257693', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.65516', '2023-09-07 12:09:57.65516');
INSERT INTO public.virksomhet VALUES (224, '889852300', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889852300', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.677597', '2023-09-07 12:09:57.677597');
INSERT INTO public.virksomhet VALUES (225, '824510214', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824510214', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.703507', '2023-09-07 12:09:57.703507');
INSERT INTO public.virksomhet VALUES (226, '878219794', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878219794', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.743546', '2023-09-07 12:09:57.743546');
INSERT INTO public.virksomhet VALUES (227, '833777549', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833777549', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.768634', '2023-09-07 12:09:57.768634');
INSERT INTO public.virksomhet VALUES (228, '855806194', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855806194', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.793671', '2023-09-07 12:09:57.793671');
INSERT INTO public.virksomhet VALUES (229, '857619997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857619997', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.818536', '2023-09-07 12:09:57.818536');
INSERT INTO public.virksomhet VALUES (230, '855072065', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855072065', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.851144', '2023-09-07 12:09:57.851144');
INSERT INTO public.virksomhet VALUES (231, '873994005', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873994005', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.87752', '2023-09-07 12:09:57.87752');
INSERT INTO public.virksomhet VALUES (232, '831772492', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831772492', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.909146', '2023-09-07 12:09:57.909146');
INSERT INTO public.virksomhet VALUES (233, '859319655', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859319655', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.936253', '2023-09-07 12:09:57.936253');
INSERT INTO public.virksomhet VALUES (234, '829583457', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829583457', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:57.97324', '2023-09-07 12:09:57.97324');
INSERT INTO public.virksomhet VALUES (235, '863035762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863035762', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.009303', '2023-09-07 12:09:58.009303');
INSERT INTO public.virksomhet VALUES (236, '818423659', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818423659', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.057152', '2023-09-07 12:09:58.057152');
INSERT INTO public.virksomhet VALUES (237, '833484882', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833484882', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.096002', '2023-09-07 12:09:58.096002');
INSERT INTO public.virksomhet VALUES (238, '811684284', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811684284', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.132412', '2023-09-07 12:09:58.132412');
INSERT INTO public.virksomhet VALUES (239, '879108983', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879108983', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.175738', '2023-09-07 12:09:58.175738');
INSERT INTO public.virksomhet VALUES (240, '896403945', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896403945', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.207189', '2023-09-07 12:09:58.207189');
INSERT INTO public.virksomhet VALUES (241, '890608443', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890608443', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.228828', '2023-09-07 12:09:58.228828');
INSERT INTO public.virksomhet VALUES (242, '809234560', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809234560', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.257356', '2023-09-07 12:09:58.257356');
INSERT INTO public.virksomhet VALUES (243, '860066709', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860066709', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.306003', '2023-09-07 12:09:58.306003');
INSERT INTO public.virksomhet VALUES (244, '863069895', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863069895', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.354807', '2023-09-07 12:09:58.354807');
INSERT INTO public.virksomhet VALUES (245, '822751051', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822751051', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.397024', '2023-09-07 12:09:58.397024');
INSERT INTO public.virksomhet VALUES (246, '831730651', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831730651', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.458733', '2023-09-07 12:09:58.458733');
INSERT INTO public.virksomhet VALUES (247, '810588854', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810588854', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.505062', '2023-09-07 12:09:58.505062');
INSERT INTO public.virksomhet VALUES (248, '889005244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889005244', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.54057', '2023-09-07 12:09:58.54057');
INSERT INTO public.virksomhet VALUES (249, '848905304', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848905304', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.57892', '2023-09-07 12:09:58.57892');
INSERT INTO public.virksomhet VALUES (250, '840918223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840918223', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.626701', '2023-09-07 12:09:58.626701');
INSERT INTO public.virksomhet VALUES (251, '837610672', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837610672', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.69656', '2023-09-07 12:09:58.69656');
INSERT INTO public.virksomhet VALUES (252, '813600293', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813600293', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.726065', '2023-09-07 12:09:58.726065');
INSERT INTO public.virksomhet VALUES (253, '814308550', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814308550', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.760893', '2023-09-07 12:09:58.760893');
INSERT INTO public.virksomhet VALUES (254, '875518774', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875518774', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.81478', '2023-09-07 12:09:58.81478');
INSERT INTO public.virksomhet VALUES (255, '825806596', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825806596', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.8701', '2023-09-07 12:09:58.8701');
INSERT INTO public.virksomhet VALUES (256, '891741795', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891741795', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.925252', '2023-09-07 12:09:58.925252');
INSERT INTO public.virksomhet VALUES (257, '898153558', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898153558', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:58.981374', '2023-09-07 12:09:58.981374');
INSERT INTO public.virksomhet VALUES (258, '808363965', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808363965', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.022011', '2023-09-07 12:09:59.022011');
INSERT INTO public.virksomhet VALUES (259, '899444179', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899444179', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.052957', '2023-09-07 12:09:59.052957');
INSERT INTO public.virksomhet VALUES (260, '818741759', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818741759', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.101058', '2023-09-07 12:09:59.101058');
INSERT INTO public.virksomhet VALUES (261, '804864157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804864157', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.128781', '2023-09-07 12:09:59.128781');
INSERT INTO public.virksomhet VALUES (262, '864337109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864337109', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.179923', '2023-09-07 12:09:59.179923');
INSERT INTO public.virksomhet VALUES (263, '886504008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886504008', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.21155', '2023-09-07 12:09:59.21155');
INSERT INTO public.virksomhet VALUES (264, '862771443', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862771443', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.294906', '2023-09-07 12:09:59.294906');
INSERT INTO public.virksomhet VALUES (265, '891584063', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891584063', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.335399', '2023-09-07 12:09:59.335399');
INSERT INTO public.virksomhet VALUES (266, '857560571', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857560571', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.363614', '2023-09-07 12:09:59.363614');
INSERT INTO public.virksomhet VALUES (267, '839718758', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839718758', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.405279', '2023-09-07 12:09:59.405279');
INSERT INTO public.virksomhet VALUES (268, '823097522', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823097522', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.43058', '2023-09-07 12:09:59.43058');
INSERT INTO public.virksomhet VALUES (269, '813365991', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813365991', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.45799', '2023-09-07 12:09:59.45799');
INSERT INTO public.virksomhet VALUES (270, '804699305', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804699305', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.494094', '2023-09-07 12:09:59.494094');
INSERT INTO public.virksomhet VALUES (271, '830939342', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830939342', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.536847', '2023-09-07 12:09:59.536847');
INSERT INTO public.virksomhet VALUES (272, '816881589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816881589', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.578078', '2023-09-07 12:09:59.578078');
INSERT INTO public.virksomhet VALUES (273, '803971965', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803971965', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.612837', '2023-09-07 12:09:59.612837');
INSERT INTO public.virksomhet VALUES (274, '874766433', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874766433', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.660154', '2023-09-07 12:09:59.660154');
INSERT INTO public.virksomhet VALUES (275, '829427942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829427942', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.706816', '2023-09-07 12:09:59.706816');
INSERT INTO public.virksomhet VALUES (276, '865465487', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865465487', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.747001', '2023-09-07 12:09:59.747001');
INSERT INTO public.virksomhet VALUES (277, '824353324', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824353324', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.791614', '2023-09-07 12:09:59.791614');
INSERT INTO public.virksomhet VALUES (278, '852649392', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852649392', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.812209', '2023-09-07 12:09:59.812209');
INSERT INTO public.virksomhet VALUES (279, '819691341', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819691341', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.845202', '2023-09-07 12:09:59.845202');
INSERT INTO public.virksomhet VALUES (280, '841800300', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841800300', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.870441', '2023-09-07 12:09:59.870441');
INSERT INTO public.virksomhet VALUES (281, '875827788', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875827788', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.907505', '2023-09-07 12:09:59.907505');
INSERT INTO public.virksomhet VALUES (282, '873346928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873346928', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.939633', '2023-09-07 12:09:59.939633');
INSERT INTO public.virksomhet VALUES (283, '874317099', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874317099', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:09:59.976069', '2023-09-07 12:09:59.976069');
INSERT INTO public.virksomhet VALUES (284, '824511321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824511321', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.01', '2023-09-07 12:10:00.01');
INSERT INTO public.virksomhet VALUES (285, '893389196', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893389196', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.052943', '2023-09-07 12:10:00.052943');
INSERT INTO public.virksomhet VALUES (286, '891901556', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891901556', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.084612', '2023-09-07 12:10:00.084612');
INSERT INTO public.virksomhet VALUES (287, '897591139', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897591139', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.114549', '2023-09-07 12:10:00.114549');
INSERT INTO public.virksomhet VALUES (288, '821796054', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821796054', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.150215', '2023-09-07 12:10:00.150215');
INSERT INTO public.virksomhet VALUES (289, '866749820', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866749820', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.187685', '2023-09-07 12:10:00.187685');
INSERT INTO public.virksomhet VALUES (290, '853653798', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853653798', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.226892', '2023-09-07 12:10:00.226892');
INSERT INTO public.virksomhet VALUES (291, '810148394', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810148394', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.253629', '2023-09-07 12:10:00.253629');
INSERT INTO public.virksomhet VALUES (292, '815156970', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815156970', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.287061', '2023-09-07 12:10:00.287061');
INSERT INTO public.virksomhet VALUES (293, '884757541', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884757541', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.311297', '2023-09-07 12:10:00.311297');
INSERT INTO public.virksomhet VALUES (294, '898222657', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898222657', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.335178', '2023-09-07 12:10:00.335178');
INSERT INTO public.virksomhet VALUES (295, '896030179', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896030179', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.358212', '2023-09-07 12:10:00.358212');
INSERT INTO public.virksomhet VALUES (296, '864599907', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864599907', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.38542', '2023-09-07 12:10:00.38542');
INSERT INTO public.virksomhet VALUES (297, '809618719', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809618719', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.417389', '2023-09-07 12:10:00.417389');
INSERT INTO public.virksomhet VALUES (298, '866797297', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866797297', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.455752', '2023-09-07 12:10:00.455752');
INSERT INTO public.virksomhet VALUES (299, '894566254', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894566254', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.481851', '2023-09-07 12:10:00.481851');
INSERT INTO public.virksomhet VALUES (300, '847700913', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847700913', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.523264', '2023-09-07 12:10:00.523264');
INSERT INTO public.virksomhet VALUES (301, '887886764', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887886764', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.568091', '2023-09-07 12:10:00.568091');
INSERT INTO public.virksomhet VALUES (302, '846277149', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846277149', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.627541', '2023-09-07 12:10:00.627541');
INSERT INTO public.virksomhet VALUES (303, '832188723', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832188723', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.670218', '2023-09-07 12:10:00.670218');
INSERT INTO public.virksomhet VALUES (304, '891532355', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891532355', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.716252', '2023-09-07 12:10:00.716252');
INSERT INTO public.virksomhet VALUES (305, '812694935', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812694935', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.748619', '2023-09-07 12:10:00.748619');
INSERT INTO public.virksomhet VALUES (306, '827754082', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827754082', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.917014', '2023-09-07 12:10:00.917014');
INSERT INTO public.virksomhet VALUES (307, '810338095', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810338095', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:00.973696', '2023-09-07 12:10:00.973696');
INSERT INTO public.virksomhet VALUES (308, '895262637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895262637', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.022293', '2023-09-07 12:10:01.022293');
INSERT INTO public.virksomhet VALUES (309, '876398349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876398349', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.084869', '2023-09-07 12:10:01.084869');
INSERT INTO public.virksomhet VALUES (310, '806767601', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806767601', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.14685', '2023-09-07 12:10:01.14685');
INSERT INTO public.virksomhet VALUES (311, '802475579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802475579', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.236366', '2023-09-07 12:10:01.236366');
INSERT INTO public.virksomhet VALUES (312, '883219495', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883219495', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.290942', '2023-09-07 12:10:01.290942');
INSERT INTO public.virksomhet VALUES (313, '879154973', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879154973', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.337382', '2023-09-07 12:10:01.337382');
INSERT INTO public.virksomhet VALUES (314, '827809774', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827809774', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.395747', '2023-09-07 12:10:01.395747');
INSERT INTO public.virksomhet VALUES (315, '861106891', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861106891', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.449195', '2023-09-07 12:10:01.449195');
INSERT INTO public.virksomhet VALUES (316, '820860873', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820860873', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.507037', '2023-09-07 12:10:01.507037');
INSERT INTO public.virksomhet VALUES (317, '833723531', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833723531', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.563425', '2023-09-07 12:10:01.563425');
INSERT INTO public.virksomhet VALUES (318, '891420050', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891420050', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.634477', '2023-09-07 12:10:01.634477');
INSERT INTO public.virksomhet VALUES (319, '881294356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881294356', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.695441', '2023-09-07 12:10:01.695441');
INSERT INTO public.virksomhet VALUES (320, '878113186', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878113186', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.806143', '2023-09-07 12:10:01.806143');
INSERT INTO public.virksomhet VALUES (321, '879974330', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879974330', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.856836', '2023-09-07 12:10:01.856836');
INSERT INTO public.virksomhet VALUES (322, '802186110', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802186110', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.906983', '2023-09-07 12:10:01.906983');
INSERT INTO public.virksomhet VALUES (323, '839798432', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839798432', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:01.957683', '2023-09-07 12:10:01.957683');
INSERT INTO public.virksomhet VALUES (324, '839394527', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839394527', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.010988', '2023-09-07 12:10:02.010988');
INSERT INTO public.virksomhet VALUES (325, '822630771', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822630771', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.045071', '2023-09-07 12:10:02.045071');
INSERT INTO public.virksomhet VALUES (326, '820632732', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820632732', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.09548', '2023-09-07 12:10:02.09548');
INSERT INTO public.virksomhet VALUES (327, '895663536', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895663536', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.155189', '2023-09-07 12:10:02.155189');
INSERT INTO public.virksomhet VALUES (328, '810464549', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810464549', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.19496', '2023-09-07 12:10:02.19496');
INSERT INTO public.virksomhet VALUES (329, '810038015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810038015', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.239339', '2023-09-07 12:10:02.239339');
INSERT INTO public.virksomhet VALUES (330, '831640932', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831640932', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.2828', '2023-09-07 12:10:02.2828');
INSERT INTO public.virksomhet VALUES (331, '826636164', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826636164', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.309509', '2023-09-07 12:10:02.309509');
INSERT INTO public.virksomhet VALUES (332, '871242919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871242919', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.354862', '2023-09-07 12:10:02.354862');
INSERT INTO public.virksomhet VALUES (333, '827203144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827203144', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.402752', '2023-09-07 12:10:02.402752');
INSERT INTO public.virksomhet VALUES (334, '818201399', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818201399', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.440146', '2023-09-07 12:10:02.440146');
INSERT INTO public.virksomhet VALUES (335, '842767011', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842767011', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.50259', '2023-09-07 12:10:02.50259');
INSERT INTO public.virksomhet VALUES (336, '871226849', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871226849', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.546901', '2023-09-07 12:10:02.546901');
INSERT INTO public.virksomhet VALUES (337, '828877547', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828877547', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.6086', '2023-09-07 12:10:02.6086');
INSERT INTO public.virksomhet VALUES (338, '803598115', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803598115', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.682385', '2023-09-07 12:10:02.682385');
INSERT INTO public.virksomhet VALUES (339, '841405627', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841405627', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.72472', '2023-09-07 12:10:02.72472');
INSERT INTO public.virksomhet VALUES (340, '881613172', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881613172', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.799379', '2023-09-07 12:10:02.799379');
INSERT INTO public.virksomhet VALUES (341, '856589401', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856589401', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.857352', '2023-09-07 12:10:02.857352');
INSERT INTO public.virksomhet VALUES (342, '863700769', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863700769', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.903467', '2023-09-07 12:10:02.903467');
INSERT INTO public.virksomhet VALUES (343, '881862150', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881862150', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.945707', '2023-09-07 12:10:02.945707');
INSERT INTO public.virksomhet VALUES (344, '817192943', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817192943', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:02.996145', '2023-09-07 12:10:02.996145');
INSERT INTO public.virksomhet VALUES (345, '865004722', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865004722', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.043623', '2023-09-07 12:10:03.043623');
INSERT INTO public.virksomhet VALUES (346, '867448417', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867448417', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.095779', '2023-09-07 12:10:03.095779');
INSERT INTO public.virksomhet VALUES (347, '849474678', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849474678', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.128742', '2023-09-07 12:10:03.128742');
INSERT INTO public.virksomhet VALUES (348, '847693270', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847693270', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.192544', '2023-09-07 12:10:03.192544');
INSERT INTO public.virksomhet VALUES (349, '841607636', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841607636', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.223012', '2023-09-07 12:10:03.223012');
INSERT INTO public.virksomhet VALUES (350, '807202254', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807202254', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.265173', '2023-09-07 12:10:03.265173');
INSERT INTO public.virksomhet VALUES (351, '865346587', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865346587', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.367488', '2023-09-07 12:10:03.367488');
INSERT INTO public.virksomhet VALUES (352, '803797113', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803797113', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.498026', '2023-09-07 12:10:03.498026');
INSERT INTO public.virksomhet VALUES (353, '859015070', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859015070', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.704014', '2023-09-07 12:10:03.704014');
INSERT INTO public.virksomhet VALUES (354, '831988569', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831988569', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.811175', '2023-09-07 12:10:03.811175');
INSERT INTO public.virksomhet VALUES (355, '817536912', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817536912', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.894814', '2023-09-07 12:10:03.894814');
INSERT INTO public.virksomhet VALUES (356, '815652536', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815652536', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:03.960862', '2023-09-07 12:10:03.960862');
INSERT INTO public.virksomhet VALUES (357, '820854735', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820854735', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:04.062823', '2023-09-07 12:10:04.062823');
INSERT INTO public.virksomhet VALUES (358, '845223389', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845223389', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:04.214702', '2023-09-07 12:10:04.214702');
INSERT INTO public.virksomhet VALUES (359, '822319019', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822319019', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:04.259784', '2023-09-07 12:10:04.259784');
INSERT INTO public.virksomhet VALUES (360, '890009028', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890009028', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:04.34259', '2023-09-07 12:10:04.34259');
INSERT INTO public.virksomhet VALUES (361, '800496904', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800496904', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:04.454881', '2023-09-07 12:10:04.454881');
INSERT INTO public.virksomhet VALUES (362, '817109970', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817109970', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:04.557835', '2023-09-07 12:10:04.557835');
INSERT INTO public.virksomhet VALUES (363, '895079930', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895079930', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:04.653246', '2023-09-07 12:10:04.653246');
INSERT INTO public.virksomhet VALUES (364, '875821555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875821555', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:04.961708', '2023-09-07 12:10:04.961708');
INSERT INTO public.virksomhet VALUES (365, '850014769', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850014769', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:05.222611', '2023-09-07 12:10:05.222611');
INSERT INTO public.virksomhet VALUES (366, '885587354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885587354', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:05.5369', '2023-09-07 12:10:05.5369');
INSERT INTO public.virksomhet VALUES (367, '857586849', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857586849', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:05.626457', '2023-09-07 12:10:05.626457');
INSERT INTO public.virksomhet VALUES (368, '839952701', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839952701', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:05.943594', '2023-09-07 12:10:05.943594');
INSERT INTO public.virksomhet VALUES (369, '803031804', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803031804', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:06.138125', '2023-09-07 12:10:06.138125');
INSERT INTO public.virksomhet VALUES (370, '875659837', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875659837', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:06.231706', '2023-09-07 12:10:06.231706');
INSERT INTO public.virksomhet VALUES (371, '832650403', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832650403', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:06.300959', '2023-09-07 12:10:06.300959');
INSERT INTO public.virksomhet VALUES (372, '883770442', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883770442', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:06.353476', '2023-09-07 12:10:06.353476');
INSERT INTO public.virksomhet VALUES (373, '845481784', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845481784', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:06.46333', '2023-09-07 12:10:06.46333');
INSERT INTO public.virksomhet VALUES (374, '854542822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854542822', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:06.594764', '2023-09-07 12:10:06.594764');
INSERT INTO public.virksomhet VALUES (375, '835249198', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835249198', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:06.706304', '2023-09-07 12:10:06.706304');
INSERT INTO public.virksomhet VALUES (376, '813953566', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813953566', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:06.774975', '2023-09-07 12:10:06.774975');
INSERT INTO public.virksomhet VALUES (377, '850540874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850540874', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:06.842577', '2023-09-07 12:10:06.842577');
INSERT INTO public.virksomhet VALUES (378, '858828188', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858828188', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:06.908696', '2023-09-07 12:10:06.908696');
INSERT INTO public.virksomhet VALUES (379, '864210989', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864210989', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.018768', '2023-09-07 12:10:07.018768');
INSERT INTO public.virksomhet VALUES (380, '839996129', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839996129', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.097054', '2023-09-07 12:10:07.097054');
INSERT INTO public.virksomhet VALUES (381, '864263901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864263901', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.342944', '2023-09-07 12:10:07.342944');
INSERT INTO public.virksomhet VALUES (382, '803135962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803135962', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.412719', '2023-09-07 12:10:07.412719');
INSERT INTO public.virksomhet VALUES (383, '870314786', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870314786', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.467114', '2023-09-07 12:10:07.467114');
INSERT INTO public.virksomhet VALUES (384, '863760146', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863760146', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.508301', '2023-09-07 12:10:07.508301');
INSERT INTO public.virksomhet VALUES (385, '861668570', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861668570', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.545329', '2023-09-07 12:10:07.545329');
INSERT INTO public.virksomhet VALUES (386, '830704856', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830704856', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.585505', '2023-09-07 12:10:07.585505');
INSERT INTO public.virksomhet VALUES (387, '889855312', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889855312', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.611247', '2023-09-07 12:10:07.611247');
INSERT INTO public.virksomhet VALUES (388, '863259727', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863259727', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.645435', '2023-09-07 12:10:07.645435');
INSERT INTO public.virksomhet VALUES (389, '840135251', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840135251', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.677446', '2023-09-07 12:10:07.677446');
INSERT INTO public.virksomhet VALUES (390, '864494818', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864494818', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.722475', '2023-09-07 12:10:07.722475');
INSERT INTO public.virksomhet VALUES (391, '825695325', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825695325', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.749154', '2023-09-07 12:10:07.749154');
INSERT INTO public.virksomhet VALUES (392, '836073862', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836073862', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.808072', '2023-09-07 12:10:07.808072');
INSERT INTO public.virksomhet VALUES (393, '840058730', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840058730', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.840486', '2023-09-07 12:10:07.840486');
INSERT INTO public.virksomhet VALUES (394, '846660938', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846660938', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.874279', '2023-09-07 12:10:07.874279');
INSERT INTO public.virksomhet VALUES (395, '898659607', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898659607', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.907631', '2023-09-07 12:10:07.907631');
INSERT INTO public.virksomhet VALUES (396, '854921842', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854921842', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.935885', '2023-09-07 12:10:07.935885');
INSERT INTO public.virksomhet VALUES (397, '873055761', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873055761', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.961148', '2023-09-07 12:10:07.961148');
INSERT INTO public.virksomhet VALUES (398, '805992114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805992114', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:07.998187', '2023-09-07 12:10:07.998187');
INSERT INTO public.virksomhet VALUES (399, '851892457', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851892457', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.036518', '2023-09-07 12:10:08.036518');
INSERT INTO public.virksomhet VALUES (400, '814941134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814941134', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.072747', '2023-09-07 12:10:08.072747');
INSERT INTO public.virksomhet VALUES (401, '888656414', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888656414', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.115648', '2023-09-07 12:10:08.115648');
INSERT INTO public.virksomhet VALUES (402, '800959797', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800959797', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.145473', '2023-09-07 12:10:08.145473');
INSERT INTO public.virksomhet VALUES (403, '850493038', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850493038', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.173467', '2023-09-07 12:10:08.173467');
INSERT INTO public.virksomhet VALUES (404, '882620191', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882620191', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.212233', '2023-09-07 12:10:08.212233');
INSERT INTO public.virksomhet VALUES (405, '854180739', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854180739', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.239937', '2023-09-07 12:10:08.239937');
INSERT INTO public.virksomhet VALUES (406, '886068919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886068919', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.265765', '2023-09-07 12:10:08.265765');
INSERT INTO public.virksomhet VALUES (407, '833662587', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833662587', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.299513', '2023-09-07 12:10:08.299513');
INSERT INTO public.virksomhet VALUES (408, '873385075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873385075', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.336463', '2023-09-07 12:10:08.336463');
INSERT INTO public.virksomhet VALUES (409, '843099645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843099645', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.37016', '2023-09-07 12:10:08.37016');
INSERT INTO public.virksomhet VALUES (410, '825885334', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825885334', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.394214', '2023-09-07 12:10:08.394214');
INSERT INTO public.virksomhet VALUES (411, '872228537', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872228537', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.424946', '2023-09-07 12:10:08.424946');
INSERT INTO public.virksomhet VALUES (412, '852201319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852201319', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.467775', '2023-09-07 12:10:08.467775');
INSERT INTO public.virksomhet VALUES (413, '890363371', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890363371', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.493926', '2023-09-07 12:10:08.493926');
INSERT INTO public.virksomhet VALUES (414, '815843495', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815843495', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.5229', '2023-09-07 12:10:08.5229');
INSERT INTO public.virksomhet VALUES (415, '852930359', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852930359', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.542289', '2023-09-07 12:10:08.542289');
INSERT INTO public.virksomhet VALUES (416, '837843994', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837843994', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.564332', '2023-09-07 12:10:08.564332');
INSERT INTO public.virksomhet VALUES (417, '806010146', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806010146', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.59273', '2023-09-07 12:10:08.59273');
INSERT INTO public.virksomhet VALUES (418, '886905862', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886905862', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.620894', '2023-09-07 12:10:08.620894');
INSERT INTO public.virksomhet VALUES (419, '835407686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835407686', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.662925', '2023-09-07 12:10:08.662925');
INSERT INTO public.virksomhet VALUES (420, '840931417', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840931417', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.693683', '2023-09-07 12:10:08.693683');
INSERT INTO public.virksomhet VALUES (421, '867005478', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867005478', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.737876', '2023-09-07 12:10:08.737876');
INSERT INTO public.virksomhet VALUES (422, '878801449', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878801449', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.783808', '2023-09-07 12:10:08.783808');
INSERT INTO public.virksomhet VALUES (423, '892032684', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892032684', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.807709', '2023-09-07 12:10:08.807709');
INSERT INTO public.virksomhet VALUES (424, '860955788', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860955788', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.837806', '2023-09-07 12:10:08.837806');
INSERT INTO public.virksomhet VALUES (425, '843920371', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843920371', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.863172', '2023-09-07 12:10:08.863172');
INSERT INTO public.virksomhet VALUES (426, '882995152', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882995152', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.888673', '2023-09-07 12:10:08.888673');
INSERT INTO public.virksomhet VALUES (427, '887827580', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887827580', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.914461', '2023-09-07 12:10:08.914461');
INSERT INTO public.virksomhet VALUES (428, '826333991', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826333991', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.943127', '2023-09-07 12:10:08.943127');
INSERT INTO public.virksomhet VALUES (429, '867611681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867611681', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:08.973751', '2023-09-07 12:10:08.973751');
INSERT INTO public.virksomhet VALUES (430, '815182148', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815182148', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.011961', '2023-09-07 12:10:09.011961');
INSERT INTO public.virksomhet VALUES (431, '873874881', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873874881', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.041258', '2023-09-07 12:10:09.041258');
INSERT INTO public.virksomhet VALUES (432, '882455206', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882455206', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.061932', '2023-09-07 12:10:09.061932');
INSERT INTO public.virksomhet VALUES (433, '845232041', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845232041', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.085829', '2023-09-07 12:10:09.085829');
INSERT INTO public.virksomhet VALUES (434, '882850737', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882850737', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.109378', '2023-09-07 12:10:09.109378');
INSERT INTO public.virksomhet VALUES (435, '865259870', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865259870', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.136029', '2023-09-07 12:10:09.136029');
INSERT INTO public.virksomhet VALUES (436, '828007957', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828007957', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.160237', '2023-09-07 12:10:09.160237');
INSERT INTO public.virksomhet VALUES (437, '808270377', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808270377', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.186815', '2023-09-07 12:10:09.186815');
INSERT INTO public.virksomhet VALUES (438, '851384052', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851384052', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.217076', '2023-09-07 12:10:09.217076');
INSERT INTO public.virksomhet VALUES (439, '898600714', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898600714', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.274761', '2023-09-07 12:10:09.274761');
INSERT INTO public.virksomhet VALUES (440, '839935652', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839935652', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.358941', '2023-09-07 12:10:09.358941');
INSERT INTO public.virksomhet VALUES (441, '810141839', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810141839', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.40258', '2023-09-07 12:10:09.40258');
INSERT INTO public.virksomhet VALUES (442, '891333152', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891333152', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.424838', '2023-09-07 12:10:09.424838');
INSERT INTO public.virksomhet VALUES (443, '805164879', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805164879', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.463089', '2023-09-07 12:10:09.463089');
INSERT INTO public.virksomhet VALUES (444, '824498308', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824498308', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.49193', '2023-09-07 12:10:09.49193');
INSERT INTO public.virksomhet VALUES (445, '844282783', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844282783', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.536287', '2023-09-07 12:10:09.536287');
INSERT INTO public.virksomhet VALUES (446, '817531159', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817531159', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.575416', '2023-09-07 12:10:09.575416');
INSERT INTO public.virksomhet VALUES (447, '855550271', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855550271', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.632076', '2023-09-07 12:10:09.632076');
INSERT INTO public.virksomhet VALUES (448, '869652681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869652681', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.673616', '2023-09-07 12:10:09.673616');
INSERT INTO public.virksomhet VALUES (449, '898751589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898751589', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.7108', '2023-09-07 12:10:09.7108');
INSERT INTO public.virksomhet VALUES (450, '878967112', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878967112', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.73795', '2023-09-07 12:10:09.73795');
INSERT INTO public.virksomhet VALUES (451, '864003987', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864003987', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.760774', '2023-09-07 12:10:09.760774');
INSERT INTO public.virksomhet VALUES (452, '832458613', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832458613', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.79245', '2023-09-07 12:10:09.79245');
INSERT INTO public.virksomhet VALUES (453, '806008111', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806008111', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.854355', '2023-09-07 12:10:09.854355');
INSERT INTO public.virksomhet VALUES (454, '850214782', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850214782', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.895647', '2023-09-07 12:10:09.895647');
INSERT INTO public.virksomhet VALUES (455, '803104220', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803104220', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.936755', '2023-09-07 12:10:09.936755');
INSERT INTO public.virksomhet VALUES (456, '850426549', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850426549', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:09.978314', '2023-09-07 12:10:09.978314');
INSERT INTO public.virksomhet VALUES (457, '848391514', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848391514', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.013316', '2023-09-07 12:10:10.013316');
INSERT INTO public.virksomhet VALUES (458, '885388008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885388008', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.044845', '2023-09-07 12:10:10.044845');
INSERT INTO public.virksomhet VALUES (459, '822821338', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822821338', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.070916', '2023-09-07 12:10:10.070916');
INSERT INTO public.virksomhet VALUES (460, '822030521', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822030521', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.094261', '2023-09-07 12:10:10.094261');
INSERT INTO public.virksomhet VALUES (461, '875874693', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875874693', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.123985', '2023-09-07 12:10:10.123985');
INSERT INTO public.virksomhet VALUES (462, '812765101', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812765101', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.180026', '2023-09-07 12:10:10.180026');
INSERT INTO public.virksomhet VALUES (463, '838926551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838926551', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.222201', '2023-09-07 12:10:10.222201');
INSERT INTO public.virksomhet VALUES (464, '899799563', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899799563', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.247375', '2023-09-07 12:10:10.247375');
INSERT INTO public.virksomhet VALUES (465, '809015209', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809015209', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.280222', '2023-09-07 12:10:10.280222');
INSERT INTO public.virksomhet VALUES (466, '820034238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820034238', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.315092', '2023-09-07 12:10:10.315092');
INSERT INTO public.virksomhet VALUES (467, '895498055', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895498055', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.351442', '2023-09-07 12:10:10.351442');
INSERT INTO public.virksomhet VALUES (468, '828601859', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828601859', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.386735', '2023-09-07 12:10:10.386735');
INSERT INTO public.virksomhet VALUES (469, '801604353', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801604353', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.441712', '2023-09-07 12:10:10.441712');
INSERT INTO public.virksomhet VALUES (470, '800776323', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800776323', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.488564', '2023-09-07 12:10:10.488564');
INSERT INTO public.virksomhet VALUES (471, '844347164', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844347164', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.533219', '2023-09-07 12:10:10.533219');
INSERT INTO public.virksomhet VALUES (472, '818219358', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818219358', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.582155', '2023-09-07 12:10:10.582155');
INSERT INTO public.virksomhet VALUES (473, '823902704', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823902704', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.614766', '2023-09-07 12:10:10.614766');
INSERT INTO public.virksomhet VALUES (474, '883162812', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883162812', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.643354', '2023-09-07 12:10:10.643354');
INSERT INTO public.virksomhet VALUES (475, '889910960', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889910960', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.695387', '2023-09-07 12:10:10.695387');
INSERT INTO public.virksomhet VALUES (476, '865749324', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865749324', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.722766', '2023-09-07 12:10:10.722766');
INSERT INTO public.virksomhet VALUES (477, '850763986', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850763986', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.768923', '2023-09-07 12:10:10.768923');
INSERT INTO public.virksomhet VALUES (478, '880519699', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880519699', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.800003', '2023-09-07 12:10:10.800003');
INSERT INTO public.virksomhet VALUES (479, '852625515', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852625515', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.833981', '2023-09-07 12:10:10.833981');
INSERT INTO public.virksomhet VALUES (480, '861045673', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861045673', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.868158', '2023-09-07 12:10:10.868158');
INSERT INTO public.virksomhet VALUES (481, '833793182', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833793182', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.907524', '2023-09-07 12:10:10.907524');
INSERT INTO public.virksomhet VALUES (482, '831330573', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831330573', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.936576', '2023-09-07 12:10:10.936576');
INSERT INTO public.virksomhet VALUES (483, '861523860', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861523860', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:10.965039', '2023-09-07 12:10:10.965039');
INSERT INTO public.virksomhet VALUES (484, '824098672', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824098672', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.001832', '2023-09-07 12:10:11.001832');
INSERT INTO public.virksomhet VALUES (485, '823778083', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823778083', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.027489', '2023-09-07 12:10:11.027489');
INSERT INTO public.virksomhet VALUES (486, '809293796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809293796', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.0741', '2023-09-07 12:10:11.0741');
INSERT INTO public.virksomhet VALUES (487, '833398283', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833398283', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.117867', '2023-09-07 12:10:11.117867');
INSERT INTO public.virksomhet VALUES (488, '850432266', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850432266', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.145422', '2023-09-07 12:10:11.145422');
INSERT INTO public.virksomhet VALUES (489, '881380147', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881380147', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.178994', '2023-09-07 12:10:11.178994');
INSERT INTO public.virksomhet VALUES (490, '863782541', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863782541', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.214106', '2023-09-07 12:10:11.214106');
INSERT INTO public.virksomhet VALUES (491, '853151041', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853151041', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.256091', '2023-09-07 12:10:11.256091');
INSERT INTO public.virksomhet VALUES (492, '802050060', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802050060', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.284446', '2023-09-07 12:10:11.284446');
INSERT INTO public.virksomhet VALUES (493, '853061189', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853061189', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.318047', '2023-09-07 12:10:11.318047');
INSERT INTO public.virksomhet VALUES (494, '839895479', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839895479', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.353338', '2023-09-07 12:10:11.353338');
INSERT INTO public.virksomhet VALUES (495, '850029414', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850029414', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.402026', '2023-09-07 12:10:11.402026');
INSERT INTO public.virksomhet VALUES (496, '850745866', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850745866', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.444354', '2023-09-07 12:10:11.444354');
INSERT INTO public.virksomhet VALUES (497, '862302999', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862302999', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.488089', '2023-09-07 12:10:11.488089');
INSERT INTO public.virksomhet VALUES (498, '838387901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838387901', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.535263', '2023-09-07 12:10:11.535263');
INSERT INTO public.virksomhet VALUES (499, '893095117', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893095117', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.567022', '2023-09-07 12:10:11.567022');
INSERT INTO public.virksomhet VALUES (500, '891087784', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891087784', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.610587', '2023-09-07 12:10:11.610587');
INSERT INTO public.virksomhet VALUES (501, '814614016', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814614016', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.638951', '2023-09-07 12:10:11.638951');
INSERT INTO public.virksomhet VALUES (502, '808055576', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808055576', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.694664', '2023-09-07 12:10:11.694664');
INSERT INTO public.virksomhet VALUES (503, '807375408', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807375408', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.729702', '2023-09-07 12:10:11.729702');
INSERT INTO public.virksomhet VALUES (504, '812020182', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812020182', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.758263', '2023-09-07 12:10:11.758263');
INSERT INTO public.virksomhet VALUES (505, '813691924', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813691924', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.787479', '2023-09-07 12:10:11.787479');
INSERT INTO public.virksomhet VALUES (506, '889537777', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889537777', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.827713', '2023-09-07 12:10:11.827713');
INSERT INTO public.virksomhet VALUES (507, '889923016', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889923016', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.874606', '2023-09-07 12:10:11.874606');
INSERT INTO public.virksomhet VALUES (508, '883410497', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883410497', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.916229', '2023-09-07 12:10:11.916229');
INSERT INTO public.virksomhet VALUES (509, '859214047', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859214047', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:11.952253', '2023-09-07 12:10:11.952253');
INSERT INTO public.virksomhet VALUES (510, '899398352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899398352', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:12.005411', '2023-09-07 12:10:12.005411');
INSERT INTO public.virksomhet VALUES (511, '888885608', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888885608', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-07 12:10:20.884061', '2023-09-07 12:10:20.884061');
INSERT INTO public.virksomhet VALUES (512, '886738603', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '306837688 nvaN', '{adresse}', 'AKTIV', NULL, 886738604, '2023-09-07 12:10:20.925548', '2023-09-07 12:10:29.866452');
INSERT INTO public.virksomhet VALUES (513, '824252875', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '578252428 nvaN', '{adresse}', 'AKTIV', NULL, 824252876, '2023-09-07 12:10:20.955104', '2023-09-07 12:10:29.871495');
INSERT INTO public.virksomhet VALUES (514, '815130751', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '157031518 nvaN', '{adresse}', 'AKTIV', NULL, 815130752, '2023-09-07 12:10:20.979743', '2023-09-07 12:10:29.873983');
INSERT INTO public.virksomhet VALUES (515, '807181403', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '304181708 nvaN', '{adresse}', 'AKTIV', NULL, 807181404, '2023-09-07 12:10:21.000749', '2023-09-07 12:10:29.879025');
INSERT INTO public.virksomhet VALUES (516, '825701028', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '820107528 nvaN', '{adresse}', 'AKTIV', NULL, 825701029, '2023-09-07 12:10:21.034229', '2023-09-07 12:10:29.882624');
INSERT INTO public.virksomhet VALUES (527, '864760613', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '316067468 nvaN', '{adresse}', 'AKTIV', NULL, 864760614, '2023-09-07 12:10:21.359199', '2023-09-07 12:10:29.885536');
INSERT INTO public.virksomhet VALUES (517, '880991109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880991109', '{adresse}', 'FJERNET', '2023-01-01', 880991110, '2023-09-07 12:10:21.063674', '2023-09-07 12:10:29.887865');
INSERT INTO public.virksomhet VALUES (518, '863223995', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863223995', '{adresse}', 'FJERNET', '2023-01-01', 863223996, '2023-09-07 12:10:21.101181', '2023-09-07 12:10:29.894396');
INSERT INTO public.virksomhet VALUES (519, '855193175', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855193175', '{adresse}', 'FJERNET', '2023-01-01', 855193176, '2023-09-07 12:10:21.140598', '2023-09-07 12:10:29.895509');
INSERT INTO public.virksomhet VALUES (520, '851914695', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851914695', '{adresse}', 'FJERNET', '2023-01-01', 851914696, '2023-09-07 12:10:21.164207', '2023-09-07 12:10:29.896804');
INSERT INTO public.virksomhet VALUES (521, '860138637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860138637', '{adresse}', 'FJERNET', '2023-01-01', 860138638, '2023-09-07 12:10:21.203052', '2023-09-07 12:10:29.898132');
INSERT INTO public.virksomhet VALUES (522, '842209425', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842209425', '{adresse}', 'SLETTET', '2023-01-01', 842209426, '2023-09-07 12:10:21.235088', '2023-09-07 12:10:29.899671');
INSERT INTO public.virksomhet VALUES (523, '886312075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886312075', '{adresse}', 'SLETTET', '2023-01-01', 886312076, '2023-09-07 12:10:21.254273', '2023-09-07 12:10:29.902114');
INSERT INTO public.virksomhet VALUES (524, '806191555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806191555', '{adresse}', 'SLETTET', '2023-01-01', 806191556, '2023-09-07 12:10:21.277759', '2023-09-07 12:10:29.905292');
INSERT INTO public.virksomhet VALUES (525, '812570442', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812570442', '{adresse}', 'SLETTET', '2023-01-01', 812570443, '2023-09-07 12:10:21.314899', '2023-09-07 12:10:29.908171');
INSERT INTO public.virksomhet VALUES (526, '842756602', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842756602', '{adresse}', 'SLETTET', '2023-01-01', 842756603, '2023-09-07 12:10:21.33741', '2023-09-07 12:10:29.909849');
INSERT INTO public.virksomhet VALUES (534, '831444300', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831444300', '{adresse}', 'AKTIV', NULL, 831444301, '2023-09-07 12:10:29.935558', '2023-09-07 12:10:29.935558');
INSERT INTO public.virksomhet VALUES (535, '881590173', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881590173', '{adresse}', 'AKTIV', NULL, 881590174, '2023-09-07 12:10:29.938698', '2023-09-07 12:10:29.938698');
INSERT INTO public.virksomhet VALUES (536, '867739180', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867739180', '{adresse}', 'AKTIV', NULL, 867739181, '2023-09-07 12:10:29.941664', '2023-09-07 12:10:29.941664');
INSERT INTO public.virksomhet VALUES (537, '859323850', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859323850', '{adresse}', 'AKTIV', NULL, 859323851, '2023-09-07 12:10:29.944441', '2023-09-07 12:10:29.944441');
INSERT INTO public.virksomhet VALUES (538, '813740662', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813740662', '{adresse}', 'AKTIV', NULL, 813740663, '2023-09-07 12:10:29.949191', '2023-09-07 12:10:29.949191');


--
-- Data for Name: virksomhet_naringsundergrupper; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_naringsundergrupper VALUES (1, 1, '90.012', NULL, NULL, '2023-09-07 12:09:46.363207', '2023-09-07 12:09:46.363207');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (2, 2, '70.220', '90.012', NULL, '2023-09-07 12:09:46.498647', '2023-09-07 12:09:46.498647');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (3, 3, '90.012', '70.220', NULL, '2023-09-07 12:09:46.56585', '2023-09-07 12:09:46.56585');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (4, 4, '90.012', NULL, NULL, '2023-09-07 12:09:46.633223', '2023-09-07 12:09:46.633223');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (5, 5, '01.120', NULL, NULL, '2023-09-07 12:09:46.915127', '2023-09-07 12:09:46.915127');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (6, 6, '01.120', NULL, NULL, '2023-09-07 12:09:46.966289', '2023-09-07 12:09:46.966289');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (7, 7, '01.120', NULL, NULL, '2023-09-07 12:09:47.015175', '2023-09-07 12:09:47.015175');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (8, 8, '01.120', '90.012', NULL, '2023-09-07 12:09:47.073616', '2023-09-07 12:09:47.073616');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (9, 9, '01.120', NULL, NULL, '2023-09-07 12:09:47.130325', '2023-09-07 12:09:47.130325');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (10, 10, '01.120', '90.012', NULL, '2023-09-07 12:09:47.187519', '2023-09-07 12:09:47.187519');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (11, 11, '01.120', NULL, NULL, '2023-09-07 12:09:47.253357', '2023-09-07 12:09:47.253357');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (12, 12, '01.120', NULL, NULL, '2023-09-07 12:09:47.311112', '2023-09-07 12:09:47.311112');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (13, 13, '01.120', NULL, NULL, '2023-09-07 12:09:47.373858', '2023-09-07 12:09:47.373858');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (14, 14, '01.120', '90.012', NULL, '2023-09-07 12:09:47.440449', '2023-09-07 12:09:47.440449');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (15, 15, '01.120', NULL, NULL, '2023-09-07 12:09:47.490035', '2023-09-07 12:09:47.490035');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (16, 16, '01.120', '90.012', NULL, '2023-09-07 12:09:47.551652', '2023-09-07 12:09:47.551652');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (17, 17, '01.120', NULL, NULL, '2023-09-07 12:09:47.601369', '2023-09-07 12:09:47.601369');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (18, 18, '01.120', NULL, NULL, '2023-09-07 12:09:47.662959', '2023-09-07 12:09:47.662959');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (19, 19, '01.120', '90.012', NULL, '2023-09-07 12:09:47.71827', '2023-09-07 12:09:47.71827');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (20, 20, '01.120', NULL, NULL, '2023-09-07 12:09:47.76774', '2023-09-07 12:09:47.76774');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (21, 21, '01.120', '90.012', '70.220', '2023-09-07 12:09:47.832027', '2023-09-07 12:09:47.832027');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (22, 22, '01.120', NULL, NULL, '2023-09-07 12:09:47.874224', '2023-09-07 12:09:47.874224');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (23, 23, '01.120', '90.012', '70.220', '2023-09-07 12:09:47.93918', '2023-09-07 12:09:47.93918');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (24, 24, '01.120', '90.012', '70.220', '2023-09-07 12:09:47.991369', '2023-09-07 12:09:47.991369');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (25, 25, '01.120', '90.012', NULL, '2023-09-07 12:09:48.046465', '2023-09-07 12:09:48.046465');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (26, 26, '01.120', '90.012', '70.220', '2023-09-07 12:09:48.101048', '2023-09-07 12:09:48.101048');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (27, 27, '01.120', NULL, NULL, '2023-09-07 12:09:48.149691', '2023-09-07 12:09:48.149691');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (28, 28, '01.120', '90.012', NULL, '2023-09-07 12:09:48.203193', '2023-09-07 12:09:48.203193');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (29, 29, '01.120', NULL, NULL, '2023-09-07 12:09:48.257917', '2023-09-07 12:09:48.257917');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (30, 30, '01.120', '90.012', NULL, '2023-09-07 12:09:48.31992', '2023-09-07 12:09:48.31992');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (31, 31, '01.120', '90.012', '70.220', '2023-09-07 12:09:48.375662', '2023-09-07 12:09:48.375662');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (32, 32, '01.120', '90.012', NULL, '2023-09-07 12:09:48.44903', '2023-09-07 12:09:48.44903');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (33, 33, '01.120', '90.012', NULL, '2023-09-07 12:09:48.508474', '2023-09-07 12:09:48.508474');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (34, 34, '01.120', '90.012', NULL, '2023-09-07 12:09:48.576508', '2023-09-07 12:09:48.576508');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (35, 35, '01.120', '90.012', '70.220', '2023-09-07 12:09:48.623603', '2023-09-07 12:09:48.623603');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (36, 36, '01.120', NULL, NULL, '2023-09-07 12:09:48.673619', '2023-09-07 12:09:48.673619');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (37, 37, '01.120', NULL, NULL, '2023-09-07 12:09:48.714503', '2023-09-07 12:09:48.714503');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (38, 38, '01.120', NULL, NULL, '2023-09-07 12:09:48.75867', '2023-09-07 12:09:48.75867');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (39, 39, '01.120', NULL, NULL, '2023-09-07 12:09:48.801967', '2023-09-07 12:09:48.801967');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (40, 40, '01.120', '90.012', NULL, '2023-09-07 12:09:48.840779', '2023-09-07 12:09:48.840779');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (41, 41, '01.120', NULL, NULL, '2023-09-07 12:09:48.900676', '2023-09-07 12:09:48.900676');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (42, 42, '01.120', '90.012', '70.220', '2023-09-07 12:09:48.966148', '2023-09-07 12:09:48.966148');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (43, 43, '01.120', '90.012', NULL, '2023-09-07 12:09:49.012874', '2023-09-07 12:09:49.012874');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (44, 44, '01.120', NULL, NULL, '2023-09-07 12:09:49.058021', '2023-09-07 12:09:49.058021');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (45, 45, '01.120', NULL, NULL, '2023-09-07 12:09:49.102161', '2023-09-07 12:09:49.102161');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (46, 46, '01.120', '90.012', '70.220', '2023-09-07 12:09:49.156479', '2023-09-07 12:09:49.156479');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (47, 47, '01.120', '90.012', NULL, '2023-09-07 12:09:49.196084', '2023-09-07 12:09:49.196084');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (48, 48, '01.120', NULL, NULL, '2023-09-07 12:09:49.231471', '2023-09-07 12:09:49.231471');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (49, 49, '01.120', '90.012', NULL, '2023-09-07 12:09:49.283536', '2023-09-07 12:09:49.283536');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (50, 50, '01.120', NULL, NULL, '2023-09-07 12:09:49.324782', '2023-09-07 12:09:49.324782');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (51, 51, '01.120', '90.012', NULL, '2023-09-07 12:09:49.365483', '2023-09-07 12:09:49.365483');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (52, 52, '01.120', '90.012', '70.220', '2023-09-07 12:09:49.412832', '2023-09-07 12:09:49.412832');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (53, 53, '01.120', NULL, NULL, '2023-09-07 12:09:49.475441', '2023-09-07 12:09:49.475441');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (54, 54, '01.120', '90.012', NULL, '2023-09-07 12:09:49.518239', '2023-09-07 12:09:49.518239');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (55, 55, '01.120', '90.012', NULL, '2023-09-07 12:09:49.544724', '2023-09-07 12:09:49.544724');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (56, 56, '01.120', '90.012', NULL, '2023-09-07 12:09:49.57584', '2023-09-07 12:09:49.57584');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (57, 57, '01.120', NULL, NULL, '2023-09-07 12:09:49.62666', '2023-09-07 12:09:49.62666');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (58, 58, '01.120', NULL, NULL, '2023-09-07 12:09:49.657426', '2023-09-07 12:09:49.657426');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (59, 59, '01.120', '90.012', NULL, '2023-09-07 12:09:49.701134', '2023-09-07 12:09:49.701134');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (60, 60, '01.120', NULL, NULL, '2023-09-07 12:09:49.750202', '2023-09-07 12:09:49.750202');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (61, 61, '01.120', '90.012', NULL, '2023-09-07 12:09:49.806353', '2023-09-07 12:09:49.806353');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (62, 62, '01.120', '90.012', NULL, '2023-09-07 12:09:49.847785', '2023-09-07 12:09:49.847785');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (63, 63, '01.120', NULL, NULL, '2023-09-07 12:09:49.894413', '2023-09-07 12:09:49.894413');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (64, 64, '01.120', NULL, NULL, '2023-09-07 12:09:49.940825', '2023-09-07 12:09:49.940825');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (65, 65, '01.120', NULL, NULL, '2023-09-07 12:09:49.991583', '2023-09-07 12:09:49.991583');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (66, 66, '01.120', NULL, NULL, '2023-09-07 12:09:50.053007', '2023-09-07 12:09:50.053007');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (67, 67, '01.120', '90.012', NULL, '2023-09-07 12:09:50.113338', '2023-09-07 12:09:50.113338');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (68, 68, '01.120', NULL, NULL, '2023-09-07 12:09:50.165815', '2023-09-07 12:09:50.165815');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (69, 69, '01.120', NULL, NULL, '2023-09-07 12:09:50.200743', '2023-09-07 12:09:50.200743');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (70, 70, '01.120', '90.012', NULL, '2023-09-07 12:09:50.235268', '2023-09-07 12:09:50.235268');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (71, 71, '01.120', NULL, NULL, '2023-09-07 12:09:50.285533', '2023-09-07 12:09:50.285533');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (72, 72, '01.120', '90.012', NULL, '2023-09-07 12:09:50.356488', '2023-09-07 12:09:50.356488');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (73, 73, '01.120', '90.012', '70.220', '2023-09-07 12:09:50.406215', '2023-09-07 12:09:50.406215');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (74, 74, '01.120', '90.012', NULL, '2023-09-07 12:09:50.46056', '2023-09-07 12:09:50.46056');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (75, 75, '01.120', '90.012', '70.220', '2023-09-07 12:09:50.500389', '2023-09-07 12:09:50.500389');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (76, 76, '01.120', '90.012', '70.220', '2023-09-07 12:09:50.540872', '2023-09-07 12:09:50.540872');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (77, 77, '01.120', '90.012', NULL, '2023-09-07 12:09:50.568336', '2023-09-07 12:09:50.568336');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (78, 78, '01.120', '90.012', NULL, '2023-09-07 12:09:50.619781', '2023-09-07 12:09:50.619781');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (79, 79, '01.120', '90.012', NULL, '2023-09-07 12:09:50.685308', '2023-09-07 12:09:50.685308');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (80, 80, '01.120', '90.012', '70.220', '2023-09-07 12:09:50.727055', '2023-09-07 12:09:50.727055');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (81, 81, '01.120', NULL, NULL, '2023-09-07 12:09:50.772144', '2023-09-07 12:09:50.772144');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (82, 82, '01.120', NULL, NULL, '2023-09-07 12:09:50.820987', '2023-09-07 12:09:50.820987');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (83, 83, '01.120', '90.012', NULL, '2023-09-07 12:09:50.869965', '2023-09-07 12:09:50.869965');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (84, 84, '01.120', '90.012', NULL, '2023-09-07 12:09:50.915917', '2023-09-07 12:09:50.915917');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (85, 85, '01.120', NULL, NULL, '2023-09-07 12:09:50.978156', '2023-09-07 12:09:50.978156');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (86, 86, '01.120', NULL, NULL, '2023-09-07 12:09:51.012301', '2023-09-07 12:09:51.012301');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (87, 87, '01.120', '90.012', '70.220', '2023-09-07 12:09:51.051491', '2023-09-07 12:09:51.051491');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (88, 88, '01.120', '90.012', '70.220', '2023-09-07 12:09:51.083263', '2023-09-07 12:09:51.083263');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (89, 89, '01.120', NULL, NULL, '2023-09-07 12:09:51.136981', '2023-09-07 12:09:51.136981');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (90, 90, '01.120', '90.012', '70.220', '2023-09-07 12:09:51.202789', '2023-09-07 12:09:51.202789');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (91, 91, '01.120', NULL, NULL, '2023-09-07 12:09:51.25416', '2023-09-07 12:09:51.25416');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (92, 92, '01.120', '90.012', NULL, '2023-09-07 12:09:51.302511', '2023-09-07 12:09:51.302511');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (93, 93, '01.120', '90.012', NULL, '2023-09-07 12:09:51.336826', '2023-09-07 12:09:51.336826');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (94, 94, '01.120', NULL, NULL, '2023-09-07 12:09:51.358136', '2023-09-07 12:09:51.358136');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (95, 95, '01.120', NULL, NULL, '2023-09-07 12:09:51.399509', '2023-09-07 12:09:51.399509');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (96, 96, '01.120', NULL, NULL, '2023-09-07 12:09:51.459081', '2023-09-07 12:09:51.459081');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (97, 97, '01.120', NULL, NULL, '2023-09-07 12:09:51.517536', '2023-09-07 12:09:51.517536');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (98, 98, '01.120', '90.012', NULL, '2023-09-07 12:09:51.610609', '2023-09-07 12:09:51.610609');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (99, 99, '01.120', '90.012', '70.220', '2023-09-07 12:09:51.689171', '2023-09-07 12:09:51.689171');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (100, 100, '01.120', '90.012', NULL, '2023-09-07 12:09:51.735875', '2023-09-07 12:09:51.735875');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (101, 101, '01.120', NULL, NULL, '2023-09-07 12:09:51.800879', '2023-09-07 12:09:51.800879');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (102, 102, '01.120', '90.012', '70.220', '2023-09-07 12:09:51.867303', '2023-09-07 12:09:51.867303');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (103, 103, '01.120', NULL, NULL, '2023-09-07 12:09:51.918269', '2023-09-07 12:09:51.918269');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (104, 104, '01.120', '90.012', NULL, '2023-09-07 12:09:51.954521', '2023-09-07 12:09:51.954521');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (105, 105, '01.120', NULL, NULL, '2023-09-07 12:09:51.999796', '2023-09-07 12:09:51.999796');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (106, 106, '01.120', NULL, NULL, '2023-09-07 12:09:52.052261', '2023-09-07 12:09:52.052261');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (107, 107, '01.120', NULL, NULL, '2023-09-07 12:09:52.094884', '2023-09-07 12:09:52.094884');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (108, 108, '01.120', '90.012', NULL, '2023-09-07 12:09:52.123925', '2023-09-07 12:09:52.123925');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (109, 109, '01.120', '90.012', '70.220', '2023-09-07 12:09:52.163837', '2023-09-07 12:09:52.163837');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (110, 110, '01.120', '90.012', '70.220', '2023-09-07 12:09:52.20641', '2023-09-07 12:09:52.20641');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (111, 111, '01.120', '90.012', NULL, '2023-09-07 12:09:52.25036', '2023-09-07 12:09:52.25036');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (112, 112, '01.120', '90.012', NULL, '2023-09-07 12:09:52.298192', '2023-09-07 12:09:52.298192');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (113, 113, '01.120', '90.012', NULL, '2023-09-07 12:09:52.33959', '2023-09-07 12:09:52.33959');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (114, 114, '01.120', '90.012', NULL, '2023-09-07 12:09:52.40625', '2023-09-07 12:09:52.40625');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (115, 115, '01.120', NULL, NULL, '2023-09-07 12:09:52.449106', '2023-09-07 12:09:52.449106');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (116, 116, '01.120', NULL, NULL, '2023-09-07 12:09:52.493053', '2023-09-07 12:09:52.493053');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (117, 117, '01.120', '90.012', NULL, '2023-09-07 12:09:52.548803', '2023-09-07 12:09:52.548803');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (118, 118, '01.120', '90.012', NULL, '2023-09-07 12:09:52.701052', '2023-09-07 12:09:52.701052');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (119, 119, '01.120', NULL, NULL, '2023-09-07 12:09:52.819911', '2023-09-07 12:09:52.819911');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (120, 120, '01.120', '90.012', NULL, '2023-09-07 12:09:52.890931', '2023-09-07 12:09:52.890931');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (121, 121, '01.120', NULL, NULL, '2023-09-07 12:09:52.952724', '2023-09-07 12:09:52.952724');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (122, 122, '01.120', '90.012', '70.220', '2023-09-07 12:09:52.996587', '2023-09-07 12:09:52.996587');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (123, 123, '01.120', NULL, NULL, '2023-09-07 12:09:53.070232', '2023-09-07 12:09:53.070232');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (124, 124, '01.120', '90.012', '70.220', '2023-09-07 12:09:53.152663', '2023-09-07 12:09:53.152663');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (125, 125, '01.120', NULL, NULL, '2023-09-07 12:09:53.205647', '2023-09-07 12:09:53.205647');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (126, 126, '01.120', NULL, NULL, '2023-09-07 12:09:53.294067', '2023-09-07 12:09:53.294067');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (127, 127, '01.120', NULL, NULL, '2023-09-07 12:09:53.370031', '2023-09-07 12:09:53.370031');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (128, 128, '01.120', NULL, NULL, '2023-09-07 12:09:53.458111', '2023-09-07 12:09:53.458111');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (129, 129, '01.120', NULL, NULL, '2023-09-07 12:09:53.520375', '2023-09-07 12:09:53.520375');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (130, 130, '01.120', '90.012', NULL, '2023-09-07 12:09:53.581036', '2023-09-07 12:09:53.581036');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (131, 131, '01.120', NULL, NULL, '2023-09-07 12:09:53.652784', '2023-09-07 12:09:53.652784');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (132, 132, '01.120', '90.012', NULL, '2023-09-07 12:09:53.693547', '2023-09-07 12:09:53.693547');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (133, 133, '01.120', '90.012', '70.220', '2023-09-07 12:09:53.754821', '2023-09-07 12:09:53.754821');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (134, 134, '01.120', NULL, NULL, '2023-09-07 12:09:53.82628', '2023-09-07 12:09:53.82628');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (135, 135, '01.120', NULL, NULL, '2023-09-07 12:09:53.881254', '2023-09-07 12:09:53.881254');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (136, 136, '01.120', '90.012', NULL, '2023-09-07 12:09:53.940591', '2023-09-07 12:09:53.940591');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (137, 137, '01.120', NULL, NULL, '2023-09-07 12:09:53.993649', '2023-09-07 12:09:53.993649');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (138, 138, '01.120', NULL, NULL, '2023-09-07 12:09:54.090798', '2023-09-07 12:09:54.090798');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (139, 139, '01.120', NULL, NULL, '2023-09-07 12:09:54.196284', '2023-09-07 12:09:54.196284');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (140, 140, '01.120', NULL, NULL, '2023-09-07 12:09:54.261644', '2023-09-07 12:09:54.261644');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (141, 141, '01.120', '90.012', '70.220', '2023-09-07 12:09:54.317278', '2023-09-07 12:09:54.317278');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (142, 142, '01.120', NULL, NULL, '2023-09-07 12:09:54.371827', '2023-09-07 12:09:54.371827');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (143, 143, '01.120', '90.012', '70.220', '2023-09-07 12:09:54.417802', '2023-09-07 12:09:54.417802');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (144, 144, '01.120', NULL, NULL, '2023-09-07 12:09:54.456327', '2023-09-07 12:09:54.456327');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (145, 145, '01.120', '90.012', NULL, '2023-09-07 12:09:54.494775', '2023-09-07 12:09:54.494775');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (146, 146, '01.120', '90.012', '70.220', '2023-09-07 12:09:54.531622', '2023-09-07 12:09:54.531622');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (147, 147, '01.120', '90.012', NULL, '2023-09-07 12:09:54.578688', '2023-09-07 12:09:54.578688');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (148, 148, '01.120', NULL, NULL, '2023-09-07 12:09:54.623921', '2023-09-07 12:09:54.623921');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (149, 149, '01.120', NULL, NULL, '2023-09-07 12:09:54.678558', '2023-09-07 12:09:54.678558');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (150, 150, '01.120', '90.012', '70.220', '2023-09-07 12:09:54.727328', '2023-09-07 12:09:54.727328');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (151, 151, '01.120', NULL, NULL, '2023-09-07 12:09:54.766463', '2023-09-07 12:09:54.766463');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (152, 152, '01.120', NULL, NULL, '2023-09-07 12:09:54.792342', '2023-09-07 12:09:54.792342');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (153, 153, '01.120', NULL, NULL, '2023-09-07 12:09:54.836907', '2023-09-07 12:09:54.836907');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (154, 154, '01.120', '90.012', NULL, '2023-09-07 12:09:54.864511', '2023-09-07 12:09:54.864511');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (155, 155, '01.120', NULL, NULL, '2023-09-07 12:09:54.899078', '2023-09-07 12:09:54.899078');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (156, 156, '01.120', NULL, NULL, '2023-09-07 12:09:54.957696', '2023-09-07 12:09:54.957696');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (157, 157, '01.120', NULL, NULL, '2023-09-07 12:09:55.000019', '2023-09-07 12:09:55.000019');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (158, 158, '01.120', NULL, NULL, '2023-09-07 12:09:55.043696', '2023-09-07 12:09:55.043696');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (159, 159, '01.120', '90.012', NULL, '2023-09-07 12:09:55.086291', '2023-09-07 12:09:55.086291');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (160, 160, '01.120', NULL, NULL, '2023-09-07 12:09:55.112662', '2023-09-07 12:09:55.112662');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (161, 161, '01.120', NULL, NULL, '2023-09-07 12:09:55.151052', '2023-09-07 12:09:55.151052');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (162, 162, '01.120', '90.012', '70.220', '2023-09-07 12:09:55.181205', '2023-09-07 12:09:55.181205');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (163, 163, '01.120', NULL, NULL, '2023-09-07 12:09:55.217347', '2023-09-07 12:09:55.217347');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (164, 164, '01.120', '90.012', NULL, '2023-09-07 12:09:55.249914', '2023-09-07 12:09:55.249914');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (165, 165, '01.120', '90.012', NULL, '2023-09-07 12:09:55.298205', '2023-09-07 12:09:55.298205');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (166, 166, '01.120', NULL, NULL, '2023-09-07 12:09:55.335259', '2023-09-07 12:09:55.335259');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (167, 167, '01.120', NULL, NULL, '2023-09-07 12:09:55.382407', '2023-09-07 12:09:55.382407');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (168, 168, '01.120', '90.012', '70.220', '2023-09-07 12:09:55.42004', '2023-09-07 12:09:55.42004');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (169, 169, '01.120', NULL, NULL, '2023-09-07 12:09:55.454338', '2023-09-07 12:09:55.454338');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (170, 170, '01.120', '90.012', NULL, '2023-09-07 12:09:55.494755', '2023-09-07 12:09:55.494755');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (171, 171, '01.120', '90.012', NULL, '2023-09-07 12:09:55.537329', '2023-09-07 12:09:55.537329');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (172, 172, '01.120', NULL, NULL, '2023-09-07 12:09:55.566763', '2023-09-07 12:09:55.566763');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (173, 173, '01.120', '90.012', NULL, '2023-09-07 12:09:55.622548', '2023-09-07 12:09:55.622548');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (174, 174, '01.120', NULL, NULL, '2023-09-07 12:09:55.693616', '2023-09-07 12:09:55.693616');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (175, 175, '01.120', NULL, NULL, '2023-09-07 12:09:55.724061', '2023-09-07 12:09:55.724061');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (176, 176, '01.120', NULL, NULL, '2023-09-07 12:09:55.762758', '2023-09-07 12:09:55.762758');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (177, 177, '01.120', NULL, NULL, '2023-09-07 12:09:55.793814', '2023-09-07 12:09:55.793814');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (178, 178, '01.120', '90.012', NULL, '2023-09-07 12:09:55.817827', '2023-09-07 12:09:55.817827');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (179, 179, '01.120', '90.012', NULL, '2023-09-07 12:09:55.847674', '2023-09-07 12:09:55.847674');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (180, 180, '01.120', '90.012', NULL, '2023-09-07 12:09:55.8808', '2023-09-07 12:09:55.8808');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (181, 181, '01.120', '90.012', NULL, '2023-09-07 12:09:55.920214', '2023-09-07 12:09:55.920214');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (182, 182, '01.120', NULL, NULL, '2023-09-07 12:09:55.952065', '2023-09-07 12:09:55.952065');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (183, 183, '01.120', '90.012', '70.220', '2023-09-07 12:09:55.997401', '2023-09-07 12:09:55.997401');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (184, 184, '01.120', NULL, NULL, '2023-09-07 12:09:56.041114', '2023-09-07 12:09:56.041114');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (185, 185, '01.120', NULL, NULL, '2023-09-07 12:09:56.075241', '2023-09-07 12:09:56.075241');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (186, 186, '01.120', NULL, NULL, '2023-09-07 12:09:56.111167', '2023-09-07 12:09:56.111167');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (187, 187, '01.120', '90.012', NULL, '2023-09-07 12:09:56.143102', '2023-09-07 12:09:56.143102');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (188, 188, '01.120', NULL, NULL, '2023-09-07 12:09:56.187852', '2023-09-07 12:09:56.187852');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (189, 189, '01.120', '90.012', '70.220', '2023-09-07 12:09:56.22396', '2023-09-07 12:09:56.22396');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (190, 190, '01.120', NULL, NULL, '2023-09-07 12:09:56.274091', '2023-09-07 12:09:56.274091');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (191, 191, '01.120', '90.012', NULL, '2023-09-07 12:09:56.332327', '2023-09-07 12:09:56.332327');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (192, 192, '01.120', '90.012', '70.220', '2023-09-07 12:09:56.380137', '2023-09-07 12:09:56.380137');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (193, 193, '01.120', '90.012', NULL, '2023-09-07 12:09:56.458008', '2023-09-07 12:09:56.458008');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (194, 194, '01.120', NULL, NULL, '2023-09-07 12:09:56.515381', '2023-09-07 12:09:56.515381');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (195, 195, '01.120', '90.012', NULL, '2023-09-07 12:09:56.571955', '2023-09-07 12:09:56.571955');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (196, 196, '01.120', '90.012', NULL, '2023-09-07 12:09:56.610098', '2023-09-07 12:09:56.610098');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (197, 197, '01.120', '90.012', NULL, '2023-09-07 12:09:56.656033', '2023-09-07 12:09:56.656033');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (198, 198, '01.120', '90.012', '70.220', '2023-09-07 12:09:56.691343', '2023-09-07 12:09:56.691343');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (199, 199, '01.120', '90.012', NULL, '2023-09-07 12:09:56.728327', '2023-09-07 12:09:56.728327');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (200, 200, '01.120', '90.012', NULL, '2023-09-07 12:09:56.763745', '2023-09-07 12:09:56.763745');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (201, 201, '01.120', '90.012', NULL, '2023-09-07 12:09:56.806066', '2023-09-07 12:09:56.806066');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (202, 202, '01.120', '90.012', '70.220', '2023-09-07 12:09:56.844143', '2023-09-07 12:09:56.844143');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (203, 203, '01.120', '90.012', NULL, '2023-09-07 12:09:56.894783', '2023-09-07 12:09:56.894783');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (204, 204, '01.120', '90.012', NULL, '2023-09-07 12:09:56.973047', '2023-09-07 12:09:56.973047');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (205, 205, '01.120', NULL, NULL, '2023-09-07 12:09:57.035347', '2023-09-07 12:09:57.035347');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (206, 206, '01.120', NULL, NULL, '2023-09-07 12:09:57.079618', '2023-09-07 12:09:57.079618');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (207, 207, '01.120', '90.012', NULL, '2023-09-07 12:09:57.132246', '2023-09-07 12:09:57.132246');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (208, 208, '01.120', NULL, NULL, '2023-09-07 12:09:57.164195', '2023-09-07 12:09:57.164195');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (209, 209, '01.120', '90.012', NULL, '2023-09-07 12:09:57.196793', '2023-09-07 12:09:57.196793');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (210, 210, '01.120', '90.012', NULL, '2023-09-07 12:09:57.22138', '2023-09-07 12:09:57.22138');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (211, 211, '01.120', '90.012', NULL, '2023-09-07 12:09:57.245986', '2023-09-07 12:09:57.245986');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (212, 212, '01.120', NULL, NULL, '2023-09-07 12:09:57.2865', '2023-09-07 12:09:57.2865');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (213, 213, '01.120', NULL, NULL, '2023-09-07 12:09:57.311421', '2023-09-07 12:09:57.311421');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (214, 214, '01.120', NULL, NULL, '2023-09-07 12:09:57.350355', '2023-09-07 12:09:57.350355');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (215, 215, '01.120', '90.012', '70.220', '2023-09-07 12:09:57.387482', '2023-09-07 12:09:57.387482');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (216, 216, '01.120', '90.012', NULL, '2023-09-07 12:09:57.416291', '2023-09-07 12:09:57.416291');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (217, 217, '01.120', NULL, NULL, '2023-09-07 12:09:57.457032', '2023-09-07 12:09:57.457032');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (218, 218, '01.120', NULL, NULL, '2023-09-07 12:09:57.492426', '2023-09-07 12:09:57.492426');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (219, 219, '01.120', NULL, NULL, '2023-09-07 12:09:57.528374', '2023-09-07 12:09:57.528374');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (220, 220, '01.120', '90.012', NULL, '2023-09-07 12:09:57.557567', '2023-09-07 12:09:57.557567');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (221, 221, '01.120', NULL, NULL, '2023-09-07 12:09:57.583627', '2023-09-07 12:09:57.583627');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (222, 222, '01.120', NULL, NULL, '2023-09-07 12:09:57.618648', '2023-09-07 12:09:57.618648');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (223, 223, '01.120', NULL, NULL, '2023-09-07 12:09:57.657471', '2023-09-07 12:09:57.657471');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (224, 224, '01.120', NULL, NULL, '2023-09-07 12:09:57.679946', '2023-09-07 12:09:57.679946');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (225, 225, '01.120', '90.012', NULL, '2023-09-07 12:09:57.706294', '2023-09-07 12:09:57.706294');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (226, 226, '01.120', '90.012', '70.220', '2023-09-07 12:09:57.746386', '2023-09-07 12:09:57.746386');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (227, 227, '01.120', NULL, NULL, '2023-09-07 12:09:57.774182', '2023-09-07 12:09:57.774182');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (228, 228, '01.120', NULL, NULL, '2023-09-07 12:09:57.796098', '2023-09-07 12:09:57.796098');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (229, 229, '01.120', NULL, NULL, '2023-09-07 12:09:57.822273', '2023-09-07 12:09:57.822273');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (230, 230, '01.120', '90.012', NULL, '2023-09-07 12:09:57.854109', '2023-09-07 12:09:57.854109');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (231, 231, '01.120', NULL, NULL, '2023-09-07 12:09:57.881325', '2023-09-07 12:09:57.881325');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (232, 232, '01.120', NULL, NULL, '2023-09-07 12:09:57.912796', '2023-09-07 12:09:57.912796');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (233, 233, '01.120', '90.012', NULL, '2023-09-07 12:09:57.93849', '2023-09-07 12:09:57.93849');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (234, 234, '01.120', NULL, NULL, '2023-09-07 12:09:57.976605', '2023-09-07 12:09:57.976605');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (235, 235, '01.120', '90.012', '70.220', '2023-09-07 12:09:58.012787', '2023-09-07 12:09:58.012787');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (236, 236, '01.120', '90.012', NULL, '2023-09-07 12:09:58.059991', '2023-09-07 12:09:58.059991');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (237, 237, '01.120', NULL, NULL, '2023-09-07 12:09:58.100345', '2023-09-07 12:09:58.100345');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (238, 238, '01.120', NULL, NULL, '2023-09-07 12:09:58.139037', '2023-09-07 12:09:58.139037');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (239, 239, '01.120', '90.012', '70.220', '2023-09-07 12:09:58.177669', '2023-09-07 12:09:58.177669');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (240, 240, '01.120', '90.012', NULL, '2023-09-07 12:09:58.209872', '2023-09-07 12:09:58.209872');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (241, 241, '01.120', '90.012', '70.220', '2023-09-07 12:09:58.23155', '2023-09-07 12:09:58.23155');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (242, 242, '01.120', '90.012', '70.220', '2023-09-07 12:09:58.261593', '2023-09-07 12:09:58.261593');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (243, 243, '01.120', '90.012', NULL, '2023-09-07 12:09:58.314511', '2023-09-07 12:09:58.314511');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (244, 244, '01.120', '90.012', NULL, '2023-09-07 12:09:58.357867', '2023-09-07 12:09:58.357867');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (245, 245, '01.120', '90.012', NULL, '2023-09-07 12:09:58.400303', '2023-09-07 12:09:58.400303');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (246, 246, '01.120', '90.012', NULL, '2023-09-07 12:09:58.462151', '2023-09-07 12:09:58.462151');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (247, 247, '01.120', '90.012', '70.220', '2023-09-07 12:09:58.511649', '2023-09-07 12:09:58.511649');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (248, 248, '01.120', '90.012', NULL, '2023-09-07 12:09:58.544811', '2023-09-07 12:09:58.544811');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (249, 249, '01.120', NULL, NULL, '2023-09-07 12:09:58.583837', '2023-09-07 12:09:58.583837');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (250, 250, '01.120', NULL, NULL, '2023-09-07 12:09:58.635198', '2023-09-07 12:09:58.635198');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (251, 251, '01.120', '90.012', NULL, '2023-09-07 12:09:58.70117', '2023-09-07 12:09:58.70117');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (252, 252, '01.120', '90.012', '70.220', '2023-09-07 12:09:58.732188', '2023-09-07 12:09:58.732188');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (253, 253, '01.120', NULL, NULL, '2023-09-07 12:09:58.766486', '2023-09-07 12:09:58.766486');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (254, 254, '01.120', NULL, NULL, '2023-09-07 12:09:58.820571', '2023-09-07 12:09:58.820571');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (255, 255, '01.120', NULL, NULL, '2023-09-07 12:09:58.874694', '2023-09-07 12:09:58.874694');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (256, 256, '01.120', '90.012', NULL, '2023-09-07 12:09:58.92912', '2023-09-07 12:09:58.92912');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (257, 257, '01.120', '90.012', '70.220', '2023-09-07 12:09:58.985664', '2023-09-07 12:09:58.985664');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (258, 258, '01.120', NULL, NULL, '2023-09-07 12:09:59.024309', '2023-09-07 12:09:59.024309');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (259, 259, '01.120', '90.012', NULL, '2023-09-07 12:09:59.0561', '2023-09-07 12:09:59.0561');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (260, 260, '01.120', '90.012', NULL, '2023-09-07 12:09:59.103762', '2023-09-07 12:09:59.103762');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (261, 261, '01.120', NULL, NULL, '2023-09-07 12:09:59.137409', '2023-09-07 12:09:59.137409');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (262, 262, '01.120', '90.012', NULL, '2023-09-07 12:09:59.184722', '2023-09-07 12:09:59.184722');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (263, 263, '01.120', '90.012', NULL, '2023-09-07 12:09:59.215821', '2023-09-07 12:09:59.215821');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (264, 264, '01.120', '90.012', '70.220', '2023-09-07 12:09:59.299347', '2023-09-07 12:09:59.299347');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (265, 265, '01.120', '90.012', NULL, '2023-09-07 12:09:59.338975', '2023-09-07 12:09:59.338975');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (266, 266, '01.120', NULL, NULL, '2023-09-07 12:09:59.370122', '2023-09-07 12:09:59.370122');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (267, 267, '01.120', '90.012', NULL, '2023-09-07 12:09:59.407308', '2023-09-07 12:09:59.407308');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (268, 268, '01.120', NULL, NULL, '2023-09-07 12:09:59.432589', '2023-09-07 12:09:59.432589');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (269, 269, '01.120', '90.012', '70.220', '2023-09-07 12:09:59.461166', '2023-09-07 12:09:59.461166');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (270, 270, '01.120', NULL, NULL, '2023-09-07 12:09:59.498211', '2023-09-07 12:09:59.498211');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (271, 271, '01.120', NULL, NULL, '2023-09-07 12:09:59.541124', '2023-09-07 12:09:59.541124');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (272, 272, '01.120', NULL, NULL, '2023-09-07 12:09:59.581971', '2023-09-07 12:09:59.581971');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (273, 273, '01.120', '90.012', NULL, '2023-09-07 12:09:59.615876', '2023-09-07 12:09:59.615876');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (274, 274, '01.120', '90.012', NULL, '2023-09-07 12:09:59.663386', '2023-09-07 12:09:59.663386');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (275, 275, '01.120', NULL, NULL, '2023-09-07 12:09:59.710261', '2023-09-07 12:09:59.710261');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (276, 276, '01.120', '90.012', NULL, '2023-09-07 12:09:59.752864', '2023-09-07 12:09:59.752864');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (277, 277, '01.120', '90.012', NULL, '2023-09-07 12:09:59.794086', '2023-09-07 12:09:59.794086');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (278, 278, '01.120', NULL, NULL, '2023-09-07 12:09:59.815205', '2023-09-07 12:09:59.815205');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (279, 279, '01.120', '90.012', NULL, '2023-09-07 12:09:59.848305', '2023-09-07 12:09:59.848305');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (280, 280, '01.120', NULL, NULL, '2023-09-07 12:09:59.874294', '2023-09-07 12:09:59.874294');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (281, 281, '01.120', '90.012', NULL, '2023-09-07 12:09:59.910898', '2023-09-07 12:09:59.910898');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (282, 282, '01.120', '90.012', NULL, '2023-09-07 12:09:59.943031', '2023-09-07 12:09:59.943031');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (283, 283, '01.120', '90.012', '70.220', '2023-09-07 12:09:59.9791', '2023-09-07 12:09:59.9791');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (284, 284, '01.120', NULL, NULL, '2023-09-07 12:10:00.014605', '2023-09-07 12:10:00.014605');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (285, 285, '01.120', '90.012', '70.220', '2023-09-07 12:10:00.055204', '2023-09-07 12:10:00.055204');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (286, 286, '01.120', '90.012', NULL, '2023-09-07 12:10:00.088607', '2023-09-07 12:10:00.088607');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (287, 287, '01.120', NULL, NULL, '2023-09-07 12:10:00.118179', '2023-09-07 12:10:00.118179');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (288, 288, '01.120', NULL, NULL, '2023-09-07 12:10:00.156244', '2023-09-07 12:10:00.156244');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (289, 289, '01.120', '90.012', NULL, '2023-09-07 12:10:00.191208', '2023-09-07 12:10:00.191208');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (290, 290, '01.120', NULL, NULL, '2023-09-07 12:10:00.230049', '2023-09-07 12:10:00.230049');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (291, 291, '01.120', NULL, NULL, '2023-09-07 12:10:00.255725', '2023-09-07 12:10:00.255725');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (292, 292, '01.120', NULL, NULL, '2023-09-07 12:10:00.292112', '2023-09-07 12:10:00.292112');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (293, 293, '01.120', '90.012', '70.220', '2023-09-07 12:10:00.313175', '2023-09-07 12:10:00.313175');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (294, 294, '01.120', '90.012', '70.220', '2023-09-07 12:10:00.337103', '2023-09-07 12:10:00.337103');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (295, 295, '01.120', NULL, NULL, '2023-09-07 12:10:00.3601', '2023-09-07 12:10:00.3601');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (296, 296, '01.120', '90.012', NULL, '2023-09-07 12:10:00.388263', '2023-09-07 12:10:00.388263');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (297, 297, '01.120', '90.012', NULL, '2023-09-07 12:10:00.42101', '2023-09-07 12:10:00.42101');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (298, 298, '01.120', NULL, NULL, '2023-09-07 12:10:00.457842', '2023-09-07 12:10:00.457842');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (299, 299, '01.120', '90.012', NULL, '2023-09-07 12:10:00.487105', '2023-09-07 12:10:00.487105');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (300, 300, '01.120', '90.012', '70.220', '2023-09-07 12:10:00.528854', '2023-09-07 12:10:00.528854');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (301, 301, '01.120', NULL, NULL, '2023-09-07 12:10:00.574509', '2023-09-07 12:10:00.574509');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (302, 302, '01.120', NULL, NULL, '2023-09-07 12:10:00.632244', '2023-09-07 12:10:00.632244');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (303, 303, '01.120', '90.012', NULL, '2023-09-07 12:10:00.674423', '2023-09-07 12:10:00.674423');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (304, 304, '01.120', '90.012', NULL, '2023-09-07 12:10:00.720133', '2023-09-07 12:10:00.720133');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (305, 305, '01.120', NULL, NULL, '2023-09-07 12:10:00.755947', '2023-09-07 12:10:00.755947');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (306, 306, '01.120', '90.012', NULL, '2023-09-07 12:10:00.926582', '2023-09-07 12:10:00.926582');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (307, 307, '01.120', NULL, NULL, '2023-09-07 12:10:00.978167', '2023-09-07 12:10:00.978167');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (308, 308, '01.120', NULL, NULL, '2023-09-07 12:10:01.026766', '2023-09-07 12:10:01.026766');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (309, 309, '01.120', '90.012', NULL, '2023-09-07 12:10:01.096158', '2023-09-07 12:10:01.096158');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (310, 310, '01.120', NULL, NULL, '2023-09-07 12:10:01.174543', '2023-09-07 12:10:01.174543');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (311, 311, '01.120', '90.012', '70.220', '2023-09-07 12:10:01.238043', '2023-09-07 12:10:01.238043');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (312, 312, '01.120', NULL, NULL, '2023-09-07 12:10:01.29489', '2023-09-07 12:10:01.29489');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (313, 313, '01.120', '90.012', NULL, '2023-09-07 12:10:01.3411', '2023-09-07 12:10:01.3411');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (314, 314, '01.120', '90.012', NULL, '2023-09-07 12:10:01.400257', '2023-09-07 12:10:01.400257');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (315, 315, '01.120', NULL, NULL, '2023-09-07 12:10:01.453478', '2023-09-07 12:10:01.453478');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (316, 316, '01.120', NULL, NULL, '2023-09-07 12:10:01.515803', '2023-09-07 12:10:01.515803');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (317, 317, '01.120', '90.012', '70.220', '2023-09-07 12:10:01.578219', '2023-09-07 12:10:01.578219');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (318, 318, '01.120', NULL, NULL, '2023-09-07 12:10:01.641994', '2023-09-07 12:10:01.641994');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (319, 319, '01.120', NULL, NULL, '2023-09-07 12:10:01.702364', '2023-09-07 12:10:01.702364');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (320, 320, '01.120', NULL, NULL, '2023-09-07 12:10:01.813788', '2023-09-07 12:10:01.813788');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (321, 321, '01.120', '90.012', NULL, '2023-09-07 12:10:01.861084', '2023-09-07 12:10:01.861084');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (322, 322, '01.120', '90.012', NULL, '2023-09-07 12:10:01.917889', '2023-09-07 12:10:01.917889');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (323, 323, '01.120', '90.012', NULL, '2023-09-07 12:10:01.96377', '2023-09-07 12:10:01.96377');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (324, 324, '01.120', NULL, NULL, '2023-09-07 12:10:02.017113', '2023-09-07 12:10:02.017113');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (325, 325, '01.120', '90.012', NULL, '2023-09-07 12:10:02.052487', '2023-09-07 12:10:02.052487');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (326, 326, '01.120', '90.012', '70.220', '2023-09-07 12:10:02.105553', '2023-09-07 12:10:02.105553');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (327, 327, '01.120', '90.012', NULL, '2023-09-07 12:10:02.160071', '2023-09-07 12:10:02.160071');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (328, 328, '01.120', NULL, NULL, '2023-09-07 12:10:02.200449', '2023-09-07 12:10:02.200449');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (329, 329, '01.120', NULL, NULL, '2023-09-07 12:10:02.24559', '2023-09-07 12:10:02.24559');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (330, 330, '01.120', '90.012', '70.220', '2023-09-07 12:10:02.286091', '2023-09-07 12:10:02.286091');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (331, 331, '01.120', NULL, NULL, '2023-09-07 12:10:02.314572', '2023-09-07 12:10:02.314572');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (332, 332, '01.120', NULL, NULL, '2023-09-07 12:10:02.358538', '2023-09-07 12:10:02.358538');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (333, 333, '01.120', '90.012', '70.220', '2023-09-07 12:10:02.407351', '2023-09-07 12:10:02.407351');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (334, 334, '01.120', NULL, NULL, '2023-09-07 12:10:02.445118', '2023-09-07 12:10:02.445118');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (335, 335, '01.120', '90.012', '70.220', '2023-09-07 12:10:02.508218', '2023-09-07 12:10:02.508218');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (336, 336, '01.120', NULL, NULL, '2023-09-07 12:10:02.557323', '2023-09-07 12:10:02.557323');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (337, 337, '01.120', NULL, NULL, '2023-09-07 12:10:02.615645', '2023-09-07 12:10:02.615645');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (338, 338, '01.120', NULL, NULL, '2023-09-07 12:10:02.686004', '2023-09-07 12:10:02.686004');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (339, 339, '01.120', NULL, NULL, '2023-09-07 12:10:02.730606', '2023-09-07 12:10:02.730606');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (340, 340, '01.120', '90.012', NULL, '2023-09-07 12:10:02.804468', '2023-09-07 12:10:02.804468');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (341, 341, '01.120', '90.012', '70.220', '2023-09-07 12:10:02.861148', '2023-09-07 12:10:02.861148');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (342, 342, '01.120', '90.012', '70.220', '2023-09-07 12:10:02.907413', '2023-09-07 12:10:02.907413');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (343, 343, '01.120', NULL, NULL, '2023-09-07 12:10:02.952151', '2023-09-07 12:10:02.952151');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (344, 344, '01.120', NULL, NULL, '2023-09-07 12:10:03.000643', '2023-09-07 12:10:03.000643');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (345, 345, '01.120', '90.012', NULL, '2023-09-07 12:10:03.047974', '2023-09-07 12:10:03.047974');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (346, 346, '01.120', NULL, NULL, '2023-09-07 12:10:03.100732', '2023-09-07 12:10:03.100732');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (347, 347, '01.120', '90.012', NULL, '2023-09-07 12:10:03.140426', '2023-09-07 12:10:03.140426');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (348, 348, '01.120', NULL, NULL, '2023-09-07 12:10:03.196419', '2023-09-07 12:10:03.196419');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (349, 349, '01.120', NULL, NULL, '2023-09-07 12:10:03.227942', '2023-09-07 12:10:03.227942');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (350, 350, '01.120', '90.012', NULL, '2023-09-07 12:10:03.268037', '2023-09-07 12:10:03.268037');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (351, 351, '01.120', NULL, NULL, '2023-09-07 12:10:03.388038', '2023-09-07 12:10:03.388038');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (352, 352, '01.120', '90.012', NULL, '2023-09-07 12:10:03.507572', '2023-09-07 12:10:03.507572');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (353, 353, '01.120', NULL, NULL, '2023-09-07 12:10:03.713996', '2023-09-07 12:10:03.713996');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (354, 354, '01.120', '90.012', '70.220', '2023-09-07 12:10:03.820363', '2023-09-07 12:10:03.820363');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (355, 355, '01.120', '90.012', '70.220', '2023-09-07 12:10:03.899795', '2023-09-07 12:10:03.899795');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (356, 356, '01.120', '90.012', NULL, '2023-09-07 12:10:03.984488', '2023-09-07 12:10:03.984488');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (357, 357, '01.120', NULL, NULL, '2023-09-07 12:10:04.078102', '2023-09-07 12:10:04.078102');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (358, 358, '01.120', '90.012', NULL, '2023-09-07 12:10:04.220535', '2023-09-07 12:10:04.220535');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (359, 359, '01.120', '90.012', NULL, '2023-09-07 12:10:04.266418', '2023-09-07 12:10:04.266418');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (360, 360, '01.120', NULL, NULL, '2023-09-07 12:10:04.347401', '2023-09-07 12:10:04.347401');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (361, 361, '01.120', '90.012', NULL, '2023-09-07 12:10:04.468863', '2023-09-07 12:10:04.468863');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (362, 362, '01.120', NULL, NULL, '2023-09-07 12:10:04.568554', '2023-09-07 12:10:04.568554');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (363, 363, '01.120', NULL, NULL, '2023-09-07 12:10:04.657561', '2023-09-07 12:10:04.657561');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (364, 364, '01.120', NULL, NULL, '2023-09-07 12:10:04.966601', '2023-09-07 12:10:04.966601');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (365, 365, '01.120', NULL, NULL, '2023-09-07 12:10:05.241615', '2023-09-07 12:10:05.241615');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (366, 366, '01.120', NULL, NULL, '2023-09-07 12:10:05.544054', '2023-09-07 12:10:05.544054');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (367, 367, '01.120', '90.012', NULL, '2023-09-07 12:10:05.642391', '2023-09-07 12:10:05.642391');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (368, 368, '01.120', NULL, NULL, '2023-09-07 12:10:05.958862', '2023-09-07 12:10:05.958862');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (369, 369, '01.120', NULL, NULL, '2023-09-07 12:10:06.147171', '2023-09-07 12:10:06.147171');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (370, 370, '01.120', '90.012', NULL, '2023-09-07 12:10:06.24012', '2023-09-07 12:10:06.24012');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (371, 371, '01.120', '90.012', NULL, '2023-09-07 12:10:06.303638', '2023-09-07 12:10:06.303638');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (372, 372, '01.120', NULL, NULL, '2023-09-07 12:10:06.366978', '2023-09-07 12:10:06.366978');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (373, 373, '01.120', '90.012', NULL, '2023-09-07 12:10:06.477936', '2023-09-07 12:10:06.477936');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (374, 374, '01.120', '90.012', NULL, '2023-09-07 12:10:06.60512', '2023-09-07 12:10:06.60512');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (375, 375, '01.120', NULL, NULL, '2023-09-07 12:10:06.716965', '2023-09-07 12:10:06.716965');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (376, 376, '01.120', '90.012', NULL, '2023-09-07 12:10:06.781914', '2023-09-07 12:10:06.781914');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (377, 377, '01.120', NULL, NULL, '2023-09-07 12:10:06.846859', '2023-09-07 12:10:06.846859');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (378, 378, '01.120', NULL, NULL, '2023-09-07 12:10:06.915545', '2023-09-07 12:10:06.915545');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (379, 379, '01.120', NULL, NULL, '2023-09-07 12:10:07.022139', '2023-09-07 12:10:07.022139');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (380, 380, '01.120', '90.012', NULL, '2023-09-07 12:10:07.124093', '2023-09-07 12:10:07.124093');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (381, 381, '01.120', '90.012', NULL, '2023-09-07 12:10:07.347186', '2023-09-07 12:10:07.347186');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (382, 382, '01.120', '90.012', NULL, '2023-09-07 12:10:07.414785', '2023-09-07 12:10:07.414785');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (383, 383, '01.120', '90.012', '70.220', '2023-09-07 12:10:07.472548', '2023-09-07 12:10:07.472548');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (384, 384, '01.120', NULL, NULL, '2023-09-07 12:10:07.511565', '2023-09-07 12:10:07.511565');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (385, 385, '01.120', '90.012', NULL, '2023-09-07 12:10:07.547983', '2023-09-07 12:10:07.547983');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (386, 386, '01.120', '90.012', NULL, '2023-09-07 12:10:07.587811', '2023-09-07 12:10:07.587811');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (387, 387, '01.120', '90.012', NULL, '2023-09-07 12:10:07.613993', '2023-09-07 12:10:07.613993');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (388, 388, '01.120', '90.012', NULL, '2023-09-07 12:10:07.647974', '2023-09-07 12:10:07.647974');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (389, 389, '01.120', '90.012', NULL, '2023-09-07 12:10:07.683508', '2023-09-07 12:10:07.683508');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (390, 390, '01.120', NULL, NULL, '2023-09-07 12:10:07.724593', '2023-09-07 12:10:07.724593');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (391, 391, '01.120', '90.012', NULL, '2023-09-07 12:10:07.753098', '2023-09-07 12:10:07.753098');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (392, 392, '01.120', NULL, NULL, '2023-09-07 12:10:07.816758', '2023-09-07 12:10:07.816758');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (393, 393, '01.120', NULL, NULL, '2023-09-07 12:10:07.842642', '2023-09-07 12:10:07.842642');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (394, 394, '01.120', '90.012', NULL, '2023-09-07 12:10:07.876843', '2023-09-07 12:10:07.876843');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (395, 395, '01.120', '90.012', '70.220', '2023-09-07 12:10:07.911803', '2023-09-07 12:10:07.911803');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (396, 396, '01.120', '90.012', '70.220', '2023-09-07 12:10:07.937962', '2023-09-07 12:10:07.937962');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (397, 397, '01.120', '90.012', NULL, '2023-09-07 12:10:07.968044', '2023-09-07 12:10:07.968044');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (398, 398, '01.120', '90.012', NULL, '2023-09-07 12:10:08.002187', '2023-09-07 12:10:08.002187');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (399, 399, '01.120', '90.012', NULL, '2023-09-07 12:10:08.040813', '2023-09-07 12:10:08.040813');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (400, 400, '01.120', NULL, NULL, '2023-09-07 12:10:08.077921', '2023-09-07 12:10:08.077921');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (401, 401, '01.120', '90.012', NULL, '2023-09-07 12:10:08.119919', '2023-09-07 12:10:08.119919');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (402, 402, '01.120', NULL, NULL, '2023-09-07 12:10:08.147491', '2023-09-07 12:10:08.147491');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (403, 403, '01.120', NULL, NULL, '2023-09-07 12:10:08.180784', '2023-09-07 12:10:08.180784');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (404, 404, '01.120', NULL, NULL, '2023-09-07 12:10:08.214777', '2023-09-07 12:10:08.214777');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (405, 405, '01.120', NULL, NULL, '2023-09-07 12:10:08.242017', '2023-09-07 12:10:08.242017');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (406, 406, '01.120', NULL, NULL, '2023-09-07 12:10:08.26795', '2023-09-07 12:10:08.26795');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (407, 407, '01.120', NULL, NULL, '2023-09-07 12:10:08.303433', '2023-09-07 12:10:08.303433');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (408, 408, '01.120', '90.012', '70.220', '2023-09-07 12:10:08.340464', '2023-09-07 12:10:08.340464');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (409, 409, '01.120', '90.012', NULL, '2023-09-07 12:10:08.373212', '2023-09-07 12:10:08.373212');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (410, 410, '01.120', NULL, NULL, '2023-09-07 12:10:08.396314', '2023-09-07 12:10:08.396314');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (411, 411, '01.120', '90.012', '70.220', '2023-09-07 12:10:08.428511', '2023-09-07 12:10:08.428511');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (412, 412, '01.120', '90.012', NULL, '2023-09-07 12:10:08.471379', '2023-09-07 12:10:08.471379');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (413, 413, '01.120', NULL, NULL, '2023-09-07 12:10:08.497263', '2023-09-07 12:10:08.497263');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (414, 414, '01.120', '90.012', NULL, '2023-09-07 12:10:08.525336', '2023-09-07 12:10:08.525336');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (415, 415, '01.120', '90.012', NULL, '2023-09-07 12:10:08.544359', '2023-09-07 12:10:08.544359');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (416, 416, '01.120', '90.012', NULL, '2023-09-07 12:10:08.566336', '2023-09-07 12:10:08.566336');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (417, 417, '01.120', '90.012', NULL, '2023-09-07 12:10:08.595113', '2023-09-07 12:10:08.595113');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (418, 418, '01.120', NULL, NULL, '2023-09-07 12:10:08.625803', '2023-09-07 12:10:08.625803');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (419, 419, '01.120', '90.012', '70.220', '2023-09-07 12:10:08.665401', '2023-09-07 12:10:08.665401');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (420, 420, '01.120', '90.012', NULL, '2023-09-07 12:10:08.704402', '2023-09-07 12:10:08.704402');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (421, 421, '01.120', '90.012', NULL, '2023-09-07 12:10:08.743492', '2023-09-07 12:10:08.743492');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (422, 422, '01.120', '90.012', NULL, '2023-09-07 12:10:08.787009', '2023-09-07 12:10:08.787009');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (423, 423, '01.120', NULL, NULL, '2023-09-07 12:10:08.810236', '2023-09-07 12:10:08.810236');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (424, 424, '01.120', NULL, NULL, '2023-09-07 12:10:08.841367', '2023-09-07 12:10:08.841367');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (425, 425, '01.120', '90.012', '70.220', '2023-09-07 12:10:08.867229', '2023-09-07 12:10:08.867229');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (426, 426, '01.120', NULL, NULL, '2023-09-07 12:10:08.892947', '2023-09-07 12:10:08.892947');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (427, 427, '01.120', NULL, NULL, '2023-09-07 12:10:08.919684', '2023-09-07 12:10:08.919684');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (428, 428, '01.120', '90.012', NULL, '2023-09-07 12:10:08.946507', '2023-09-07 12:10:08.946507');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (429, 429, '01.120', NULL, NULL, '2023-09-07 12:10:08.97742', '2023-09-07 12:10:08.97742');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (430, 430, '01.120', NULL, NULL, '2023-09-07 12:10:09.014638', '2023-09-07 12:10:09.014638');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (431, 431, '01.120', NULL, NULL, '2023-09-07 12:10:09.043299', '2023-09-07 12:10:09.043299');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (432, 432, '01.120', '90.012', '70.220', '2023-09-07 12:10:09.064283', '2023-09-07 12:10:09.064283');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (433, 433, '01.120', '90.012', NULL, '2023-09-07 12:10:09.088283', '2023-09-07 12:10:09.088283');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (434, 434, '01.120', NULL, NULL, '2023-09-07 12:10:09.111351', '2023-09-07 12:10:09.111351');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (435, 435, '01.120', NULL, NULL, '2023-09-07 12:10:09.140214', '2023-09-07 12:10:09.140214');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (436, 436, '01.120', NULL, NULL, '2023-09-07 12:10:09.163322', '2023-09-07 12:10:09.163322');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (437, 437, '01.120', NULL, NULL, '2023-09-07 12:10:09.192391', '2023-09-07 12:10:09.192391');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (438, 438, '01.120', NULL, NULL, '2023-09-07 12:10:09.224703', '2023-09-07 12:10:09.224703');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (439, 439, '01.120', NULL, NULL, '2023-09-07 12:10:09.27805', '2023-09-07 12:10:09.27805');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (440, 440, '01.120', NULL, NULL, '2023-09-07 12:10:09.361297', '2023-09-07 12:10:09.361297');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (441, 441, '01.120', NULL, NULL, '2023-09-07 12:10:09.404883', '2023-09-07 12:10:09.404883');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (442, 442, '01.120', '90.012', '70.220', '2023-09-07 12:10:09.428946', '2023-09-07 12:10:09.428946');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (443, 443, '01.120', '90.012', NULL, '2023-09-07 12:10:09.465225', '2023-09-07 12:10:09.465225');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (444, 444, '01.120', NULL, NULL, '2023-09-07 12:10:09.498549', '2023-09-07 12:10:09.498549');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (445, 445, '01.120', NULL, NULL, '2023-09-07 12:10:09.541425', '2023-09-07 12:10:09.541425');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (446, 446, '01.120', NULL, NULL, '2023-09-07 12:10:09.578795', '2023-09-07 12:10:09.578795');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (447, 447, '01.120', NULL, NULL, '2023-09-07 12:10:09.636355', '2023-09-07 12:10:09.636355');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (448, 448, '01.120', NULL, NULL, '2023-09-07 12:10:09.678009', '2023-09-07 12:10:09.678009');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (449, 449, '01.120', NULL, NULL, '2023-09-07 12:10:09.713458', '2023-09-07 12:10:09.713458');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (450, 450, '01.120', '90.012', NULL, '2023-09-07 12:10:09.741883', '2023-09-07 12:10:09.741883');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (451, 451, '01.120', '90.012', '70.220', '2023-09-07 12:10:09.763213', '2023-09-07 12:10:09.763213');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (452, 452, '01.120', NULL, NULL, '2023-09-07 12:10:09.796491', '2023-09-07 12:10:09.796491');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (453, 453, '01.120', '90.012', NULL, '2023-09-07 12:10:09.859037', '2023-09-07 12:10:09.859037');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (454, 454, '01.120', '90.012', NULL, '2023-09-07 12:10:09.900008', '2023-09-07 12:10:09.900008');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (455, 455, '01.120', NULL, NULL, '2023-09-07 12:10:09.942851', '2023-09-07 12:10:09.942851');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (456, 456, '01.120', NULL, NULL, '2023-09-07 12:10:09.983287', '2023-09-07 12:10:09.983287');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (457, 457, '01.120', '90.012', '70.220', '2023-09-07 12:10:10.018174', '2023-09-07 12:10:10.018174');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (458, 458, '01.120', '90.012', NULL, '2023-09-07 12:10:10.048585', '2023-09-07 12:10:10.048585');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (459, 459, '01.120', '90.012', NULL, '2023-09-07 12:10:10.073941', '2023-09-07 12:10:10.073941');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (460, 460, '01.120', NULL, NULL, '2023-09-07 12:10:10.098318', '2023-09-07 12:10:10.098318');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (461, 461, '01.120', NULL, NULL, '2023-09-07 12:10:10.127417', '2023-09-07 12:10:10.127417');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (462, 462, '01.120', '90.012', NULL, '2023-09-07 12:10:10.183465', '2023-09-07 12:10:10.183465');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (463, 463, '01.120', NULL, NULL, '2023-09-07 12:10:10.227394', '2023-09-07 12:10:10.227394');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (464, 464, '01.120', '90.012', NULL, '2023-09-07 12:10:10.253171', '2023-09-07 12:10:10.253171');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (465, 465, '01.120', NULL, NULL, '2023-09-07 12:10:10.285091', '2023-09-07 12:10:10.285091');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (466, 466, '01.120', NULL, NULL, '2023-09-07 12:10:10.317745', '2023-09-07 12:10:10.317745');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (467, 467, '01.120', NULL, NULL, '2023-09-07 12:10:10.354578', '2023-09-07 12:10:10.354578');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (468, 468, '01.120', '90.012', '70.220', '2023-09-07 12:10:10.391766', '2023-09-07 12:10:10.391766');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (469, 469, '01.120', '90.012', '70.220', '2023-09-07 12:10:10.447427', '2023-09-07 12:10:10.447427');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (470, 470, '01.120', NULL, NULL, '2023-09-07 12:10:10.494082', '2023-09-07 12:10:10.494082');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (471, 471, '01.120', '90.012', NULL, '2023-09-07 12:10:10.537677', '2023-09-07 12:10:10.537677');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (472, 472, '01.120', NULL, NULL, '2023-09-07 12:10:10.588614', '2023-09-07 12:10:10.588614');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (473, 473, '01.120', '90.012', '70.220', '2023-09-07 12:10:10.618879', '2023-09-07 12:10:10.618879');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (474, 474, '01.120', '90.012', NULL, '2023-09-07 12:10:10.648442', '2023-09-07 12:10:10.648442');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (475, 475, '01.120', '90.012', NULL, '2023-09-07 12:10:10.698536', '2023-09-07 12:10:10.698536');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (476, 476, '01.120', '90.012', '70.220', '2023-09-07 12:10:10.727282', '2023-09-07 12:10:10.727282');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (477, 477, '01.120', NULL, NULL, '2023-09-07 12:10:10.775362', '2023-09-07 12:10:10.775362');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (478, 478, '01.120', '90.012', '70.220', '2023-09-07 12:10:10.803143', '2023-09-07 12:10:10.803143');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (479, 479, '01.120', NULL, NULL, '2023-09-07 12:10:10.83638', '2023-09-07 12:10:10.83638');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (480, 480, '01.120', '90.012', '70.220', '2023-09-07 12:10:10.871925', '2023-09-07 12:10:10.871925');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (481, 481, '01.120', NULL, NULL, '2023-09-07 12:10:10.910424', '2023-09-07 12:10:10.910424');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (482, 482, '01.120', '90.012', '70.220', '2023-09-07 12:10:10.93942', '2023-09-07 12:10:10.93942');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (483, 483, '01.120', '90.012', NULL, '2023-09-07 12:10:10.970049', '2023-09-07 12:10:10.970049');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (484, 484, '01.120', '90.012', NULL, '2023-09-07 12:10:11.00518', '2023-09-07 12:10:11.00518');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (485, 485, '01.120', NULL, NULL, '2023-09-07 12:10:11.031097', '2023-09-07 12:10:11.031097');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (486, 486, '01.120', '90.012', NULL, '2023-09-07 12:10:11.077372', '2023-09-07 12:10:11.077372');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (487, 487, '01.120', '90.012', NULL, '2023-09-07 12:10:11.121477', '2023-09-07 12:10:11.121477');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (488, 488, '01.120', NULL, NULL, '2023-09-07 12:10:11.148246', '2023-09-07 12:10:11.148246');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (489, 489, '01.120', '90.012', '70.220', '2023-09-07 12:10:11.18375', '2023-09-07 12:10:11.18375');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (490, 490, '01.120', NULL, NULL, '2023-09-07 12:10:11.217369', '2023-09-07 12:10:11.217369');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (491, 491, '01.120', NULL, NULL, '2023-09-07 12:10:11.261813', '2023-09-07 12:10:11.261813');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (492, 492, '01.120', NULL, NULL, '2023-09-07 12:10:11.2878', '2023-09-07 12:10:11.2878');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (493, 493, '01.120', NULL, NULL, '2023-09-07 12:10:11.326445', '2023-09-07 12:10:11.326445');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (494, 494, '01.120', '90.012', NULL, '2023-09-07 12:10:11.370457', '2023-09-07 12:10:11.370457');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (495, 495, '01.120', '90.012', '70.220', '2023-09-07 12:10:11.404894', '2023-09-07 12:10:11.404894');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (496, 496, '01.120', NULL, NULL, '2023-09-07 12:10:11.447375', '2023-09-07 12:10:11.447375');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (497, 497, '01.120', NULL, NULL, '2023-09-07 12:10:11.491413', '2023-09-07 12:10:11.491413');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (498, 498, '01.120', NULL, NULL, '2023-09-07 12:10:11.537387', '2023-09-07 12:10:11.537387');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (499, 499, '01.120', NULL, NULL, '2023-09-07 12:10:11.570919', '2023-09-07 12:10:11.570919');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (500, 500, '01.120', NULL, NULL, '2023-09-07 12:10:11.613561', '2023-09-07 12:10:11.613561');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (501, 501, '01.120', '90.012', NULL, '2023-09-07 12:10:11.643189', '2023-09-07 12:10:11.643189');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (502, 502, '01.120', '90.012', '70.220', '2023-09-07 12:10:11.697592', '2023-09-07 12:10:11.697592');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (503, 503, '01.120', NULL, NULL, '2023-09-07 12:10:11.732307', '2023-09-07 12:10:11.732307');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (504, 504, '01.120', NULL, NULL, '2023-09-07 12:10:11.760575', '2023-09-07 12:10:11.760575');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (505, 505, '01.120', '90.012', NULL, '2023-09-07 12:10:11.794152', '2023-09-07 12:10:11.794152');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (506, 506, '01.120', NULL, NULL, '2023-09-07 12:10:11.832326', '2023-09-07 12:10:11.832326');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (507, 507, '01.120', '90.012', '70.220', '2023-09-07 12:10:11.877562', '2023-09-07 12:10:11.877562');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (508, 508, '01.120', NULL, NULL, '2023-09-07 12:10:11.920388', '2023-09-07 12:10:11.920388');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (509, 509, '01.120', '90.012', NULL, '2023-09-07 12:10:11.959966', '2023-09-07 12:10:11.959966');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (510, 510, '01.120', '90.012', NULL, '2023-09-07 12:10:12.010419', '2023-09-07 12:10:12.010419');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (511, 511, '01.120', '90.012', '70.220', '2023-09-07 12:10:20.886954', '2023-09-07 12:10:20.886954');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (517, 517, '01.120', '90.012', NULL, '2023-09-07 12:10:21.066579', '2023-09-07 12:10:21.066579');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (518, 518, '01.120', NULL, NULL, '2023-09-07 12:10:21.105611', '2023-09-07 12:10:21.105611');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (519, 519, '01.120', NULL, NULL, '2023-09-07 12:10:21.142897', '2023-09-07 12:10:21.142897');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (520, 520, '01.120', '90.012', NULL, '2023-09-07 12:10:21.168142', '2023-09-07 12:10:21.168142');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (521, 521, '01.120', NULL, NULL, '2023-09-07 12:10:21.207267', '2023-09-07 12:10:21.207267');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (522, 522, '01.120', '90.012', NULL, '2023-09-07 12:10:21.236932', '2023-09-07 12:10:21.236932');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (523, 523, '01.120', '90.012', NULL, '2023-09-07 12:10:21.256702', '2023-09-07 12:10:21.256702');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (524, 524, '01.120', NULL, NULL, '2023-09-07 12:10:21.2816', '2023-09-07 12:10:21.2816');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (525, 525, '01.120', NULL, NULL, '2023-09-07 12:10:21.3173', '2023-09-07 12:10:21.3173');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (526, 526, '01.120', '90.012', '70.220', '2023-09-07 12:10:21.340333', '2023-09-07 12:10:21.340333');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (512, 512, '01.120', NULL, NULL, '2023-09-07 12:10:29.868504', '2023-09-07 12:10:20.932146');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (513, 513, '01.120', NULL, NULL, '2023-09-07 12:10:29.872594', '2023-09-07 12:10:20.957114');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (514, 514, '01.120', '90.012', NULL, '2023-09-07 12:10:29.87698', '2023-09-07 12:10:20.982798');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (515, 515, '01.120', '90.012', NULL, '2023-09-07 12:10:29.880415', '2023-09-07 12:10:21.005111');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (516, 516, '01.120', '90.012', NULL, '2023-09-07 12:10:29.884062', '2023-09-07 12:10:21.03795');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (527, 527, '01.120', '01.110', '70.220', '2023-09-07 12:10:29.886656', '2023-09-07 12:10:21.361133');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (534, 534, '01.120', NULL, NULL, '2023-09-07 12:10:29.937026', '2023-09-07 12:10:29.937026');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (535, 535, '01.120', '90.012', NULL, '2023-09-07 12:10:29.940098', '2023-09-07 12:10:29.940098');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (536, 536, '01.120', NULL, NULL, '2023-09-07 12:10:29.942983', '2023-09-07 12:10:29.942983');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (537, 537, '01.120', NULL, NULL, '2023-09-07 12:10:29.946176', '2023-09-07 12:10:29.946176');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (538, 538, '01.120', NULL, NULL, '2023-09-07 12:10:29.950018', '2023-09-07 12:10:29.950018');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.093275');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.137724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '555555555', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.137724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (6, '892399737', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.137724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '826590600', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.157436');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '831268381', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.178629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '895089382', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.196664');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '853015007', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.220551');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (15, '825079892', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.220551');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (16, '860686834', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.239183');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (17, '874808559', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.239183');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (18, '898523088', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.239183');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (19, '885058584', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.257911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (20, '851282088', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.257911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (21, '877208213', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.257911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (22, '842272409', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.278202');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '829660290', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.278202');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '899090884', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.278202');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (25, '848928047', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.305735');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '871424742', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.305735');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (27, '886017047', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.334365');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '833439299', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.334365');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (29, '897462626', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.334365');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '802345222', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.359621');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (31, '820451130', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.359621');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '831580863', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.359621');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '833761548', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.392675');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '890808319', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.415928');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '823222591', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.415928');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '819370689', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.44113');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '877074185', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.44113');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '877076454', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.465053');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '817705715', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.465053');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '898846403', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.465053');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '873361735', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.483444');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '868944192', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.483444');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '884366382', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.50623');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '802244769', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.50623');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '876487875', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.50623');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '835982972', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.50623');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '895727413', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.529608');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '884201205', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.545344');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '883177876', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.545344');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '867694191', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.545344');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '852811561', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.5669');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '886557526', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.5669');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '876660082', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.5669');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '834218334', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.585507');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '851696278', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.585507');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '879389524', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.614107');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '858910824', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.614107');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '804672944', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.614107');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '863104947', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.634533');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '896697110', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.634533');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '853727860', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.660435');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '802940728', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.660435');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '836011249', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.689448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '842449018', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.689448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '880726000', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.715521');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '848129204', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.736798');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '818713664', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.761395');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '853176413', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.761395');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '823756322', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.761395');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '881363295', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.791673');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '805152073', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.791673');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '825084231', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.806135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '880791986', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.828771');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '852913999', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.828771');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '802850977', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.852844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '841747129', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.852844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '844487259', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.875229');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '890392943', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.875229');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '804733585', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.875229');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '826874776', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.898427');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '814797885', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.898427');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '881250910', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.927917');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '869292565', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.927917');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '891967915', 'VIRKSOMHET', '9', '2023-09-07 12:10:16.953931');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '823567033', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.953931');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '804739623', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.953931');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '809157105', 'VIRKSOMHET', '1', '2023-09-07 12:10:16.978744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '818314307', 'VIRKSOMHET', '2', '2023-09-07 12:10:16.978744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '873865403', 'VIRKSOMHET', '3', '2023-09-07 12:10:16.978744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '872220974', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.005039');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '871740960', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.030931');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '839209391', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.030931');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '845126466', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.030931');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '823308255', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.08742');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '838170047', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.08742');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '898389901', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.150759');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '839244653', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.150759');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '888286666', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.150759');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '818063008', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.29347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '837482396', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.29347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '887156552', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.29347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '806165288', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.29347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '868645574', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.33218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '883595681', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.33218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '814308411', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.33218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '811454092', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.33218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '841274453', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.33218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '876450529', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.33218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '832025086', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.33218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '876040207', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.33218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '808044969', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.393718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '815657103', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.393718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '806207908', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.393718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '863372662', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.422887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '816502624', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.422887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '852986256', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.422887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '853555598', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.422887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '835392717', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.422887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '817070709', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.422887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '810311994', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.458378');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '850022448', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.458378');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '806685779', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.494267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '803687989', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.494267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '853443507', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.494267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '845560676', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.518317');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '827358643', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.541418');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '874825286', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.541418');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '880253499', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.541418');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '835809313', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.575913');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '896901593', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.575913');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '802899775', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.601011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '838961590', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.601011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '892373226', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.633556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '841507581', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.673393');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '861604952', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.727309');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '854358127', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.727309');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '852267877', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.772656');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '847360475', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.772656');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '853302353', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.772656');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '808758602', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.811527');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '881135497', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.811527');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '883221257', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.839923');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '829482164', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.897678');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '856230051', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.897678');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '810249268', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.897678');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '892788724', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.897678');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '840025055', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.930306');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '821348427', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.930306');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '807977696', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.930306');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '879659474', 'VIRKSOMHET', '9', '2023-09-07 12:10:17.930306');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '897882038', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.930306');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '828677735', 'VIRKSOMHET', '1', '2023-09-07 12:10:17.930306');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '879034952', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.973661');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '865949769', 'VIRKSOMHET', '2', '2023-09-07 12:10:17.973661');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '847877290', 'VIRKSOMHET', '3', '2023-09-07 12:10:17.973661');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '850257793', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.0042');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '830101038', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.0042');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '823151420', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.0042');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '809286516', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.0042');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '819145900', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.029964');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '863874454', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.029964');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '884217469', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.029964');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '867258510', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.049493');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '897988683', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.049493');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '844667733', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.071555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '844723188', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.071555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '818141808', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.071555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '859165386', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.094476');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '865504204', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.094476');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '898737040', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.122507');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '891816187', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.122507');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '816256086', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.141961');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '877756065', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.141961');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '828223293', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.141961');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '846339829', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.141961');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '850152691', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.165196');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '890037539', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.165196');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '822458792', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.187345');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '809266951', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.187345');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '899886628', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.187345');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '886901775', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.187345');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '886470266', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.202789');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '811210451', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.202789');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '888988714', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.202789');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '826324969', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.231084');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '807828501', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.253748');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '892008639', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.253748');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '888721551', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.253748');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '879069742', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.283939');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '808964650', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.283939');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '884187399', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.283939');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '824468605', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.31294');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '888257410', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.328466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '854254584', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.328466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '862727618', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.328466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '835427889', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.348264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '820294549', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.348264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '806377882', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.348264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '845531199', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.361318');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '830603806', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.361318');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '804075321', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.387525');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '891705500', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.387525');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '805367803', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.387525');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '883071436', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.411893');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '846197303', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.411893');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '868131855', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.43351');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '811538812', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.43351');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '835595464', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.43351');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '852912939', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.462391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '890193691', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.462391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '834044439', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.4806');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '801308434', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.4806');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '895387215', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.4806');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '803097144', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.508548');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '820460681', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.508548');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '893391635', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.527209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '803964775', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.527209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '830940695', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.527209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '821384683', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.544867');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '816338918', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.544867');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '858327975', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.544867');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '814845704', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.570249');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '807845910', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.570249');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '870936597', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.570249');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '837540796', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.594438');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '865165723', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.594438');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '809257693', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.594438');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '889852300', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.612635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '824510214', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.612635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '878219794', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.612635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '833777549', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.612635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '855806194', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.631059');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '857619997', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.631059');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '855072065', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.631059');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '873994005', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.645818');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '831772492', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.645818');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '859319655', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.663683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '829583457', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.663683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '863035762', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.663683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '818423659', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.689546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '833484882', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.689546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '811684284', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.689546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '879108983', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.706133');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '896403945', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.706133');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '890608443', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.725089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '809234560', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.725089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '860066709', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.725089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '863069895', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.747784');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '822751051', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.747784');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '831730651', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.747784');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '810588854', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.764534');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '889005244', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.780605');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '848905304', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.780605');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '840918223', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.780605');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '837610672', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.780605');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '813600293', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.806732');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '814308550', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.806732');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '875518774', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.827161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '825806596', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.827161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '891741795', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.827161');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '898153558', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.843743');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '808363965', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.843743');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '899444179', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.859454');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '818741759', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.859454');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '804864157', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.882239');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '864337109', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.882239');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '886504008', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.882239');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '862771443', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.898257');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '891584063', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.898257');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '857560571', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.914123');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '839718758', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.914123');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '823097522', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.914123');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '813365991', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.931477');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '804699305', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.931477');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '830939342', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.931477');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '816881589', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.948322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '803971965', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.948322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '874766433', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.948322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '829427942', 'VIRKSOMHET', '9', '2023-09-07 12:10:18.966921');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '865465487', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.966921');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '824353324', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.966921');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '852649392', 'VIRKSOMHET', '3', '2023-09-07 12:10:18.966921');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '819691341', 'VIRKSOMHET', '1', '2023-09-07 12:10:18.983655');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '841800300', 'VIRKSOMHET', '2', '2023-09-07 12:10:18.983655');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '875827788', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.002703');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '873346928', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.002703');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '874317099', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.002703');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '824511321', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.020185');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '893389196', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.020185');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '891901556', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.020185');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '897591139', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.037878');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '821796054', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.050782');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '866749820', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.050782');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '853653798', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.050782');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '810148394', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.070959');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '815156970', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.070959');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '884757541', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.070959');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '898222657', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.070959');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '896030179', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.088329');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '864599907', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.088329');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '809618719', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.122732');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '866797297', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.122732');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '894566254', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.122732');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '847700913', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.158801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '887886764', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.158801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '846277149', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.158801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '832188723', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.158801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '891532355', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.158801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '812694935', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.158801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '827754082', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.191069');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '810338095', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.191069');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '895262637', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.191069');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '876398349', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.217513');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '806767601', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.217513');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '802475579', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.217513');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '883219495', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.217513');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '879154973', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.235008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '827809774', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.235008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '861106891', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.235008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '820860873', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.235008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '833723531', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.235008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '891420050', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.251781');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '881294356', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.251781');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '878113186', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.269129');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '879974330', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.269129');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '802186110', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.269129');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '839798432', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.291532');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '839394527', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.291532');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '822630771', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.291532');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '820632732', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.291532');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '895663536', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.319439');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '810464549', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.319439');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '810038015', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.319439');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '831640932', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.337626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '826636164', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.337626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '871242919', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.356166');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '827203144', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.356166');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '818201399', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.356166');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '842767011', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.388503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '871226849', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.388503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '828877547', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.388503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '803598115', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.417717');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '841405627', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.417717');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '881613172', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.417717');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '856589401', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.437552');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '863700769', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.437552');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '881862150', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.437552');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '817192943', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.45882');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '865004722', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.45882');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '867448417', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.538204');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '849474678', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.538204');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '847693270', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.538204');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '841607636', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.538204');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '807202254', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.552087');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '865346587', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.552087');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '803797113', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.552087');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '859015070', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.552087');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '831988569', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.552087');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '817536912', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.572814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '815652536', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.572814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '820854735', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.572814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '845223389', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.59447');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '822319019', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.59447');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '890009028', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.59447');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '800496904', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.620716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '817109970', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.620716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '895079930', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.620716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '875821555', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.648116');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '850014769', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.648116');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '885587354', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.648116');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '857586849', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.666747');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '839952701', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.666747');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '803031804', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.666747');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '875659837', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.666747');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '832650403', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.666747');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '883770442', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.687501');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '845481784', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.687501');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '854542822', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.715758');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '835249198', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.715758');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '813953566', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.715758');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '850540874', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.715758');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '858828188', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.74128');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '864210989', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.74128');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '839996129', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.74128');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '864263901', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.74128');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '803135962', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.74128');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '870314786', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.763603');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '863760146', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.763603');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '861668570', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.781371');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '830704856', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.781371');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '889855312', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.781371');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '863259727', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.800999');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '840135251', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.800999');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '864494818', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.81549');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '825695325', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.81549');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '836073862', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.867674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '840058730', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.867674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '846660938', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.867674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '898659607', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.867674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '854921842', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.867674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '873055761', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.867674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '805992114', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.867674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '851892457', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.867674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '814941134', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.867674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '888656414', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.887844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '800959797', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.887844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '850493038', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.887844');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '882620191', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.90724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '854180739', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.923721');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '886068919', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.923721');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '833662587', 'VIRKSOMHET', '3', '2023-09-07 12:10:19.938031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '873385075', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.938031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '843099645', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.95491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '825885334', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.974424');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '872228537', 'VIRKSOMHET', '2', '2023-09-07 12:10:19.974424');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '852201319', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.974424');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '890363371', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.998599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '815843495', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.998599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '852930359', 'VIRKSOMHET', '1', '2023-09-07 12:10:19.998599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '837843994', 'VIRKSOMHET', '9', '2023-09-07 12:10:19.998599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '806010146', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.020793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '886905862', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.020793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '835407686', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.020793');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '840931417', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.050787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '867005478', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.050787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '878801449', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.068803');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '892032684', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.068803');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '860955788', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.068803');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '843920371', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.068803');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '882995152', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.092201');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '887827580', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.092201');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '826333991', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.092201');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '867611681', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.092201');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '815182148', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.108308');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '873874881', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.124546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '882455206', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.124546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '845232041', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.124546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '882850737', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.142081');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '865259870', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.142081');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '828007957', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.158603');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '808270377', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.158603');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '851384052', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.158603');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '898600714', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.17709');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '839935652', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.17709');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '810141839', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.191618');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '891333152', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.191618');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '805164879', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.191618');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '824498308', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.203086');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '844282783', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.203086');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '817531159', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.220019');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '855550271', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.24086');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '869652681', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.24086');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '898751589', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.24086');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '878967112', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.24086');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '864003987', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.25582');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '832458613', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.25582');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '806008111', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.25582');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '850214782', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.280144');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '803104220', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.280144');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '850426549', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.296085');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '848391514', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.296085');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '885388008', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.306674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '822821338', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.306674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '822030521', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.306674');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '875874693', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.3293');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '812765101', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.346596');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '838926551', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.346596');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '899799563', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.346596');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '809015209', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.346596');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '820034238', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.368469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '895498055', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.368469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '828601859', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.368469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '801604353', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.368469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '800776323', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.38797');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '844347164', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.38797');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '818219358', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.403084');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '823902704', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.421529');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '883162812', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.421529');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '889910960', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.442073');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '865749324', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.442073');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '850763986', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.459546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '880519699', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.459546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '852625515', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.459546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '861045673', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.476562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '833793182', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.476562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '831330573', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.476562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '861523860', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.491069');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '824098672', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.491069');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '823778083', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.491069');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '809293796', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.511514');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '833398283', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.511514');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '850432266', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.511514');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '881380147', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.550958');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '863782541', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.550958');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '853151041', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.550958');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '802050060', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.575008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '853061189', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.575008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '839895479', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.575008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '850029414', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.575008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '850745866', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.60223');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '862302999', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.641079');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '838387901', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.641079');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '893095117', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.667851');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '891087784', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.692095');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '814614016', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.692095');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '808055576', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.720025');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '807375408', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.720025');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '812020182', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.734145');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '813691924', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.734145');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '889537777', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.734145');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '889923016', 'VIRKSOMHET', '9', '2023-09-07 12:10:20.757276');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '883410497', 'VIRKSOMHET', '3', '2023-09-07 12:10:20.773179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '859214047', 'VIRKSOMHET', '1', '2023-09-07 12:10:20.773179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '899398352', 'VIRKSOMHET', '2', '2023-09-07 12:10:20.773179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '888885608', 'VIRKSOMHET', '9', '2023-09-07 12:10:21.565742');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '886738603', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.584845');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '824252875', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.599747');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '815130751', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.599747');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '807181403', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.599747');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '825701028', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.624131');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '880991109', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.624131');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '863223995', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.624131');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '855193175', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.64466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '851914695', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.64466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '860138637', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.64466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '842209425', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.661906');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '886312075', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.661906');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '806191555', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.661906');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '812570442', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.661906');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '842756602', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.661906');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '864760613', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.67563');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '861707783', 'VIRKSOMHET', '1', '2023-09-07 12:10:21.67563');


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

SELECT pg_catalog.setval('public.siste_publiseringsinfo_id_seq', 8, true);


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

