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
DROP INDEX IF EXISTS public.idx_bransje_sykefravar_statistikk_bransje;
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

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', 'V1__init.sql', 1782034767, 'test', '2023-08-29 15:39:59.468392', 54, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', 'V2__create_virksomhet_adresse.sql', -64248919, 'test', '2023-08-29 15:39:59.584994', 57, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', 'V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2023-08-29 15:39:59.692831', 15, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', 'V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2023-08-29 15:39:59.860283', 16, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', 'V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2023-08-29 15:39:59.915003', 19, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', 'V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2023-08-29 15:39:59.967708', 14, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', 'V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2023-08-29 15:40:00.011031', 17, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', 'V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2023-08-29 15:40:00.060027', 19, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', 'V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2023-08-29 15:40:00.115397', 27, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', 'V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2023-08-29 15:40:00.184522', 21, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', 'V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2023-08-29 15:40:00.243307', 12, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', 'V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2023-08-29 15:40:00.284239', 18, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', 'V13__ia_prosess.sql', -1755516749, 'test', '2023-08-29 15:40:00.338746', 15, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', 'V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2023-08-29 15:40:00.383008', 33, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', 'V15__endre_saknummer.sql', -1379621340, 'test', '2023-08-29 15:40:00.455344', 14, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', 'V16__ia_sak_hendelse.sql', 586872662, 'test', '2023-08-29 15:40:00.49966', 34, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', 'V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2023-08-29 15:40:00.569799', 16, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', 'V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2023-08-29 15:40:00.617308', 24, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', 'V19__legg_til_begrunnelser.sql', 779259005, 'test', '2023-08-29 15:40:00.677705', 19, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', 'V20__legg_til_flere_indekser.sql', -843857404, 'test', '2023-08-29 15:40:00.73244', 30, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', 'V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2023-08-29 15:40:00.794258', 12, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', 'V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2023-08-29 15:40:00.832536', 19, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', 'V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2023-08-29 15:40:00.878513', 18, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', 'V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2023-08-29 15:40:00.923379', 19, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', 'V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2023-08-29 15:40:00.974566', 38, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', 'V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2023-08-29 15:40:01.042334', 15, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', 'V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2023-08-29 15:40:01.095486', 12, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', 'V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2023-08-29 15:40:01.132954', 15, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', 'V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2023-08-29 15:40:01.192801', 15, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', 'V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2023-08-29 15:40:01.239992', 18, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', 'V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2023-08-29 15:40:01.294232', 23, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', 'V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2023-08-29 15:40:01.351275', 15, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', 'V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2023-08-29 15:40:01.395266', 13, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', 'V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2023-08-29 15:40:01.43316', 20, true);
INSERT INTO public.flyway_schema_history VALUES (35, '35', 'drop sykefravar statistikk grunnlag', 'SQL', 'V35__drop_sykefravar_statistikk_grunnlag.sql', 461103825, 'test', '2023-08-29 15:40:01.486993', 16, true);
INSERT INTO public.flyway_schema_history VALUES (36, '36', 'registrere bistand', 'SQL', 'V36__registrere_bistand.sql', -1365283904, 'test', '2023-08-29 15:40:01.541399', 39, true);
INSERT INTO public.flyway_schema_history VALUES (37, '37', 'fullfoert dato leveranse', 'SQL', 'V37__fullfoert_dato_leveranse.sql', 1621470787, 'test', '2023-08-29 15:40:01.620866', 12, true);
INSERT INTO public.flyway_schema_history VALUES (38, '38', 'oppdatere moduler', 'SQL', 'V38__oppdatere_moduler.sql', -246234034, 'test', '2023-08-29 15:40:01.669532', 25, true);
INSERT INTO public.flyway_schema_history VALUES (39, '39', 'rette iatjeneste på modul', 'SQL', 'V39__rette_iatjeneste_på_modul.sql', -1034067650, 'test', '2023-08-29 15:40:01.730108', 13, true);
INSERT INTO public.flyway_schema_history VALUES (40, '40', 'legg til rolle ia sak hendelse', 'SQL', 'V40__legg_til_rolle_ia_sak_hendelse.sql', -82283870, 'test', '2023-08-29 15:40:01.774754', 13, true);
INSERT INTO public.flyway_schema_history VALUES (41, '41', 'legg til rolle ia sak leveranse', 'SQL', 'V41__legg_til_rolle_ia_sak_leveranse.sql', -2029318456, 'test', '2023-08-29 15:40:01.815171', 12, true);
INSERT INTO public.flyway_schema_history VALUES (42, '42', 'legg til deaktivert', 'SQL', 'V42__legg_til_deaktivert.sql', 1170357332, 'test', '2023-08-29 15:40:01.853988', 13, true);
INSERT INTO public.flyway_schema_history VALUES (43, '43', 'siste publiseringsinfo tabell', 'SQL', 'V43__siste_publiseringsinfo_tabell.sql', -1555520829, 'test', '2023-08-29 15:40:01.890545', 14, true);
INSERT INTO public.flyway_schema_history VALUES (44, '44', 'hendelse nav enhet', 'SQL', 'V44__hendelse_nav_enhet.sql', -1118774222, 'test', '2023-08-29 15:40:01.927314', 11, true);
INSERT INTO public.flyway_schema_history VALUES (45, '45', 'oppdatere siste publiseringsinfo', 'SQL', 'V45__oppdatere_siste_publiseringsinfo.sql', -1919960111, 'test', '2023-08-29 15:40:01.963023', 11, true);
INSERT INTO public.flyway_schema_history VALUES (46, '46', 'populer siste publiseringsdato', 'SQL', 'V46__populer_siste_publiseringsdato.sql', 21300723, 'test', '2023-08-29 15:40:01.999829', 18, true);
INSERT INTO public.flyway_schema_history VALUES (47, '47', 'virksomhet naringsundergrupper tabell', 'SQL', 'V47__virksomhet_naringsundergrupper_tabell.sql', 581614507, 'test', '2023-08-29 15:40:02.041413', 18, true);
INSERT INTO public.flyway_schema_history VALUES (48, '48', 'endre oppdateringsdato', 'SQL', 'V48__endre_oppdateringsdato.sql', 855334580, 'test', '2023-08-29 15:40:02.084844', 18, true);
INSERT INTO public.flyway_schema_history VALUES (49, '49', 'sykefravar statistikk bransje tabell', 'SQL', 'V49__sykefravar_statistikk_bransje_tabell.sql', 1439525146, 'test', '2023-08-29 15:40:02.132988', 21, true);
INSERT INTO public.flyway_schema_history VALUES (50, '50', 'endre kode lengde siste 4 kvartal', 'SQL', 'V50__endre_kode_lengde_siste_4_kvartal.sql', 218855534, 'test', '2023-08-29 15:40:02.188762', 15, true);
INSERT INTO public.flyway_schema_history VALUES (51, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 1490298704, 'test', '2023-08-29 15:40:02.241061', 22, true);
INSERT INTO public.flyway_schema_history VALUES (52, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 955744042, 'test', '2023-08-29 15:40:43.59686', 40, true);


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

INSERT INTO public.siste_publiseringsinfo VALUES (1, 2022, 4, '2023-03-02 00:00:00', '2023-06-01 00:00:00', '2023-08-29 15:40:01.899364');
INSERT INTO public.siste_publiseringsinfo VALUES (2, 2023, 1, '2023-06-01 00:00:00', '2023-09-07 00:00:00', '2023-08-29 15:40:01.974004');
INSERT INTO public.siste_publiseringsinfo VALUES (3, 2022, 3, '2022-12-01 00:00:00', '2023-03-02 00:00:00', '2023-08-29 15:40:02.009286');
INSERT INTO public.siste_publiseringsinfo VALUES (4, 2022, 2, '2022-09-08 00:00:00', '2022-12-01 00:00:00', '2023-08-29 15:40:02.009286');
INSERT INTO public.siste_publiseringsinfo VALUES (5, 2022, 1, '2022-06-02 00:00:00', '2022-09-08 00:00:00', '2023-08-29 15:40:02.009286');
INSERT INTO public.siste_publiseringsinfo VALUES (6, 2021, 4, '2022-03-03 00:00:00', '2022-06-02 00:00:00', '2023-08-29 15:40:02.009286');
INSERT INTO public.siste_publiseringsinfo VALUES (7, 2021, 3, '2021-12-02 00:00:00', '2022-03-03 00:00:00', '2023-08-29 15:40:02.009286');


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

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2023, 1, 6, 12.8, 125, 1.5, false, '2023-08-29 15:41:09.974818', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2022, 4, 6, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.01282', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2023, 1, 943, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2022, 4, 943, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '555555555', 2023, 1, 135, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '851137753', 2023, 1, 38, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '851137753', 2022, 4, 38, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '852104530', 2023, 1, 42, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '852104530', 2022, 4, 42, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '807686992', 2023, 1, 42, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '807686992', 2022, 4, 42, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '802398455', 2023, 1, 865, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '802398455', 2022, 4, 865, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '833276442', 2023, 1, 222, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '839258152', 2023, 1, 652, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '807576151', 2023, 1, 403, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '850913244', 2023, 1, 581, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '895920338', 2023, 1, 974, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '836472840', 2023, 1, 976, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '822673392', 2023, 1, 501, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '887128573', 2023, 1, 780, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '850313595', 2023, 1, 384, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.109492', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '826526358', 2023, 1, 216, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.185248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '868229775', 2023, 1, 305, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.185248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '830135417', 2023, 1, 733, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.185248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '861395649', 2023, 1, 812, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.185248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '854415713', 2023, 1, 462, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '862293147', 2023, 1, 928, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '893597205', 2023, 1, 493, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '890770619', 2023, 1, 354, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '860001813', 2023, 1, 6, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '883513987', 2023, 1, 149, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '895897798', 2023, 1, 354, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '881142130', 2023, 1, 735, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '854024937', 2023, 1, 137, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '813141705', 2023, 1, 190, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '828562569', 2023, 1, 929, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '833109464', 2023, 1, 220, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '886747994', 2023, 1, 650, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '848152346', 2023, 1, 805, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '825933759', 2023, 1, 860, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '814690513', 2023, 1, 121, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '851970156', 2023, 1, 8, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '868511260', 2023, 1, 869, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '830016645', 2023, 1, 505, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '855026158', 2023, 1, 937, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.257733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '815935399', 2023, 1, 244, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.31164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '889414930', 2023, 1, 588, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.31164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '880049406', 2023, 1, 711, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.31164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '874394949', 2023, 1, 423, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.31164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '837847297', 2023, 1, 596, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.31164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '883745258', 2023, 1, 476, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.31164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '862454991', 2023, 1, 750, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.31164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '860113451', 2023, 1, 772, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '829554318', 2023, 1, 456, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '822008150', 2023, 1, 73, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '846330108', 2023, 1, 797, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '833112838', 2023, 1, 556, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '872591676', 2023, 1, 792, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '860029289', 2023, 1, 730, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '891988313', 2023, 1, 951, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '810800936', 2023, 1, 642, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '826304723', 2023, 1, 878, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '842368398', 2023, 1, 460, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '800088073', 2023, 1, 376, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '804056780', 2023, 1, 240, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '804071213', 2023, 1, 690, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '820154688', 2023, 1, 485, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '845863731', 2023, 1, 293, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.380055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '883360358', 2023, 1, 515, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.446144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '876784801', 2023, 1, 917, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.446144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '894296991', 2023, 1, 223, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.446144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '811139665', 2023, 1, 44, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.446144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '803395093', 2023, 1, 205, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.446144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '881308154', 2023, 1, 507, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.446144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '858673060', 2023, 1, 544, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '864584378', 2023, 1, 149, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '811805933', 2023, 1, 918, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '843998631', 2023, 1, 457, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '807742610', 2023, 1, 416, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '817024036', 2023, 1, 903, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '894510299', 2023, 1, 73, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '882979718', 2023, 1, 111, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '820922005', 2023, 1, 787, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '802652255', 2023, 1, 50, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '800028335', 2023, 1, 206, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '806830647', 2023, 1, 750, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '875024581', 2023, 1, 55, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '857530854', 2023, 1, 170, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.508337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '868564499', 2023, 1, 750, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.568008', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '891332471', 2023, 1, 426, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.568008', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '869425048', 2023, 1, 934, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.568008', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '876047468', 2023, 1, 659, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.568008', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '873464281', 2023, 1, 372, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.568008', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '801699286', 2023, 1, 562, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '852299828', 2023, 1, 515, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '899052538', 2023, 1, 904, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '884824815', 2023, 1, 270, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '872546768', 2023, 1, 133, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '836460310', 2023, 1, 216, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '830319650', 2023, 1, 864, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '840782943', 2023, 1, 257, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '852197780', 2023, 1, 249, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '800883616', 2023, 1, 79, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '824222593', 2023, 1, 815, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '828229897', 2023, 1, 163, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.612958', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '853872043', 2023, 1, 60, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.680957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '874698776', 2023, 1, 124, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.680957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '864225323', 2023, 1, 392, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.680957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '860689823', 2023, 1, 627, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.680957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '837622686', 2023, 1, 88, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.680957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '830385086', 2023, 1, 613, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.680957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '881748098', 2023, 1, 279, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.716486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '843242787', 2023, 1, 51, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.716486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '858993885', 2023, 1, 932, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.716486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '837367306', 2023, 1, 495, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.716486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '882886632', 2023, 1, 268, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.716486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '836876279', 2023, 1, 377, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.716486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '892895220', 2023, 1, 906, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.716486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '834326743', 2023, 1, 730, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.716486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '882121457', 2023, 1, 680, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.716486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '880716859', 2023, 1, 800, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.716486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '895819799', 2023, 1, 980, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.716486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '880564530', 2023, 1, 153, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.78037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '846886752', 2023, 1, 598, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.78037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '898989109', 2023, 1, 739, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.78037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '800011345', 2023, 1, 263, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.78037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '897397259', 2023, 1, 348, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.78037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '823589360', 2023, 1, 735, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.78037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '800146846', 2023, 1, 620, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.82471', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '832421836', 2023, 1, 87, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.82471', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '832949251', 2023, 1, 68, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.82471', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '863286333', 2023, 1, 841, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.82471', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '879969815', 2023, 1, 392, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.82471', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '860767985', 2023, 1, 588, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.82471', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '844833881', 2023, 1, 302, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.82471', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '801398410', 2023, 1, 521, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.82471', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '883614387', 2023, 1, 261, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.82471', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '816105744', 2023, 1, 815, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.82471', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '878011469', 2023, 1, 339, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.867405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '885803184', 2023, 1, 604, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.867405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '848263054', 2023, 1, 168, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.867405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '897957146', 2023, 1, 485, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.867405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '808478749', 2023, 1, 380, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.867405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '888040470', 2023, 1, 152, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.867405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '834999357', 2023, 1, 51, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.867405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '887207722', 2023, 1, 297, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.867405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '852437784', 2023, 1, 108, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.92597', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '819785097', 2023, 1, 853, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.92597', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '867188209', 2023, 1, 969, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.92597', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '881550924', 2023, 1, 591, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.92597', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '835379695', 2023, 1, 74, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.92597', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '880617782', 2023, 1, 185, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.92597', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '853760011', 2023, 1, 627, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.92597', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '821849235', 2023, 1, 131, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.92597', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '858115062', 2023, 1, 838, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.92597', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '869577747', 2023, 1, 169, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.974249', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '800095119', 2023, 1, 916, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.974249', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '884112569', 2023, 1, 106, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.974249', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '839810200', 2023, 1, 862, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.974249', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '891387618', 2023, 1, 87, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.974249', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '892351179', 2023, 1, 896, 12.8, 125, 1.5, false, '2023-08-29 15:41:10.974249', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '818384717', 2023, 1, 660, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.019642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '815743441', 2023, 1, 906, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.019642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '851397068', 2023, 1, 77, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.019642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '875534564', 2023, 1, 148, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.019642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '801281104', 2023, 1, 872, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.019642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '865687238', 2023, 1, 838, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.019642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '854703296', 2023, 1, 954, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.019642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '878480632', 2023, 1, 670, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.019642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '886814557', 2023, 1, 389, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.019642', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '807657039', 2023, 1, 845, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.059697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '866503879', 2023, 1, 569, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.059697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '879255744', 2023, 1, 644, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.059697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '836040137', 2023, 1, 734, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.059697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '835974207', 2023, 1, 562, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.098296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '868960486', 2023, 1, 810, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.098296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '800922553', 2023, 1, 239, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.098296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '849827380', 2023, 1, 56, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.098296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '813075874', 2023, 1, 289, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.098296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '895048096', 2023, 1, 930, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.098296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '800493742', 2023, 1, 545, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.098296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '896767809', 2023, 1, 60, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.098296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '880634250', 2023, 1, 949, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.141842', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '831707731', 2023, 1, 766, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.141842', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '867072306', 2023, 1, 776, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.141842', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '898091120', 2023, 1, 352, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.141842', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '820345524', 2023, 1, 679, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.141842', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '811514303', 2023, 1, 669, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.182234', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '888227038', 2023, 1, 249, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.182234', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '824351597', 2023, 1, 412, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.182234', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '898909248', 2023, 1, 787, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.182234', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '833801366', 2023, 1, 518, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.182234', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '885444119', 2023, 1, 830, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.182234', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '865794794', 2023, 1, 865, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.182234', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '868806184', 2023, 1, 533, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.182234', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '809005837', 2023, 1, 629, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.231631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '888993141', 2023, 1, 230, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.231631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '855555426', 2023, 1, 800, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.231631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '899843792', 2023, 1, 663, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.231631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '875763838', 2023, 1, 823, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.231631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '897966038', 2023, 1, 663, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.231631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '886073506', 2023, 1, 93, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.278993', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '889870174', 2023, 1, 365, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.278993', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '869904540', 2023, 1, 35, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.278993', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '821894505', 2023, 1, 190, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.278993', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '812212065', 2023, 1, 264, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.278993', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '854723519', 2023, 1, 107, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.38541', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '892918228', 2023, 1, 513, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.38541', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '858126546', 2023, 1, 367, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.38541', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '858394926', 2023, 1, 89, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.38541', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '881372741', 2023, 1, 347, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.464734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '828822894', 2023, 1, 652, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.464734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '804452158', 2023, 1, 386, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.464734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '812803827', 2023, 1, 762, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.464734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '851163302', 2023, 1, 200, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.464734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '887970150', 2023, 1, 560, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.464734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '885228334', 2023, 1, 285, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.464734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '803989289', 2023, 1, 876, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.526473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '885663079', 2023, 1, 402, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.526473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '880836681', 2023, 1, 670, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.526473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '890484231', 2023, 1, 827, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.526473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '876207551', 2023, 1, 957, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.526473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '816635391', 2023, 1, 837, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.526473', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '804710504', 2023, 1, 665, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.567672', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '863736808', 2023, 1, 359, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.567672', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '812752597', 2023, 1, 506, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.567672', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '846383406', 2023, 1, 228, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.567672', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '862716503', 2023, 1, 203, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.567672', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '854308355', 2023, 1, 761, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.606101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '847640744', 2023, 1, 537, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.606101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '858653530', 2023, 1, 695, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.606101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '881633232', 2023, 1, 545, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.606101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '832936423', 2023, 1, 89, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.606101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '868397690', 2023, 1, 870, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.671042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '875009936', 2023, 1, 618, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.671042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '806934151', 2023, 1, 814, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.671042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '873202447', 2023, 1, 729, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.671042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '885786568', 2023, 1, 965, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.671042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '834856113', 2023, 1, 494, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.752012', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '836784911', 2023, 1, 992, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.752012', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '894747218', 2023, 1, 997, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.752012', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '895681992', 2023, 1, 735, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.752012', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '832637622', 2023, 1, 635, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.752012', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '874482558', 2023, 1, 289, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.752012', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '855761730', 2023, 1, 970, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.838246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '820139087', 2023, 1, 135, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.838246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '865386572', 2023, 1, 953, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.838246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '829511734', 2023, 1, 64, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.838246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '811846482', 2023, 1, 57, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.91682', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '854256242', 2023, 1, 706, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.91682', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '865097331', 2023, 1, 156, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.91682', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '876783179', 2023, 1, 181, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.91682', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '899264391', 2023, 1, 223, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.956699', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '894999875', 2023, 1, 725, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.956699', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '816627945', 2023, 1, 666, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.956699', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '864598083', 2023, 1, 908, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.956699', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '840970664', 2023, 1, 771, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.956699', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '827743840', 2023, 1, 286, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.987462', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '827433286', 2023, 1, 478, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.987462', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '847189640', 2023, 1, 26, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.987462', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '831633908', 2023, 1, 48, 12.8, 125, 1.5, false, '2023-08-29 15:41:11.987462', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '867645704', 2023, 1, 298, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.018363', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '812108401', 2023, 1, 886, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.018363', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '889335036', 2023, 1, 145, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.018363', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '844930296', 2023, 1, 694, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.018363', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '851548938', 2023, 1, 333, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.050309', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '874171433', 2023, 1, 71, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.050309', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '867713572', 2023, 1, 591, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.050309', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '813483207', 2023, 1, 293, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.050309', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '805031170', 2023, 1, 450, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.083779', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '862102260', 2023, 1, 876, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.083779', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '816146647', 2023, 1, 788, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.083779', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '848438344', 2023, 1, 809, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.083779', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '816933976', 2023, 1, 694, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.083779', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '882893771', 2023, 1, 777, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.136495', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '885095175', 2023, 1, 426, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.136495', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '820914876', 2023, 1, 255, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.136495', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '819663639', 2023, 1, 297, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.136495', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '887228311', 2023, 1, 667, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.239924', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '832446008', 2023, 1, 637, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.239924', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '813258210', 2023, 1, 343, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.239924', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '888116513', 2023, 1, 472, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.239924', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '875730862', 2023, 1, 801, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.239924', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '848841245', 2023, 1, 825, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.307248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '841256069', 2023, 1, 106, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.307248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '805207537', 2023, 1, 717, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.307248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '818993953', 2023, 1, 900, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.307248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '831454006', 2023, 1, 67, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.307248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '883416962', 2023, 1, 437, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.307248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '809416939', 2023, 1, 467, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.307248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '813799118', 2023, 1, 762, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.307248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '863491262', 2023, 1, 773, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.307248', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '867056903', 2023, 1, 363, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.365854', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '885874897', 2023, 1, 610, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.365854', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '889159375', 2023, 1, 27, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.365854', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '888451869', 2023, 1, 741, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.365854', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '891420733', 2023, 1, 876, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.405601', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '896940956', 2023, 1, 958, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.405601', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '827161001', 2023, 1, 713, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.405601', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '843998028', 2023, 1, 765, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.405601', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '832385490', 2023, 1, 373, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.405601', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '828970725', 2023, 1, 684, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.405601', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '884294930', 2023, 1, 667, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.405601', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '884539162', 2023, 1, 466, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.405601', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '839707107', 2023, 1, 906, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.405601', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '857501205', 2023, 1, 24, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.450418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '892829715', 2023, 1, 998, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.450418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '835144465', 2023, 1, 259, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.450418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '833673063', 2023, 1, 679, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.450418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '893494597', 2023, 1, 122, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.503683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '831839631', 2023, 1, 84, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.503683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '857180192', 2023, 1, 247, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.503683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '802650881', 2023, 1, 321, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.503683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '842224053', 2023, 1, 493, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.503683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '886538999', 2023, 1, 379, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.503683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '819435752', 2023, 1, 669, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.503683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '824307021', 2023, 1, 172, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.503683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '875204204', 2023, 1, 764, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.544087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '879284008', 2023, 1, 813, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.544087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '803494974', 2023, 1, 270, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.544087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '809317616', 2023, 1, 929, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.544087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '839093982', 2023, 1, 168, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.544087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '801964879', 2023, 1, 64, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.544087', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '870320690', 2023, 1, 487, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.586229', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '834707050', 2023, 1, 332, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.586229', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '802466699', 2023, 1, 166, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.586229', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '801062547', 2023, 1, 68, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.586229', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '821343665', 2023, 1, 531, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.586229', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '817936779', 2023, 1, 18, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.586229', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '877671658', 2023, 1, 431, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.586229', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '819018936', 2023, 1, 426, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.624183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '800286721', 2023, 1, 354, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.624183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '825254008', 2023, 1, 653, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.624183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '850450265', 2023, 1, 756, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.624183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '886304033', 2023, 1, 16, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.624183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '811041360', 2023, 1, 512, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.624183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '817484495', 2023, 1, 989, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.624183', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '896259714', 2023, 1, 620, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.66521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '877179757', 2023, 1, 652, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.66521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '880502805', 2023, 1, 211, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.66521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '864532427', 2023, 1, 611, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.66521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '865196110', 2023, 1, 714, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.66521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '890377554', 2023, 1, 658, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.66521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '890477159', 2023, 1, 347, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.66521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '868311985', 2023, 1, 65, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.66521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '881487654', 2023, 1, 533, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.66521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '819222250', 2023, 1, 643, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.692832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '806628725', 2023, 1, 49, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.692832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '883691516', 2023, 1, 392, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.692832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '812745366', 2023, 1, 223, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.692832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '829741575', 2023, 1, 134, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.692832', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '874898152', 2023, 1, 285, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.714826', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '817852775', 2023, 1, 506, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.714826', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '809591404', 2023, 1, 608, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.714826', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '832352774', 2023, 1, 717, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.714826', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '838346408', 2023, 1, 709, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.714826', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '885516480', 2023, 1, 82, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.743725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '849774021', 2023, 1, 960, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.743725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '850986342', 2023, 1, 474, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.777497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '808083042', 2023, 1, 643, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.777497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '802046791', 2023, 1, 536, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.777497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '875562853', 2023, 1, 871, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.777497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '845556525', 2023, 1, 765, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.777497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '897253649', 2023, 1, 283, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.797765', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '864262533', 2023, 1, 207, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.797765', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '885952882', 2023, 1, 707, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.797765', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '840097094', 2023, 1, 745, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.797765', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '879243879', 2023, 1, 774, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.81906', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '844075519', 2023, 1, 630, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.81906', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '866317127', 2023, 1, 346, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.850509', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '840082452', 2023, 1, 413, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.850509', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '898206411', 2023, 1, 576, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.850509', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '832564050', 2023, 1, 119, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.850509', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '836673562', 2023, 1, 941, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.888244', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '878495762', 2023, 1, 114, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.888244', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '853514048', 2023, 1, 912, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.888244', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '809198051', 2023, 1, 122, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.888244', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '815803212', 2023, 1, 146, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.888244', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '823868580', 2023, 1, 527, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.921974', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '856809969', 2023, 1, 328, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.921974', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '806197095', 2023, 1, 648, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.921974', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '875088087', 2023, 1, 899, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.921974', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '823976707', 2023, 1, 601, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.950474', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '817220330', 2023, 1, 819, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.950474', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '891478088', 2023, 1, 232, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.950474', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '868019564', 2023, 1, 202, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.986453', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '816244312', 2023, 1, 418, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.986453', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '860191016', 2023, 1, 680, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.986453', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '833832924', 2023, 1, 620, 12.8, 125, 1.5, false, '2023-08-29 15:41:12.986453', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '880961071', 2023, 1, 607, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.019256', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '895091858', 2023, 1, 313, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.019256', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '883079881', 2023, 1, 236, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.019256', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '853367104', 2023, 1, 444, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.019256', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '828309280', 2023, 1, 228, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.019256', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '887350417', 2023, 1, 878, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.054876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '832030436', 2023, 1, 219, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.054876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '827350744', 2023, 1, 446, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.054876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '886411231', 2023, 1, 733, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.054876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '817560052', 2023, 1, 559, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.054876', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '835317170', 2023, 1, 929, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.084843', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '841420446', 2023, 1, 566, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.084843', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '820358357', 2023, 1, 552, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.084843', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '846038499', 2023, 1, 317, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.084843', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '807597881', 2023, 1, 468, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.084843', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '878937891', 2023, 1, 677, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.123144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '853362787', 2023, 1, 53, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.123144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '829594073', 2023, 1, 523, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.123144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '880327539', 2023, 1, 336, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.123144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '830152078', 2023, 1, 177, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.123144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '885606403', 2023, 1, 170, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.123144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '876914756', 2023, 1, 94, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.160016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '825345571', 2023, 1, 129, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.160016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '897110971', 2023, 1, 816, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.160016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '828171064', 2023, 1, 22, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.160016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '839200091', 2023, 1, 330, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.160016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '800828122', 2023, 1, 775, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.160016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '820448355', 2023, 1, 907, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.192443', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '827162708', 2023, 1, 533, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.192443', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '818072316', 2023, 1, 473, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.192443', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '880683442', 2023, 1, 930, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.192443', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '839857951', 2023, 1, 797, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.192443', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '861172682', 2023, 1, 848, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.192443', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '832468180', 2023, 1, 201, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.192443', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '835288541', 2023, 1, 189, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.228496', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '895916424', 2023, 1, 462, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.228496', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '884908020', 2023, 1, 440, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.228496', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '862637850', 2023, 1, 335, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.228496', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '867225512', 2023, 1, 365, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.228496', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '867401631', 2023, 1, 873, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.228496', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '877300206', 2023, 1, 389, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.228496', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '840496436', 2023, 1, 733, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.26039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '819305793', 2023, 1, 243, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.26039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '873601335', 2023, 1, 920, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.26039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '841551914', 2023, 1, 99, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.26039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '805115619', 2023, 1, 24, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.26039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '856407982', 2023, 1, 534, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.26039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '807229158', 2023, 1, 61, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.26039', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '845910088', 2023, 1, 192, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.292341', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '893522201', 2023, 1, 135, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.292341', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '839225416', 2023, 1, 339, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.292341', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '892994223', 2023, 1, 724, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.292341', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '824608397', 2023, 1, 309, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.292341', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '830789314', 2023, 1, 569, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.292341', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '820111150', 2023, 1, 729, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.292341', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '845783635', 2023, 1, 451, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.322167', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '871562531', 2023, 1, 598, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.322167', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '815764078', 2023, 1, 11, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.322167', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '803431336', 2023, 1, 505, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.322167', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '881518598', 2023, 1, 122, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.322167', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '880282542', 2023, 1, 728, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.322167', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '878982724', 2023, 1, 368, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.35296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '858422935', 2023, 1, 652, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.35296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '852270662', 2023, 1, 523, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.35296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '877943225', 2023, 1, 567, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.35296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '894353446', 2023, 1, 72, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.35296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '843899480', 2023, 1, 824, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.439284', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '864291871', 2023, 1, 56, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.439284', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '871725956', 2023, 1, 220, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.439284', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '852516782', 2023, 1, 182, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.439284', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '869347173', 2023, 1, 734, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.439284', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '822984515', 2023, 1, 828, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.507683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '820967644', 2023, 1, 295, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.507683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '812040694', 2023, 1, 319, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.507683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '812596296', 2023, 1, 930, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.507683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '825796909', 2023, 1, 23, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.507683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '888220534', 2023, 1, 664, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.507683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '828546683', 2023, 1, 259, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.549102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '888888152', 2023, 1, 558, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.549102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '806544734', 2023, 1, 777, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.549102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '861855954', 2023, 1, 292, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.549102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '826747324', 2023, 1, 251, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.549102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '823421563', 2023, 1, 878, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.549102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '864279810', 2023, 1, 728, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.549102', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '815059394', 2023, 1, 902, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.612555', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '800677974', 2023, 1, 459, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.612555', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '869709608', 2023, 1, 173, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.612555', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '837340038', 2023, 1, 291, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.65186', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '878196649', 2023, 1, 577, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.65186', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '855021005', 2023, 1, 266, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.65186', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '842874686', 2023, 1, 13, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.698322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '897678406', 2023, 1, 455, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.698322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '822440491', 2023, 1, 928, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.725986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '895236942', 2023, 1, 489, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.725986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '873250306', 2023, 1, 94, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.725986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '896136191', 2023, 1, 745, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.725986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '830923847', 2023, 1, 941, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.766302', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '839016903', 2023, 1, 981, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.766302', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '840910627', 2023, 1, 986, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.803685', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '826212807', 2023, 1, 447, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.803685', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '830146348', 2023, 1, 288, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.803685', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '865855341', 2023, 1, 555, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.803685', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '813254974', 2023, 1, 268, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.803685', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '878458400', 2023, 1, 411, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.803685', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '819718155', 2023, 1, 94, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.837337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '840048395', 2023, 1, 617, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.837337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '817049990', 2023, 1, 12, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.837337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '823217376', 2023, 1, 57, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.837337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '814797335', 2023, 1, 437, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.837337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '863017059', 2023, 1, 819, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.837337', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '829272494', 2023, 1, 278, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.866143', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '821621583', 2023, 1, 827, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.866143', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '808719782', 2023, 1, 734, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.866143', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '805762106', 2023, 1, 615, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.926773', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '823603319', 2023, 1, 989, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.926773', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '824698886', 2023, 1, 982, 12.8, 125, 1.5, false, '2023-08-29 15:41:13.926773', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '829645138', 2023, 1, 752, 12.8, 125, 1.5, false, '2023-08-29 15:41:14.027049', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '826280365', 2023, 1, 118, 12.8, 125, 1.5, false, '2023-08-29 15:41:14.027049', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '840922156', 2023, 1, 693, 12.8, 125, 1.5, false, '2023-08-29 15:41:14.06161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '869270642', 2023, 1, 727, 12.8, 125, 1.5, false, '2023-08-29 15:41:14.06161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '846201495', 2023, 1, 530, 12.8, 125, 1.5, false, '2023-08-29 15:41:14.06161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '895595058', 2023, 1, 136, 12.8, 125, 1.5, false, '2023-08-29 15:41:14.06161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '880255752', 2023, 1, 159, 12.8, 125, 1.5, false, '2023-08-29 15:41:14.06161', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '883516756', 2023, 1, 52, 12.8, 125, 1.5, false, '2023-08-29 15:41:14.095922', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '823825914', 2023, 1, 521, 12.8, 125, 1.5, false, '2023-08-29 15:41:20.871582', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '891494743', 2023, 1, 945, 12.8, 125, 1.5, false, '2023-08-29 15:41:20.894886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '866996950', 2023, 1, 35, 12.8, 125, 1.5, false, '2023-08-29 15:41:20.932517', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '878276775', 2023, 1, 146, 12.8, 125, 1.5, false, '2023-08-29 15:41:20.932517', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '835631853', 2023, 1, 729, 12.8, 125, 1.5, false, '2023-08-29 15:41:20.932517', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '804345056', 2023, 1, 137, 12.8, 125, 1.5, false, '2023-08-29 15:41:20.967528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '863529173', 2023, 1, 980, 12.8, 125, 1.5, false, '2023-08-29 15:41:20.967528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '873351078', 2023, 1, 441, 12.8, 125, 1.5, false, '2023-08-29 15:41:20.967528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '881715947', 2023, 1, 402, 12.8, 125, 1.5, false, '2023-08-29 15:41:20.967528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '812300486', 2023, 1, 409, 12.8, 125, 1.5, false, '2023-08-29 15:41:21.088508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '819978335', 2023, 1, 112, 12.8, 125, 1.5, false, '2023-08-29 15:41:21.088508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '800406757', 2023, 1, 751, 12.8, 125, 1.5, false, '2023-08-29 15:41:21.088508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '893603727', 2023, 1, 273, 12.8, 125, 1.5, false, '2023-08-29 15:41:21.088508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '803556311', 2023, 1, 276, 12.8, 125, 1.5, false, '2023-08-29 15:41:21.088508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '881416980', 2023, 1, 268, 12.8, 125, 1.5, false, '2023-08-29 15:41:21.088508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '879409878', 2023, 1, 462, 12.8, 125, 1.5, false, '2023-08-29 15:41:21.088508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '864176730', 2023, 1, 111, 12.8, 125, 1.5, false, '2023-08-29 15:41:21.088508', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '857464841', 2023, 1, 867, 12.8, 125, 1.5, false, '2023-08-29 15:41:21.21659', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 4315.54733360141, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.007151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 8433.77196354516, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '555555555', 2628.64500637307, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '851137753', 4725.162753329, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '852104530', 55.5537537525788, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '807686992', 2395.65417659004, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '802398455', 820.248206012114, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '833276442', 7852.55890773938, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '839258152', 5128.63752627858, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '807576151', 4611.0876436625, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '850913244', 3777.3473406388, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '895920338', 5097.69068568016, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '836472840', 7715.57237688136, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '822673392', 9794.71807860521, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '887128573', 1064.53447255191, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '850313595', 1454.04415675079, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.057988');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '826526358', 1506.14923904036, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.173773');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '868229775', 9506.62987951964, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.173773');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '830135417', 1949.44500597224, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.173773');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '861395649', 5135.02448734634, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.173773');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '854415713', 7916.37995870741, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '862293147', 7391.01293272534, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '893597205', 1587.60762531857, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '890770619', 2384.18865280113, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '860001813', 88.6280122091372, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '883513987', 286.724721105867, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '895897798', 9878.79465802411, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '881142130', 7419.57699095408, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '854024937', 4103.76439404969, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '813141705', 1118.82100684806, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '828562569', 6653.5365009059, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '833109464', 7382.44101905221, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '886747994', 7526.94384754058, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '848152346', 9100.73493663583, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '825933759', 3361.73998259939, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '814690513', 778.551742025208, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '851970156', 8499.06915432258, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '868511260', 5357.56719202758, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '830016645', 189.817996202051, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '855026158', 7541.04087477025, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.226549');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '815935399', 2287.51100357913, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.300582');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '889414930', 2390.3372364306, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.300582');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '880049406', 7261.31914562958, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.300582');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '874394949', 5412.11164555425, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.300582');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '837847297', 8506.37421758025, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.300582');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '883745258', 2548.47668552862, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.300582');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '862454991', 9226.99247412294, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.300582');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '860113451', 7905.78736200967, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '829554318', 4499.61638793995, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '822008150', 4252.8051631708, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '846330108', 5841.23176315229, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '833112838', 981.121468030996, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '872591676', 8118.22768461127, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '860029289', 9714.24013330033, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '891988313', 7558.06460685214, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '810800936', 5318.04300632532, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '826304723', 8512.68705379685, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '842368398', 318.176119752469, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '800088073', 2519.7549554585, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '804056780', 5749.47811448338, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '804071213', 3140.78661968756, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '820154688', 2134.52525356885, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '845863731', 7428.44960314937, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.352722');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '883360358', 4763.53210192631, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.427761');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '876784801', 5340.11842927679, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.427761');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '894296991', 5346.91298262617, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.427761');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '811139665', 9035.35467390712, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.427761');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '803395093', 7573.46779834199, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.427761');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '881308154', 9966.6478533614, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.427761');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '858673060', 8760.00670007481, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '864584378', 5520.64709424876, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '811805933', 4290.21031807995, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '843998631', 1703.39464927858, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '807742610', 2549.03475787444, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '817024036', 718.279759182843, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '894510299', 4889.4336953004, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '882979718', 9819.75964945833, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '820922005', 6839.68687993688, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '802652255', 941.956724823827, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '800028335', 8058.77256189963, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '806830647', 2154.02465645751, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '875024581', 2834.59746503529, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '857530854', 9236.91223281362, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.490088');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '868564499', 3909.17237673595, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.553919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '891332471', 3786.4182211477, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.553919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '869425048', 8693.84120966434, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.553919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '876047468', 752.010646214894, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.553919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '873464281', 1952.90351377143, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.553919');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '801699286', 7891.17161309426, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '852299828', 1014.84104106819, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '899052538', 5830.5944140857, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '884824815', 8732.25588460287, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '872546768', 29.3999135028066, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '836460310', 3505.92934695052, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '830319650', 7368.50033592609, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '840782943', 9403.6687131052, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '852197780', 9948.37916089754, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '800883616', 1666.90173887491, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '824222593', 3983.80132644716, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '828229897', 2392.76723599393, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.595302');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '853872043', 7786.58770589922, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.665448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '874698776', 9166.72408318778, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.665448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '864225323', 6339.16346223507, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.665448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '860689823', 4915.6468711507, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.665448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '837622686', 502.406492966757, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.665448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '830385086', 5624.94981706227, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.665448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '881748098', 9207.87613505331, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.703151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '843242787', 9171.53642179154, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.703151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '858993885', 8963.95589513388, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.703151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '837367306', 1245.78243313097, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.703151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '882886632', 8494.73913662919, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.703151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '836876279', 2330.79235328387, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.703151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '892895220', 5964.06557880466, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.703151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '834326743', 341.115011196187, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.703151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '882121457', 7170.65306312297, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.703151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '880716859', 3091.35028040236, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.703151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '895819799', 7367.25901674077, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.703151');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '880564530', 5745.69297596188, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.760829');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '846886752', 618.510115852062, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.760829');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '898989109', 9686.81134657623, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.760829');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '800011345', 5041.56148664286, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.760829');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '897397259', 7564.47042503358, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.760829');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '823589360', 3947.20795266851, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.760829');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '800146846', 3522.21703915133, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.807971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '832421836', 3381.92796917204, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.807971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '832949251', 6334.3604889693, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.807971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '863286333', 3454.3092275787, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.807971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '879969815', 6105.57894486293, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.807971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '860767985', 3312.04974929642, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.807971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '844833881', 5301.7597548386, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.807971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '801398410', 5141.74740185736, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.807971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '883614387', 1942.32988214224, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.807971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '816105744', 2506.5073574746, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.807971');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '878011469', 6746.70133244092, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.854808');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '885803184', 2131.85183862342, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.854808');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '848263054', 8529.18036449571, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.854808');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '897957146', 2183.41622710793, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.854808');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '808478749', 1588.6583787777, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.854808');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '888040470', 2585.01329696817, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.854808');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '834999357', 641.100348291096, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.854808');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '887207722', 3872.29320139846, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.854808');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '852437784', 135.032883936894, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.911951');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '819785097', 812.11375455705, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.911951');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '867188209', 1076.56345535041, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.911951');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '881550924', 6889.01268605794, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.911951');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '835379695', 8028.32068679389, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.911951');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '880617782', 2346.01785359459, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.911951');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '853760011', 9581.72323281217, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.911951');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '821849235', 8175.31934142966, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.911951');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '858115062', 9809.41343701906, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.911951');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '869577747', 1983.51644791438, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.962008');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '800095119', 6467.28716968681, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.962008');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '884112569', 3953.89421770573, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.962008');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '839810200', 2864.15793718481, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.962008');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '891387618', 7086.41953375394, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.962008');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '892351179', 834.941368779089, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:10.962008');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '818384717', 1625.49276757466, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.001064');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '815743441', 5044.65986786273, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.001064');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '851397068', 4705.83760744014, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.001064');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '875534564', 9986.72843985768, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.001064');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '801281104', 1849.314928306, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.001064');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '865687238', 1841.02266214791, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.001064');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '854703296', 3836.29148049594, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.001064');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '878480632', 6911.82380137287, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.001064');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '886814557', 9453.2335786292, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.001064');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '807657039', 1747.6132294152, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.051224');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '866503879', 5175.17504719564, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.051224');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '879255744', 9211.95173481875, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.051224');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '836040137', 671.829536692341, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.051224');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '835974207', 485.857644491806, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.084705');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '868960486', 5750.86561690946, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.084705');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '800922553', 6451.78288779196, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.084705');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '849827380', 3730.87547825803, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.084705');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '813075874', 7391.58135166483, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.084705');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '895048096', 8257.80336581055, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.084705');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '800493742', 6156.68079910127, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.084705');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '896767809', 3204.00152197172, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.084705');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '880634250', 8542.81455064015, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.128667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '831707731', 2991.60470055763, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.128667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '867072306', 1031.03077549829, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.128667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '898091120', 8462.84450663762, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.128667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '820345524', 4714.69139243907, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.128667');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '811514303', 7866.83201332636, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.169367');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '888227038', 2041.12402886874, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.169367');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '824351597', 3539.71217364748, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.169367');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '898909248', 2495.48811242834, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.169367');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '833801366', 6045.98059177825, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.169367');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '885444119', 7194.0543695111, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.169367');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '865794794', 7601.52177932897, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.169367');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '868806184', 9072.7863432563, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.169367');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '809005837', 3243.70960213522, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.221245');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '888993141', 5848.22732889918, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.221245');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '855555426', 2727.44168471381, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.221245');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '899843792', 3892.38238842091, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.221245');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '875763838', 5256.96981193044, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.221245');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '897966038', 2122.78972853834, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.221245');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '886073506', 3266.49658459076, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.25849');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '889870174', 9992.6258202017, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.25849');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '869904540', 1273.30106147415, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.25849');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '821894505', 5456.70691251937, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.25849');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '812212065', 1653.2517508598, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.25849');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '854723519', 7642.46022805128, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.362214');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '892918228', 6793.23846199588, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.362214');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '858126546', 7307.79021099175, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.362214');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '858394926', 6558.86625101132, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.362214');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '881372741', 2800.23322856908, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.43606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '828822894', 8127.60041941877, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.43606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '804452158', 5387.41682819793, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.43606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '812803827', 3015.43841953125, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.43606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '851163302', 7121.98201034235, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.43606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '887970150', 9042.83290893109, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.43606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '885228334', 1882.73806566792, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.43606');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '803989289', 6965.61927271551, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.513838');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '885663079', 4926.8061771656, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.513838');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '880836681', 218.247068924768, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.513838');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '890484231', 9228.43575312361, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.513838');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '876207551', 1691.35973416344, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.513838');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '816635391', 5270.73684945801, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.513838');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '804710504', 8281.14125768246, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.555339');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '863736808', 3078.65896417206, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.555339');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '812752597', 1075.91441846809, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.555339');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '846383406', 8002.83754899237, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.555339');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '862716503', 9634.34012663661, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.555339');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '854308355', 6274.2057683087, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.593763');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '847640744', 4445.51457442594, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.593763');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '858653530', 2470.06746916152, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.593763');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '881633232', 5182.03861587975, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.593763');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '832936423', 6350.42209488021, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.593763');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '868397690', 213.043189197361, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.647043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '875009936', 5847.16307250974, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.647043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '806934151', 6614.81208588391, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.647043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '873202447', 9572.55919176155, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.647043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '885786568', 9322.61611113598, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.647043');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '834856113', 5608.57912527102, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.730945');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '836784911', 6843.36752533474, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.730945');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '894747218', 5255.37570862882, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.730945');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '895681992', 7821.98192673343, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.730945');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '832637622', 3724.48347577896, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.730945');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '874482558', 8970.14184614859, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.730945');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '855761730', 7952.45074293442, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.821474');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '820139087', 367.769880503244, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.821474');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '865386572', 6135.41042630486, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.821474');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '829511734', 6208.12669600926, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.821474');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '811846482', 6351.00956993097, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.905718');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '854256242', 7248.92779619751, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.905718');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '865097331', 6254.75829971226, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.905718');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '876783179', 453.403683812625, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.905718');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '899264391', 9693.67571807543, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.94116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '894999875', 9198.98037052015, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.94116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '816627945', 1185.8454068004, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.94116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '864598083', 6066.2128337316, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.94116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '840970664', 1737.76418672748, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.94116');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '827743840', 8845.3467297844, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.981488');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '827433286', 6981.14730702323, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.981488');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '847189640', 4772.59868764899, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.981488');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '831633908', 5670.81805682782, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:11.981488');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '867645704', 2949.42662427853, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.010459');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '812108401', 7946.9026943612, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.010459');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '889335036', 1462.09546276219, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.010459');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '844930296', 8061.26693656693, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.010459');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '851548938', 9749.61318499823, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.038486');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '874171433', 3116.69496777918, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.038486');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '867713572', 9564.27072339626, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.038486');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '813483207', 1941.38372162502, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.038486');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '805031170', 3148.28553517027, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.073962');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '862102260', 5330.17924378341, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.073962');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '816146647', 4538.23542662528, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.073962');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '848438344', 7133.18860179601, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.073962');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '816933976', 5441.41899284648, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.073962');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '882893771', 8368.67459878773, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.130602');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '885095175', 4676.1702653361, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.130602');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '820914876', 9271.38196790133, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.130602');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '819663639', 1190.48461930043, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.130602');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '887228311', 3007.13101076873, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.186251');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '832446008', 8589.22115754427, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.186251');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '813258210', 4794.52662536485, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.186251');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '888116513', 8002.09599178679, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.186251');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '875730862', 2469.36213353712, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.186251');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '848841245', 8151.09198173985, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.28719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '841256069', 5607.00480222211, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.28719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '805207537', 1372.03603966677, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.28719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '818993953', 8337.93769395138, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.28719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '831454006', 6258.93305727496, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.28719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '883416962', 7832.95562864552, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.28719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '809416939', 3023.11897690753, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.28719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '813799118', 4119.84504383712, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.28719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '863491262', 3756.932666704, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.28719');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '867056903', 7171.94918177364, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.354579');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '885874897', 2053.83916201319, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.354579');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '889159375', 9594.2727559848, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.354579');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '888451869', 1529.43240770631, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.354579');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '891420733', 1070.10777138116, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.392396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '896940956', 7896.66201602737, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.392396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '827161001', 2307.62734151775, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.392396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '843998028', 456.185252232784, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.392396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '832385490', 8825.05579667451, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.392396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '828970725', 5051.08394129159, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.392396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '884294930', 5749.68795818678, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.392396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '884539162', 1916.17071726795, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.392396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '839707107', 6612.24576838661, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.392396');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '857501205', 296.045401884723, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.438713');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '892829715', 5069.67901678591, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.438713');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '835144465', 8542.96369339051, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.438713');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '833673063', 2398.67862265677, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.438713');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '893494597', 1881.113996273, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.48678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '831839631', 6987.89466717991, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.48678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '857180192', 7688.79619973348, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.48678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '802650881', 2606.42046824205, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.48678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '842224053', 3221.33535925226, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.48678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '886538999', 5761.7139692122, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.48678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '819435752', 834.467220701144, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.48678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '824307021', 4666.13783595782, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.48678');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '875204204', 6304.09460471041, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.535666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '879284008', 1504.21352609046, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.535666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '803494974', 1684.26400137805, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.535666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '809317616', 9688.5757612175, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.535666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '839093982', 1207.57272562284, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.535666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '801964879', 3548.31276169279, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.535666');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '870320690', 2460.67761707354, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.567283');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '834707050', 362.797893717207, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.567283');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '802466699', 9581.54081245939, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.567283');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '801062547', 1834.69943026313, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.567283');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '821343665', 1607.67318908122, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.567283');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '817936779', 6874.73939985502, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.567283');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '877671658', 3328.45881222952, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.567283');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '819018936', 3282.16897365659, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.615609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '800286721', 4015.87257090616, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.615609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '825254008', 108.671013209686, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.615609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '850450265', 1768.55626641299, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.615609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '886304033', 5602.88495330884, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.615609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '811041360', 9813.00568234236, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.615609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '817484495', 4877.10619288836, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.615609');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '896259714', 164.211573491869, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.648984');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '877179757', 4155.8219494721, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.648984');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '880502805', 4131.86535707784, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.648984');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '864532427', 1334.7241791496, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.648984');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '865196110', 1273.56535411782, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.648984');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '890377554', 9159.74007781826, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.648984');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '890477159', 2061.57103477001, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.648984');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '868311985', 7161.23454447945, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.648984');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '881487654', 9320.11188466561, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.648984');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '819222250', 8388.24376492117, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.685175');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '806628725', 9956.67947937351, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.685175');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '883691516', 8561.06542669301, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.685175');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '812745366', 4872.25023978617, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.685175');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '829741575', 4517.16828408373, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.685175');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '874898152', 2076.84405572497, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.705576');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '817852775', 121.381249175958, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.705576');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '809591404', 8674.89735519354, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.705576');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '832352774', 46.8523263879465, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.705576');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '838346408', 7939.76915014833, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.705576');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '885516480', 2787.90289453843, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.738059');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '849774021', 9314.41618396351, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.738059');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '850986342', 7623.57423660205, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.762448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '808083042', 4666.45926425141, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.762448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '802046791', 7286.53155841664, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.762448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '875562853', 8193.94635945586, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.762448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '845556525', 6305.4103659208, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.762448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '897253649', 5824.51847862041, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.791111');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '864262533', 9697.11051912771, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.791111');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '885952882', 6896.19703461558, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.791111');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '840097094', 7725.80422790999, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.791111');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '879243879', 5267.75944060654, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.812094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '844075519', 9671.87361851432, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.812094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '866317127', 2704.30716807174, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.843682');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '840082452', 2867.37138135729, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.843682');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '898206411', 9950.96888110186, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.843682');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '832564050', 8407.65077791299, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.843682');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '836673562', 3886.56885805714, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.87672');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '878495762', 6136.41531289267, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.87672');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '853514048', 2221.01997902028, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.87672');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '809198051', 4436.99418006702, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.87672');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '815803212', 6076.96907007118, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.87672');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '823868580', 8774.53917145367, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.914126');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '856809969', 7188.52199752038, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.914126');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '806197095', 8093.96152536292, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.914126');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '875088087', 5853.31056722434, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.914126');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '823976707', 569.639449563933, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.944148');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '817220330', 636.621307690025, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.944148');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '891478088', 7379.48332417233, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.944148');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '868019564', 5399.8975702273, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.976197');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '816244312', 2206.6044803171, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.976197');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '860191016', 1263.2990869578, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.976197');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '833832924', 8946.94680165301, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:12.976197');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '880961071', 5261.60299699679, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.01104');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '895091858', 3653.32424054135, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.01104');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '883079881', 1945.75454798706, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.01104');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '853367104', 6767.5611289183, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.01104');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '828309280', 6490.02811500943, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.01104');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '887350417', 6271.84077936591, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.046786');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '832030436', 9274.4713022745, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.046786');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '827350744', 5694.89152838037, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.046786');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '886411231', 4669.68487435983, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.046786');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '817560052', 9502.49454667049, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.046786');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '835317170', 425.291789667957, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.072395');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '841420446', 5745.57970532255, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.072395');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '820358357', 4715.64971442092, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.072395');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '846038499', 1333.27257034113, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.072395');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '807597881', 4788.09994111076, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.072395');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '878937891', 9059.61555430363, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.110374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '853362787', 8298.68547194949, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.110374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '829594073', 7672.06289445385, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.110374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '880327539', 8062.23932576064, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.110374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '830152078', 6976.07661663163, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.110374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '885606403', 4167.98806456622, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.110374');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '876914756', 6010.16474199614, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.148021');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '825345571', 4502.09062910431, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.148021');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '897110971', 2657.20131426292, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.148021');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '828171064', 4157.46954851651, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.148021');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '839200091', 9934.72010297224, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.148021');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '800828122', 9111.14026588589, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.148021');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '820448355', 5523.84094700808, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.184202');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '827162708', 148.244616566776, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.184202');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '818072316', 3313.81970253627, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.184202');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '880683442', 7830.9956213594, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.184202');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '839857951', 1134.94579866544, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.184202');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '861172682', 8973.22965483389, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.184202');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '832468180', 5224.83340363221, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.184202');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '835288541', 3935.47040423453, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.217636');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '895916424', 4358.12803347938, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.217636');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '884908020', 8796.8567960909, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.217636');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '862637850', 5333.16993071081, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.217636');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '867225512', 6318.19227501662, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.217636');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '867401631', 7454.25770796758, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.217636');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '877300206', 6760.37188253587, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.217636');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '840496436', 3828.31788719849, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.250775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '819305793', 4332.25905474068, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.250775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '873601335', 9138.52425814421, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.250775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '841551914', 8244.85207080917, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.250775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '805115619', 4798.13571683604, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.250775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '856407982', 5667.21132368757, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.250775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '807229158', 5189.02309641794, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.250775');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '845910088', 3699.97813619932, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.280022');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '893522201', 101.301044970947, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.280022');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '839225416', 6692.4004582394, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.280022');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '892994223', 484.213396638217, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.280022');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '824608397', 7320.45555177815, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.280022');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '830789314', 4752.87654331884, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.280022');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '820111150', 8676.98328216787, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.280022');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '845783635', 2776.49017026453, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.31163');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '871562531', 5830.6562620937, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.31163');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '815764078', 9106.16910376213, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.31163');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '803431336', 1970.3951815479, 500, 1, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.31163');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '881518598', 845.392639708543, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.31163');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '880282542', 9311.92360189528, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.31163');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '878982724', 2412.79618278382, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.345872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '858422935', 3182.50325246433, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.345872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '852270662', 1252.88464878118, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.345872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '877943225', 6868.35790776311, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.345872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '894353446', 9078.46658728952, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.345872');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '843899480', 756.873414936739, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.390139');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '864291871', 6400.57812659586, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.390139');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '871725956', 4019.11943984932, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.390139');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '852516782', 3344.33329505395, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.390139');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '869347173', 6302.58491876378, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.390139');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '822984515', 3979.7913713227, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.499877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '820967644', 4603.8156542366, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.499877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '812040694', 1158.12073017127, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.499877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '812596296', 2950.07920662073, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.499877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '825796909', 770.336257555355, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.499877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '888220534', 2687.23334646613, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.499877');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '828546683', 5243.57433976539, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.536977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '888888152', 1731.81702013572, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.536977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '806544734', 286.423415793829, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.536977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '861855954', 6451.44777795966, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.536977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '826747324', 3388.61195285439, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.536977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '823421563', 1949.2220097295, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.536977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '864279810', 4413.24513231104, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.536977');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '815059394', 4942.72264109406, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.600859');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '800677974', 4652.76002610147, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.600859');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '869709608', 200.447696474996, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.600859');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '837340038', 8274.22696448614, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.641094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '878196649', 6829.602676141, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.641094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '855021005', 8411.63838599824, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.641094');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '842874686', 5541.67010403176, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.690296');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '897678406', 2556.22714258095, 500, 7, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.690296');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '822440491', 2138.80166380517, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.716747');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '895236942', 3909.21371872232, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.716747');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '873250306', 786.616812689621, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.716747');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '896136191', 9440.12283700918, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.716747');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '830923847', 2984.76724179934, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.757448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '839016903', 4758.04287585652, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.757448');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '840910627', 6179.21587390554, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.790075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '826212807', 1800.41882870603, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.790075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '830146348', 6428.3357350865, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.790075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '865855341', 3712.27047807187, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.790075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '813254974', 6391.37509961653, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.790075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '878458400', 5405.85917746349, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.790075');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '819718155', 910.266155808416, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.827763');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '840048395', 3769.04346792284, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.827763');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '817049990', 7213.96867526594, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.827763');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '823217376', 5788.61704233517, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.827763');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '814797335', 5291.16974098425, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.827763');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '863017059', 3491.16376435118, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.827763');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '829272494', 4264.85490655287, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.858371');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '821621583', 212.711540770457, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.858371');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '808719782', 7621.64210422491, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.858371');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '805762106', 6002.15544024802, 500, 2, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.892654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '823603319', 6742.10961442176, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.892654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '824698886', 9124.1728859598, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.892654');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '829645138', 4938.81823929634, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.993822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '826280365', 1780.79887542892, 500, 9, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:13.993822');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '840922156', 5070.38233560504, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:14.045978');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '869270642', 1761.6838570759, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:14.045978');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '846201495', 5812.45929610436, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:14.045978');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '895595058', 8665.8918692388, 500, 17, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:14.045978');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '880255752', 4999.01986750776, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:14.045978');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '883516756', 4365.74969468434, 500, 8, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:14.090205');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '823825914', 4277.50559951847, 500, 3, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:20.866425');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '891494743', 9571.03028048717, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:20.888538');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '866996950', 6118.57271749047, 500, 19, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:20.925246');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '878276775', 2628.32268957366, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:20.925246');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '835631853', 864.45881754204, 500, 5, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:20.925246');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '804345056', 8243.96164794505, 500, 16, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:20.95463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '863529173', 966.718604827245, 500, 6, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:20.95463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '873351078', 5675.82085926704, 500, 11, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:20.95463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '881715947', 4825.32113694024, 500, 15, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:20.95463');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '812300486', 1185.84119412488, 500, 18, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:21.056387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '819978335', 443.358637405204, 500, 20, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:21.056387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '800406757', 4688.76002750635, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:21.056387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '893603727', 340.041507377392, 500, 13, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:21.056387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '803556311', 2758.05959292958, 500, 12, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:21.056387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '881416980', 6278.38000435466, 500, 10, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:21.056387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '879409878', 2265.56564511667, 500, 4, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:21.056387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '864176730', 5626.750449562, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:21.056387');
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '857464841', 5445.38839601317, 500, 14, false, 2, '[{"kvartal": 1, "årstall": 2023}, {"kvartal": 4, "årstall": 2022}]', '2023-08-29 15:41:21.203945');


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:49.816415', '2023-08-29 15:40:49.816415');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:50.016618', '2023-08-29 15:40:50.016618');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:50.198578', '2023-08-29 15:40:50.198578');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:50.285975', '2023-08-29 15:40:50.285975');
INSERT INTO public.virksomhet VALUES (5, '884675261', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884675261', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:50.457709', '2023-08-29 15:40:50.457709');
INSERT INTO public.virksomhet VALUES (6, '851137753', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851137753', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:50.522653', '2023-08-29 15:40:50.522653');
INSERT INTO public.virksomhet VALUES (7, '852104530', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852104530', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:50.575763', '2023-08-29 15:40:50.575763');
INSERT INTO public.virksomhet VALUES (8, '807686992', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807686992', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:50.630276', '2023-08-29 15:40:50.630276');
INSERT INTO public.virksomhet VALUES (9, '802398455', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802398455', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:50.697879', '2023-08-29 15:40:50.697879');
INSERT INTO public.virksomhet VALUES (10, '833276442', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833276442', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:50.754619', '2023-08-29 15:40:50.754619');
INSERT INTO public.virksomhet VALUES (11, '839258152', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839258152', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:50.865547', '2023-08-29 15:40:50.865547');
INSERT INTO public.virksomhet VALUES (12, '807576151', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807576151', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:50.935603', '2023-08-29 15:40:50.935603');
INSERT INTO public.virksomhet VALUES (13, '850913244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850913244', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.013678', '2023-08-29 15:40:51.013678');
INSERT INTO public.virksomhet VALUES (14, '895920338', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895920338', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.066363', '2023-08-29 15:40:51.066363');
INSERT INTO public.virksomhet VALUES (15, '836472840', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836472840', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.116612', '2023-08-29 15:40:51.116612');
INSERT INTO public.virksomhet VALUES (16, '822673392', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822673392', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.177431', '2023-08-29 15:40:51.177431');
INSERT INTO public.virksomhet VALUES (17, '887128573', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887128573', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.220191', '2023-08-29 15:40:51.220191');
INSERT INTO public.virksomhet VALUES (18, '850313595', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850313595', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.400415', '2023-08-29 15:40:51.400415');
INSERT INTO public.virksomhet VALUES (19, '826526358', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826526358', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.438042', '2023-08-29 15:40:51.438042');
INSERT INTO public.virksomhet VALUES (20, '868229775', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868229775', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.501099', '2023-08-29 15:40:51.501099');
INSERT INTO public.virksomhet VALUES (21, '830135417', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830135417', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.581657', '2023-08-29 15:40:51.581657');
INSERT INTO public.virksomhet VALUES (22, '861395649', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861395649', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.684078', '2023-08-29 15:40:51.684078');
INSERT INTO public.virksomhet VALUES (23, '854415713', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854415713', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.762011', '2023-08-29 15:40:51.762011');
INSERT INTO public.virksomhet VALUES (24, '862293147', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862293147', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.807409', '2023-08-29 15:40:51.807409');
INSERT INTO public.virksomhet VALUES (25, '893597205', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893597205', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.86083', '2023-08-29 15:40:51.86083');
INSERT INTO public.virksomhet VALUES (26, '890770619', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890770619', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.901791', '2023-08-29 15:40:51.901791');
INSERT INTO public.virksomhet VALUES (27, '860001813', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860001813', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.950248', '2023-08-29 15:40:51.950248');
INSERT INTO public.virksomhet VALUES (28, '883513987', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883513987', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:51.998624', '2023-08-29 15:40:51.998624');
INSERT INTO public.virksomhet VALUES (29, '895897798', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895897798', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.042828', '2023-08-29 15:40:52.042828');
INSERT INTO public.virksomhet VALUES (30, '881142130', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881142130', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.095818', '2023-08-29 15:40:52.095818');
INSERT INTO public.virksomhet VALUES (31, '854024937', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854024937', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.126381', '2023-08-29 15:40:52.126381');
INSERT INTO public.virksomhet VALUES (32, '813141705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813141705', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.173327', '2023-08-29 15:40:52.173327');
INSERT INTO public.virksomhet VALUES (33, '828562569', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828562569', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.223247', '2023-08-29 15:40:52.223247');
INSERT INTO public.virksomhet VALUES (34, '833109464', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833109464', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.268937', '2023-08-29 15:40:52.268937');
INSERT INTO public.virksomhet VALUES (35, '886747994', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886747994', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.302707', '2023-08-29 15:40:52.302707');
INSERT INTO public.virksomhet VALUES (36, '848152346', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848152346', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.338616', '2023-08-29 15:40:52.338616');
INSERT INTO public.virksomhet VALUES (37, '825933759', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825933759', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.391017', '2023-08-29 15:40:52.391017');
INSERT INTO public.virksomhet VALUES (38, '814690513', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814690513', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.452706', '2023-08-29 15:40:52.452706');
INSERT INTO public.virksomhet VALUES (39, '851970156', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851970156', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.506029', '2023-08-29 15:40:52.506029');
INSERT INTO public.virksomhet VALUES (40, '868511260', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868511260', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.541187', '2023-08-29 15:40:52.541187');
INSERT INTO public.virksomhet VALUES (41, '830016645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830016645', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.585534', '2023-08-29 15:40:52.585534');
INSERT INTO public.virksomhet VALUES (42, '855026158', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855026158', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.632222', '2023-08-29 15:40:52.632222');
INSERT INTO public.virksomhet VALUES (43, '815935399', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815935399', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.673716', '2023-08-29 15:40:52.673716');
INSERT INTO public.virksomhet VALUES (44, '889414930', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889414930', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.717029', '2023-08-29 15:40:52.717029');
INSERT INTO public.virksomhet VALUES (45, '880049406', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880049406', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.785231', '2023-08-29 15:40:52.785231');
INSERT INTO public.virksomhet VALUES (46, '874394949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874394949', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.821342', '2023-08-29 15:40:52.821342');
INSERT INTO public.virksomhet VALUES (47, '837847297', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837847297', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.87025', '2023-08-29 15:40:52.87025');
INSERT INTO public.virksomhet VALUES (48, '883745258', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883745258', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:52.944766', '2023-08-29 15:40:52.944766');
INSERT INTO public.virksomhet VALUES (49, '862454991', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862454991', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.025193', '2023-08-29 15:40:53.025193');
INSERT INTO public.virksomhet VALUES (50, '860113451', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860113451', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.067076', '2023-08-29 15:40:53.067076');
INSERT INTO public.virksomhet VALUES (51, '829554318', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829554318', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.115109', '2023-08-29 15:40:53.115109');
INSERT INTO public.virksomhet VALUES (52, '822008150', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822008150', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.159283', '2023-08-29 15:40:53.159283');
INSERT INTO public.virksomhet VALUES (53, '846330108', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846330108', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.204325', '2023-08-29 15:40:53.204325');
INSERT INTO public.virksomhet VALUES (54, '833112838', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833112838', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.246152', '2023-08-29 15:40:53.246152');
INSERT INTO public.virksomhet VALUES (55, '872591676', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872591676', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.301607', '2023-08-29 15:40:53.301607');
INSERT INTO public.virksomhet VALUES (56, '860029289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860029289', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.342121', '2023-08-29 15:40:53.342121');
INSERT INTO public.virksomhet VALUES (57, '891988313', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891988313', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.403222', '2023-08-29 15:40:53.403222');
INSERT INTO public.virksomhet VALUES (58, '810800936', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810800936', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.467353', '2023-08-29 15:40:53.467353');
INSERT INTO public.virksomhet VALUES (59, '826304723', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826304723', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.521766', '2023-08-29 15:40:53.521766');
INSERT INTO public.virksomhet VALUES (60, '842368398', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842368398', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.567832', '2023-08-29 15:40:53.567832');
INSERT INTO public.virksomhet VALUES (61, '800088073', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800088073', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.601563', '2023-08-29 15:40:53.601563');
INSERT INTO public.virksomhet VALUES (62, '804056780', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804056780', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.636394', '2023-08-29 15:40:53.636394');
INSERT INTO public.virksomhet VALUES (63, '804071213', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804071213', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.680213', '2023-08-29 15:40:53.680213');
INSERT INTO public.virksomhet VALUES (64, '820154688', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820154688', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.724541', '2023-08-29 15:40:53.724541');
INSERT INTO public.virksomhet VALUES (65, '845863731', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845863731', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.769859', '2023-08-29 15:40:53.769859');
INSERT INTO public.virksomhet VALUES (66, '883360358', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883360358', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.800092', '2023-08-29 15:40:53.800092');
INSERT INTO public.virksomhet VALUES (67, '876784801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876784801', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.84068', '2023-08-29 15:40:53.84068');
INSERT INTO public.virksomhet VALUES (68, '894296991', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894296991', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:53.924922', '2023-08-29 15:40:53.924922');
INSERT INTO public.virksomhet VALUES (69, '811139665', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811139665', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.006786', '2023-08-29 15:40:54.006786');
INSERT INTO public.virksomhet VALUES (70, '803395093', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803395093', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.041994', '2023-08-29 15:40:54.041994');
INSERT INTO public.virksomhet VALUES (71, '881308154', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881308154', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.078927', '2023-08-29 15:40:54.078927');
INSERT INTO public.virksomhet VALUES (72, '858673060', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858673060', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.10878', '2023-08-29 15:40:54.10878');
INSERT INTO public.virksomhet VALUES (73, '864584378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864584378', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.146124', '2023-08-29 15:40:54.146124');
INSERT INTO public.virksomhet VALUES (74, '811805933', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811805933', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.172289', '2023-08-29 15:40:54.172289');
INSERT INTO public.virksomhet VALUES (75, '843998631', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843998631', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.193427', '2023-08-29 15:40:54.193427');
INSERT INTO public.virksomhet VALUES (76, '807742610', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807742610', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.230597', '2023-08-29 15:40:54.230597');
INSERT INTO public.virksomhet VALUES (77, '817024036', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817024036', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.267251', '2023-08-29 15:40:54.267251');
INSERT INTO public.virksomhet VALUES (78, '894510299', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894510299', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.317716', '2023-08-29 15:40:54.317716');
INSERT INTO public.virksomhet VALUES (79, '882979718', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882979718', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.343535', '2023-08-29 15:40:54.343535');
INSERT INTO public.virksomhet VALUES (80, '820922005', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820922005', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.390811', '2023-08-29 15:40:54.390811');
INSERT INTO public.virksomhet VALUES (81, '802652255', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802652255', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.432937', '2023-08-29 15:40:54.432937');
INSERT INTO public.virksomhet VALUES (82, '800028335', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800028335', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.47147', '2023-08-29 15:40:54.47147');
INSERT INTO public.virksomhet VALUES (83, '806830647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806830647', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.515739', '2023-08-29 15:40:54.515739');
INSERT INTO public.virksomhet VALUES (84, '875024581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875024581', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.55246', '2023-08-29 15:40:54.55246');
INSERT INTO public.virksomhet VALUES (85, '857530854', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857530854', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.584223', '2023-08-29 15:40:54.584223');
INSERT INTO public.virksomhet VALUES (86, '868564499', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868564499', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.614228', '2023-08-29 15:40:54.614228');
INSERT INTO public.virksomhet VALUES (87, '891332471', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891332471', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.643593', '2023-08-29 15:40:54.643593');
INSERT INTO public.virksomhet VALUES (88, '869425048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869425048', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.680125', '2023-08-29 15:40:54.680125');
INSERT INTO public.virksomhet VALUES (89, '876047468', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876047468', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.708202', '2023-08-29 15:40:54.708202');
INSERT INTO public.virksomhet VALUES (90, '873464281', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873464281', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.73359', '2023-08-29 15:40:54.73359');
INSERT INTO public.virksomhet VALUES (91, '801699286', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801699286', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.786514', '2023-08-29 15:40:54.786514');
INSERT INTO public.virksomhet VALUES (92, '852299828', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852299828', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.830797', '2023-08-29 15:40:54.830797');
INSERT INTO public.virksomhet VALUES (93, '899052538', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899052538', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.878175', '2023-08-29 15:40:54.878175');
INSERT INTO public.virksomhet VALUES (94, '884824815', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884824815', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.924882', '2023-08-29 15:40:54.924882');
INSERT INTO public.virksomhet VALUES (95, '872546768', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872546768', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:54.95511', '2023-08-29 15:40:54.95511');
INSERT INTO public.virksomhet VALUES (96, '836460310', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836460310', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.000398', '2023-08-29 15:40:55.000398');
INSERT INTO public.virksomhet VALUES (97, '830319650', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830319650', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.034321', '2023-08-29 15:40:55.034321');
INSERT INTO public.virksomhet VALUES (98, '840782943', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840782943', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.057644', '2023-08-29 15:40:55.057644');
INSERT INTO public.virksomhet VALUES (99, '852197780', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852197780', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.098724', '2023-08-29 15:40:55.098724');
INSERT INTO public.virksomhet VALUES (100, '800883616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800883616', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.138596', '2023-08-29 15:40:55.138596');
INSERT INTO public.virksomhet VALUES (101, '824222593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824222593', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.175525', '2023-08-29 15:40:55.175525');
INSERT INTO public.virksomhet VALUES (102, '828229897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828229897', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.200729', '2023-08-29 15:40:55.200729');
INSERT INTO public.virksomhet VALUES (103, '853872043', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853872043', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.239211', '2023-08-29 15:40:55.239211');
INSERT INTO public.virksomhet VALUES (104, '874698776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874698776', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.261863', '2023-08-29 15:40:55.261863');
INSERT INTO public.virksomhet VALUES (105, '864225323', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864225323', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.287984', '2023-08-29 15:40:55.287984');
INSERT INTO public.virksomhet VALUES (106, '860689823', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860689823', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.315531', '2023-08-29 15:40:55.315531');
INSERT INTO public.virksomhet VALUES (107, '837622686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837622686', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.343287', '2023-08-29 15:40:55.343287');
INSERT INTO public.virksomhet VALUES (108, '830385086', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830385086', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.381658', '2023-08-29 15:40:55.381658');
INSERT INTO public.virksomhet VALUES (109, '881748098', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881748098', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.425109', '2023-08-29 15:40:55.425109');
INSERT INTO public.virksomhet VALUES (110, '843242787', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843242787', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.467904', '2023-08-29 15:40:55.467904');
INSERT INTO public.virksomhet VALUES (111, '858993885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858993885', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.50498', '2023-08-29 15:40:55.50498');
INSERT INTO public.virksomhet VALUES (112, '837367306', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837367306', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.538195', '2023-08-29 15:40:55.538195');
INSERT INTO public.virksomhet VALUES (113, '882886632', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882886632', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.577066', '2023-08-29 15:40:55.577066');
INSERT INTO public.virksomhet VALUES (114, '836876279', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836876279', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.702317', '2023-08-29 15:40:55.702317');
INSERT INTO public.virksomhet VALUES (115, '892895220', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892895220', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.740221', '2023-08-29 15:40:55.740221');
INSERT INTO public.virksomhet VALUES (116, '834326743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834326743', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.824929', '2023-08-29 15:40:55.824929');
INSERT INTO public.virksomhet VALUES (117, '882121457', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882121457', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.908257', '2023-08-29 15:40:55.908257');
INSERT INTO public.virksomhet VALUES (118, '880716859', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880716859', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.949526', '2023-08-29 15:40:55.949526');
INSERT INTO public.virksomhet VALUES (119, '895819799', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895819799', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:55.979608', '2023-08-29 15:40:55.979608');
INSERT INTO public.virksomhet VALUES (120, '880564530', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880564530', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.017841', '2023-08-29 15:40:56.017841');
INSERT INTO public.virksomhet VALUES (121, '846886752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846886752', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.062131', '2023-08-29 15:40:56.062131');
INSERT INTO public.virksomhet VALUES (122, '898989109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898989109', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.092302', '2023-08-29 15:40:56.092302');
INSERT INTO public.virksomhet VALUES (123, '800011345', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800011345', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.126341', '2023-08-29 15:40:56.126341');
INSERT INTO public.virksomhet VALUES (124, '897397259', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897397259', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.157651', '2023-08-29 15:40:56.157651');
INSERT INTO public.virksomhet VALUES (125, '823589360', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823589360', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.182243', '2023-08-29 15:40:56.182243');
INSERT INTO public.virksomhet VALUES (126, '800146846', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800146846', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.232621', '2023-08-29 15:40:56.232621');
INSERT INTO public.virksomhet VALUES (127, '832421836', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832421836', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.278519', '2023-08-29 15:40:56.278519');
INSERT INTO public.virksomhet VALUES (128, '832949251', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832949251', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.317625', '2023-08-29 15:40:56.317625');
INSERT INTO public.virksomhet VALUES (129, '863286333', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863286333', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.349719', '2023-08-29 15:40:56.349719');
INSERT INTO public.virksomhet VALUES (130, '879969815', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879969815', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.409606', '2023-08-29 15:40:56.409606');
INSERT INTO public.virksomhet VALUES (131, '860767985', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860767985', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.461408', '2023-08-29 15:40:56.461408');
INSERT INTO public.virksomhet VALUES (132, '844833881', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844833881', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.520149', '2023-08-29 15:40:56.520149');
INSERT INTO public.virksomhet VALUES (133, '801398410', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801398410', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.582697', '2023-08-29 15:40:56.582697');
INSERT INTO public.virksomhet VALUES (134, '883614387', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883614387', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.61097', '2023-08-29 15:40:56.61097');
INSERT INTO public.virksomhet VALUES (135, '816105744', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816105744', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.643759', '2023-08-29 15:40:56.643759');
INSERT INTO public.virksomhet VALUES (136, '878011469', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878011469', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.681365', '2023-08-29 15:40:56.681365');
INSERT INTO public.virksomhet VALUES (137, '885803184', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885803184', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.726717', '2023-08-29 15:40:56.726717');
INSERT INTO public.virksomhet VALUES (138, '848263054', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848263054', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.775657', '2023-08-29 15:40:56.775657');
INSERT INTO public.virksomhet VALUES (139, '897957146', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897957146', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.808585', '2023-08-29 15:40:56.808585');
INSERT INTO public.virksomhet VALUES (140, '808478749', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808478749', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.854655', '2023-08-29 15:40:56.854655');
INSERT INTO public.virksomhet VALUES (141, '888040470', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888040470', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.932225', '2023-08-29 15:40:56.932225');
INSERT INTO public.virksomhet VALUES (142, '834999357', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834999357', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:56.992194', '2023-08-29 15:40:56.992194');
INSERT INTO public.virksomhet VALUES (143, '887207722', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887207722', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.053545', '2023-08-29 15:40:57.053545');
INSERT INTO public.virksomhet VALUES (144, '852437784', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852437784', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.104149', '2023-08-29 15:40:57.104149');
INSERT INTO public.virksomhet VALUES (145, '819785097', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819785097', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.163631', '2023-08-29 15:40:57.163631');
INSERT INTO public.virksomhet VALUES (146, '867188209', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867188209', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.241531', '2023-08-29 15:40:57.241531');
INSERT INTO public.virksomhet VALUES (147, '881550924', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881550924', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.284793', '2023-08-29 15:40:57.284793');
INSERT INTO public.virksomhet VALUES (148, '835379695', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835379695', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.331359', '2023-08-29 15:40:57.331359');
INSERT INTO public.virksomhet VALUES (149, '880617782', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880617782', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.390664', '2023-08-29 15:40:57.390664');
INSERT INTO public.virksomhet VALUES (150, '853760011', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853760011', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.461314', '2023-08-29 15:40:57.461314');
INSERT INTO public.virksomhet VALUES (151, '821849235', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821849235', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.519328', '2023-08-29 15:40:57.519328');
INSERT INTO public.virksomhet VALUES (152, '858115062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858115062', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.571074', '2023-08-29 15:40:57.571074');
INSERT INTO public.virksomhet VALUES (153, '869577747', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869577747', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.628222', '2023-08-29 15:40:57.628222');
INSERT INTO public.virksomhet VALUES (154, '800095119', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800095119', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.655421', '2023-08-29 15:40:57.655421');
INSERT INTO public.virksomhet VALUES (155, '884112569', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884112569', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.692944', '2023-08-29 15:40:57.692944');
INSERT INTO public.virksomhet VALUES (156, '839810200', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839810200', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.728384', '2023-08-29 15:40:57.728384');
INSERT INTO public.virksomhet VALUES (157, '891387618', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891387618', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.757209', '2023-08-29 15:40:57.757209');
INSERT INTO public.virksomhet VALUES (158, '892351179', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892351179', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.794373', '2023-08-29 15:40:57.794373');
INSERT INTO public.virksomhet VALUES (159, '818384717', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818384717', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.81738', '2023-08-29 15:40:57.81738');
INSERT INTO public.virksomhet VALUES (160, '815743441', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815743441', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.843352', '2023-08-29 15:40:57.843352');
INSERT INTO public.virksomhet VALUES (161, '851397068', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851397068', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.868303', '2023-08-29 15:40:57.868303');
INSERT INTO public.virksomhet VALUES (162, '875534564', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875534564', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.927167', '2023-08-29 15:40:57.927167');
INSERT INTO public.virksomhet VALUES (163, '801281104', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801281104', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:57.990776', '2023-08-29 15:40:57.990776');
INSERT INTO public.virksomhet VALUES (164, '865687238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865687238', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.065487', '2023-08-29 15:40:58.065487');
INSERT INTO public.virksomhet VALUES (165, '854703296', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854703296', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.118558', '2023-08-29 15:40:58.118558');
INSERT INTO public.virksomhet VALUES (166, '878480632', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878480632', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.159171', '2023-08-29 15:40:58.159171');
INSERT INTO public.virksomhet VALUES (167, '886814557', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886814557', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.185869', '2023-08-29 15:40:58.185869');
INSERT INTO public.virksomhet VALUES (168, '807657039', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807657039', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.221727', '2023-08-29 15:40:58.221727');
INSERT INTO public.virksomhet VALUES (169, '866503879', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866503879', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.261816', '2023-08-29 15:40:58.261816');
INSERT INTO public.virksomhet VALUES (170, '879255744', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879255744', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.303133', '2023-08-29 15:40:58.303133');
INSERT INTO public.virksomhet VALUES (171, '836040137', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836040137', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.329341', '2023-08-29 15:40:58.329341');
INSERT INTO public.virksomhet VALUES (172, '835974207', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835974207', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.364493', '2023-08-29 15:40:58.364493');
INSERT INTO public.virksomhet VALUES (173, '868960486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868960486', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.401244', '2023-08-29 15:40:58.401244');
INSERT INTO public.virksomhet VALUES (174, '800922553', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800922553', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.440034', '2023-08-29 15:40:58.440034');
INSERT INTO public.virksomhet VALUES (175, '849827380', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849827380', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.475583', '2023-08-29 15:40:58.475583');
INSERT INTO public.virksomhet VALUES (176, '813075874', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813075874', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.510579', '2023-08-29 15:40:58.510579');
INSERT INTO public.virksomhet VALUES (177, '895048096', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895048096', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.545205', '2023-08-29 15:40:58.545205');
INSERT INTO public.virksomhet VALUES (178, '800493742', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800493742', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.586272', '2023-08-29 15:40:58.586272');
INSERT INTO public.virksomhet VALUES (179, '896767809', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896767809', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.623194', '2023-08-29 15:40:58.623194');
INSERT INTO public.virksomhet VALUES (180, '880634250', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880634250', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.650931', '2023-08-29 15:40:58.650931');
INSERT INTO public.virksomhet VALUES (181, '831707731', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831707731', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.69301', '2023-08-29 15:40:58.69301');
INSERT INTO public.virksomhet VALUES (182, '867072306', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867072306', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.729824', '2023-08-29 15:40:58.729824');
INSERT INTO public.virksomhet VALUES (183, '898091120', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898091120', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.76812', '2023-08-29 15:40:58.76812');
INSERT INTO public.virksomhet VALUES (184, '820345524', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820345524', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.80672', '2023-08-29 15:40:58.80672');
INSERT INTO public.virksomhet VALUES (185, '811514303', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811514303', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.842964', '2023-08-29 15:40:58.842964');
INSERT INTO public.virksomhet VALUES (186, '888227038', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888227038', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.881502', '2023-08-29 15:40:58.881502');
INSERT INTO public.virksomhet VALUES (187, '824351597', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824351597', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.919264', '2023-08-29 15:40:58.919264');
INSERT INTO public.virksomhet VALUES (188, '898909248', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898909248', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:58.948268', '2023-08-29 15:40:58.948268');
INSERT INTO public.virksomhet VALUES (189, '833801366', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833801366', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.175018', '2023-08-29 15:40:59.175018');
INSERT INTO public.virksomhet VALUES (190, '885444119', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885444119', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.219576', '2023-08-29 15:40:59.219576');
INSERT INTO public.virksomhet VALUES (191, '865794794', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865794794', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.262056', '2023-08-29 15:40:59.262056');
INSERT INTO public.virksomhet VALUES (192, '868806184', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868806184', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.305189', '2023-08-29 15:40:59.305189');
INSERT INTO public.virksomhet VALUES (193, '809005837', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809005837', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.355949', '2023-08-29 15:40:59.355949');
INSERT INTO public.virksomhet VALUES (194, '888993141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888993141', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.407922', '2023-08-29 15:40:59.407922');
INSERT INTO public.virksomhet VALUES (195, '855555426', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855555426', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.471417', '2023-08-29 15:40:59.471417');
INSERT INTO public.virksomhet VALUES (196, '899843792', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899843792', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.526353', '2023-08-29 15:40:59.526353');
INSERT INTO public.virksomhet VALUES (197, '875763838', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875763838', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.573428', '2023-08-29 15:40:59.573428');
INSERT INTO public.virksomhet VALUES (198, '897966038', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897966038', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.607968', '2023-08-29 15:40:59.607968');
INSERT INTO public.virksomhet VALUES (199, '886073506', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886073506', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.643013', '2023-08-29 15:40:59.643013');
INSERT INTO public.virksomhet VALUES (200, '889870174', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889870174', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.680872', '2023-08-29 15:40:59.680872');
INSERT INTO public.virksomhet VALUES (201, '869904540', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869904540', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.717905', '2023-08-29 15:40:59.717905');
INSERT INTO public.virksomhet VALUES (202, '821894505', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821894505', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.850208', '2023-08-29 15:40:59.850208');
INSERT INTO public.virksomhet VALUES (203, '812212065', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812212065', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.916184', '2023-08-29 15:40:59.916184');
INSERT INTO public.virksomhet VALUES (204, '854723519', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854723519', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.952027', '2023-08-29 15:40:59.952027');
INSERT INTO public.virksomhet VALUES (205, '892918228', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892918228', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:40:59.99335', '2023-08-29 15:40:59.99335');
INSERT INTO public.virksomhet VALUES (206, '858126546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858126546', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.167065', '2023-08-29 15:41:00.167065');
INSERT INTO public.virksomhet VALUES (207, '858394926', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858394926', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.22438', '2023-08-29 15:41:00.22438');
INSERT INTO public.virksomhet VALUES (208, '881372741', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881372741', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.277549', '2023-08-29 15:41:00.277549');
INSERT INTO public.virksomhet VALUES (209, '828822894', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828822894', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.299987', '2023-08-29 15:41:00.299987');
INSERT INTO public.virksomhet VALUES (210, '804452158', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804452158', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.334804', '2023-08-29 15:41:00.334804');
INSERT INTO public.virksomhet VALUES (211, '812803827', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812803827', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.373446', '2023-08-29 15:41:00.373446');
INSERT INTO public.virksomhet VALUES (212, '851163302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851163302', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.439185', '2023-08-29 15:41:00.439185');
INSERT INTO public.virksomhet VALUES (213, '887970150', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887970150', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.477797', '2023-08-29 15:41:00.477797');
INSERT INTO public.virksomhet VALUES (214, '885228334', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885228334', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.518018', '2023-08-29 15:41:00.518018');
INSERT INTO public.virksomhet VALUES (215, '803989289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803989289', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.547108', '2023-08-29 15:41:00.547108');
INSERT INTO public.virksomhet VALUES (216, '885663079', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885663079', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.581146', '2023-08-29 15:41:00.581146');
INSERT INTO public.virksomhet VALUES (217, '880836681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880836681', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.606879', '2023-08-29 15:41:00.606879');
INSERT INTO public.virksomhet VALUES (218, '890484231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890484231', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.639067', '2023-08-29 15:41:00.639067');
INSERT INTO public.virksomhet VALUES (219, '876207551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876207551', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.672478', '2023-08-29 15:41:00.672478');
INSERT INTO public.virksomhet VALUES (220, '816635391', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816635391', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.693537', '2023-08-29 15:41:00.693537');
INSERT INTO public.virksomhet VALUES (221, '804710504', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804710504', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.727255', '2023-08-29 15:41:00.727255');
INSERT INTO public.virksomhet VALUES (222, '863736808', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863736808', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.749254', '2023-08-29 15:41:00.749254');
INSERT INTO public.virksomhet VALUES (223, '812752597', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812752597', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.770674', '2023-08-29 15:41:00.770674');
INSERT INTO public.virksomhet VALUES (224, '846383406', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846383406', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.795137', '2023-08-29 15:41:00.795137');
INSERT INTO public.virksomhet VALUES (225, '862716503', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862716503', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.83171', '2023-08-29 15:41:00.83171');
INSERT INTO public.virksomhet VALUES (226, '854308355', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854308355', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.857059', '2023-08-29 15:41:00.857059');
INSERT INTO public.virksomhet VALUES (227, '847640744', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847640744', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.885772', '2023-08-29 15:41:00.885772');
INSERT INTO public.virksomhet VALUES (228, '858653530', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858653530', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.926139', '2023-08-29 15:41:00.926139');
INSERT INTO public.virksomhet VALUES (229, '881633232', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881633232', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:00.961062', '2023-08-29 15:41:00.961062');
INSERT INTO public.virksomhet VALUES (230, '832936423', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832936423', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.001355', '2023-08-29 15:41:01.001355');
INSERT INTO public.virksomhet VALUES (231, '868397690', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868397690', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.046143', '2023-08-29 15:41:01.046143');
INSERT INTO public.virksomhet VALUES (232, '875009936', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875009936', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.074412', '2023-08-29 15:41:01.074412');
INSERT INTO public.virksomhet VALUES (233, '806934151', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806934151', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.10961', '2023-08-29 15:41:01.10961');
INSERT INTO public.virksomhet VALUES (234, '873202447', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873202447', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.132594', '2023-08-29 15:41:01.132594');
INSERT INTO public.virksomhet VALUES (235, '885786568', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885786568', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.156924', '2023-08-29 15:41:01.156924');
INSERT INTO public.virksomhet VALUES (236, '834856113', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834856113', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.182487', '2023-08-29 15:41:01.182487');
INSERT INTO public.virksomhet VALUES (237, '836784911', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836784911', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.207296', '2023-08-29 15:41:01.207296');
INSERT INTO public.virksomhet VALUES (238, '894747218', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894747218', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.241716', '2023-08-29 15:41:01.241716');
INSERT INTO public.virksomhet VALUES (239, '895681992', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895681992', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.268158', '2023-08-29 15:41:01.268158');
INSERT INTO public.virksomhet VALUES (240, '832637622', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832637622', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.304973', '2023-08-29 15:41:01.304973');
INSERT INTO public.virksomhet VALUES (241, '874482558', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874482558', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.330638', '2023-08-29 15:41:01.330638');
INSERT INTO public.virksomhet VALUES (242, '855761730', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855761730', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.376219', '2023-08-29 15:41:01.376219');
INSERT INTO public.virksomhet VALUES (243, '820139087', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820139087', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.416453', '2023-08-29 15:41:01.416453');
INSERT INTO public.virksomhet VALUES (244, '865386572', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865386572', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.451547', '2023-08-29 15:41:01.451547');
INSERT INTO public.virksomhet VALUES (245, '829511734', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829511734', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.478213', '2023-08-29 15:41:01.478213');
INSERT INTO public.virksomhet VALUES (246, '811846482', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811846482', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.515507', '2023-08-29 15:41:01.515507');
INSERT INTO public.virksomhet VALUES (247, '854256242', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854256242', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.554285', '2023-08-29 15:41:01.554285');
INSERT INTO public.virksomhet VALUES (248, '865097331', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865097331', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.578946', '2023-08-29 15:41:01.578946');
INSERT INTO public.virksomhet VALUES (249, '876783179', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876783179', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.614745', '2023-08-29 15:41:01.614745');
INSERT INTO public.virksomhet VALUES (250, '899264391', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899264391', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.657664', '2023-08-29 15:41:01.657664');
INSERT INTO public.virksomhet VALUES (251, '894999875', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894999875', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.699894', '2023-08-29 15:41:01.699894');
INSERT INTO public.virksomhet VALUES (252, '816627945', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816627945', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.734169', '2023-08-29 15:41:01.734169');
INSERT INTO public.virksomhet VALUES (253, '864598083', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864598083', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.77427', '2023-08-29 15:41:01.77427');
INSERT INTO public.virksomhet VALUES (254, '840970664', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840970664', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.803061', '2023-08-29 15:41:01.803061');
INSERT INTO public.virksomhet VALUES (255, '827743840', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827743840', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.83982', '2023-08-29 15:41:01.83982');
INSERT INTO public.virksomhet VALUES (256, '827433286', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827433286', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.868847', '2023-08-29 15:41:01.868847');
INSERT INTO public.virksomhet VALUES (257, '847189640', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847189640', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.918256', '2023-08-29 15:41:01.918256');
INSERT INTO public.virksomhet VALUES (258, '831633908', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831633908', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:01.954548', '2023-08-29 15:41:01.954548');
INSERT INTO public.virksomhet VALUES (259, '867645704', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867645704', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.011243', '2023-08-29 15:41:02.011243');
INSERT INTO public.virksomhet VALUES (260, '812108401', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812108401', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.049237', '2023-08-29 15:41:02.049237');
INSERT INTO public.virksomhet VALUES (261, '889335036', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889335036', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.078579', '2023-08-29 15:41:02.078579');
INSERT INTO public.virksomhet VALUES (262, '844930296', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844930296', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.104136', '2023-08-29 15:41:02.104136');
INSERT INTO public.virksomhet VALUES (263, '851548938', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851548938', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.140123', '2023-08-29 15:41:02.140123');
INSERT INTO public.virksomhet VALUES (264, '874171433', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874171433', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.172426', '2023-08-29 15:41:02.172426');
INSERT INTO public.virksomhet VALUES (265, '867713572', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867713572', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.192905', '2023-08-29 15:41:02.192905');
INSERT INTO public.virksomhet VALUES (266, '813483207', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813483207', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.2192', '2023-08-29 15:41:02.2192');
INSERT INTO public.virksomhet VALUES (267, '805031170', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805031170', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.239811', '2023-08-29 15:41:02.239811');
INSERT INTO public.virksomhet VALUES (268, '862102260', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862102260', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.265788', '2023-08-29 15:41:02.265788');
INSERT INTO public.virksomhet VALUES (269, '816146647', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816146647', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.303335', '2023-08-29 15:41:02.303335');
INSERT INTO public.virksomhet VALUES (270, '848438344', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848438344', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.338175', '2023-08-29 15:41:02.338175');
INSERT INTO public.virksomhet VALUES (271, '816933976', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816933976', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.363036', '2023-08-29 15:41:02.363036');
INSERT INTO public.virksomhet VALUES (272, '882893771', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882893771', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.403083', '2023-08-29 15:41:02.403083');
INSERT INTO public.virksomhet VALUES (273, '885095175', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885095175', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.438824', '2023-08-29 15:41:02.438824');
INSERT INTO public.virksomhet VALUES (274, '820914876', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820914876', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.472955', '2023-08-29 15:41:02.472955');
INSERT INTO public.virksomhet VALUES (275, '819663639', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819663639', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.502021', '2023-08-29 15:41:02.502021');
INSERT INTO public.virksomhet VALUES (276, '887228311', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887228311', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.530291', '2023-08-29 15:41:02.530291');
INSERT INTO public.virksomhet VALUES (277, '832446008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832446008', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.564605', '2023-08-29 15:41:02.564605');
INSERT INTO public.virksomhet VALUES (278, '813258210', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813258210', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.599828', '2023-08-29 15:41:02.599828');
INSERT INTO public.virksomhet VALUES (279, '888116513', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888116513', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.639604', '2023-08-29 15:41:02.639604');
INSERT INTO public.virksomhet VALUES (280, '875730862', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875730862', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.665144', '2023-08-29 15:41:02.665144');
INSERT INTO public.virksomhet VALUES (281, '848841245', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848841245', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.68522', '2023-08-29 15:41:02.68522');
INSERT INTO public.virksomhet VALUES (282, '841256069', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841256069', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.7134', '2023-08-29 15:41:02.7134');
INSERT INTO public.virksomhet VALUES (283, '805207537', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805207537', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.738436', '2023-08-29 15:41:02.738436');
INSERT INTO public.virksomhet VALUES (284, '818993953', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818993953', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.772212', '2023-08-29 15:41:02.772212');
INSERT INTO public.virksomhet VALUES (285, '831454006', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831454006', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.79657', '2023-08-29 15:41:02.79657');
INSERT INTO public.virksomhet VALUES (286, '883416962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883416962', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.819307', '2023-08-29 15:41:02.819307');
INSERT INTO public.virksomhet VALUES (287, '809416939', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809416939', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.848016', '2023-08-29 15:41:02.848016');
INSERT INTO public.virksomhet VALUES (288, '813799118', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813799118', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.876725', '2023-08-29 15:41:02.876725');
INSERT INTO public.virksomhet VALUES (289, '863491262', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863491262', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:02.969608', '2023-08-29 15:41:02.969608');
INSERT INTO public.virksomhet VALUES (290, '867056903', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867056903', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.034406', '2023-08-29 15:41:03.034406');
INSERT INTO public.virksomhet VALUES (291, '885874897', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885874897', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.068928', '2023-08-29 15:41:03.068928');
INSERT INTO public.virksomhet VALUES (292, '889159375', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889159375', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.091694', '2023-08-29 15:41:03.091694');
INSERT INTO public.virksomhet VALUES (293, '888451869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888451869', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.128391', '2023-08-29 15:41:03.128391');
INSERT INTO public.virksomhet VALUES (294, '891420733', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891420733', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.14976', '2023-08-29 15:41:03.14976');
INSERT INTO public.virksomhet VALUES (295, '896940956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896940956', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.178215', '2023-08-29 15:41:03.178215');
INSERT INTO public.virksomhet VALUES (296, '827161001', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827161001', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.203965', '2023-08-29 15:41:03.203965');
INSERT INTO public.virksomhet VALUES (297, '843998028', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843998028', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.229021', '2023-08-29 15:41:03.229021');
INSERT INTO public.virksomhet VALUES (298, '832385490', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832385490', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.257571', '2023-08-29 15:41:03.257571');
INSERT INTO public.virksomhet VALUES (299, '828970725', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828970725', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.278654', '2023-08-29 15:41:03.278654');
INSERT INTO public.virksomhet VALUES (300, '884294930', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884294930', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.301656', '2023-08-29 15:41:03.301656');
INSERT INTO public.virksomhet VALUES (301, '884539162', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884539162', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.332335', '2023-08-29 15:41:03.332335');
INSERT INTO public.virksomhet VALUES (302, '839707107', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839707107', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.358996', '2023-08-29 15:41:03.358996');
INSERT INTO public.virksomhet VALUES (303, '857501205', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857501205', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.430728', '2023-08-29 15:41:03.430728');
INSERT INTO public.virksomhet VALUES (304, '892829715', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892829715', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.475209', '2023-08-29 15:41:03.475209');
INSERT INTO public.virksomhet VALUES (305, '835144465', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835144465', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.54287', '2023-08-29 15:41:03.54287');
INSERT INTO public.virksomhet VALUES (306, '833673063', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833673063', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.56924', '2023-08-29 15:41:03.56924');
INSERT INTO public.virksomhet VALUES (307, '893494597', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893494597', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.598244', '2023-08-29 15:41:03.598244');
INSERT INTO public.virksomhet VALUES (308, '831839631', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831839631', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.634182', '2023-08-29 15:41:03.634182');
INSERT INTO public.virksomhet VALUES (309, '857180192', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857180192', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.660041', '2023-08-29 15:41:03.660041');
INSERT INTO public.virksomhet VALUES (310, '802650881', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802650881', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.689227', '2023-08-29 15:41:03.689227');
INSERT INTO public.virksomhet VALUES (311, '842224053', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842224053', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.725908', '2023-08-29 15:41:03.725908');
INSERT INTO public.virksomhet VALUES (312, '886538999', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886538999', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.751844', '2023-08-29 15:41:03.751844');
INSERT INTO public.virksomhet VALUES (313, '819435752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819435752', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.782049', '2023-08-29 15:41:03.782049');
INSERT INTO public.virksomhet VALUES (314, '824307021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824307021', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.815218', '2023-08-29 15:41:03.815218');
INSERT INTO public.virksomhet VALUES (315, '875204204', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875204204', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.846793', '2023-08-29 15:41:03.846793');
INSERT INTO public.virksomhet VALUES (316, '879284008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879284008', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.884436', '2023-08-29 15:41:03.884436');
INSERT INTO public.virksomhet VALUES (317, '803494974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803494974', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.939715', '2023-08-29 15:41:03.939715');
INSERT INTO public.virksomhet VALUES (318, '809317616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809317616', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:03.981975', '2023-08-29 15:41:03.981975');
INSERT INTO public.virksomhet VALUES (319, '839093982', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839093982', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.018162', '2023-08-29 15:41:04.018162');
INSERT INTO public.virksomhet VALUES (320, '801964879', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801964879', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.058231', '2023-08-29 15:41:04.058231');
INSERT INTO public.virksomhet VALUES (321, '870320690', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870320690', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.093189', '2023-08-29 15:41:04.093189');
INSERT INTO public.virksomhet VALUES (322, '834707050', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834707050', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.119057', '2023-08-29 15:41:04.119057');
INSERT INTO public.virksomhet VALUES (323, '802466699', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802466699', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.151915', '2023-08-29 15:41:04.151915');
INSERT INTO public.virksomhet VALUES (324, '801062547', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801062547', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.186637', '2023-08-29 15:41:04.186637');
INSERT INTO public.virksomhet VALUES (325, '821343665', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821343665', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.2204', '2023-08-29 15:41:04.2204');
INSERT INTO public.virksomhet VALUES (326, '817936779', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817936779', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.243793', '2023-08-29 15:41:04.243793');
INSERT INTO public.virksomhet VALUES (327, '877671658', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877671658', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.275614', '2023-08-29 15:41:04.275614');
INSERT INTO public.virksomhet VALUES (328, '819018936', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819018936', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.311396', '2023-08-29 15:41:04.311396');
INSERT INTO public.virksomhet VALUES (329, '800286721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800286721', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.338533', '2023-08-29 15:41:04.338533');
INSERT INTO public.virksomhet VALUES (330, '825254008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825254008', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.367846', '2023-08-29 15:41:04.367846');
INSERT INTO public.virksomhet VALUES (331, '850450265', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850450265', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.397451', '2023-08-29 15:41:04.397451');
INSERT INTO public.virksomhet VALUES (332, '886304033', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886304033', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.422493', '2023-08-29 15:41:04.422493');
INSERT INTO public.virksomhet VALUES (333, '811041360', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811041360', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.448388', '2023-08-29 15:41:04.448388');
INSERT INTO public.virksomhet VALUES (334, '817484495', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817484495', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.472052', '2023-08-29 15:41:04.472052');
INSERT INTO public.virksomhet VALUES (335, '896259714', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896259714', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.505813', '2023-08-29 15:41:04.505813');
INSERT INTO public.virksomhet VALUES (336, '877179757', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877179757', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.530869', '2023-08-29 15:41:04.530869');
INSERT INTO public.virksomhet VALUES (337, '880502805', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880502805', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.56603', '2023-08-29 15:41:04.56603');
INSERT INTO public.virksomhet VALUES (338, '864532427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864532427', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.594963', '2023-08-29 15:41:04.594963');
INSERT INTO public.virksomhet VALUES (339, '865196110', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865196110', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.626609', '2023-08-29 15:41:04.626609');
INSERT INTO public.virksomhet VALUES (340, '890377554', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890377554', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.653856', '2023-08-29 15:41:04.653856');
INSERT INTO public.virksomhet VALUES (341, '890477159', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890477159', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.673455', '2023-08-29 15:41:04.673455');
INSERT INTO public.virksomhet VALUES (342, '868311985', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868311985', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.69244', '2023-08-29 15:41:04.69244');
INSERT INTO public.virksomhet VALUES (343, '881487654', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881487654', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.715223', '2023-08-29 15:41:04.715223');
INSERT INTO public.virksomhet VALUES (344, '819222250', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819222250', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.749474', '2023-08-29 15:41:04.749474');
INSERT INTO public.virksomhet VALUES (345, '806628725', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806628725', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.793813', '2023-08-29 15:41:04.793813');
INSERT INTO public.virksomhet VALUES (346, '883691516', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883691516', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.858691', '2023-08-29 15:41:04.858691');
INSERT INTO public.virksomhet VALUES (347, '812745366', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812745366', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.911499', '2023-08-29 15:41:04.911499');
INSERT INTO public.virksomhet VALUES (348, '829741575', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829741575', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:04.961481', '2023-08-29 15:41:04.961481');
INSERT INTO public.virksomhet VALUES (349, '874898152', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874898152', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.001987', '2023-08-29 15:41:05.001987');
INSERT INTO public.virksomhet VALUES (350, '817852775', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817852775', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.033465', '2023-08-29 15:41:05.033465');
INSERT INTO public.virksomhet VALUES (351, '809591404', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809591404', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.060979', '2023-08-29 15:41:05.060979');
INSERT INTO public.virksomhet VALUES (352, '832352774', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832352774', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.093705', '2023-08-29 15:41:05.093705');
INSERT INTO public.virksomhet VALUES (353, '838346408', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838346408', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.124328', '2023-08-29 15:41:05.124328');
INSERT INTO public.virksomhet VALUES (354, '885516480', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885516480', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.157306', '2023-08-29 15:41:05.157306');
INSERT INTO public.virksomhet VALUES (355, '849774021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849774021', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.181821', '2023-08-29 15:41:05.181821');
INSERT INTO public.virksomhet VALUES (356, '850986342', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850986342', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.204607', '2023-08-29 15:41:05.204607');
INSERT INTO public.virksomhet VALUES (357, '808083042', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808083042', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.236927', '2023-08-29 15:41:05.236927');
INSERT INTO public.virksomhet VALUES (358, '802046791', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802046791', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.261141', '2023-08-29 15:41:05.261141');
INSERT INTO public.virksomhet VALUES (359, '875562853', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875562853', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.285088', '2023-08-29 15:41:05.285088');
INSERT INTO public.virksomhet VALUES (360, '845556525', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845556525', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.320885', '2023-08-29 15:41:05.320885');
INSERT INTO public.virksomhet VALUES (361, '897253649', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897253649', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.34561', '2023-08-29 15:41:05.34561');
INSERT INTO public.virksomhet VALUES (362, '864262533', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864262533', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.374041', '2023-08-29 15:41:05.374041');
INSERT INTO public.virksomhet VALUES (363, '885952882', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885952882', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.397155', '2023-08-29 15:41:05.397155');
INSERT INTO public.virksomhet VALUES (364, '840097094', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840097094', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.423447', '2023-08-29 15:41:05.423447');
INSERT INTO public.virksomhet VALUES (365, '879243879', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879243879', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.460747', '2023-08-29 15:41:05.460747');
INSERT INTO public.virksomhet VALUES (366, '844075519', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844075519', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.485599', '2023-08-29 15:41:05.485599');
INSERT INTO public.virksomhet VALUES (367, '866317127', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866317127', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.519794', '2023-08-29 15:41:05.519794');
INSERT INTO public.virksomhet VALUES (368, '840082452', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840082452', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.564335', '2023-08-29 15:41:05.564335');
INSERT INTO public.virksomhet VALUES (369, '898206411', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898206411', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.594264', '2023-08-29 15:41:05.594264');
INSERT INTO public.virksomhet VALUES (370, '832564050', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832564050', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.618895', '2023-08-29 15:41:05.618895');
INSERT INTO public.virksomhet VALUES (371, '836673562', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836673562', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.650357', '2023-08-29 15:41:05.650357');
INSERT INTO public.virksomhet VALUES (372, '878495762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878495762', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.67049', '2023-08-29 15:41:05.67049');
INSERT INTO public.virksomhet VALUES (373, '853514048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853514048', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.69534', '2023-08-29 15:41:05.69534');
INSERT INTO public.virksomhet VALUES (374, '809198051', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809198051', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.729467', '2023-08-29 15:41:05.729467');
INSERT INTO public.virksomhet VALUES (375, '815803212', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815803212', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.752191', '2023-08-29 15:41:05.752191');
INSERT INTO public.virksomhet VALUES (376, '823868580', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823868580', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.78227', '2023-08-29 15:41:05.78227');
INSERT INTO public.virksomhet VALUES (377, '856809969', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856809969', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.813809', '2023-08-29 15:41:05.813809');
INSERT INTO public.virksomhet VALUES (378, '806197095', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806197095', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.83924', '2023-08-29 15:41:05.83924');
INSERT INTO public.virksomhet VALUES (379, '875088087', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875088087', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.873935', '2023-08-29 15:41:05.873935');
INSERT INTO public.virksomhet VALUES (380, '823976707', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823976707', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.913347', '2023-08-29 15:41:05.913347');
INSERT INTO public.virksomhet VALUES (381, '817220330', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817220330', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.948926', '2023-08-29 15:41:05.948926');
INSERT INTO public.virksomhet VALUES (382, '891478088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891478088', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:05.990974', '2023-08-29 15:41:05.990974');
INSERT INTO public.virksomhet VALUES (383, '868019564', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868019564', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.021232', '2023-08-29 15:41:06.021232');
INSERT INTO public.virksomhet VALUES (384, '816244312', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816244312', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.045776', '2023-08-29 15:41:06.045776');
INSERT INTO public.virksomhet VALUES (385, '860191016', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860191016', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.082995', '2023-08-29 15:41:06.082995');
INSERT INTO public.virksomhet VALUES (386, '833832924', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833832924', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.1067', '2023-08-29 15:41:06.1067');
INSERT INTO public.virksomhet VALUES (387, '880961071', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880961071', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.132517', '2023-08-29 15:41:06.132517');
INSERT INTO public.virksomhet VALUES (388, '895091858', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895091858', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.161431', '2023-08-29 15:41:06.161431');
INSERT INTO public.virksomhet VALUES (389, '883079881', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883079881', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.189577', '2023-08-29 15:41:06.189577');
INSERT INTO public.virksomhet VALUES (390, '853367104', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853367104', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.228889', '2023-08-29 15:41:06.228889');
INSERT INTO public.virksomhet VALUES (391, '828309280', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828309280', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.261687', '2023-08-29 15:41:06.261687');
INSERT INTO public.virksomhet VALUES (392, '887350417', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887350417', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.280162', '2023-08-29 15:41:06.280162');
INSERT INTO public.virksomhet VALUES (393, '832030436', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832030436', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.304032', '2023-08-29 15:41:06.304032');
INSERT INTO public.virksomhet VALUES (394, '827350744', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827350744', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.324918', '2023-08-29 15:41:06.324918');
INSERT INTO public.virksomhet VALUES (395, '886411231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886411231', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.354945', '2023-08-29 15:41:06.354945');
INSERT INTO public.virksomhet VALUES (396, '817560052', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817560052', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.370075', '2023-08-29 15:41:06.370075');
INSERT INTO public.virksomhet VALUES (397, '835317170', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835317170', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.387161', '2023-08-29 15:41:06.387161');
INSERT INTO public.virksomhet VALUES (398, '841420446', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841420446', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.411904', '2023-08-29 15:41:06.411904');
INSERT INTO public.virksomhet VALUES (399, '820358357', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820358357', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.439051', '2023-08-29 15:41:06.439051');
INSERT INTO public.virksomhet VALUES (400, '846038499', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846038499', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.476293', '2023-08-29 15:41:06.476293');
INSERT INTO public.virksomhet VALUES (401, '807597881', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807597881', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.501748', '2023-08-29 15:41:06.501748');
INSERT INTO public.virksomhet VALUES (402, '878937891', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878937891', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.534639', '2023-08-29 15:41:06.534639');
INSERT INTO public.virksomhet VALUES (403, '853362787', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853362787', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.567723', '2023-08-29 15:41:06.567723');
INSERT INTO public.virksomhet VALUES (404, '829594073', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829594073', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.60543', '2023-08-29 15:41:06.60543');
INSERT INTO public.virksomhet VALUES (405, '880327539', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880327539', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.629706', '2023-08-29 15:41:06.629706');
INSERT INTO public.virksomhet VALUES (406, '830152078', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830152078', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.650344', '2023-08-29 15:41:06.650344');
INSERT INTO public.virksomhet VALUES (407, '885606403', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885606403', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.672279', '2023-08-29 15:41:06.672279');
INSERT INTO public.virksomhet VALUES (408, '876914756', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876914756', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.708824', '2023-08-29 15:41:06.708824');
INSERT INTO public.virksomhet VALUES (409, '825345571', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825345571', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.726009', '2023-08-29 15:41:06.726009');
INSERT INTO public.virksomhet VALUES (410, '897110971', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897110971', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.750428', '2023-08-29 15:41:06.750428');
INSERT INTO public.virksomhet VALUES (411, '828171064', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828171064', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.784426', '2023-08-29 15:41:06.784426');
INSERT INTO public.virksomhet VALUES (412, '839200091', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839200091', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.810106', '2023-08-29 15:41:06.810106');
INSERT INTO public.virksomhet VALUES (413, '800828122', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800828122', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.842552', '2023-08-29 15:41:06.842552');
INSERT INTO public.virksomhet VALUES (414, '820448355', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820448355', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.866686', '2023-08-29 15:41:06.866686');
INSERT INTO public.virksomhet VALUES (415, '827162708', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827162708', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.888047', '2023-08-29 15:41:06.888047');
INSERT INTO public.virksomhet VALUES (416, '818072316', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818072316', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.929193', '2023-08-29 15:41:06.929193');
INSERT INTO public.virksomhet VALUES (417, '880683442', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880683442', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:06.967562', '2023-08-29 15:41:06.967562');
INSERT INTO public.virksomhet VALUES (418, '839857951', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839857951', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.012562', '2023-08-29 15:41:07.012562');
INSERT INTO public.virksomhet VALUES (419, '861172682', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861172682', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.039642', '2023-08-29 15:41:07.039642');
INSERT INTO public.virksomhet VALUES (420, '832468180', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832468180', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.062027', '2023-08-29 15:41:07.062027');
INSERT INTO public.virksomhet VALUES (421, '835288541', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835288541', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.086784', '2023-08-29 15:41:07.086784');
INSERT INTO public.virksomhet VALUES (422, '895916424', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895916424', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.123034', '2023-08-29 15:41:07.123034');
INSERT INTO public.virksomhet VALUES (423, '884908020', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884908020', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.146699', '2023-08-29 15:41:07.146699');
INSERT INTO public.virksomhet VALUES (424, '862637850', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862637850', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.177794', '2023-08-29 15:41:07.177794');
INSERT INTO public.virksomhet VALUES (425, '867225512', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867225512', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.201022', '2023-08-29 15:41:07.201022');
INSERT INTO public.virksomhet VALUES (426, '867401631', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867401631', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.226666', '2023-08-29 15:41:07.226666');
INSERT INTO public.virksomhet VALUES (427, '877300206', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877300206', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.250847', '2023-08-29 15:41:07.250847');
INSERT INTO public.virksomhet VALUES (428, '840496436', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840496436', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.271315', '2023-08-29 15:41:07.271315');
INSERT INTO public.virksomhet VALUES (429, '819305793', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819305793', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.298989', '2023-08-29 15:41:07.298989');
INSERT INTO public.virksomhet VALUES (430, '873601335', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873601335', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.330443', '2023-08-29 15:41:07.330443');
INSERT INTO public.virksomhet VALUES (431, '841551914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841551914', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.358473', '2023-08-29 15:41:07.358473');
INSERT INTO public.virksomhet VALUES (432, '805115619', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805115619', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.399236', '2023-08-29 15:41:07.399236');
INSERT INTO public.virksomhet VALUES (433, '856407982', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856407982', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.451194', '2023-08-29 15:41:07.451194');
INSERT INTO public.virksomhet VALUES (434, '807229158', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807229158', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.487952', '2023-08-29 15:41:07.487952');
INSERT INTO public.virksomhet VALUES (435, '845910088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845910088', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.524924', '2023-08-29 15:41:07.524924');
INSERT INTO public.virksomhet VALUES (436, '893522201', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893522201', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.565486', '2023-08-29 15:41:07.565486');
INSERT INTO public.virksomhet VALUES (437, '839225416', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839225416', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.597172', '2023-08-29 15:41:07.597172');
INSERT INTO public.virksomhet VALUES (438, '892994223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892994223', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.626861', '2023-08-29 15:41:07.626861');
INSERT INTO public.virksomhet VALUES (439, '824608397', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824608397', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.64856', '2023-08-29 15:41:07.64856');
INSERT INTO public.virksomhet VALUES (440, '830789314', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830789314', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.677859', '2023-08-29 15:41:07.677859');
INSERT INTO public.virksomhet VALUES (441, '820111150', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820111150', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.705305', '2023-08-29 15:41:07.705305');
INSERT INTO public.virksomhet VALUES (442, '845783635', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845783635', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.727169', '2023-08-29 15:41:07.727169');
INSERT INTO public.virksomhet VALUES (443, '871562531', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871562531', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.764979', '2023-08-29 15:41:07.764979');
INSERT INTO public.virksomhet VALUES (444, '815764078', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815764078', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.79465', '2023-08-29 15:41:07.79465');
INSERT INTO public.virksomhet VALUES (445, '803431336', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803431336', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.833206', '2023-08-29 15:41:07.833206');
INSERT INTO public.virksomhet VALUES (446, '881518598', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881518598', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.865269', '2023-08-29 15:41:07.865269');
INSERT INTO public.virksomhet VALUES (447, '880282542', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880282542', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.904992', '2023-08-29 15:41:07.904992');
INSERT INTO public.virksomhet VALUES (448, '878982724', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878982724', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.936664', '2023-08-29 15:41:07.936664');
INSERT INTO public.virksomhet VALUES (449, '858422935', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858422935', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:07.976374', '2023-08-29 15:41:07.976374');
INSERT INTO public.virksomhet VALUES (450, '852270662', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852270662', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.000856', '2023-08-29 15:41:08.000856');
INSERT INTO public.virksomhet VALUES (451, '877943225', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877943225', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.028455', '2023-08-29 15:41:08.028455');
INSERT INTO public.virksomhet VALUES (452, '894353446', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894353446', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.063309', '2023-08-29 15:41:08.063309');
INSERT INTO public.virksomhet VALUES (453, '843899480', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843899480', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.088232', '2023-08-29 15:41:08.088232');
INSERT INTO public.virksomhet VALUES (454, '864291871', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864291871', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.110023', '2023-08-29 15:41:08.110023');
INSERT INTO public.virksomhet VALUES (455, '871725956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871725956', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.1438', '2023-08-29 15:41:08.1438');
INSERT INTO public.virksomhet VALUES (456, '852516782', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852516782', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.167534', '2023-08-29 15:41:08.167534');
INSERT INTO public.virksomhet VALUES (457, '869347173', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869347173', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.195614', '2023-08-29 15:41:08.195614');
INSERT INTO public.virksomhet VALUES (458, '822984515', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822984515', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.222928', '2023-08-29 15:41:08.222928');
INSERT INTO public.virksomhet VALUES (459, '820967644', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820967644', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.248877', '2023-08-29 15:41:08.248877');
INSERT INTO public.virksomhet VALUES (460, '812040694', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812040694', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.273421', '2023-08-29 15:41:08.273421');
INSERT INTO public.virksomhet VALUES (461, '812596296', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812596296', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.303102', '2023-08-29 15:41:08.303102');
INSERT INTO public.virksomhet VALUES (462, '825796909', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825796909', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.325052', '2023-08-29 15:41:08.325052');
INSERT INTO public.virksomhet VALUES (463, '888220534', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888220534', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.354812', '2023-08-29 15:41:08.354812');
INSERT INTO public.virksomhet VALUES (464, '828546683', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828546683', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.376026', '2023-08-29 15:41:08.376026');
INSERT INTO public.virksomhet VALUES (465, '888888152', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888888152', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.417857', '2023-08-29 15:41:08.417857');
INSERT INTO public.virksomhet VALUES (466, '806544734', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806544734', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.468656', '2023-08-29 15:41:08.468656');
INSERT INTO public.virksomhet VALUES (467, '861855954', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861855954', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.488935', '2023-08-29 15:41:08.488935');
INSERT INTO public.virksomhet VALUES (468, '826747324', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826747324', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.509096', '2023-08-29 15:41:08.509096');
INSERT INTO public.virksomhet VALUES (469, '823421563', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823421563', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.536987', '2023-08-29 15:41:08.536987');
INSERT INTO public.virksomhet VALUES (470, '864279810', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864279810', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.569748', '2023-08-29 15:41:08.569748');
INSERT INTO public.virksomhet VALUES (471, '815059394', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815059394', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.603224', '2023-08-29 15:41:08.603224');
INSERT INTO public.virksomhet VALUES (472, '800677974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800677974', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.633667', '2023-08-29 15:41:08.633667');
INSERT INTO public.virksomhet VALUES (473, '869709608', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869709608', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.669739', '2023-08-29 15:41:08.669739');
INSERT INTO public.virksomhet VALUES (474, '837340038', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837340038', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.699631', '2023-08-29 15:41:08.699631');
INSERT INTO public.virksomhet VALUES (475, '878196649', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878196649', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.721082', '2023-08-29 15:41:08.721082');
INSERT INTO public.virksomhet VALUES (476, '855021005', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855021005', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.745191', '2023-08-29 15:41:08.745191');
INSERT INTO public.virksomhet VALUES (477, '842874686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842874686', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.768269', '2023-08-29 15:41:08.768269');
INSERT INTO public.virksomhet VALUES (478, '897678406', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897678406', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.790685', '2023-08-29 15:41:08.790685');
INSERT INTO public.virksomhet VALUES (479, '822440491', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822440491', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.827586', '2023-08-29 15:41:08.827586');
INSERT INTO public.virksomhet VALUES (480, '895236942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895236942', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.84775', '2023-08-29 15:41:08.84775');
INSERT INTO public.virksomhet VALUES (481, '873250306', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873250306', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.870117', '2023-08-29 15:41:08.870117');
INSERT INTO public.virksomhet VALUES (482, '896136191', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896136191', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.935876', '2023-08-29 15:41:08.935876');
INSERT INTO public.virksomhet VALUES (483, '830923847', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830923847', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:08.989696', '2023-08-29 15:41:08.989696');
INSERT INTO public.virksomhet VALUES (484, '839016903', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839016903', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.043216', '2023-08-29 15:41:09.043216');
INSERT INTO public.virksomhet VALUES (485, '840910627', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840910627', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.079058', '2023-08-29 15:41:09.079058');
INSERT INTO public.virksomhet VALUES (486, '826212807', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826212807', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.111039', '2023-08-29 15:41:09.111039');
INSERT INTO public.virksomhet VALUES (487, '830146348', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830146348', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.137809', '2023-08-29 15:41:09.137809');
INSERT INTO public.virksomhet VALUES (488, '865855341', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865855341', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.157412', '2023-08-29 15:41:09.157412');
INSERT INTO public.virksomhet VALUES (489, '813254974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813254974', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.179358', '2023-08-29 15:41:09.179358');
INSERT INTO public.virksomhet VALUES (490, '878458400', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878458400', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.201139', '2023-08-29 15:41:09.201139');
INSERT INTO public.virksomhet VALUES (491, '819718155', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819718155', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.22688', '2023-08-29 15:41:09.22688');
INSERT INTO public.virksomhet VALUES (492, '840048395', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840048395', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.248273', '2023-08-29 15:41:09.248273');
INSERT INTO public.virksomhet VALUES (493, '817049990', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817049990', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.271599', '2023-08-29 15:41:09.271599');
INSERT INTO public.virksomhet VALUES (494, '823217376', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823217376', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.307673', '2023-08-29 15:41:09.307673');
INSERT INTO public.virksomhet VALUES (495, '814797335', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814797335', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.330753', '2023-08-29 15:41:09.330753');
INSERT INTO public.virksomhet VALUES (496, '863017059', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863017059', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.368372', '2023-08-29 15:41:09.368372');
INSERT INTO public.virksomhet VALUES (497, '829272494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829272494', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.400842', '2023-08-29 15:41:09.400842');
INSERT INTO public.virksomhet VALUES (498, '821621583', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821621583', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.426949', '2023-08-29 15:41:09.426949');
INSERT INTO public.virksomhet VALUES (499, '808719782', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808719782', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.467295', '2023-08-29 15:41:09.467295');
INSERT INTO public.virksomhet VALUES (500, '805762106', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805762106', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.507597', '2023-08-29 15:41:09.507597');
INSERT INTO public.virksomhet VALUES (501, '823603319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823603319', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.54768', '2023-08-29 15:41:09.54768');
INSERT INTO public.virksomhet VALUES (502, '824698886', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824698886', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.579853', '2023-08-29 15:41:09.579853');
INSERT INTO public.virksomhet VALUES (503, '829645138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829645138', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.604753', '2023-08-29 15:41:09.604753');
INSERT INTO public.virksomhet VALUES (504, '826280365', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826280365', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.629232', '2023-08-29 15:41:09.629232');
INSERT INTO public.virksomhet VALUES (505, '840922156', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840922156', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.665812', '2023-08-29 15:41:09.665812');
INSERT INTO public.virksomhet VALUES (506, '869270642', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869270642', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.689809', '2023-08-29 15:41:09.689809');
INSERT INTO public.virksomhet VALUES (507, '846201495', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846201495', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.723998', '2023-08-29 15:41:09.723998');
INSERT INTO public.virksomhet VALUES (508, '895595058', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895595058', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.746826', '2023-08-29 15:41:09.746826');
INSERT INTO public.virksomhet VALUES (509, '880255752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880255752', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.770912', '2023-08-29 15:41:09.770912');
INSERT INTO public.virksomhet VALUES (510, '883516756', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883516756', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:09.8207', '2023-08-29 15:41:09.8207');
INSERT INTO public.virksomhet VALUES (511, '823825914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823825914', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-08-29 15:41:20.350504', '2023-08-29 15:41:20.350504');
INSERT INTO public.virksomhet VALUES (512, '891494743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '347494198 nvaN', '{adresse}', 'AKTIV', NULL, 891494744, '2023-08-29 15:41:20.389088', '2023-08-29 15:41:27.578349');
INSERT INTO public.virksomhet VALUES (513, '866996950', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '059699668 nvaN', '{adresse}', 'AKTIV', NULL, 866996951, '2023-08-29 15:41:20.420911', '2023-08-29 15:41:27.595472');
INSERT INTO public.virksomhet VALUES (514, '878276775', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '577672878 nvaN', '{adresse}', 'AKTIV', NULL, 878276776, '2023-08-29 15:41:20.444787', '2023-08-29 15:41:27.598425');
INSERT INTO public.virksomhet VALUES (515, '835631853', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '358136538 nvaN', '{adresse}', 'AKTIV', NULL, 835631854, '2023-08-29 15:41:20.465341', '2023-08-29 15:41:27.626752');
INSERT INTO public.virksomhet VALUES (516, '804345056', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '650543408 nvaN', '{adresse}', 'AKTIV', NULL, 804345057, '2023-08-29 15:41:20.494294', '2023-08-29 15:41:27.635945');
INSERT INTO public.virksomhet VALUES (527, '864176730', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '037671468 nvaN', '{adresse}', 'AKTIV', NULL, 864176731, '2023-08-29 15:41:20.824039', '2023-08-29 15:41:27.64651');
INSERT INTO public.virksomhet VALUES (517, '863529173', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863529173', '{adresse}', 'FJERNET', '2023-01-01', 863529174, '2023-08-29 15:41:20.528008', '2023-08-29 15:41:27.650715');
INSERT INTO public.virksomhet VALUES (518, '873351078', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873351078', '{adresse}', 'FJERNET', '2023-01-01', 873351079, '2023-08-29 15:41:20.554668', '2023-08-29 15:41:27.655189');
INSERT INTO public.virksomhet VALUES (519, '881715947', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881715947', '{adresse}', 'FJERNET', '2023-01-01', 881715948, '2023-08-29 15:41:20.578161', '2023-08-29 15:41:27.65708');
INSERT INTO public.virksomhet VALUES (520, '812300486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812300486', '{adresse}', 'FJERNET', '2023-01-01', 812300487, '2023-08-29 15:41:20.603028', '2023-08-29 15:41:27.658736');
INSERT INTO public.virksomhet VALUES (521, '819978335', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819978335', '{adresse}', 'FJERNET', '2023-01-01', 819978336, '2023-08-29 15:41:20.625684', '2023-08-29 15:41:27.660112');
INSERT INTO public.virksomhet VALUES (522, '800406757', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800406757', '{adresse}', 'SLETTET', '2023-01-01', 800406758, '2023-08-29 15:41:20.647472', '2023-08-29 15:41:27.678981');
INSERT INTO public.virksomhet VALUES (523, '893603727', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893603727', '{adresse}', 'SLETTET', '2023-01-01', 893603728, '2023-08-29 15:41:20.688071', '2023-08-29 15:41:27.682871');
INSERT INTO public.virksomhet VALUES (524, '803556311', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803556311', '{adresse}', 'SLETTET', '2023-01-01', 803556312, '2023-08-29 15:41:20.708944', '2023-08-29 15:41:27.684512');
INSERT INTO public.virksomhet VALUES (525, '881416980', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881416980', '{adresse}', 'SLETTET', '2023-01-01', 881416981, '2023-08-29 15:41:20.756555', '2023-08-29 15:41:27.687926');
INSERT INTO public.virksomhet VALUES (526, '879409878', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879409878', '{adresse}', 'SLETTET', '2023-01-01', 879409879, '2023-08-29 15:41:20.791308', '2023-08-29 15:41:27.689471');
INSERT INTO public.virksomhet VALUES (534, '883758182', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883758182', '{adresse}', 'AKTIV', NULL, 883758183, '2023-08-29 15:41:27.737413', '2023-08-29 15:41:27.737413');
INSERT INTO public.virksomhet VALUES (535, '860222235', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860222235', '{adresse}', 'AKTIV', NULL, 860222236, '2023-08-29 15:41:27.744786', '2023-08-29 15:41:27.744786');
INSERT INTO public.virksomhet VALUES (536, '808583998', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808583998', '{adresse}', 'AKTIV', NULL, 808583999, '2023-08-29 15:41:27.749923', '2023-08-29 15:41:27.749923');
INSERT INTO public.virksomhet VALUES (537, '848923035', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848923035', '{adresse}', 'AKTIV', NULL, 848923036, '2023-08-29 15:41:27.755656', '2023-08-29 15:41:27.755656');
INSERT INTO public.virksomhet VALUES (538, '820560282', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820560282', '{adresse}', 'AKTIV', NULL, 820560283, '2023-08-29 15:41:27.761532', '2023-08-29 15:41:27.761532');


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
INSERT INTO public.virksomhet_naring VALUES (5, '70.220');
INSERT INTO public.virksomhet_naring VALUES (6, '01.120');
INSERT INTO public.virksomhet_naring VALUES (7, '01.120');
INSERT INTO public.virksomhet_naring VALUES (8, '01.120');
INSERT INTO public.virksomhet_naring VALUES (8, '90.012');
INSERT INTO public.virksomhet_naring VALUES (8, '70.220');
INSERT INTO public.virksomhet_naring VALUES (9, '01.120');
INSERT INTO public.virksomhet_naring VALUES (10, '01.120');
INSERT INTO public.virksomhet_naring VALUES (11, '01.120');
INSERT INTO public.virksomhet_naring VALUES (12, '01.120');
INSERT INTO public.virksomhet_naring VALUES (12, '90.012');
INSERT INTO public.virksomhet_naring VALUES (13, '01.120');
INSERT INTO public.virksomhet_naring VALUES (14, '01.120');
INSERT INTO public.virksomhet_naring VALUES (14, '90.012');
INSERT INTO public.virksomhet_naring VALUES (15, '01.120');
INSERT INTO public.virksomhet_naring VALUES (15, '90.012');
INSERT INTO public.virksomhet_naring VALUES (16, '01.120');
INSERT INTO public.virksomhet_naring VALUES (16, '90.012');
INSERT INTO public.virksomhet_naring VALUES (17, '01.120');
INSERT INTO public.virksomhet_naring VALUES (17, '90.012');
INSERT INTO public.virksomhet_naring VALUES (18, '01.120');
INSERT INTO public.virksomhet_naring VALUES (18, '90.012');
INSERT INTO public.virksomhet_naring VALUES (19, '01.120');
INSERT INTO public.virksomhet_naring VALUES (20, '01.120');
INSERT INTO public.virksomhet_naring VALUES (21, '01.120');
INSERT INTO public.virksomhet_naring VALUES (21, '90.012');
INSERT INTO public.virksomhet_naring VALUES (21, '70.220');
INSERT INTO public.virksomhet_naring VALUES (22, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '01.120');
INSERT INTO public.virksomhet_naring VALUES (23, '90.012');
INSERT INTO public.virksomhet_naring VALUES (24, '01.120');
INSERT INTO public.virksomhet_naring VALUES (25, '01.120');
INSERT INTO public.virksomhet_naring VALUES (26, '01.120');
INSERT INTO public.virksomhet_naring VALUES (26, '90.012');
INSERT INTO public.virksomhet_naring VALUES (26, '70.220');
INSERT INTO public.virksomhet_naring VALUES (27, '01.120');
INSERT INTO public.virksomhet_naring VALUES (27, '90.012');
INSERT INTO public.virksomhet_naring VALUES (27, '70.220');
INSERT INTO public.virksomhet_naring VALUES (28, '01.120');
INSERT INTO public.virksomhet_naring VALUES (28, '90.012');
INSERT INTO public.virksomhet_naring VALUES (29, '01.120');
INSERT INTO public.virksomhet_naring VALUES (29, '90.012');
INSERT INTO public.virksomhet_naring VALUES (29, '70.220');
INSERT INTO public.virksomhet_naring VALUES (30, '01.120');
INSERT INTO public.virksomhet_naring VALUES (31, '01.120');
INSERT INTO public.virksomhet_naring VALUES (32, '01.120');
INSERT INTO public.virksomhet_naring VALUES (32, '90.012');
INSERT INTO public.virksomhet_naring VALUES (32, '70.220');
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
INSERT INTO public.virksomhet_naring VALUES (44, '01.120');
INSERT INTO public.virksomhet_naring VALUES (44, '90.012');
INSERT INTO public.virksomhet_naring VALUES (45, '01.120');
INSERT INTO public.virksomhet_naring VALUES (46, '01.120');
INSERT INTO public.virksomhet_naring VALUES (46, '90.012');
INSERT INTO public.virksomhet_naring VALUES (46, '70.220');
INSERT INTO public.virksomhet_naring VALUES (47, '01.120');
INSERT INTO public.virksomhet_naring VALUES (48, '01.120');
INSERT INTO public.virksomhet_naring VALUES (49, '01.120');
INSERT INTO public.virksomhet_naring VALUES (50, '01.120');
INSERT INTO public.virksomhet_naring VALUES (51, '01.120');
INSERT INTO public.virksomhet_naring VALUES (52, '01.120');
INSERT INTO public.virksomhet_naring VALUES (52, '90.012');
INSERT INTO public.virksomhet_naring VALUES (53, '01.120');
INSERT INTO public.virksomhet_naring VALUES (54, '01.120');
INSERT INTO public.virksomhet_naring VALUES (55, '01.120');
INSERT INTO public.virksomhet_naring VALUES (55, '90.012');
INSERT INTO public.virksomhet_naring VALUES (56, '01.120');
INSERT INTO public.virksomhet_naring VALUES (56, '90.012');
INSERT INTO public.virksomhet_naring VALUES (56, '70.220');
INSERT INTO public.virksomhet_naring VALUES (57, '01.120');
INSERT INTO public.virksomhet_naring VALUES (57, '90.012');
INSERT INTO public.virksomhet_naring VALUES (57, '70.220');
INSERT INTO public.virksomhet_naring VALUES (58, '01.120');
INSERT INTO public.virksomhet_naring VALUES (58, '90.012');
INSERT INTO public.virksomhet_naring VALUES (58, '70.220');
INSERT INTO public.virksomhet_naring VALUES (59, '01.120');
INSERT INTO public.virksomhet_naring VALUES (59, '90.012');
INSERT INTO public.virksomhet_naring VALUES (60, '01.120');
INSERT INTO public.virksomhet_naring VALUES (60, '90.012');
INSERT INTO public.virksomhet_naring VALUES (60, '70.220');
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
INSERT INTO public.virksomhet_naring VALUES (68, '01.120');
INSERT INTO public.virksomhet_naring VALUES (68, '90.012');
INSERT INTO public.virksomhet_naring VALUES (68, '70.220');
INSERT INTO public.virksomhet_naring VALUES (69, '01.120');
INSERT INTO public.virksomhet_naring VALUES (70, '01.120');
INSERT INTO public.virksomhet_naring VALUES (71, '01.120');
INSERT INTO public.virksomhet_naring VALUES (71, '90.012');
INSERT INTO public.virksomhet_naring VALUES (72, '01.120');
INSERT INTO public.virksomhet_naring VALUES (72, '90.012');
INSERT INTO public.virksomhet_naring VALUES (73, '01.120');
INSERT INTO public.virksomhet_naring VALUES (74, '01.120');
INSERT INTO public.virksomhet_naring VALUES (74, '90.012');
INSERT INTO public.virksomhet_naring VALUES (74, '70.220');
INSERT INTO public.virksomhet_naring VALUES (75, '01.120');
INSERT INTO public.virksomhet_naring VALUES (75, '90.012');
INSERT INTO public.virksomhet_naring VALUES (76, '01.120');
INSERT INTO public.virksomhet_naring VALUES (77, '01.120');
INSERT INTO public.virksomhet_naring VALUES (77, '90.012');
INSERT INTO public.virksomhet_naring VALUES (78, '01.120');
INSERT INTO public.virksomhet_naring VALUES (78, '90.012');
INSERT INTO public.virksomhet_naring VALUES (79, '01.120');
INSERT INTO public.virksomhet_naring VALUES (79, '90.012');
INSERT INTO public.virksomhet_naring VALUES (79, '70.220');
INSERT INTO public.virksomhet_naring VALUES (80, '01.120');
INSERT INTO public.virksomhet_naring VALUES (80, '90.012');
INSERT INTO public.virksomhet_naring VALUES (81, '01.120');
INSERT INTO public.virksomhet_naring VALUES (81, '90.012');
INSERT INTO public.virksomhet_naring VALUES (81, '70.220');
INSERT INTO public.virksomhet_naring VALUES (82, '01.120');
INSERT INTO public.virksomhet_naring VALUES (82, '90.012');
INSERT INTO public.virksomhet_naring VALUES (83, '01.120');
INSERT INTO public.virksomhet_naring VALUES (84, '01.120');
INSERT INTO public.virksomhet_naring VALUES (84, '90.012');
INSERT INTO public.virksomhet_naring VALUES (85, '01.120');
INSERT INTO public.virksomhet_naring VALUES (85, '90.012');
INSERT INTO public.virksomhet_naring VALUES (86, '01.120');
INSERT INTO public.virksomhet_naring VALUES (87, '01.120');
INSERT INTO public.virksomhet_naring VALUES (88, '01.120');
INSERT INTO public.virksomhet_naring VALUES (88, '90.012');
INSERT INTO public.virksomhet_naring VALUES (89, '01.120');
INSERT INTO public.virksomhet_naring VALUES (89, '90.012');
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
INSERT INTO public.virksomhet_naring VALUES (96, '70.220');
INSERT INTO public.virksomhet_naring VALUES (97, '01.120');
INSERT INTO public.virksomhet_naring VALUES (98, '01.120');
INSERT INTO public.virksomhet_naring VALUES (98, '90.012');
INSERT INTO public.virksomhet_naring VALUES (99, '01.120');
INSERT INTO public.virksomhet_naring VALUES (100, '01.120');
INSERT INTO public.virksomhet_naring VALUES (100, '90.012');
INSERT INTO public.virksomhet_naring VALUES (101, '01.120');
INSERT INTO public.virksomhet_naring VALUES (101, '90.012');
INSERT INTO public.virksomhet_naring VALUES (101, '70.220');
INSERT INTO public.virksomhet_naring VALUES (102, '01.120');
INSERT INTO public.virksomhet_naring VALUES (102, '90.012');
INSERT INTO public.virksomhet_naring VALUES (103, '01.120');
INSERT INTO public.virksomhet_naring VALUES (103, '90.012');
INSERT INTO public.virksomhet_naring VALUES (104, '01.120');
INSERT INTO public.virksomhet_naring VALUES (104, '90.012');
INSERT INTO public.virksomhet_naring VALUES (105, '01.120');
INSERT INTO public.virksomhet_naring VALUES (106, '01.120');
INSERT INTO public.virksomhet_naring VALUES (107, '01.120');
INSERT INTO public.virksomhet_naring VALUES (108, '01.120');
INSERT INTO public.virksomhet_naring VALUES (108, '90.012');
INSERT INTO public.virksomhet_naring VALUES (109, '01.120');
INSERT INTO public.virksomhet_naring VALUES (110, '01.120');
INSERT INTO public.virksomhet_naring VALUES (111, '01.120');
INSERT INTO public.virksomhet_naring VALUES (111, '90.012');
INSERT INTO public.virksomhet_naring VALUES (111, '70.220');
INSERT INTO public.virksomhet_naring VALUES (112, '01.120');
INSERT INTO public.virksomhet_naring VALUES (112, '90.012');
INSERT INTO public.virksomhet_naring VALUES (113, '01.120');
INSERT INTO public.virksomhet_naring VALUES (113, '90.012');
INSERT INTO public.virksomhet_naring VALUES (113, '70.220');
INSERT INTO public.virksomhet_naring VALUES (114, '01.120');
INSERT INTO public.virksomhet_naring VALUES (114, '90.012');
INSERT INTO public.virksomhet_naring VALUES (115, '01.120');
INSERT INTO public.virksomhet_naring VALUES (116, '01.120');
INSERT INTO public.virksomhet_naring VALUES (116, '90.012');
INSERT INTO public.virksomhet_naring VALUES (116, '70.220');
INSERT INTO public.virksomhet_naring VALUES (117, '01.120');
INSERT INTO public.virksomhet_naring VALUES (118, '01.120');
INSERT INTO public.virksomhet_naring VALUES (118, '90.012');
INSERT INTO public.virksomhet_naring VALUES (119, '01.120');
INSERT INTO public.virksomhet_naring VALUES (120, '01.120');
INSERT INTO public.virksomhet_naring VALUES (121, '01.120');
INSERT INTO public.virksomhet_naring VALUES (121, '90.012');
INSERT INTO public.virksomhet_naring VALUES (121, '70.220');
INSERT INTO public.virksomhet_naring VALUES (122, '01.120');
INSERT INTO public.virksomhet_naring VALUES (123, '01.120');
INSERT INTO public.virksomhet_naring VALUES (123, '90.012');
INSERT INTO public.virksomhet_naring VALUES (123, '70.220');
INSERT INTO public.virksomhet_naring VALUES (124, '01.120');
INSERT INTO public.virksomhet_naring VALUES (125, '01.120');
INSERT INTO public.virksomhet_naring VALUES (126, '01.120');
INSERT INTO public.virksomhet_naring VALUES (126, '90.012');
INSERT INTO public.virksomhet_naring VALUES (127, '01.120');
INSERT INTO public.virksomhet_naring VALUES (128, '01.120');
INSERT INTO public.virksomhet_naring VALUES (128, '90.012');
INSERT INTO public.virksomhet_naring VALUES (129, '01.120');
INSERT INTO public.virksomhet_naring VALUES (130, '01.120');
INSERT INTO public.virksomhet_naring VALUES (130, '90.012');
INSERT INTO public.virksomhet_naring VALUES (131, '01.120');
INSERT INTO public.virksomhet_naring VALUES (131, '90.012');
INSERT INTO public.virksomhet_naring VALUES (132, '01.120');
INSERT INTO public.virksomhet_naring VALUES (132, '90.012');
INSERT INTO public.virksomhet_naring VALUES (132, '70.220');
INSERT INTO public.virksomhet_naring VALUES (133, '01.120');
INSERT INTO public.virksomhet_naring VALUES (134, '01.120');
INSERT INTO public.virksomhet_naring VALUES (134, '90.012');
INSERT INTO public.virksomhet_naring VALUES (135, '01.120');
INSERT INTO public.virksomhet_naring VALUES (136, '01.120');
INSERT INTO public.virksomhet_naring VALUES (137, '01.120');
INSERT INTO public.virksomhet_naring VALUES (138, '01.120');
INSERT INTO public.virksomhet_naring VALUES (138, '90.012');
INSERT INTO public.virksomhet_naring VALUES (139, '01.120');
INSERT INTO public.virksomhet_naring VALUES (139, '90.012');
INSERT INTO public.virksomhet_naring VALUES (139, '70.220');
INSERT INTO public.virksomhet_naring VALUES (140, '01.120');
INSERT INTO public.virksomhet_naring VALUES (141, '01.120');
INSERT INTO public.virksomhet_naring VALUES (142, '01.120');
INSERT INTO public.virksomhet_naring VALUES (143, '01.120');
INSERT INTO public.virksomhet_naring VALUES (144, '01.120');
INSERT INTO public.virksomhet_naring VALUES (144, '90.012');
INSERT INTO public.virksomhet_naring VALUES (145, '01.120');
INSERT INTO public.virksomhet_naring VALUES (146, '01.120');
INSERT INTO public.virksomhet_naring VALUES (146, '90.012');
INSERT INTO public.virksomhet_naring VALUES (147, '01.120');
INSERT INTO public.virksomhet_naring VALUES (148, '01.120');
INSERT INTO public.virksomhet_naring VALUES (149, '01.120');
INSERT INTO public.virksomhet_naring VALUES (150, '01.120');
INSERT INTO public.virksomhet_naring VALUES (150, '90.012');
INSERT INTO public.virksomhet_naring VALUES (150, '70.220');
INSERT INTO public.virksomhet_naring VALUES (151, '01.120');
INSERT INTO public.virksomhet_naring VALUES (151, '90.012');
INSERT INTO public.virksomhet_naring VALUES (152, '01.120');
INSERT INTO public.virksomhet_naring VALUES (153, '01.120');
INSERT INTO public.virksomhet_naring VALUES (154, '01.120');
INSERT INTO public.virksomhet_naring VALUES (154, '90.012');
INSERT INTO public.virksomhet_naring VALUES (155, '01.120');
INSERT INTO public.virksomhet_naring VALUES (156, '01.120');
INSERT INTO public.virksomhet_naring VALUES (156, '90.012');
INSERT INTO public.virksomhet_naring VALUES (157, '01.120');
INSERT INTO public.virksomhet_naring VALUES (157, '90.012');
INSERT INTO public.virksomhet_naring VALUES (158, '01.120');
INSERT INTO public.virksomhet_naring VALUES (159, '01.120');
INSERT INTO public.virksomhet_naring VALUES (160, '01.120');
INSERT INTO public.virksomhet_naring VALUES (161, '01.120');
INSERT INTO public.virksomhet_naring VALUES (161, '90.012');
INSERT INTO public.virksomhet_naring VALUES (161, '70.220');
INSERT INTO public.virksomhet_naring VALUES (162, '01.120');
INSERT INTO public.virksomhet_naring VALUES (162, '90.012');
INSERT INTO public.virksomhet_naring VALUES (163, '01.120');
INSERT INTO public.virksomhet_naring VALUES (163, '90.012');
INSERT INTO public.virksomhet_naring VALUES (163, '70.220');
INSERT INTO public.virksomhet_naring VALUES (164, '01.120');
INSERT INTO public.virksomhet_naring VALUES (164, '90.012');
INSERT INTO public.virksomhet_naring VALUES (165, '01.120');
INSERT INTO public.virksomhet_naring VALUES (166, '01.120');
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
INSERT INTO public.virksomhet_naring VALUES (176, '01.120');
INSERT INTO public.virksomhet_naring VALUES (177, '01.120');
INSERT INTO public.virksomhet_naring VALUES (177, '90.012');
INSERT INTO public.virksomhet_naring VALUES (178, '01.120');
INSERT INTO public.virksomhet_naring VALUES (178, '90.012');
INSERT INTO public.virksomhet_naring VALUES (178, '70.220');
INSERT INTO public.virksomhet_naring VALUES (179, '01.120');
INSERT INTO public.virksomhet_naring VALUES (179, '90.012');
INSERT INTO public.virksomhet_naring VALUES (180, '01.120');
INSERT INTO public.virksomhet_naring VALUES (181, '01.120');
INSERT INTO public.virksomhet_naring VALUES (181, '90.012');
INSERT INTO public.virksomhet_naring VALUES (182, '01.120');
INSERT INTO public.virksomhet_naring VALUES (183, '01.120');
INSERT INTO public.virksomhet_naring VALUES (183, '90.012');
INSERT INTO public.virksomhet_naring VALUES (183, '70.220');
INSERT INTO public.virksomhet_naring VALUES (184, '01.120');
INSERT INTO public.virksomhet_naring VALUES (184, '90.012');
INSERT INTO public.virksomhet_naring VALUES (184, '70.220');
INSERT INTO public.virksomhet_naring VALUES (185, '01.120');
INSERT INTO public.virksomhet_naring VALUES (185, '90.012');
INSERT INTO public.virksomhet_naring VALUES (186, '01.120');
INSERT INTO public.virksomhet_naring VALUES (187, '01.120');
INSERT INTO public.virksomhet_naring VALUES (187, '90.012');
INSERT INTO public.virksomhet_naring VALUES (188, '01.120');
INSERT INTO public.virksomhet_naring VALUES (188, '90.012');
INSERT INTO public.virksomhet_naring VALUES (189, '01.120');
INSERT INTO public.virksomhet_naring VALUES (190, '01.120');
INSERT INTO public.virksomhet_naring VALUES (191, '01.120');
INSERT INTO public.virksomhet_naring VALUES (191, '90.012');
INSERT INTO public.virksomhet_naring VALUES (192, '01.120');
INSERT INTO public.virksomhet_naring VALUES (192, '90.012');
INSERT INTO public.virksomhet_naring VALUES (193, '01.120');
INSERT INTO public.virksomhet_naring VALUES (193, '90.012');
INSERT INTO public.virksomhet_naring VALUES (194, '01.120');
INSERT INTO public.virksomhet_naring VALUES (195, '01.120');
INSERT INTO public.virksomhet_naring VALUES (195, '90.012');
INSERT INTO public.virksomhet_naring VALUES (195, '70.220');
INSERT INTO public.virksomhet_naring VALUES (196, '01.120');
INSERT INTO public.virksomhet_naring VALUES (196, '90.012');
INSERT INTO public.virksomhet_naring VALUES (196, '70.220');
INSERT INTO public.virksomhet_naring VALUES (197, '01.120');
INSERT INTO public.virksomhet_naring VALUES (198, '01.120');
INSERT INTO public.virksomhet_naring VALUES (198, '90.012');
INSERT INTO public.virksomhet_naring VALUES (199, '01.120');
INSERT INTO public.virksomhet_naring VALUES (200, '01.120');
INSERT INTO public.virksomhet_naring VALUES (201, '01.120');
INSERT INTO public.virksomhet_naring VALUES (202, '01.120');
INSERT INTO public.virksomhet_naring VALUES (202, '90.012');
INSERT INTO public.virksomhet_naring VALUES (202, '70.220');
INSERT INTO public.virksomhet_naring VALUES (203, '01.120');
INSERT INTO public.virksomhet_naring VALUES (204, '01.120');
INSERT INTO public.virksomhet_naring VALUES (205, '01.120');
INSERT INTO public.virksomhet_naring VALUES (206, '01.120');
INSERT INTO public.virksomhet_naring VALUES (206, '90.012');
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
INSERT INTO public.virksomhet_naring VALUES (211, '70.220');
INSERT INTO public.virksomhet_naring VALUES (212, '01.120');
INSERT INTO public.virksomhet_naring VALUES (212, '90.012');
INSERT INTO public.virksomhet_naring VALUES (213, '01.120');
INSERT INTO public.virksomhet_naring VALUES (214, '01.120');
INSERT INTO public.virksomhet_naring VALUES (215, '01.120');
INSERT INTO public.virksomhet_naring VALUES (216, '01.120');
INSERT INTO public.virksomhet_naring VALUES (216, '90.012');
INSERT INTO public.virksomhet_naring VALUES (217, '01.120');
INSERT INTO public.virksomhet_naring VALUES (217, '90.012');
INSERT INTO public.virksomhet_naring VALUES (218, '01.120');
INSERT INTO public.virksomhet_naring VALUES (218, '90.012');
INSERT INTO public.virksomhet_naring VALUES (219, '01.120');
INSERT INTO public.virksomhet_naring VALUES (220, '01.120');
INSERT INTO public.virksomhet_naring VALUES (220, '90.012');
INSERT INTO public.virksomhet_naring VALUES (221, '01.120');
INSERT INTO public.virksomhet_naring VALUES (222, '01.120');
INSERT INTO public.virksomhet_naring VALUES (223, '01.120');
INSERT INTO public.virksomhet_naring VALUES (224, '01.120');
INSERT INTO public.virksomhet_naring VALUES (224, '90.012');
INSERT INTO public.virksomhet_naring VALUES (225, '01.120');
INSERT INTO public.virksomhet_naring VALUES (225, '90.012');
INSERT INTO public.virksomhet_naring VALUES (225, '70.220');
INSERT INTO public.virksomhet_naring VALUES (226, '01.120');
INSERT INTO public.virksomhet_naring VALUES (227, '01.120');
INSERT INTO public.virksomhet_naring VALUES (227, '90.012');
INSERT INTO public.virksomhet_naring VALUES (228, '01.120');
INSERT INTO public.virksomhet_naring VALUES (229, '01.120');
INSERT INTO public.virksomhet_naring VALUES (230, '01.120');
INSERT INTO public.virksomhet_naring VALUES (231, '01.120');
INSERT INTO public.virksomhet_naring VALUES (231, '90.012');
INSERT INTO public.virksomhet_naring VALUES (232, '01.120');
INSERT INTO public.virksomhet_naring VALUES (232, '90.012');
INSERT INTO public.virksomhet_naring VALUES (233, '01.120');
INSERT INTO public.virksomhet_naring VALUES (233, '90.012');
INSERT INTO public.virksomhet_naring VALUES (234, '01.120');
INSERT INTO public.virksomhet_naring VALUES (235, '01.120');
INSERT INTO public.virksomhet_naring VALUES (236, '01.120');
INSERT INTO public.virksomhet_naring VALUES (236, '90.012');
INSERT INTO public.virksomhet_naring VALUES (237, '01.120');
INSERT INTO public.virksomhet_naring VALUES (238, '01.120');
INSERT INTO public.virksomhet_naring VALUES (238, '90.012');
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
INSERT INTO public.virksomhet_naring VALUES (246, '01.120');
INSERT INTO public.virksomhet_naring VALUES (246, '90.012');
INSERT INTO public.virksomhet_naring VALUES (247, '01.120');
INSERT INTO public.virksomhet_naring VALUES (248, '01.120');
INSERT INTO public.virksomhet_naring VALUES (248, '90.012');
INSERT INTO public.virksomhet_naring VALUES (249, '01.120');
INSERT INTO public.virksomhet_naring VALUES (250, '01.120');
INSERT INTO public.virksomhet_naring VALUES (250, '90.012');
INSERT INTO public.virksomhet_naring VALUES (250, '70.220');
INSERT INTO public.virksomhet_naring VALUES (251, '01.120');
INSERT INTO public.virksomhet_naring VALUES (251, '90.012');
INSERT INTO public.virksomhet_naring VALUES (252, '01.120');
INSERT INTO public.virksomhet_naring VALUES (253, '01.120');
INSERT INTO public.virksomhet_naring VALUES (253, '90.012');
INSERT INTO public.virksomhet_naring VALUES (254, '01.120');
INSERT INTO public.virksomhet_naring VALUES (254, '90.012');
INSERT INTO public.virksomhet_naring VALUES (255, '01.120');
INSERT INTO public.virksomhet_naring VALUES (256, '01.120');
INSERT INTO public.virksomhet_naring VALUES (257, '01.120');
INSERT INTO public.virksomhet_naring VALUES (257, '90.012');
INSERT INTO public.virksomhet_naring VALUES (258, '01.120');
INSERT INTO public.virksomhet_naring VALUES (258, '90.012');
INSERT INTO public.virksomhet_naring VALUES (259, '01.120');
INSERT INTO public.virksomhet_naring VALUES (260, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '01.120');
INSERT INTO public.virksomhet_naring VALUES (261, '90.012');
INSERT INTO public.virksomhet_naring VALUES (262, '01.120');
INSERT INTO public.virksomhet_naring VALUES (262, '90.012');
INSERT INTO public.virksomhet_naring VALUES (263, '01.120');
INSERT INTO public.virksomhet_naring VALUES (264, '01.120');
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
INSERT INTO public.virksomhet_naring VALUES (274, '01.120');
INSERT INTO public.virksomhet_naring VALUES (274, '90.012');
INSERT INTO public.virksomhet_naring VALUES (275, '01.120');
INSERT INTO public.virksomhet_naring VALUES (276, '01.120');
INSERT INTO public.virksomhet_naring VALUES (276, '90.012');
INSERT INTO public.virksomhet_naring VALUES (277, '01.120');
INSERT INTO public.virksomhet_naring VALUES (278, '01.120');
INSERT INTO public.virksomhet_naring VALUES (278, '90.012');
INSERT INTO public.virksomhet_naring VALUES (279, '01.120');
INSERT INTO public.virksomhet_naring VALUES (279, '90.012');
INSERT INTO public.virksomhet_naring VALUES (280, '01.120');
INSERT INTO public.virksomhet_naring VALUES (281, '01.120');
INSERT INTO public.virksomhet_naring VALUES (282, '01.120');
INSERT INTO public.virksomhet_naring VALUES (282, '90.012');
INSERT INTO public.virksomhet_naring VALUES (282, '70.220');
INSERT INTO public.virksomhet_naring VALUES (283, '01.120');
INSERT INTO public.virksomhet_naring VALUES (284, '01.120');
INSERT INTO public.virksomhet_naring VALUES (285, '01.120');
INSERT INTO public.virksomhet_naring VALUES (285, '90.012');
INSERT INTO public.virksomhet_naring VALUES (285, '70.220');
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
INSERT INTO public.virksomhet_naring VALUES (292, '90.012');
INSERT INTO public.virksomhet_naring VALUES (293, '01.120');
INSERT INTO public.virksomhet_naring VALUES (294, '01.120');
INSERT INTO public.virksomhet_naring VALUES (294, '90.012');
INSERT INTO public.virksomhet_naring VALUES (294, '70.220');
INSERT INTO public.virksomhet_naring VALUES (295, '01.120');
INSERT INTO public.virksomhet_naring VALUES (296, '01.120');
INSERT INTO public.virksomhet_naring VALUES (296, '90.012');
INSERT INTO public.virksomhet_naring VALUES (296, '70.220');
INSERT INTO public.virksomhet_naring VALUES (297, '01.120');
INSERT INTO public.virksomhet_naring VALUES (298, '01.120');
INSERT INTO public.virksomhet_naring VALUES (299, '01.120');
INSERT INTO public.virksomhet_naring VALUES (299, '90.012');
INSERT INTO public.virksomhet_naring VALUES (300, '01.120');
INSERT INTO public.virksomhet_naring VALUES (301, '01.120');
INSERT INTO public.virksomhet_naring VALUES (301, '90.012');
INSERT INTO public.virksomhet_naring VALUES (301, '70.220');
INSERT INTO public.virksomhet_naring VALUES (302, '01.120');
INSERT INTO public.virksomhet_naring VALUES (302, '90.012');
INSERT INTO public.virksomhet_naring VALUES (303, '01.120');
INSERT INTO public.virksomhet_naring VALUES (304, '01.120');
INSERT INTO public.virksomhet_naring VALUES (304, '90.012');
INSERT INTO public.virksomhet_naring VALUES (305, '01.120');
INSERT INTO public.virksomhet_naring VALUES (305, '90.012');
INSERT INTO public.virksomhet_naring VALUES (305, '70.220');
INSERT INTO public.virksomhet_naring VALUES (306, '01.120');
INSERT INTO public.virksomhet_naring VALUES (307, '01.120');
INSERT INTO public.virksomhet_naring VALUES (307, '90.012');
INSERT INTO public.virksomhet_naring VALUES (308, '01.120');
INSERT INTO public.virksomhet_naring VALUES (308, '90.012');
INSERT INTO public.virksomhet_naring VALUES (309, '01.120');
INSERT INTO public.virksomhet_naring VALUES (309, '90.012');
INSERT INTO public.virksomhet_naring VALUES (310, '01.120');
INSERT INTO public.virksomhet_naring VALUES (311, '01.120');
INSERT INTO public.virksomhet_naring VALUES (311, '90.012');
INSERT INTO public.virksomhet_naring VALUES (311, '70.220');
INSERT INTO public.virksomhet_naring VALUES (312, '01.120');
INSERT INTO public.virksomhet_naring VALUES (313, '01.120');
INSERT INTO public.virksomhet_naring VALUES (314, '01.120');
INSERT INTO public.virksomhet_naring VALUES (315, '01.120');
INSERT INTO public.virksomhet_naring VALUES (316, '01.120');
INSERT INTO public.virksomhet_naring VALUES (317, '01.120');
INSERT INTO public.virksomhet_naring VALUES (317, '90.012');
INSERT INTO public.virksomhet_naring VALUES (317, '70.220');
INSERT INTO public.virksomhet_naring VALUES (318, '01.120');
INSERT INTO public.virksomhet_naring VALUES (318, '90.012');
INSERT INTO public.virksomhet_naring VALUES (319, '01.120');
INSERT INTO public.virksomhet_naring VALUES (319, '90.012');
INSERT INTO public.virksomhet_naring VALUES (320, '01.120');
INSERT INTO public.virksomhet_naring VALUES (321, '01.120');
INSERT INTO public.virksomhet_naring VALUES (321, '90.012');
INSERT INTO public.virksomhet_naring VALUES (322, '01.120');
INSERT INTO public.virksomhet_naring VALUES (323, '01.120');
INSERT INTO public.virksomhet_naring VALUES (323, '90.012');
INSERT INTO public.virksomhet_naring VALUES (324, '01.120');
INSERT INTO public.virksomhet_naring VALUES (325, '01.120');
INSERT INTO public.virksomhet_naring VALUES (325, '90.012');
INSERT INTO public.virksomhet_naring VALUES (325, '70.220');
INSERT INTO public.virksomhet_naring VALUES (326, '01.120');
INSERT INTO public.virksomhet_naring VALUES (326, '90.012');
INSERT INTO public.virksomhet_naring VALUES (327, '01.120');
INSERT INTO public.virksomhet_naring VALUES (327, '90.012');
INSERT INTO public.virksomhet_naring VALUES (328, '01.120');
INSERT INTO public.virksomhet_naring VALUES (328, '90.012');
INSERT INTO public.virksomhet_naring VALUES (329, '01.120');
INSERT INTO public.virksomhet_naring VALUES (330, '01.120');
INSERT INTO public.virksomhet_naring VALUES (330, '90.012');
INSERT INTO public.virksomhet_naring VALUES (331, '01.120');
INSERT INTO public.virksomhet_naring VALUES (332, '01.120');
INSERT INTO public.virksomhet_naring VALUES (333, '01.120');
INSERT INTO public.virksomhet_naring VALUES (334, '01.120');
INSERT INTO public.virksomhet_naring VALUES (334, '90.012');
INSERT INTO public.virksomhet_naring VALUES (334, '70.220');
INSERT INTO public.virksomhet_naring VALUES (335, '01.120');
INSERT INTO public.virksomhet_naring VALUES (336, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '01.120');
INSERT INTO public.virksomhet_naring VALUES (337, '90.012');
INSERT INTO public.virksomhet_naring VALUES (338, '01.120');
INSERT INTO public.virksomhet_naring VALUES (339, '01.120');
INSERT INTO public.virksomhet_naring VALUES (339, '90.012');
INSERT INTO public.virksomhet_naring VALUES (339, '70.220');
INSERT INTO public.virksomhet_naring VALUES (340, '01.120');
INSERT INTO public.virksomhet_naring VALUES (341, '01.120');
INSERT INTO public.virksomhet_naring VALUES (342, '01.120');
INSERT INTO public.virksomhet_naring VALUES (342, '90.012');
INSERT INTO public.virksomhet_naring VALUES (343, '01.120');
INSERT INTO public.virksomhet_naring VALUES (343, '90.012');
INSERT INTO public.virksomhet_naring VALUES (344, '01.120');
INSERT INTO public.virksomhet_naring VALUES (344, '90.012');
INSERT INTO public.virksomhet_naring VALUES (345, '01.120');
INSERT INTO public.virksomhet_naring VALUES (345, '90.012');
INSERT INTO public.virksomhet_naring VALUES (346, '01.120');
INSERT INTO public.virksomhet_naring VALUES (346, '90.012');
INSERT INTO public.virksomhet_naring VALUES (347, '01.120');
INSERT INTO public.virksomhet_naring VALUES (347, '90.012');
INSERT INTO public.virksomhet_naring VALUES (347, '70.220');
INSERT INTO public.virksomhet_naring VALUES (348, '01.120');
INSERT INTO public.virksomhet_naring VALUES (349, '01.120');
INSERT INTO public.virksomhet_naring VALUES (349, '90.012');
INSERT INTO public.virksomhet_naring VALUES (349, '70.220');
INSERT INTO public.virksomhet_naring VALUES (350, '01.120');
INSERT INTO public.virksomhet_naring VALUES (351, '01.120');
INSERT INTO public.virksomhet_naring VALUES (352, '01.120');
INSERT INTO public.virksomhet_naring VALUES (353, '01.120');
INSERT INTO public.virksomhet_naring VALUES (353, '90.012');
INSERT INTO public.virksomhet_naring VALUES (354, '01.120');
INSERT INTO public.virksomhet_naring VALUES (354, '90.012');
INSERT INTO public.virksomhet_naring VALUES (354, '70.220');
INSERT INTO public.virksomhet_naring VALUES (355, '01.120');
INSERT INTO public.virksomhet_naring VALUES (356, '01.120');
INSERT INTO public.virksomhet_naring VALUES (356, '90.012');
INSERT INTO public.virksomhet_naring VALUES (357, '01.120');
INSERT INTO public.virksomhet_naring VALUES (358, '01.120');
INSERT INTO public.virksomhet_naring VALUES (359, '01.120');
INSERT INTO public.virksomhet_naring VALUES (360, '01.120');
INSERT INTO public.virksomhet_naring VALUES (361, '01.120');
INSERT INTO public.virksomhet_naring VALUES (362, '01.120');
INSERT INTO public.virksomhet_naring VALUES (363, '01.120');
INSERT INTO public.virksomhet_naring VALUES (364, '01.120');
INSERT INTO public.virksomhet_naring VALUES (364, '90.012');
INSERT INTO public.virksomhet_naring VALUES (365, '01.120');
INSERT INTO public.virksomhet_naring VALUES (365, '90.012');
INSERT INTO public.virksomhet_naring VALUES (366, '01.120');
INSERT INTO public.virksomhet_naring VALUES (367, '01.120');
INSERT INTO public.virksomhet_naring VALUES (368, '01.120');
INSERT INTO public.virksomhet_naring VALUES (369, '01.120');
INSERT INTO public.virksomhet_naring VALUES (369, '90.012');
INSERT INTO public.virksomhet_naring VALUES (370, '01.120');
INSERT INTO public.virksomhet_naring VALUES (371, '01.120');
INSERT INTO public.virksomhet_naring VALUES (371, '90.012');
INSERT INTO public.virksomhet_naring VALUES (372, '01.120');
INSERT INTO public.virksomhet_naring VALUES (373, '01.120');
INSERT INTO public.virksomhet_naring VALUES (373, '90.012');
INSERT INTO public.virksomhet_naring VALUES (373, '70.220');
INSERT INTO public.virksomhet_naring VALUES (374, '01.120');
INSERT INTO public.virksomhet_naring VALUES (375, '01.120');
INSERT INTO public.virksomhet_naring VALUES (376, '01.120');
INSERT INTO public.virksomhet_naring VALUES (376, '90.012');
INSERT INTO public.virksomhet_naring VALUES (377, '01.120');
INSERT INTO public.virksomhet_naring VALUES (378, '01.120');
INSERT INTO public.virksomhet_naring VALUES (379, '01.120');
INSERT INTO public.virksomhet_naring VALUES (379, '90.012');
INSERT INTO public.virksomhet_naring VALUES (380, '01.120');
INSERT INTO public.virksomhet_naring VALUES (381, '01.120');
INSERT INTO public.virksomhet_naring VALUES (382, '01.120');
INSERT INTO public.virksomhet_naring VALUES (382, '90.012');
INSERT INTO public.virksomhet_naring VALUES (383, '01.120');
INSERT INTO public.virksomhet_naring VALUES (383, '90.012');
INSERT INTO public.virksomhet_naring VALUES (384, '01.120');
INSERT INTO public.virksomhet_naring VALUES (384, '90.012');
INSERT INTO public.virksomhet_naring VALUES (385, '01.120');
INSERT INTO public.virksomhet_naring VALUES (385, '90.012');
INSERT INTO public.virksomhet_naring VALUES (386, '01.120');
INSERT INTO public.virksomhet_naring VALUES (386, '90.012');
INSERT INTO public.virksomhet_naring VALUES (387, '01.120');
INSERT INTO public.virksomhet_naring VALUES (387, '90.012');
INSERT INTO public.virksomhet_naring VALUES (387, '70.220');
INSERT INTO public.virksomhet_naring VALUES (388, '01.120');
INSERT INTO public.virksomhet_naring VALUES (389, '01.120');
INSERT INTO public.virksomhet_naring VALUES (390, '01.120');
INSERT INTO public.virksomhet_naring VALUES (391, '01.120');
INSERT INTO public.virksomhet_naring VALUES (392, '01.120');
INSERT INTO public.virksomhet_naring VALUES (393, '01.120');
INSERT INTO public.virksomhet_naring VALUES (394, '01.120');
INSERT INTO public.virksomhet_naring VALUES (394, '90.012');
INSERT INTO public.virksomhet_naring VALUES (395, '01.120');
INSERT INTO public.virksomhet_naring VALUES (396, '01.120');
INSERT INTO public.virksomhet_naring VALUES (397, '01.120');
INSERT INTO public.virksomhet_naring VALUES (398, '01.120');
INSERT INTO public.virksomhet_naring VALUES (398, '90.012');
INSERT INTO public.virksomhet_naring VALUES (398, '70.220');
INSERT INTO public.virksomhet_naring VALUES (399, '01.120');
INSERT INTO public.virksomhet_naring VALUES (400, '01.120');
INSERT INTO public.virksomhet_naring VALUES (401, '01.120');
INSERT INTO public.virksomhet_naring VALUES (401, '90.012');
INSERT INTO public.virksomhet_naring VALUES (401, '70.220');
INSERT INTO public.virksomhet_naring VALUES (402, '01.120');
INSERT INTO public.virksomhet_naring VALUES (403, '01.120');
INSERT INTO public.virksomhet_naring VALUES (404, '01.120');
INSERT INTO public.virksomhet_naring VALUES (404, '90.012');
INSERT INTO public.virksomhet_naring VALUES (405, '01.120');
INSERT INTO public.virksomhet_naring VALUES (405, '90.012');
INSERT INTO public.virksomhet_naring VALUES (405, '70.220');
INSERT INTO public.virksomhet_naring VALUES (406, '01.120');
INSERT INTO public.virksomhet_naring VALUES (406, '90.012');
INSERT INTO public.virksomhet_naring VALUES (406, '70.220');
INSERT INTO public.virksomhet_naring VALUES (407, '01.120');
INSERT INTO public.virksomhet_naring VALUES (407, '90.012');
INSERT INTO public.virksomhet_naring VALUES (407, '70.220');
INSERT INTO public.virksomhet_naring VALUES (408, '01.120');
INSERT INTO public.virksomhet_naring VALUES (409, '01.120');
INSERT INTO public.virksomhet_naring VALUES (410, '01.120');
INSERT INTO public.virksomhet_naring VALUES (411, '01.120');
INSERT INTO public.virksomhet_naring VALUES (411, '90.012');
INSERT INTO public.virksomhet_naring VALUES (412, '01.120');
INSERT INTO public.virksomhet_naring VALUES (412, '90.012');
INSERT INTO public.virksomhet_naring VALUES (413, '01.120');
INSERT INTO public.virksomhet_naring VALUES (414, '01.120');
INSERT INTO public.virksomhet_naring VALUES (415, '01.120');
INSERT INTO public.virksomhet_naring VALUES (415, '90.012');
INSERT INTO public.virksomhet_naring VALUES (415, '70.220');
INSERT INTO public.virksomhet_naring VALUES (416, '01.120');
INSERT INTO public.virksomhet_naring VALUES (416, '90.012');
INSERT INTO public.virksomhet_naring VALUES (417, '01.120');
INSERT INTO public.virksomhet_naring VALUES (418, '01.120');
INSERT INTO public.virksomhet_naring VALUES (418, '90.012');
INSERT INTO public.virksomhet_naring VALUES (419, '01.120');
INSERT INTO public.virksomhet_naring VALUES (420, '01.120');
INSERT INTO public.virksomhet_naring VALUES (420, '90.012');
INSERT INTO public.virksomhet_naring VALUES (421, '01.120');
INSERT INTO public.virksomhet_naring VALUES (421, '90.012');
INSERT INTO public.virksomhet_naring VALUES (422, '01.120');
INSERT INTO public.virksomhet_naring VALUES (423, '01.120');
INSERT INTO public.virksomhet_naring VALUES (423, '90.012');
INSERT INTO public.virksomhet_naring VALUES (424, '01.120');
INSERT INTO public.virksomhet_naring VALUES (425, '01.120');
INSERT INTO public.virksomhet_naring VALUES (426, '01.120');
INSERT INTO public.virksomhet_naring VALUES (427, '01.120');
INSERT INTO public.virksomhet_naring VALUES (427, '90.012');
INSERT INTO public.virksomhet_naring VALUES (428, '01.120');
INSERT INTO public.virksomhet_naring VALUES (429, '01.120');
INSERT INTO public.virksomhet_naring VALUES (430, '01.120');
INSERT INTO public.virksomhet_naring VALUES (431, '01.120');
INSERT INTO public.virksomhet_naring VALUES (432, '01.120');
INSERT INTO public.virksomhet_naring VALUES (433, '01.120');
INSERT INTO public.virksomhet_naring VALUES (434, '01.120');
INSERT INTO public.virksomhet_naring VALUES (434, '90.012');
INSERT INTO public.virksomhet_naring VALUES (435, '01.120');
INSERT INTO public.virksomhet_naring VALUES (436, '01.120');
INSERT INTO public.virksomhet_naring VALUES (436, '90.012');
INSERT INTO public.virksomhet_naring VALUES (436, '70.220');
INSERT INTO public.virksomhet_naring VALUES (437, '01.120');
INSERT INTO public.virksomhet_naring VALUES (437, '90.012');
INSERT INTO public.virksomhet_naring VALUES (438, '01.120');
INSERT INTO public.virksomhet_naring VALUES (439, '01.120');
INSERT INTO public.virksomhet_naring VALUES (439, '90.012');
INSERT INTO public.virksomhet_naring VALUES (440, '01.120');
INSERT INTO public.virksomhet_naring VALUES (441, '01.120');
INSERT INTO public.virksomhet_naring VALUES (441, '90.012');
INSERT INTO public.virksomhet_naring VALUES (441, '70.220');
INSERT INTO public.virksomhet_naring VALUES (442, '01.120');
INSERT INTO public.virksomhet_naring VALUES (442, '90.012');
INSERT INTO public.virksomhet_naring VALUES (443, '01.120');
INSERT INTO public.virksomhet_naring VALUES (443, '90.012');
INSERT INTO public.virksomhet_naring VALUES (444, '01.120');
INSERT INTO public.virksomhet_naring VALUES (444, '90.012');
INSERT INTO public.virksomhet_naring VALUES (444, '70.220');
INSERT INTO public.virksomhet_naring VALUES (445, '01.120');
INSERT INTO public.virksomhet_naring VALUES (445, '90.012');
INSERT INTO public.virksomhet_naring VALUES (445, '70.220');
INSERT INTO public.virksomhet_naring VALUES (446, '01.120');
INSERT INTO public.virksomhet_naring VALUES (446, '90.012');
INSERT INTO public.virksomhet_naring VALUES (446, '70.220');
INSERT INTO public.virksomhet_naring VALUES (447, '01.120');
INSERT INTO public.virksomhet_naring VALUES (448, '01.120');
INSERT INTO public.virksomhet_naring VALUES (449, '01.120');
INSERT INTO public.virksomhet_naring VALUES (449, '90.012');
INSERT INTO public.virksomhet_naring VALUES (450, '01.120');
INSERT INTO public.virksomhet_naring VALUES (450, '90.012');
INSERT INTO public.virksomhet_naring VALUES (450, '70.220');
INSERT INTO public.virksomhet_naring VALUES (451, '01.120');
INSERT INTO public.virksomhet_naring VALUES (451, '90.012');
INSERT INTO public.virksomhet_naring VALUES (451, '70.220');
INSERT INTO public.virksomhet_naring VALUES (452, '01.120');
INSERT INTO public.virksomhet_naring VALUES (453, '01.120');
INSERT INTO public.virksomhet_naring VALUES (453, '90.012');
INSERT INTO public.virksomhet_naring VALUES (454, '01.120');
INSERT INTO public.virksomhet_naring VALUES (455, '01.120');
INSERT INTO public.virksomhet_naring VALUES (456, '01.120');
INSERT INTO public.virksomhet_naring VALUES (457, '01.120');
INSERT INTO public.virksomhet_naring VALUES (458, '01.120');
INSERT INTO public.virksomhet_naring VALUES (458, '90.012');
INSERT INTO public.virksomhet_naring VALUES (458, '70.220');
INSERT INTO public.virksomhet_naring VALUES (459, '01.120');
INSERT INTO public.virksomhet_naring VALUES (459, '90.012');
INSERT INTO public.virksomhet_naring VALUES (460, '01.120');
INSERT INTO public.virksomhet_naring VALUES (461, '01.120');
INSERT INTO public.virksomhet_naring VALUES (462, '01.120');
INSERT INTO public.virksomhet_naring VALUES (463, '01.120');
INSERT INTO public.virksomhet_naring VALUES (464, '01.120');
INSERT INTO public.virksomhet_naring VALUES (464, '90.012');
INSERT INTO public.virksomhet_naring VALUES (464, '70.220');
INSERT INTO public.virksomhet_naring VALUES (465, '01.120');
INSERT INTO public.virksomhet_naring VALUES (465, '90.012');
INSERT INTO public.virksomhet_naring VALUES (466, '01.120');
INSERT INTO public.virksomhet_naring VALUES (467, '01.120');
INSERT INTO public.virksomhet_naring VALUES (468, '01.120');
INSERT INTO public.virksomhet_naring VALUES (468, '90.012');
INSERT INTO public.virksomhet_naring VALUES (469, '01.120');
INSERT INTO public.virksomhet_naring VALUES (470, '01.120');
INSERT INTO public.virksomhet_naring VALUES (470, '90.012');
INSERT INTO public.virksomhet_naring VALUES (471, '01.120');
INSERT INTO public.virksomhet_naring VALUES (472, '01.120');
INSERT INTO public.virksomhet_naring VALUES (473, '01.120');
INSERT INTO public.virksomhet_naring VALUES (473, '90.012');
INSERT INTO public.virksomhet_naring VALUES (473, '70.220');
INSERT INTO public.virksomhet_naring VALUES (474, '01.120');
INSERT INTO public.virksomhet_naring VALUES (475, '01.120');
INSERT INTO public.virksomhet_naring VALUES (476, '01.120');
INSERT INTO public.virksomhet_naring VALUES (476, '90.012');
INSERT INTO public.virksomhet_naring VALUES (477, '01.120');
INSERT INTO public.virksomhet_naring VALUES (477, '90.012');
INSERT INTO public.virksomhet_naring VALUES (478, '01.120');
INSERT INTO public.virksomhet_naring VALUES (478, '90.012');
INSERT INTO public.virksomhet_naring VALUES (478, '70.220');
INSERT INTO public.virksomhet_naring VALUES (479, '01.120');
INSERT INTO public.virksomhet_naring VALUES (480, '01.120');
INSERT INTO public.virksomhet_naring VALUES (481, '01.120');
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
INSERT INTO public.virksomhet_naring VALUES (492, '70.220');
INSERT INTO public.virksomhet_naring VALUES (493, '01.120');
INSERT INTO public.virksomhet_naring VALUES (493, '90.012');
INSERT INTO public.virksomhet_naring VALUES (493, '70.220');
INSERT INTO public.virksomhet_naring VALUES (494, '01.120');
INSERT INTO public.virksomhet_naring VALUES (495, '01.120');
INSERT INTO public.virksomhet_naring VALUES (495, '90.012');
INSERT INTO public.virksomhet_naring VALUES (496, '01.120');
INSERT INTO public.virksomhet_naring VALUES (496, '90.012');
INSERT INTO public.virksomhet_naring VALUES (496, '70.220');
INSERT INTO public.virksomhet_naring VALUES (497, '01.120');
INSERT INTO public.virksomhet_naring VALUES (497, '90.012');
INSERT INTO public.virksomhet_naring VALUES (498, '01.120');
INSERT INTO public.virksomhet_naring VALUES (498, '90.012');
INSERT INTO public.virksomhet_naring VALUES (499, '01.120');
INSERT INTO public.virksomhet_naring VALUES (500, '01.120');
INSERT INTO public.virksomhet_naring VALUES (500, '90.012');
INSERT INTO public.virksomhet_naring VALUES (500, '70.220');
INSERT INTO public.virksomhet_naring VALUES (501, '01.120');
INSERT INTO public.virksomhet_naring VALUES (502, '01.120');
INSERT INTO public.virksomhet_naring VALUES (503, '01.120');
INSERT INTO public.virksomhet_naring VALUES (504, '01.120');
INSERT INTO public.virksomhet_naring VALUES (505, '01.120');
INSERT INTO public.virksomhet_naring VALUES (505, '90.012');
INSERT INTO public.virksomhet_naring VALUES (506, '01.120');
INSERT INTO public.virksomhet_naring VALUES (506, '90.012');
INSERT INTO public.virksomhet_naring VALUES (507, '01.120');
INSERT INTO public.virksomhet_naring VALUES (508, '01.120');
INSERT INTO public.virksomhet_naring VALUES (508, '90.012');
INSERT INTO public.virksomhet_naring VALUES (508, '70.220');
INSERT INTO public.virksomhet_naring VALUES (509, '01.120');
INSERT INTO public.virksomhet_naring VALUES (509, '90.012');
INSERT INTO public.virksomhet_naring VALUES (509, '70.220');
INSERT INTO public.virksomhet_naring VALUES (510, '01.120');
INSERT INTO public.virksomhet_naring VALUES (510, '90.012');
INSERT INTO public.virksomhet_naring VALUES (510, '70.220');
INSERT INTO public.virksomhet_naring VALUES (511, '01.120');
INSERT INTO public.virksomhet_naring VALUES (517, '01.120');
INSERT INTO public.virksomhet_naring VALUES (518, '01.120');
INSERT INTO public.virksomhet_naring VALUES (519, '01.120');
INSERT INTO public.virksomhet_naring VALUES (519, '90.012');
INSERT INTO public.virksomhet_naring VALUES (519, '70.220');
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
INSERT INTO public.virksomhet_naring VALUES (526, '70.220');
INSERT INTO public.virksomhet_naring VALUES (512, '01.120');
INSERT INTO public.virksomhet_naring VALUES (513, '01.120');
INSERT INTO public.virksomhet_naring VALUES (514, '01.120');
INSERT INTO public.virksomhet_naring VALUES (515, '01.120');
INSERT INTO public.virksomhet_naring VALUES (516, '01.120');
INSERT INTO public.virksomhet_naring VALUES (516, '90.012');
INSERT INTO public.virksomhet_naring VALUES (527, '01.120');
INSERT INTO public.virksomhet_naring VALUES (527, '01.110');
INSERT INTO public.virksomhet_naring VALUES (527, '70.220');
INSERT INTO public.virksomhet_naring VALUES (534, '01.120');
INSERT INTO public.virksomhet_naring VALUES (534, '90.012');
INSERT INTO public.virksomhet_naring VALUES (534, '70.220');
INSERT INTO public.virksomhet_naring VALUES (535, '01.120');
INSERT INTO public.virksomhet_naring VALUES (535, '90.012');
INSERT INTO public.virksomhet_naring VALUES (536, '01.120');
INSERT INTO public.virksomhet_naring VALUES (536, '90.012');
INSERT INTO public.virksomhet_naring VALUES (537, '01.120');
INSERT INTO public.virksomhet_naring VALUES (538, '01.120');
INSERT INTO public.virksomhet_naring VALUES (538, '90.012');


--
-- Data for Name: virksomhet_naringsundergrupper; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_naringsundergrupper VALUES (1, 1, '90.012', NULL, NULL, '2023-08-29 15:40:49.866346', '2023-08-29 15:40:49.866346');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (2, 2, '70.220', '90.012', NULL, '2023-08-29 15:40:50.027855', '2023-08-29 15:40:50.027855');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (3, 3, '90.012', '70.220', NULL, '2023-08-29 15:40:50.220848', '2023-08-29 15:40:50.220848');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (4, 4, '90.012', NULL, NULL, '2023-08-29 15:40:50.295135', '2023-08-29 15:40:50.295135');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (5, 5, '01.120', '90.012', '70.220', '2023-08-29 15:40:50.46954', '2023-08-29 15:40:50.46954');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (6, 6, '01.120', NULL, NULL, '2023-08-29 15:40:50.529222', '2023-08-29 15:40:50.529222');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (7, 7, '01.120', NULL, NULL, '2023-08-29 15:40:50.588424', '2023-08-29 15:40:50.588424');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (8, 8, '01.120', '90.012', '70.220', '2023-08-29 15:40:50.645422', '2023-08-29 15:40:50.645422');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (9, 9, '01.120', NULL, NULL, '2023-08-29 15:40:50.707787', '2023-08-29 15:40:50.707787');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (10, 10, '01.120', NULL, NULL, '2023-08-29 15:40:50.778584', '2023-08-29 15:40:50.778584');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (11, 11, '01.120', NULL, NULL, '2023-08-29 15:40:50.87865', '2023-08-29 15:40:50.87865');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (12, 12, '01.120', '90.012', NULL, '2023-08-29 15:40:50.966525', '2023-08-29 15:40:50.966525');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (13, 13, '01.120', NULL, NULL, '2023-08-29 15:40:51.030679', '2023-08-29 15:40:51.030679');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (14, 14, '01.120', '90.012', NULL, '2023-08-29 15:40:51.075681', '2023-08-29 15:40:51.075681');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (15, 15, '01.120', '90.012', NULL, '2023-08-29 15:40:51.127606', '2023-08-29 15:40:51.127606');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (16, 16, '01.120', '90.012', NULL, '2023-08-29 15:40:51.182778', '2023-08-29 15:40:51.182778');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (17, 17, '01.120', '90.012', NULL, '2023-08-29 15:40:51.226448', '2023-08-29 15:40:51.226448');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (18, 18, '01.120', '90.012', NULL, '2023-08-29 15:40:51.407244', '2023-08-29 15:40:51.407244');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (19, 19, '01.120', NULL, NULL, '2023-08-29 15:40:51.445489', '2023-08-29 15:40:51.445489');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (20, 20, '01.120', NULL, NULL, '2023-08-29 15:40:51.507953', '2023-08-29 15:40:51.507953');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (21, 21, '01.120', '90.012', '70.220', '2023-08-29 15:40:51.590255', '2023-08-29 15:40:51.590255');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (22, 22, '01.120', NULL, NULL, '2023-08-29 15:40:51.69827', '2023-08-29 15:40:51.69827');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (23, 23, '01.120', '90.012', NULL, '2023-08-29 15:40:51.769429', '2023-08-29 15:40:51.769429');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (24, 24, '01.120', NULL, NULL, '2023-08-29 15:40:51.813089', '2023-08-29 15:40:51.813089');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (25, 25, '01.120', NULL, NULL, '2023-08-29 15:40:51.866294', '2023-08-29 15:40:51.866294');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (26, 26, '01.120', '90.012', '70.220', '2023-08-29 15:40:51.912931', '2023-08-29 15:40:51.912931');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (27, 27, '01.120', '90.012', '70.220', '2023-08-29 15:40:51.963492', '2023-08-29 15:40:51.963492');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (28, 28, '01.120', '90.012', NULL, '2023-08-29 15:40:52.00678', '2023-08-29 15:40:52.00678');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (29, 29, '01.120', '90.012', '70.220', '2023-08-29 15:40:52.050127', '2023-08-29 15:40:52.050127');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (30, 30, '01.120', NULL, NULL, '2023-08-29 15:40:52.100195', '2023-08-29 15:40:52.100195');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (31, 31, '01.120', NULL, NULL, '2023-08-29 15:40:52.131652', '2023-08-29 15:40:52.131652');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (32, 32, '01.120', '90.012', '70.220', '2023-08-29 15:40:52.181844', '2023-08-29 15:40:52.181844');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (33, 33, '01.120', '90.012', NULL, '2023-08-29 15:40:52.23288', '2023-08-29 15:40:52.23288');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (34, 34, '01.120', NULL, NULL, '2023-08-29 15:40:52.273736', '2023-08-29 15:40:52.273736');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (35, 35, '01.120', NULL, NULL, '2023-08-29 15:40:52.309789', '2023-08-29 15:40:52.309789');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (36, 36, '01.120', '90.012', NULL, '2023-08-29 15:40:52.347533', '2023-08-29 15:40:52.347533');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (37, 37, '01.120', NULL, NULL, '2023-08-29 15:40:52.401494', '2023-08-29 15:40:52.401494');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (38, 38, '01.120', NULL, NULL, '2023-08-29 15:40:52.463902', '2023-08-29 15:40:52.463902');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (39, 39, '01.120', NULL, NULL, '2023-08-29 15:40:52.51265', '2023-08-29 15:40:52.51265');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (40, 40, '01.120', NULL, NULL, '2023-08-29 15:40:52.549653', '2023-08-29 15:40:52.549653');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (41, 41, '01.120', NULL, NULL, '2023-08-29 15:40:52.591635', '2023-08-29 15:40:52.591635');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (42, 42, '01.120', NULL, NULL, '2023-08-29 15:40:52.639815', '2023-08-29 15:40:52.639815');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (43, 43, '01.120', NULL, NULL, '2023-08-29 15:40:52.682291', '2023-08-29 15:40:52.682291');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (44, 44, '01.120', '90.012', NULL, '2023-08-29 15:40:52.730389', '2023-08-29 15:40:52.730389');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (45, 45, '01.120', NULL, NULL, '2023-08-29 15:40:52.789537', '2023-08-29 15:40:52.789537');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (46, 46, '01.120', '90.012', '70.220', '2023-08-29 15:40:52.827926', '2023-08-29 15:40:52.827926');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (47, 47, '01.120', NULL, NULL, '2023-08-29 15:40:52.877587', '2023-08-29 15:40:52.877587');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (48, 48, '01.120', NULL, NULL, '2023-08-29 15:40:52.966157', '2023-08-29 15:40:52.966157');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (49, 49, '01.120', NULL, NULL, '2023-08-29 15:40:53.03202', '2023-08-29 15:40:53.03202');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (50, 50, '01.120', NULL, NULL, '2023-08-29 15:40:53.070959', '2023-08-29 15:40:53.070959');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (51, 51, '01.120', NULL, NULL, '2023-08-29 15:40:53.123896', '2023-08-29 15:40:53.123896');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (52, 52, '01.120', '90.012', NULL, '2023-08-29 15:40:53.166308', '2023-08-29 15:40:53.166308');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (53, 53, '01.120', NULL, NULL, '2023-08-29 15:40:53.211519', '2023-08-29 15:40:53.211519');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (54, 54, '01.120', NULL, NULL, '2023-08-29 15:40:53.266603', '2023-08-29 15:40:53.266603');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (55, 55, '01.120', '90.012', NULL, '2023-08-29 15:40:53.306686', '2023-08-29 15:40:53.306686');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (56, 56, '01.120', '90.012', '70.220', '2023-08-29 15:40:53.349361', '2023-08-29 15:40:53.349361');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (57, 57, '01.120', '90.012', '70.220', '2023-08-29 15:40:53.419121', '2023-08-29 15:40:53.419121');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (58, 58, '01.120', '90.012', '70.220', '2023-08-29 15:40:53.476657', '2023-08-29 15:40:53.476657');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (59, 59, '01.120', '90.012', NULL, '2023-08-29 15:40:53.526795', '2023-08-29 15:40:53.526795');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (60, 60, '01.120', '90.012', '70.220', '2023-08-29 15:40:53.574694', '2023-08-29 15:40:53.574694');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (61, 61, '01.120', NULL, NULL, '2023-08-29 15:40:53.604968', '2023-08-29 15:40:53.604968');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (62, 62, '01.120', '90.012', '70.220', '2023-08-29 15:40:53.643208', '2023-08-29 15:40:53.643208');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (63, 63, '01.120', '90.012', '70.220', '2023-08-29 15:40:53.686328', '2023-08-29 15:40:53.686328');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (64, 64, '01.120', NULL, NULL, '2023-08-29 15:40:53.732772', '2023-08-29 15:40:53.732772');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (65, 65, '01.120', NULL, NULL, '2023-08-29 15:40:53.774313', '2023-08-29 15:40:53.774313');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (66, 66, '01.120', NULL, NULL, '2023-08-29 15:40:53.805435', '2023-08-29 15:40:53.805435');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (67, 67, '01.120', NULL, NULL, '2023-08-29 15:40:53.846664', '2023-08-29 15:40:53.846664');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (68, 68, '01.120', '90.012', '70.220', '2023-08-29 15:40:53.931532', '2023-08-29 15:40:53.931532');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (69, 69, '01.120', NULL, NULL, '2023-08-29 15:40:54.016165', '2023-08-29 15:40:54.016165');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (70, 70, '01.120', NULL, NULL, '2023-08-29 15:40:54.049557', '2023-08-29 15:40:54.049557');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (71, 71, '01.120', '90.012', NULL, '2023-08-29 15:40:54.084523', '2023-08-29 15:40:54.084523');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (72, 72, '01.120', '90.012', NULL, '2023-08-29 15:40:54.11623', '2023-08-29 15:40:54.11623');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (73, 73, '01.120', NULL, NULL, '2023-08-29 15:40:54.150182', '2023-08-29 15:40:54.150182');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (74, 74, '01.120', '90.012', '70.220', '2023-08-29 15:40:54.175064', '2023-08-29 15:40:54.175064');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (75, 75, '01.120', '90.012', NULL, '2023-08-29 15:40:54.19808', '2023-08-29 15:40:54.19808');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (76, 76, '01.120', NULL, NULL, '2023-08-29 15:40:54.237804', '2023-08-29 15:40:54.237804');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (77, 77, '01.120', '90.012', NULL, '2023-08-29 15:40:54.270906', '2023-08-29 15:40:54.270906');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (78, 78, '01.120', '90.012', NULL, '2023-08-29 15:40:54.321094', '2023-08-29 15:40:54.321094');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (79, 79, '01.120', '90.012', '70.220', '2023-08-29 15:40:54.353235', '2023-08-29 15:40:54.353235');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (80, 80, '01.120', '90.012', NULL, '2023-08-29 15:40:54.39905', '2023-08-29 15:40:54.39905');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (81, 81, '01.120', '90.012', '70.220', '2023-08-29 15:40:54.440081', '2023-08-29 15:40:54.440081');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (82, 82, '01.120', '90.012', NULL, '2023-08-29 15:40:54.477632', '2023-08-29 15:40:54.477632');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (83, 83, '01.120', NULL, NULL, '2023-08-29 15:40:54.521123', '2023-08-29 15:40:54.521123');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (84, 84, '01.120', '90.012', NULL, '2023-08-29 15:40:54.558031', '2023-08-29 15:40:54.558031');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (85, 85, '01.120', '90.012', NULL, '2023-08-29 15:40:54.58951', '2023-08-29 15:40:54.58951');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (86, 86, '01.120', NULL, NULL, '2023-08-29 15:40:54.618767', '2023-08-29 15:40:54.618767');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (87, 87, '01.120', NULL, NULL, '2023-08-29 15:40:54.650335', '2023-08-29 15:40:54.650335');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (88, 88, '01.120', '90.012', NULL, '2023-08-29 15:40:54.6853', '2023-08-29 15:40:54.6853');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (89, 89, '01.120', '90.012', NULL, '2023-08-29 15:40:54.71298', '2023-08-29 15:40:54.71298');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (90, 90, '01.120', NULL, NULL, '2023-08-29 15:40:54.737697', '2023-08-29 15:40:54.737697');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (91, 91, '01.120', '90.012', '70.220', '2023-08-29 15:40:54.795092', '2023-08-29 15:40:54.795092');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (92, 92, '01.120', NULL, NULL, '2023-08-29 15:40:54.83974', '2023-08-29 15:40:54.83974');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (93, 93, '01.120', NULL, NULL, '2023-08-29 15:40:54.8933', '2023-08-29 15:40:54.8933');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (94, 94, '01.120', NULL, NULL, '2023-08-29 15:40:54.93023', '2023-08-29 15:40:54.93023');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (95, 95, '01.120', NULL, NULL, '2023-08-29 15:40:54.959555', '2023-08-29 15:40:54.959555');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (96, 96, '01.120', '90.012', '70.220', '2023-08-29 15:40:55.005705', '2023-08-29 15:40:55.005705');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (97, 97, '01.120', NULL, NULL, '2023-08-29 15:40:55.038374', '2023-08-29 15:40:55.038374');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (98, 98, '01.120', '90.012', NULL, '2023-08-29 15:40:55.066564', '2023-08-29 15:40:55.066564');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (99, 99, '01.120', NULL, NULL, '2023-08-29 15:40:55.102429', '2023-08-29 15:40:55.102429');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (100, 100, '01.120', '90.012', NULL, '2023-08-29 15:40:55.147814', '2023-08-29 15:40:55.147814');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (101, 101, '01.120', '90.012', '70.220', '2023-08-29 15:40:55.178248', '2023-08-29 15:40:55.178248');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (102, 102, '01.120', '90.012', NULL, '2023-08-29 15:40:55.203878', '2023-08-29 15:40:55.203878');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (103, 103, '01.120', '90.012', NULL, '2023-08-29 15:40:55.245551', '2023-08-29 15:40:55.245551');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (104, 104, '01.120', '90.012', NULL, '2023-08-29 15:40:55.266413', '2023-08-29 15:40:55.266413');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (105, 105, '01.120', NULL, NULL, '2023-08-29 15:40:55.291597', '2023-08-29 15:40:55.291597');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (106, 106, '01.120', NULL, NULL, '2023-08-29 15:40:55.321395', '2023-08-29 15:40:55.321395');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (107, 107, '01.120', NULL, NULL, '2023-08-29 15:40:55.34634', '2023-08-29 15:40:55.34634');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (108, 108, '01.120', '90.012', NULL, '2023-08-29 15:40:55.38857', '2023-08-29 15:40:55.38857');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (109, 109, '01.120', NULL, NULL, '2023-08-29 15:40:55.42984', '2023-08-29 15:40:55.42984');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (110, 110, '01.120', NULL, NULL, '2023-08-29 15:40:55.472188', '2023-08-29 15:40:55.472188');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (111, 111, '01.120', '90.012', '70.220', '2023-08-29 15:40:55.510354', '2023-08-29 15:40:55.510354');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (112, 112, '01.120', '90.012', NULL, '2023-08-29 15:40:55.542444', '2023-08-29 15:40:55.542444');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (113, 113, '01.120', '90.012', '70.220', '2023-08-29 15:40:55.593083', '2023-08-29 15:40:55.593083');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (114, 114, '01.120', '90.012', NULL, '2023-08-29 15:40:55.709029', '2023-08-29 15:40:55.709029');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (115, 115, '01.120', NULL, NULL, '2023-08-29 15:40:55.745032', '2023-08-29 15:40:55.745032');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (116, 116, '01.120', '90.012', '70.220', '2023-08-29 15:40:55.860938', '2023-08-29 15:40:55.860938');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (117, 117, '01.120', NULL, NULL, '2023-08-29 15:40:55.916744', '2023-08-29 15:40:55.916744');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (118, 118, '01.120', '90.012', NULL, '2023-08-29 15:40:55.954726', '2023-08-29 15:40:55.954726');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (119, 119, '01.120', NULL, NULL, '2023-08-29 15:40:55.985543', '2023-08-29 15:40:55.985543');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (120, 120, '01.120', NULL, NULL, '2023-08-29 15:40:56.023028', '2023-08-29 15:40:56.023028');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (121, 121, '01.120', '90.012', '70.220', '2023-08-29 15:40:56.066841', '2023-08-29 15:40:56.066841');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (122, 122, '01.120', NULL, NULL, '2023-08-29 15:40:56.0965', '2023-08-29 15:40:56.0965');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (123, 123, '01.120', '90.012', '70.220', '2023-08-29 15:40:56.129776', '2023-08-29 15:40:56.129776');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (124, 124, '01.120', NULL, NULL, '2023-08-29 15:40:56.161136', '2023-08-29 15:40:56.161136');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (125, 125, '01.120', NULL, NULL, '2023-08-29 15:40:56.187783', '2023-08-29 15:40:56.187783');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (126, 126, '01.120', '90.012', NULL, '2023-08-29 15:40:56.23617', '2023-08-29 15:40:56.23617');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (127, 127, '01.120', NULL, NULL, '2023-08-29 15:40:56.284784', '2023-08-29 15:40:56.284784');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (128, 128, '01.120', '90.012', NULL, '2023-08-29 15:40:56.322643', '2023-08-29 15:40:56.322643');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (129, 129, '01.120', NULL, NULL, '2023-08-29 15:40:56.351965', '2023-08-29 15:40:56.351965');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (130, 130, '01.120', '90.012', NULL, '2023-08-29 15:40:56.413069', '2023-08-29 15:40:56.413069');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (131, 131, '01.120', '90.012', NULL, '2023-08-29 15:40:56.469498', '2023-08-29 15:40:56.469498');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (132, 132, '01.120', '90.012', '70.220', '2023-08-29 15:40:56.536091', '2023-08-29 15:40:56.536091');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (133, 133, '01.120', NULL, NULL, '2023-08-29 15:40:56.586284', '2023-08-29 15:40:56.586284');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (134, 134, '01.120', '90.012', NULL, '2023-08-29 15:40:56.612994', '2023-08-29 15:40:56.612994');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (135, 135, '01.120', NULL, NULL, '2023-08-29 15:40:56.648732', '2023-08-29 15:40:56.648732');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (136, 136, '01.120', NULL, NULL, '2023-08-29 15:40:56.687037', '2023-08-29 15:40:56.687037');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (137, 137, '01.120', NULL, NULL, '2023-08-29 15:40:56.731681', '2023-08-29 15:40:56.731681');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (138, 138, '01.120', '90.012', NULL, '2023-08-29 15:40:56.779226', '2023-08-29 15:40:56.779226');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (139, 139, '01.120', '90.012', '70.220', '2023-08-29 15:40:56.813556', '2023-08-29 15:40:56.813556');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (140, 140, '01.120', NULL, NULL, '2023-08-29 15:40:56.86351', '2023-08-29 15:40:56.86351');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (141, 141, '01.120', NULL, NULL, '2023-08-29 15:40:56.937492', '2023-08-29 15:40:56.937492');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (142, 142, '01.120', NULL, NULL, '2023-08-29 15:40:56.997937', '2023-08-29 15:40:56.997937');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (143, 143, '01.120', NULL, NULL, '2023-08-29 15:40:57.062478', '2023-08-29 15:40:57.062478');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (144, 144, '01.120', '90.012', NULL, '2023-08-29 15:40:57.108472', '2023-08-29 15:40:57.108472');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (145, 145, '01.120', NULL, NULL, '2023-08-29 15:40:57.172793', '2023-08-29 15:40:57.172793');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (146, 146, '01.120', '90.012', NULL, '2023-08-29 15:40:57.249069', '2023-08-29 15:40:57.249069');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (147, 147, '01.120', NULL, NULL, '2023-08-29 15:40:57.289018', '2023-08-29 15:40:57.289018');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (148, 148, '01.120', NULL, NULL, '2023-08-29 15:40:57.337121', '2023-08-29 15:40:57.337121');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (149, 149, '01.120', NULL, NULL, '2023-08-29 15:40:57.402392', '2023-08-29 15:40:57.402392');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (150, 150, '01.120', '90.012', '70.220', '2023-08-29 15:40:57.466843', '2023-08-29 15:40:57.466843');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (151, 151, '01.120', '90.012', NULL, '2023-08-29 15:40:57.527347', '2023-08-29 15:40:57.527347');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (152, 152, '01.120', NULL, NULL, '2023-08-29 15:40:57.577455', '2023-08-29 15:40:57.577455');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (153, 153, '01.120', NULL, NULL, '2023-08-29 15:40:57.631216', '2023-08-29 15:40:57.631216');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (154, 154, '01.120', '90.012', NULL, '2023-08-29 15:40:57.661502', '2023-08-29 15:40:57.661502');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (155, 155, '01.120', NULL, NULL, '2023-08-29 15:40:57.698316', '2023-08-29 15:40:57.698316');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (156, 156, '01.120', '90.012', NULL, '2023-08-29 15:40:57.733872', '2023-08-29 15:40:57.733872');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (157, 157, '01.120', '90.012', NULL, '2023-08-29 15:40:57.761056', '2023-08-29 15:40:57.761056');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (158, 158, '01.120', NULL, NULL, '2023-08-29 15:40:57.799347', '2023-08-29 15:40:57.799347');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (159, 159, '01.120', NULL, NULL, '2023-08-29 15:40:57.820747', '2023-08-29 15:40:57.820747');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (160, 160, '01.120', NULL, NULL, '2023-08-29 15:40:57.847792', '2023-08-29 15:40:57.847792');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (161, 161, '01.120', '90.012', '70.220', '2023-08-29 15:40:57.873327', '2023-08-29 15:40:57.873327');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (162, 162, '01.120', '90.012', NULL, '2023-08-29 15:40:57.934019', '2023-08-29 15:40:57.934019');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (163, 163, '01.120', '90.012', '70.220', '2023-08-29 15:40:58.001118', '2023-08-29 15:40:58.001118');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (164, 164, '01.120', '90.012', NULL, '2023-08-29 15:40:58.068799', '2023-08-29 15:40:58.068799');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (165, 165, '01.120', NULL, NULL, '2023-08-29 15:40:58.126956', '2023-08-29 15:40:58.126956');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (166, 166, '01.120', NULL, NULL, '2023-08-29 15:40:58.163284', '2023-08-29 15:40:58.163284');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (167, 167, '01.120', '90.012', NULL, '2023-08-29 15:40:58.189278', '2023-08-29 15:40:58.189278');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (168, 168, '01.120', NULL, NULL, '2023-08-29 15:40:58.228969', '2023-08-29 15:40:58.228969');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (169, 169, '01.120', '90.012', NULL, '2023-08-29 15:40:58.265999', '2023-08-29 15:40:58.265999');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (170, 170, '01.120', NULL, NULL, '2023-08-29 15:40:58.306401', '2023-08-29 15:40:58.306401');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (171, 171, '01.120', '90.012', NULL, '2023-08-29 15:40:58.334615', '2023-08-29 15:40:58.334615');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (172, 172, '01.120', '90.012', NULL, '2023-08-29 15:40:58.367913', '2023-08-29 15:40:58.367913');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (173, 173, '01.120', NULL, NULL, '2023-08-29 15:40:58.406504', '2023-08-29 15:40:58.406504');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (174, 174, '01.120', NULL, NULL, '2023-08-29 15:40:58.445774', '2023-08-29 15:40:58.445774');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (175, 175, '01.120', '90.012', NULL, '2023-08-29 15:40:58.479818', '2023-08-29 15:40:58.479818');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (176, 176, '01.120', NULL, NULL, '2023-08-29 15:40:58.515521', '2023-08-29 15:40:58.515521');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (177, 177, '01.120', '90.012', NULL, '2023-08-29 15:40:58.548996', '2023-08-29 15:40:58.548996');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (178, 178, '01.120', '90.012', '70.220', '2023-08-29 15:40:58.592523', '2023-08-29 15:40:58.592523');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (179, 179, '01.120', '90.012', NULL, '2023-08-29 15:40:58.628098', '2023-08-29 15:40:58.628098');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (180, 180, '01.120', NULL, NULL, '2023-08-29 15:40:58.658479', '2023-08-29 15:40:58.658479');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (181, 181, '01.120', '90.012', NULL, '2023-08-29 15:40:58.699459', '2023-08-29 15:40:58.699459');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (182, 182, '01.120', NULL, NULL, '2023-08-29 15:40:58.732899', '2023-08-29 15:40:58.732899');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (183, 183, '01.120', '90.012', '70.220', '2023-08-29 15:40:58.771086', '2023-08-29 15:40:58.771086');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (184, 184, '01.120', '90.012', '70.220', '2023-08-29 15:40:58.811875', '2023-08-29 15:40:58.811875');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (185, 185, '01.120', '90.012', NULL, '2023-08-29 15:40:58.848238', '2023-08-29 15:40:58.848238');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (186, 186, '01.120', NULL, NULL, '2023-08-29 15:40:58.885303', '2023-08-29 15:40:58.885303');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (187, 187, '01.120', '90.012', NULL, '2023-08-29 15:40:58.921796', '2023-08-29 15:40:58.921796');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (188, 188, '01.120', '90.012', NULL, '2023-08-29 15:40:58.956076', '2023-08-29 15:40:58.956076');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (189, 189, '01.120', NULL, NULL, '2023-08-29 15:40:59.180917', '2023-08-29 15:40:59.180917');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (190, 190, '01.120', NULL, NULL, '2023-08-29 15:40:59.231232', '2023-08-29 15:40:59.231232');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (191, 191, '01.120', '90.012', NULL, '2023-08-29 15:40:59.273133', '2023-08-29 15:40:59.273133');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (192, 192, '01.120', '90.012', NULL, '2023-08-29 15:40:59.308865', '2023-08-29 15:40:59.308865');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (193, 193, '01.120', '90.012', NULL, '2023-08-29 15:40:59.370182', '2023-08-29 15:40:59.370182');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (194, 194, '01.120', NULL, NULL, '2023-08-29 15:40:59.418333', '2023-08-29 15:40:59.418333');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (195, 195, '01.120', '90.012', '70.220', '2023-08-29 15:40:59.478362', '2023-08-29 15:40:59.478362');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (196, 196, '01.120', '90.012', '70.220', '2023-08-29 15:40:59.529527', '2023-08-29 15:40:59.529527');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (197, 197, '01.120', NULL, NULL, '2023-08-29 15:40:59.578227', '2023-08-29 15:40:59.578227');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (198, 198, '01.120', '90.012', NULL, '2023-08-29 15:40:59.614186', '2023-08-29 15:40:59.614186');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (199, 199, '01.120', NULL, NULL, '2023-08-29 15:40:59.647871', '2023-08-29 15:40:59.647871');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (200, 200, '01.120', NULL, NULL, '2023-08-29 15:40:59.686779', '2023-08-29 15:40:59.686779');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (201, 201, '01.120', NULL, NULL, '2023-08-29 15:40:59.775034', '2023-08-29 15:40:59.775034');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (202, 202, '01.120', '90.012', '70.220', '2023-08-29 15:40:59.861673', '2023-08-29 15:40:59.861673');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (203, 203, '01.120', NULL, NULL, '2023-08-29 15:40:59.9233', '2023-08-29 15:40:59.9233');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (204, 204, '01.120', NULL, NULL, '2023-08-29 15:40:59.958253', '2023-08-29 15:40:59.958253');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (205, 205, '01.120', NULL, NULL, '2023-08-29 15:41:00.000127', '2023-08-29 15:41:00.000127');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (206, 206, '01.120', '90.012', NULL, '2023-08-29 15:41:00.176939', '2023-08-29 15:41:00.176939');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (207, 207, '01.120', NULL, NULL, '2023-08-29 15:41:00.232645', '2023-08-29 15:41:00.232645');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (208, 208, '01.120', '90.012', '70.220', '2023-08-29 15:41:00.282845', '2023-08-29 15:41:00.282845');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (209, 209, '01.120', '90.012', '70.220', '2023-08-29 15:41:00.305937', '2023-08-29 15:41:00.305937');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (210, 210, '01.120', '90.012', NULL, '2023-08-29 15:41:00.338639', '2023-08-29 15:41:00.338639');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (211, 211, '01.120', '90.012', '70.220', '2023-08-29 15:41:00.381402', '2023-08-29 15:41:00.381402');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (212, 212, '01.120', '90.012', NULL, '2023-08-29 15:41:00.447057', '2023-08-29 15:41:00.447057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (213, 213, '01.120', NULL, NULL, '2023-08-29 15:41:00.487586', '2023-08-29 15:41:00.487586');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (214, 214, '01.120', NULL, NULL, '2023-08-29 15:41:00.522226', '2023-08-29 15:41:00.522226');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (215, 215, '01.120', NULL, NULL, '2023-08-29 15:41:00.549748', '2023-08-29 15:41:00.549748');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (216, 216, '01.120', '90.012', NULL, '2023-08-29 15:41:00.584807', '2023-08-29 15:41:00.584807');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (217, 217, '01.120', '90.012', NULL, '2023-08-29 15:41:00.609786', '2023-08-29 15:41:00.609786');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (218, 218, '01.120', '90.012', NULL, '2023-08-29 15:41:00.645233', '2023-08-29 15:41:00.645233');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (219, 219, '01.120', NULL, NULL, '2023-08-29 15:41:00.676497', '2023-08-29 15:41:00.676497');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (220, 220, '01.120', '90.012', NULL, '2023-08-29 15:41:00.697712', '2023-08-29 15:41:00.697712');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (221, 221, '01.120', NULL, NULL, '2023-08-29 15:41:00.73136', '2023-08-29 15:41:00.73136');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (222, 222, '01.120', NULL, NULL, '2023-08-29 15:41:00.753097', '2023-08-29 15:41:00.753097');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (223, 223, '01.120', NULL, NULL, '2023-08-29 15:41:00.774383', '2023-08-29 15:41:00.774383');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (224, 224, '01.120', '90.012', NULL, '2023-08-29 15:41:00.802199', '2023-08-29 15:41:00.802199');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (225, 225, '01.120', '90.012', '70.220', '2023-08-29 15:41:00.835869', '2023-08-29 15:41:00.835869');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (226, 226, '01.120', NULL, NULL, '2023-08-29 15:41:00.863772', '2023-08-29 15:41:00.863772');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (227, 227, '01.120', '90.012', NULL, '2023-08-29 15:41:00.891395', '2023-08-29 15:41:00.891395');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (228, 228, '01.120', NULL, NULL, '2023-08-29 15:41:00.93135', '2023-08-29 15:41:00.93135');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (229, 229, '01.120', NULL, NULL, '2023-08-29 15:41:00.968025', '2023-08-29 15:41:00.968025');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (230, 230, '01.120', NULL, NULL, '2023-08-29 15:41:01.009878', '2023-08-29 15:41:01.009878');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (231, 231, '01.120', '90.012', NULL, '2023-08-29 15:41:01.048683', '2023-08-29 15:41:01.048683');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (232, 232, '01.120', '90.012', NULL, '2023-08-29 15:41:01.078563', '2023-08-29 15:41:01.078563');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (233, 233, '01.120', '90.012', NULL, '2023-08-29 15:41:01.112951', '2023-08-29 15:41:01.112951');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (234, 234, '01.120', NULL, NULL, '2023-08-29 15:41:01.135807', '2023-08-29 15:41:01.135807');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (235, 235, '01.120', NULL, NULL, '2023-08-29 15:41:01.161353', '2023-08-29 15:41:01.161353');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (236, 236, '01.120', '90.012', NULL, '2023-08-29 15:41:01.186293', '2023-08-29 15:41:01.186293');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (237, 237, '01.120', NULL, NULL, '2023-08-29 15:41:01.212428', '2023-08-29 15:41:01.212428');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (238, 238, '01.120', '90.012', NULL, '2023-08-29 15:41:01.245526', '2023-08-29 15:41:01.245526');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (239, 239, '01.120', '90.012', NULL, '2023-08-29 15:41:01.277349', '2023-08-29 15:41:01.277349');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (240, 240, '01.120', NULL, NULL, '2023-08-29 15:41:01.307783', '2023-08-29 15:41:01.307783');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (241, 241, '01.120', NULL, NULL, '2023-08-29 15:41:01.337456', '2023-08-29 15:41:01.337456');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (242, 242, '01.120', '90.012', NULL, '2023-08-29 15:41:01.38194', '2023-08-29 15:41:01.38194');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (243, 243, '01.120', NULL, NULL, '2023-08-29 15:41:01.419648', '2023-08-29 15:41:01.419648');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (244, 244, '01.120', '90.012', NULL, '2023-08-29 15:41:01.456527', '2023-08-29 15:41:01.456527');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (245, 245, '01.120', '90.012', NULL, '2023-08-29 15:41:01.485193', '2023-08-29 15:41:01.485193');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (246, 246, '01.120', '90.012', NULL, '2023-08-29 15:41:01.519777', '2023-08-29 15:41:01.519777');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (247, 247, '01.120', NULL, NULL, '2023-08-29 15:41:01.558207', '2023-08-29 15:41:01.558207');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (248, 248, '01.120', '90.012', NULL, '2023-08-29 15:41:01.584054', '2023-08-29 15:41:01.584054');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (249, 249, '01.120', NULL, NULL, '2023-08-29 15:41:01.618254', '2023-08-29 15:41:01.618254');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (250, 250, '01.120', '90.012', '70.220', '2023-08-29 15:41:01.661781', '2023-08-29 15:41:01.661781');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (251, 251, '01.120', '90.012', NULL, '2023-08-29 15:41:01.705562', '2023-08-29 15:41:01.705562');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (252, 252, '01.120', NULL, NULL, '2023-08-29 15:41:01.737235', '2023-08-29 15:41:01.737235');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (253, 253, '01.120', '90.012', NULL, '2023-08-29 15:41:01.778951', '2023-08-29 15:41:01.778951');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (254, 254, '01.120', '90.012', NULL, '2023-08-29 15:41:01.809719', '2023-08-29 15:41:01.809719');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (255, 255, '01.120', NULL, NULL, '2023-08-29 15:41:01.845805', '2023-08-29 15:41:01.845805');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (256, 256, '01.120', NULL, NULL, '2023-08-29 15:41:01.884083', '2023-08-29 15:41:01.884083');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (257, 257, '01.120', '90.012', NULL, '2023-08-29 15:41:01.922827', '2023-08-29 15:41:01.922827');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (258, 258, '01.120', '90.012', NULL, '2023-08-29 15:41:01.979981', '2023-08-29 15:41:01.979981');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (259, 259, '01.120', NULL, NULL, '2023-08-29 15:41:02.01809', '2023-08-29 15:41:02.01809');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (260, 260, '01.120', NULL, NULL, '2023-08-29 15:41:02.057832', '2023-08-29 15:41:02.057832');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (261, 261, '01.120', '90.012', NULL, '2023-08-29 15:41:02.082408', '2023-08-29 15:41:02.082408');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (262, 262, '01.120', '90.012', NULL, '2023-08-29 15:41:02.108926', '2023-08-29 15:41:02.108926');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (263, 263, '01.120', NULL, NULL, '2023-08-29 15:41:02.146054', '2023-08-29 15:41:02.146054');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (264, 264, '01.120', NULL, NULL, '2023-08-29 15:41:02.17522', '2023-08-29 15:41:02.17522');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (265, 265, '01.120', '90.012', NULL, '2023-08-29 15:41:02.197075', '2023-08-29 15:41:02.197075');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (266, 266, '01.120', '90.012', NULL, '2023-08-29 15:41:02.222761', '2023-08-29 15:41:02.222761');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (267, 267, '01.120', NULL, NULL, '2023-08-29 15:41:02.242529', '2023-08-29 15:41:02.242529');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (268, 268, '01.120', '90.012', '70.220', '2023-08-29 15:41:02.270774', '2023-08-29 15:41:02.270774');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (269, 269, '01.120', NULL, NULL, '2023-08-29 15:41:02.307779', '2023-08-29 15:41:02.307779');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (270, 270, '01.120', NULL, NULL, '2023-08-29 15:41:02.340425', '2023-08-29 15:41:02.340425');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (271, 271, '01.120', NULL, NULL, '2023-08-29 15:41:02.367983', '2023-08-29 15:41:02.367983');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (272, 272, '01.120', NULL, NULL, '2023-08-29 15:41:02.410331', '2023-08-29 15:41:02.410331');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (273, 273, '01.120', NULL, NULL, '2023-08-29 15:41:02.445617', '2023-08-29 15:41:02.445617');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (274, 274, '01.120', '90.012', NULL, '2023-08-29 15:41:02.478235', '2023-08-29 15:41:02.478235');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (275, 275, '01.120', NULL, NULL, '2023-08-29 15:41:02.506216', '2023-08-29 15:41:02.506216');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (276, 276, '01.120', '90.012', NULL, '2023-08-29 15:41:02.535658', '2023-08-29 15:41:02.535658');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (277, 277, '01.120', NULL, NULL, '2023-08-29 15:41:02.570652', '2023-08-29 15:41:02.570652');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (278, 278, '01.120', '90.012', NULL, '2023-08-29 15:41:02.603903', '2023-08-29 15:41:02.603903');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (279, 279, '01.120', '90.012', NULL, '2023-08-29 15:41:02.642889', '2023-08-29 15:41:02.642889');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (280, 280, '01.120', NULL, NULL, '2023-08-29 15:41:02.668053', '2023-08-29 15:41:02.668053');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (281, 281, '01.120', NULL, NULL, '2023-08-29 15:41:02.687414', '2023-08-29 15:41:02.687414');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (282, 282, '01.120', '90.012', '70.220', '2023-08-29 15:41:02.717285', '2023-08-29 15:41:02.717285');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (283, 283, '01.120', NULL, NULL, '2023-08-29 15:41:02.741586', '2023-08-29 15:41:02.741586');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (284, 284, '01.120', NULL, NULL, '2023-08-29 15:41:02.778385', '2023-08-29 15:41:02.778385');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (285, 285, '01.120', '90.012', '70.220', '2023-08-29 15:41:02.80117', '2023-08-29 15:41:02.80117');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (286, 286, '01.120', '90.012', NULL, '2023-08-29 15:41:02.823029', '2023-08-29 15:41:02.823029');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (287, 287, '01.120', '90.012', NULL, '2023-08-29 15:41:02.852469', '2023-08-29 15:41:02.852469');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (288, 288, '01.120', NULL, NULL, '2023-08-29 15:41:02.892941', '2023-08-29 15:41:02.892941');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (289, 289, '01.120', NULL, NULL, '2023-08-29 15:41:02.996467', '2023-08-29 15:41:02.996467');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (290, 290, '01.120', NULL, NULL, '2023-08-29 15:41:03.040257', '2023-08-29 15:41:03.040257');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (291, 291, '01.120', '90.012', NULL, '2023-08-29 15:41:03.074143', '2023-08-29 15:41:03.074143');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (292, 292, '01.120', '90.012', NULL, '2023-08-29 15:41:03.101116', '2023-08-29 15:41:03.101116');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (293, 293, '01.120', NULL, NULL, '2023-08-29 15:41:03.132182', '2023-08-29 15:41:03.132182');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (294, 294, '01.120', '90.012', '70.220', '2023-08-29 15:41:03.153411', '2023-08-29 15:41:03.153411');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (295, 295, '01.120', NULL, NULL, '2023-08-29 15:41:03.182396', '2023-08-29 15:41:03.182396');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (296, 296, '01.120', '90.012', '70.220', '2023-08-29 15:41:03.206867', '2023-08-29 15:41:03.206867');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (297, 297, '01.120', NULL, NULL, '2023-08-29 15:41:03.232703', '2023-08-29 15:41:03.232703');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (298, 298, '01.120', NULL, NULL, '2023-08-29 15:41:03.259817', '2023-08-29 15:41:03.259817');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (299, 299, '01.120', '90.012', NULL, '2023-08-29 15:41:03.281762', '2023-08-29 15:41:03.281762');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (300, 300, '01.120', NULL, NULL, '2023-08-29 15:41:03.30447', '2023-08-29 15:41:03.30447');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (301, 301, '01.120', '90.012', '70.220', '2023-08-29 15:41:03.335401', '2023-08-29 15:41:03.335401');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (302, 302, '01.120', '90.012', NULL, '2023-08-29 15:41:03.362041', '2023-08-29 15:41:03.362041');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (303, 303, '01.120', NULL, NULL, '2023-08-29 15:41:03.440795', '2023-08-29 15:41:03.440795');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (304, 304, '01.120', '90.012', NULL, '2023-08-29 15:41:03.489913', '2023-08-29 15:41:03.489913');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (305, 305, '01.120', '90.012', '70.220', '2023-08-29 15:41:03.550057', '2023-08-29 15:41:03.550057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (306, 306, '01.120', NULL, NULL, '2023-08-29 15:41:03.571564', '2023-08-29 15:41:03.571564');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (307, 307, '01.120', '90.012', NULL, '2023-08-29 15:41:03.601753', '2023-08-29 15:41:03.601753');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (308, 308, '01.120', '90.012', NULL, '2023-08-29 15:41:03.637876', '2023-08-29 15:41:03.637876');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (309, 309, '01.120', '90.012', NULL, '2023-08-29 15:41:03.665338', '2023-08-29 15:41:03.665338');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (310, 310, '01.120', NULL, NULL, '2023-08-29 15:41:03.693435', '2023-08-29 15:41:03.693435');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (311, 311, '01.120', '90.012', '70.220', '2023-08-29 15:41:03.729571', '2023-08-29 15:41:03.729571');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (312, 312, '01.120', NULL, NULL, '2023-08-29 15:41:03.757036', '2023-08-29 15:41:03.757036');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (313, 313, '01.120', NULL, NULL, '2023-08-29 15:41:03.78604', '2023-08-29 15:41:03.78604');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (314, 314, '01.120', NULL, NULL, '2023-08-29 15:41:03.817766', '2023-08-29 15:41:03.817766');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (315, 315, '01.120', NULL, NULL, '2023-08-29 15:41:03.85275', '2023-08-29 15:41:03.85275');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (316, 316, '01.120', NULL, NULL, '2023-08-29 15:41:03.901923', '2023-08-29 15:41:03.901923');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (317, 317, '01.120', '90.012', '70.220', '2023-08-29 15:41:03.947455', '2023-08-29 15:41:03.947455');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (318, 318, '01.120', '90.012', NULL, '2023-08-29 15:41:03.986954', '2023-08-29 15:41:03.986954');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (319, 319, '01.120', '90.012', NULL, '2023-08-29 15:41:04.023494', '2023-08-29 15:41:04.023494');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (320, 320, '01.120', NULL, NULL, '2023-08-29 15:41:04.069084', '2023-08-29 15:41:04.069084');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (321, 321, '01.120', '90.012', NULL, '2023-08-29 15:41:04.097764', '2023-08-29 15:41:04.097764');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (322, 322, '01.120', NULL, NULL, '2023-08-29 15:41:04.125773', '2023-08-29 15:41:04.125773');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (323, 323, '01.120', '90.012', NULL, '2023-08-29 15:41:04.156929', '2023-08-29 15:41:04.156929');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (324, 324, '01.120', NULL, NULL, '2023-08-29 15:41:04.190493', '2023-08-29 15:41:04.190493');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (325, 325, '01.120', '90.012', '70.220', '2023-08-29 15:41:04.226045', '2023-08-29 15:41:04.226045');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (326, 326, '01.120', '90.012', NULL, '2023-08-29 15:41:04.248064', '2023-08-29 15:41:04.248064');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (327, 327, '01.120', '90.012', NULL, '2023-08-29 15:41:04.280237', '2023-08-29 15:41:04.280237');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (328, 328, '01.120', '90.012', NULL, '2023-08-29 15:41:04.314107', '2023-08-29 15:41:04.314107');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (329, 329, '01.120', NULL, NULL, '2023-08-29 15:41:04.343312', '2023-08-29 15:41:04.343312');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (330, 330, '01.120', '90.012', NULL, '2023-08-29 15:41:04.374029', '2023-08-29 15:41:04.374029');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (331, 331, '01.120', NULL, NULL, '2023-08-29 15:41:04.403116', '2023-08-29 15:41:04.403116');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (332, 332, '01.120', NULL, NULL, '2023-08-29 15:41:04.425828', '2023-08-29 15:41:04.425828');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (333, 333, '01.120', NULL, NULL, '2023-08-29 15:41:04.45352', '2023-08-29 15:41:04.45352');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (334, 334, '01.120', '90.012', '70.220', '2023-08-29 15:41:04.476958', '2023-08-29 15:41:04.476958');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (335, 335, '01.120', NULL, NULL, '2023-08-29 15:41:04.510109', '2023-08-29 15:41:04.510109');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (336, 336, '01.120', NULL, NULL, '2023-08-29 15:41:04.537515', '2023-08-29 15:41:04.537515');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (337, 337, '01.120', '90.012', NULL, '2023-08-29 15:41:04.568453', '2023-08-29 15:41:04.568453');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (338, 338, '01.120', NULL, NULL, '2023-08-29 15:41:04.601394', '2023-08-29 15:41:04.601394');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (339, 339, '01.120', '90.012', '70.220', '2023-08-29 15:41:04.630285', '2023-08-29 15:41:04.630285');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (340, 340, '01.120', NULL, NULL, '2023-08-29 15:41:04.658357', '2023-08-29 15:41:04.658357');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (341, 341, '01.120', NULL, NULL, '2023-08-29 15:41:04.67609', '2023-08-29 15:41:04.67609');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (342, 342, '01.120', '90.012', NULL, '2023-08-29 15:41:04.696294', '2023-08-29 15:41:04.696294');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (343, 343, '01.120', '90.012', NULL, '2023-08-29 15:41:04.718913', '2023-08-29 15:41:04.718913');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (344, 344, '01.120', '90.012', NULL, '2023-08-29 15:41:04.751917', '2023-08-29 15:41:04.751917');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (345, 345, '01.120', '90.012', NULL, '2023-08-29 15:41:04.805714', '2023-08-29 15:41:04.805714');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (346, 346, '01.120', '90.012', NULL, '2023-08-29 15:41:04.863751', '2023-08-29 15:41:04.863751');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (347, 347, '01.120', '90.012', '70.220', '2023-08-29 15:41:04.925418', '2023-08-29 15:41:04.925418');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (348, 348, '01.120', NULL, NULL, '2023-08-29 15:41:04.975489', '2023-08-29 15:41:04.975489');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (349, 349, '01.120', '90.012', '70.220', '2023-08-29 15:41:05.011825', '2023-08-29 15:41:05.011825');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (350, 350, '01.120', NULL, NULL, '2023-08-29 15:41:05.037545', '2023-08-29 15:41:05.037545');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (351, 351, '01.120', NULL, NULL, '2023-08-29 15:41:05.066889', '2023-08-29 15:41:05.066889');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (352, 352, '01.120', NULL, NULL, '2023-08-29 15:41:05.097872', '2023-08-29 15:41:05.097872');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (353, 353, '01.120', '90.012', NULL, '2023-08-29 15:41:05.126878', '2023-08-29 15:41:05.126878');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (354, 354, '01.120', '90.012', '70.220', '2023-08-29 15:41:05.160795', '2023-08-29 15:41:05.160795');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (355, 355, '01.120', NULL, NULL, '2023-08-29 15:41:05.185962', '2023-08-29 15:41:05.185962');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (356, 356, '01.120', '90.012', NULL, '2023-08-29 15:41:05.208676', '2023-08-29 15:41:05.208676');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (357, 357, '01.120', NULL, NULL, '2023-08-29 15:41:05.242146', '2023-08-29 15:41:05.242146');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (358, 358, '01.120', NULL, NULL, '2023-08-29 15:41:05.265758', '2023-08-29 15:41:05.265758');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (359, 359, '01.120', NULL, NULL, '2023-08-29 15:41:05.288362', '2023-08-29 15:41:05.288362');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (360, 360, '01.120', NULL, NULL, '2023-08-29 15:41:05.324432', '2023-08-29 15:41:05.324432');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (361, 361, '01.120', NULL, NULL, '2023-08-29 15:41:05.352473', '2023-08-29 15:41:05.352473');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (362, 362, '01.120', NULL, NULL, '2023-08-29 15:41:05.377828', '2023-08-29 15:41:05.377828');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (363, 363, '01.120', NULL, NULL, '2023-08-29 15:41:05.401885', '2023-08-29 15:41:05.401885');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (364, 364, '01.120', '90.012', NULL, '2023-08-29 15:41:05.43338', '2023-08-29 15:41:05.43338');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (365, 365, '01.120', '90.012', NULL, '2023-08-29 15:41:05.465779', '2023-08-29 15:41:05.465779');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (366, 366, '01.120', NULL, NULL, '2023-08-29 15:41:05.490524', '2023-08-29 15:41:05.490524');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (367, 367, '01.120', NULL, NULL, '2023-08-29 15:41:05.526629', '2023-08-29 15:41:05.526629');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (368, 368, '01.120', NULL, NULL, '2023-08-29 15:41:05.568045', '2023-08-29 15:41:05.568045');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (369, 369, '01.120', '90.012', NULL, '2023-08-29 15:41:05.59927', '2023-08-29 15:41:05.59927');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (370, 370, '01.120', NULL, NULL, '2023-08-29 15:41:05.625112', '2023-08-29 15:41:05.625112');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (371, 371, '01.120', '90.012', NULL, '2023-08-29 15:41:05.652942', '2023-08-29 15:41:05.652942');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (372, 372, '01.120', NULL, NULL, '2023-08-29 15:41:05.673099', '2023-08-29 15:41:05.673099');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (373, 373, '01.120', '90.012', '70.220', '2023-08-29 15:41:05.703932', '2023-08-29 15:41:05.703932');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (374, 374, '01.120', NULL, NULL, '2023-08-29 15:41:05.732163', '2023-08-29 15:41:05.732163');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (375, 375, '01.120', NULL, NULL, '2023-08-29 15:41:05.758453', '2023-08-29 15:41:05.758453');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (376, 376, '01.120', '90.012', NULL, '2023-08-29 15:41:05.786517', '2023-08-29 15:41:05.786517');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (377, 377, '01.120', NULL, NULL, '2023-08-29 15:41:05.816955', '2023-08-29 15:41:05.816955');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (378, 378, '01.120', NULL, NULL, '2023-08-29 15:41:05.843655', '2023-08-29 15:41:05.843655');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (379, 379, '01.120', '90.012', NULL, '2023-08-29 15:41:05.878607', '2023-08-29 15:41:05.878607');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (380, 380, '01.120', NULL, NULL, '2023-08-29 15:41:05.919551', '2023-08-29 15:41:05.919551');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (381, 381, '01.120', NULL, NULL, '2023-08-29 15:41:05.956071', '2023-08-29 15:41:05.956071');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (382, 382, '01.120', '90.012', NULL, '2023-08-29 15:41:05.997345', '2023-08-29 15:41:05.997345');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (383, 383, '01.120', '90.012', NULL, '2023-08-29 15:41:06.025752', '2023-08-29 15:41:06.025752');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (384, 384, '01.120', '90.012', NULL, '2023-08-29 15:41:06.051508', '2023-08-29 15:41:06.051508');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (385, 385, '01.120', '90.012', NULL, '2023-08-29 15:41:06.086516', '2023-08-29 15:41:06.086516');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (386, 386, '01.120', '90.012', NULL, '2023-08-29 15:41:06.110216', '2023-08-29 15:41:06.110216');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (387, 387, '01.120', '90.012', '70.220', '2023-08-29 15:41:06.135105', '2023-08-29 15:41:06.135105');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (388, 388, '01.120', NULL, NULL, '2023-08-29 15:41:06.165414', '2023-08-29 15:41:06.165414');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (389, 389, '01.120', NULL, NULL, '2023-08-29 15:41:06.193646', '2023-08-29 15:41:06.193646');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (390, 390, '01.120', NULL, NULL, '2023-08-29 15:41:06.232749', '2023-08-29 15:41:06.232749');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (391, 391, '01.120', NULL, NULL, '2023-08-29 15:41:06.265407', '2023-08-29 15:41:06.265407');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (392, 392, '01.120', NULL, NULL, '2023-08-29 15:41:06.283874', '2023-08-29 15:41:06.283874');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (393, 393, '01.120', NULL, NULL, '2023-08-29 15:41:06.30647', '2023-08-29 15:41:06.30647');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (394, 394, '01.120', '90.012', NULL, '2023-08-29 15:41:06.328189', '2023-08-29 15:41:06.328189');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (395, 395, '01.120', NULL, NULL, '2023-08-29 15:41:06.357339', '2023-08-29 15:41:06.357339');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (396, 396, '01.120', NULL, NULL, '2023-08-29 15:41:06.372622', '2023-08-29 15:41:06.372622');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (397, 397, '01.120', NULL, NULL, '2023-08-29 15:41:06.390129', '2023-08-29 15:41:06.390129');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (398, 398, '01.120', '90.012', '70.220', '2023-08-29 15:41:06.416059', '2023-08-29 15:41:06.416059');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (399, 399, '01.120', NULL, NULL, '2023-08-29 15:41:06.447016', '2023-08-29 15:41:06.447016');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (400, 400, '01.120', NULL, NULL, '2023-08-29 15:41:06.479802', '2023-08-29 15:41:06.479802');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (401, 401, '01.120', '90.012', '70.220', '2023-08-29 15:41:06.506317', '2023-08-29 15:41:06.506317');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (402, 402, '01.120', NULL, NULL, '2023-08-29 15:41:06.537731', '2023-08-29 15:41:06.537731');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (403, 403, '01.120', NULL, NULL, '2023-08-29 15:41:06.574305', '2023-08-29 15:41:06.574305');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (404, 404, '01.120', '90.012', NULL, '2023-08-29 15:41:06.609359', '2023-08-29 15:41:06.609359');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (405, 405, '01.120', '90.012', '70.220', '2023-08-29 15:41:06.632731', '2023-08-29 15:41:06.632731');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (406, 406, '01.120', '90.012', '70.220', '2023-08-29 15:41:06.655616', '2023-08-29 15:41:06.655616');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (407, 407, '01.120', '90.012', '70.220', '2023-08-29 15:41:06.680709', '2023-08-29 15:41:06.680709');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (408, 408, '01.120', NULL, NULL, '2023-08-29 15:41:06.711897', '2023-08-29 15:41:06.711897');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (409, 409, '01.120', NULL, NULL, '2023-08-29 15:41:06.728313', '2023-08-29 15:41:06.728313');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (410, 410, '01.120', NULL, NULL, '2023-08-29 15:41:06.75397', '2023-08-29 15:41:06.75397');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (411, 411, '01.120', '90.012', NULL, '2023-08-29 15:41:06.78818', '2023-08-29 15:41:06.78818');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (412, 412, '01.120', '90.012', NULL, '2023-08-29 15:41:06.817165', '2023-08-29 15:41:06.817165');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (413, 413, '01.120', NULL, NULL, '2023-08-29 15:41:06.848731', '2023-08-29 15:41:06.848731');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (414, 414, '01.120', NULL, NULL, '2023-08-29 15:41:06.871209', '2023-08-29 15:41:06.871209');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (415, 415, '01.120', '90.012', '70.220', '2023-08-29 15:41:06.893598', '2023-08-29 15:41:06.893598');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (416, 416, '01.120', '90.012', NULL, '2023-08-29 15:41:06.941864', '2023-08-29 15:41:06.941864');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (417, 417, '01.120', NULL, NULL, '2023-08-29 15:41:06.970243', '2023-08-29 15:41:06.970243');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (418, 418, '01.120', '90.012', NULL, '2023-08-29 15:41:07.016197', '2023-08-29 15:41:07.016197');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (419, 419, '01.120', NULL, NULL, '2023-08-29 15:41:07.045315', '2023-08-29 15:41:07.045315');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (420, 420, '01.120', '90.012', NULL, '2023-08-29 15:41:07.066122', '2023-08-29 15:41:07.066122');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (421, 421, '01.120', '90.012', NULL, '2023-08-29 15:41:07.090829', '2023-08-29 15:41:07.090829');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (422, 422, '01.120', NULL, NULL, '2023-08-29 15:41:07.128735', '2023-08-29 15:41:07.128735');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (423, 423, '01.120', '90.012', NULL, '2023-08-29 15:41:07.151612', '2023-08-29 15:41:07.151612');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (424, 424, '01.120', NULL, NULL, '2023-08-29 15:41:07.183382', '2023-08-29 15:41:07.183382');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (425, 425, '01.120', NULL, NULL, '2023-08-29 15:41:07.207502', '2023-08-29 15:41:07.207502');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (426, 426, '01.120', NULL, NULL, '2023-08-29 15:41:07.229669', '2023-08-29 15:41:07.229669');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (427, 427, '01.120', '90.012', NULL, '2023-08-29 15:41:07.255183', '2023-08-29 15:41:07.255183');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (428, 428, '01.120', NULL, NULL, '2023-08-29 15:41:07.275849', '2023-08-29 15:41:07.275849');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (429, 429, '01.120', NULL, NULL, '2023-08-29 15:41:07.302449', '2023-08-29 15:41:07.302449');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (430, 430, '01.120', NULL, NULL, '2023-08-29 15:41:07.335646', '2023-08-29 15:41:07.335646');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (431, 431, '01.120', NULL, NULL, '2023-08-29 15:41:07.361066', '2023-08-29 15:41:07.361066');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (432, 432, '01.120', NULL, NULL, '2023-08-29 15:41:07.405375', '2023-08-29 15:41:07.405375');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (433, 433, '01.120', NULL, NULL, '2023-08-29 15:41:07.455355', '2023-08-29 15:41:07.455355');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (434, 434, '01.120', '90.012', NULL, '2023-08-29 15:41:07.491831', '2023-08-29 15:41:07.491831');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (435, 435, '01.120', NULL, NULL, '2023-08-29 15:41:07.531933', '2023-08-29 15:41:07.531933');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (436, 436, '01.120', '90.012', '70.220', '2023-08-29 15:41:07.569665', '2023-08-29 15:41:07.569665');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (437, 437, '01.120', '90.012', NULL, '2023-08-29 15:41:07.602802', '2023-08-29 15:41:07.602802');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (438, 438, '01.120', NULL, NULL, '2023-08-29 15:41:07.629992', '2023-08-29 15:41:07.629992');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (439, 439, '01.120', '90.012', NULL, '2023-08-29 15:41:07.651376', '2023-08-29 15:41:07.651376');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (440, 440, '01.120', NULL, NULL, '2023-08-29 15:41:07.681319', '2023-08-29 15:41:07.681319');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (441, 441, '01.120', '90.012', '70.220', '2023-08-29 15:41:07.708324', '2023-08-29 15:41:07.708324');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (442, 442, '01.120', '90.012', NULL, '2023-08-29 15:41:07.730972', '2023-08-29 15:41:07.730972');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (443, 443, '01.120', '90.012', NULL, '2023-08-29 15:41:07.768095', '2023-08-29 15:41:07.768095');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (444, 444, '01.120', '90.012', '70.220', '2023-08-29 15:41:07.804995', '2023-08-29 15:41:07.804995');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (445, 445, '01.120', '90.012', '70.220', '2023-08-29 15:41:07.839937', '2023-08-29 15:41:07.839937');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (446, 446, '01.120', '90.012', '70.220', '2023-08-29 15:41:07.870031', '2023-08-29 15:41:07.870031');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (447, 447, '01.120', NULL, NULL, '2023-08-29 15:41:07.909699', '2023-08-29 15:41:07.909699');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (448, 448, '01.120', NULL, NULL, '2023-08-29 15:41:07.942251', '2023-08-29 15:41:07.942251');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (449, 449, '01.120', '90.012', NULL, '2023-08-29 15:41:07.981144', '2023-08-29 15:41:07.981144');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (450, 450, '01.120', '90.012', '70.220', '2023-08-29 15:41:08.004323', '2023-08-29 15:41:08.004323');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (451, 451, '01.120', '90.012', '70.220', '2023-08-29 15:41:08.033079', '2023-08-29 15:41:08.033079');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (452, 452, '01.120', NULL, NULL, '2023-08-29 15:41:08.066742', '2023-08-29 15:41:08.066742');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (453, 453, '01.120', '90.012', NULL, '2023-08-29 15:41:08.093771', '2023-08-29 15:41:08.093771');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (454, 454, '01.120', NULL, NULL, '2023-08-29 15:41:08.114813', '2023-08-29 15:41:08.114813');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (455, 455, '01.120', NULL, NULL, '2023-08-29 15:41:08.146916', '2023-08-29 15:41:08.146916');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (456, 456, '01.120', NULL, NULL, '2023-08-29 15:41:08.174652', '2023-08-29 15:41:08.174652');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (457, 457, '01.120', NULL, NULL, '2023-08-29 15:41:08.201418', '2023-08-29 15:41:08.201418');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (458, 458, '01.120', '90.012', '70.220', '2023-08-29 15:41:08.227272', '2023-08-29 15:41:08.227272');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (459, 459, '01.120', '90.012', NULL, '2023-08-29 15:41:08.254192', '2023-08-29 15:41:08.254192');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (460, 460, '01.120', NULL, NULL, '2023-08-29 15:41:08.278113', '2023-08-29 15:41:08.278113');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (461, 461, '01.120', NULL, NULL, '2023-08-29 15:41:08.306032', '2023-08-29 15:41:08.306032');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (462, 462, '01.120', NULL, NULL, '2023-08-29 15:41:08.328755', '2023-08-29 15:41:08.328755');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (463, 463, '01.120', NULL, NULL, '2023-08-29 15:41:08.35774', '2023-08-29 15:41:08.35774');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (464, 464, '01.120', '90.012', '70.220', '2023-08-29 15:41:08.382589', '2023-08-29 15:41:08.382589');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (465, 465, '01.120', '90.012', NULL, '2023-08-29 15:41:08.427961', '2023-08-29 15:41:08.427961');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (466, 466, '01.120', NULL, NULL, '2023-08-29 15:41:08.471646', '2023-08-29 15:41:08.471646');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (467, 467, '01.120', NULL, NULL, '2023-08-29 15:41:08.49239', '2023-08-29 15:41:08.49239');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (468, 468, '01.120', '90.012', NULL, '2023-08-29 15:41:08.512874', '2023-08-29 15:41:08.512874');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (469, 469, '01.120', NULL, NULL, '2023-08-29 15:41:08.541625', '2023-08-29 15:41:08.541625');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (470, 470, '01.120', '90.012', NULL, '2023-08-29 15:41:08.573552', '2023-08-29 15:41:08.573552');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (471, 471, '01.120', NULL, NULL, '2023-08-29 15:41:08.609433', '2023-08-29 15:41:08.609433');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (472, 472, '01.120', NULL, NULL, '2023-08-29 15:41:08.640646', '2023-08-29 15:41:08.640646');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (473, 473, '01.120', '90.012', '70.220', '2023-08-29 15:41:08.675196', '2023-08-29 15:41:08.675196');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (474, 474, '01.120', NULL, NULL, '2023-08-29 15:41:08.703481', '2023-08-29 15:41:08.703481');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (475, 475, '01.120', NULL, NULL, '2023-08-29 15:41:08.725775', '2023-08-29 15:41:08.725775');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (476, 476, '01.120', '90.012', NULL, '2023-08-29 15:41:08.748415', '2023-08-29 15:41:08.748415');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (477, 477, '01.120', '90.012', NULL, '2023-08-29 15:41:08.771896', '2023-08-29 15:41:08.771896');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (478, 478, '01.120', '90.012', '70.220', '2023-08-29 15:41:08.798271', '2023-08-29 15:41:08.798271');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (479, 479, '01.120', NULL, NULL, '2023-08-29 15:41:08.830948', '2023-08-29 15:41:08.830948');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (480, 480, '01.120', NULL, NULL, '2023-08-29 15:41:08.850686', '2023-08-29 15:41:08.850686');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (481, 481, '01.120', NULL, NULL, '2023-08-29 15:41:08.876581', '2023-08-29 15:41:08.876581');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (482, 482, '01.120', '90.012', '70.220', '2023-08-29 15:41:08.946085', '2023-08-29 15:41:08.946085');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (483, 483, '01.120', '90.012', '70.220', '2023-08-29 15:41:09.003005', '2023-08-29 15:41:09.003005');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (484, 484, '01.120', '90.012', NULL, '2023-08-29 15:41:09.048337', '2023-08-29 15:41:09.048337');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (485, 485, '01.120', NULL, NULL, '2023-08-29 15:41:09.082981', '2023-08-29 15:41:09.082981');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (486, 486, '01.120', NULL, NULL, '2023-08-29 15:41:09.113662', '2023-08-29 15:41:09.113662');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (487, 487, '01.120', '90.012', NULL, '2023-08-29 15:41:09.142783', '2023-08-29 15:41:09.142783');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (488, 488, '01.120', '90.012', NULL, '2023-08-29 15:41:09.161598', '2023-08-29 15:41:09.161598');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (489, 489, '01.120', NULL, NULL, '2023-08-29 15:41:09.182806', '2023-08-29 15:41:09.182806');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (490, 490, '01.120', '90.012', '70.220', '2023-08-29 15:41:09.206686', '2023-08-29 15:41:09.206686');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (491, 491, '01.120', NULL, NULL, '2023-08-29 15:41:09.230126', '2023-08-29 15:41:09.230126');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (492, 492, '01.120', '90.012', '70.220', '2023-08-29 15:41:09.255868', '2023-08-29 15:41:09.255868');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (493, 493, '01.120', '90.012', '70.220', '2023-08-29 15:41:09.276996', '2023-08-29 15:41:09.276996');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (494, 494, '01.120', NULL, NULL, '2023-08-29 15:41:09.312773', '2023-08-29 15:41:09.312773');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (495, 495, '01.120', '90.012', NULL, '2023-08-29 15:41:09.335445', '2023-08-29 15:41:09.335445');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (496, 496, '01.120', '90.012', '70.220', '2023-08-29 15:41:09.371997', '2023-08-29 15:41:09.371997');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (497, 497, '01.120', '90.012', NULL, '2023-08-29 15:41:09.404087', '2023-08-29 15:41:09.404087');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (498, 498, '01.120', '90.012', NULL, '2023-08-29 15:41:09.431946', '2023-08-29 15:41:09.431946');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (499, 499, '01.120', NULL, NULL, '2023-08-29 15:41:09.475252', '2023-08-29 15:41:09.475252');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (500, 500, '01.120', '90.012', '70.220', '2023-08-29 15:41:09.511618', '2023-08-29 15:41:09.511618');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (501, 501, '01.120', NULL, NULL, '2023-08-29 15:41:09.552827', '2023-08-29 15:41:09.552827');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (502, 502, '01.120', NULL, NULL, '2023-08-29 15:41:09.58363', '2023-08-29 15:41:09.58363');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (503, 503, '01.120', NULL, NULL, '2023-08-29 15:41:09.608921', '2023-08-29 15:41:09.608921');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (504, 504, '01.120', NULL, NULL, '2023-08-29 15:41:09.634925', '2023-08-29 15:41:09.634925');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (505, 505, '01.120', '90.012', NULL, '2023-08-29 15:41:09.670209', '2023-08-29 15:41:09.670209');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (506, 506, '01.120', '90.012', NULL, '2023-08-29 15:41:09.694865', '2023-08-29 15:41:09.694865');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (507, 507, '01.120', NULL, NULL, '2023-08-29 15:41:09.728194', '2023-08-29 15:41:09.728194');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (508, 508, '01.120', '90.012', '70.220', '2023-08-29 15:41:09.750239', '2023-08-29 15:41:09.750239');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (509, 509, '01.120', '90.012', '70.220', '2023-08-29 15:41:09.777317', '2023-08-29 15:41:09.777317');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (510, 510, '01.120', '90.012', '70.220', '2023-08-29 15:41:09.82538', '2023-08-29 15:41:09.82538');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (511, 511, '01.120', NULL, NULL, '2023-08-29 15:41:20.355184', '2023-08-29 15:41:20.355184');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (517, 517, '01.120', NULL, NULL, '2023-08-29 15:41:20.534848', '2023-08-29 15:41:20.534848');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (518, 518, '01.120', NULL, NULL, '2023-08-29 15:41:20.557653', '2023-08-29 15:41:20.557653');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (519, 519, '01.120', '90.012', '70.220', '2023-08-29 15:41:20.582072', '2023-08-29 15:41:20.582072');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (520, 520, '01.120', '90.012', '70.220', '2023-08-29 15:41:20.607566', '2023-08-29 15:41:20.607566');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (521, 521, '01.120', NULL, NULL, '2023-08-29 15:41:20.629882', '2023-08-29 15:41:20.629882');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (522, 522, '01.120', NULL, NULL, '2023-08-29 15:41:20.652638', '2023-08-29 15:41:20.652638');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (523, 523, '01.120', NULL, NULL, '2023-08-29 15:41:20.691448', '2023-08-29 15:41:20.691448');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (524, 524, '01.120', NULL, NULL, '2023-08-29 15:41:20.711698', '2023-08-29 15:41:20.711698');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (525, 525, '01.120', NULL, NULL, '2023-08-29 15:41:20.760291', '2023-08-29 15:41:20.760291');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (526, 526, '01.120', '90.012', '70.220', '2023-08-29 15:41:20.795043', '2023-08-29 15:41:20.795043');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (512, 512, '01.120', NULL, NULL, '2023-08-29 15:41:27.580458', '2023-08-29 15:41:20.392236');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (513, 513, '01.120', NULL, NULL, '2023-08-29 15:41:27.597161', '2023-08-29 15:41:20.423669');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (514, 514, '01.120', NULL, NULL, '2023-08-29 15:41:27.618667', '2023-08-29 15:41:20.448565');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (515, 515, '01.120', NULL, NULL, '2023-08-29 15:41:27.631099', '2023-08-29 15:41:20.471747');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (516, 516, '01.120', '90.012', NULL, '2023-08-29 15:41:27.64321', '2023-08-29 15:41:20.498964');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (527, 527, '01.120', '01.110', '70.220', '2023-08-29 15:41:27.648846', '2023-08-29 15:41:20.827549');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (534, 534, '01.120', '90.012', '70.220', '2023-08-29 15:41:27.743092', '2023-08-29 15:41:27.743092');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (535, 535, '01.120', '90.012', NULL, '2023-08-29 15:41:27.747787', '2023-08-29 15:41:27.747787');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (536, 536, '01.120', '90.012', NULL, '2023-08-29 15:41:27.752738', '2023-08-29 15:41:27.752738');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (537, 537, '01.120', NULL, NULL, '2023-08-29 15:41:27.759335', '2023-08-29 15:41:27.759335');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (538, 538, '01.120', '90.012', NULL, '2023-08-29 15:41:27.76472', '2023-08-29 15:41:27.76472');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.150253');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.22526');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '555555555', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.22526');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (6, '851137753', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.22526');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '852104530', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.262384');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '807686992', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.262384');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '802398455', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.290163');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '833276442', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.338951');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (15, '839258152', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.338951');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (16, '807576151', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.372461');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (17, '850913244', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.372461');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (18, '895920338', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.372461');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (19, '836472840', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.372461');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (20, '822673392', 'VIRKSOMHET', '9', '2023-08-29 15:41:14.410994');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (21, '887128573', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.410994');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (22, '850313595', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.410994');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '826526358', 'VIRKSOMHET', '9', '2023-08-29 15:41:14.410994');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '868229775', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.464701');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (25, '830135417', 'VIRKSOMHET', '9', '2023-08-29 15:41:14.464701');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '861395649', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.527123');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (27, '854415713', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.527123');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '862293147', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.559346');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (29, '893597205', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.559346');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '890770619', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.589988');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (31, '860001813', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.589988');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '883513987', 'VIRKSOMHET', '9', '2023-08-29 15:41:14.589988');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '895897798', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.621637');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '881142130', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.621637');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '854024937', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.652605');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '813141705', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.652605');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '828562569', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.700031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '833109464', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.700031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '886747994', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.700031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '848152346', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.700031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '825933759', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.733602');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '814690513', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.733602');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '851970156', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.733602');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '868511260', 'VIRKSOMHET', '9', '2023-08-29 15:41:14.775129');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '830016645', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.775129');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '855026158', 'VIRKSOMHET', '9', '2023-08-29 15:41:14.775129');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '815935399', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.802714');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '889414930', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.802714');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '880049406', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.802714');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '874394949', 'VIRKSOMHET', '9', '2023-08-29 15:41:14.833667');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '837847297', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.833667');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '883745258', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.886078');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '862454991', 'VIRKSOMHET', '9', '2023-08-29 15:41:14.886078');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '860113451', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.886078');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '829554318', 'VIRKSOMHET', '2', '2023-08-29 15:41:14.928973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '822008150', 'VIRKSOMHET', '9', '2023-08-29 15:41:14.928973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '846330108', 'VIRKSOMHET', '9', '2023-08-29 15:41:14.928973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '833112838', 'VIRKSOMHET', '1', '2023-08-29 15:41:14.965307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '872591676', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.965307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '860029289', 'VIRKSOMHET', '3', '2023-08-29 15:41:14.965307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '891988313', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.018043');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '810800936', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.018043');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '826304723', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.06102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '842368398', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.06102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '800088073', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.06102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '804056780', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.06102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '804071213', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.06102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '820154688', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.06102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '845863731', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.101108');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '883360358', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.101108');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '876784801', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.101108');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '894296991', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.133718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '811139665', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.133718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '803395093', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.133718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '881308154', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.16764');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '858673060', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.16764');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '864584378', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.16764');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '811805933', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.206302');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '843998631', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.206302');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '807742610', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.238938');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '817024036', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.238938');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '894510299', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.238938');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '882979718', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.238938');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '820922005', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.238938');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '802652255', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.269347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '800028335', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.269347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '806830647', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.269347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '875024581', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.269347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '857530854', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.324917');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '868564499', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.324917');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '891332471', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.371562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '869425048', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.371562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '876047468', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.371562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '873464281', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.371562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '801699286', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.414113');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '852299828', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.414113');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '899052538', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.414113');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '884824815', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.448829');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '872546768', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.448829');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '836460310', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.516924');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '830319650', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.516924');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '840782943', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.549497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '852197780', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.549497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '800883616', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.549497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '824222593', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.572383');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '828229897', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.572383');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '853872043', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.619686');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '874698776', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.649913');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '864225323', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.649913');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '860689823', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.649913');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '837622686', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.687178');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '830385086', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.687178');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '881748098', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.711379');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '843242787', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.711379');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '858993885', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.745834');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '837367306', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.745834');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '882886632', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.769594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '836876279', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.769594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '892895220', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.769594');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '834326743', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.80665');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '882121457', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.80665');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '880716859', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.838187');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '895819799', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.838187');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '880564530', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.857467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '846886752', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.857467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '898989109', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.88759');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '800011345', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.88759');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '897397259', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.88759');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '823589360', 'VIRKSOMHET', '1', '2023-08-29 15:41:15.910307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '800146846', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.910307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '832421836', 'VIRKSOMHET', '3', '2023-08-29 15:41:15.957203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '832949251', 'VIRKSOMHET', '2', '2023-08-29 15:41:15.957203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '863286333', 'VIRKSOMHET', '9', '2023-08-29 15:41:15.957203');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '879969815', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.011555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '860767985', 'VIRKSOMHET', '9', '2023-08-29 15:41:16.073993');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '844833881', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.073993');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '801398410', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.106421');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '883614387', 'VIRKSOMHET', '9', '2023-08-29 15:41:16.106421');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '816105744', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.136251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '878011469', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.136251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '885803184', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.176409');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '848263054', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.215832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '897957146', 'VIRKSOMHET', '9', '2023-08-29 15:41:16.215832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '808478749', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.215832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '888040470', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.248031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '834999357', 'VIRKSOMHET', '2', '2023-08-29 15:41:16.248031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '887207722', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.248031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '852437784', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.248031');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '819785097', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.278375');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '867188209', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.278375');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '881550924', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.278375');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '835379695', 'VIRKSOMHET', '9', '2023-08-29 15:41:16.307874');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '880617782', 'VIRKSOMHET', '9', '2023-08-29 15:41:16.307874');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '853760011', 'VIRKSOMHET', '9', '2023-08-29 15:41:16.307874');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '821849235', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.307874');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '858115062', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.329011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '869577747', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.329011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '800095119', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.329011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '884112569', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.349559');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '839810200', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.349559');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '891387618', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.349559');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '892351179', 'VIRKSOMHET', '9', '2023-08-29 15:41:16.349559');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '818384717', 'VIRKSOMHET', '2', '2023-08-29 15:41:16.386724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '815743441', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.386724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '851397068', 'VIRKSOMHET', '9', '2023-08-29 15:41:16.386724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '875534564', 'VIRKSOMHET', '2', '2023-08-29 15:41:16.406962');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '801281104', 'VIRKSOMHET', '2', '2023-08-29 15:41:16.406962');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '865687238', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.446149');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '854703296', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.446149');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '878480632', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.477472');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '886814557', 'VIRKSOMHET', '2', '2023-08-29 15:41:16.477472');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '807657039', 'VIRKSOMHET', '9', '2023-08-29 15:41:16.55681');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '866503879', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.55681');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '879255744', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.600523');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '836040137', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.600523');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '835974207', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.600523');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '868960486', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.600523');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '800922553', 'VIRKSOMHET', '2', '2023-08-29 15:41:16.6565');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '849827380', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.6565');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '813075874', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.6565');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '895048096', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.6565');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '800493742', 'VIRKSOMHET', '2', '2023-08-29 15:41:16.6565');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '896767809', 'VIRKSOMHET', '9', '2023-08-29 15:41:16.718267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '880634250', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.718267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '831707731', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.823822');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '867072306', 'VIRKSOMHET', '2', '2023-08-29 15:41:16.823822');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '898091120', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.823822');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '820345524', 'VIRKSOMHET', '3', '2023-08-29 15:41:16.894635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '811514303', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.894635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '888227038', 'VIRKSOMHET', '2', '2023-08-29 15:41:16.894635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '824351597', 'VIRKSOMHET', '9', '2023-08-29 15:41:16.894635');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '898909248', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.946503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '833801366', 'VIRKSOMHET', '2', '2023-08-29 15:41:16.946503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '885444119', 'VIRKSOMHET', '2', '2023-08-29 15:41:16.946503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '865794794', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.946503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '868806184', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.986446');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '809005837', 'VIRKSOMHET', '1', '2023-08-29 15:41:16.986446');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '888993141', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.038234');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '855555426', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.079372');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '899843792', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.079372');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '875763838', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.118852');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '897966038', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.118852');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '886073506', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.118852');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '889870174', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.153265');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '869904540', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.153265');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '821894505', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.153265');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '812212065', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.191503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '854723519', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.191503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '892918228', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.235792');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '858126546', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.235792');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '858394926', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.257983');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '881372741', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.257983');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '828822894', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.257983');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '804452158', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.308855');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '812803827', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.308855');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '851163302', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.34601');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '887970150', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.34601');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '885228334', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.34601');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '803989289', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.382588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '885663079', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.382588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '880836681', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.382588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '890484231', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.382588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '876207551', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.382588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '816635391', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.472634');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '804710504', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.472634');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '863736808', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.515774');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '812752597', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.515774');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '846383406', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.515774');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '862716503', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.515774');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '854308355', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.585534');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '847640744', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.585534');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '858653530', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.585534');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '881633232', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.585534');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '832936423', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.648828');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '868397690', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.687124');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '875009936', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.687124');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '806934151', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.687124');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '873202447', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.710825');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '885786568', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.710825');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '834856113', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.710825');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '836784911', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.758496');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '894747218', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.758496');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '895681992', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.784035');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '832637622', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.784035');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '874482558', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.784035');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '855761730', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.784035');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '820139087', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.847509');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '865386572', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.900141');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '829511734', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.900141');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '811846482', 'VIRKSOMHET', '1', '2023-08-29 15:41:17.900141');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '854256242', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.921128');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '865097331', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.921128');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '876783179', 'VIRKSOMHET', '9', '2023-08-29 15:41:17.944814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '899264391', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.944814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '894999875', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.944814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '816627945', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.964909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '864598083', 'VIRKSOMHET', '2', '2023-08-29 15:41:17.964909');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '840970664', 'VIRKSOMHET', '3', '2023-08-29 15:41:17.999484');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '827743840', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.026377');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '827433286', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.026377');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '847189640', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.026377');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '831633908', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.026377');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '867645704', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.026377');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '812108401', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.026377');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '889335036', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.047884');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '844930296', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.070654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '851548938', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.070654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '874171433', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.070654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '867713572', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.09175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '813483207', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.09175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '805031170', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.09175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '862102260', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.112238');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '816146647', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.112238');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '848438344', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.133326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '816933976', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.133326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '882893771', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.133326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '885095175', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.15504');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '820914876', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.15504');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '819663639', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.15504');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '887228311', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.178904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '832446008', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.178904');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '813258210', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.220207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '888116513', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.220207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '875730862', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.256323');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '848841245', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.256323');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '841256069', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.256323');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '805207537', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.256323');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '818993953', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.256323');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '831454006', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.289803');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '883416962', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.289803');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '809416939', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.289803');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '813799118', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.289803');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '863491262', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.320197');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '867056903', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.320197');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '885874897', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.320197');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '889159375', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.349402');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '888451869', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.349402');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '891420733', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.349402');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '896940956', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.375466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '827161001', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.375466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '843998028', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.375466');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '832385490', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.396653');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '828970725', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.396653');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '884294930', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.396653');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '884539162', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.396653');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '839707107', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.426892');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '857501205', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.426892');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '892829715', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.444403');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '835144465', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.444403');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '833673063', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.468847');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '893494597', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.468847');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '831839631', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.500451');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '857180192', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.500451');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '802650881', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.539255');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '842224053', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.539255');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '886538999', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.561449');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '819435752', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.561449');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '824307021', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.561449');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '875204204', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.561449');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '879284008', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.589643');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '803494974', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.60847');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '809317616', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.629675');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '839093982', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.629675');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '801964879', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.679119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '870320690', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.679119');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '834707050', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.701317');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '802466699', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.701317');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '801062547', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.701317');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '821343665', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.701317');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '817936779', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.701317');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '877671658', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.701317');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '819018936', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.701317');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '800286721', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.701317');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '825254008', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.722337');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '850450265', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.722337');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '886304033', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.722337');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '811041360', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.745957');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '817484495', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.745957');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '896259714', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.745957');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '877179757', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.745957');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '880502805', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.769263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '864532427', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.769263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '865196110', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.796776');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '890377554', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.796776');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '890477159', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.796776');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '868311985', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.796776');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '881487654', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.841286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '819222250', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.841286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '806628725', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.841286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '883691516', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.841286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '812745366', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.841286');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '829741575', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.872545');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '874898152', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.872545');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '817852775', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.872545');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '809591404', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.872545');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '832352774', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.872545');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '838346408', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.872545');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '885516480', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.872545');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '849774021', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.872545');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '850986342', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.907542');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '808083042', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.907542');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '802046791', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.907542');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '875562853', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.926683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '845556525', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.926683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '897253649', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.926683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '864262533', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.926683');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '885952882', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.946954');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '840097094', 'VIRKSOMHET', '9', '2023-08-29 15:41:18.946954');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '879243879', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.946954');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '844075519', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.967938');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '866317127', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.967938');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '840082452', 'VIRKSOMHET', '3', '2023-08-29 15:41:18.967938');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '898206411', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.967938');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '832564050', 'VIRKSOMHET', '1', '2023-08-29 15:41:18.983447');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '836673562', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.983447');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '878495762', 'VIRKSOMHET', '2', '2023-08-29 15:41:18.983447');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '853514048', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.008919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '809198051', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.008919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '815803212', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.008919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '823868580', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.035262');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '856809969', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.035262');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '806197095', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.035262');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '875088087', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.061015');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '823976707', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.061015');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '817220330', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.087705');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '891478088', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.087705');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '868019564', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.087705');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '816244312', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.104741');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '860191016', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.104741');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '833832924', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.104741');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '880961071', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.123954');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '895091858', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.123954');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '883079881', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.123954');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '853367104', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.140744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '828309280', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.140744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '887350417', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.161338');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '832030436', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.161338');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '827350744', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.161338');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '886411231', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.17975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '817560052', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.17975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '835317170', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.202787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '841420446', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.202787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '820358357', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.202787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '846038499', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.218887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '807597881', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.218887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '878937891', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.218887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '853362787', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.218887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '829594073', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.235343');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '880327539', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.250577');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '830152078', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.250577');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '885606403', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.271282');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '876914756', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.271282');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '825345571', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.289742');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '897110971', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.289742');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '828171064', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.321888');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '839200091', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.321888');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '800828122', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.34395');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '820448355', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.34395');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '827162708', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.34395');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '818072316', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.364973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '880683442', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.364973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '839857951', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.364973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '861172682', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.406102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '832468180', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.406102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '835288541', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.406102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '895916424', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.437292');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '884908020', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.437292');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '862637850', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.437292');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '867225512', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.437292');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '867401631', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.437292');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '877300206', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.471322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '840496436', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.471322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '819305793', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.471322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '873601335', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.471322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '841551914', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.471322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '805115619', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.506044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '856407982', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.506044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '807229158', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.506044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '845910088', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.506044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '893522201', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.506044');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '839225416', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.55038');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '892994223', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.55038');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '824608397', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.55038');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '830789314', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.582263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '820111150', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.582263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '845783635', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.582263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '871562531', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.656867');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '815764078', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.656867');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '803431336', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.656867');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '881518598', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.676484');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '880282542', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.676484');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '878982724', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.676484');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '858422935', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.676484');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '852270662', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.692995');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '877943225', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.692995');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '894353446', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.692995');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '843899480', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.692995');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '864291871', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.692995');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '871725956', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.725153');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '852516782', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.738463');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '869347173', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.753269');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '822984515', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.77596');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '820967644', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.79614');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '812040694', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.79614');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '812596296', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.79614');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '825796909', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.8199');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '888220534', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.8199');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '828546683', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.837267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '888888152', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.837267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '806544734', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.837267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '861855954', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.860761');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '826747324', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.878926');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '823421563', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.878926');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '864279810', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.878926');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '815059394', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.904529');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '800677974', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.904529');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '869709608', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.904529');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '837340038', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.926467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '878196649', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.926467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '855021005', 'VIRKSOMHET', '2', '2023-08-29 15:41:19.926467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '842874686', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.941889');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '897678406', 'VIRKSOMHET', '1', '2023-08-29 15:41:19.941889');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '822440491', 'VIRKSOMHET', '9', '2023-08-29 15:41:19.941889');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '895236942', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.962699');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '873250306', 'VIRKSOMHET', '3', '2023-08-29 15:41:19.962699');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '896136191', 'VIRKSOMHET', '1', '2023-08-29 15:41:20.002115');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '830923847', 'VIRKSOMHET', '3', '2023-08-29 15:41:20.002115');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '839016903', 'VIRKSOMHET', '2', '2023-08-29 15:41:20.002115');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '840910627', 'VIRKSOMHET', '1', '2023-08-29 15:41:20.027425');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '826212807', 'VIRKSOMHET', '1', '2023-08-29 15:41:20.027425');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '830146348', 'VIRKSOMHET', '9', '2023-08-29 15:41:20.027425');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '865855341', 'VIRKSOMHET', '2', '2023-08-29 15:41:20.054775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '813254974', 'VIRKSOMHET', '9', '2023-08-29 15:41:20.054775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '878458400', 'VIRKSOMHET', '9', '2023-08-29 15:41:20.076408');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '819718155', 'VIRKSOMHET', '9', '2023-08-29 15:41:20.076408');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '840048395', 'VIRKSOMHET', '1', '2023-08-29 15:41:20.09641');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '817049990', 'VIRKSOMHET', '9', '2023-08-29 15:41:20.09641');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '823217376', 'VIRKSOMHET', '2', '2023-08-29 15:41:20.09641');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '814797335', 'VIRKSOMHET', '3', '2023-08-29 15:41:20.123135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '863017059', 'VIRKSOMHET', '2', '2023-08-29 15:41:20.123135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '829272494', 'VIRKSOMHET', '1', '2023-08-29 15:41:20.123135');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '821621583', 'VIRKSOMHET', '1', '2023-08-29 15:41:20.161046');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '808719782', 'VIRKSOMHET', '2', '2023-08-29 15:41:20.161046');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '805762106', 'VIRKSOMHET', '3', '2023-08-29 15:41:20.161046');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '823603319', 'VIRKSOMHET', '2', '2023-08-29 15:41:20.161046');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '824698886', 'VIRKSOMHET', '9', '2023-08-29 15:41:20.178518');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '829645138', 'VIRKSOMHET', '9', '2023-08-29 15:41:20.178518');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '826280365', 'VIRKSOMHET', '1', '2023-08-29 15:41:20.178518');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '840922156', 'VIRKSOMHET', '3', '2023-08-29 15:41:20.19973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '869270642', 'VIRKSOMHET', '9', '2023-08-29 15:41:20.19973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '846201495', 'VIRKSOMHET', '3', '2023-08-29 15:41:20.19973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '895595058', 'VIRKSOMHET', '9', '2023-08-29 15:41:20.218812');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '880255752', 'VIRKSOMHET', '1', '2023-08-29 15:41:20.218812');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '883516756', 'VIRKSOMHET', '1', '2023-08-29 15:41:20.218812');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '823825914', 'VIRKSOMHET', '9', '2023-08-29 15:41:21.314771');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '891494743', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.356499');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '866996950', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.392891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '878276775', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.392891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '835631853', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.418318');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '804345056', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.418318');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '863529173', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.438692');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '873351078', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.438692');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '881715947', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.465704');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '812300486', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.465704');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '819978335', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.465704');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '800406757', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.489047');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '893603727', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.489047');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '803556311', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.511539');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '881416980', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.511539');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '879409878', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.511539');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '864176730', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.511539');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '857464841', 'VIRKSOMHET', '1', '2023-08-29 15:41:21.532326');


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

