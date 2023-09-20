--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Debian 14.9-1.pgdg120+1)
-- Dumped by pg_dump version 14.9 (Homebrew)

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
DROP INDEX IF EXISTS public.idx_bransje_naringsundergrupper_per_bransje;
DROP INDEX IF EXISTS public.flyway_schema_history_s_idx;
ALTER TABLE IF EXISTS ONLY public.virksomhet DROP CONSTRAINT IF EXISTS virksomhet_unik_orgnr;
ALTER TABLE IF EXISTS ONLY public.virksomhet_statistikk_metadata DROP CONSTRAINT IF EXISTS virksomhet_statistikk_metadata_unik_orgnr;
ALTER TABLE IF EXISTS ONLY public.virksomhet DROP CONSTRAINT IF EXISTS virksomhet_pkey;
ALTER TABLE IF EXISTS ONLY public.virksomhet_naringsundergrupper DROP CONSTRAINT IF EXISTS virksomhet_naringsundergrupper_unik;
ALTER TABLE IF EXISTS ONLY public.virksomhet_naringsundergrupper DROP CONSTRAINT IF EXISTS virksomhet_naringsundergrupper_pkey;
ALTER TABLE IF EXISTS ONLY public.virksomhet_statistikk_metadata DROP CONSTRAINT IF EXISTS virksomhet_metadata_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet_siste_4_kvartal DROP CONSTRAINT IF EXISTS sykefravar_statistikk_virksomhet_siste_4_kvartal_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet DROP CONSTRAINT IF EXISTS sykefravar_statistikk_virksomhet_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet_siste_4_kvartal DROP CONSTRAINT IF EXISTS sykefravar_statistikk_virksom_orgnr_publisert_kvartal_publi_key;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_sektor DROP CONSTRAINT IF EXISTS sykefravar_statistikk_sektor_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naringsundergruppe DROP CONSTRAINT IF EXISTS sykefravar_statistikk_naringsundergruppe_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naring DROP CONSTRAINT IF EXISTS sykefravar_statistikk_naring_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_land DROP CONSTRAINT IF EXISTS sykefravar_statistikk_land_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_kategori_siste_4_kvartal DROP CONSTRAINT IF EXISTS sykefravar_statistikk_kategori_siste_4_kvartal_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_kategori_siste_4_kvartal DROP CONSTRAINT IF EXISTS sykefravar_statistikk_kategor_kategori_kode_publisert_kvart_key;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_bransje DROP CONSTRAINT IF EXISTS sykefravar_statistikk_bransje_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_virksomhet DROP CONSTRAINT IF EXISTS sykefravar_periode;
ALTER TABLE IF EXISTS ONLY public.siste_publiseringsinfo DROP CONSTRAINT IF EXISTS siste_publiseringsinfo_pkey;
ALTER TABLE IF EXISTS ONLY public.sektor DROP CONSTRAINT IF EXISTS sektor_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_sektor DROP CONSTRAINT IF EXISTS sektor_periode;
ALTER TABLE IF EXISTS ONLY public.naringsundergrupper_per_bransje DROP CONSTRAINT IF EXISTS naringsundergrupper_per_bransje_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naringsundergruppe DROP CONSTRAINT IF EXISTS naringsundergruppe_periode;
ALTER TABLE IF EXISTS ONLY public.naring DROP CONSTRAINT IF EXISTS naring_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_naring DROP CONSTRAINT IF EXISTS naring_periode;
ALTER TABLE IF EXISTS ONLY public.modul DROP CONSTRAINT IF EXISTS modul_pkey;
ALTER TABLE IF EXISTS ONLY public.sykefravar_statistikk_land DROP CONSTRAINT IF EXISTS land_periode;
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
DROP TABLE IF EXISTS public.naringsundergrupper_per_bransje;
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
    sist_endret_av_rolle character varying,
    opprettet_tidspunkt timestamp without time zone
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
-- Name: naringsundergrupper_per_bransje; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.naringsundergrupper_per_bransje (
    naringsundergruppe character varying NOT NULL,
    bransje character varying NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.naringsundergrupper_per_bransje OWNER TO test;

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
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    endret timestamp without time zone
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
    sist_endret timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    publisert_kvartal smallint NOT NULL,
    publisert_arstall smallint NOT NULL
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
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    endret timestamp without time zone
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
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    endret timestamp without time zone
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
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    endret timestamp without time zone
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
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    endret timestamp without time zone
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
    sist_endret timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    publisert_kvartal smallint NOT NULL,
    publisert_arstall smallint NOT NULL
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

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', 'V1__init.sql', 1782034767, 'test', '2023-09-20 13:19:54.905579', 10, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', 'V2__create_virksomhet_adresse.sql', -64248919, 'test', '2023-09-20 13:19:54.930693', 10, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', 'V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2023-09-20 13:19:54.951617', 3, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', 'V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2023-09-20 13:19:54.962743', 3, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', 'V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2023-09-20 13:19:54.974835', 4, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', 'V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2023-09-20 13:19:54.988135', 3, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', 'V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2023-09-20 13:19:54.999864', 5, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', 'V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2023-09-20 13:19:55.013283', 3, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', 'V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2023-09-20 13:19:55.024835', 7, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', 'V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2023-09-20 13:19:55.039633', 4, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', 'V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2023-09-20 13:19:55.053247', 3, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', 'V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2023-09-20 13:19:55.067489', 3, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', 'V13__ia_prosess.sql', -1755516749, 'test', '2023-09-20 13:19:55.079499', 4, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', 'V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2023-09-20 13:19:55.093479', 6, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', 'V15__endre_saknummer.sql', -1379621340, 'test', '2023-09-20 13:19:55.10769', 4, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', 'V16__ia_sak_hendelse.sql', 586872662, 'test', '2023-09-20 13:19:55.120673', 6, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', 'V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2023-09-20 13:19:55.138727', 3, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', 'V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2023-09-20 13:19:55.150885', 5, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', 'V19__legg_til_begrunnelser.sql', 779259005, 'test', '2023-09-20 13:19:55.163977', 5, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', 'V20__legg_til_flere_indekser.sql', -843857404, 'test', '2023-09-20 13:19:55.175967', 5, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', 'V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2023-09-20 13:19:55.191362', 3, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', 'V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2023-09-20 13:19:55.201256', 3, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', 'V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2023-09-20 13:19:55.212483', 5, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', 'V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2023-09-20 13:19:55.225967', 5, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', 'V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2023-09-20 13:19:55.239376', 10, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', 'V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2023-09-20 13:19:55.257904', 3, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', 'V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2023-09-20 13:19:55.268743', 3, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', 'V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2023-09-20 13:19:55.279649', 2, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', 'V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2023-09-20 13:19:55.289714', 3, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', 'V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2023-09-20 13:19:55.299765', 3, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', 'V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2023-09-20 13:19:55.310336', 4, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', 'V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2023-09-20 13:19:55.322061', 4, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', 'V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2023-09-20 13:19:55.332887', 3, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', 'V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2023-09-20 13:19:55.342402', 5, true);
INSERT INTO public.flyway_schema_history VALUES (35, '35', 'drop sykefravar statistikk grunnlag', 'SQL', 'V35__drop_sykefravar_statistikk_grunnlag.sql', 461103825, 'test', '2023-09-20 13:19:55.355146', 3, true);
INSERT INTO public.flyway_schema_history VALUES (36, '36', 'registrere bistand', 'SQL', 'V36__registrere_bistand.sql', -1365283904, 'test', '2023-09-20 13:19:55.365627', 8, true);
INSERT INTO public.flyway_schema_history VALUES (37, '37', 'fullfoert dato leveranse', 'SQL', 'V37__fullfoert_dato_leveranse.sql', 1621470787, 'test', '2023-09-20 13:19:55.381623', 3, true);
INSERT INTO public.flyway_schema_history VALUES (38, '38', 'oppdatere moduler', 'SQL', 'V38__oppdatere_moduler.sql', -246234034, 'test', '2023-09-20 13:19:55.391211', 3, true);
INSERT INTO public.flyway_schema_history VALUES (39, '39', 'rette iatjeneste på modul', 'SQL', 'V39__rette_iatjeneste_på_modul.sql', -1034067650, 'test', '2023-09-20 13:19:55.401718', 3, true);
INSERT INTO public.flyway_schema_history VALUES (40, '40', 'legg til rolle ia sak hendelse', 'SQL', 'V40__legg_til_rolle_ia_sak_hendelse.sql', -82283870, 'test', '2023-09-20 13:19:55.411813', 2, true);
INSERT INTO public.flyway_schema_history VALUES (41, '41', 'legg til rolle ia sak leveranse', 'SQL', 'V41__legg_til_rolle_ia_sak_leveranse.sql', -2029318456, 'test', '2023-09-20 13:19:55.420587', 2, true);
INSERT INTO public.flyway_schema_history VALUES (42, '42', 'legg til deaktivert', 'SQL', 'V42__legg_til_deaktivert.sql', 1170357332, 'test', '2023-09-20 13:19:55.429646', 4, true);
INSERT INTO public.flyway_schema_history VALUES (43, '43', 'siste publiseringsinfo tabell', 'SQL', 'V43__siste_publiseringsinfo_tabell.sql', -1555520829, 'test', '2023-09-20 13:19:55.441019', 4, true);
INSERT INTO public.flyway_schema_history VALUES (44, '44', 'hendelse nav enhet', 'SQL', 'V44__hendelse_nav_enhet.sql', -1118774222, 'test', '2023-09-20 13:19:55.451715', 3, true);
INSERT INTO public.flyway_schema_history VALUES (45, '45', 'oppdatere siste publiseringsinfo', 'SQL', 'V45__oppdatere_siste_publiseringsinfo.sql', -1919960111, 'test', '2023-09-20 13:19:55.461111', 3, true);
INSERT INTO public.flyway_schema_history VALUES (46, '46', 'populer siste publiseringsdato', 'SQL', 'V46__populer_siste_publiseringsdato.sql', 21300723, 'test', '2023-09-20 13:19:55.470624', 5, true);
INSERT INTO public.flyway_schema_history VALUES (47, '47', 'virksomhet naringsundergrupper tabell', 'SQL', 'V47__virksomhet_naringsundergrupper_tabell.sql', 581614507, 'test', '2023-09-20 13:19:55.482716', 4, true);
INSERT INTO public.flyway_schema_history VALUES (48, '48', 'endre oppdateringsdato', 'SQL', 'V48__endre_oppdateringsdato.sql', 855334580, 'test', '2023-09-20 13:19:55.494031', 3, true);
INSERT INTO public.flyway_schema_history VALUES (49, '49', 'sykefravar statistikk bransje tabell', 'SQL', 'V49__sykefravar_statistikk_bransje_tabell.sql', 1439525146, 'test', '2023-09-20 13:19:55.505093', 5, true);
INSERT INTO public.flyway_schema_history VALUES (50, '50', 'endre kode lengde siste 4 kvartal', 'SQL', 'V50__endre_kode_lengde_siste_4_kvartal.sql', 218855534, 'test', '2023-09-20 13:19:55.517382', 3, true);
INSERT INTO public.flyway_schema_history VALUES (51, '51', 'endre navn fra naeringskode til naringsundergruppe', 'SQL', 'V51__endre_navn_fra_naeringskode_til_naringsundergruppe.sql', 498551672, 'test', '2023-09-20 13:19:55.527293', 3, true);
INSERT INTO public.flyway_schema_history VALUES (52, '52', 'slett virksomhet naring tabell', 'SQL', 'V52__slett_virksomhet_naring_tabell.sql', 1210783708, 'test', '2023-09-20 13:19:55.538254', 3, true);
INSERT INTO public.flyway_schema_history VALUES (53, '53', 'oppdatere siste publiseringsinfo Q2 2023', 'SQL', 'V53__oppdatere_siste_publiseringsinfo_Q2_2023.sql', -100876903, 'test', '2023-09-20 13:19:55.54811', 3, true);
INSERT INTO public.flyway_schema_history VALUES (54, '54', 'naringsundergrupper per bransje tabell', 'SQL', 'V54__naringsundergrupper_per_bransje_tabell.sql', -885609844, 'test', '2023-09-20 13:19:55.557513', 32, true);
INSERT INTO public.flyway_schema_history VALUES (55, '55', 'legg til opprettet tidspunkt iasak leveranse', 'SQL', 'V55__legg_til_opprettet_tidspunkt_iasak_leveranse.sql', -1334142016, 'test', '2023-09-20 13:19:55.59821', 3, true);
INSERT INTO public.flyway_schema_history VALUES (56, '56', 'legg til endret statistikk tabeller', 'SQL', 'V56__legg_til_endret_statistikk_tabeller.sql', 1995700472, 'test', '2023-09-20 13:19:55.608211', 5, true);
INSERT INTO public.flyway_schema_history VALUES (57, '57', 'legg til publiseringskvartal', 'SQL', 'V57__legg_til_publiseringskvartal.sql', -1125206576, 'test', '2023-09-20 13:19:55.619197', 6, true);
INSERT INTO public.flyway_schema_history VALUES (58, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -2099773996, 'test', '2023-09-20 13:19:55.631588', 5, true);
INSERT INTO public.flyway_schema_history VALUES (59, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -1693737955, 'test', '2023-09-20 13:20:03.223417', 7, true);


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
INSERT INTO public.naring VALUES ('01', 'Jordbruk og tjenester tilknyttet jordbruk, jakt og viltstell', 'Jordbruk, tilhør. tjenester, jakt');
INSERT INTO public.naring VALUES ('01.1', 'Dyrking av ettårige vekster', 'Dyrking av ettårige vekster');
INSERT INTO public.naring VALUES ('01.2', 'Dyrking av flerårige vekster', 'Dyrking av flerårige vekster');
INSERT INTO public.naring VALUES ('01.3', 'Planteformering', 'Planteformering');
INSERT INTO public.naring VALUES ('01.4', 'Husdyrhold', 'Husdyrhold');
INSERT INTO public.naring VALUES ('01.5', 'Kombinert husdyrhold og planteproduksjon', 'Komb. husdyrhold og planteprod.');
INSERT INTO public.naring VALUES ('01.6', 'Tjenester tilknyttet jordbruk og etterbehandling av vekster etter innhøsting', 'Tjenester tilknyttet jordbruk');
INSERT INTO public.naring VALUES ('01.7', 'Jakt, viltstell og tjenester tilknyttet jakt og viltstell', 'Jakt, viltstell og tilkn. tjenester');
INSERT INTO public.naring VALUES ('01.11', 'Dyrking av korn (unntatt ris), belgvekster og oljeholdige vekster', 'Dyrking av korn, belgvekster mv.');
INSERT INTO public.naring VALUES ('01.12', 'Dyrking av ris', 'Dyrking av ris');
INSERT INTO public.naring VALUES ('01.13', 'Dyrking av grønnsaker, meloner, rot- og knollvekster', 'Dyrking av grønnsaker, poteter mv.');
INSERT INTO public.naring VALUES ('01.14', 'Dyrking av sukkerrør', 'Dyrking av sukkerrør');
INSERT INTO public.naring VALUES ('01.15', 'Dyrking av tobakk', 'Dyrking av tobakk');
INSERT INTO public.naring VALUES ('01.16', 'Dyrking av fibervekster', 'Dyrking av fibervekster');
INSERT INTO public.naring VALUES ('01.19', 'Dyrking av ettårige vekster ellers', 'Dyrking av ettårige vekster ellers');
INSERT INTO public.naring VALUES ('01.21', 'Dyrking av druer', 'Dyrking av druer');
INSERT INTO public.naring VALUES ('01.22', 'Dyrking av tropiske og subtropiske frukter', 'Dyrking av trop./subtrop. frukter');
INSERT INTO public.naring VALUES ('01.23', 'Dyrking av sitrusfrukter', 'Dyrking av sitrusfrukter');
INSERT INTO public.naring VALUES ('01.24', 'Dyrking av kjernefrukter og steinfrukter', 'Dyrking av kjerne- og steinfrukter');
INSERT INTO public.naring VALUES ('01.25', 'Dyrking av annen frukt som vokser på trær eller busker samt nøtter', 'Dyrking av bær og nøtter mv.');
INSERT INTO public.naring VALUES ('01.26', 'Dyrking av oljeholdige frukter', 'Dyrking av oljeholdige frukter');
INSERT INTO public.naring VALUES ('01.27', 'Dyrking av vekster for produksjon av drikkevarer', 'Dyrk. vekster for prod. av drikkev.');
INSERT INTO public.naring VALUES ('01.28', 'Dyrking av krydder og aromatiske, medisinske og farmasøytiske vekster', 'Dyrking av krydder mv.');
INSERT INTO public.naring VALUES ('01.29', 'Dyrking av flerårige vekster ellers', 'Dyrking av flerårige vekster ellers');
INSERT INTO public.naring VALUES ('01.30', 'Planteformering', 'Planteformering');
INSERT INTO public.naring VALUES ('01.41', 'Melkeproduksjon på storfe', 'Melkeproduksjon på storfe');
INSERT INTO public.naring VALUES ('01.42', 'Oppdrett av annet storfe', 'Oppdrett av annet storfe');
INSERT INTO public.naring VALUES ('01.43', 'Oppdrett av hester og andre dyr av hestefamilien', 'Oppdrett av hester, esler o.l.');
INSERT INTO public.naring VALUES ('01.44', 'Oppdrett av kameler og andre kameldyr', 'Oppdrett av kameler og kameldyr el.');
INSERT INTO public.naring VALUES ('01.45', 'Saue- og geitehold', 'Saue- og geitehold');
INSERT INTO public.naring VALUES ('01.46', 'Svinehold', 'Svinehold');
INSERT INTO public.naring VALUES ('01.47', 'Fjørfehold', 'Fjørfehold');
INSERT INTO public.naring VALUES ('01.49', 'Husdyrhold ellers', 'Husdyrhold ellers');
INSERT INTO public.naring VALUES ('01.50', 'Kombinert husdyrhold og planteproduksjon', 'Komb. husdyrhold og planteprod.');
INSERT INTO public.naring VALUES ('01.61', 'Tjenester tilknyttet planteproduksjon', 'Tjenester tilknyttet planteprod.');
INSERT INTO public.naring VALUES ('01.62', 'Tjenester tilknyttet husdyrhold', 'Tjenester tilknyttet husdyrhold');
INSERT INTO public.naring VALUES ('01.63', 'Etterbehandling av vekster etter innhøsting', 'Etterbeh. av vekster etter innhøst.');
INSERT INTO public.naring VALUES ('01.64', 'Behandling av såfrø', 'Behandling av såfrø');
INSERT INTO public.naring VALUES ('01.70', 'Jakt, viltstell og tjenester tilknyttet jakt og viltstell', 'Jakt, viltstell og tilkn. tjenester');
INSERT INTO public.naring VALUES ('01.110', 'Dyrking av korn (unntatt ris), belgvekster og oljeholdige vekster', 'Dyrking av korn, belgvekster mv.');
INSERT INTO public.naring VALUES ('01.120', 'Dyrking av ris', 'Dyrking av ris');
INSERT INTO public.naring VALUES ('01.130', 'Dyrking av grønnsaker, meloner, rot- og knollvekster', 'Dyrking av grønnsaker, poteter mv.');
INSERT INTO public.naring VALUES ('01.140', 'Dyrking av sukkerrør', 'Dyrking av sukkerrør');
INSERT INTO public.naring VALUES ('01.150', 'Dyrking av tobakk', 'Dyrking av tobakk');
INSERT INTO public.naring VALUES ('01.160', 'Dyrking av fibervekster', 'Dyrking av fibervekster');
INSERT INTO public.naring VALUES ('01.190', 'Dyrking av ettårige vekster ellers', 'Dyrking av ettårige vekster ellers');
INSERT INTO public.naring VALUES ('01.210', 'Dyrking av druer', 'Dyrking av druer');
INSERT INTO public.naring VALUES ('01.220', 'Dyrking av tropiske og subtropiske frukter', 'Dyrking av trop./subtrop. frukter');
INSERT INTO public.naring VALUES ('01.230', 'Dyrking av sitrusfrukter', 'Dyrking av sitrusfrukter');
INSERT INTO public.naring VALUES ('01.240', 'Dyrking av kjernefrukter og steinfrukter', 'Dyrking av kjerne- og steinfrukter');
INSERT INTO public.naring VALUES ('01.250', 'Dyrking av annen frukt som vokser på trær eller busker samt nøtter', 'Dyrking av bær og nøtter mv.');
INSERT INTO public.naring VALUES ('01.260', 'Dyrking av oljeholdige frukter', 'Dyrking av oljeholdige frukter');
INSERT INTO public.naring VALUES ('01.270', 'Dyrking av vekster for produksjon av drikkevarer', 'Dyrk. vekster for prod. av drikkev.');
INSERT INTO public.naring VALUES ('01.280', 'Dyrking av krydder og aromatiske, medisinske og farmasøytiske vekster', 'Dyrking av krydder mv.');
INSERT INTO public.naring VALUES ('01.290', 'Dyrking av flerårige vekster ellers', 'Dyrking av flerårige vekster ellers');
INSERT INTO public.naring VALUES ('01.300', 'Planteformering', 'Planteformering');
INSERT INTO public.naring VALUES ('01.410', 'Melkeproduksjon på storfe', 'Melkeproduksjon på storfe');
INSERT INTO public.naring VALUES ('01.420', 'Oppdrett av annet storfe', 'Oppdrett av annet storfe');
INSERT INTO public.naring VALUES ('01.430', 'Oppdrett av hester og andre dyr av hestefamilien', 'Oppdrett av hester, esler o.l.');
INSERT INTO public.naring VALUES ('01.440', 'Oppdrett av kameler og andre kameldyr', 'Oppdrett av kameler og kameldyr el.');
INSERT INTO public.naring VALUES ('01.451', 'Sauehold', 'Sauehold');
INSERT INTO public.naring VALUES ('01.452', 'Geitehold', 'Geitehold');
INSERT INTO public.naring VALUES ('01.460', 'Svinehold', 'Svinehold');
INSERT INTO public.naring VALUES ('01.471', 'Hold av verpehøner for konsumeggproduksjon', 'Verpehøner for konsumeggprod.');
INSERT INTO public.naring VALUES ('01.479', 'Annet fjørfehold', 'Annet fjørfehold');
INSERT INTO public.naring VALUES ('01.490', 'Husdyrhold ellers', 'Husdyrhold ellers');
INSERT INTO public.naring VALUES ('01.500', 'Kombinert husdyrhold og planteproduksjon', 'Komb. husdyrhold og planteprod.');
INSERT INTO public.naring VALUES ('01.610', 'Tjenester tilknyttet planteproduksjon', 'Tjenester tilknyttet planteprod.');
INSERT INTO public.naring VALUES ('01.620', 'Tjenester tilknyttet husdyrhold', 'Tjenester tilknyttet husdyrhold');
INSERT INTO public.naring VALUES ('01.630', 'Etterbehandling av vekster etter innhøsting', 'Etterbeh. av vekster etter innhøst.');
INSERT INTO public.naring VALUES ('01.640', 'Behandling av såfrø', 'Behandling av såfrø');
INSERT INTO public.naring VALUES ('01.700', 'Jakt, viltstell og tjenester tilknyttet jakt og viltstell', 'Jakt, viltstell og tilkn. tjenester');
INSERT INTO public.naring VALUES ('02', 'Skogbruk og tjenester tilknyttet skogbruk', 'Skogbruk og tilhørende tjenester');
INSERT INTO public.naring VALUES ('02.1', 'Skogskjøtsel og andre skogbruksaktiviteter', 'Skogskjøtsel, andre skogbruksakt.');
INSERT INTO public.naring VALUES ('02.2', 'Avvirkning', 'Avvirkning');
INSERT INTO public.naring VALUES ('02.3', 'Innsamling av viltvoksende produkter av annet enn tre', 'Innsaml. av sopp, bær, mose etc.');
INSERT INTO public.naring VALUES ('02.4', 'Tjenester tilknyttet skogbruk', 'Tjenester tilknyttet skogbruk');
INSERT INTO public.naring VALUES ('02.10', 'Skogskjøtsel og andre skogbruksaktiviteter', 'Skogskjøtsel, andre skogbruksakt.');
INSERT INTO public.naring VALUES ('02.20', 'Avvirkning', 'Avvirkning');
INSERT INTO public.naring VALUES ('02.30', 'Innsamling av viltvoksende produkter av annet enn tre', 'Innsaml. av sopp, bær, mose etc.');
INSERT INTO public.naring VALUES ('02.40', 'Tjenester tilknyttet skogbruk', 'Tjenester tilknyttet skogbruk');
INSERT INTO public.naring VALUES ('02.100', 'Skogskjøtsel og andre skogbruksaktiviteter', 'Skogskjøtsel, andre skogbruksakt.');
INSERT INTO public.naring VALUES ('02.200', 'Avvirkning', 'Avvirkning');
INSERT INTO public.naring VALUES ('02.300', 'Innsamling av viltvoksende produkter av annet enn tre', 'Innsaml. av sopp, bær, mose etc.');
INSERT INTO public.naring VALUES ('02.400', 'Tjenester tilknyttet skogbruk', 'Tjenester tilknyttet skogbruk');
INSERT INTO public.naring VALUES ('03', 'Fiske, fangst og akvakultur', 'Fiske, fangst og akvakultur');
INSERT INTO public.naring VALUES ('03.1', 'Fiske og fangst', 'Fiske og fangst');
INSERT INTO public.naring VALUES ('03.2', 'Akvakultur', 'Akvakultur');
INSERT INTO public.naring VALUES ('03.11', 'Hav- og kystfiske og fangst', 'Hav- og kystfiske og fangst');
INSERT INTO public.naring VALUES ('03.12', 'Ferskvannsfiske', 'Ferskvannsfiske');
INSERT INTO public.naring VALUES ('03.21', 'Hav- og kystbasert akvakultur', 'Hav- og kystbasert akvakultur');
INSERT INTO public.naring VALUES ('03.22', 'Ferskvannsbasert akvakultur', 'Ferskvannsbasert akvakultur');
INSERT INTO public.naring VALUES ('03.111', 'Hav- og kystfiske', 'Hav- og kystfiske');
INSERT INTO public.naring VALUES ('03.112', 'Hvalfangst', 'Hvalfangst');
INSERT INTO public.naring VALUES ('03.120', 'Ferskvannsfiske', 'Ferskvannsfiske');
INSERT INTO public.naring VALUES ('03.211', 'Produksjon av matfisk, bløtdyr, krepsdyr og pigghuder i hav- og kystbasert akvakultur', 'Matfisk/krepsdyr mv. hav-/kystbas.');
INSERT INTO public.naring VALUES ('03.212', 'Produksjon av yngel og settefisk i hav- og kystbasert akvakultur', 'Yngel, settefisk hav-/kystbas.');
INSERT INTO public.naring VALUES ('03.213', 'Tjenester tilknyttet hav- og kystbasert akvakultur', 'Tjen. tilkn. hav-/kystbas. akvakult.');
INSERT INTO public.naring VALUES ('03.221', 'Produksjon av matfisk, bløtdyr og krepsdyr i ferskvannsbasert akvakultur', 'Matfisk/krepsdyr mv. ferskvannsbas.');
INSERT INTO public.naring VALUES ('03.222', 'Produksjon av yngel og settefisk i ferskvannsbasert akvakultur', 'Yngel, settefisk ferskvannsbasert');
INSERT INTO public.naring VALUES ('03.223', 'Tjenester tilknyttet ferskvannsbasert akvakultur', 'Tjen. tilkn. ferskvannsbas. akvakult');
INSERT INTO public.naring VALUES ('05', 'Bryting av steinkull og brunkull', 'Bryting av steinkull og brunkull');
INSERT INTO public.naring VALUES ('05.1', 'Bryting av steinkull', 'Bryting av steinkull');
INSERT INTO public.naring VALUES ('05.2', 'Bryting av brunkull', 'Bryting av brunkull');
INSERT INTO public.naring VALUES ('05.10', 'Bryting av steinkull', 'Bryting av steinkull');
INSERT INTO public.naring VALUES ('05.20', 'Bryting av brunkull', 'Bryting av brunkull');
INSERT INTO public.naring VALUES ('05.100', 'Bryting av steinkull', 'Bryting av steinkull');
INSERT INTO public.naring VALUES ('05.200', 'Bryting av brunkull', 'Bryting av brunkull');
INSERT INTO public.naring VALUES ('06', 'Utvinning av råolje og naturgass', 'Utvinning av råolje og naturgass');
INSERT INTO public.naring VALUES ('06.1', 'Utvinning av råolje', 'Utvinning av råolje');
INSERT INTO public.naring VALUES ('06.2', 'Utvinning av naturgass', 'Utvinning av naturgass');
INSERT INTO public.naring VALUES ('06.10', 'Utvinning av råolje', 'Utvinning av råolje');
INSERT INTO public.naring VALUES ('06.20', 'Utvinning av naturgass', 'Utvinning av naturgass');
INSERT INTO public.naring VALUES ('06.100', 'Utvinning av råolje', 'Utvinning av råolje');
INSERT INTO public.naring VALUES ('06.200', 'Utvinning av naturgass', 'Utvinning av naturgass');
INSERT INTO public.naring VALUES ('07', 'Bryting av metallholdig malm', 'Bryting av metallholdig malm');
INSERT INTO public.naring VALUES ('07.1', 'Bryting av jernmalm', 'Bryting av jernmalm');
INSERT INTO public.naring VALUES ('07.2', 'Bryting av ikke-jernholdig malm', 'Bryting av ikke-jernholdig malm');
INSERT INTO public.naring VALUES ('07.10', 'Bryting av jernmalm', 'Bryting av jernmalm');
INSERT INTO public.naring VALUES ('07.21', 'Bryting av uran- og thoriummalm', 'Bryting av uran- og thoriummalm');
INSERT INTO public.naring VALUES ('07.29', 'Bryting av ikke-jernholdig malm ellers', 'Bryting av annen ikke-jernh. malm');
INSERT INTO public.naring VALUES ('07.100', 'Bryting av jernmalm', 'Bryting av jernmalm');
INSERT INTO public.naring VALUES ('07.210', 'Bryting av uran- og thoriummalm', 'Bryting av uran- og thoriummalm');
INSERT INTO public.naring VALUES ('07.290', 'Bryting av ikke-jernholdig malm ellers', 'Bryting av annen ikke-jernh. malm');
INSERT INTO public.naring VALUES ('08', 'Bryting og bergverksdrift ellers', 'Bryting og bergverksdrift ellers');
INSERT INTO public.naring VALUES ('08.1', 'Bryting av stein, utvinning av sand og leire', 'Bryt. av stein, utv. av sand, leire');
INSERT INTO public.naring VALUES ('08.9', 'Annen bryting og utvinning', 'Annen bryting og utvinning');
INSERT INTO public.naring VALUES ('08.11', 'Bryting av stein til bygge- og anleggsvirksomhet, kalkstein, gips, kritt og skifer', 'Bryt. bygn.-/kalkstein/skifer mv.');
INSERT INTO public.naring VALUES ('08.12', 'Utvinning fra grus- og sandtak, og utvinning av leire og kaolin', 'Utv. fra grus- og sandtak, leire mv.');
INSERT INTO public.naring VALUES ('08.91', 'Bryting og utvinning av kjemiske mineraler og gjødselsmineraler', 'Utv. kjem. mineraler/gjødselsmin.');
INSERT INTO public.naring VALUES ('08.92', 'Stikking av torv', 'Stikking av torv');
INSERT INTO public.naring VALUES ('08.93', 'Utvinning av salt', 'Utvinning av salt');
INSERT INTO public.naring VALUES ('08.99', 'Annen bryting og utvinning ikke nevnt annet sted', 'Annen bryting og utvinning');
INSERT INTO public.naring VALUES ('08.111', 'Bryting av stein til bygge- og anleggsvirksomhet', 'Bryting stein til bygge- og anl.virks');
INSERT INTO public.naring VALUES ('08.112', 'Bryting av kalkstein, gips og kritt', 'Bryting av kalkstein, gips og kritt');
INSERT INTO public.naring VALUES ('08.113', 'Bryting av skifer', 'Bryting av skifer');
INSERT INTO public.naring VALUES ('08.120', 'Utvinning fra grus- og sandtak, og utvinning av leire og kaolin', 'Utv. fra grus- og sandtak, leire mv.');
INSERT INTO public.naring VALUES ('08.910', 'Bryting og utvinning av kjemiske mineraler og gjødselsmineraler', 'Utv. kjem. mineraler/gjødselsmin.');
INSERT INTO public.naring VALUES ('08.920', 'Stikking av torv', 'Stikking av torv');
INSERT INTO public.naring VALUES ('08.930', 'Utvinning av salt', 'Utvinning av salt');
INSERT INTO public.naring VALUES ('08.990', 'Annen bryting og utvinning ikke nevnt annet sted', 'Annen bryting og utvinning');
INSERT INTO public.naring VALUES ('09', 'Tjenester tilknyttet bergverksdrift og utvinning', 'Tjenester til bergverk og utvinning');
INSERT INTO public.naring VALUES ('09.1', 'Tjenester tilknyttet utvinning av råolje og naturgass', 'Utvinningstjenester');
INSERT INTO public.naring VALUES ('09.9', 'Tjenester tilknyttet annen bergverksdrift', 'Bergverkstjenester');
INSERT INTO public.naring VALUES ('09.10', 'Tjenester tilknyttet utvinning av råolje og naturgass', 'Utvinningstjenester');
INSERT INTO public.naring VALUES ('09.90', 'Tjenester tilknyttet annen bergverksdrift', 'Bergverkstjenester');
INSERT INTO public.naring VALUES ('09.101', 'Boretjenester tilknyttet utvinning av råolje og naturgass', 'Boretj. tilkn. utv. råolje/naturgass');
INSERT INTO public.naring VALUES ('09.109', 'Andre tjenester tilknyttet utvinning av råolje og naturgass', 'Tjen. til utv. råolje/naturgass el.');
INSERT INTO public.naring VALUES ('09.900', 'Tjenester tilknyttet annen bergverksdrift', 'Bergverkstjenester');
INSERT INTO public.naring VALUES ('10', 'Produksjon av nærings- og nytelsesmidler', 'Næringsmiddelindustri');
INSERT INTO public.naring VALUES ('10.1', 'Produksjon, bearbeiding og konservering av kjøtt og kjøttvarer', 'Bearbeiding kjøtt og kjøttvarer');
INSERT INTO public.naring VALUES ('10.2', 'Bearbeiding og konservering av fisk, skalldyr og bløtdyr', 'Bearbeiding fisk, skalldyr, bløtdyr');
INSERT INTO public.naring VALUES ('10.3', 'Bearbeiding og konservering av frukt og grønnsaker', 'Bearbeiding frukt og grønnsaker');
INSERT INTO public.naring VALUES ('10.4', 'Produksjon av vegetabilske og animalske oljer og fettstoffer', 'Produksjon oljer og fettstoff');
INSERT INTO public.naring VALUES ('10.5', 'Produksjon av meierivarer og iskrem', 'Produksjon av meierivarer og iskrem');
INSERT INTO public.naring VALUES ('10.6', 'Produksjon av kornvarer, stivelse og stivelsesprodukter', 'Produksjon kornvarer, stivelse mv.');
INSERT INTO public.naring VALUES ('10.7', 'Produksjon av bakeri- og pastavarer', 'Produksjon av bakeri- og pastavarer');
INSERT INTO public.naring VALUES ('10.8', 'Produksjon av andre næringsmidler', 'Produksjon av andre næringsmidler');
INSERT INTO public.naring VALUES ('10.9', 'Produksjon av fôrvarer', 'Produksjon av fôrvarer');
INSERT INTO public.naring VALUES ('10.11', 'Bearbeiding og konservering av kjøtt', 'Kjøttbearbeiding og konservering');
INSERT INTO public.naring VALUES ('10.12', 'Bearbeiding og konservering av fjørfekjøtt', 'Fjørfekjøttbearb. og konservering');
INSERT INTO public.naring VALUES ('10.13', 'Produksjon av kjøtt- og fjørfevarer', 'Kjøtt- og fjørfevareproduksjon');
INSERT INTO public.naring VALUES ('10.20', 'Bearbeiding og konservering av fisk, skalldyr og bløtdyr', 'Bearbeiding fisk, skalldyr, bløtdyr');
INSERT INTO public.naring VALUES ('10.31', 'Bearbeiding og konservering av poteter', 'Potetbearbeiding');
INSERT INTO public.naring VALUES ('10.32', 'Produksjon av juice av frukt og grønnsaker', 'Frukt- og grønnsakjuiceproduksjon');
INSERT INTO public.naring VALUES ('10.39', 'Bearbeiding og konservering av frukt og grønnsaker ellers', 'Frukt- og grønnsakbearbeiding el.');
INSERT INTO public.naring VALUES ('10.41', 'Produksjon av oljer og fettstoffer', 'Prod. av oljer og fettstoffer');
INSERT INTO public.naring VALUES ('10.42', 'Produksjon av margarin og lignende spiselige fettstoffer', 'Margarinproduksjon m.m.');
INSERT INTO public.naring VALUES ('10.51', 'Produksjon av meierivarer', 'Meierivareproduksjon');
INSERT INTO public.naring VALUES ('10.52', 'Produksjon av iskrem', 'Iskremproduksjon');
INSERT INTO public.naring VALUES ('10.61', 'Produksjon av kornvarer', 'Kornvareproduksjon');
INSERT INTO public.naring VALUES ('10.62', 'Produksjon av stivelse og stivelsesprodukter', 'Prod. av stivelse og stivelseprod.');
INSERT INTO public.naring VALUES ('10.71', 'Produksjon av brød og ferske konditorvarer', 'Brød og ferske konditorvarer');
INSERT INTO public.naring VALUES ('10.72', 'Produksjon av kavringer, kjeks og konserverte konditorvarer', 'Kavring- og kjeksprod. mv.');
INSERT INTO public.naring VALUES ('10.73', 'Produksjon av makaroni, nudler, couscous og lignende pastavarer', 'Pastavareproduksjon');
INSERT INTO public.naring VALUES ('10.81', 'Produksjon av sukker', 'Sukkerproduksjon');
INSERT INTO public.naring VALUES ('10.82', 'Produksjon av kakao, sjokolade og sukkervarer', 'Kakao-, sjokolade- og sukkervareprod.');
INSERT INTO public.naring VALUES ('10.83', 'Bearbeiding av te og kaffe', 'Te- og kaffebearbeiding');
INSERT INTO public.naring VALUES ('10.84', 'Produksjon av smakstilsettingsstoffer og krydderier', 'Smakstilsettingsstoffer og krydder');
INSERT INTO public.naring VALUES ('10.85', 'Produksjon av ferdigmat', 'Ferdigmatproduksjon');
INSERT INTO public.naring VALUES ('10.86', 'Produksjon av homogeniserte matprodukter og diettmat', 'Diettmat og homogeniserte matprod.');
INSERT INTO public.naring VALUES ('10.89', 'Produksjon av næringsmidler ikke nevnt annet sted', 'Produksjon av næringsmidler el.');
INSERT INTO public.naring VALUES ('10.91', 'Produksjon av fôrvarer til husdyrhold', 'Fôrvareproduksjon til husdyr');
INSERT INTO public.naring VALUES ('10.92', 'Produksjon av fôrvarer til kjæledyr', 'Fôrvareproduksjon til kjæledyr');
INSERT INTO public.naring VALUES ('10.110', 'Bearbeiding og konservering av kjøtt', 'Kjøttbearbeiding og konservering');
INSERT INTO public.naring VALUES ('10.120', 'Bearbeiding og konservering av fjørfekjøtt', 'Fjørfekjøttbearb. og konservering');
INSERT INTO public.naring VALUES ('10.130', 'Produksjon av kjøtt- og fjørfevarer', 'Kjøtt- og fjørfevareproduksjon');
INSERT INTO public.naring VALUES ('10.201', 'Produksjon av saltfisk, tørrfisk og klippfisk', 'Salt-, tørr- og klippfiskproduksjon');
INSERT INTO public.naring VALUES ('10.202', 'Frysing av fisk, fiskefileter, skalldyr og bløtdyr', 'Frysing av fisk, fiskefileter mv.');
INSERT INTO public.naring VALUES ('10.203', 'Produksjon av fiskehermetikk', 'Fiskehermetikkproduksjon');
INSERT INTO public.naring VALUES ('10.209', 'Slakting, bearbeiding og konservering av fisk og fiskevarer ellers', 'Bearb. og konserv. av fisk/fiskev.');
INSERT INTO public.naring VALUES ('10.310', 'Bearbeiding og konservering av poteter', 'Potetbearbeiding');
INSERT INTO public.naring VALUES ('10.320', 'Produksjon av juice av frukt og grønnsaker', 'Frukt- og grønnsakjuiceproduksjon');
INSERT INTO public.naring VALUES ('10.390', 'Bearbeiding og konservering av frukt og grønnsaker ellers', 'Frukt- og grønnsakbearbeiding el.');
INSERT INTO public.naring VALUES ('10.411', 'Produksjon av rå fiskeoljer og fett', 'Prod. av rå fiskeoljer og fett');
INSERT INTO public.naring VALUES ('10.412', 'Produksjon av andre uraffinerte oljer og fett', 'Prod. av andre uraff. oljer og fett');
INSERT INTO public.naring VALUES ('10.413', 'Produksjon av raffinerte oljer og fett', 'Raffinert olje- og fettproduksjon');
INSERT INTO public.naring VALUES ('10.420', 'Produksjon av margarin og lignende spiselige fettstoffer', 'Margarinproduksjon m.m.');
INSERT INTO public.naring VALUES ('10.510', 'Produksjon av meierivarer', 'Meierivareproduksjon');
INSERT INTO public.naring VALUES ('10.520', 'Produksjon av iskrem', 'Iskremproduksjon');
INSERT INTO public.naring VALUES ('10.610', 'Produksjon av kornvarer', 'Kornvareproduksjon');
INSERT INTO public.naring VALUES ('10.620', 'Produksjon av stivelse og stivelsesprodukter', 'Prod. av stivelse og stivelseprod.');
INSERT INTO public.naring VALUES ('10.710', 'Produksjon av brød og ferske konditorvarer', 'Brød og ferske konditorvarer');
INSERT INTO public.naring VALUES ('10.720', 'Produksjon av kavringer, kjeks og konserverte konditorvarer', 'Kavring- og kjeksprod. mv.');
INSERT INTO public.naring VALUES ('10.730', 'Produksjon av makaroni, nudler, couscous og lignende pastavarer', 'Pastavareproduksjon');
INSERT INTO public.naring VALUES ('10.810', 'Produksjon av sukker', 'Sukkerproduksjon');
INSERT INTO public.naring VALUES ('10.820', 'Produksjon av kakao, sjokolade og sukkervarer', 'Kakao-, sjokolade- og sukkervareprod.');
INSERT INTO public.naring VALUES ('10.830', 'Bearbeiding av te og kaffe', 'Te- og kaffebearbeiding');
INSERT INTO public.naring VALUES ('10.840', 'Produksjon av smakstilsettingsstoffer og krydderier', 'Smakstilsettingsstoffer og krydder');
INSERT INTO public.naring VALUES ('10.850', 'Produksjon av ferdigmat', 'Ferdigmatproduksjon');
INSERT INTO public.naring VALUES ('10.860', 'Produksjon av homogeniserte matprodukter og diettmat', 'Diettmat og homogeniserte matprod.');
INSERT INTO public.naring VALUES ('10.890', 'Produksjon av næringsmidler ikke nevnt annet sted', 'Produksjon av næringsmidler el.');
INSERT INTO public.naring VALUES ('10.910', 'Produksjon av fôrvarer til husdyrhold', 'Fôrvareproduksjon til husdyr');
INSERT INTO public.naring VALUES ('10.920', 'Produksjon av fôrvarer til kjæledyr', 'Fôrvareproduksjon til kjæledyr');
INSERT INTO public.naring VALUES ('11', 'Produksjon av drikkevarer', 'Drikkevareindustri');
INSERT INTO public.naring VALUES ('11.0', 'Produksjon av drikkevarer', 'Produksjon av drikkevarer');
INSERT INTO public.naring VALUES ('11.01', 'Destillering, rektifisering og blanding av sprit', 'Destill. alkoholholdige drikkevarer');
INSERT INTO public.naring VALUES ('11.02', 'Produksjon av vin', 'Vinproduksjon');
INSERT INTO public.naring VALUES ('11.03', 'Produksjon av sider og annen fruktvin', 'Sider- og annen fruktvinproduksjon');
INSERT INTO public.naring VALUES ('11.04', 'Produksjon av andre ikke-destillerte gjærede drikkevarer', 'Ikke-destill. gjærede drikkevarer');
INSERT INTO public.naring VALUES ('11.05', 'Produksjon av øl', 'Ølproduksjon');
INSERT INTO public.naring VALUES ('11.06', 'Produksjon av malt', 'Maltproduksjon');
INSERT INTO public.naring VALUES ('11.07', 'Produksjon av mineralvann, leskedrikker og annet vann på flaske', 'Mineralvann- og leskedrikkproduksjon');
INSERT INTO public.naring VALUES ('11.010', 'Destillering, rektifisering og blanding av sprit', 'Destill. alkoholholdige drikkevarer');
INSERT INTO public.naring VALUES ('11.020', 'Produksjon av vin', 'Vinproduksjon');
INSERT INTO public.naring VALUES ('11.030', 'Produksjon av sider og annen fruktvin', 'Sider- og annen fruktvinproduksjon');
INSERT INTO public.naring VALUES ('11.040', 'Produksjon av andre ikke-destillerte gjærede drikkevarer', 'Ikke-destill. gjærede drikkevarer');
INSERT INTO public.naring VALUES ('11.050', 'Produksjon av øl', 'Ølproduksjon');
INSERT INTO public.naring VALUES ('11.060', 'Produksjon av malt', 'Maltproduksjon');
INSERT INTO public.naring VALUES ('11.070', 'Produksjon av mineralvann, leskedrikker og annet vann på flaske', 'Mineralvann- og leskedrikkproduksjon');
INSERT INTO public.naring VALUES ('12', 'Produksjon av tobakksvarer', 'Tobakksindustri');
INSERT INTO public.naring VALUES ('12.0', 'Produksjon av tobakksvarer', 'Tobakksindustri');
INSERT INTO public.naring VALUES ('12.00', 'Produksjon av tobakksvarer', 'Tobakksindustri');
INSERT INTO public.naring VALUES ('12.000', 'Produksjon av tobakksvarer', 'Tobakksindustri');
INSERT INTO public.naring VALUES ('13', 'Produksjon av tekstiler', 'Tekstilindustri');
INSERT INTO public.naring VALUES ('13.1', 'Bearbeiding og spinning av tekstilfibrer', 'Bearb./spinning av tekstilfibrer');
INSERT INTO public.naring VALUES ('13.2', 'Veving av tekstiler', 'Veving av tekstiler');
INSERT INTO public.naring VALUES ('13.3', 'Etterbehandling av tekstiler', 'Etterbehandling av tekstiler');
INSERT INTO public.naring VALUES ('13.9', 'Produksjon av andre tekstiler', 'Produksjon av andre tekstiler');
INSERT INTO public.naring VALUES ('13.10', 'Bearbeiding og spinning av tekstilfibrer', 'Bearb./spinning av tekstilfibrer');
INSERT INTO public.naring VALUES ('13.20', 'Veving av tekstiler', 'Veving av tekstiler');
INSERT INTO public.naring VALUES ('13.30', 'Etterbehandling av tekstiler', 'Etterbehandling av tekstiler');
INSERT INTO public.naring VALUES ('13.91', 'Produksjon av stoffer av trikotasje', 'Trikotasjestoffproduksjon');
INSERT INTO public.naring VALUES ('13.92', 'Produksjon av tekstilvarer, unntatt klær', 'Tekstilvareproduksjon, unntatt klær');
INSERT INTO public.naring VALUES ('13.93', 'Produksjon av gulvtepper, -matter og -ryer', 'Gulvteppe-, matte- og ryeproduksjon');
INSERT INTO public.naring VALUES ('13.94', 'Produksjon av tauverk og nett', 'Tauverk- og nettproduksjon');
INSERT INTO public.naring VALUES ('13.95', 'Produksjon av ikke-vevde tekstiler og tekstilvarer, unntatt klær', 'Fiberproduksjon mv.');
INSERT INTO public.naring VALUES ('13.96', 'Produksjon av tekstiler til teknisk og industriell bruk', 'Tekstiler til tekn./industriell bruk');
INSERT INTO public.naring VALUES ('13.99', 'Produksjon av tekstiler ikke nevnt annet sted', 'Tekstilproduksjon el.');
INSERT INTO public.naring VALUES ('13.100', 'Bearbeiding og spinning av tekstilfibrer', 'Bearb./spinning av tekstilfibrer');
INSERT INTO public.naring VALUES ('13.200', 'Veving av tekstiler', 'Veving av tekstiler');
INSERT INTO public.naring VALUES ('13.300', 'Etterbehandling av tekstiler', 'Etterbehandling av tekstiler');
INSERT INTO public.naring VALUES ('13.910', 'Produksjon av stoffer av trikotasje', 'Trikotasjestoffproduksjon');
INSERT INTO public.naring VALUES ('13.921', 'Produksjon av utstyrsvarer', 'Utstyrsvareproduksjon');
INSERT INTO public.naring VALUES ('13.929', 'Produksjon av andre tekstilvarer, unntatt klær', 'Annen tekstilvareprod., unnt. klær');
INSERT INTO public.naring VALUES ('13.930', 'Produksjon av gulvtepper, -matter og -ryer', 'Gulvteppe-, matte- og ryeproduksjon');
INSERT INTO public.naring VALUES ('13.940', 'Produksjon av tauverk og nett', 'Tauverk- og nettproduksjon');
INSERT INTO public.naring VALUES ('13.950', 'Produksjon av ikke-vevde tekstiler og tekstilvarer, unntatt klær', 'Fiberproduksjon mv.');
INSERT INTO public.naring VALUES ('13.960', 'Produksjon av tekstiler til teknisk og industriell bruk', 'Tekstiler til tekn./industriell bruk');
INSERT INTO public.naring VALUES ('13.990', 'Produksjon av tekstiler ikke nevnt annet sted', 'Tekstilproduksjon el.');
INSERT INTO public.naring VALUES ('14', 'Produksjon av klær', 'Bekledningsindustri');
INSERT INTO public.naring VALUES ('14.1', 'Produksjon av klær, unntatt pelsvarer', 'Produksjon av klær, unnt. pelsvarer');
INSERT INTO public.naring VALUES ('14.2', 'Produksjon av pelsvarer', 'Produksjon av pelsvarer');
INSERT INTO public.naring VALUES ('14.3', 'Produksjon av klær av trikotasje', 'Prod. av klær av trikotasje');
INSERT INTO public.naring VALUES ('14.11', 'Produksjon av klær av lær', 'Produksjon av klær av lær');
INSERT INTO public.naring VALUES ('14.12', 'Produksjon av arbeidstøy', 'Arbeidstøyproduksjon');
INSERT INTO public.naring VALUES ('14.13', 'Produksjon av annet yttertøy', 'Annen yttertøyproduksjon');
INSERT INTO public.naring VALUES ('14.14', 'Produksjon av undertøy og innertøy', 'Undertøy- og innertøyproduksjon');
INSERT INTO public.naring VALUES ('14.19', 'Produksjon av klær og tilbehør ellers', 'Produksjon av klær og tilbehør el.');
INSERT INTO public.naring VALUES ('14.20', 'Produksjon av pelsvarer', 'Produksjon av pelsvarer');
INSERT INTO public.naring VALUES ('14.31', 'Produksjon av strømpevarer', 'Strømpevareproduksjon');
INSERT INTO public.naring VALUES ('14.39', 'Produksjon av andre klær av trikotasje', 'Prod. av klær av trikotasje el.');
INSERT INTO public.naring VALUES ('14.110', 'Produksjon av klær av lær', 'Produksjon av klær av lær');
INSERT INTO public.naring VALUES ('14.120', 'Produksjon av arbeidstøy', 'Arbeidstøyproduksjon');
INSERT INTO public.naring VALUES ('14.130', 'Produksjon av annet yttertøy', 'Annen yttertøyproduksjon');
INSERT INTO public.naring VALUES ('14.140', 'Produksjon av undertøy og innertøy', 'Undertøy- og innertøyproduksjon');
INSERT INTO public.naring VALUES ('14.190', 'Produksjon av klær og tilbehør ellers', 'Produksjon av klær og tilbehør el.');
INSERT INTO public.naring VALUES ('14.200', 'Produksjon av pelsvarer', 'Produksjon av pelsvarer');
INSERT INTO public.naring VALUES ('14.310', 'Produksjon av strømpevarer', 'Strømpevareproduksjon');
INSERT INTO public.naring VALUES ('14.390', 'Produksjon av andre klær av trikotasje', 'Prod. av klær av trikotasje el.');
INSERT INTO public.naring VALUES ('15', 'Produksjon av lær og lærvarer', 'Lær- og lærvareindustri');
INSERT INTO public.naring VALUES ('15.1', 'Beredning av lær, produksjon av reiseeffekter og salmakerartikler og beredning og farging av pelsskinn', 'Bered. lær, prod. av reiseeff. mv.');
INSERT INTO public.naring VALUES ('15.2', 'Produksjon av skotøy', 'Produksjon av skotøy');
INSERT INTO public.naring VALUES ('15.11', 'Beredning av lær, og beredning og farging av pelsskinn', 'Lærberedning');
INSERT INTO public.naring VALUES ('15.12', 'Produksjon av reiseeffekter og salmakerartikler', 'Reiseeffekter og salmakerartikler');
INSERT INTO public.naring VALUES ('15.20', 'Produksjon av skotøy', 'Produksjon av skotøy');
INSERT INTO public.naring VALUES ('15.110', 'Beredning av lær, og beredning og farging av pelsskinn', 'Lærberedning');
INSERT INTO public.naring VALUES ('15.120', 'Produksjon av reiseeffekter og salmakerartikler', 'Reiseeffekter og salmakerartikler');
INSERT INTO public.naring VALUES ('15.200', 'Produksjon av skotøy', 'Produksjon av skotøy');
INSERT INTO public.naring VALUES ('16', 'Produksjon av trelast og varer av tre, kork, strå og flettematerialer, unntatt møbler', 'Trelast- og trevareindustri');
INSERT INTO public.naring VALUES ('16.1', 'Saging, høvling og impregnering av tre', 'Saging, høvling mv. av tre');
INSERT INTO public.naring VALUES ('16.2', 'Produksjon av varer av tre, kork, strå og flettematerialer', 'Produksjon trevarer, kork mv.');
INSERT INTO public.naring VALUES ('16.10', 'Saging, høvling og impregnering av tre', 'Saging, høvling mv. av tre');
INSERT INTO public.naring VALUES ('16.21', 'Produksjon av finerplater og andre bygnings- og møbelplater av tre', 'Bygnings- og møbelplateproduksjon');
INSERT INTO public.naring VALUES ('16.22', 'Produksjon av sammensatte parkettstaver', 'Sammensatte parkettstavprod.');
INSERT INTO public.naring VALUES ('16.23', 'Produksjon av andre bygningsartikler', 'Annen bygningsartikkelprod.');
INSERT INTO public.naring VALUES ('16.24', 'Produksjon av treemballasje', 'Treemballasjeproduksjon');
INSERT INTO public.naring VALUES ('16.29', 'Produksjon av andre trevarer og varer av kork, strå og flettematerialer', 'Andre tre-, kork-, stråvarer mv.');
INSERT INTO public.naring VALUES ('16.100', 'Saging, høvling og impregnering av tre', 'Saging, høvling mv. av tre');
INSERT INTO public.naring VALUES ('16.210', 'Produksjon av finerplater og andre bygnings- og møbelplater av tre', 'Bygnings- og møbelplateproduksjon');
INSERT INTO public.naring VALUES ('16.220', 'Produksjon av sammensatte parkettstaver', 'Sammensatte parkettstavprod.');
INSERT INTO public.naring VALUES ('16.231', 'Produksjon av monteringsferdige hus', 'Ferdighusproduksjon');
INSERT INTO public.naring VALUES ('16.232', 'Produksjon av bygningsartikler', 'Bygningsartikkelproduksjon');
INSERT INTO public.naring VALUES ('16.240', 'Produksjon av treemballasje', 'Treemballasjeproduksjon');
INSERT INTO public.naring VALUES ('16.290', 'Produksjon av andre trevarer og varer av kork, strå og flettematerialer', 'Andre tre-, kork-, stråvarer mv.');
INSERT INTO public.naring VALUES ('17', 'Produksjon av papir og papirvarer', 'Papir- og papirvareindustri');
INSERT INTO public.naring VALUES ('17.1', 'Produksjon av papirmasse, papir og papp', 'Prod. av papirmasse, papir og papp');
INSERT INTO public.naring VALUES ('17.2', 'Produksjon av varer av papir og papp', 'Produksjon av varer av papir og papp');
INSERT INTO public.naring VALUES ('17.11', 'Produksjon av papirmasse', 'Produksjon av papirmasse');
INSERT INTO public.naring VALUES ('17.12', 'Produksjon av papir og papp', 'Produksjon av papir og papp');
INSERT INTO public.naring VALUES ('17.21', 'Produksjon av bølgepapp og emballasje av papir og papp', 'Bølgepapp, papir- og pappemballasje');
INSERT INTO public.naring VALUES ('17.22', 'Produksjon av husholdnings-, sanitær- og toalettartikler av papir', 'Hushold.-/toalettartikler av papir');
INSERT INTO public.naring VALUES ('17.23', 'Produksjon av kontorartikler av papir', 'Prod. av kontorartikler av papir');
INSERT INTO public.naring VALUES ('17.24', 'Produksjon av tapeter', 'Tapetproduksjon');
INSERT INTO public.naring VALUES ('22.2', 'Produksjon av plastprodukter', 'Produksjon av plastprodukter');
INSERT INTO public.naring VALUES ('17.29', 'Produksjon av varer av papir og papp ellers', 'Papir- og pappvareproduksjon el.');
INSERT INTO public.naring VALUES ('17.110', 'Produksjon av papirmasse', 'Produksjon av papirmasse');
INSERT INTO public.naring VALUES ('17.120', 'Produksjon av papir og papp', 'Produksjon av papir og papp');
INSERT INTO public.naring VALUES ('17.210', 'Produksjon av bølgepapp og emballasje av papir og papp', 'Bølgepapp, papir- og pappemballasje');
INSERT INTO public.naring VALUES ('17.220', 'Produksjon av husholdnings-, sanitær- og toalettartikler av papir', 'Hushold.-/toalettartikler av papir');
INSERT INTO public.naring VALUES ('17.230', 'Produksjon av kontorartikler av papir', 'Prod. av kontorartikler av papir');
INSERT INTO public.naring VALUES ('17.240', 'Produksjon av tapeter', 'Tapetproduksjon');
INSERT INTO public.naring VALUES ('17.290', 'Produksjon av varer av papir og papp ellers', 'Papir- og pappvareproduksjon el.');
INSERT INTO public.naring VALUES ('18', 'Trykking og reproduksjon av innspilte opptak', 'Trykking, grafisk industri');
INSERT INTO public.naring VALUES ('18.1', 'Trykking og tjenester tilknyttet trykking', 'Trykking, tilhørende tjenester');
INSERT INTO public.naring VALUES ('18.2', 'Reproduksjon av innspilte opptak', 'Reproduksjon av innspilte opptak');
INSERT INTO public.naring VALUES ('18.11', 'Trykking av aviser', 'Trykking av aviser');
INSERT INTO public.naring VALUES ('18.12', 'Trykking ellers', 'Trykking ellers');
INSERT INTO public.naring VALUES ('18.13', 'Ferdiggjøring før trykking og publisering', 'Ferdiggjøring før trykking og publ.');
INSERT INTO public.naring VALUES ('18.14', 'Bokbinding og tilknyttede tjenester', 'Bokbinding og tilkn. tjenester');
INSERT INTO public.naring VALUES ('18.20', 'Reproduksjon av innspilte opptak', 'Reproduksjon av innspilte opptak');
INSERT INTO public.naring VALUES ('18.110', 'Trykking av aviser', 'Trykking av aviser');
INSERT INTO public.naring VALUES ('18.120', 'Trykking ellers', 'Trykking ellers');
INSERT INTO public.naring VALUES ('18.130', 'Ferdiggjøring før trykking og publisering', 'Ferdiggjøring før trykking og publ.');
INSERT INTO public.naring VALUES ('18.140', 'Bokbinding og tilknyttede tjenester', 'Bokbinding og tilkn. tjenester');
INSERT INTO public.naring VALUES ('18.200', 'Reproduksjon av innspilte opptak', 'Reproduksjon av innspilte opptak');
INSERT INTO public.naring VALUES ('19', 'Produksjon av kull- og raffinerte petroleumsprodukter', 'Petroleums- og kullvareindustri');
INSERT INTO public.naring VALUES ('19.1', 'Produksjon av kullprodukter', 'Produksjon av kullprodukter');
INSERT INTO public.naring VALUES ('19.2', 'Produksjon av raffinerte petroleumsprodukter', 'Prod. raffinerte petroleumsprodukt');
INSERT INTO public.naring VALUES ('19.10', 'Produksjon av kullprodukter', 'Produksjon av kullprodukter');
INSERT INTO public.naring VALUES ('19.20', 'Produksjon av raffinerte petroleumsprodukter', 'Prod. raffinerte petroleumsprodukt');
INSERT INTO public.naring VALUES ('19.100', 'Produksjon av kullprodukter', 'Produksjon av kullprodukter');
INSERT INTO public.naring VALUES ('19.200', 'Produksjon av raffinerte petroleumsprodukter', 'Prod. raffinerte petroleumsprodukt');
INSERT INTO public.naring VALUES ('20', 'Produksjon av kjemikalier og kjemiske produkter', 'Kjemisk industri');
INSERT INTO public.naring VALUES ('20.1', 'Produksjon av kjemiske råvarer, gjødsel og nitrogenforbindelser, basisplast og syntetisk gummi', 'Produksjon kjemiske råvarer mv.');
INSERT INTO public.naring VALUES ('20.2', 'Produksjon av plantevern- og skadedyrmidler og andre landbrukskjemiske produkter', 'Produksjon landbrukskjemiske prod.');
INSERT INTO public.naring VALUES ('20.3', 'Produksjon av maling og lakk, trykkfarger og tetningsmidler', 'Produksjon maling, lakk mv.');
INSERT INTO public.naring VALUES ('20.4', 'Produksjon av såpe og vaskemidler, rense- og polermidler, parfyme og toalettartikler', 'Produksjon vaske- og toalettartikler');
INSERT INTO public.naring VALUES ('20.5', 'Produksjon av andre kjemiske produkter', 'Produksjon andre kjemiske prod.');
INSERT INTO public.naring VALUES ('20.6', 'Produksjon av kunstfibrer', 'Produksjon av kunstfibrer');
INSERT INTO public.naring VALUES ('20.11', 'Produksjon av industrigasser', 'Industrigassproduksjon');
INSERT INTO public.naring VALUES ('20.12', 'Produksjon av fargestoffer og pigmenter', 'Fargestoff- og pigmentproduksjon');
INSERT INTO public.naring VALUES ('20.13', 'Produksjon av andre uorganiske kjemikalier', 'Uorganisk kjemikalieproduksjon el.');
INSERT INTO public.naring VALUES ('20.14', 'Produksjon av andre organiske kjemiske råvarer', 'Annen org. kjemisk råvareproduksjon');
INSERT INTO public.naring VALUES ('20.15', 'Produksjon av gjødsel, nitrogenforbindelser og vekstjord', 'Gjødselproduksjon mv.');
INSERT INTO public.naring VALUES ('20.16', 'Produksjon av basisplast', 'Basisplastproduksjon');
INSERT INTO public.naring VALUES ('20.17', 'Produksjon av syntetisk gummi', 'Produksjon av syntetisk gummi');
INSERT INTO public.naring VALUES ('20.20', 'Produksjon av plantevern- og skadedyrmidler og andre landbrukskjemiske produkter', 'Produksjon landbrukskjemiske prod.');
INSERT INTO public.naring VALUES ('20.30', 'Produksjon av maling og lakk, trykkfarger og tetningsmidler', 'Produksjon maling, lakk mv.');
INSERT INTO public.naring VALUES ('20.41', 'Produksjon av såpe og vaskemidler, rense- og polermidler', 'Såpe- og vaskemiddelprod. mv.');
INSERT INTO public.naring VALUES ('20.42', 'Produksjon av parfyme og toalettartikler', 'Parfyme og toalettartikler');
INSERT INTO public.naring VALUES ('20.51', 'Produksjon av eksplosiver', 'Produksjon av eksplosiver');
INSERT INTO public.naring VALUES ('20.52', 'Produksjon av lim', 'Limproduksjon');
INSERT INTO public.naring VALUES ('20.53', 'Produksjon av eteriske oljer', 'Produksjon av eteriske oljer');
INSERT INTO public.naring VALUES ('20.59', 'Produksjon av kjemiske produkter ikke nevnt annet sted', 'Annen kjemisk produksjon');
INSERT INTO public.naring VALUES ('20.60', 'Produksjon av kunstfibrer', 'Produksjon av kunstfibrer');
INSERT INTO public.naring VALUES ('20.110', 'Produksjon av industrigasser', 'Industrigassproduksjon');
INSERT INTO public.naring VALUES ('20.120', 'Produksjon av fargestoffer og pigmenter', 'Fargestoff- og pigmentproduksjon');
INSERT INTO public.naring VALUES ('20.130', 'Produksjon av andre uorganiske kjemikalier', 'Uorganisk kjemikalieproduksjon el.');
INSERT INTO public.naring VALUES ('20.140', 'Produksjon av andre organiske kjemiske råvarer', 'Annen org. kjemisk råvareproduksjon');
INSERT INTO public.naring VALUES ('20.150', 'Produksjon av gjødsel, nitrogenforbindelser og vekstjord', 'Gjødselproduksjon mv.');
INSERT INTO public.naring VALUES ('20.160', 'Produksjon av basisplast', 'Basisplastproduksjon');
INSERT INTO public.naring VALUES ('20.170', 'Produksjon av syntetisk gummi', 'Produksjon av syntetisk gummi');
INSERT INTO public.naring VALUES ('20.200', 'Produksjon av plantevern- og skadedyrmidler og andre landbrukskjemiske produkter', 'Produksjon landbrukskjemiske prod.');
INSERT INTO public.naring VALUES ('20.300', 'Produksjon av maling og lakk, trykkfarger og tetningsmidler', 'Produksjon maling, lakk mv.');
INSERT INTO public.naring VALUES ('20.410', 'Produksjon av såpe og vaskemidler, rense- og polermidler', 'Såpe- og vaskemiddelprod. mv.');
INSERT INTO public.naring VALUES ('20.420', 'Produksjon av parfyme og toalettartikler', 'Parfyme og toalettartikler');
INSERT INTO public.naring VALUES ('20.510', 'Produksjon av eksplosiver', 'Produksjon av eksplosiver');
INSERT INTO public.naring VALUES ('20.520', 'Produksjon av lim', 'Limproduksjon');
INSERT INTO public.naring VALUES ('20.530', 'Produksjon av eteriske oljer', 'Produksjon av eteriske oljer');
INSERT INTO public.naring VALUES ('20.590', 'Produksjon av kjemiske produkter ikke nevnt annet sted', 'Annen kjemisk produksjon');
INSERT INTO public.naring VALUES ('20.600', 'Produksjon av kunstfibrer', 'Produksjon av kunstfibrer');
INSERT INTO public.naring VALUES ('21', 'Produksjon av farmasøytiske råvarer og preparater', 'Farmasøytisk industri');
INSERT INTO public.naring VALUES ('21.1', 'Produksjon av farmasøytiske råvarer', 'Farmasøytiske råvarer');
INSERT INTO public.naring VALUES ('21.2', 'Produksjon av farmasøytiske preparater', 'Farmasøytiske preparater');
INSERT INTO public.naring VALUES ('21.10', 'Produksjon av farmasøytiske råvarer', 'Farmasøytiske råvarer');
INSERT INTO public.naring VALUES ('21.20', 'Produksjon av farmasøytiske preparater', 'Farmasøytiske preparater');
INSERT INTO public.naring VALUES ('21.100', 'Produksjon av farmasøytiske råvarer', 'Farmasøytiske råvarer');
INSERT INTO public.naring VALUES ('21.200', 'Produksjon av farmasøytiske preparater', 'Farmasøytiske preparater');
INSERT INTO public.naring VALUES ('22', 'Produksjon av gummi- og plastprodukter', 'Gummivare- og plastindustri');
INSERT INTO public.naring VALUES ('22.1', 'Produksjon av gummiprodukter', 'Produksjon av gummiprodukter');
INSERT INTO public.naring VALUES ('22.11', 'Produksjon av gummidekk og slanger til gummidekk, og regummiering og vulkanisering av gummidekk', 'Gummidekkprod., -regumm. og -vulk.');
INSERT INTO public.naring VALUES ('22.19', 'Produksjon av gummiprodukter ellers', 'Produksjon av gummiprodukter el.');
INSERT INTO public.naring VALUES ('22.21', 'Produksjon av halvfabrikater av plast', 'Prod. av halvfabrikater av plast');
INSERT INTO public.naring VALUES ('22.22', 'Produksjon av plastemballasje', 'Plastemballasjeproduksjon');
INSERT INTO public.naring VALUES ('22.23', 'Produksjon av byggevarer av plast', 'Byggevareprod. av plast');
INSERT INTO public.naring VALUES ('22.29', 'Produksjon av plastprodukter ellers', 'Prod. av plastprodukter el.');
INSERT INTO public.naring VALUES ('22.110', 'Produksjon av gummidekk og slanger til gummidekk, og regummiering og vulkanisering av gummidekk', 'Gummidekkprod., -regumm. og -vulk');
INSERT INTO public.naring VALUES ('22.190', 'Produksjon av gummiprodukter ellers', 'Produksjon av gummiprodukter el.');
INSERT INTO public.naring VALUES ('22.210', 'Produksjon av halvfabrikater av plast', 'Prod. av halvfabrikater av plast');
INSERT INTO public.naring VALUES ('22.220', 'Produksjon av plastemballasje', 'Plastemballasjeproduksjon');
INSERT INTO public.naring VALUES ('22.230', 'Produksjon av byggevarer av plast', 'Byggevareprod. av plast');
INSERT INTO public.naring VALUES ('22.290', 'Produksjon av plastprodukter ellers', 'Prod. av plastprodukter el.');
INSERT INTO public.naring VALUES ('23', 'Produksjon av andre ikke-metallholdige mineralprodukter', 'Mineralproduktindustri');
INSERT INTO public.naring VALUES ('23.1', 'Produksjon av glass og glassprodukter', 'Produksjon av glass og glassprodukter');
INSERT INTO public.naring VALUES ('23.2', 'Produksjon av ildfaste produkter', 'Prod. av ildfaste produkter');
INSERT INTO public.naring VALUES ('23.3', 'Produksjon av byggevarer av brent leire', 'Prod. av byggevarer av brent leire');
INSERT INTO public.naring VALUES ('23.4', 'Produksjon av andre porselensprodukter og keramiske produkter', 'Prod. av porselens-/keram.prod. el.');
INSERT INTO public.naring VALUES ('23.5', 'Produksjon av sement, kalk og gips', 'Produksjon av sement, kalk og gips');
INSERT INTO public.naring VALUES ('23.6', 'Produksjon av betong-, sement- og gipsprodukter', 'Prod. av betong-/sement-/gipsprod.');
INSERT INTO public.naring VALUES ('23.7', 'Hogging og bearbeiding av monument- og bygningsstein', 'Hogg./bearb. av monum.-/bygn.stein');
INSERT INTO public.naring VALUES ('23.9', 'Produksjon av ikke-metallholdige mineralprodukter ikke nevnt annet sted', 'Prod. ikke-metallholdige mineralprod.');
INSERT INTO public.naring VALUES ('23.11', 'Produksjon av planglass', 'Planglassproduksjon');
INSERT INTO public.naring VALUES ('23.12', 'Bearbeiding av planglass', 'Planglassbearbeiding');
INSERT INTO public.naring VALUES ('23.13', 'Produksjon av emballasje og husholdningsartikler av glass og krystall', 'Emb. og hush.art. av glass/krystall');
INSERT INTO public.naring VALUES ('23.14', 'Produksjon av glassfibrer', 'Glassfiberproduksjon');
INSERT INTO public.naring VALUES ('23.19', 'Produksjon av teknisk glass og andre glassvarer', 'Tekn. glass- og annen glassvareprod.');
INSERT INTO public.naring VALUES ('23.20', 'Produksjon av ildfaste produkter', 'Prod. av ildfaste produkter');
INSERT INTO public.naring VALUES ('23.31', 'Produksjon av keramiske vegg- og gulvfliser', 'Keramisk byggematerialproduksjon');
INSERT INTO public.naring VALUES ('23.32', 'Produksjon av murstein, teglstein og andre byggevarer av brent leire', 'Mur-, teglstein- o.a. byggevareprod.');
INSERT INTO public.naring VALUES ('23.41', 'Produksjon av keramiske husholdningsartikler og dekorasjonsgjenstander', 'Keramiske husholdningsartikler mv.');
INSERT INTO public.naring VALUES ('23.42', 'Produksjon av sanitærutstyr av keramisk materiale', 'Prod. av keramisk sanitærutstyr');
INSERT INTO public.naring VALUES ('23.43', 'Produksjon av isolatorer og isoleringsdeler av keramisk materiale', 'Prod. av keramiske isoleringsdeler');
INSERT INTO public.naring VALUES ('23.44', 'Produksjon av andre keramiske produkter for teknisk bruk', 'Prod. av keram. prod. for tekn. bruk');
INSERT INTO public.naring VALUES ('23.49', 'Produksjon av andre keramiske produkter', 'Prod. av andre keramiske prod.');
INSERT INTO public.naring VALUES ('23.51', 'Produksjon av sement', 'Sementproduksjon');
INSERT INTO public.naring VALUES ('23.52', 'Produksjon av kalk og gips', 'Kalk- og gipsproduksjon');
INSERT INTO public.naring VALUES ('23.61', 'Produksjon av betongprodukter for bygge- og anleggsvirksomhet', 'Betongprodukter for bygg og anlegg');
INSERT INTO public.naring VALUES ('23.62', 'Produksjon av gipsprodukter for bygge- og anleggsvirksomhet', 'Gipsprodukter for bygg av anlegg');
INSERT INTO public.naring VALUES ('23.63', 'Produksjon av ferdigblandet betong', 'Ferdigblandet betong');
INSERT INTO public.naring VALUES ('23.64', 'Produksjon av mørtel', 'Mørtelproduksjon');
INSERT INTO public.naring VALUES ('23.65', 'Produksjon av fibersement', 'Fibersementproduksjon');
INSERT INTO public.naring VALUES ('23.69', 'Produksjon av betong-, sement- og gipsprodukter ellers', 'Annen betong-, sement- og gipsprod.');
INSERT INTO public.naring VALUES ('23.70', 'Hogging og bearbeiding av monument- og bygningsstein', 'Hogg./bearb. av monum.-/bygn.stein');
INSERT INTO public.naring VALUES ('23.91', 'Produksjon av slipestoffer', 'Slipestoffproduksjon');
INSERT INTO public.naring VALUES ('23.99', 'Produksjon av ikke-metallholdige mineralprodukter ikke nevnt annet sted', 'Prod. av ikke-met. mineralprod. el.');
INSERT INTO public.naring VALUES ('23.110', 'Produksjon av planglass', 'Planglassproduksjon');
INSERT INTO public.naring VALUES ('23.120', 'Bearbeiding av planglass', 'Planglassbearbeiding');
INSERT INTO public.naring VALUES ('23.130', 'Produksjon av emballasje og husholdningsartikler av glass og krystall', 'Emb. og hush.art. av glass/krystall');
INSERT INTO public.naring VALUES ('23.140', 'Produksjon av glassfibrer', 'Glassfiberproduksjon');
INSERT INTO public.naring VALUES ('23.190', 'Produksjon av teknisk glass og andre glassvarer', 'Tekn. glass- og annen glassvareprod.');
INSERT INTO public.naring VALUES ('23.200', 'Produksjon av ildfaste produkter', 'Prod. av ildfaste produkter');
INSERT INTO public.naring VALUES ('23.310', 'Produksjon av keramiske vegg- og gulvfliser', 'Keramisk byggematerialproduksjon');
INSERT INTO public.naring VALUES ('23.320', 'Produksjon av murstein, teglstein og andre byggevarer av brent leire', 'Mur-, teglstein- o.a. byggevareprod.');
INSERT INTO public.naring VALUES ('23.410', 'Produksjon av keramiske husholdningsartikler og dekorasjonsgjenstander', 'Keramiske husholdningsartikler mv.');
INSERT INTO public.naring VALUES ('23.420', 'Produksjon av sanitærutstyr av keramisk materiale', 'Prod. av keramisk sanitærutstyr');
INSERT INTO public.naring VALUES ('23.430', 'Produksjon av isolatorer og isoleringsdeler av keramisk materiale', 'Prod. av keramiske isoleringsdeler');
INSERT INTO public.naring VALUES ('23.440', 'Produksjon av andre keramiske produkter for teknisk bruk', 'Prod. av keram. prod. for tekn. bruk');
INSERT INTO public.naring VALUES ('23.490', 'Produksjon av andre keramiske produkter', 'Prod. av andre keram. prod.');
INSERT INTO public.naring VALUES ('23.510', 'Produksjon av sement', 'Sementproduksjon');
INSERT INTO public.naring VALUES ('23.520', 'Produksjon av kalk og gips', 'Kalk- og gipsproduksjon');
INSERT INTO public.naring VALUES ('23.610', 'Produksjon av betongprodukter for bygge- og anleggsvirksomhet', 'Betongprodukter for bygg og anlegg');
INSERT INTO public.naring VALUES ('23.620', 'Produksjon av gipsprodukter for bygge- og anleggsvirksomhet', 'Gipsprodukter for bygg og anlegg');
INSERT INTO public.naring VALUES ('23.630', 'Produksjon av ferdigblandet betong', 'Ferdigblandet betong');
INSERT INTO public.naring VALUES ('23.640', 'Produksjon av mørtel', 'Mørtelproduksjon');
INSERT INTO public.naring VALUES ('23.650', 'Produksjon av fibersement', 'Fibersementproduksjon');
INSERT INTO public.naring VALUES ('23.690', 'Produksjon av betong-, sement- og gipsprodukter ellers', 'Annen betong-, sement- og gipsprod.');
INSERT INTO public.naring VALUES ('23.700', 'Hogging og bearbeiding av monument- og bygningsstein', 'Hogg./bearb. av monum.-/bygn.stein');
INSERT INTO public.naring VALUES ('23.910', 'Produksjon av slipestoffer', 'Slipestoffproduksjon');
INSERT INTO public.naring VALUES ('23.990', 'Produksjon av ikke-metallholdige mineralprodukter ikke nevnt annet sted', 'Prod. av ikke-met. mineralprod. el.');
INSERT INTO public.naring VALUES ('24', 'Produksjon av metaller', 'Metallindustri');
INSERT INTO public.naring VALUES ('24.1', 'Produksjon av jern og stål, samt ferrolegeringer', 'Produksjon jern, stål, ferroleger.');
INSERT INTO public.naring VALUES ('24.2', 'Produksjon av andre rør og rørdeler av stål', 'Annen rør- og rørdelprod. av stål');
INSERT INTO public.naring VALUES ('24.3', 'Annen bearbeiding av jern og stål', 'Annen bearbeiding av jern og stål');
INSERT INTO public.naring VALUES ('24.4', 'Produksjon av ikke-jernholdige metaller', 'Prod. av ikke-jernh. metaller');
INSERT INTO public.naring VALUES ('24.5', 'Støping av metaller', 'Støping av metaller');
INSERT INTO public.naring VALUES ('24.10', 'Produksjon av jern og stål, samt ferrolegeringer', 'Produksjon jern,  stål, ferroleger.');
INSERT INTO public.naring VALUES ('24.20', 'Produksjon av andre rør og rørdeler av stål', 'Annen rør- og rørdelprod. av stål');
INSERT INTO public.naring VALUES ('24.31', 'Kaldtrekking av stenger og profiler', 'Kaldtrekking av stenger og profiler');
INSERT INTO public.naring VALUES ('24.32', 'Kaldvalsing av bånd', 'Kaldvalsing av bånd');
INSERT INTO public.naring VALUES ('24.33', 'Kaldvalsing og pressing av profilerte plater og profiler', 'Kaldv./press. av prof. plater mv.');
INSERT INTO public.naring VALUES ('24.34', 'Kaldtrekking av tråd', 'Kaldtrekking av tråd');
INSERT INTO public.naring VALUES ('24.41', 'Produksjon av edelmetaller', 'Edelmetallproduksjon');
INSERT INTO public.naring VALUES ('24.42', 'Produksjon av aluminium', 'Produksjon av aluminium');
INSERT INTO public.naring VALUES ('24.43', 'Produksjon av bly, sink og tinn', 'Bly-, sink- og tinnproduksjon');
INSERT INTO public.naring VALUES ('24.44', 'Produksjon av kobber', 'Kobberproduksjon');
INSERT INTO public.naring VALUES ('24.45', 'Produksjon av ikke-jernholdige metaller ellers', 'Prod. ikke-jernhold. metaller ellers');
INSERT INTO public.naring VALUES ('24.46', 'Produksjon av kjernebrensel', 'Kjernebrenselproduksjon');
INSERT INTO public.naring VALUES ('24.51', 'Støping av jern', 'Støping av jern');
INSERT INTO public.naring VALUES ('24.52', 'Støping av stål', 'Støping av stål');
INSERT INTO public.naring VALUES ('24.53', 'Støping av lettmetaller', 'Støping av lettmetaller');
INSERT INTO public.naring VALUES ('24.54', 'Støping av andre ikke-jernholdige metaller', 'Annen ikke-jernholdig metallstøp.');
INSERT INTO public.naring VALUES ('24.101', 'Produksjon av jern og stål', 'Jern- og stålproduksjon');
INSERT INTO public.naring VALUES ('24.102', 'Produksjon av ferrolegeringer', 'Prod. av ferrolegeringer');
INSERT INTO public.naring VALUES ('24.200', 'Produksjon av andre rør og rørdeler av stål', 'Annen rør- og rørdelprod. av stål');
INSERT INTO public.naring VALUES ('24.310', 'Kaldtrekking av stenger og profiler', 'Kaldtrekking av stenger og profiler');
INSERT INTO public.naring VALUES ('24.320', 'Kaldvalsing av bånd', 'Kaldvalsing av bånd');
INSERT INTO public.naring VALUES ('24.330', 'Kaldvalsing og pressing av profilerte plater og profiler', 'Kaldv./press. av prof. plater mv.');
INSERT INTO public.naring VALUES ('24.340', 'Kaldtrekking av tråd', 'Kaldtrekking av tråd');
INSERT INTO public.naring VALUES ('24.410', 'Produksjon av edelmetaller', 'Edelmetallproduksjon');
INSERT INTO public.naring VALUES ('24.421', 'Produksjon av primæraluminium', 'Prod. av primæraluminium');
INSERT INTO public.naring VALUES ('24.422', 'Produksjon av halvfabrikater av aluminium', 'Prod. av halvfabrikater av aluminium');
INSERT INTO public.naring VALUES ('24.430', 'Produksjon av bly, sink og tinn', 'Bly-, sink- og tinnproduksjon');
INSERT INTO public.naring VALUES ('24.440', 'Produksjon av kobber', 'Kobberproduksjon');
INSERT INTO public.naring VALUES ('24.450', 'Produksjon av ikke-jernholdige metaller ellers', 'Prod. ikke-jernhold. metaller ellers');
INSERT INTO public.naring VALUES ('24.460', 'Produksjon av kjernebrensel', 'Kjernebrenselproduksjon');
INSERT INTO public.naring VALUES ('24.510', 'Støping av jern', 'Støping av jern');
INSERT INTO public.naring VALUES ('24.520', 'Støping av stål', 'Støping av stål');
INSERT INTO public.naring VALUES ('24.530', 'Støping av lettmetaller', 'Støping av lettmetaller');
INSERT INTO public.naring VALUES ('24.540', 'Støping av andre ikke-jernholdige metaller', 'Annen ikke-jernholdig metallstøp.');
INSERT INTO public.naring VALUES ('25', 'Produksjon av metallvarer, unntatt maskiner og utstyr', 'Metallvareindustri');
INSERT INTO public.naring VALUES ('25.1', 'Produksjon av metallkonstruksjoner', 'Produksjon av metallkonstruksjoner');
INSERT INTO public.naring VALUES ('25.2', 'Produksjon av tanker, cisterner og andre beholdere av metall', 'Tanker, cisterner, sentralvarmeanl.');
INSERT INTO public.naring VALUES ('25.3', 'Produksjon av dampkjeler, unntatt kjeler til sentralvarmeanlegg', 'Dampkjeler unnt. sentralvarmeanl');
INSERT INTO public.naring VALUES ('25.4', 'Produksjon av våpen og ammunisjon', 'Våpen- og ammunisjonsproduksjon');
INSERT INTO public.naring VALUES ('25.5', 'Smiing, stansing og valsing av metall, og pulvermetallurgi', 'Stansing/valsing/pulvermetallurgi');
INSERT INTO public.naring VALUES ('25.6', 'Overflatebehandling og bearbeiding av metaller', 'Overflatebeh./bearb. av metaller');
INSERT INTO public.naring VALUES ('25.7', 'Produksjon av kjøkkenredskaper, skjære- og klipperedskaper, håndverktøy og andre jernvarer', 'Produksjon redskaper, andre jernvarer');
INSERT INTO public.naring VALUES ('25.9', 'Produksjon av andre metallvarer', 'Produksjon av andre metallvarer');
INSERT INTO public.naring VALUES ('25.11', 'Produksjon av metallkonstruksjoner og deler', 'Prod. av metallkonstruksj. og deler');
INSERT INTO public.naring VALUES ('25.12', 'Produksjon av dører og vinduer av metall', 'Bygningsartikkelprod. av metall');
INSERT INTO public.naring VALUES ('25.21', 'Produksjon av radiatorer og kjeler til sentralvarmeanlegg', 'Sentralv.kjeler- og radiatorprod.');
INSERT INTO public.naring VALUES ('25.29', 'Produksjon av andre tanker, cisterner og beholdere av metall', 'Prod. av metallbeholdere');
INSERT INTO public.naring VALUES ('25.30', 'Produksjon av dampkjeler, unntatt kjeler til sentralvarmeanlegg', 'Dampkjeler unnt. sentralvarmeanl.');
INSERT INTO public.naring VALUES ('25.40', 'Produksjon av våpen og ammunisjon', 'Våpen- og ammunisjonsproduksjon');
INSERT INTO public.naring VALUES ('25.50', 'Smiing, stansing og valsing av metall, og pulvermetallurgi', 'Stansing/valsing/pulvermetallurgi');
INSERT INTO public.naring VALUES ('25.61', 'Overflatebehandling av metaller', 'Overflatebehandling av metaller');
INSERT INTO public.naring VALUES ('25.62', 'Bearbeiding av metaller', 'Bearbeiding av metaller');
INSERT INTO public.naring VALUES ('25.71', 'Produksjon av kjøkkenredskaper og skjære- og klipperedskaper', 'Kjøkkenredskapsproduksjon');
INSERT INTO public.naring VALUES ('25.72', 'Produksjon av låser og beslag', 'Låse- og beslagproduksjon');
INSERT INTO public.naring VALUES ('25.73', 'Produksjon av håndverktøy', 'Håndverktøyproduksjon');
INSERT INTO public.naring VALUES ('25.91', 'Produksjon av stålfat og lignende beholdere av jern og stål', 'Prod. av behold. mv. av jern/stål');
INSERT INTO public.naring VALUES ('25.92', 'Produksjon av emballasje av lettmetall', 'Prod. av lettmetallemballasje');
INSERT INTO public.naring VALUES ('25.93', 'Produksjon av varer av metalltråd, kjetting og fjærer', 'Metalltrådvareproduksjon');
INSERT INTO public.naring VALUES ('25.94', 'Produksjon av bolter og skruer', 'Bolte- og skrueproduksjon');
INSERT INTO public.naring VALUES ('25.99', 'Produksjon av metallvarer ikke nevnt annet sted', 'Metallvareprod. el.');
INSERT INTO public.naring VALUES ('25.110', 'Produksjon av metallkonstruksjoner og deler', 'Prod. av metallkonstruksj. og deler');
INSERT INTO public.naring VALUES ('25.120', 'Produksjon av dører og vinduer av metall', 'Bygningsartikkelprod. av metall');
INSERT INTO public.naring VALUES ('25.210', 'Produksjon av radiatorer og kjeler til sentralvarmeanlegg', 'Sentralv.kjeler- og radiatorprod.');
INSERT INTO public.naring VALUES ('25.290', 'Produksjon av andre tanker, cisterner og beholdere av metall', 'Prod. av metallbeholdere');
INSERT INTO public.naring VALUES ('25.300', 'Produksjon av dampkjeler, unntatt kjeler til sentralvarmeanlegg', 'Dampkjeler unnt. sentralvarmeanl.');
INSERT INTO public.naring VALUES ('25.400', 'Produksjon av våpen og ammunisjon', 'Våpen- og ammunisjonsproduksjon');
INSERT INTO public.naring VALUES ('25.500', 'Smiing, stansing og valsing av metall, og pulvermetallurgi', 'Stansing/valsing/pulvermetallurgi');
INSERT INTO public.naring VALUES ('25.610', 'Overflatebehandling av metaller', 'Overflatebehandling av metaller');
INSERT INTO public.naring VALUES ('25.620', 'Bearbeiding av metaller', 'Bearbeiding av metaller');
INSERT INTO public.naring VALUES ('25.710', 'Produksjon av kjøkkenredskaper og skjære- og klipperedskaper', 'Kjøkkenredskapsproduksjon');
INSERT INTO public.naring VALUES ('25.720', 'Produksjon av låser og beslag', 'Låse- og beslagproduksjon');
INSERT INTO public.naring VALUES ('25.730', 'Produksjon av håndverktøy', 'Håndverktøyproduksjon');
INSERT INTO public.naring VALUES ('25.910', 'Produksjon av stålfat og lignende beholdere av jern og stål', 'Prod. av behold. mv. av jern/stål');
INSERT INTO public.naring VALUES ('25.920', 'Produksjon av emballasje av lettmetall', 'Prod. av lettmetallemballasje');
INSERT INTO public.naring VALUES ('25.930', 'Produksjon av varer av metalltråd, kjetting og fjærer', 'Metalltrådvareproduksjon');
INSERT INTO public.naring VALUES ('25.940', 'Produksjon av bolter og skruer', 'Bolte- og skrueproduksjon');
INSERT INTO public.naring VALUES ('25.990', 'Produksjon av metallvarer ikke nevnt annet sted', 'Metallvareprod. el.');
INSERT INTO public.naring VALUES ('26', 'Produksjon av datamaskiner og elektroniske og optiske produkter', 'Data- og elektronisk industri');
INSERT INTO public.naring VALUES ('26.1', 'Produksjon av elektroniske komponenter og kretskort', 'Elek. komponenter, kretskort');
INSERT INTO public.naring VALUES ('26.2', 'Produksjon av datamaskiner og tilleggsutstyr', 'Prod. datamaskiner og tilleggsutstyr');
INSERT INTO public.naring VALUES ('26.3', 'Produksjon av kommunikasjonsutstyr', 'Prod. av kommunikasjonsutstyr');
INSERT INTO public.naring VALUES ('26.4', 'Produksjon av elektronikk til husholdningsbruk', 'Prod. av husholdningselektronikk');
INSERT INTO public.naring VALUES ('26.5', 'Produksjon av måle-, kontroll- og navigasjonsinstrumenter, og klokker og ur', 'Måle- og kontrollinstrumenter');
INSERT INTO public.naring VALUES ('26.6', 'Produksjon av strålingsutstyr, elektromedisinsk og elektroterapeutisk utstyr', 'Elektromed./elektroterap. utst. mv.');
INSERT INTO public.naring VALUES ('26.7', 'Produksjon av optiske instrumenter og fotografisk utstyr', 'Optiske instr./fotografisk utstyr');
INSERT INTO public.naring VALUES ('26.8', 'Produksjon av magnetiske og optiske media', 'Magnetiske/optiske media');
INSERT INTO public.naring VALUES ('26.11', 'Produksjon av elektroniske komponenter', 'Prod. av elektroniske komponenter');
INSERT INTO public.naring VALUES ('26.12', 'Produksjon av kretskort', 'Produksjon av kretskort');
INSERT INTO public.naring VALUES ('26.20', 'Produksjon av datamaskiner og tilleggsutstyr', 'Prod. datamaskiner og tilleggsutstyr');
INSERT INTO public.naring VALUES ('26.30', 'Produksjon av kommunikasjonsutstyr', 'Prod. av kommunikasjonsutstyr');
INSERT INTO public.naring VALUES ('26.40', 'Produksjon av elektronikk til husholdningsbruk', 'Prod. av husholdningselektronikk');
INSERT INTO public.naring VALUES ('26.51', 'Produksjon av måle-, kontroll- og navigasjonsinstrumenter', 'Måle-, kontroll- og navig.instr.');
INSERT INTO public.naring VALUES ('26.52', 'Produksjon av klokker og ur', 'Klokke- og urproduksjon');
INSERT INTO public.naring VALUES ('26.60', 'Produksjon av strålingsutstyr, elektromedisinsk og elektroterapeutisk utstyr', 'Elektromed./elektroterap. utst. mv.');
INSERT INTO public.naring VALUES ('26.70', 'Produksjon av optiske instrumenter og fotografisk utstyr', 'Optiske instr./fotografisk utstyr');
INSERT INTO public.naring VALUES ('26.80', 'Produksjon av magnetiske og optiske media', 'Magnetiske/optiske media');
INSERT INTO public.naring VALUES ('26.110', 'Produksjon av elektroniske komponenter', 'Prod. av elektroniske komponenter');
INSERT INTO public.naring VALUES ('26.120', 'Produksjon av kretskort', 'Produksjon av kretskort');
INSERT INTO public.naring VALUES ('26.200', 'Produksjon av datamaskiner og tilleggsutstyr', 'Prod. datamaskiner og tilleggsutstyr');
INSERT INTO public.naring VALUES ('26.300', 'Produksjon av kommunikasjonsutstyr', 'Prod. av kommunikasjonsutstyr');
INSERT INTO public.naring VALUES ('26.400', 'Produksjon av elektronikk til husholdningsbruk', 'Prod. av husholdningselektronikk');
INSERT INTO public.naring VALUES ('26.510', 'Produksjon av måle-, kontroll- og navigasjonsinstrumenter', 'Måle-, kontroll- og navig.instr.');
INSERT INTO public.naring VALUES ('26.520', 'Produksjon av klokker og ur', 'Klokke- og urproduksjon');
INSERT INTO public.naring VALUES ('26.600', 'Produksjon av strålingsutstyr, elektromedisinsk og elektroterapeutisk utstyr', 'Elektromed./elektroterap. utst. mv.');
INSERT INTO public.naring VALUES ('26.700', 'Produksjon av optiske instrumenter og fotografisk utstyr', 'Optiske instr./fotografisk utstyr');
INSERT INTO public.naring VALUES ('26.800', 'Produksjon av magnetiske og optiske media', 'Magnetiske/optiske media');
INSERT INTO public.naring VALUES ('27', 'Produksjon av elektrisk utstyr', 'Elektroteknisk industri');
INSERT INTO public.naring VALUES ('27.1', 'Produksjon av elektromotorer, generatorer, transformatorer og elektriske fordelings- og kontrolltavler og paneler', 'Elektromotorer, generatorer mv.');
INSERT INTO public.naring VALUES ('27.2', 'Produksjon av batterier og akkumulatorer', 'Batterier, akkumulatorer');
INSERT INTO public.naring VALUES ('27.3', 'Produksjon av ledninger og ledningsmateriell', 'Ledninger og ledningsmateriell');
INSERT INTO public.naring VALUES ('27.4', 'Produksjon av belysningsutstyr', 'Prod. av belysningsutstyr');
INSERT INTO public.naring VALUES ('27.5', 'Produksjon av husholdningsmaskiner og -apparater', 'Husholdningsmaskinproduksjon');
INSERT INTO public.naring VALUES ('27.9', 'Produksjon av annet elektrisk utstyr', 'Produksjon elektrisk utstyr ellers');
INSERT INTO public.naring VALUES ('27.11', 'Produksjon av elektromotorer, generatorer og transformatorer', 'Elektromotor-, generatorprod. mv.');
INSERT INTO public.naring VALUES ('27.12', 'Produksjon av elektriske fordelings- og kontrolltavler og paneler', 'Elektriske tavler, paneler mv.');
INSERT INTO public.naring VALUES ('27.20', 'Produksjon av batterier og akkumulatorer', 'Batterier, akkumulatorer');
INSERT INTO public.naring VALUES ('27.31', 'Produksjon av optiske fiberkabler', 'Prod. av optiske fiberkabler');
INSERT INTO public.naring VALUES ('27.32', 'Produksjon av andre elektroniske og elektriske ledninger og kabler', 'Elektron./el. ledninger/kabler el.');
INSERT INTO public.naring VALUES ('27.33', 'Produksjon av ledningsmateriell', 'Prod. av ledningsmateriell');
INSERT INTO public.naring VALUES ('27.40', 'Produksjon av belysningsutstyr', 'Prod. av belysningsutstyr');
INSERT INTO public.naring VALUES ('27.51', 'Produksjon av elektriske husholdningsmaskiner og apparater', 'Elektr. hush.maskin-/apparatprod.');
INSERT INTO public.naring VALUES ('27.52', 'Produksjon av ikke-elektriske husholdningsmaskiner og apparater', 'Ikke-el. hush.mask.-/apparatprod.');
INSERT INTO public.naring VALUES ('27.90', 'Produksjon av annet elektrisk utstyr', 'Produksjon elektrisk utstyr ellers');
INSERT INTO public.naring VALUES ('27.110', 'Produksjon av elektromotorer, generatorer og transformatorer', 'Elektromotor-, generatorprod. mv.');
INSERT INTO public.naring VALUES ('27.120', 'Produksjon av elektriske fordelings- og kontrolltavler og paneler', 'Elektriske tavler, paneler mv.');
INSERT INTO public.naring VALUES ('27.200', 'Produksjon av batterier og akkumulatorer', 'Batterier, akkumulatorer');
INSERT INTO public.naring VALUES ('27.310', 'Produksjon av optiske fiberkabler', 'Prod. av optiske fiberkabler');
INSERT INTO public.naring VALUES ('27.320', 'Produksjon av andre elektroniske og elektriske ledninger og kabler', 'Elektron./el. ledninger/kabler el.');
INSERT INTO public.naring VALUES ('27.330', 'Produksjon av ledningsmateriell', 'Prod. av ledningsmateriell');
INSERT INTO public.naring VALUES ('27.400', 'Produksjon av belysningsutstyr', 'Prod. av belysningsutstyr');
INSERT INTO public.naring VALUES ('27.510', 'Produksjon av elektriske husholdningsmaskiner og apparater', 'Elektr. hush.maskin-/apparatprod.');
INSERT INTO public.naring VALUES ('27.520', 'Produksjon av ikke-elektriske husholdningsmaskiner og apparater', 'Ikke-el. hush.mask.-/apparatprod.');
INSERT INTO public.naring VALUES ('27.900', 'Produksjon av annet elektrisk utstyr', 'Produksjon elektrisk utstyr ellers');
INSERT INTO public.naring VALUES ('28', 'Produksjon av maskiner og utstyr til generell bruk, ikke nevnt annet sted', 'Maskinindustri');
INSERT INTO public.naring VALUES ('28.1', 'Produksjon av maskiner og utstyr til generell bruk', 'Prod. mask. og utstyr generell bruk');
INSERT INTO public.naring VALUES ('28.2', 'Produksjon av andre maskiner og annet utstyr til generell bruk', 'Annen maskinprod. for generell bruk');
INSERT INTO public.naring VALUES ('28.3', 'Produksjon av jordbruks- og skogbruksmaskiner', 'Jord- og skogbruksmaskinproduksjon');
INSERT INTO public.naring VALUES ('28.4', 'Produksjon av maskiner til metallbearbeiding og annet maskinverktøy', 'Mask.verktøy til metallbearb. mv.');
INSERT INTO public.naring VALUES ('28.9', 'Produksjon av andre spesialmaskiner', 'Produksjon av andre spesialmaskiner');
INSERT INTO public.naring VALUES ('28.11', 'Produksjon av motorer og turbiner, unntatt motorer til luftfartøyer og motorvogner', 'Skipsmotor-/motor- og turbinprod. el.');
INSERT INTO public.naring VALUES ('28.12', 'Produksjon av komponenter til hydraulisk og pneumatisk utstyr', 'Komp. til hydraul./pneumatisk utstyr');
INSERT INTO public.naring VALUES ('28.13', 'Produksjon av pumper og kompressorer ellers', 'Pumpe- og kompressorprod. el.');
INSERT INTO public.naring VALUES ('28.14', 'Produksjon av kraner og ventiler ellers', 'Kran- og ventilproduksjon el.');
INSERT INTO public.naring VALUES ('28.15', 'Produksjon av lagre, gir, tannhjulsutvekslinger og andre innretninger for kraftoverføring', 'Lager-, girproduksjon mv.');
INSERT INTO public.naring VALUES ('28.21', 'Produksjon av industri- og laboratorieovner samt brennere', 'Industri- og laboratorieovnprod.');
INSERT INTO public.naring VALUES ('28.22', 'Produksjon av løfte- og håndteringsutstyr', 'Løfte- og håndteringsutstyr');
INSERT INTO public.naring VALUES ('28.23', 'Produksjon av kontormaskiner og utstyr (unntatt datamaskiner og tilleggsutstyr)', 'Kontormaskinproduksjon');
INSERT INTO public.naring VALUES ('28.24', 'Produksjon av motordrevet håndverktøy', 'Prod. av motordrevet håndverktøy');
INSERT INTO public.naring VALUES ('28.25', 'Produksjon av kjøle- og ventilasjonsanlegg, unntatt til husholdningsbruk', 'Kjøle- og ventilasjonsanleggprod.');
INSERT INTO public.naring VALUES ('28.29', 'Produksjon av maskiner og utstyr til generell bruk, ikke nevnt annet sted', 'Maskiner og utstyr til gen. bruk el.');
INSERT INTO public.naring VALUES ('28.30', 'Produksjon av jordbruks- og skogbruksmaskiner', 'Jord- og skogbruksmaskinproduksjon');
INSERT INTO public.naring VALUES ('28.41', 'Produksjon av maskinverktøy til metallbearbeiding', 'Maskinverktøy til metallbearb.');
INSERT INTO public.naring VALUES ('28.49', 'Produksjon av maskinverktøy ikke nevnt annet sted', 'Prod. av maskinverktøy el.');
INSERT INTO public.naring VALUES ('28.91', 'Produksjon av maskiner og utstyr til metallurgisk industri', 'Mask./utstyr metallurgisk industri');
INSERT INTO public.naring VALUES ('28.92', 'Produksjon av maskiner og utstyr til bergverksdrift og bygge- og anleggsvirksomhet', 'Mask./utstyr bergverk, bygg og anl.');
INSERT INTO public.naring VALUES ('28.93', 'Produksjon av maskiner og utstyr til nærings- og nytelsesmiddelindustri', 'Mask./utstyr næringsmiddelindustri');
INSERT INTO public.naring VALUES ('28.94', 'Produksjon av maskiner og utstyr til tekstil-, konfeksjons- og lærvareindustri', 'Mask./utstyr tekstilindustri');
INSERT INTO public.naring VALUES ('28.95', 'Produksjon av maskiner og utstyr til papir- og pappvareindustri', 'Mask./utstyr papir- og pappvareindustri');
INSERT INTO public.naring VALUES ('28.96', 'Produksjon av maskiner og utstyr til plast- og gummiindustri', 'Mask./utstyr plast- og gummiindustri');
INSERT INTO public.naring VALUES ('28.99', 'Produksjon av spesialmaskiner ikke nevnt annet sted', 'Spesialmaskinproduksjon el.');
INSERT INTO public.naring VALUES ('28.110', 'Produksjon av motorer og turbiner, unntatt motorer til luftfartøyer og motorvogner', 'Skipsmotor-/motor- og turbinprod. el.');
INSERT INTO public.naring VALUES ('28.120', 'Produksjon av komponenter til hydraulisk og pneumatisk utstyr', 'Komp. til hydraul./pneumatisk utstyr');
INSERT INTO public.naring VALUES ('28.130', 'Produksjon av pumper og kompressorer ellers', 'Pumpe- og kompressorprod. el.');
INSERT INTO public.naring VALUES ('28.140', 'Produksjon av kraner og ventiler ellers', 'Kran- og ventilproduksjon el.');
INSERT INTO public.naring VALUES ('28.150', 'Produksjon av lagre, gir, tannhjulsutvekslinger og andre innretninger for kraftoverføring', 'Lager-, girproduksjon mv.');
INSERT INTO public.naring VALUES ('28.210', 'Produksjon av industri- og laboratorieovner samt brennere', 'Industri- og laboratorieovnprod.');
INSERT INTO public.naring VALUES ('28.221', 'Produksjon av løfte- og håndteringsutstyr til skip og båter', 'Løfteutstyr m.m. for skip og båter');
INSERT INTO public.naring VALUES ('28.229', 'Produksjon av løfte- og håndteringsutstyr ellers', 'Løfte- og håndteringsutstyr el.');
INSERT INTO public.naring VALUES ('28.230', 'Produksjon av kontormaskiner og utstyr (unntatt datamaskiner og tilleggsutstyr)', 'Kontormaskinproduksjon');
INSERT INTO public.naring VALUES ('28.240', 'Produksjon av motordrevet håndverktøy', 'Prod. av motordrevet håndverktøy');
INSERT INTO public.naring VALUES ('28.250', 'Produksjon av kjøle- og ventilasjonsanlegg, unntatt til husholdningsbruk', 'Kjøle- og ventilasjonsanleggprod.');
INSERT INTO public.naring VALUES ('28.290', 'Produksjon av maskiner og utstyr til generell bruk, ikke nevnt annet sted', 'Maskiner og utstyr til gen. bruk el.');
INSERT INTO public.naring VALUES ('28.300', 'Produksjon av jordbruks- og skogbruksmaskiner', 'Jord- og skogbruksmaskinproduksjon');
INSERT INTO public.naring VALUES ('28.410', 'Produksjon av maskinverktøy til metallbearbeiding', 'Maskinverktøy til metallbearb.');
INSERT INTO public.naring VALUES ('28.490', 'Produksjon av maskinverktøy ikke nevnt annet sted', 'Prod. av maskinverktøy el.');
INSERT INTO public.naring VALUES ('28.910', 'Produksjon av maskiner og utstyr til metallurgisk industri', 'Mask./utstyr metallurgisk industri');
INSERT INTO public.naring VALUES ('28.920', 'Produksjon av maskiner og utstyr til bergverksdrift og bygge- og anleggsvirksomhet', 'Mask./utstyr bergverk, bygg og anl.');
INSERT INTO public.naring VALUES ('28.930', 'Produksjon av maskiner og utstyr til nærings- og nytelsesmiddelindustri', 'Mask./utstyr næringsmiddelindustri');
INSERT INTO public.naring VALUES ('28.940', 'Produksjon av maskiner og utstyr til tekstil-, konfeksjons- og lærvareindustri', 'Mask./utstyr tekstilindustri');
INSERT INTO public.naring VALUES ('28.950', 'Produksjon av maskiner og utstyr til papir- og pappvareindustri', 'Mask./utstyr papir- og pappvareindustri');
INSERT INTO public.naring VALUES ('28.960', 'Produksjon av maskiner og utstyr til plast- og gummiindustri', 'Mask./utstyr plast- og gummiindustri');
INSERT INTO public.naring VALUES ('28.990', 'Produksjon av spesialmaskiner ikke nevnt annet sted', 'Spesialmaskinproduksjon el.');
INSERT INTO public.naring VALUES ('29', 'Produksjon av motorvogner og tilhengere', 'Motorkjøretøyindustri');
INSERT INTO public.naring VALUES ('29.1', 'Produksjon av motorvogner', 'Motorvognproduksjon');
INSERT INTO public.naring VALUES ('29.2', 'Produksjon av karosserier og tilhengere', 'Karosseri- og tilhengerproduksjon');
INSERT INTO public.naring VALUES ('29.3', 'Produksjon av deler og utstyr til motorvogner', 'Utstyr- og delprod. motorvogner');
INSERT INTO public.naring VALUES ('29.10', 'Produksjon av motorvogner', 'Motorvognproduksjon');
INSERT INTO public.naring VALUES ('29.20', 'Produksjon av karosserier og tilhengere', 'Karosseri- og tilhengerproduksjon');
INSERT INTO public.naring VALUES ('29.31', 'Produksjon av elektrisk og elektronisk utstyr til motorvogner', 'Elektrisk/elektron. utstyr motorv.');
INSERT INTO public.naring VALUES ('29.32', 'Produksjon av andre deler og annet utstyr til motorvogner', 'Annet utstyr-/delprod. til motorv.');
INSERT INTO public.naring VALUES ('29.100', 'Produksjon av motorvogner', 'Motorvognproduksjon');
INSERT INTO public.naring VALUES ('29.200', 'Produksjon av karosserier og tilhengere', 'Karosseri- og tilhengerproduksjon');
INSERT INTO public.naring VALUES ('29.310', 'Produksjon av elektrisk og elektronisk utstyr til motorvogner', 'Elektrisk/elektron. utstyr motorv.');
INSERT INTO public.naring VALUES ('29.320', 'Produksjon av andre deler og annet utstyr til motorvogner', 'Annet utstyr-/delprod. til motorv.');
INSERT INTO public.naring VALUES ('30', 'Produksjon av andre transportmidler', 'Transportmiddelindustri ellers');
INSERT INTO public.naring VALUES ('30.1', 'Bygging av skip og båter', 'Bygging av skip og oljeplattformer');
INSERT INTO public.naring VALUES ('30.2', 'Produksjon av lokomotiver og annet rullende materiell til jernbane og sporvei', 'Jernbane- og sporvognmateriell mv.');
INSERT INTO public.naring VALUES ('30.3', 'Produksjon av luftfartøyer og romfartøyer og lignende utstyr', 'Prod. luft- og romfartøy og lignende');
INSERT INTO public.naring VALUES ('30.4', 'Produksjon av militære stridskjøretøyer', 'Produksjon militære stridskjøretøy');
INSERT INTO public.naring VALUES ('30.9', 'Produksjon av transportmidler ikke nevnt annet sted', 'Produksjon transportmidler ellers');
INSERT INTO public.naring VALUES ('30.11', 'Bygging av skip og flytende materiell', 'Bygg av skip og flytende materiell');
INSERT INTO public.naring VALUES ('30.12', 'Bygging av fritidsbåter', 'Bygging av fritidsbåter');
INSERT INTO public.naring VALUES ('30.20', 'Produksjon av lokomotiver og annet rullende materiell til jernbane og sporvei', 'Jernbane- og sporvognmateriell mv.');
INSERT INTO public.naring VALUES ('30.30', 'Produksjon av luftfartøyer og romfartøyer og lignende utstyr', 'Prod. luft- og romfartøy og lignende');
INSERT INTO public.naring VALUES ('30.40', 'Produksjon av militære stridskjøretøyer', 'Produksjon militære stridskjøretøy');
INSERT INTO public.naring VALUES ('30.91', 'Produksjon av motorsykler', 'Motorsykkelproduksjon');
INSERT INTO public.naring VALUES ('68.310', 'Eiendomsmegling', 'Eiendomsmegling');
INSERT INTO public.naring VALUES ('30.92', 'Produksjon av sykler og invalidevogner', 'Sykkel- og invalidevognprod.');
INSERT INTO public.naring VALUES ('30.99', 'Produksjon av andre transportmidler ikke nevnt annet sted', 'Transportmiddelproduksjon el.');
INSERT INTO public.naring VALUES ('30.111', 'Bygging av skip og skrog over 100 br.tonn', 'Bygg. av skip/skrog over 100 br.tonn');
INSERT INTO public.naring VALUES ('30.112', 'Bygging av skip under 100 br.tonn', 'Bygg. av skip under 100 br.tonn');
INSERT INTO public.naring VALUES ('30.113', 'Bygging av oljeplattformer og moduler', 'Bygging oljeplattformer, moduler');
INSERT INTO public.naring VALUES ('30.114', 'Produksjon av annet flytende materiell', 'Annen flytende materiellproduksjon');
INSERT INTO public.naring VALUES ('30.115', 'Innrednings- og installasjonsarbeid utført på skip over 100 br.tonn', 'Install. m.m. på skip over 100 br.t.');
INSERT INTO public.naring VALUES ('30.116', 'Innrednings- og installasjonsarbeid utført på oljeplattformer og moduler', 'Install. m.m. på oljepl./moduler');
INSERT INTO public.naring VALUES ('30.120', 'Bygging av fritidsbåter', 'Bygging av fritidsbåter');
INSERT INTO public.naring VALUES ('30.200', 'Produksjon av lokomotiver og annet rullende materiell til jernbane og sporvei', 'Jernbane- og sporvognmateriell mv.');
INSERT INTO public.naring VALUES ('30.300', 'Produksjon av luftfartøyer og romfartøyer og lignende utstyr', 'Prod. luft- og romfartøy og lignende');
INSERT INTO public.naring VALUES ('30.400', 'Produksjon av militære stridskjøretøyer', 'Produksjon militære stridskjøretøy');
INSERT INTO public.naring VALUES ('30.910', 'Produksjon av motorsykler', 'Motorsykkelproduksjon');
INSERT INTO public.naring VALUES ('30.920', 'Produksjon av sykler og invalidevogner', 'Sykkel- og invalidevognprod.');
INSERT INTO public.naring VALUES ('30.990', 'Produksjon av andre transportmidler ikke nevnt annet sted', 'Transportmiddelproduksjon el.');
INSERT INTO public.naring VALUES ('31', 'Produksjon av møbler', 'Møbelindustri');
INSERT INTO public.naring VALUES ('31.0', 'Produksjon av møbler', 'Produksjon av møbler');
INSERT INTO public.naring VALUES ('31.01', 'Produksjon av kontor- og butikkmøbler', 'Kontor- og butikkmøbelprod.');
INSERT INTO public.naring VALUES ('31.02', 'Produksjon av kjøkkenmøbler', 'Kjøkkenmøbelproduksjon');
INSERT INTO public.naring VALUES ('31.03', 'Produksjon av madrasser', 'Madrassproduksjon');
INSERT INTO public.naring VALUES ('31.09', 'Produksjon av møbler ellers', 'Møbelproduksjon el.');
INSERT INTO public.naring VALUES ('31.010', 'Produksjon av kontor- og butikkmøbler', 'Kontor- og butikkmøbelprod.');
INSERT INTO public.naring VALUES ('31.020', 'Produksjon av kjøkkenmøbler', 'Kjøkkenmøbelproduksjon');
INSERT INTO public.naring VALUES ('31.030', 'Produksjon av madrasser', 'Madrassproduksjon');
INSERT INTO public.naring VALUES ('31.090', 'Produksjon av møbler ellers', 'Møbelproduksjon el.');
INSERT INTO public.naring VALUES ('32', 'Annen industriproduksjon', 'Annen industri');
INSERT INTO public.naring VALUES ('32.1', 'Produksjon av gull- og sølvvarer, bijouteri og lignende artikler', 'Produksjon gull- og sølvvarer mv.');
INSERT INTO public.naring VALUES ('32.2', 'Produksjon av musikkinstrumenter', 'Musikkinstrumentproduksjon');
INSERT INTO public.naring VALUES ('32.3', 'Produksjon av sportsartikler', 'Sportsartikkelproduksjon');
INSERT INTO public.naring VALUES ('32.4', 'Produksjon av spill og leker', 'Spill- og leketøyproduksjon');
INSERT INTO public.naring VALUES ('32.5', 'Produksjon av medisinske og tanntekniske instrumenter og utstyr', 'Medisinske og tanntekniske instr.');
INSERT INTO public.naring VALUES ('32.9', 'Industriproduksjon ikke nevnt annet sted', 'Industriproduksjon el.');
INSERT INTO public.naring VALUES ('32.11', 'Preging av mynter og medaljer', 'Mynt- og medaljepreging');
INSERT INTO public.naring VALUES ('32.12', 'Produksjon av gull- og sølvvarer og lignende artikler', 'Gull- og sølvvareprod. mv.');
INSERT INTO public.naring VALUES ('32.13', 'Produksjon av bijouteri og lignende artikler', 'Bijouterivareproduksjon mv.');
INSERT INTO public.naring VALUES ('32.20', 'Produksjon av musikkinstrumenter', 'Musikkinstrumentproduksjon');
INSERT INTO public.naring VALUES ('32.30', 'Produksjon av sportsartikler', 'Sportsartikkelproduksjon');
INSERT INTO public.naring VALUES ('32.40', 'Produksjon av spill og leker', 'Spill- og leketøyproduksjon');
INSERT INTO public.naring VALUES ('32.50', 'Produksjon av medisinske og tanntekniske instrumenter og utstyr', 'Medisinske og tanntekniske instr.');
INSERT INTO public.naring VALUES ('32.91', 'Produksjon av koster og børster', 'Kost- og børsteproduksjon');
INSERT INTO public.naring VALUES ('32.99', 'Annen industriproduksjon ikke nevnt annet sted', 'Industriproduksjon ellers');
INSERT INTO public.naring VALUES ('32.110', 'Preging av mynter og medaljer', 'Mynt- og medaljepreging');
INSERT INTO public.naring VALUES ('32.120', 'Produksjon av gull- og sølvvarer og lignende artikler', 'Gull- og sølvvareprod. mv.');
INSERT INTO public.naring VALUES ('32.130', 'Produksjon av bijouteri og lignende artikler', 'Bijouterivareproduksjon mv.');
INSERT INTO public.naring VALUES ('32.200', 'Produksjon av musikkinstrumenter', 'Musikkinstrumentproduksjon');
INSERT INTO public.naring VALUES ('32.300', 'Produksjon av sportsartikler', 'Sportsartikkelproduksjon');
INSERT INTO public.naring VALUES ('32.400', 'Produksjon av spill og leker', 'Spill- og leketøyproduksjon');
INSERT INTO public.naring VALUES ('32.500', 'Produksjon av medisinske og tanntekniske instrumenter og utstyr', 'Medisinske og tanntekniske instr.');
INSERT INTO public.naring VALUES ('32.910', 'Produksjon av koster og børster', 'Kost- og børsteproduksjon');
INSERT INTO public.naring VALUES ('32.990', 'Annen industriproduksjon ikke nevnt annet sted', 'Industriproduksjon ellers');
INSERT INTO public.naring VALUES ('33', 'Reparasjon og installasjon av maskiner og utstyr', 'Maskinreparasjon og -installasjon');
INSERT INTO public.naring VALUES ('33.1', 'Reparasjon av metallvarer, maskiner og utstyr', 'Reparasjon metallvarer, maskiner mv.');
INSERT INTO public.naring VALUES ('33.2', 'Installasjon av industrimaskiner og -utstyr', 'Installasjon industrimask., utstyr');
INSERT INTO public.naring VALUES ('33.11', 'Reparasjon av bearbeidede metallprodukter', 'Rep. av bearbeidede metallprodukter');
INSERT INTO public.naring VALUES ('33.12', 'Reparasjon av maskiner', 'Reparasjon av maskiner');
INSERT INTO public.naring VALUES ('33.13', 'Reparasjon av elektronisk og optisk utstyr', 'Rep. av elektronisk og optisk utstyr');
INSERT INTO public.naring VALUES ('33.14', 'Reparasjon av elektrisk utstyr', 'Rep. av elektrisk utstyr');
INSERT INTO public.naring VALUES ('33.15', 'Reparasjon og vedlikehold av skip og båter', 'Rep./vedlikehold av skip og båter');
INSERT INTO public.naring VALUES ('33.16', 'Reparasjon og vedlikehold av luftfartøyer og romfartøyer', 'Rep./vedlikeh. luft- og romfartøyer');
INSERT INTO public.naring VALUES ('33.17', 'Reparasjon og vedlikehold av andre transportmidler', 'Rep./vedlikeh. av andre transportmidler');
INSERT INTO public.naring VALUES ('33.19', 'Reparasjon av annet utstyr', 'Rep. av annet utstyr');
INSERT INTO public.naring VALUES ('33.20', 'Installasjon av industrimaskiner og -utstyr', 'Installasjon industrimask. og utstyr');
INSERT INTO public.naring VALUES ('33.110', 'Reparasjon av bearbeidede metallprodukter', 'Rep. av bearbeidede metallprodukter');
INSERT INTO public.naring VALUES ('33.120', 'Reparasjon av maskiner', 'Reparasjon av maskiner');
INSERT INTO public.naring VALUES ('33.130', 'Reparasjon av elektronisk og optisk utstyr', 'Rep. av elektronisk og optisk utstyr');
INSERT INTO public.naring VALUES ('33.140', 'Reparasjon av elektrisk utstyr', 'Rep. av elektrisk utstyr');
INSERT INTO public.naring VALUES ('33.150', 'Reparasjon og vedlikehold av skip og båter', 'Rep./vedlikehold av skip og båter');
INSERT INTO public.naring VALUES ('33.160', 'Reparasjon og vedlikehold av luftfartøyer og romfartøyer', 'Rep./vedlikeh. luft- og romfartøyer');
INSERT INTO public.naring VALUES ('33.170', 'Reparasjon og vedlikehold av andre transportmidler', 'Rep./vedlikeh. av andre transportmidler');
INSERT INTO public.naring VALUES ('33.190', 'Reparasjon av annet utstyr', 'Rep. av annet utstyr');
INSERT INTO public.naring VALUES ('33.200', 'Installasjon av industrimaskiner og -utstyr', 'Installasjon industrimask. og utstyr');
INSERT INTO public.naring VALUES ('35', 'Elektrisitets-, gass-, damp- og varmtvannsforsyning', 'Kraftforsyning');
INSERT INTO public.naring VALUES ('35.1', 'Produksjon, overføring og distribusjon av elektrisitet', 'El.prod., overføring og distrib.');
INSERT INTO public.naring VALUES ('35.2', 'Produksjon av gass og distribusjon av gass gjennom ledningsnett', 'Produksjon gass gj. ledningsnett');
INSERT INTO public.naring VALUES ('35.3', 'Damp- og varmtvannsforsyning', 'Damp- og varmtvannsforsyning');
INSERT INTO public.naring VALUES ('35.11', 'Produksjon av elektrisitet', 'Produksjon av elektrisitet');
INSERT INTO public.naring VALUES ('35.12', 'Overføring av elektrisitet', 'Overføring av elektrisitet');
INSERT INTO public.naring VALUES ('35.13', 'Distribusjon av elektrisitet', 'Distribusjon av elektrisitet');
INSERT INTO public.naring VALUES ('35.14', 'Handel med elektrisitet', 'Handel med elektrisitet');
INSERT INTO public.naring VALUES ('35.21', 'Produksjon av gass', 'Gassproduksjon');
INSERT INTO public.naring VALUES ('35.22', 'Distribusjon av gass gjennom ledningsnett', 'Gassdistrib. via. ledningsnett');
INSERT INTO public.naring VALUES ('35.23', 'Handel med gass gjennom ledningsnett', 'Handel med gass via ledningsnett');
INSERT INTO public.naring VALUES ('35.30', 'Damp- og varmtvannsforsyning', 'Damp- og varmtvannsforsyning');
INSERT INTO public.naring VALUES ('35.111', 'Produksjon av elektrisitet fra vannkraft', 'Elektrisitetsprod. fra vannkraft');
INSERT INTO public.naring VALUES ('35.112', 'Produksjon av elektrisitet fra vindkraft', 'Elektrisitetsprod. fra vindkraft');
INSERT INTO public.naring VALUES ('35.113', 'Produksjon av elektrisitet fra biobrensel', 'El. fra biobrensel');
INSERT INTO public.naring VALUES ('35.114', 'Produksjon av elektrisitet fra naturgass', 'Elektrisitetsprod. fra naturgass');
INSERT INTO public.naring VALUES ('35.119', 'Produksjon av elektrisitet ellers', 'Elektrisitetsprod. ellers');
INSERT INTO public.naring VALUES ('35.120', 'Overføring av elektrisitet', 'Overføring av elektrisitet');
INSERT INTO public.naring VALUES ('35.130', 'Distribusjon av elektrisitet', 'Distribusjon av elektrisitet');
INSERT INTO public.naring VALUES ('35.140', 'Handel med elektrisitet', 'Handel med elektrisitet');
INSERT INTO public.naring VALUES ('35.210', 'Produksjon av gass', 'Gassproduksjon');
INSERT INTO public.naring VALUES ('35.220', 'Distribusjon av gass gjennom ledningsnett', 'Gassdistrib. via ledningsnett');
INSERT INTO public.naring VALUES ('35.230', 'Handel med gass gjennom ledningsnett', 'Handel med gass via ledningsnett');
INSERT INTO public.naring VALUES ('35.300', 'Damp- og varmtvannsforsyning', 'Damp- og varmtvannsforsyning');
INSERT INTO public.naring VALUES ('36', 'Uttak fra kilde, rensing og distribusjon av vann', 'Vannforsyning');
INSERT INTO public.naring VALUES ('36.0', 'Uttak fra kilde, rensing og distribusjon av vann', 'Vannforsyning');
INSERT INTO public.naring VALUES ('36.00', 'Uttak fra kilde, rensing og distribusjon av vann', 'Vannforsyning');
INSERT INTO public.naring VALUES ('36.000', 'Uttak fra kilde, rensing og distribusjon av vann', 'Vannforsyning');
INSERT INTO public.naring VALUES ('37', 'Oppsamling og behandling av avløpsvann', 'Håndtering av avløpsvann');
INSERT INTO public.naring VALUES ('37.0', 'Oppsamling og behandling av avløpsvann', 'Håndtering av avløpsvann');
INSERT INTO public.naring VALUES ('37.00', 'Oppsamling og behandling av avløpsvann', 'Håndtering av avløpsvann');
INSERT INTO public.naring VALUES ('37.000', 'Oppsamling og behandling av avløpsvann', 'Håndtering av avløpsvann');
INSERT INTO public.naring VALUES ('38', 'Innsamling, behandling, disponering og gjenvinning av avfall', 'Avfallshåndtering');
INSERT INTO public.naring VALUES ('38.1', 'Innsamling av avfall', 'Innsamling av avfall');
INSERT INTO public.naring VALUES ('38.2', 'Behandling og disponering av avfall', 'Behandl. og disponering av avfall');
INSERT INTO public.naring VALUES ('38.3', 'Materialgjenvinning', 'Materialgjenvinning');
INSERT INTO public.naring VALUES ('38.11', 'Innsamling av ikke-farlig avfall', 'Innsaml. av ikke-farlig avfall');
INSERT INTO public.naring VALUES ('38.12', 'Innsamling av farlig avfall', 'Innsamling av farlig avfall');
INSERT INTO public.naring VALUES ('38.21', 'Behandling og disponering av ikke-farlig avfall', 'Behandl. og disp. av ikke-farlig avfall');
INSERT INTO public.naring VALUES ('38.22', 'Behandling og disponering av farlig avfall', 'Behandl. og disp. av farlig avfall');
INSERT INTO public.naring VALUES ('38.31', 'Demontering av vrakede gjenstander', 'Demont. av vrakede gjenstander');
INSERT INTO public.naring VALUES ('38.32', 'Sortering og bearbeiding av avfall for materialgjenvinning', 'Sort./bearb. avfall for matr.gjenv.');
INSERT INTO public.naring VALUES ('38.110', 'Innsamling av ikke-farlig avfall', 'Innsaml. av ikke-farlig avfall');
INSERT INTO public.naring VALUES ('38.120', 'Innsamling av farlig avfall', 'Innsamling av farlig avfall');
INSERT INTO public.naring VALUES ('38.210', 'Behandling og disponering av ikke-farlig avfall', 'Behandl. og disp. av ikke-farlig avfall');
INSERT INTO public.naring VALUES ('38.220', 'Behandling og disponering av farlig avfall', 'Behandl. og disp. av farlig avfall');
INSERT INTO public.naring VALUES ('38.310', 'Demontering av vrakede gjenstander', 'Demont. av vrakede gjenstander');
INSERT INTO public.naring VALUES ('38.320', 'Sortering og bearbeiding av avfall for materialgjenvinning', 'Sort./bearb. avfall for matr.gjenv.');
INSERT INTO public.naring VALUES ('39', 'Miljørydding, miljørensing og lignende virksomhet', 'Miljørydding og miljørensing');
INSERT INTO public.naring VALUES ('39.0', 'Miljørydding, miljørensing og lignende virksomhet', 'Miljørydding og miljørensing');
INSERT INTO public.naring VALUES ('39.00', 'Miljørydding, miljørensing og lignende virksomhet', 'Miljørydding og miljørensing');
INSERT INTO public.naring VALUES ('39.000', 'Miljørydding, miljørensing og lignende virksomhet', 'Miljørydding og miljørensing');
INSERT INTO public.naring VALUES ('41', 'Oppføring av bygninger', 'Oppføring av bygninger');
INSERT INTO public.naring VALUES ('41.1', 'Utvikling av byggeprosjekter', 'Utvikling av byggeprosjekter');
INSERT INTO public.naring VALUES ('41.2', 'Oppføring av bygninger', 'Oppføring av bygninger');
INSERT INTO public.naring VALUES ('41.10', 'Utvikling av byggeprosjekter', 'Utvikling av byggeprosjekter');
INSERT INTO public.naring VALUES ('41.20', 'Oppføring av bygninger', 'Oppføring av bygninger');
INSERT INTO public.naring VALUES ('41.101', 'Boligbyggelag', 'Boligbyggelag');
INSERT INTO public.naring VALUES ('41.109', 'Utvikling og salg av egen fast eiendom ellers', 'Utvikl./salg av egen fast eiendom');
INSERT INTO public.naring VALUES ('41.200', 'Oppføring av bygninger', 'Oppføring av bygninger');
INSERT INTO public.naring VALUES ('42', 'Anleggsvirksomhet', 'Anleggsvirksomhet');
INSERT INTO public.naring VALUES ('42.1', 'Bygging av veier og jernbaner', 'Bygging av veier og jernbaner');
INSERT INTO public.naring VALUES ('42.2', 'Bygging av vann- og kloakkanlegg, og anlegg for elektrisitet og telekommunikasjon', 'Vann-/kloakk-, el-. og telekom. anl.');
INSERT INTO public.naring VALUES ('42.9', 'Bygging av andre anlegg', 'Bygging av andre anlegg');
INSERT INTO public.naring VALUES ('42.11', 'Bygging av veier og motorveier', 'Bygging av veier og motorveier');
INSERT INTO public.naring VALUES ('42.12', 'Bygging av jernbaner og undergrunnsbaner', 'Bygg. av jernbaner/undergrunnsbaner');
INSERT INTO public.naring VALUES ('42.13', 'Bygging av bruer og tunneler', 'Bygging av bruer og tunneler');
INSERT INTO public.naring VALUES ('42.21', 'Bygging av vann- og kloakkanlegg', 'Bygging av vann- og kloakkanl.');
INSERT INTO public.naring VALUES ('42.22', 'Bygging av anlegg for elektrisitet og telekommunikasjon', 'Bygg. av el.anl. og telekomm.anl.');
INSERT INTO public.naring VALUES ('42.91', 'Bygging av havne- og damanlegg', 'Bygging av havne- og damanlegg');
INSERT INTO public.naring VALUES ('42.99', 'Bygging av andre anlegg ikke nevnt annet sted', 'Bygging av andre anlegg');
INSERT INTO public.naring VALUES ('42.110', 'Bygging av veier og motorveier', 'Bygging av veier og motorveier');
INSERT INTO public.naring VALUES ('42.120', 'Bygging av jernbaner og undergrunnsbaner', 'Bygg. av jernbaner/undergrunnsbaner');
INSERT INTO public.naring VALUES ('42.130', 'Bygging av bruer og tunneler', 'Bygging av bruer og tunneler');
INSERT INTO public.naring VALUES ('42.210', 'Bygging av vann- og kloakkanlegg', 'Bygging av vann- og kloakkanl.');
INSERT INTO public.naring VALUES ('42.220', 'Bygging av anlegg for elektrisitet og telekommunikasjon', 'Bygg. av el.anl. og telekomm.anl.');
INSERT INTO public.naring VALUES ('42.910', 'Bygging av havne- og damanlegg', 'Bygging av havne- og damanlegg');
INSERT INTO public.naring VALUES ('42.990', 'Bygging av andre anlegg ikke nevnt annet sted', 'Bygging av andre anlegg');
INSERT INTO public.naring VALUES ('43', 'Spesialisert bygge- og anleggsvirksomhet', 'Spes. bygge- og anleggsvirksomhet');
INSERT INTO public.naring VALUES ('43.1', 'Riving og grunnarbeid', 'Riving og grunnarbeid');
INSERT INTO public.naring VALUES ('43.2', 'Elektrisk installasjonsarbeid, VVS-arbeid og annet installasjonsarbeid', 'El. install., VVS, annet installarb.');
INSERT INTO public.naring VALUES ('43.3', 'Ferdiggjøring av bygninger', 'Ferdiggjøring av bygninger');
INSERT INTO public.naring VALUES ('43.9', 'Annen spesialisert bygge- og anleggsvirksomhet', 'Annen spes. bygge- og anleggsvirks.');
INSERT INTO public.naring VALUES ('43.11', 'Riving av bygninger og andre konstruksjoner', 'Riv. av bygn./andre konstruksjoner');
INSERT INTO public.naring VALUES ('43.12', 'Grunnarbeid', 'Grunnarbeid');
INSERT INTO public.naring VALUES ('43.13', 'Prøveboring', 'Prøveboring');
INSERT INTO public.naring VALUES ('43.21', 'Elektrisk installasjonsarbeid', 'Elektrisk installasjonsarbeid');
INSERT INTO public.naring VALUES ('43.22', 'VVS-arbeid', 'VVS-arbeid');
INSERT INTO public.naring VALUES ('43.29', 'Annet installasjonsarbeid', 'Annet installasjonsarbeid');
INSERT INTO public.naring VALUES ('43.31', 'Stukkatørarbeid og pussing', 'Stukkatørarbeid og pussing');
INSERT INTO public.naring VALUES ('43.32', 'Snekkerarbeid', 'Snekkerarbeid');
INSERT INTO public.naring VALUES ('43.33', 'Gulvlegging og tapetsering', 'Gulvlegging og tapetsering');
INSERT INTO public.naring VALUES ('43.34', 'Maler- og glassarbeid', 'Maler- og glassarbeid');
INSERT INTO public.naring VALUES ('43.39', 'Annen ferdiggjøring av bygninger', 'Annen ferdiggjøring av bygninger');
INSERT INTO public.naring VALUES ('43.91', 'Takarbeid', 'Takarbeid');
INSERT INTO public.naring VALUES ('43.99', 'Annen spesialisert bygge- og anleggsvirksomhet', 'Annen spes. bygge- og anleggsvirks.');
INSERT INTO public.naring VALUES ('43.110', 'Riving av bygninger og andre konstruksjoner', 'Riv. av bygn./andre konstruksjoner');
INSERT INTO public.naring VALUES ('43.120', 'Grunnarbeid', 'Grunnarbeid');
INSERT INTO public.naring VALUES ('43.130', 'Prøveboring', 'Prøveboring');
INSERT INTO public.naring VALUES ('43.210', 'Elektrisk installasjonsarbeid', 'Elektrisk installasjonsarbeid');
INSERT INTO public.naring VALUES ('43.221', 'Rørleggerarbeid', 'Rørleggerarbeid');
INSERT INTO public.naring VALUES ('43.222', 'Kuldeanlegg- og varmepumpearbeid', 'Kuldeanlegg- og varmepumpearbeid');
INSERT INTO public.naring VALUES ('43.223', 'Ventilasjonsarbeid', '');
INSERT INTO public.naring VALUES ('43.290', 'Annet installasjonsarbeid', 'Annet installasjonsarbeid');
INSERT INTO public.naring VALUES ('43.310', 'Stukkatørarbeid og pussing', 'Stukkatørarbeid og pussing');
INSERT INTO public.naring VALUES ('43.320', 'Snekkerarbeid', 'Snekkerarbeid');
INSERT INTO public.naring VALUES ('43.330', 'Gulvlegging og tapetsering', 'Gulvlegging og tapetsering');
INSERT INTO public.naring VALUES ('43.341', 'Malerarbeid', 'Malerarbeid');
INSERT INTO public.naring VALUES ('43.342', 'Glassarbeid', 'Glassarbeid');
INSERT INTO public.naring VALUES ('43.390', 'Annen ferdiggjøring av bygninger', 'Annen ferdiggjøring av bygninger');
INSERT INTO public.naring VALUES ('43.911', 'Blikkenslagerarbeid', 'Blikkenslagerarbeid');
INSERT INTO public.naring VALUES ('43.919', 'Takarbeid ellers', 'Takarbeid ellers');
INSERT INTO public.naring VALUES ('43.990', 'Annen spesialisert bygge- og anleggsvirksomhet', 'Annen spes. bygge- og anleggsvirks.');
INSERT INTO public.naring VALUES ('45', 'Handel med og reparasjon av motorvogner', 'Kjøretøyreparasjoner og -handel');
INSERT INTO public.naring VALUES ('45.1', 'Handel med motorvogner, unntatt motorsykler', 'Motorvognhandel, unnt. motorsykler');
INSERT INTO public.naring VALUES ('45.2', 'Vedlikehold og reparasjon av motorvogner, unntatt motorsykler', 'Rep. av motorvogner/unnt. motorsyk.');
INSERT INTO public.naring VALUES ('45.3', 'Handel med deler og utstyr til motorvogner, unntatt motorsykler', 'Del-/utstyrshdl. til motorvogner');
INSERT INTO public.naring VALUES ('45.4', 'Handel med motorsykler, deler og utstyr. Vedlikehold og reparasjon av motorsykler', 'Motorsykkelhandel og -rep. mv.');
INSERT INTO public.naring VALUES ('45.11', 'Handel med biler og lette motorvogner, unntatt motorsykler', 'Handel med biler og lette motorv.');
INSERT INTO public.naring VALUES ('45.19', 'Handel med andre motorvogner, unntatt motorsykler', 'Handel med andre motorvogner');
INSERT INTO public.naring VALUES ('45.20', 'Vedlikehold og reparasjon av motorvogner, unntatt motorsykler', 'Rep. av motorvogner/unnt. motorsyk.');
INSERT INTO public.naring VALUES ('45.31', 'Agentur- og engroshandel med deler og utstyr til motorvogner, unntatt motorsykler', 'Agent.-/engrosh. motorv./-deler mv.');
INSERT INTO public.naring VALUES ('45.32', 'Detaljhandel med deler og utstyr til motorvogner, unntatt motorsykler', 'Detalj. deler/utstyr til motorvogn');
INSERT INTO public.naring VALUES ('45.40', 'Handel med motorsykler, deler og utstyr. Vedlikehold og reparasjon av motorsykler', 'Motorsykkelhandel og -rep. mv.');
INSERT INTO public.naring VALUES ('45.111', 'Agentur- og engroshandel med biler og lette motorvogner, unntatt motorsykler', 'Agentur/engros biler/unnt. motorsyk');
INSERT INTO public.naring VALUES ('45.112', 'Detaljhandel med biler og lette motorvogner, unntatt motorsykler', 'Detaljh. biler, unnt. motorsykler');
INSERT INTO public.naring VALUES ('45.191', 'Agentur- og engroshandel med andre motorvogner, unntatt motorsykler', 'Agentur/engros motorvogner el.');
INSERT INTO public.naring VALUES ('45.192', 'Detaljhandel med andre motorvogner, unntatt motorsykler', 'Detaljh. motorvogner el.');
INSERT INTO public.naring VALUES ('45.200', 'Vedlikehold og reparasjon av motorvogner, unntatt motorsykler', 'Rep. av motorvogner/unnt. motorsyk.');
INSERT INTO public.naring VALUES ('45.310', 'Agentur- og engroshandel med deler og utstyr til motorvogner, unntatt motorsykler', 'Agent.-/engrosh. motorv./-deler mv.');
INSERT INTO public.naring VALUES ('45.320', 'Detaljhandel med deler og utstyr til motorvogner, unntatt motorsykler', 'Detalj. deler/utstyr til motorvogn');
INSERT INTO public.naring VALUES ('45.401', 'Agentur- og engroshandel med motorsykler, deler og utstyr', 'Agentur-/engrosh. motorsykler');
INSERT INTO public.naring VALUES ('45.402', 'Detaljhandel med motorsykler, deler og utstyr', 'Detaljh. motorsykler mv.');
INSERT INTO public.naring VALUES ('45.403', 'Vedlikehold og reparasjon av motorsykler', 'Motorsykkelvedlikehold og -rep.');
INSERT INTO public.naring VALUES ('46', 'Agentur- og engroshandel, unntatt med motorvogner', 'Agentur- og engroshandel');
INSERT INTO public.naring VALUES ('46.1', 'Agenturhandel', 'Agenturhandel');
INSERT INTO public.naring VALUES ('46.2', 'Engroshandel med jordbruksråvarer og levende dyr', 'Engrosh. jordbr.råvarer og lev. dyr');
INSERT INTO public.naring VALUES ('46.3', 'Engroshandel med nærings- og nytelsesmidler', 'Engrosh., nærings- og nytelsesmidler');
INSERT INTO public.naring VALUES ('46.4', 'Engroshandel med husholdningsvarer og varer til personlig bruk', 'Engrosh. hush.- og varer pers. bruk');
INSERT INTO public.naring VALUES ('46.5', 'Engroshandel med IKT-utstyr', 'Engrosh. IKT-utstyr');
INSERT INTO public.naring VALUES ('46.6', 'Engroshandel med andre maskiner og annet utstyr', 'Engrosh. mask. og utstyr el');
INSERT INTO public.naring VALUES ('46.7', 'Engroshandel med spesialisert vareutvalg ellers', 'Engrosh. med spes. vareutvalg el.');
INSERT INTO public.naring VALUES ('46.9', 'Uspesifisert engroshandel', 'Uspesifisert engroshandel');
INSERT INTO public.naring VALUES ('46.11', 'Agenturhandel med jordbruksråvarer, levende dyr, tekstilråvarer og innsatsvarer', 'Agentur jordbr. og tekstilråv. mv.');
INSERT INTO public.naring VALUES ('46.12', 'Agenturhandel med brensel, drivstoff, malm, metaller og industrikjemikalier', 'Agentur brensel, drivstoff mv.');
INSERT INTO public.naring VALUES ('46.13', 'Agenturhandel med tømmer, trelast og byggevarer', 'Agentur tømmer, trelast, byggev.');
INSERT INTO public.naring VALUES ('46.14', 'Agenturhandel med maskiner, produksjonsutstyr, båter og luftfartøyer', 'Agentur maskiner, prod.utstyr mv.');
INSERT INTO public.naring VALUES ('46.15', 'Agenturhandel med møbler, husholdningsvarer og jernvarer', 'Agentur møbler, hush.- og jernvarer');
INSERT INTO public.naring VALUES ('46.16', 'Agenturhandel med tekstiler, klær, pelsskinn, skotøy og lærvarer', 'Agentur tekstiler/klær/skotøy mv.');
INSERT INTO public.naring VALUES ('46.17', 'Agenturhandel med nærings- og nytelsesmidler', 'Agentur nærings- og nytelsesmidler');
INSERT INTO public.naring VALUES ('46.18', 'Agenturhandel med spesialisert vareutvalg ellers', 'Agentur spesialisert vareutvalg el.');
INSERT INTO public.naring VALUES ('46.19', 'Agenturhandel med bredt vareutvalg', 'Agentur bredt vareutvalg');
INSERT INTO public.naring VALUES ('46.21', 'Engroshandel med korn, råtobakk, såvarer og fôrvarer', 'Engrosh. korn, såvarer og fôr');
INSERT INTO public.naring VALUES ('46.22', 'Engroshandel med blomster og planter', 'Engrosh. blomster og planter');
INSERT INTO public.naring VALUES ('46.23', 'Engroshandel med levende dyr', 'Engrosh. levende dyr');
INSERT INTO public.naring VALUES ('46.24', 'Engroshandel med huder, skinn og lær', 'Engrosh. huder, skinn og lær');
INSERT INTO public.naring VALUES ('46.31', 'Engroshandel med frukt og grønnsaker', 'Engrosh. frukt og grønnsaker');
INSERT INTO public.naring VALUES ('46.32', 'Engroshandel med kjøtt og kjøttvarer', 'Engrosh. kjøtt og kjøttvarer');
INSERT INTO public.naring VALUES ('46.33', 'Engroshandel med meierivarer, egg, matolje og -fett', 'Engrosh. meierivarer, egg mv.');
INSERT INTO public.naring VALUES ('46.34', 'Engroshandel med drikkevarer', 'Engrosh. drikkevarer');
INSERT INTO public.naring VALUES ('46.35', 'Engroshandel med tobakksvarer', 'Engrosh. tobakksvarer');
INSERT INTO public.naring VALUES ('46.36', 'Engroshandel med sukker, sjokolade og sukkervarer', 'Engrosh. sukker, sjok. og sukkerv.');
INSERT INTO public.naring VALUES ('46.37', 'Engroshandel med kaffe, te, kakao og krydder', 'Engrosh. kaffe, te, kakao mv.');
INSERT INTO public.naring VALUES ('46.38', 'Engroshandel med andre næringsmidler, herunder fisk, skalldyr og bløtdyr', 'Engrosh. andre næringsmidler');
INSERT INTO public.naring VALUES ('46.39', 'Engroshandel med bredt utvalg av nærings- og nytelsesmidler', 'Engrosh. bredt utv. nær.-/nyt. midl');
INSERT INTO public.naring VALUES ('46.41', 'Engroshandel med tekstiler og utstyrsvarer', 'Engrosh. tekstiler og utstyrsvarer');
INSERT INTO public.naring VALUES ('46.42', 'Engroshandel med klær og skotøy', 'Engrosh. klær og skotøy');
INSERT INTO public.naring VALUES ('46.43', 'Engroshandel med elektriske husholdningsapparater', 'Engrosh. el. husholdningsapp. mv..');
INSERT INTO public.naring VALUES ('46.44', 'Engroshandel med kjøkkenutstyr, glass, steintøy og rengjøringsmidler', 'Engrosh. kjøkkenutstyr, steintøy mv.');
INSERT INTO public.naring VALUES ('46.45', 'Engroshandel med parfyme og kosmetikk', 'Engrosh. parfyme og kosmetikk');
INSERT INTO public.naring VALUES ('46.46', 'Engroshandel med sykepleie- og apotekvarer', 'Engrosh. sykepleie- og apotekvarer');
INSERT INTO public.naring VALUES ('46.47', 'Engroshandel med møbler, gulvbelegg, gulvtepper og belysningsutstyr', 'Engrosh. møbler og innredningsart.');
INSERT INTO public.naring VALUES ('46.48', 'Engroshandel med klokker, ur, gull- og sølvvarer', 'Engrosh. klokker/ur/gull-/sølvvarer');
INSERT INTO public.naring VALUES ('46.49', 'Engroshandel med husholdningsvarer og varer til personlig bruk ellers', 'Engrosh. husholdningsvarer m.m.');
INSERT INTO public.naring VALUES ('46.51', 'Engroshandel med datamaskiner, tilleggsutstyr til datamaskiner samt programvare', 'Engrosh. datamask., programv. mv..');
INSERT INTO public.naring VALUES ('46.52', 'Engroshandel med elektronikkutstyr og telekommunikasjonsutstyr samt deler', 'Engrosh. elektronikk-/telekomm.uts.');
INSERT INTO public.naring VALUES ('46.61', 'Engroshandel med maskiner og utstyr til jordbruk og skogbruk', 'Engrosh. jordbr.-/skogbr.mask. mv.');
INSERT INTO public.naring VALUES ('46.62', 'Engroshandel med maskinverktøy', 'Engrosh. maskinverktøy');
INSERT INTO public.naring VALUES ('46.63', 'Engroshandel med maskiner og utstyr til bergverksdrift, olje- og gassutvinning og bygge- og anleggsvirksomhet', 'Engros mask bygg/anl./oljeutv. mv.');
INSERT INTO public.naring VALUES ('46.64', 'Engroshandel med maskiner og utstyr til tekstilproduksjon', 'Engrosh. tekstilprod.maskiner mv.');
INSERT INTO public.naring VALUES ('46.65', 'Engroshandel med kontormøbler', 'Engrosh. kontormøbler');
INSERT INTO public.naring VALUES ('46.66', 'Engroshandel med maskiner og utstyr til kontor ellers', 'Engrosh. kontormask., -utstyr el.');
INSERT INTO public.naring VALUES ('46.69', 'Engroshandel med maskiner og utstyr ellers', 'Engrosh. maskiner og utstyr el.');
INSERT INTO public.naring VALUES ('46.71', 'Engroshandel med drivstoff og brensel', 'Engrosh. drivstoff og brensel');
INSERT INTO public.naring VALUES ('46.72', 'Engroshandel med metaller og metallholdig malm', 'Engrosh. metaller og metallh. malm');
INSERT INTO public.naring VALUES ('46.73', 'Engroshandel med tømmer, trelast, byggevarer og sanitærutstyr', 'Engrosh. tømmer/trelast/byggev. mv.');
INSERT INTO public.naring VALUES ('46.74', 'Engroshandel med jernvarer, rørleggerartikler og oppvarmingsutstyr', 'Engrosh. jernv., rørleggerart. m.m.');
INSERT INTO public.naring VALUES ('46.75', 'Engroshandel med kjemiske produkter', 'Engrosh. kjemiske produkter');
INSERT INTO public.naring VALUES ('46.76', 'Engroshandel med innsatsvarer ellers', 'Engrosh. innsatsvarer el.');
INSERT INTO public.naring VALUES ('46.77', 'Engroshandel med avfall og skrap', 'Engrosh. avfall og skrap');
INSERT INTO public.naring VALUES ('46.90', 'Uspesifisert engroshandel', 'Uspesifisert engroshandel');
INSERT INTO public.naring VALUES ('46.110', 'Agenturhandel med jordbruksråvarer, levende dyr, tekstilråvarer og innsatsvarer', 'Agentur jordbr. og tekstilråv. mv.');
INSERT INTO public.naring VALUES ('46.120', 'Agenturhandel med brensel, drivstoff, malm, metaller og industrikjemikalier', 'Agentur brensel, drivstoff mv.');
INSERT INTO public.naring VALUES ('46.130', 'Agenturhandel med tømmer, trelast og byggevarer', 'Agentur tømmer. trelast, byggev.');
INSERT INTO public.naring VALUES ('46.140', 'Agenturhandel med maskiner, produksjonsutstyr, båter og luftfartøyer', 'Agentur maskiner, prod.utstyr mv.');
INSERT INTO public.naring VALUES ('46.150', 'Agenturhandel med møbler, husholdningsvarer og jernvarer', 'Agentur møbler, hush.- og jernvarer');
INSERT INTO public.naring VALUES ('46.160', 'Agenturhandel med tekstiler, klær, pelsskinn, skotøy og lærvarer', 'Agentur tekstiler/klær/skotøy mv.');
INSERT INTO public.naring VALUES ('46.170', 'Agenturhandel med nærings- og nytelsesmidler', 'Agentur nærings- og nytelsesmidler');
INSERT INTO public.naring VALUES ('46.180', 'Agenturhandel med spesialisert vareutvalg ellers', 'Agentur spesialisert vareutvalg el.');
INSERT INTO public.naring VALUES ('46.190', 'Agenturhandel med bredt vareutvalg', 'Agentur bredt vareutvalg');
INSERT INTO public.naring VALUES ('46.210', 'Engroshandel med korn, råtobakk, såvarer og fôrvarer', 'Engrosh. korn, såvarer og fôr');
INSERT INTO public.naring VALUES ('46.220', 'Engroshandel med blomster og planter', 'Engrosh. blomster og planter');
INSERT INTO public.naring VALUES ('46.230', 'Engroshandel med levende dyr', 'Engrosh. levende dyr');
INSERT INTO public.naring VALUES ('46.240', 'Engroshandel med huder, skinn og lær', 'Engrosh. huder, skinn og lær');
INSERT INTO public.naring VALUES ('46.310', 'Engroshandel med frukt og grønnsaker', 'Engrosh. frukt og grønnsaker');
INSERT INTO public.naring VALUES ('46.320', 'Engroshandel med kjøtt og kjøttvarer', 'Engrosh. kjøtt og kjøttvarer');
INSERT INTO public.naring VALUES ('46.330', 'Engroshandel med meierivarer, egg, matolje og -fett', 'Engrosh. meierivarer, egg mv.');
INSERT INTO public.naring VALUES ('46.341', 'Engroshandel med vin og brennevin', 'Engrosh. vin og brennevin');
INSERT INTO public.naring VALUES ('46.349', 'Engroshandel med drikkevarer ellers', 'Engrosh. drikkevarer el.');
INSERT INTO public.naring VALUES ('46.350', 'Engroshandel med tobakksvarer', 'Engrosh. tobakksvarer');
INSERT INTO public.naring VALUES ('46.360', 'Engroshandel med sukker, sjokolade og sukkervarer', 'Engrosh. sukker, sjok. og sukkerv.');
INSERT INTO public.naring VALUES ('46.370', 'Engroshandel med kaffe, te, kakao og krydder', 'Engrosh. kaffe, te, kakao mv.');
INSERT INTO public.naring VALUES ('46.381', 'Engroshandel med fisk, skalldyr og bløtdyr', 'Engrosh. fisk og skalldyr');
INSERT INTO public.naring VALUES ('46.389', 'Engroshandel med spesialisert utvalg av nærings- og nytelsesmidler ikke nevnt annet sted', 'Engrosh. spes. utv. nær.-/nyt.midl.');
INSERT INTO public.naring VALUES ('46.390', 'Engroshandel med bredt utvalg av nærings- og nytelsesmidler', 'Engrosh. bredt utv. nær.-/nyt.midl.');
INSERT INTO public.naring VALUES ('46.410', 'Engroshandel med tekstiler og utstyrsvarer', 'Engrosh. tekstiler og utstyrsvarer');
INSERT INTO public.naring VALUES ('46.421', 'Engroshandel med klær', 'Engrosh. klær');
INSERT INTO public.naring VALUES ('46.422', 'Engroshandel med skotøy', 'Engrosh. skotøy');
INSERT INTO public.naring VALUES ('46.431', 'Engroshandel med elektriske husholdningsapparater og -maskiner', 'Engrosh. el.hush.app. og -maskiner');
INSERT INTO public.naring VALUES ('46.432', 'Engroshandel med radio og fjernsyn', 'Engrosh. radio og fjernsyn');
INSERT INTO public.naring VALUES ('46.433', 'Engroshandel med plater, musikk- og videokassetter og CD- og DVD-plater', 'Engrosh. musikk-,videokass.,CD,DVD');
INSERT INTO public.naring VALUES ('46.434', 'Engroshandel med fotoutstyr', 'Engrosh. fotoutstyr');
INSERT INTO public.naring VALUES ('46.435', 'Engroshandel med optiske artikler', 'Engrosh. optiske artikler');
INSERT INTO public.naring VALUES ('46.441', 'Engroshandel med kjøkkenutstyr, glass og steintøy', 'Engrosh. kjøkkenutstyr, steintøy mv.');
INSERT INTO public.naring VALUES ('46.442', 'Engroshandel med rengjøringsmidler', 'Engrosh. rengjøringsmidler');
INSERT INTO public.naring VALUES ('46.450', 'Engroshandel med parfyme og kosmetikk', 'Engrosh. parfyme og kosmetikk');
INSERT INTO public.naring VALUES ('46.460', 'Engroshandel med sykepleie- og apotekvarer', 'Engrosh. sykepleie- og apotekvarer');
INSERT INTO public.naring VALUES ('46.471', 'Engroshandel med møbler', 'Engrosh. møbler');
INSERT INTO public.naring VALUES ('46.472', 'Engroshandel med gulvtepper', 'Engrosh. gulvtepper');
INSERT INTO public.naring VALUES ('46.473', 'Engroshandel med belysningsutstyr', 'Engrosh. belysningsutstyr');
INSERT INTO public.naring VALUES ('46.481', 'Engroshandel med klokker og ur', 'Engrosh. klokker og ur');
INSERT INTO public.naring VALUES ('46.482', 'Engroshandel med gull- og sølvvarer', 'Engrosh. gull- og sølvvarer');
INSERT INTO public.naring VALUES ('46.491', 'Engroshandel med bøker, aviser og blader', 'Engrosh. bøker, aviser og blader');
INSERT INTO public.naring VALUES ('46.492', 'Engroshandel med reiseeffekter og lærvarer', 'Engrosh. reiseeffekter og lærvarer');
INSERT INTO public.naring VALUES ('46.493', 'Engroshandel med fritidsbåter og -utstyr', 'Engrosh. fritidsbåter og -utstyr');
INSERT INTO public.naring VALUES ('46.494', 'Engroshandel med sportsutstyr', 'Engrosh. sportsutstyr');
INSERT INTO public.naring VALUES ('46.495', 'Engroshandel med spill og leker', 'Engrosh. spill og leker');
INSERT INTO public.naring VALUES ('46.499', 'Engroshandel med husholdningsvarer og varer til personlig bruk ikke nevnt annet sted', 'Engrosh. hush.varer ellers');
INSERT INTO public.naring VALUES ('46.510', 'Engroshandel med datamaskiner, tilleggsutstyr til datamaskiner samt programvare', 'Engrosh. datamask., programv. mv.');
INSERT INTO public.naring VALUES ('46.520', 'Engroshandel med elektronikkutstyr og telekommunikasjonsutstyr samt deler', 'Engrosh. elektronikk-/telekomm.uts.');
INSERT INTO public.naring VALUES ('46.610', 'Engroshandel med maskiner og utstyr til jordbruk og skogbruk', 'Engrosh. jordbr.-/skogbr.mask. mv.');
INSERT INTO public.naring VALUES ('46.620', 'Engroshandel med maskinverktøy', 'Engrosh. maskinverktøy');
INSERT INTO public.naring VALUES ('46.630', 'Engroshandel med maskiner og utstyr til bergverksdrift, olje- og gassutvinning og bygge- og anleggsvirksomhet', 'Engros mask bygg/anl./oljeutv. mv.');
INSERT INTO public.naring VALUES ('46.640', 'Engroshandel med maskiner og utstyr til tekstilproduksjon', 'Engrosh. tekstilprod.maskiner mv.');
INSERT INTO public.naring VALUES ('46.650', 'Engroshandel med kontormøbler', 'Engrosh. kontormøbler');
INSERT INTO public.naring VALUES ('46.660', 'Engroshandel med maskiner og utstyr til kontor ellers', 'Engrosh. kontormask., -utstyr el.');
INSERT INTO public.naring VALUES ('46.691', 'Engroshandel med maskiner og utstyr til kraftproduksjon og installasjon', 'Engrosh. kraftprod.-,install.utstyr');
INSERT INTO public.naring VALUES ('46.692', 'Engroshandel med skipsutstyr og fiskeredskap', 'Engrosh. skipsutstyr og fiskeredsk.');
INSERT INTO public.naring VALUES ('46.693', 'Engroshandel med maskiner og utstyr til industri ellers', 'Engrosh. utstyr industri ellers');
INSERT INTO public.naring VALUES ('46.694', 'Engroshandel med maskiner og utstyr til handel, transport og tjenesteyting ellers', 'Engrosh. utstyr handel, transp. mv.');
INSERT INTO public.naring VALUES ('46.710', 'Engroshandel med drivstoff og brensel', 'Engrosh. drivstoff og brensel');
INSERT INTO public.naring VALUES ('46.720', 'Engroshandel med metaller og metallholdig malm', 'Engrosh. metaller og metallh. malm');
INSERT INTO public.naring VALUES ('46.731', 'Engroshandel med tømmer', 'Engrosh. tømmer');
INSERT INTO public.naring VALUES ('46.732', 'Engroshandel med trelast', 'Engrosh. trelast');
INSERT INTO public.naring VALUES ('46.733', 'Engroshandel med fargevarer', 'Engrosh. fargevarer');
INSERT INTO public.naring VALUES ('46.739', 'Engroshandel med byggevarer ikke nevnt annet sted', 'Engrosh. byggevarer el.');
INSERT INTO public.naring VALUES ('46.740', 'Engroshandel med jernvarer, rørleggerartikler og oppvarmingsutstyr', 'Engrosh. jernv., rørleggerart. m.m.');
INSERT INTO public.naring VALUES ('46.750', 'Engroshandel med kjemiske produkter', 'Engrosh. kjemiske produkter');
INSERT INTO public.naring VALUES ('46.761', 'Engroshandel med papir og papp', 'Engrosh. papir og papp');
INSERT INTO public.naring VALUES ('46.769', 'Engroshandel med innsatsvarer ikke nevnt annet sted', 'Engrosh innsatsvarer el.');
INSERT INTO public.naring VALUES ('46.770', 'Engroshandel med avfall og skrap', 'Engrosh. avfall og skrap');
INSERT INTO public.naring VALUES ('46.900', 'Uspesifisert engroshandel', 'Uspesifisert engroshandel');
INSERT INTO public.naring VALUES ('47', 'Detaljhandel, unntatt med motorvogner', 'Detaljhandel, unntatt motorvogner');
INSERT INTO public.naring VALUES ('47.1', 'Butikkhandel med bredt vareutvalg', 'Butikkh. med bredt vareutvalg');
INSERT INTO public.naring VALUES ('47.2', 'Butikkhandel med nærings- og nytelsesmidler i spesialforretninger', 'Spesialforr. nær.- og nytelsesmidl.');
INSERT INTO public.naring VALUES ('47.3', 'Detaljhandel med drivstoff til motorvogner', 'Detaljh. drivstoff til motorvogner');
INSERT INTO public.naring VALUES ('47.4', 'Butikkhandel med IKT-utstyr i spesialforretninger', 'Butikkh. med IKT-utstyr');
INSERT INTO public.naring VALUES ('47.5', 'Butikkhandel med andre husholdningsvarer i spesialforretninger', 'Butikkh. med andre husholdningsvarer');
INSERT INTO public.naring VALUES ('47.6', 'Butikkhandel med bøker, musikkartikler og andre fritidsartikler i spesialforretninger', 'Butikkh. med bøker, musikkart. etc.');
INSERT INTO public.naring VALUES ('47.7', 'Annen butikkhandel i spesialforretninger', 'Annen butikkhandel');
INSERT INTO public.naring VALUES ('47.8', 'Torghandel', 'Torghandel');
INSERT INTO public.naring VALUES ('47.9', 'Detaljhandel utenom utsalgssted', 'Detaljh. utenom utsalgssted');
INSERT INTO public.naring VALUES ('47.11', 'Butikkhandel med bredt vareutvalg med hovedvekt på nærings- og nytelsesmidler', 'Butikkh. bredt utvalg nær.midler mv.');
INSERT INTO public.naring VALUES ('47.19', 'Butikkhandel med bredt vareutvalg ellers', 'Butikkh. bredt vareutvalg el.');
INSERT INTO public.naring VALUES ('47.21', 'Butikkhandel med frukt og grønnsaker', 'Butikkh. frukt og grønnsaker');
INSERT INTO public.naring VALUES ('47.22', 'Butikkhandel med kjøtt og kjøttvarer', 'Butikkh. kjøtt og kjøttvarer');
INSERT INTO public.naring VALUES ('47.23', 'Butikkhandel med fisk, skalldyr og bløtdyr', 'Butikkh. fisk, skalldyr og bløtdyr');
INSERT INTO public.naring VALUES ('47.24', 'Butikkhandel med bakervarer, konditorvarer og sukkervarer', 'Butikkh. baker-, konditorvarer mv.');
INSERT INTO public.naring VALUES ('47.25', 'Butikkhandel med drikkevarer', 'Butikkh. drikkevarer');
INSERT INTO public.naring VALUES ('47.26', 'Butikkhandel med tobakksvarer', 'Butikkh. tobakksvarer');
INSERT INTO public.naring VALUES ('47.29', 'Butikkhandel med nærings- og nytelsesmidler ellers', 'Butikkh. nær.- og nytelsesmidler el.');
INSERT INTO public.naring VALUES ('47.30', 'Detaljhandel med drivstoff til motorvogner', 'Detaljh. drivstoff til motorvogner');
INSERT INTO public.naring VALUES ('47.41', 'Butikkhandel med datamaskiner og utstyr til datamaskiner', 'Butikkh. datamask. og tilleggsutst.');
INSERT INTO public.naring VALUES ('47.42', 'Butikkhandel med telekommunikasjonsutstyr', 'Butikkh. telekommunikasjonsutstyr');
INSERT INTO public.naring VALUES ('47.43', 'Butikkhandel med audio- og videoutstyr', 'Butikkh. audio- og videoutstyr');
INSERT INTO public.naring VALUES ('47.51', 'Butikkhandel med tekstiler og utstyrsvarer', 'Butikkh. tekstiler og utstyrsvarer');
INSERT INTO public.naring VALUES ('47.52', 'Butikkhandel med jernvarer, fargevarer og glass', 'Butikkh. jernv., fargev. og glass');
INSERT INTO public.naring VALUES ('47.53', 'Butikkhandel med tapeter, gulvtepper og gardiner', 'Butikkh. tapet/gulvtepper/gardiner');
INSERT INTO public.naring VALUES ('47.54', 'Butikkhandel med elektriske husholdningsapparater', 'Butikkh. el. hush.apparater');
INSERT INTO public.naring VALUES ('47.59', 'Butikkhandel med møbler, belysningsutstyr og andre innredningsartikler', 'Butikkh. møbler/belys.utstyr mv.');
INSERT INTO public.naring VALUES ('47.61', 'Butikkhandel med bøker', 'Butikkh. bøker');
INSERT INTO public.naring VALUES ('47.62', 'Butikkhandel med aviser og papirvarer', 'Butikkh. aviser og papirvarer');
INSERT INTO public.naring VALUES ('47.63', 'Butikkhandel med innspillinger av musikk og video', 'Butikkh. innspill. av musikk/video');
INSERT INTO public.naring VALUES ('47.64', 'Butikkhandel med sportsutstyr', 'Butikkh. sportsutstyr');
INSERT INTO public.naring VALUES ('47.65', 'Butikkhandel med spill og leker', 'Butikkh. spill og leker');
INSERT INTO public.naring VALUES ('47.71', 'Butikkhandel med klær', 'Butikkh. klær');
INSERT INTO public.naring VALUES ('47.72', 'Butikkhandel med skotøy og lærvarer', 'Butikkh. skotøy og lærvarer');
INSERT INTO public.naring VALUES ('47.73', 'Butikkhandel med apotekvarer', 'Butikkh. apotekvarer');
INSERT INTO public.naring VALUES ('47.74', 'Butikkhandel med medisinske og ortopediske artikler', 'Butikkh. medisinske/ortop. art.');
INSERT INTO public.naring VALUES ('47.75', 'Butikkhandel med kosmetikk og toalettartikler', 'Butikkh. kosmetikk og toalettart.');
INSERT INTO public.naring VALUES ('47.76', 'Butikkhandel med blomster og planter, kjæledyr og fôrvarer til kjæledyr', 'Butikkh. blomster/planter mv.');
INSERT INTO public.naring VALUES ('47.77', 'Butikkhandel med ur, gull- og sølvvarer', 'Butikkh. ur, gull- og sølvvarer');
INSERT INTO public.naring VALUES ('47.78', 'Annen butikkhandel med andre nye varer i spesialforretninger', 'Butikkh. nye varer i spes.forr. el.');
INSERT INTO public.naring VALUES ('47.79', 'Butikkhandel med brukte varer', 'Butikkh. brukte varer');
INSERT INTO public.naring VALUES ('47.81', 'Torghandel med næringsmidler, drikkevarer og tobakksvarer', 'Torgh. nær.midl./drikkev./tobakksv.');
INSERT INTO public.naring VALUES ('47.82', 'Torghandel med tekstiler, klær, skotøy og utstyrsvarer', 'Torgh. tekstiler, klær, skotøy m.m.');
INSERT INTO public.naring VALUES ('47.89', 'Torghandel med andre varer', 'Torgh. andre varer');
INSERT INTO public.naring VALUES ('47.91', 'Postordrehandel og handel via Internett', 'Postordreh. og handel via Internett');
INSERT INTO public.naring VALUES ('47.99', 'Detaljhandel utenom utsalgssted ellers', 'Detaljh. utenom utsalgssted el.');
INSERT INTO public.naring VALUES ('47.111', 'Butikkhandel med bredt vareutvalg med hovedvekt på nærings- og nytelsesmidler', 'Butikkh. bredt utvalg nær.midler mv.');
INSERT INTO public.naring VALUES ('47.112', 'Kioskhandel med bredt vareutvalg med hovedvekt på nærings- og nytelsesmidler', 'Kioskh. bredt utvalg nær.midler mv.');
INSERT INTO public.naring VALUES ('47.190', 'Butikkhandel med bredt vareutvalg ellers', 'Butikkh. bredt vareutvalg el.');
INSERT INTO public.naring VALUES ('47.210', 'Butikkhandel med frukt og grønnsaker', 'Butikkh. frukt og grønnsaker');
INSERT INTO public.naring VALUES ('47.220', 'Butikkhandel med kjøtt og kjøttvarer', 'Butikkh. kjøtt og kjøttvarer');
INSERT INTO public.naring VALUES ('47.230', 'Butikkhandel med fisk, skalldyr og bløtdyr', 'Butikkh. fisk, skalldyr og bløtdyr');
INSERT INTO public.naring VALUES ('47.241', 'Butikkhandel med bakervarer og konditorvarer', 'Butikkh. baker- og konditorvarer');
INSERT INTO public.naring VALUES ('47.242', 'Butikkhandel med sukkervarer', 'Butikkh. sukkervarer');
INSERT INTO public.naring VALUES ('47.251', 'Butikkhandel med vin og brennevin', 'Butikkh. vin og brennevin');
INSERT INTO public.naring VALUES ('47.259', 'Butikkhandel med drikkevarer ellers', 'Butikkh. drikkevarer el.');
INSERT INTO public.naring VALUES ('47.260', 'Butikkhandel med tobakksvarer', 'Butikkh. tobakksvarer');
INSERT INTO public.naring VALUES ('47.291', 'Butikkhandel med helsekost', 'Butikkh. helsekost');
INSERT INTO public.naring VALUES ('47.292', 'Butikkhandel med kaffe og te', 'Butikkh. kaffe og te');
INSERT INTO public.naring VALUES ('47.299', 'Butikkhandel med nærings- og nytelsesmidler ikke nevnt annet sted', 'Butikkh. nær.- og nytelsesmidler el.');
INSERT INTO public.naring VALUES ('47.300', 'Detaljhandel med drivstoff til motorvogner', 'Detaljh. drivstoff til motorvogner');
INSERT INTO public.naring VALUES ('47.410', 'Butikkhandel med datamaskiner og utstyr til datamaskiner', 'Butikkh. datamask. og tilleggsutst.');
INSERT INTO public.naring VALUES ('47.420', 'Butikkhandel med telekommunikasjonsutstyr', 'Butikkh. telekommunikasjonsutstyr');
INSERT INTO public.naring VALUES ('47.430', 'Butikkhandel med audio- og videoutstyr', 'Butikkh. audio- og videoutstyr');
INSERT INTO public.naring VALUES ('47.510', 'Butikkhandel med tekstiler og utstyrsvarer', 'Butikkh. tekstiler og utstyrsvarer');
INSERT INTO public.naring VALUES ('47.521', 'Butikkhandel med bredt utvalg av jernvarer, fargevarer og andre byggevarer', 'Byggvarehus m.m.');
INSERT INTO public.naring VALUES ('47.522', 'Butikkhandel med jernvarer', 'Butikkh. jernvarer');
INSERT INTO public.naring VALUES ('47.523', 'Butikkhandel med fargevarer', 'Butikkh. fargevarer');
INSERT INTO public.naring VALUES ('47.524', 'Butikkhandel med trelast', 'Butikkh. trelast');
INSERT INTO public.naring VALUES ('47.529', 'Butikkhandel med byggevarer ikke nevnt annet sted', 'Butikkh. byggevarer el.');
INSERT INTO public.naring VALUES ('47.531', 'Butikkhandel med tapeter og gulvbelegg', 'Butikkh. tapeter og gulvbelegg');
INSERT INTO public.naring VALUES ('47.532', 'Butikkhandel med tepper', 'Butikkh. tepper');
INSERT INTO public.naring VALUES ('47.533', 'Butikkhandel med gardiner', 'Butikkh. gardiner');
INSERT INTO public.naring VALUES ('47.540', 'Butikkhandel med elektriske husholdningsapparater', 'Butikkh. el. hush.apparater');
INSERT INTO public.naring VALUES ('47.591', 'Butikkhandel med møbler', 'Butikkh. møbler');
INSERT INTO public.naring VALUES ('47.592', 'Butikkhandel med belysningsutstyr', 'Butikkh. belysningsutstyr');
INSERT INTO public.naring VALUES ('47.593', 'Butikkhandel med kjøkkenutstyr, glass og steintøy', 'Butikkh. kjøkkenutstyr/steintøy mv.');
INSERT INTO public.naring VALUES ('47.594', 'Butikkhandel med musikkinstrumenter og noter', 'Butikkh. musikkinstr. og noter');
INSERT INTO public.naring VALUES ('47.599', 'Butikkhandel med innredningsartikler ikke nevnt annet sted', 'Butikkh. innredningsartikler el.');
INSERT INTO public.naring VALUES ('47.610', 'Butikkhandel med bøker', 'Butikkh. bøker');
INSERT INTO public.naring VALUES ('47.620', 'Butikkhandel med aviser og papirvarer', 'Butikkh. aviser og papirvarer');
INSERT INTO public.naring VALUES ('47.630', 'Butikkhandel med innspillinger av musikk og video', 'Butikkh. innspill. av musikk/video');
INSERT INTO public.naring VALUES ('47.641', 'Butikkhandel med sportsutstyr', 'Butikkh. sportsutstyr');
INSERT INTO public.naring VALUES ('47.642', 'Butikkhandel med fritidsbåter og -utstyr', 'Butikkh. fritidsbåter og -utstyr');
INSERT INTO public.naring VALUES ('47.650', 'Butikkhandel med spill og leker', 'Butikkh. spill og leker');
INSERT INTO public.naring VALUES ('47.710', 'Butikkhandel med klær', 'Butikkh. klær');
INSERT INTO public.naring VALUES ('47.721', 'Butikkhandel med skotøy', 'Butikkh. skotøy');
INSERT INTO public.naring VALUES ('47.722', 'Butikkhandel med reiseeffekter av lær og lærimitasjoner og varer av lær', 'Butikkh. reiseeff. og andre lærvarer');
INSERT INTO public.naring VALUES ('47.730', 'Butikkhandel med apotekvarer', 'Butikkh. apotekvarer');
INSERT INTO public.naring VALUES ('47.740', 'Butikkhandel med medisinske og ortopediske artikler', 'Butikkh. medisinske/ortop. art.');
INSERT INTO public.naring VALUES ('47.750', 'Butikkhandel med kosmetikk og toalettartikler', 'Butikkh. kosmetikk og toalettart.');
INSERT INTO public.naring VALUES ('47.761', 'Butikkhandel med blomster og planter', 'Butikkh. blomster og planter');
INSERT INTO public.naring VALUES ('47.762', 'Butikkhandel med kjæledyr og fôrvarer til kjæledyr', 'Butikkh. kjæledyr mv.');
INSERT INTO public.naring VALUES ('47.771', 'Butikkhandel med ur og klokker', 'Butikkh. ur og klokker');
INSERT INTO public.naring VALUES ('47.772', 'Butikkhandel med gull- og sølvvarer', 'Butikkh. gull- og sølvvarer');
INSERT INTO public.naring VALUES ('47.781', 'Butikkhandel med fotoutstyr', 'Butikkh. fotoutstyr');
INSERT INTO public.naring VALUES ('47.782', 'Butikkhandel med optiske artikler', 'Butikkh. optiske artikler');
INSERT INTO public.naring VALUES ('47.789', 'Butikkhandel ikke nevnt annet sted', 'Butikkh. el.');
INSERT INTO public.naring VALUES ('47.791', 'Butikkhandel med antikviteter', 'Butikkh. antikviteter');
INSERT INTO public.naring VALUES ('47.792', 'Butikkhandel med brukte klær', 'Butikkh. brukte klær');
INSERT INTO public.naring VALUES ('47.799', 'Butikkhandel med brukte varer ellers', 'Butikkh. brukte varer el.');
INSERT INTO public.naring VALUES ('47.810', 'Torghandel med næringsmidler, drikkevarer og tobakksvarer', 'Torgh. nær.midl./drikkev./tobakksv');
INSERT INTO public.naring VALUES ('47.820', 'Torghandel med tekstiler, klær, skotøy og utstyrsvarer', 'Torgh. tekstiler, klær, skotøy m.m.');
INSERT INTO public.naring VALUES ('47.890', 'Torghandel med andre varer', 'Torghandel med andre varer');
INSERT INTO public.naring VALUES ('47.911', 'Postordre-/Internetthandel med bredt vareutvalg', 'Postord.-/Internetth. br. vareutv.');
INSERT INTO public.naring VALUES ('47.912', 'Postordre-/Internetthandel med tekstiler, utstyrsvarer, klær, skotøy, reiseeffekter og lærvarer', 'Postord.-/Internetth. tekstiler mv.');
INSERT INTO public.naring VALUES ('47.913', 'Postordre-/Internetthandel med belysningsutstyr, kjøkkenutstyr, møbler og innredningsartikler', 'Postord.-/Internetth. møbler mv.');
INSERT INTO public.naring VALUES ('47.914', 'Postordre-/Internetthandel med elektriske husholdningsapparater, radio, fjernsyn, plater, kassetter og musikkinstrumenter', 'Post.-/Internetth. el.hush.app. mv.');
INSERT INTO public.naring VALUES ('47.915', 'Postordre-/internetthandel med bøker, papir, aviser og blader', 'Postord.-/Internetth. bøker mv.');
INSERT INTO public.naring VALUES ('47.916', 'Postordre-/Internetthandel med IKT-utstyr', 'Postord.-/Internetth. IKT-utstyr');
INSERT INTO public.naring VALUES ('47.917', 'Postordre-/Internetthandel med helsekost', 'Postord.-/Internetth. helsekost');
INSERT INTO public.naring VALUES ('47.919', 'Postordre-/Internetthandel med annet spesialisert vareutvalg', 'Postord.-/Internetth. ellers');
INSERT INTO public.naring VALUES ('47.990', 'Detaljhandel utenom utsalgssted ellers', 'Detaljh. utenom utsalgssted el.');
INSERT INTO public.naring VALUES ('49', 'Landtransport og rørtransport', 'Landtransport og rørtransport');
INSERT INTO public.naring VALUES ('49.1', 'Passasjertransport med jernbane', 'Passasjertransp. med jernbane');
INSERT INTO public.naring VALUES ('49.2', 'Godstransport med jernbane', 'Godstransp. med jernbane');
INSERT INTO public.naring VALUES ('49.3', 'Annen landtransport med passasjerer', 'Annen landtransp. med passasjerer');
INSERT INTO public.naring VALUES ('49.4', 'Godstransport på vei, herunder flyttetransport', 'Godstransp. på vei/flyttetransport');
INSERT INTO public.naring VALUES ('49.5', 'Rørtransport', 'Rørtransport');
INSERT INTO public.naring VALUES ('49.10', 'Passasjertransport med jernbane', 'Passasjertransp. med jernbane');
INSERT INTO public.naring VALUES ('49.20', 'Godstransport med jernbane', 'Godstransp. med jernbane');
INSERT INTO public.naring VALUES ('49.31', 'Transport med rutebil og sporvei i by- og forstadsområde', 'Rutebil/sporvei i by-/forstadsomr.');
INSERT INTO public.naring VALUES ('49.32', 'Drosjebiltransport', 'Drosjebiltransport');
INSERT INTO public.naring VALUES ('49.39', 'Landtransport med passasjerer ikke nevnt annet sted', 'Landtr. med passasjerer el.');
INSERT INTO public.naring VALUES ('49.41', 'Godstransport på vei', 'Godstransport på vei');
INSERT INTO public.naring VALUES ('49.42', 'Flyttetransport', 'Flyttetransport');
INSERT INTO public.naring VALUES ('49.50', 'Rørtransport', 'Rørtransport');
INSERT INTO public.naring VALUES ('49.100', 'Passasjertransport med jernbane', 'Passasjertransp. med jernbane');
INSERT INTO public.naring VALUES ('49.200', 'Godstransport med jernbane', 'Godstransp. med jernbane');
INSERT INTO public.naring VALUES ('49.311', 'Rutebiltransport i by- og forstadsområde', 'Rutebiltransp. by-/forstadsområde');
INSERT INTO public.naring VALUES ('49.312', 'Transport med sporveis- og forstadsbane', 'Transp. sporveis-/forstadsbane');
INSERT INTO public.naring VALUES ('49.320', 'Drosjebiltransport', 'Drosjebiltransport');
INSERT INTO public.naring VALUES ('49.391', 'Rutebiltransport utenfor by- og forstadsområde', 'Rutebiltr. utenfor by-/forstadsomr.');
INSERT INTO public.naring VALUES ('49.392', 'Turbiltransport', 'Turbiltransport');
INSERT INTO public.naring VALUES ('49.393', 'Transport med taubaner, kabelbaner og skiheiser', 'Transp. tau-/kabelbaner/skiheiser');
INSERT INTO public.naring VALUES ('49.410', 'Godstransport på vei', 'Godstransport på vei');
INSERT INTO public.naring VALUES ('49.420', 'Flyttetransport', 'Flyttetransport');
INSERT INTO public.naring VALUES ('49.500', 'Rørtransport', 'Rørtransport');
INSERT INTO public.naring VALUES ('50', 'Sjøfart', 'Sjøfart');
INSERT INTO public.naring VALUES ('50.1', 'Sjøfart og kysttrafikk med passasjerer', 'Sjøfart og kysttraf. m/passasjerer');
INSERT INTO public.naring VALUES ('50.2', 'Sjøfart og kysttrafikk med gods', 'Sjøfart og kysttrafikk med gods');
INSERT INTO public.naring VALUES ('50.3', 'Passasjertransport på elver og innsjøer', 'Passasjertr. på elver og innsjøer');
INSERT INTO public.naring VALUES ('50.4', 'Godstransport på elver og innsjøer', 'Godstransp. på elver og innsjøer');
INSERT INTO public.naring VALUES ('50.10', 'Sjøfart og kysttrafikk med passasjerer', 'Sjøfart og kysttraf. m/passasjerer');
INSERT INTO public.naring VALUES ('50.20', 'Sjøfart og kysttrafikk med gods', 'Sjøfart og kysttrafikk med gods');
INSERT INTO public.naring VALUES ('50.30', 'Passasjertransport på elver og innsjøer', 'Passasjertr. på elver og innsjøer');
INSERT INTO public.naring VALUES ('50.40', 'Godstransport på elver og innsjøer', 'Godstransp. på elver og innsjøer');
INSERT INTO public.naring VALUES ('50.101', 'Utenriks sjøfart med passasjerer', 'Utenriks sjøfart med passasjerer');
INSERT INTO public.naring VALUES ('50.102', 'Innenlandske kystruter med passasjerer', 'Innenl. kystruter med passasjerer');
INSERT INTO public.naring VALUES ('50.109', 'Kysttrafikk ellers med passasjerer', 'Kysttrafikk ellers med passasjerer');
INSERT INTO public.naring VALUES ('50.201', 'Utenriks sjøfart med gods', 'Utenriks sjøfart med gods');
INSERT INTO public.naring VALUES ('50.202', 'Innenriks sjøfart med gods', 'Innenriks sjøfart med gods');
INSERT INTO public.naring VALUES ('50.203', 'Slepebåter', 'Slepebåter');
INSERT INTO public.naring VALUES ('50.204', 'Forsyning og andre sjøtransporttjenester for offshore', 'Forsyn./andre sjøtr.tj. for offshore');
INSERT INTO public.naring VALUES ('50.300', 'Passasjertransport på elver og innsjøer', 'Passasjertr. på elver og innsjøer');
INSERT INTO public.naring VALUES ('50.400', 'Godstransport på elver og innsjøer', 'Godstransp. på elver og innsjøer');
INSERT INTO public.naring VALUES ('51', 'Lufttransport', 'Lufttransport');
INSERT INTO public.naring VALUES ('51.1', 'Lufttransport med passasjerer', 'Lufttransp. med passasjerer');
INSERT INTO public.naring VALUES ('51.2', 'Lufttransport med gods samt romfart', 'Lufttransp. med gods samt romfart');
INSERT INTO public.naring VALUES ('51.10', 'Lufttransport med passasjerer', 'Lufttransp. med passasjerer');
INSERT INTO public.naring VALUES ('51.21', 'Lufttransport med gods', 'Lufttransp. med gods');
INSERT INTO public.naring VALUES ('51.22', 'Romfart', 'Romfart');
INSERT INTO public.naring VALUES ('51.100', 'Lufttransport med passasjerer', 'Lufttransp. med passasjerer');
INSERT INTO public.naring VALUES ('51.210', 'Lufttransport med gods', 'Lufttransp. med gods');
INSERT INTO public.naring VALUES ('51.220', 'Romfart', 'Romfart');
INSERT INTO public.naring VALUES ('52', 'Lagring og andre tjenester tilknyttet transport', 'Transporttjenester og lagring');
INSERT INTO public.naring VALUES ('52.1', 'Lagring', 'Lagring');
INSERT INTO public.naring VALUES ('52.2', 'Andre tjenester tilknyttet transport', 'Andre tjenester tilkn. transport');
INSERT INTO public.naring VALUES ('52.10', 'Lagring', 'Lagring');
INSERT INTO public.naring VALUES ('52.21', 'Andre tjenester tilknyttet landtransport', 'Andre tjen. tilkn. landtransport');
INSERT INTO public.naring VALUES ('52.22', 'Andre tjenester tilknyttet sjøtransport', 'Andre tjen. tilkn. sjøtransport');
INSERT INTO public.naring VALUES ('52.23', 'Andre tjenester tilknyttet lufttransport', 'Andre tjen. tilkn. lufttransport');
INSERT INTO public.naring VALUES ('52.24', 'Lasting og lossing', 'Lasting og lossing');
INSERT INTO public.naring VALUES ('52.29', 'Andre tjenester tilknyttet transport', 'Andre tjenester tilknyttet transport');
INSERT INTO public.naring VALUES ('52.100', 'Lagring', 'Lagring');
INSERT INTO public.naring VALUES ('52.211', 'Drift av gods- og transportsentraler', 'Drift av gods- og transportsentraler');
INSERT INTO public.naring VALUES ('52.212', 'Drift av parkeringsplasser og parkeringshus', 'Drift av parkeringsplasser og -hus');
INSERT INTO public.naring VALUES ('52.213', 'Drift av bomstasjoner', 'Drift av bomstasjoner');
INSERT INTO public.naring VALUES ('52.214', 'Drift av taxisentraler og annen formidling av persontransport', 'Drift av taxisentraler m.m.');
INSERT INTO public.naring VALUES ('52.216', 'Kondensering av gass med henblikk på transport', 'Kondensering av gass mtp. transport');
INSERT INTO public.naring VALUES ('52.219', 'Tjenester tilknyttet landtransport ellers', 'Tjen. tilkn. landtransport el.');
INSERT INTO public.naring VALUES ('52.221', 'Drift av havne- og kaianlegg', 'Drift av havne- og kaianlegg');
INSERT INTO public.naring VALUES ('52.222', 'Redningstjeneste', 'Redningstjeneste');
INSERT INTO public.naring VALUES ('52.223', 'Forsyningsbaser', 'Forsyningsbaser');
INSERT INTO public.naring VALUES ('52.229', 'Tjenester tilknyttet sjøtransport ellers', 'Tjen. tilkn. sjøtransport el.');
INSERT INTO public.naring VALUES ('52.230', 'Andre tjenester tilknyttet lufttransport', 'Andre tjen. tilkn. lufttransport');
INSERT INTO public.naring VALUES ('52.240', 'Lasting og lossing', 'Lasting og lossing');
INSERT INTO public.naring VALUES ('52.291', 'Spedisjon', 'Spedisjon');
INSERT INTO public.naring VALUES ('52.292', 'Skipsmegling', 'Skipsmegling');
INSERT INTO public.naring VALUES ('52.293', 'Flymegling', 'Flymegling');
INSERT INTO public.naring VALUES ('52.299', 'Transportformidling ellers', 'Transportformidling ellers');
INSERT INTO public.naring VALUES ('53', 'Post og distribusjonsvirksomhet', 'Post og distribusjonsvirksomhet');
INSERT INTO public.naring VALUES ('53.1', 'Landsdekkende posttjenester', 'Landsdekkende posttjenester');
INSERT INTO public.naring VALUES ('53.2', 'Andre post- og budtjenester', 'Andre post- og budtjenester');
INSERT INTO public.naring VALUES ('53.10', 'Landsdekkende posttjenester', 'Landsdekkende posttjenester');
INSERT INTO public.naring VALUES ('53.20', 'Andre post- og budtjenester', 'Andre post- og budtjenester');
INSERT INTO public.naring VALUES ('53.100', 'Landsdekkende posttjenester', 'Landsdekkende posttjenester');
INSERT INTO public.naring VALUES ('53.200', 'Andre post- og budtjenester', 'Andre post- og budtjenester');
INSERT INTO public.naring VALUES ('55', 'Overnattingsvirksomhet', 'Overnattingsvirksomhet');
INSERT INTO public.naring VALUES ('55.1', 'Hotellvirksomhet', 'Hotellvirksomhet');
INSERT INTO public.naring VALUES ('55.2', 'Drift av vandrerhjem og ferieleiligheter', 'Drift av vandrerhjem/ferieleil.');
INSERT INTO public.naring VALUES ('55.3', 'Drift av campingplasser', 'Drift av campingplasser');
INSERT INTO public.naring VALUES ('55.9', 'Annen overnatting', 'Annen overnatting');
INSERT INTO public.naring VALUES ('55.10', 'Hotellvirksomhet', 'Hotellvirksomhet');
INSERT INTO public.naring VALUES ('55.20', 'Drift av vandrerhjem og ferieleiligheter', 'Drift av vandrerhjem/ferieleil.');
INSERT INTO public.naring VALUES ('55.30', 'Drift av campingplasser', 'Drift av campingplasser');
INSERT INTO public.naring VALUES ('55.90', 'Annen overnatting', 'Annen overnatting');
INSERT INTO public.naring VALUES ('55.101', 'Drift av hoteller, pensjonater og moteller med restaurant', 'Drift av hoteller med restaurant');
INSERT INTO public.naring VALUES ('55.102', 'Drift av hoteller, pensjonater og moteller uten restaurant', 'Drift av hoteller uten restaurant');
INSERT INTO public.naring VALUES ('55.201', 'Drift av vandrerhjem', 'Drift av vandrerhjem');
INSERT INTO public.naring VALUES ('55.202', 'Drift av ferieleiligheter', 'Drift av ferieleiligheter');
INSERT INTO public.naring VALUES ('55.300', 'Drift av campingplasser', 'Drift av campingplasser');
INSERT INTO public.naring VALUES ('55.900', 'Annen overnatting', 'Annen overnatting');
INSERT INTO public.naring VALUES ('56', 'Serveringsvirksomhet', 'Serveringsvirksomhet');
INSERT INTO public.naring VALUES ('56.1', 'Restaurantvirksomhet', 'Restaurantvirksomhet');
INSERT INTO public.naring VALUES ('56.2', 'Cateringvirksomhet og kantiner drevet som selvstendig virksomhet', 'Catering- og kantinevirksomhet');
INSERT INTO public.naring VALUES ('56.3', 'Drift av barer', 'Drift av barer');
INSERT INTO public.naring VALUES ('56.10', 'Restaurantvirksomhet', 'Restaurantvirksomhet');
INSERT INTO public.naring VALUES ('56.21', 'Cateringvirksomhet', 'Cateringvirksomhet');
INSERT INTO public.naring VALUES ('56.29', 'Kantiner drevet som selvstendig virksomhet', 'Kantinedrift, selvst. virksomhet');
INSERT INTO public.naring VALUES ('56.30', 'Drift av barer', 'Drift av barer');
INSERT INTO public.naring VALUES ('56.101', 'Drift av restauranter og kafeer', 'Drift av restauranter og kafeer');
INSERT INTO public.naring VALUES ('56.102', 'Drift av gatekjøkken', 'Drift av gatekjøkken');
INSERT INTO public.naring VALUES ('56.210', 'Cateringvirksomhet', 'Cateringvirksomhet');
INSERT INTO public.naring VALUES ('56.290', 'Kantiner drevet som selvstendig virksomhet', 'Kantinedrift, selvst. virksomhet');
INSERT INTO public.naring VALUES ('56.301', 'Drift av puber', 'Drift av puber');
INSERT INTO public.naring VALUES ('56.309', 'Drift av barer ellers', 'Drift av barer ellers');
INSERT INTO public.naring VALUES ('58', 'Forlagsvirksomhet', 'Forlagsvirksomhet');
INSERT INTO public.naring VALUES ('58.1', 'Utgivelse av bøker, tidsskrifter og annen forlagsvirksomhet', 'Utgiv. av bøker, tidsskrifter etc.');
INSERT INTO public.naring VALUES ('58.2', 'Utgivelse av programvare', 'Utgivelse av programvare');
INSERT INTO public.naring VALUES ('58.11', 'Utgivelse av bøker', 'Utgivelse av bøker');
INSERT INTO public.naring VALUES ('58.12', 'Utgivelse av kataloger og adresselister', 'Utgiv. av kataloger/adresselister');
INSERT INTO public.naring VALUES ('58.13', 'Utgivelse av aviser', 'Utgivelse av aviser');
INSERT INTO public.naring VALUES ('58.14', 'Utgivelse av blader og tidsskrifter', 'Utgivelse av blader og tidsskrifter');
INSERT INTO public.naring VALUES ('58.19', 'Forlagsvirksomhet ellers', 'Forlagsvirksomhet ellers');
INSERT INTO public.naring VALUES ('58.21', 'Utgivelse av programvare for dataspill', 'Utgiv. av programv. for dataspill');
INSERT INTO public.naring VALUES ('58.29', 'Utgivelse av annen programvare', 'Utgiv. av annen programvare');
INSERT INTO public.naring VALUES ('58.110', 'Utgivelse av bøker', 'Utgivelse av bøker');
INSERT INTO public.naring VALUES ('58.120', 'Utgivelse av kataloger og adresselister', 'Utgiv. av kataloger/adresselister');
INSERT INTO public.naring VALUES ('58.130', 'Utgivelse av aviser', 'Utgivelse av aviser');
INSERT INTO public.naring VALUES ('58.140', 'Utgivelse av blader og tidsskrifter', 'Utgivelse av blader og tidsskrifter');
INSERT INTO public.naring VALUES ('58.190', 'Forlagsvirksomhet ellers', 'Forlagsvirksomhet ellers');
INSERT INTO public.naring VALUES ('58.210', 'Utgivelse av programvare for dataspill', 'Utgiv. av programv. for dataspill');
INSERT INTO public.naring VALUES ('58.290', 'Utgivelse av annen programvare', 'Utgiv. av annen programvare');
INSERT INTO public.naring VALUES ('59', 'Film-, video- og fjernsynsprogramproduksjon, utgivelse av musikk- og lydopptak', 'Film- og TV-prod., musikkutgivelse');
INSERT INTO public.naring VALUES ('59.1', 'Virksomhet innen film, video og fjernsynsprogrammer', 'Virks. innen film/video/tv-program.');
INSERT INTO public.naring VALUES ('59.2', 'Produksjon og utgivelse av musikk- og lydopptak', 'Prod./utgiv. av musikk-/lydopptak');
INSERT INTO public.naring VALUES ('59.11', 'Produksjon av film, video og fjernsynsprogrammer', 'Prod. av film/video/fjernsynsprogr.');
INSERT INTO public.naring VALUES ('59.12', 'Etterarbeid knyttet til produksjon av film, video og fjernsynsprogrammer', 'Etterarb. til film-/video-/TV-prod.');
INSERT INTO public.naring VALUES ('59.13', 'Distribusjon av film, video og fjernsynsprogrammer', 'Distrib. film/video/fjernsynsprogr.');
INSERT INTO public.naring VALUES ('59.14', 'Filmframvisning', 'Filmframvisning');
INSERT INTO public.naring VALUES ('59.20', 'Produksjon og utgivelse av musikk- og lydopptak', 'Prod./utgiv. av musikk-/lydopptak');
INSERT INTO public.naring VALUES ('59.110', 'Produksjon av film, video og fjernsynsprogrammer', 'Prod. av film/video/fjernsynsprogr.');
INSERT INTO public.naring VALUES ('59.120', 'Etterarbeid knyttet til produksjon av film, video og fjernsynsprogrammer', 'Etterarb. til film-/video-/TV-prod.');
INSERT INTO public.naring VALUES ('59.130', 'Distribusjon av film, video og fjernsynsprogrammer', 'Distrib. film/video/fjernsynsprogr.');
INSERT INTO public.naring VALUES ('59.140', 'Filmframvisning', 'Filmframvisning');
INSERT INTO public.naring VALUES ('59.200', 'Produksjon og utgivelse av musikk- og lydopptak', 'Prod./utgiv. av musikk-/lydopptak');
INSERT INTO public.naring VALUES ('60', 'Radio- og fjernsynskringkasting', 'Radio- og fjernsynskringkasting');
INSERT INTO public.naring VALUES ('60.1', 'Radiokringkasting', 'Radiokringkasting');
INSERT INTO public.naring VALUES ('60.2', 'Fjernsynskringkasting', 'Fjernsynskringkasting');
INSERT INTO public.naring VALUES ('60.10', 'Radiokringkasting', 'Radiokringkasting');
INSERT INTO public.naring VALUES ('60.20', 'Fjernsynskringkasting', 'Fjernsynskringkasting');
INSERT INTO public.naring VALUES ('60.100', 'Radiokringkasting', 'Radiokringkasting');
INSERT INTO public.naring VALUES ('60.200', 'Fjernsynskringkasting', 'Fjernsynskringkasting');
INSERT INTO public.naring VALUES ('61', 'Telekommunikasjon', 'Telekommunikasjon');
INSERT INTO public.naring VALUES ('61.1', 'Kabelbasert telekommunikasjon', 'Kabelbasert telekomm.');
INSERT INTO public.naring VALUES ('61.2', 'Trådløs telekommunikasjon', 'Trådløs telekomm.');
INSERT INTO public.naring VALUES ('61.3', 'Satellittbasert telekommunikasjon', 'Satellittbasert telekomm.');
INSERT INTO public.naring VALUES ('61.9', 'Telekommunikasjon ellers', 'Telekommunikasjon ellers');
INSERT INTO public.naring VALUES ('61.10', 'Kabelbasert telekommunikasjon', 'Kabelbasert telekomm.');
INSERT INTO public.naring VALUES ('61.20', 'Trådløs telekommunikasjon', 'Trådløs telekomm.');
INSERT INTO public.naring VALUES ('61.30', 'Satellittbasert telekommunikasjon', 'Satellittbasert telekomm.');
INSERT INTO public.naring VALUES ('61.90', 'Telekommunikasjon ellers', 'Telekommunikasjon ellers');
INSERT INTO public.naring VALUES ('61.100', 'Kabelbasert telekommunikasjon', 'Kabelbasert telekomm.');
INSERT INTO public.naring VALUES ('61.200', 'Trådløs telekommunikasjon', 'Trådløs telekomm.');
INSERT INTO public.naring VALUES ('61.300', 'Satellittbasert telekommunikasjon', 'Satellittbasert telekomm.');
INSERT INTO public.naring VALUES ('61.900', 'Telekommunikasjon ellers', 'Telekommunikasjon ellers');
INSERT INTO public.naring VALUES ('62', 'Tjenester tilknyttet informasjonsteknologi', 'IT-tjenester');
INSERT INTO public.naring VALUES ('62.0', 'Tjenester tilknyttet informasjonsteknologi', 'Tjen. tilkn. informasjonsteknologi');
INSERT INTO public.naring VALUES ('62.01', 'Programmeringstjenester', 'Programmeringstjenester');
INSERT INTO public.naring VALUES ('62.02', 'Konsulentvirksomhet tilknyttet informasjonsteknologi', 'Kons.virks. tilkn. informasj.tekn.');
INSERT INTO public.naring VALUES ('62.03', 'Forvaltning og drift av IT-systemer', 'Forvaltning og drift av IT-systemer');
INSERT INTO public.naring VALUES ('62.09', 'Andre tjenester tilknyttet informasjonsteknologi', 'Tjen. tilkn. informasjonsteknologi el.');
INSERT INTO public.naring VALUES ('62.010', 'Programmeringstjenester', 'Programmeringstjenester');
INSERT INTO public.naring VALUES ('62.020', 'Konsulentvirksomhet tilknyttet informasjonsteknologi', 'Kons.virks. tilkn. informasj.tekn.');
INSERT INTO public.naring VALUES ('62.030', 'Forvaltning og drift av IT-systemer', 'Forvaltning og drift av IT-systemer');
INSERT INTO public.naring VALUES ('62.090', 'Andre tjenester tilknyttet informasjonsteknologi', 'Tjen. tilkn. informasjonsteknologi el.');
INSERT INTO public.naring VALUES ('63', 'Informasjonstjenester', 'Informasjonstjenester');
INSERT INTO public.naring VALUES ('63.1', 'Databehandling, datalagring og tilknyttede tjenester, drift av web-portaler', 'Databeh./datalagr./web-portaler');
INSERT INTO public.naring VALUES ('63.9', 'Andre informasjonstjenester', 'Andre informasjonstjenester');
INSERT INTO public.naring VALUES ('63.11', 'Databehandling, datalagring og tilknyttede tjenester', 'Databeh./-lagring og tilkn. tjen.');
INSERT INTO public.naring VALUES ('63.12', 'Drift av web-portaler', 'Drift av web-portaler');
INSERT INTO public.naring VALUES ('63.91', 'Nyhetsbyråer', 'Nyhetsbyråer');
INSERT INTO public.naring VALUES ('63.99', 'Andre informasjonstjenester ikke nevnt annet sted', 'Andre informasjonstjenester');
INSERT INTO public.naring VALUES ('63.110', 'Databehandling, datalagring og tilknyttede tjenester', 'Databeh./-lagring og tilkn. tjen.');
INSERT INTO public.naring VALUES ('63.120', 'Drift av web-portaler', 'Drift av web-portaler');
INSERT INTO public.naring VALUES ('63.910', 'Nyhetsbyråer', 'Nyhetsbyråer');
INSERT INTO public.naring VALUES ('63.990', 'Andre informasjonstjenester ikke nevnt annet sted', 'Andre informasjonstjenester');
INSERT INTO public.naring VALUES ('64', 'Finansieringsvirksomhet', 'Finansieringsvirksomhet');
INSERT INTO public.naring VALUES ('64.1', 'Bankvirksomhet', 'Bankvirksomhet');
INSERT INTO public.naring VALUES ('64.2', 'Holdingselskaper', 'Holdingselskaper');
INSERT INTO public.naring VALUES ('64.3', 'Verdipapirfond, investeringsselskaper o.l.', 'Verdipapirfond/invest.selskap o.l.');
INSERT INTO public.naring VALUES ('64.9', 'Annen finansieringsvirksomhet', 'Annen finansieringsvirksomhet');
INSERT INTO public.naring VALUES ('64.11', 'Sentralbankvirksomhet', 'Sentralbankvirksomhet');
INSERT INTO public.naring VALUES ('64.19', 'Bankvirksomhet ellers', 'Bankvirksomhet ellers');
INSERT INTO public.naring VALUES ('64.20', 'Holdingselskaper', 'Holdingselskaper');
INSERT INTO public.naring VALUES ('64.30', 'Verdipapirfond, investeringsselskaper o.l.', 'Verdipapirfond/invest.selskap. o.l.');
INSERT INTO public.naring VALUES ('64.91', 'Finansiell leasing', 'Finansiell leasing');
INSERT INTO public.naring VALUES ('64.92', 'Annen kredittgivning', 'Annen kredittgivning');
INSERT INTO public.naring VALUES ('64.99', 'Annen finansieringsvirksomhet ikke nevnt annet sted', 'Finansieringsvirksomhet el.');
INSERT INTO public.naring VALUES ('64.110', 'Sentralbankvirksomhet', 'Sentralbankvirksomhet');
INSERT INTO public.naring VALUES ('64.190', 'Bankvirksomhet ellers', 'Bankvirksomhet ellers');
INSERT INTO public.naring VALUES ('64.201', 'Finansielle holdingselskaper', 'Finansielle holdingselskaper');
INSERT INTO public.naring VALUES ('64.202', 'Spesielle holdingselskaper', 'Spesielle holdingselskaper');
INSERT INTO public.naring VALUES ('64.301', 'Verdipapirfond', 'Verdipapirfond');
INSERT INTO public.naring VALUES ('64.302', 'Investeringsselskaper/-fond åpne for allmennheten', 'Innvest/fond åpne for allmennheten');
INSERT INTO public.naring VALUES ('64.305', 'Forvaltningsstiftelser for fond og legater opprettet for veldedige og allmennyttige formål, men som selv ikke fordeler støtte', 'Fond/leg. for allmennyttige formål');
INSERT INTO public.naring VALUES ('64.306', 'Aktive eierfond', 'Aktive eierfond');
INSERT INTO public.naring VALUES ('64.308', 'Investeringsselskaper o.l. lukket for allmennheten', 'Invest. o.l. lukket for allmennheten');
INSERT INTO public.naring VALUES ('64.910', 'Finansiell leasing', 'Finansiell leasing');
INSERT INTO public.naring VALUES ('64.920', 'Annen kredittgivning', 'Annen kredittgiving');
INSERT INTO public.naring VALUES ('64.990', 'Annen finansieringsvirksomhet ikke nevnt annet sted', 'Finansieringsvirksomhet el.');
INSERT INTO public.naring VALUES ('65', 'Forsikringsvirksomhet og pensjonskasser, unntatt trygdeordninger underlagt offentlig forvaltning', 'Forsikring og pensjonskasser');
INSERT INTO public.naring VALUES ('65.1', 'Forsikring', 'Forsikring');
INSERT INTO public.naring VALUES ('65.2', 'Gjenforsikring', 'Gjenforsikring');
INSERT INTO public.naring VALUES ('65.3', 'Pensjonskasser', 'Pensjonskasser');
INSERT INTO public.naring VALUES ('65.11', 'Livsforsikring', 'Livsforsikring');
INSERT INTO public.naring VALUES ('65.12', 'Skadeforsikring', 'Skadeforsikring');
INSERT INTO public.naring VALUES ('65.20', 'Gjenforsikring', 'Gjenforsikring');
INSERT INTO public.naring VALUES ('65.30', 'Pensjonskasser', 'Pensjonskasser');
INSERT INTO public.naring VALUES ('65.110', 'Livsforsikring', 'Livsforsikring');
INSERT INTO public.naring VALUES ('65.120', 'Skadeforsikring', 'Skadeforsikring');
INSERT INTO public.naring VALUES ('65.200', 'Gjenforsikring', 'Gjenforsikring');
INSERT INTO public.naring VALUES ('65.300', 'Pensjonskasser', 'Pensjonskasser');
INSERT INTO public.naring VALUES ('66', 'Tjenester tilknyttet finansierings- og forsikringsvirksomhet', 'Finans-, forsikringshjelpetjenester');
INSERT INTO public.naring VALUES ('66.1', 'Tjenester tilknyttet finansieringsvirksomhet', 'Tjen. tilkn. finansieringsvirks.');
INSERT INTO public.naring VALUES ('66.2', 'Tjenester tilknyttet forsikringsvirksomhet og pensjonskasser', 'Tjen. til forsikr./pensjonskasser');
INSERT INTO public.naring VALUES ('66.3', 'Fondsforvaltningsvirksomhet', 'Fondsforvaltningsvirksomhet');
INSERT INTO public.naring VALUES ('66.11', 'Administrasjon av finansmarkeder', 'Administrasjon av finansmarkeder');
INSERT INTO public.naring VALUES ('66.12', 'Verdipapirmegling', 'Verdipapirmegling');
INSERT INTO public.naring VALUES ('66.19', 'Andre tjenester tilknyttet finansieringsvirksomhet', 'Tjen. tilkn. finansieringsvirks. el.');
INSERT INTO public.naring VALUES ('66.21', 'Risiko- og skadevurdering', 'Risiko- og skadevurdering');
INSERT INTO public.naring VALUES ('66.22', 'Forsikringsformidling', 'Forsikringsformidling');
INSERT INTO public.naring VALUES ('66.29', 'Andre tjenester tilknyttet forsikringsvirksomhet og pensjonskasser', 'Tjen. fors.virks./pensj.kasser el.');
INSERT INTO public.naring VALUES ('66.30', 'Fondsforvaltningsvirksomhet', 'Fondsforvaltningsvirksomhet');
INSERT INTO public.naring VALUES ('66.110', 'Administrasjon av finansmarkeder', 'Administrasjon av finansmarkeder');
INSERT INTO public.naring VALUES ('66.120', 'Verdipapirmegling', 'Verdipapirmegling');
INSERT INTO public.naring VALUES ('66.190', 'Andre tjenester tilknyttet finansieringsvirksomhet', 'Tjen. tilkn. finansieringsvirks. el.');
INSERT INTO public.naring VALUES ('66.210', 'Risiko- og skadevurdering', 'Risiko- og skadevurdering');
INSERT INTO public.naring VALUES ('66.220', 'Forsikringsformidling', 'Forsikringsformidling');
INSERT INTO public.naring VALUES ('66.290', 'Andre tjenester tilknyttet forsikringsvirksomhet og pensjonskasser', 'Tjen. fors.virks./pensj.kasser el.');
INSERT INTO public.naring VALUES ('66.300', 'Fondsforvaltningsvirksomhet', 'Fondsforvaltningsvirksomhet');
INSERT INTO public.naring VALUES ('68', 'Omsetning og drift av fast eiendom', 'Omsetning og drift av fast eiendom');
INSERT INTO public.naring VALUES ('68.1', 'Kjøp og salg av egen fast eiendom', 'Kjøp/salg av egen fast eiendom');
INSERT INTO public.naring VALUES ('68.2', 'Utleie av egen eller leid fast eiendom', 'Utleie av egen/leid fast eiendom');
INSERT INTO public.naring VALUES ('68.3', 'Omsetning og drift av fast eiendom på oppdrag', 'Oppdragsvirksomhet for fast eiendom');
INSERT INTO public.naring VALUES ('68.10', 'Kjøp og salg av egen fast eiendom', 'Kjøp/salg av egen fast eiendom');
INSERT INTO public.naring VALUES ('68.20', 'Utleie av egen eller leid fast eiendom', 'Utleie av egen/leid fast eiendom');
INSERT INTO public.naring VALUES ('68.31', 'Eiendomsmegling', 'Eiendomsmegling');
INSERT INTO public.naring VALUES ('68.32', 'Eiendomsforvaltning', 'Eiendomsforvaltning');
INSERT INTO public.naring VALUES ('68.100', 'Kjøp og salg av egen fast eiendom', 'Kjøp/salg av egen fast eiendom');
INSERT INTO public.naring VALUES ('68.201', 'Borettslag', 'Borettslag');
INSERT INTO public.naring VALUES ('68.209', 'Utleie av egen eller leid fast eiendom ellers', 'Utl. av egen/leid fast eiendom el.');
INSERT INTO public.naring VALUES ('68.320', 'Eiendomsforvaltning', 'Eiendomsforvaltning');
INSERT INTO public.naring VALUES ('69', 'Juridisk og regnskapsmessig tjenesteyting', 'Juridisk og regnsk.messig tj.yting');
INSERT INTO public.naring VALUES ('69.1', 'Juridisk tjenesteyting', 'Juridisk tjenesteyting');
INSERT INTO public.naring VALUES ('69.2', 'Regnskap, revisjon og skatterådgivning', 'Regnskap/revisjon/skatterådgiv.');
INSERT INTO public.naring VALUES ('69.10', 'Juridisk tjenesteyting', 'Juridisk tjenesteyting');
INSERT INTO public.naring VALUES ('69.20', 'Regnskap, revisjon og skatterådgivning', 'Regnskap/revisjon/skatterådgiv.');
INSERT INTO public.naring VALUES ('69.100', 'Juridisk tjenesteyting', 'Juridisk tjenesteyting');
INSERT INTO public.naring VALUES ('69.201', 'Regnskap og bokføring', 'Regnskap og bokføring');
INSERT INTO public.naring VALUES ('69.202', 'Revisjon', 'Revisjon');
INSERT INTO public.naring VALUES ('69.203', 'Skatterådgivning', 'Skatterådgivning');
INSERT INTO public.naring VALUES ('70', 'Hovedkontortjenester, administrativ rådgivning', 'Hovedkontortjen. og adm. rådgivning');
INSERT INTO public.naring VALUES ('70.1', 'Hovedkontortjenester', 'Hovedkontortjenester');
INSERT INTO public.naring VALUES ('70.2', 'Administrativ rådgivning', 'Administrativ rådgivning');
INSERT INTO public.naring VALUES ('70.10', 'Hovedkontortjenester', 'Hovedkontortjenester');
INSERT INTO public.naring VALUES ('70.21', 'PR og kommunikasjonstjenester', 'PR og kommunikasjonstjenester');
INSERT INTO public.naring VALUES ('70.22', 'Bedriftsrådgivning og annen administrativ rådgivning', 'Bedriftsrådgiv./annen adm. rådgiv.');
INSERT INTO public.naring VALUES ('70.100', 'Hovedkontortjenester', 'Hovedkontortjenester');
INSERT INTO public.naring VALUES ('70.210', 'PR og kommunikasjonstjenester', 'PR og kommunikasjonstjenester');
INSERT INTO public.naring VALUES ('70.220', 'Bedriftsrådgivning og annen administrativ rådgivning', 'Bedriftsrådgiv./annen adm. rådgiv.');
INSERT INTO public.naring VALUES ('71', 'Arkitektvirksomhet og teknisk konsulentvirksomhet, og teknisk prøving og analyse', 'Arkitekter og tekniske konsulenter');
INSERT INTO public.naring VALUES ('71.1', 'Arkitektvirksomhet og teknisk konsulentvirksomhet', 'Arkitekt- og tekn. konsulentvirks.');
INSERT INTO public.naring VALUES ('71.2', 'Teknisk prøving og analyse', 'Teknisk prøving og analyse');
INSERT INTO public.naring VALUES ('71.11', 'Arkitektvirksomhet', 'Arkitektvirksomhet');
INSERT INTO public.naring VALUES ('71.12', 'Teknisk konsulentvirksomhet', 'Teknisk konsulentvirksomhet');
INSERT INTO public.naring VALUES ('71.20', 'Teknisk prøving og analyse', 'Teknisk prøving og analyse');
INSERT INTO public.naring VALUES ('71.111', 'Plan- og reguleringsarbeid', 'Plan- og reguleringsarbeid');
INSERT INTO public.naring VALUES ('71.112', 'Arkitekttjenester vedrørende byggverk', 'Arkitekttjen. vedr. byggverk');
INSERT INTO public.naring VALUES ('71.113', 'Landskapsarkitekttjenester', 'Landskapsarkitekttjenester');
INSERT INTO public.naring VALUES ('71.121', 'Byggeteknisk konsulentvirksomhet', 'Byggeteknisk konsulentvirks.');
INSERT INTO public.naring VALUES ('71.122', 'Geologiske undersøkelser', 'Geologiske undersøkelser');
INSERT INTO public.naring VALUES ('71.123', 'Kart og oppmåling', '');
INSERT INTO public.naring VALUES ('71.129', 'Annen teknisk konsulentvirksomhet', 'Annen teknisk konsulentvirks.');
INSERT INTO public.naring VALUES ('71.200', 'Teknisk prøving og analyse', 'Teknisk prøving og analyse');
INSERT INTO public.naring VALUES ('72', 'Forskning og utviklingsarbeid', 'Forskning og utviklingsarbeid');
INSERT INTO public.naring VALUES ('72.1', 'Forskning og utviklingsarbeid innen naturvitenskap og teknikk', 'Forskning naturvitenskap, teknikk');
INSERT INTO public.naring VALUES ('72.2', 'Forskning og utviklingsarbeid innen samfunnsvitenskap og humanistiske fag', 'Forskning samfunnsvit., human. fag');
INSERT INTO public.naring VALUES ('72.11', 'Forskning og utviklingsarbeid innen bioteknologi', 'Forsk./utvikl.arb. innen bioteknologi');
INSERT INTO public.naring VALUES ('72.19', 'Annen forskning og annet utviklingsarbeid innen naturvitenskap og teknikk', 'Annen forsk. innen naturvit. og teknikk');
INSERT INTO public.naring VALUES ('72.20', 'Forskning og utviklingsarbeid innen samfunnsvitenskap og humanistiske fag', 'Forskning samfunnsvit., human. fag');
INSERT INTO public.naring VALUES ('72.110', 'Forskning og utviklingsarbeid innen bioteknologi', 'Forsk./utvikl.arb. innen bioteknologi');
INSERT INTO public.naring VALUES ('72.190', 'Annen forskning og annet utviklingsarbeid innen naturvitenskap og teknikk', 'Annen forsk. innen naturvit. og teknikk');
INSERT INTO public.naring VALUES ('72.200', 'Forskning og utviklingsarbeid innen samfunnsvitenskap og humanistiske fag', 'Forskning samfunnsvit., human. fag');
INSERT INTO public.naring VALUES ('73', 'Annonse- og reklamevirksomhet og markedsundersøkelser', 'Reklamevirksomhet og markedsund.');
INSERT INTO public.naring VALUES ('73.1', 'Annonse- og reklamevirksomhet', 'Annonse- og reklamevirksomhet');
INSERT INTO public.naring VALUES ('73.2', 'Markeds- og opinionsundersøkelser', 'Markeds- og opinionsundersøkelser');
INSERT INTO public.naring VALUES ('73.11', 'Reklamebyråer', 'Reklamebyråer');
INSERT INTO public.naring VALUES ('73.12', 'Medieformidlingstjenester', 'Medieformidlingstjenester');
INSERT INTO public.naring VALUES ('73.20', 'Markeds- og opinionsundersøkelser', 'Markeds- og opinionsundersøkelser');
INSERT INTO public.naring VALUES ('73.110', 'Reklamebyråer', 'Reklamebyråer');
INSERT INTO public.naring VALUES ('73.120', 'Medieformidlingstjenester', 'Medieformidlingstjenester');
INSERT INTO public.naring VALUES ('73.200', 'Markeds- og opinionsundersøkelser', 'Markeds- og opinionsundersøkelser');
INSERT INTO public.naring VALUES ('74', 'Annen faglig, vitenskapelig og teknisk virksomhet', 'Fagl., vit. og tekn. virks. ellers');
INSERT INTO public.naring VALUES ('74.1', 'Spesialisert designvirksomhet', 'Spesialisert designvirksomhet');
INSERT INTO public.naring VALUES ('74.2', 'Fotografvirksomhet', 'Fotografvirksomhet');
INSERT INTO public.naring VALUES ('74.3', 'Oversettelses- og tolkevirksomhet', 'Oversettelses- og tolkevirksomhet');
INSERT INTO public.naring VALUES ('74.9', 'Annen faglig, vitenskapelig og teknisk virksomhet', 'Annen faglig/vit.skap./tekn. virks.');
INSERT INTO public.naring VALUES ('74.10', 'Spesialisert designvirksomhet', 'Spesialisert designvirksomhet');
INSERT INTO public.naring VALUES ('74.20', 'Fotografvirksomhet', 'Fotografvirksomhet');
INSERT INTO public.naring VALUES ('74.30', 'Oversettelses- og tolkevirksomhet', 'Oversettelses- og tolkevirksomhet');
INSERT INTO public.naring VALUES ('74.90', 'Annen faglig, vitenskapelig og teknisk virksomhet', 'Annen faglig/vit.skap./tekn. virks.');
INSERT INTO public.naring VALUES ('74.101', 'Industridesign, produktdesign og annen teknisk designvirksomhet', 'Ind.-/produkt-/tekn.designvirks el');
INSERT INTO public.naring VALUES ('74.102', 'Grafisk og visuell kommunikasjonsdesign', 'Grafisk/visuell kommunikasj.design');
INSERT INTO public.naring VALUES ('74.103', 'Interiørarkitekt-, interiørdesign- og interiørkonsulentvirksomhet', 'Interiørark./-design/interiørkons.');
INSERT INTO public.naring VALUES ('74.200', 'Fotografvirksomhet', 'Fotografvirksomhet');
INSERT INTO public.naring VALUES ('74.300', 'Oversettelses- og tolkevirksomhet', 'Oversettelses- og tolkevirksomhet');
INSERT INTO public.naring VALUES ('74.901', 'Takseringsvirksomhet', 'Takseringsvirksomhet');
INSERT INTO public.naring VALUES ('74.902', 'Modellbyråvirksomhet', 'Modellbyråvirksomhet');
INSERT INTO public.naring VALUES ('74.903', 'Impresariovirksomhet', 'Impresariovirksomhet');
INSERT INTO public.naring VALUES ('74.909', 'Annen faglig, vitenskapelig og teknisk virksomhet ikke nevnt annet sted', 'Faglig/vit.skapelig/tekn.virks. el.');
INSERT INTO public.naring VALUES ('75', 'Veterinærtjenester', 'Veterinærtjenester');
INSERT INTO public.naring VALUES ('75.0', 'Veterinærtjenester', 'Veterinærtjenester');
INSERT INTO public.naring VALUES ('75.00', 'Veterinærtjenester', 'Veterinærtjenester');
INSERT INTO public.naring VALUES ('75.000', 'Veterinærtjenester', 'Veterinærtjenester');
INSERT INTO public.naring VALUES ('77', 'Utleie- og leasingvirksomhet', 'Utleie- og leasingvirksomhet');
INSERT INTO public.naring VALUES ('77.1', 'Utleie og leasing av motorvogner', 'Bilutleie');
INSERT INTO public.naring VALUES ('77.2', 'Utleie og leasing av husholdningsvarer og varer til personlig bruk', 'Utl. hush.varer og varer pers. bruk');
INSERT INTO public.naring VALUES ('77.3', 'Utleie og leasing av andre maskiner, og annet utstyr og materiell', 'Utleie av maskiner og utstyr ellers');
INSERT INTO public.naring VALUES ('77.4', 'Leasing av immateriell eiendom og lignende produkter, unntatt opphavsrettsbeskyttede verker', 'Leas. av immateriell eiendom mv.');
INSERT INTO public.naring VALUES ('85.594', 'Voksenopplæringssentre', 'Voksenopplæringssentre');
INSERT INTO public.naring VALUES ('77.11', 'Utleie og leasing av biler og andre lette motorvogner', 'Utl./leas. biler/andre lette motorv.');
INSERT INTO public.naring VALUES ('77.12', 'Utleie og leasing av lastebiler', 'Utleie og leasing av lastebiler');
INSERT INTO public.naring VALUES ('77.21', 'Utleie og leasing av sports- og fritidsutstyr', 'Utl./leas. sports- og fritidsutstyr');
INSERT INTO public.naring VALUES ('77.22', 'Utleie av videofilm, DVD og lignende', 'Utleie videofilm, DVD og lignende');
INSERT INTO public.naring VALUES ('77.29', 'Utleie og leasing av andre husholdningsvarer og varer til personlig bruk', 'Utl./leas. husholdningsvarer el.');
INSERT INTO public.naring VALUES ('77.31', 'Utleie og leasing av landbruksmaskiner og -utstyr', 'Utl./leas. landbruksmaskiner og -utstyr');
INSERT INTO public.naring VALUES ('77.32', 'Utleie og leasing av bygge- og anleggsmaskiner og -utstyr', 'Utl./leas. bygge- og anleggsmask.');
INSERT INTO public.naring VALUES ('77.33', 'Utleie og leasing av kontor- og datamaskiner', 'Utl./leas. kontor- og datamaskiner');
INSERT INTO public.naring VALUES ('77.34', 'Utleie og leasing av sjøtransportmateriell', 'Utl./leas. sjøtransportmateriell');
INSERT INTO public.naring VALUES ('77.35', 'Utleie og leasing av lufttransportmateriell', 'Utl./leas. lufttransportmateriell');
INSERT INTO public.naring VALUES ('77.39', 'Utleie og leasing av andre maskiner og annet utstyr og materiell ikke nevnt annet sted', 'Utl./leas. andre mask./annet utstyr');
INSERT INTO public.naring VALUES ('77.40', 'Leasing av immateriell eiendom og lignende produkter, unntatt opphavsrettsbeskyttede verker', 'Leas. av immateriell eiendom mv.');
INSERT INTO public.naring VALUES ('77.110', 'Utleie og leasing av biler og andre lette motorvogner', 'Utl./leas. biler/andre lette motorv.');
INSERT INTO public.naring VALUES ('77.120', 'Utleie og leasing av lastebiler', 'Utleie og leasing av lastebiler');
INSERT INTO public.naring VALUES ('77.210', 'Utleie og leasing av sports- og fritidsutstyr', 'Utl./leas. sports- og fritidsutstyr');
INSERT INTO public.naring VALUES ('77.220', 'Utleie av videofilm, DVD og lignende', 'Utleie videofilm, DVD og lignende');
INSERT INTO public.naring VALUES ('77.290', 'Utleie og leasing av andre husholdningsvarer og varer til personlig bruk', 'Utl./leas. husholdningsvarer el.');
INSERT INTO public.naring VALUES ('77.310', 'Utleie og leasing av landbruksmaskiner og -utstyr', 'Utl./leas. landbruksmaskiner og -utstyr');
INSERT INTO public.naring VALUES ('77.320', 'Utleie og leasing av bygge- og anleggsmaskiner og -utstyr', 'Utl./leas. bygge- og anleggsmask.');
INSERT INTO public.naring VALUES ('77.330', 'Utleie og leasing av kontor- og datamaskiner', 'Utl./leas. kontor- og datamaskiner');
INSERT INTO public.naring VALUES ('77.340', 'Utleie og leasing av sjøtransportmateriell', 'Utl./leas. sjøtransportmateriell');
INSERT INTO public.naring VALUES ('77.350', 'Utleie og leasing av lufttransportmateriell', 'Utl./leas. lufttransportmateriell');
INSERT INTO public.naring VALUES ('77.390', 'Utleie og leasing av andre maskiner og annet utstyr og materiell ikke nevnt annet sted', 'Utl./leas. andre mask./annet utstyr');
INSERT INTO public.naring VALUES ('77.400', 'Leasing av immateriell eiendom og lignende produkter, unntatt opphavsrettsbeskyttede verker', 'Leas. av immateriell eiendom mv.');
INSERT INTO public.naring VALUES ('78', 'Arbeidskrafttjenester', 'Arbeidskrafttjenester');
INSERT INTO public.naring VALUES ('78.1', 'Rekruttering og formidling av arbeidskraft', 'Rekrutt./formidling av arbeidskraft');
INSERT INTO public.naring VALUES ('78.2', 'Utleie av arbeidskraft', 'Utleie av arbeidskraft');
INSERT INTO public.naring VALUES ('78.3', 'Andre personaladministrative tjenester', 'Andre personaladm. tjen.');
INSERT INTO public.naring VALUES ('78.10', 'Rekruttering og formidling av arbeidskraft', 'Rekrutt./formidling av arbeidskraft');
INSERT INTO public.naring VALUES ('78.20', 'Utleie av arbeidskraft', 'Utleie av arbeidskraft');
INSERT INTO public.naring VALUES ('78.30', 'Andre personaladministrative tjenester', 'Andre personaladm. tjen.');
INSERT INTO public.naring VALUES ('78.100', 'Rekruttering og formidling av arbeidskraft', 'Rekrutt./formidling av arbeidskraft');
INSERT INTO public.naring VALUES ('78.200', 'Utleie av arbeidskraft', 'Utleie av arbeidskraft');
INSERT INTO public.naring VALUES ('78.300', 'Andre personaladministrative tjenester', 'Andre personaladm. tjen.');
INSERT INTO public.naring VALUES ('79', 'Reisebyrå- og reisearrangørvirksomhet og tilknyttede tjenester', 'Reisebyråer og reisearrangører');
INSERT INTO public.naring VALUES ('79.1', 'Reisebyrå- og reisearrangørvirksomhet', 'Reisebyrå- og reisearrangørvirks.');
INSERT INTO public.naring VALUES ('79.9', 'Annen arrangørvirksomhet og tilknyttede tjenester', 'Annen arrangørvirks. og tilkn.tjen.');
INSERT INTO public.naring VALUES ('79.11', 'Reisebyråvirksomhet', 'Reisebyråvirksomhet');
INSERT INTO public.naring VALUES ('79.12', 'Reisearrangørvirksomhet', 'Reisearrangørvirksomhet');
INSERT INTO public.naring VALUES ('79.90', 'Annen arrangørvirksomhet og tilknyttede tjenester', 'Annen arrangørvirks. og tilkn. tjen.');
INSERT INTO public.naring VALUES ('79.110', 'Reisebyråvirksomhet', 'Reisebyråvirksomhet');
INSERT INTO public.naring VALUES ('79.120', 'Reisearrangørvirksomhet', 'Reisearrangørvirksomhet');
INSERT INTO public.naring VALUES ('79.901', 'Turistkontorvirksomhet og destinasjonsselskaper', 'Turistkontorvirks./destinasj.selsk.');
INSERT INTO public.naring VALUES ('79.902', 'Guider og reiseledere', 'Guider og reiseledere');
INSERT INTO public.naring VALUES ('79.903', 'Opplevelses-, arrangements- og aktivitetsarrangørvirksomhet', 'Opplevelses-/arrangementsvirks.m.m.');
INSERT INTO public.naring VALUES ('79.909', 'Turistrelaterte tjenester ikke nevnt annet sted', 'Turistrelaterte tjenester el.');
INSERT INTO public.naring VALUES ('80', 'Vakttjeneste og etterforsking', 'Vakttjeneste og etterforsking');
INSERT INTO public.naring VALUES ('80.1', 'Private vakttjenester', 'Private vakttjenester');
INSERT INTO public.naring VALUES ('80.2', 'Tjenester tilknyttet vakttjenester', 'Tjenester tilknyttet vakttjenester');
INSERT INTO public.naring VALUES ('80.3', 'Etterforsking', 'Etterforsking');
INSERT INTO public.naring VALUES ('80.10', 'Private vakttjenester', 'Private vakttjenester');
INSERT INTO public.naring VALUES ('80.20', 'Tjenester tilknyttet vakttjenester', 'Tjenester tilknyttet vakttjenester');
INSERT INTO public.naring VALUES ('80.30', 'Etterforsking', 'Etterforsking');
INSERT INTO public.naring VALUES ('80.100', 'Private vakttjenester', 'Private vakttjenester');
INSERT INTO public.naring VALUES ('80.200', 'Tjenester tilknyttet vakttjenester', 'Tjenester tilknyttet vakttjenester');
INSERT INTO public.naring VALUES ('80.300', 'Etterforsking', 'Etterforsking');
INSERT INTO public.naring VALUES ('81', 'Tjenester tilknyttet eiendomsdrift', 'Tjenester tilknyttet eiendomsdrift');
INSERT INTO public.naring VALUES ('81.1', 'Kombinerte tjenester tilknyttet eiendomsdrift', 'Komb. tjen. tilkn. eiendomsdrift');
INSERT INTO public.naring VALUES ('81.2', 'Rengjøringsvirksomhet', 'Rengjøringsvirksomhet');
INSERT INTO public.naring VALUES ('81.3', 'Beplantning av hager og parkanlegg', 'Beplantning av hager og parkanl.');
INSERT INTO public.naring VALUES ('81.10', 'Kombinerte tjenester tilknyttet eiendomsdrift', 'Komb. tjen. tilkn. eiendomsdrift');
INSERT INTO public.naring VALUES ('81.21', 'Rengjøring av bygninger', 'Rengjøring av bygninger');
INSERT INTO public.naring VALUES ('81.22', 'Utvendig rengjøring av bygninger og industriell rengjøring', 'Utv. rengj. bygn./ind. rengjøring');
INSERT INTO public.naring VALUES ('81.29', 'Annen rengjøringsvirksomhet', 'Annen rengjøringsvirksomhet');
INSERT INTO public.naring VALUES ('81.30', 'Beplantning av hager og parkanlegg', 'Beplantning av hager og parkanl.');
INSERT INTO public.naring VALUES ('81.101', 'Vaktmestertjenester', 'Vaktmestertjenester');
INSERT INTO public.naring VALUES ('81.109', 'Andre kombinerte tjenester tilknyttet eiendomsdrift', 'Andre komb. tjen. tilkn. eiendomsdr.');
INSERT INTO public.naring VALUES ('81.210', 'Rengjøring av bygninger', 'Rengjøring av bygninger');
INSERT INTO public.naring VALUES ('81.220', 'Utvendig rengjøring av bygninger og industriell rengjøring', 'Utv. rengj. bygn./ind. rengjøring');
INSERT INTO public.naring VALUES ('81.291', 'Skadedyrkontroll', 'Skadedyrkontroll');
INSERT INTO public.naring VALUES ('81.299', 'Annen rengjøringsvirksomhet ikke nevnt annet sted', 'Rengjøringsvirksomhet ellers');
INSERT INTO public.naring VALUES ('81.300', 'Beplantning av hager og parkanlegg', 'Beplantning av hager og parkanl.');
INSERT INTO public.naring VALUES ('82', 'Annen forretningsmessig tjenesteyting', 'Forretningsm. tjenesteyt. ellers');
INSERT INTO public.naring VALUES ('82.1', 'Kontortjenester', 'Kontortjenester');
INSERT INTO public.naring VALUES ('85.595', 'Timelærervirksomhet', 'Timelærervirksomhet');
INSERT INTO public.naring VALUES ('82.2', 'Telefonvakttjenester og telefonsalg', 'Telefonvakttjenester/telefonsalg');
INSERT INTO public.naring VALUES ('82.3', 'Kongress-, messe- og utstillingsvirksomhet', 'Kongress-/messe-/utstillingsvirks.');
INSERT INTO public.naring VALUES ('82.9', 'Forretningsmessig tjenesteyting ikke nevnt annet sted', 'Annen forretningsmessig tj.yting');
INSERT INTO public.naring VALUES ('82.11', 'Kombinerte kontortjenester', 'Kombinerte kontortjenester');
INSERT INTO public.naring VALUES ('82.19', 'Fotokopiering, forberedelse av dokumenter og andre spesialiserte kontortjenester', 'Fotokopiering/spes. kontortjen. el.');
INSERT INTO public.naring VALUES ('82.20', 'Telefonvakttjenester og telefonsalg', 'Telefonvakttjenester/telefonsalg');
INSERT INTO public.naring VALUES ('82.30', 'Kongress-, messe- og utstillingsvirksomhet', 'Kongress-/messe-/utstillingsvirks.');
INSERT INTO public.naring VALUES ('82.91', 'Inkasso- og kredittopplysningsvirksomhet', 'Inkasso- og kredittopplysningsvirks.');
INSERT INTO public.naring VALUES ('82.92', 'Pakkevirksomhet', 'Pakkevirksomhet');
INSERT INTO public.naring VALUES ('82.99', 'Annen forretningsmessig tjenesteyting ikke nevnt annet sted', 'Forr.messig tj.yting ikke nevnt el.');
INSERT INTO public.naring VALUES ('82.110', 'Kombinerte kontortjenester', 'Kombinerte kontortjenester');
INSERT INTO public.naring VALUES ('82.190', 'Fotokopiering, forberedelse av dokumenter og andre spesialiserte kontortjenester', 'Fotokopiering/spes. kontortjen. el.');
INSERT INTO public.naring VALUES ('82.201', 'Telefonvakttjenester', 'Telefonvakttjenester');
INSERT INTO public.naring VALUES ('82.202', 'Telefonsalg', 'Telefonsalg');
INSERT INTO public.naring VALUES ('82.300', 'Kongress-, messe- og utstillingsvirksomhet', 'Kongress-/messe-/utstillingsvirks.');
INSERT INTO public.naring VALUES ('82.910', 'Inkasso- og kredittopplysningsvirksomhet', 'Inkasso- og kredittopplysningsvirks.');
INSERT INTO public.naring VALUES ('82.920', 'Pakkevirksomhet', 'Pakkevirksomhet');
INSERT INTO public.naring VALUES ('82.990', 'Annen forretningsmessig tjenesteyting ikke nevnt annet sted', 'Forr.messig tj.yting ikke nevnt el.');
INSERT INTO public.naring VALUES ('84', 'Offentlig administrasjon og forsvar, og trygdeordninger underlagt offentlig forvaltning', 'Off.adm., forsvar, sosialforsikring');
INSERT INTO public.naring VALUES ('84.1', 'Offentlig administrasjon og forvaltning', 'Off. administrasjon, forvaltning');
INSERT INTO public.naring VALUES ('84.2', 'Offentlig administrasjon tilknyttet utenriks- og sikkerhetssaker', 'Off.adm. utenriks-/sikkerhetssaker');
INSERT INTO public.naring VALUES ('84.3', 'Trygdeordninger underlagt offentlig forvaltning', 'Sosialforsikring, trygd');
INSERT INTO public.naring VALUES ('84.11', 'Generell offentlig administrasjon', 'Generell offentlig administrasjon');
INSERT INTO public.naring VALUES ('84.12', 'Offentlig administrasjon tilknyttet helsestell, sosial virksomhet, undervisning, kirke, kultur og miljøvern', 'Off.adm. helse, sos.virks. m.m.');
INSERT INTO public.naring VALUES ('84.13', 'Offentlig administrasjon tilknyttet næringsvirksomhet og arbeidsmarked', 'Off.adm. nær.virks. og arb.marked');
INSERT INTO public.naring VALUES ('84.21', 'Utenrikssaker', 'Utenrikssaker');
INSERT INTO public.naring VALUES ('84.22', 'Forsvar', 'Forsvar');
INSERT INTO public.naring VALUES ('84.23', 'Retts- og fengselsvesen', 'Retts- og fengselsvesen');
INSERT INTO public.naring VALUES ('84.24', 'Politi- og påtalemyndighet', 'Politi- og påtalemyndighet');
INSERT INTO public.naring VALUES ('84.25', 'Brannvern', 'Brannvern');
INSERT INTO public.naring VALUES ('84.30', 'Trygdeordninger underlagt offentlig forvaltning', 'Sosialforsikring, trygd');
INSERT INTO public.naring VALUES ('84.110', 'Generell offentlig administrasjon', 'Generell offentlig administrasjon');
INSERT INTO public.naring VALUES ('84.120', 'Offentlig administrasjon tilknyttet helsestell, sosial virksomhet, undervisning, kirke, kultur og miljøvern', 'Off.adm. helse, sos.virks. m.m.');
INSERT INTO public.naring VALUES ('84.130', 'Offentlig administrasjon tilknyttet næringsvirksomhet og arbeidsmarked', 'Off.adm. nær.virks. og arb.marked');
INSERT INTO public.naring VALUES ('84.210', 'Utenrikssaker', 'Utenrikssaker');
INSERT INTO public.naring VALUES ('84.220', 'Forsvar', 'Forsvar');
INSERT INTO public.naring VALUES ('84.230', 'Retts- og fengselsvesen', 'Retts- og fengselsvesen');
INSERT INTO public.naring VALUES ('84.240', 'Politi- og påtalemyndighet', 'Politi- og påtalemyndighet');
INSERT INTO public.naring VALUES ('84.250', 'Brannvern', 'Brannvern');
INSERT INTO public.naring VALUES ('84.300', 'Trygdeordninger underlagt offentlig forvaltning', 'Sosialforsikring, trygd');
INSERT INTO public.naring VALUES ('85', 'Undervisning', 'Undervisning');
INSERT INTO public.naring VALUES ('85.1', 'Førskoleundervisning', 'Førskoleundervisning');
INSERT INTO public.naring VALUES ('85.2', 'Grunnskoleundervisning', 'Grunnskoleundervisning');
INSERT INTO public.naring VALUES ('85.3', 'Undervisning på videregående skoles nivå', 'Undervisning videregående skoler');
INSERT INTO public.naring VALUES ('85.4', 'Undervisning i høyere utdanning', 'Undervisning i høyere utdanning');
INSERT INTO public.naring VALUES ('85.5', 'Annen undervisning', 'Annen undervisning');
INSERT INTO public.naring VALUES ('85.6', 'Tjenester tilknyttet undervisning', 'Tjenester tilkn. undervisning');
INSERT INTO public.naring VALUES ('85.10', 'Førskoleundervisning', 'Førskoleundervisning');
INSERT INTO public.naring VALUES ('85.20', 'Grunnskoleundervisning', 'Grunnskoleundervisning');
INSERT INTO public.naring VALUES ('85.31', 'Videregående opplæring innen allmennfaglige studieretninger', 'Undervisning i allmennfag');
INSERT INTO public.naring VALUES ('85.32', 'Videregående opplæring innen tekniske og andre yrkesfaglige studieretninger', 'Undervisn. i tekn./yrkesrettede fag');
INSERT INTO public.naring VALUES ('85.41', 'Undervisning ved fagskoler', 'Undervisning ved fagskoler');
INSERT INTO public.naring VALUES ('85.42', 'Undervisning på universitets- og høgskolenivå', 'Undervisning universitet, høgskoler');
INSERT INTO public.naring VALUES ('85.51', 'Undervisning innen idrett og rekreasjon', 'Underv. innen idrett og rekreasjon');
INSERT INTO public.naring VALUES ('85.52', 'Undervisning innen kultur', 'Undervisning innen kultur');
INSERT INTO public.naring VALUES ('85.53', 'Trafikkskoleundervisning', 'Trafikkskoleundervisning');
INSERT INTO public.naring VALUES ('85.59', 'Annen undervisning ikke nevnt annet sted', 'Undervisning el.');
INSERT INTO public.naring VALUES ('85.60', 'Tjenester tilknyttet undervisning', 'Tjenester tilkn. undervisning');
INSERT INTO public.naring VALUES ('85.100', 'Førskoleundervisning', 'Førskoleundervisning');
INSERT INTO public.naring VALUES ('85.201', 'Ordinær grunnskoleundervisning', 'Ordinær grunnskoleundervisning');
INSERT INTO public.naring VALUES ('85.202', 'Spesialskoleundervisning for funksjonshemmede', 'Spes.undervisn. for funksj.hemmede');
INSERT INTO public.naring VALUES ('85.203', 'Kompetansesentra og annen spesialundervisning', 'Kompetansesentra og lignende');
INSERT INTO public.naring VALUES ('85.310', 'Videregående opplæring innen allmennfaglige studieretninger', 'Undervisning i allmennfag');
INSERT INTO public.naring VALUES ('85.320', 'Videregående opplæring innen tekniske og andre yrkesfaglige studieretninger', 'Undervisn. i tekn./yrkesrettede fag');
INSERT INTO public.naring VALUES ('85.410', 'Undervisning ved fagskoler', 'Undervisning ved fagskoler');
INSERT INTO public.naring VALUES ('85.421', 'Undervisning ved universiteter', 'Undervisning ved universiteter');
INSERT INTO public.naring VALUES ('85.422', 'Undervisning ved vitenskapelige høgskoler', 'Underv. ved vit.skap høgskoler');
INSERT INTO public.naring VALUES ('85.423', 'Undervisning ved statlige høgskoler', 'Underv. ved statlige høgskoler');
INSERT INTO public.naring VALUES ('85.424', 'Undervisning ved militære høgskoler', 'Underv. ved militære høgskoler');
INSERT INTO public.naring VALUES ('85.429', 'Undervisning ved andre høgskoler', 'Underv. ved andre høgskoler');
INSERT INTO public.naring VALUES ('85.510', 'Undervisning innen idrett og rekreasjon', 'Underv. innen idrett og rekreasjon');
INSERT INTO public.naring VALUES ('85.521', 'Kommunal kulturskoleundervisning', 'Kommunal kulturskoleunderv.');
INSERT INTO public.naring VALUES ('85.522', 'Undervisning i kunstfag', 'Undervisning i kunstfag');
INSERT INTO public.naring VALUES ('85.529', 'Annen undervisning innen kultur', 'Annen undervisning innen kultur');
INSERT INTO public.naring VALUES ('85.530', 'Trafikkskoleundervisning', 'Trafikkskoleundervisning');
INSERT INTO public.naring VALUES ('85.591', 'Folkehøgskoleundervisning', 'Folkehøgskoleundervisning');
INSERT INTO public.naring VALUES ('85.592', 'Arbeidsmarkedskurs', 'Arbeidsmarkedkurs');
INSERT INTO public.naring VALUES ('85.593', 'Studieforbunds- og frivillige organisasjoners kurs', 'Studieforb.- og friv. organ kurs');
INSERT INTO public.naring VALUES ('85.596', 'Undervisning innen religion', 'Undervisning innen religion');
INSERT INTO public.naring VALUES ('85.599', 'Annen undervisning ikke nevnt annet sted', 'Undervisning ellers');
INSERT INTO public.naring VALUES ('85.601', 'Pedagogisk-psykologisk rådgivningstjeneste', 'Pedag./psyk. rådgivningstjeneste');
INSERT INTO public.naring VALUES ('85.609', 'Andre tjenester tilknyttet undervisning', 'Tjenester tilkn. undervisning el.');
INSERT INTO public.naring VALUES ('86', 'Helsetjenester', 'Helsetjenester');
INSERT INTO public.naring VALUES ('86.1', 'Sykehustjenester', 'Sykehustjenester');
INSERT INTO public.naring VALUES ('86.2', 'Lege- og tannlegetjenester', 'Lege- og tannlegetjenester');
INSERT INTO public.naring VALUES ('86.9', 'Andre helsetjenester', 'Andre helsetjenester');
INSERT INTO public.naring VALUES ('86.10', 'Sykehustjenester', 'Sykehustjenester');
INSERT INTO public.naring VALUES ('86.21', 'Legetjeneste', 'Legetjeneste');
INSERT INTO public.naring VALUES ('86.22', 'Spesialisert legetjeneste', 'Spesialisert legetjeneste');
INSERT INTO public.naring VALUES ('86.23', 'Tannhelsetjenester', 'Tannhelsetjenester');
INSERT INTO public.naring VALUES ('86.90', 'Andre helsetjenester', 'Andre helsetjenester');
INSERT INTO public.naring VALUES ('86.101', 'Alminnelige somatiske sykehus', 'Alminnelige somatiske sykehus');
INSERT INTO public.naring VALUES ('86.102', 'Somatiske spesialsykehus', 'Somatiske spesialsykehus');
INSERT INTO public.naring VALUES ('86.103', 'Andre somatiske spesialinstitusjoner', 'Andre somat. spesialinstitusjoner');
INSERT INTO public.naring VALUES ('86.104', 'Institusjoner i psykisk helsevern for voksne', 'Inst. i psyk helsevern voksne');
INSERT INTO public.naring VALUES ('86.105', 'Institusjoner i psykisk helsevern for barn og unge', 'Inst. psyk. helsevern barn/unge');
INSERT INTO public.naring VALUES ('86.106', 'Rusmiddelinstitusjoner', 'Rusmiddelinstitusjoner');
INSERT INTO public.naring VALUES ('86.107', 'Rehabiliterings- og opptreningsinstitusjoner', 'Rehab.- og opptreningsinstitusjoner');
INSERT INTO public.naring VALUES ('86.211', 'Allmenn legetjeneste', 'Allmenn legetjeneste');
INSERT INTO public.naring VALUES ('86.212', 'Somatiske poliklinikker', 'Somatiske poliklinikker');
INSERT INTO public.naring VALUES ('86.221', 'Spesialisert legetjeneste, unntatt psykiatrisk legetjeneste', 'Spes.legetj., unnt. psykiatrisk');
INSERT INTO public.naring VALUES ('86.222', 'Legetjenester innen psykisk helsevern', 'Legetj. innen psykisk helsevern');
INSERT INTO public.naring VALUES ('86.223', 'Poliklinikker i psykisk helsevern for voksne', 'Poliklin. i psyk. helsevern voksne');
INSERT INTO public.naring VALUES ('86.224', 'Poliklinikker i psykisk helsevern for barn og unge', 'Poliklin. i psyk. helsev. barn/unge');
INSERT INTO public.naring VALUES ('86.225', 'Rusmiddelpoliklinikker', 'Rusmiddelpoliklinikker');
INSERT INTO public.naring VALUES ('86.230', 'Tannhelsetjenester', 'Tannhelsetjenester');
INSERT INTO public.naring VALUES ('86.901', 'Hjemmesykepleie', 'Hjemmesykepleie');
INSERT INTO public.naring VALUES ('86.902', 'Fysioterapitjeneste', 'Fysioterapitjeneste');
INSERT INTO public.naring VALUES ('86.903', 'Helsestasjons- og skolehelsetjeneste', 'Helsestasjons- og skolehelsetjeneste');
INSERT INTO public.naring VALUES ('86.904', 'Annen forebyggende helsetjeneste', 'Annen forebyggende helsetjeneste');
INSERT INTO public.naring VALUES ('86.905', 'Klinisk psykologtjeneste', 'Klinisk psykologtjeneste');
INSERT INTO public.naring VALUES ('86.906', 'Medisinske laboratorietjenester', 'Medisinske laboratorietjenester');
INSERT INTO public.naring VALUES ('86.907', 'Ambulansetjenester', 'Ambulansetjenester');
INSERT INTO public.naring VALUES ('86.909', 'Andre helsetjenester', 'Andre helsetjenester');
INSERT INTO public.naring VALUES ('87', 'Pleie- og omsorgstjenester i institusjon', 'Pleie og omsorg i institusjon');
INSERT INTO public.naring VALUES ('87.1', 'Pleie- og omsorgstjenester i institusjon', 'Pleie- og omsorg i institusjon');
INSERT INTO public.naring VALUES ('87.2', 'Institusjoner og bofellesskap innen omsorg for psykisk utviklingshemmede, psykisk helsearbeid og rusmiddelomsorg', 'Inst./bof.skap psyk.utv.hem. mv.');
INSERT INTO public.naring VALUES ('87.3', 'Institusjoner og bofellesskap innen omsorg for eldre og funksjonshemmede', 'Inst./bofellesskap eldre/funksj.hem.');
INSERT INTO public.naring VALUES ('87.9', 'Andre omsorgsinstitusjoner', 'Andre omsorgsinstitusjoner');
INSERT INTO public.naring VALUES ('87.10', 'Pleie- og omsorgstjenester i institusjon', 'Pleie- og omsorg i institusjon');
INSERT INTO public.naring VALUES ('87.20', 'Institusjoner og bofellesskap innen omsorg for psykisk utviklingshemmede, psykisk helsearbeid og rusmiddelomsorg', 'Inst./bof.skap psyk. utv.hem. mv.');
INSERT INTO public.naring VALUES ('87.30', 'Institusjoner og bofellesskap innen omsorg for eldre og funksjonshemmede', 'Inst./bofellesskap eldre/funksj.hem.');
INSERT INTO public.naring VALUES ('87.90', 'Andre omsorgsinstitusjoner', 'Andre omsorgsinstitusjoner');
INSERT INTO public.naring VALUES ('87.101', 'Somatiske spesialsykehjem', 'Somatiske spesialsykehjem');
INSERT INTO public.naring VALUES ('87.102', 'Somatiske sykehjem', 'Somatiske sykehjem');
INSERT INTO public.naring VALUES ('87.201', 'Psykiatriske sykehjem', 'Psykiatriske sykehjem');
INSERT INTO public.naring VALUES ('87.202', 'Omsorgsinstitusjoner for rusmiddelmisbrukere', 'Omsorgsinst. for rusmiddelmisbruk.');
INSERT INTO public.naring VALUES ('87.203', 'Bofellesskap for psykisk utviklingshemmede', 'Bofellesskap for psyk utv.hemmede');
INSERT INTO public.naring VALUES ('87.301', 'Aldershjem', 'Aldershjem');
INSERT INTO public.naring VALUES ('87.302', 'Bofellesskap for eldre og funksjonshemmede med fast tilknyttet personell hele døgnet', 'Heldøgns pleie eldre/funksjonshem.');
INSERT INTO public.naring VALUES ('87.303', 'Bofellesskap for eldre og funksjonshemmede med fast tilknyttet personell deler av døgnet', 'Deldøgns pleie eldre /funksj.hem.');
INSERT INTO public.naring VALUES ('87.304', 'Avlastningsboliger/-institusjoner', 'Avlastningsboliger/-institusjoner');
INSERT INTO public.naring VALUES ('87.305', 'Barneboliger', 'Barneboliger');
INSERT INTO public.naring VALUES ('87.901', 'Institusjoner innen barne- og ungdomsvern', 'Inst for barne- og ungdomsvern');
INSERT INTO public.naring VALUES ('87.909', 'Omsorgsinstitusjoner ellers', 'Omsorgsinstitusjoner ellers');
INSERT INTO public.naring VALUES ('88', 'Sosiale omsorgstjenester uten botilbud', 'Omsorg uten botilbud, barnehager mv.');
INSERT INTO public.naring VALUES ('88.1', 'Sosialtjenester uten botilbud for eldre og funksjonshemmede', 'Sosialtj. u/botilbud eldre/funksj.hem');
INSERT INTO public.naring VALUES ('88.9', 'Andre sosialtjenester uten botilbud', 'Andre sosialtjen. uten botilbud');
INSERT INTO public.naring VALUES ('88.10', 'Sosialtjenester uten botilbud for eldre og funksjonshemmede', 'Sosialtj. u/botilbud eldre/funksj.hem.');
INSERT INTO public.naring VALUES ('88.91', 'Sosialtjenester uten botilbud for barn og ungdom', 'Sosialtj. u/botilbud barn/ungdom');
INSERT INTO public.naring VALUES ('88.99', 'Andre sosialtjenester uten botilbud ikke nevnt annet sted', 'Sosialtjenester u/botilbud el.');
INSERT INTO public.naring VALUES ('88.101', 'Hjemmehjelp', 'Hjemmehjelp');
INSERT INTO public.naring VALUES ('88.102', 'Dagsentra/aktivitetssentra for eldre og funksjonshemmede', 'Akt.sentra eldre og funksjonshem.');
INSERT INTO public.naring VALUES ('88.103', 'Eldresentre', 'Eldresentre');
INSERT INTO public.naring VALUES ('88.911', 'Barnehager', 'Barnehager');
INSERT INTO public.naring VALUES ('88.912', 'Barneparker og dagmammaer', 'Barneparker og dagmammaer');
INSERT INTO public.naring VALUES ('88.913', 'Skolefritidsordninger', 'Skolefritidsordninger');
INSERT INTO public.naring VALUES ('88.914', 'Fritidsklubber for barn og ungdom', 'Fritidsklubber for barn og ungdom');
INSERT INTO public.naring VALUES ('88.991', 'Barneverntjenester', 'Barneverntjenester');
INSERT INTO public.naring VALUES ('88.992', 'Familieverntjenester', 'Familieverntjenester');
INSERT INTO public.naring VALUES ('88.993', 'Arbeidstrening for ordinært arbeidsmarked', 'Arb.trening for ordinært arb.marked');
INSERT INTO public.naring VALUES ('88.994', 'Varig tilrettelagt arbeid', 'Varig tilrettelagt arbeid');
INSERT INTO public.naring VALUES ('88.995', 'Sosiale velferdsorganisasjoner', 'Sosiale velferdsorganisasjoner');
INSERT INTO public.naring VALUES ('88.996', 'Asylmottak', 'Asylmottak');
INSERT INTO public.naring VALUES ('88.997', 'Sosialtjenester for rusmiddelmisbrukere uten botilbud', 'Sos.tj. rusmisbr. uten botilbud');
INSERT INTO public.naring VALUES ('88.998', 'Kommunale sosialkontortjenester', 'Kommunale sosialkontortjenester');
INSERT INTO public.naring VALUES ('88.999', 'Andre sosialtjenester uten botilbud', 'Andre sosialtjenester uten botilbud');
INSERT INTO public.naring VALUES ('90', 'Kunstnerisk virksomhet og underholdningsvirksomhet', 'Kunstnerisk virks. og underholdning');
INSERT INTO public.naring VALUES ('90.0', 'Kunstnerisk virksomhet og underholdningsvirksomhet', 'Kunstnerisk virks. og underholdning');
INSERT INTO public.naring VALUES ('90.01', 'Utøvende kunstnere og underholdningsvirksomhet', 'Utøv. kunstnere og underhold.virks.');
INSERT INTO public.naring VALUES ('90.02', 'Tjenester tilknyttet underholdningsvirksomhet', 'Tjen. tilkn. underholdningsvirks.');
INSERT INTO public.naring VALUES ('90.03', 'Selvstendig kunstnerisk virksomhet', 'Selvstendig kunstnerisk virks.');
INSERT INTO public.naring VALUES ('90.04', 'Drift av lokaler tilknyttet kunstnerisk virksomhet', 'Drift lokaler tilkn. kunst.virks.');
INSERT INTO public.naring VALUES ('90.011', 'Utøvende kunstnere og underholdningsvirksomhet innen musikk', 'Utøv. kunstnere innen musikk');
INSERT INTO public.naring VALUES ('90.012', 'Utøvende kunstnere og underholdningsvirksomhet innen scenekunst', 'Utøv. kunstnere innen scenekunst');
INSERT INTO public.naring VALUES ('90.019', 'Utøvende kunstnere og underholdningsvirksomhet ikke nevnt annet sted', 'Utøv. kunstnere ellers');
INSERT INTO public.naring VALUES ('90.020', 'Tjenester tilknyttet underholdningsvirksomhet', 'Tjen. tilkn. underholdningsvirks.');
INSERT INTO public.naring VALUES ('90.031', 'Selvstendig kunstnerisk virksomhet innen visuell kunst', 'Selvst. kunst.virks. visuell kunst');
INSERT INTO public.naring VALUES ('90.032', 'Selvstendig kunstnerisk virksomhet innen musikk', 'Selvst. kunst.virks. innen musikk');
INSERT INTO public.naring VALUES ('90.033', 'Selvstendig kunstnerisk virksomhet innen scenekunst', 'Selvst. kunst.virks. scenekunst');
INSERT INTO public.naring VALUES ('90.034', 'Selvstendig kunstnerisk virksomhet innen litteratur', 'Selvst. kunst.virks. litteratur');
INSERT INTO public.naring VALUES ('90.035', 'Selvstendig kunstnerisk virksomhet innen blogging ', 'Selvstendig kunstnerisk virksomhet innen blogging ');
INSERT INTO public.naring VALUES ('90.039', 'Selvstendig kunstnerisk virksomhet ikke nevnt annet sted', 'Annen selvst. kunstnerisk virks.');
INSERT INTO public.naring VALUES ('90.040', 'Drift av lokaler tilknyttet kunstnerisk virksomhet', 'Drift lokaler tilkn. kunst.virks.');
INSERT INTO public.naring VALUES ('91', 'Drift av biblioteker, arkiver, museer og annen kulturvirksomhet', 'Bibliotek, muséer o.a. kulturvirks.');
INSERT INTO public.naring VALUES ('91.0', 'Drift av biblioteker, arkiver, museer og annen kulturvirksomhet', 'Bibliotek, muséer o.a. kulturvirks.');
INSERT INTO public.naring VALUES ('91.01', 'Drift av biblioteker og arkiver', 'Drift av biblioteker og arkiver');
INSERT INTO public.naring VALUES ('91.02', 'Drift av museer', 'Drift av museer');
INSERT INTO public.naring VALUES ('91.03', 'Drift av historiske steder og bygninger og lignende severdigheter', 'Drift av hist. steder og bygn. mv.');
INSERT INTO public.naring VALUES ('91.04', 'Drift av botaniske og zoologiske hager og naturreservater', 'Drift av bot./zool. hager/naturres.');
INSERT INTO public.naring VALUES ('91.011', 'Drift av folkebiblioteker', 'Drift av folkebiblioteker');
INSERT INTO public.naring VALUES ('91.012', 'Drift av fag- og forskningsbiblioteker', 'Drift av fag-/forskningsbiblioteker');
INSERT INTO public.naring VALUES ('91.013', 'Drift av arkiver', 'Drift av arkiver');
INSERT INTO public.naring VALUES ('91.021', 'Drift av kunst- og kunstindustrimuseer', 'Drift av kunst-/kunstindustrimuseer');
INSERT INTO public.naring VALUES ('91.022', 'Drift av kulturhistoriske museer', 'Drift av kulturhistoriske museer');
INSERT INTO public.naring VALUES ('91.023', 'Drift av naturhistoriske museer', 'Drift av naturhistoriske museer');
INSERT INTO public.naring VALUES ('91.029', 'Drift av museer ikke nevnt annet sted', 'Drift av museer ellers');
INSERT INTO public.naring VALUES ('91.030', 'Drift av historiske steder og bygninger og lignende severdigheter', 'Drift av hist. steder og bygn. mv.');
INSERT INTO public.naring VALUES ('91.040', 'Drift av botaniske og zoologiske hager og naturreservater', 'Drift av bot./zool. hager/naturres.');
INSERT INTO public.naring VALUES ('92', 'Lotteri og totalisatorspill', 'Lotteri og totalisatorspill');
INSERT INTO public.naring VALUES ('92.0', 'Lotteri og totalisatorspill', 'Lotteri og totalisatorspill');
INSERT INTO public.naring VALUES ('92.00', 'Lotteri og totalisatorspill', 'Lotteri og totalisatorspill');
INSERT INTO public.naring VALUES ('92.000', 'Lotteri og totalisatorspill', 'Lotteri og totalisatorspill');
INSERT INTO public.naring VALUES ('93', 'Sports- og fritidsaktiviteter og drift av fornøyelsesetablissementer', 'Sports- og fritidsaktiviteter');
INSERT INTO public.naring VALUES ('93.1', 'Sportsaktiviteter', 'Sportsaktiviteter');
INSERT INTO public.naring VALUES ('93.2', 'Fritidsaktiviteter og drift av fornøyelsesetablissementer', 'Fritidsaktiviteter, fornøyelsesetabl.');
INSERT INTO public.naring VALUES ('93.11', 'Drift av idrettsanlegg', 'Drift av idrettsanlegg');
INSERT INTO public.naring VALUES ('93.12', 'Idrettslag og -klubber', 'Idrettslag og -klubber');
INSERT INTO public.naring VALUES ('93.13', 'Treningssentre', 'Treningssentre');
INSERT INTO public.naring VALUES ('93.19', 'Andre sportsaktiviteter', 'Andre sportsaktiviteter');
INSERT INTO public.naring VALUES ('93.21', 'Drift av fornøyelses- og temaparker', 'Drift av fornøyelses- og temaparker');
INSERT INTO public.naring VALUES ('93.29', 'Andre fritidsaktiviteter', 'Andre fritidsaktiviteter');
INSERT INTO public.naring VALUES ('93.110', 'Drift av idrettsanlegg', 'Drift av idrettsanlegg');
INSERT INTO public.naring VALUES ('93.120', 'Idrettslag og -klubber', 'Idrettslag og -klubber');
INSERT INTO public.naring VALUES ('93.130', 'Treningssentre', 'Treningssentre');
INSERT INTO public.naring VALUES ('93.190', 'Andre sportsaktiviteter', 'Andre sportsaktiviteter');
INSERT INTO public.naring VALUES ('93.210', 'Drift av fornøyelses- og temaparker', 'Drift av fornøyelses- og temaparker');
INSERT INTO public.naring VALUES ('93.291', 'Opplevelsesaktiviteter', 'Opplevelsesaktiviteter');
INSERT INTO public.naring VALUES ('93.292', 'Fritidsetablissement', 'Fritidsetablissement');
INSERT INTO public.naring VALUES ('93.299', 'Fritidsvirksomhet ellers', 'Firtidsvirksomhet ellers');
INSERT INTO public.naring VALUES ('94', 'Aktiviteter i medlemsorganisasjoner', 'Aktiviteter i medlemsorgansiasjoner');
INSERT INTO public.naring VALUES ('94.1', 'Næringslivs- og arbeidsgiverorganisasjoner og yrkessammenslutninger', 'Næringslivs-/arbeidsgiverorg mv.');
INSERT INTO public.naring VALUES ('94.2', 'Arbeidstakerorganisasjoner', 'Arbeidstakerorganisasjoner');
INSERT INTO public.naring VALUES ('94.9', 'Aktiviteter i andre medlemsorganisasjoner', 'Aktiviteter i andre medlemsorg.');
INSERT INTO public.naring VALUES ('94.11', 'Næringslivs- og arbeidsgiverorganisasjoner', 'Næringslivs-/arbeidsgiverorg. mv.');
INSERT INTO public.naring VALUES ('94.12', 'Yrkessammenslutninger', 'Yrkessammenslutninger');
INSERT INTO public.naring VALUES ('94.20', 'Arbeidstakerorganisasjoner', 'Arbeidstakerorganisasjoner');
INSERT INTO public.naring VALUES ('94.91', 'Religiøse organisasjoner', 'Religiøse organisasjoner');
INSERT INTO public.naring VALUES ('94.92', 'Partipolitiske organisasjoner', 'Partipolitiske organisasjoner');
INSERT INTO public.naring VALUES ('94.99', 'Aktiviteter i andre medlemsorganisasjoner ikke nevnt annet sted', 'Aktiviteter i andre medlemsorg. el.');
INSERT INTO public.naring VALUES ('94.110', 'Næringslivs- og arbeidsgiverorganisasjoner', 'Næringslivs-/arbeidsgiverorg. mv.');
INSERT INTO public.naring VALUES ('94.120', 'Yrkessammenslutninger', 'Yrkessammenslutninger');
INSERT INTO public.naring VALUES ('94.200', 'Arbeidstakerorganisasjoner', 'Arbeidstakerorganisasjoner');
INSERT INTO public.naring VALUES ('94.910', 'Religiøse organisasjoner', 'Religiøse organisasjoner');
INSERT INTO public.naring VALUES ('94.920', 'Partipolitiske organisasjoner', 'Partipolitiske organisasjoner');
INSERT INTO public.naring VALUES ('94.991', 'Aktiviteter i andre interesseorganisasjoner ikke nevnt annet sted', 'Interesseorganisasjoner ellers');
INSERT INTO public.naring VALUES ('94.992', 'Fond/legat som støtter veldedige og allmennyttige formål', 'Fond/legat allmennyttige formål');
INSERT INTO public.naring VALUES ('95', 'Reparasjon av datamaskiner, husholdningsvarer og varer til personlig bruk', 'Reparasjon av varer til pers. bruk');
INSERT INTO public.naring VALUES ('95.1', 'Reparasjon av datamaskiner og kommunikasjonsutstyr', 'Rep. av datamaskiner og komm.utstyr');
INSERT INTO public.naring VALUES ('95.2', 'Reparasjon av husholdningsvarer og varer til personlig bruk', 'Reparasjon varer personlig bruk');
INSERT INTO public.naring VALUES ('95.11', 'Reparasjon av datamaskiner og tilleggsutstyr', 'Rep. av datamask. og tilleggsutstyr');
INSERT INTO public.naring VALUES ('95.12', 'Reparasjon av kommunikasjonsutstyr', 'Rep. av kommunikasjonsutstyr');
INSERT INTO public.naring VALUES ('95.21', 'Reparasjon av elektronikk til husholdningsbruk', 'Rep. av elektronikk til hush.bruk');
INSERT INTO public.naring VALUES ('95.22', 'Reparasjon av husholdningsvarer og hageredskaper', 'Rep. av hush.varer og hageredskaper');
INSERT INTO public.naring VALUES ('95.23', 'Reparasjon av skotøy og lærvarer', 'Rep. av skotøy og lærvarer');
INSERT INTO public.naring VALUES ('95.24', 'Reparasjon av møbler og boliginnredning', 'Rep. av møbler og boliginnredning');
INSERT INTO public.naring VALUES ('95.25', 'Reparasjon av ur, gull- og sølvvarer', 'Rep. av ur, gull- og sølvvarer');
INSERT INTO public.naring VALUES ('95.29', 'Reparasjon av andre husholdningsvarer og varer til personlig bruk', 'Rep. av husholdningsvarer el.');
INSERT INTO public.naring VALUES ('95.110', 'Reparasjon av datamaskiner og tilleggsutstyr', 'Rep. av datamask. og tilleggsutstyr');
INSERT INTO public.naring VALUES ('95.120', 'Reparasjon av kommunikasjonsutstyr', 'Rep. av kommunikasjonsutstyr');
INSERT INTO public.naring VALUES ('95.210', 'Reparasjon av elektronikk til husholdningsbruk', 'Rep. av elektronikk til hush.bruk');
INSERT INTO public.naring VALUES ('95.220', 'Reparasjon av husholdningsvarer og hageredskaper', 'Rep. av hush.varer og hageredskaper');
INSERT INTO public.naring VALUES ('95.230', 'Reparasjon av skotøy og lærvarer', 'Rep. av skotøy og lærvarer');
INSERT INTO public.naring VALUES ('95.240', 'Reparasjon av møbler og boliginnredning', 'Rep. av møbler og boliginnredning');
INSERT INTO public.naring VALUES ('95.250', 'Reparasjon av ur, gull- og sølvvarer', 'Rep. av ur, gull- og sølvvarer');
INSERT INTO public.naring VALUES ('95.290', 'Reparasjon av andre husholdningsvarer og varer til personlig bruk', 'Rep. av husholdningsvarer el.');
INSERT INTO public.naring VALUES ('96', 'Annen personlig tjenesteyting', 'Annen personlig tjenesteyting');
INSERT INTO public.naring VALUES ('96.0', 'Annen personlig tjenesteyting', 'Annen personlig tjenesteyting');
INSERT INTO public.naring VALUES ('96.01', 'Vaskeri- og renserivirksomhet', 'Vaskeri- og renserivirksomhet');
INSERT INTO public.naring VALUES ('96.02', 'Frisering og annen skjønnhetspleie', 'Frisering og skjønnhetspleie el.');
INSERT INTO public.naring VALUES ('96.03', 'Begravelsesbyråvirksomhet og drift av kirkegårder og krematorier', 'Begrav.byrå, kirkegårdsdrift mv.');
INSERT INTO public.naring VALUES ('96.04', 'Virksomhet knyttet til kroppspleie og fysisk velvære', 'Helsestudiovirksomhet mv..');
INSERT INTO public.naring VALUES ('96.09', 'Personlig tjenesteyting ikke nevnt annet sted', 'Personlig tjenesteyting el.');
INSERT INTO public.naring VALUES ('96.010', 'Vaskeri- og renserivirksomhet', 'Vaskeri- og renserivirksomhet');
INSERT INTO public.naring VALUES ('96.020', 'Frisering og annen skjønnhetspleie', 'Frisering og skjønnhetspleie el.');
INSERT INTO public.naring VALUES ('96.030', 'Begravelsesbyråvirksomhet og drift av kirkegårder og krematorier', 'Begrav.byrå, kirkegårdsdrift mv..');
INSERT INTO public.naring VALUES ('96.040', 'Virksomhet knyttet til kroppspleie og fysisk velvære', 'Helsestudiovirksomhet mv.');
INSERT INTO public.naring VALUES ('96.090', 'Personlig tjenesteyting ikke nevnt annet sted', 'Personlig tjenesteyting el.');
INSERT INTO public.naring VALUES ('97', 'Lønnet arbeid i private husholdninger', 'Lønnet arbeid i private husholdn.');
INSERT INTO public.naring VALUES ('97.0', 'Lønnet arbeid i private husholdninger', 'Lønnet arbeid i private husholdn.');
INSERT INTO public.naring VALUES ('97.00', 'Lønnet arbeid i private husholdninger', 'Lønnet arbeid i private husholdn.');
INSERT INTO public.naring VALUES ('97.000', 'Lønnet arbeid i private husholdninger', 'Lønnet arbeid i private husholdn.');
INSERT INTO public.naring VALUES ('99', 'Internasjonale organisasjoner og organer', 'Internasjonale organer');
INSERT INTO public.naring VALUES ('99.0', 'Internasjonale organisasjoner og organer', 'Internasjonale organer');
INSERT INTO public.naring VALUES ('99.00', 'Internasjonale organisasjoner og organer', 'Internasjonale organer');
INSERT INTO public.naring VALUES ('99.000', 'Internasjonale organisasjoner og organer', 'Internasjonale organer');
INSERT INTO public.naring VALUES ('A', 'Jordbruk, skogbruk og fiske', 'Jordbruk, skogbruk og fiske');
INSERT INTO public.naring VALUES ('B', 'Bergverksdrift og utvinning', 'Bergverksdrift og utvinning');
INSERT INTO public.naring VALUES ('C', 'Industri', 'Industri');
INSERT INTO public.naring VALUES ('D', 'Elektrisitets-, gass-, damp- og varmtvannsforsyning', 'Kraftforsyning');
INSERT INTO public.naring VALUES ('E', 'Vannforsyning, avløps- og renovasjonsvirksomhet', 'Vann, avløp, renovasjon');
INSERT INTO public.naring VALUES ('F', 'Bygge- og anleggsvirksomhet', 'Bygge- og anleggsvirksomhet');
INSERT INTO public.naring VALUES ('G', 'Varehandel, reparasjon av motorvogner', 'Varehandel, bilverksteder');
INSERT INTO public.naring VALUES ('H', 'Transport og lagring', 'Transport og lagring');
INSERT INTO public.naring VALUES ('I', 'Overnattings- og serveringsvirksomhet', 'Overnattings- og serveringsvirks.');
INSERT INTO public.naring VALUES ('J', 'Informasjon og kommunikasjon', 'Informasjon og kommunikasjon');
INSERT INTO public.naring VALUES ('K', 'Finansierings- og forsikringsvirksomhet', 'Finansiering og forsikring');
INSERT INTO public.naring VALUES ('L', 'Omsetning og drift av fast eiendom', 'Omsetning og drift av fast eiendom');
INSERT INTO public.naring VALUES ('M', 'Faglig, vitenskapelig og teknisk tjenesteyting', 'Faglig, vit. og tekn. tjenesteyting');
INSERT INTO public.naring VALUES ('N', 'Forretningsmessig tjenesteyting', 'Forretningsmessig tjenesteyting');
INSERT INTO public.naring VALUES ('O', 'Offentlig administrasjon og forsvar, og trygdeordninger underlagt offentlig forvaltning', 'Off.adm., forsvar, sosialforsikring');
INSERT INTO public.naring VALUES ('P', 'Undervisning', 'Undervisning');
INSERT INTO public.naring VALUES ('Q', 'Helse- og sosialtjenester', 'Helse- og sosialtjenester');
INSERT INTO public.naring VALUES ('R', 'Kulturell virksomhet, underholdning og fritidsaktiviteter', 'Kultur, underholdning og fritid');
INSERT INTO public.naring VALUES ('S', 'Annen tjenesteyting', 'Annen tjenesteyting');
INSERT INTO public.naring VALUES ('T', 'Lønnet arbeid i private husholdninger', 'Lønnet arbeid i private husholdn.');
INSERT INTO public.naring VALUES ('U', 'Internasjonale organisasjoner og organer', 'Internasjonale organer');


--
-- Data for Name: naringsundergrupper_per_bransje; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.naringsundergrupper_per_bransje VALUES ('88.911', 'BARNEHAGER', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.110', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.120', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.130', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.201', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.202', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.203', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.209', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.310', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.320', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.390', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.411', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.412', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.413', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.420', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.510', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.520', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.610', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.620', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.710', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.720', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.730', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.810', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.820', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.830', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.840', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.850', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.860', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.890', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.910', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.920', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.101', 'SYKEHUS', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.102', 'SYKEHUS', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.104', 'SYKEHUS', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.105', 'SYKEHUS', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.106', 'SYKEHUS', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.107', 'SYKEHUS', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('87.101', 'SYKEHJEM', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('87.102', 'SYKEHJEM', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.100', 'TRANSPORT', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.311', 'TRANSPORT', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.391', 'TRANSPORT', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.392', 'TRANSPORT', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.101', 'BYGG', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.109', 'BYGG', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.200', 'BYGG', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.110', 'ANLEGG', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.120', 'ANLEGG', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.130', 'ANLEGG', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.210', 'ANLEGG', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.220', 'ANLEGG', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.910', 'ANLEGG', '2023-09-20 13:19:55.5616');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.990', 'ANLEGG', '2023-09-20 13:19:55.5616');


--
-- Data for Name: sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: siste_publiseringsinfo; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.siste_publiseringsinfo VALUES (1, 2022, 4, '2023-03-02 00:00:00', '2023-06-01 00:00:00', '2023-09-20 13:19:55.444065');
INSERT INTO public.siste_publiseringsinfo VALUES (2, 2023, 1, '2023-06-01 00:00:00', '2023-09-07 00:00:00', '2023-09-20 13:19:55.464135');
INSERT INTO public.siste_publiseringsinfo VALUES (3, 2022, 3, '2022-12-01 00:00:00', '2023-03-02 00:00:00', '2023-09-20 13:19:55.473736');
INSERT INTO public.siste_publiseringsinfo VALUES (4, 2022, 2, '2022-09-08 00:00:00', '2022-12-01 00:00:00', '2023-09-20 13:19:55.473736');
INSERT INTO public.siste_publiseringsinfo VALUES (5, 2022, 1, '2022-06-02 00:00:00', '2022-09-08 00:00:00', '2023-09-20 13:19:55.473736');
INSERT INTO public.siste_publiseringsinfo VALUES (6, 2021, 4, '2022-03-03 00:00:00', '2022-06-02 00:00:00', '2023-09-20 13:19:55.473736');
INSERT INTO public.siste_publiseringsinfo VALUES (7, 2021, 3, '2021-12-02 00:00:00', '2022-03-03 00:00:00', '2023-09-20 13:19:55.473736');
INSERT INTO public.siste_publiseringsinfo VALUES (8, 2023, 2, '2023-09-07 00:00:00', '2023-11-30 00:00:00', '2023-09-20 13:19:55.550651');


--
-- Data for Name: sykefravar_statistikk_bransje; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_kategori_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (1, 'NÆRING', '00', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.340423', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (2, 'NÆRING', '01', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.366969', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (3, 'NÆRING', '02', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.366969', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (4, 'NÆRING', '03', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (5, 'NÆRING', '05', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (6, 'NÆRING', '06', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (7, 'NÆRING', '07', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (8, 'NÆRING', '08', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (9, 'NÆRING', '09', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (10, 'NÆRING', '10', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (11, 'NÆRING', '11', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (12, 'NÆRING', '12', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (13, 'NÆRING', '13', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (14, 'NÆRING', '14', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (15, 'NÆRING', '15', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (16, 'NÆRING', '16', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (17, 'NÆRING', '17', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (18, 'NÆRING', '18', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (19, 'NÆRING', '19', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (20, 'NÆRING', '20', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (21, 'NÆRING', '21', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (22, 'NÆRING', '22', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.382352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (23, 'NÆRING', '23', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.408205', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (24, 'NÆRING', '24', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.408205', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (25, 'NÆRING', '25', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.408205', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (26, 'NÆRING', '26', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.408205', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (27, 'NÆRING', '27', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.419482', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (28, 'NÆRING', '28', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.419482', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (29, 'NÆRING', '29', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.419482', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (30, 'NÆRING', '30', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.419482', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (31, 'NÆRING', '31', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.419482', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (32, 'NÆRING', '32', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.419482', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (33, 'NÆRING', '33', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.419482', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (34, 'NÆRING', '35', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.419482', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (35, 'NÆRING', '36', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.419482', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (36, 'NÆRING', '37', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.434604', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (37, 'NÆRING', '38', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.434604', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (38, 'NÆRING', '39', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.434604', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (39, 'NÆRING', '41', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.434604', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (40, 'NÆRING', '42', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.434604', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (41, 'NÆRING', '43', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.449704', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (42, 'NÆRING', '45', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.449704', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (43, 'NÆRING', '46', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.449704', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (44, 'NÆRING', '47', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.449704', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (45, 'NÆRING', '49', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.463342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (46, 'NÆRING', '50', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.463342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (47, 'NÆRING', '51', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.463342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (48, 'NÆRING', '52', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.463342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (49, 'NÆRING', '53', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.463342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (50, 'NÆRING', '55', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.463342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (51, 'NÆRING', '56', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.463342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (52, 'NÆRING', '58', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.477718', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (53, 'NÆRING', '59', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.477718', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (54, 'NÆRING', '60', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.477718', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (55, 'NÆRING', '61', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.477718', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (56, 'NÆRING', '62', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.477718', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (57, 'NÆRING', '63', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.477718', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (58, 'NÆRING', '64', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.477718', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (59, 'NÆRING', '65', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.477718', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (60, 'NÆRING', '66', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.491099', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (61, 'NÆRING', '68', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.491099', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (62, 'NÆRING', '69', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.491099', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (63, 'NÆRING', '70', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.491099', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (64, 'NÆRING', '71', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.491099', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (65, 'NÆRING', '72', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.491099', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (66, 'NÆRING', '73', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.491099', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (67, 'NÆRING', '74', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.508821', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (68, 'NÆRING', '75', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.508821', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (69, 'NÆRING', '77', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.508821', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (70, 'NÆRING', '78', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.508821', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (71, 'NÆRING', '79', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.508821', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (72, 'NÆRING', '80', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.508821', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (73, 'NÆRING', '81', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.525999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (74, 'NÆRING', '82', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.525999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (75, 'NÆRING', '84', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.525999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (76, 'NÆRING', '85', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.525999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (77, 'NÆRING', '86', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.525999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (78, 'NÆRING', '87', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.525999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (79, 'NÆRING', '88', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.525999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (80, 'NÆRING', '90', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.525999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (81, 'NÆRING', '91', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.536248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (82, 'NÆRING', '92', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.536248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (83, 'NÆRING', '93', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.536248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (84, 'NÆRING', '94', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.536248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (85, 'NÆRING', '95', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.536248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (86, 'NÆRING', '96', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.536248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (87, 'NÆRING', '97', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.536248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (88, 'NÆRING', '99', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:06.536248', 2, 2023);


--
-- Data for Name: sykefravar_statistikk_land; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naring VALUES (1, 2023, 2, '00', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.346993', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (2, 2023, 2, '01', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.369551', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (3, 2023, 2, '02', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.369551', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (4, 2023, 2, '03', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (5, 2023, 2, '05', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (6, 2023, 2, '06', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (7, 2023, 2, '07', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (8, 2023, 2, '08', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (9, 2023, 2, '09', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (10, 2023, 2, '10', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (11, 2023, 2, '11', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (12, 2023, 2, '12', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (13, 2023, 2, '13', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (14, 2023, 2, '14', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (15, 2023, 2, '15', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (16, 2023, 2, '16', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (17, 2023, 2, '17', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (18, 2023, 2, '18', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (19, 2023, 2, '19', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (20, 2023, 2, '20', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (21, 2023, 2, '21', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (22, 2023, 2, '22', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.391052', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (23, 2023, 2, '23', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.411482', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (24, 2023, 2, '24', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.411482', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (25, 2023, 2, '25', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.411482', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (26, 2023, 2, '26', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.411482', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (27, 2023, 2, '27', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.422968', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (28, 2023, 2, '28', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.422968', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (29, 2023, 2, '29', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.422968', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (30, 2023, 2, '30', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.422968', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (31, 2023, 2, '31', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.422968', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (32, 2023, 2, '32', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.422968', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (33, 2023, 2, '33', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.422968', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (34, 2023, 2, '35', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.422968', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (35, 2023, 2, '36', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.422968', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (36, 2023, 2, '37', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.439036', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (37, 2023, 2, '38', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.439036', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (38, 2023, 2, '39', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.439036', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (39, 2023, 2, '41', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.439036', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (40, 2023, 2, '42', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.439036', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (41, 2023, 2, '43', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.453376', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (42, 2023, 2, '45', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.453376', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (43, 2023, 2, '46', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.453376', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (44, 2023, 2, '47', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.453376', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (45, 2023, 2, '49', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.467058', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (46, 2023, 2, '50', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.467058', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (47, 2023, 2, '51', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.467058', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (48, 2023, 2, '52', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.467058', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (49, 2023, 2, '53', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.467058', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (50, 2023, 2, '55', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.467058', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (51, 2023, 2, '56', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.467058', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (52, 2023, 2, '58', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.481696', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (53, 2023, 2, '59', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.481696', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (54, 2023, 2, '60', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.481696', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (55, 2023, 2, '61', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.481696', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (56, 2023, 2, '62', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.481696', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (57, 2023, 2, '63', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.481696', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (58, 2023, 2, '64', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.481696', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (59, 2023, 2, '65', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.481696', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (60, 2023, 2, '66', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.495815', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (61, 2023, 2, '68', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.495815', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (62, 2023, 2, '69', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.495815', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (63, 2023, 2, '70', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.495815', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (64, 2023, 2, '71', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.495815', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (65, 2023, 2, '72', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.495815', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (66, 2023, 2, '73', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.495815', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (67, 2023, 2, '74', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.512066', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (68, 2023, 2, '75', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.512066', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (69, 2023, 2, '77', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.512066', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (70, 2023, 2, '78', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.512066', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (71, 2023, 2, '79', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.512066', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (72, 2023, 2, '80', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.512066', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (73, 2023, 2, '81', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.528323', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (74, 2023, 2, '82', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.528323', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (75, 2023, 2, '84', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.528323', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (76, 2023, 2, '85', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.528323', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (77, 2023, 2, '86', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.528323', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (78, 2023, 2, '87', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.528323', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (79, 2023, 2, '88', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.528323', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (80, 2023, 2, '90', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.528323', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (81, 2023, 2, '91', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.540576', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (82, 2023, 2, '92', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.540576', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (83, 2023, 2, '93', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.540576', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (84, 2023, 2, '94', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.540576', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (85, 2023, 2, '95', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.540576', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (86, 2023, 2, '96', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.540576', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (87, 2023, 2, '97', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.540576', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (88, 2023, 2, '99', 1000, 12500, 250000, 1.5, false, '2023-09-20 13:20:06.540576', NULL);


--
-- Data for Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2023, 2, 6, 9625.6992583168, 125, 1.5, false, '2023-09-20 13:20:11.895751', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2023, 1, 6, 9625.6992583168, 125, 1.5, false, '2023-09-20 13:20:11.900017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2023, 2, 683, 4383.42255338064, 125, 1.5, false, '2023-09-20 13:20:11.905759', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2023, 1, 683, 4383.42255338064, 125, 1.5, false, '2023-09-20 13:20:11.905759', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '555555555', 2023, 2, 274, 4101.83583729133, 125, 1.5, false, '2023-09-20 13:20:11.905759', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '835690072', 2023, 2, 210, 9609.35065143694, 125, 1.5, false, '2023-09-20 13:20:11.905759', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '835690072', 2023, 1, 210, 9609.35065143694, 125, 1.5, false, '2023-09-20 13:20:11.905759', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '851259006', 2023, 2, 42, 357.625612153453, 125, 1.5, false, '2023-09-20 13:20:11.905759', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '851259006', 2023, 1, 42, 357.625612153453, 125, 1.5, false, '2023-09-20 13:20:11.911866', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '891657310', 2023, 2, 42, 4194.42509198739, 125, 1.5, false, '2023-09-20 13:20:11.911866', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '891657310', 2023, 1, 42, 4194.42509198739, 125, 1.5, false, '2023-09-20 13:20:11.911866', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '890069516', 2023, 2, 426, 141.402260611168, 125, 1.5, false, '2023-09-20 13:20:11.911866', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '890069516', 2023, 1, 426, 141.402260611168, 125, 1.5, false, '2023-09-20 13:20:11.917983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '818227880', 2023, 2, 404, 5251.73637985183, 125, 1.5, false, '2023-09-20 13:20:11.917983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '887929660', 2023, 2, 556, 67.7471458493257, 125, 1.5, false, '2023-09-20 13:20:11.917983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '833098223', 2023, 2, 116, 3022.02950167008, 125, 1.5, false, '2023-09-20 13:20:11.917983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '810132798', 2023, 2, 344, 472.676185464675, 125, 1.5, false, '2023-09-20 13:20:11.917983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '865287159', 2023, 2, 926, 9837.92167743065, 125, 1.5, false, '2023-09-20 13:20:11.923516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '812325861', 2023, 2, 16, 8037.59594303541, 125, 1.5, false, '2023-09-20 13:20:11.923516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '854678052', 2023, 2, 667, 3580.76101689166, 125, 1.5, false, '2023-09-20 13:20:11.923516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '826529622', 2023, 2, 935, 9058.22128637638, 125, 1.5, false, '2023-09-20 13:20:11.923516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '896593666', 2023, 2, 305, 949.681364699214, 125, 1.5, false, '2023-09-20 13:20:11.923516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '898415442', 2023, 2, 752, 5615.77856502204, 125, 1.5, false, '2023-09-20 13:20:11.923516', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '847120809', 2023, 2, 773, 6879.77435551197, 125, 1.5, false, '2023-09-20 13:20:11.929523', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '830931807', 2023, 2, 758, 1275.07688479912, 125, 1.5, false, '2023-09-20 13:20:11.929523', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '812705354', 2023, 2, 439, 1029.62995393139, 125, 1.5, false, '2023-09-20 13:20:11.929523', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '876999418', 2023, 2, 358, 1231.33003283524, 125, 1.5, false, '2023-09-20 13:20:11.929523', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '883094378', 2023, 2, 615, 1703.44682420086, 125, 1.5, false, '2023-09-20 13:20:11.929523', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '826578249', 2023, 2, 975, 8705.83788201908, 125, 1.5, false, '2023-09-20 13:20:11.934787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '821779748', 2023, 2, 131, 1659.33139364663, 125, 1.5, false, '2023-09-20 13:20:11.934787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '898304073', 2023, 2, 869, 1774.75141453456, 125, 1.5, false, '2023-09-20 13:20:11.934787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '806055367', 2023, 2, 911, 4762.30530633698, 125, 1.5, false, '2023-09-20 13:20:11.934787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '849267670', 2023, 2, 472, 9990.4916388767, 125, 1.5, false, '2023-09-20 13:20:11.934787', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '814067491', 2023, 2, 115, 8027.52945634693, 125, 1.5, false, '2023-09-20 13:20:11.940235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '827223911', 2023, 2, 671, 9101.20068616073, 125, 1.5, false, '2023-09-20 13:20:11.940235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '852060664', 2023, 2, 278, 4679.65449534442, 125, 1.5, false, '2023-09-20 13:20:11.940235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '828472924', 2023, 2, 158, 5983.15314438781, 125, 1.5, false, '2023-09-20 13:20:11.940235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '802034315', 2023, 2, 62, 4745.47872169434, 125, 1.5, false, '2023-09-20 13:20:11.940235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '821364109', 2023, 2, 113, 6762.48251837865, 125, 1.5, false, '2023-09-20 13:20:11.946084', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '840899793', 2023, 2, 43, 3306.74546009046, 125, 1.5, false, '2023-09-20 13:20:11.946084', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '835831981', 2023, 2, 467, 8223.63257966152, 125, 1.5, false, '2023-09-20 13:20:11.946084', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '834110433', 2023, 2, 970, 4032.4054480228, 125, 1.5, false, '2023-09-20 13:20:11.946084', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '871024289', 2023, 2, 318, 6365.03844517215, 125, 1.5, false, '2023-09-20 13:20:11.951055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '825209846', 2023, 2, 28, 5335.50095001637, 125, 1.5, false, '2023-09-20 13:20:11.951055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '881202253', 2023, 2, 431, 6717.92677659945, 125, 1.5, false, '2023-09-20 13:20:11.951055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '812103300', 2023, 2, 637, 8356.58632542173, 125, 1.5, false, '2023-09-20 13:20:11.951055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '826806454', 2023, 2, 175, 6005.87493721704, 125, 1.5, false, '2023-09-20 13:20:11.951055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '836563069', 2023, 2, 58, 3983.61735214297, 125, 1.5, false, '2023-09-20 13:20:11.951055', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '883569645', 2023, 2, 142, 6313.30521528351, 125, 1.5, false, '2023-09-20 13:20:11.956356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '864282766', 2023, 2, 488, 7560.44635561111, 125, 1.5, false, '2023-09-20 13:20:11.956356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '853470204', 2023, 2, 899, 7437.56797480448, 125, 1.5, false, '2023-09-20 13:20:11.956356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '892154043', 2023, 2, 344, 9726.74863057594, 125, 1.5, false, '2023-09-20 13:20:11.961538', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '884553531', 2023, 2, 129, 9485.09437311621, 125, 1.5, false, '2023-09-20 13:20:11.961538', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '837702175', 2023, 2, 24, 3305.13717225189, 125, 1.5, false, '2023-09-20 13:20:11.961538', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '848135730', 2023, 2, 190, 1940.99054860065, 125, 1.5, false, '2023-09-20 13:20:11.961538', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '843069529', 2023, 2, 940, 8513.65392584943, 125, 1.5, false, '2023-09-20 13:20:11.96666', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '841202354', 2023, 2, 339, 5566.16386177057, 125, 1.5, false, '2023-09-20 13:20:11.96666', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '800661351', 2023, 2, 5, 9270.70458367771, 125, 1.5, false, '2023-09-20 13:20:11.96666', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '852377976', 2023, 2, 182, 7366.34983929656, 125, 1.5, false, '2023-09-20 13:20:11.96666', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '821899473', 2023, 2, 539, 9014.88346081554, 125, 1.5, false, '2023-09-20 13:20:11.97735', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '848304798', 2023, 2, 708, 9366.70800049646, 125, 1.5, false, '2023-09-20 13:20:11.97735', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '827048656', 2023, 2, 111, 8174.04493194989, 125, 1.5, false, '2023-09-20 13:20:11.97735', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '825165311', 2023, 2, 719, 2178.18858547786, 125, 1.5, false, '2023-09-20 13:20:11.97735', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '889921082', 2023, 2, 978, 8378.78648405105, 125, 1.5, false, '2023-09-20 13:20:11.97735', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '834786168', 2023, 2, 143, 6002.76164262808, 125, 1.5, false, '2023-09-20 13:20:11.983101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '889648932', 2023, 2, 272, 3723.28327528466, 125, 1.5, false, '2023-09-20 13:20:11.983101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '846081284', 2023, 2, 433, 5935.96771278882, 125, 1.5, false, '2023-09-20 13:20:11.983101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '899521020', 2023, 2, 977, 4574.65595892779, 125, 1.5, false, '2023-09-20 13:20:11.983101', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '897984578', 2023, 2, 503, 8604.93613577196, 125, 1.5, false, '2023-09-20 13:20:11.988382', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '815452764', 2023, 2, 122, 3544.52359100864, 125, 1.5, false, '2023-09-20 13:20:11.988382', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '845306307', 2023, 2, 985, 1220.19104556739, 125, 1.5, false, '2023-09-20 13:20:11.988382', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '862266403', 2023, 2, 643, 8623.76038693827, 125, 1.5, false, '2023-09-20 13:20:11.988382', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '859743159', 2023, 2, 70, 2945.18696973344, 125, 1.5, false, '2023-09-20 13:20:11.988382', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '836953790', 2023, 2, 455, 7096.15344929073, 125, 1.5, false, '2023-09-20 13:20:11.993877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '809615855', 2023, 2, 790, 4924.05875107289, 125, 1.5, false, '2023-09-20 13:20:11.993877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '882106339', 2023, 2, 872, 1824.45648087485, 125, 1.5, false, '2023-09-20 13:20:11.993877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '847671651', 2023, 2, 500, 153.00449795323, 125, 1.5, false, '2023-09-20 13:20:11.993877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '838086404', 2023, 2, 874, 867.116966226544, 125, 1.5, false, '2023-09-20 13:20:11.993877', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '875335169', 2023, 2, 386, 2038.55523795101, 125, 1.5, false, '2023-09-20 13:20:11.998632', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '885654025', 2023, 2, 838, 4322.3009327766, 125, 1.5, false, '2023-09-20 13:20:11.998632', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '847026988', 2023, 2, 948, 5016.51384072004, 125, 1.5, false, '2023-09-20 13:20:11.998632', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '816378418', 2023, 2, 814, 2876.59685185907, 125, 1.5, false, '2023-09-20 13:20:11.998632', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '897996553', 2023, 2, 561, 2320.58756685406, 125, 1.5, false, '2023-09-20 13:20:12.003631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '800055701', 2023, 2, 464, 660.851925374538, 125, 1.5, false, '2023-09-20 13:20:12.003631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '814989456', 2023, 2, 793, 1985.27954109107, 125, 1.5, false, '2023-09-20 13:20:12.003631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '813772256', 2023, 2, 904, 5582.35528162439, 125, 1.5, false, '2023-09-20 13:20:12.003631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '897580139', 2023, 2, 279, 5412.17422441237, 125, 1.5, false, '2023-09-20 13:20:12.003631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '857663926', 2023, 2, 801, 9774.58500016875, 125, 1.5, false, '2023-09-20 13:20:12.009019', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '820181951', 2023, 2, 448, 9869.61956639776, 125, 1.5, false, '2023-09-20 13:20:12.009019', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '818792472', 2023, 2, 436, 1617.01276213834, 125, 1.5, false, '2023-09-20 13:20:12.009019', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '849137527', 2023, 2, 31, 5055.93424477916, 125, 1.5, false, '2023-09-20 13:20:12.009019', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '888437122', 2023, 2, 324, 3197.89548632546, 125, 1.5, false, '2023-09-20 13:20:12.013976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '847199028', 2023, 2, 109, 9420.55670035788, 125, 1.5, false, '2023-09-20 13:20:12.013976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '802475208', 2023, 2, 489, 6541.64221588068, 125, 1.5, false, '2023-09-20 13:20:12.013976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '873799686', 2023, 2, 183, 2602.0363649002, 125, 1.5, false, '2023-09-20 13:20:12.019549', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '879062037', 2023, 2, 411, 7282.92100826799, 125, 1.5, false, '2023-09-20 13:20:12.019549', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '814256657', 2023, 2, 989, 3573.86851885567, 125, 1.5, false, '2023-09-20 13:20:12.019549', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '891092944', 2023, 2, 844, 3102.5175411343, 125, 1.5, false, '2023-09-20 13:20:12.019549', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '832958392', 2023, 2, 137, 961.813437647635, 125, 1.5, false, '2023-09-20 13:20:12.019549', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '824528008', 2023, 2, 270, 33.8150971424081, 125, 1.5, false, '2023-09-20 13:20:12.02481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '833648500', 2023, 2, 968, 4241.20782192344, 125, 1.5, false, '2023-09-20 13:20:12.02481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '837119021', 2023, 2, 549, 1647.8007454898, 125, 1.5, false, '2023-09-20 13:20:12.02481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '859036595', 2023, 2, 939, 7359.65960974081, 125, 1.5, false, '2023-09-20 13:20:12.02481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '818754298', 2023, 2, 337, 2871.92399889105, 125, 1.5, false, '2023-09-20 13:20:12.029764', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '812704644', 2023, 2, 242, 9677.88006516373, 125, 1.5, false, '2023-09-20 13:20:12.029764', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '819173366', 2023, 2, 246, 6994.37907872625, 125, 1.5, false, '2023-09-20 13:20:12.029764', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '850862665', 2023, 2, 477, 5050.47418161251, 125, 1.5, false, '2023-09-20 13:20:12.029764', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '848077518', 2023, 2, 290, 8070.51603704523, 125, 1.5, false, '2023-09-20 13:20:12.029764', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '878236994', 2023, 2, 761, 1427.51996887801, 125, 1.5, false, '2023-09-20 13:20:12.035133', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '877412476', 2023, 2, 341, 4034.68916463395, 125, 1.5, false, '2023-09-20 13:20:12.035133', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '856276748', 2023, 2, 47, 4367.18987061331, 125, 1.5, false, '2023-09-20 13:20:12.035133', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '831572234', 2023, 2, 108, 2427.03795263877, 125, 1.5, false, '2023-09-20 13:20:12.035133', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '889067758', 2023, 2, 446, 1515.49833998425, 125, 1.5, false, '2023-09-20 13:20:12.035133', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '804216935', 2023, 2, 590, 2361.4663392331, 125, 1.5, false, '2023-09-20 13:20:12.040698', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '806865325', 2023, 2, 861, 7444.79001488999, 125, 1.5, false, '2023-09-20 13:20:12.040698', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '815297831', 2023, 2, 338, 9739.29065130366, 125, 1.5, false, '2023-09-20 13:20:12.040698', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '857456187', 2023, 2, 312, 226.906814538609, 125, 1.5, false, '2023-09-20 13:20:12.040698', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '853108988', 2023, 2, 150, 3267.85338067816, 125, 1.5, false, '2023-09-20 13:20:12.046706', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '879916784', 2023, 2, 81, 347.025668375112, 125, 1.5, false, '2023-09-20 13:20:12.046706', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '823976938', 2023, 2, 552, 8392.8171126791, 125, 1.5, false, '2023-09-20 13:20:12.046706', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '853659393', 2023, 2, 382, 8107.13037337452, 125, 1.5, false, '2023-09-20 13:20:12.046706', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '831217959', 2023, 2, 837, 5670.11003131196, 125, 1.5, false, '2023-09-20 13:20:12.046706', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '882165409', 2023, 2, 72, 2379.45105894379, 125, 1.5, false, '2023-09-20 13:20:12.046706', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '815785458', 2023, 2, 755, 2419.54973489649, 125, 1.5, false, '2023-09-20 13:20:12.051693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '846634644', 2023, 2, 418, 6369.17764623824, 125, 1.5, false, '2023-09-20 13:20:12.051693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '855681292', 2023, 2, 796, 3217.54594070926, 125, 1.5, false, '2023-09-20 13:20:12.051693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '830105110', 2023, 2, 334, 6652.86015952977, 125, 1.5, false, '2023-09-20 13:20:12.057148', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '880754152', 2023, 2, 634, 9815.75964582862, 125, 1.5, false, '2023-09-20 13:20:12.057148', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '884104027', 2023, 2, 613, 9532.71023317729, 125, 1.5, false, '2023-09-20 13:20:12.057148', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '841084572', 2023, 2, 667, 6952.16978035622, 125, 1.5, false, '2023-09-20 13:20:12.057148', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '845226813', 2023, 2, 858, 2985.44840531744, 125, 1.5, false, '2023-09-20 13:20:12.062265', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '800169782', 2023, 2, 818, 9874.71787704014, 125, 1.5, false, '2023-09-20 13:20:12.062265', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '829826155', 2023, 2, 806, 1587.91892408499, 125, 1.5, false, '2023-09-20 13:20:12.062265', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '827151822', 2023, 2, 613, 6564.11389204201, 125, 1.5, false, '2023-09-20 13:20:12.067338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '800490092', 2023, 2, 561, 3578.8307239117, 125, 1.5, false, '2023-09-20 13:20:12.067338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '814741356', 2023, 2, 63, 7675.51968138877, 125, 1.5, false, '2023-09-20 13:20:12.067338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '844621127', 2023, 2, 327, 3471.33854563105, 125, 1.5, false, '2023-09-20 13:20:12.067338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '867032125', 2023, 2, 272, 1887.51799344041, 125, 1.5, false, '2023-09-20 13:20:12.067338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '821385573', 2023, 2, 613, 5951.99045438226, 125, 1.5, false, '2023-09-20 13:20:12.067338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '851245090', 2023, 2, 11, 1536.16923024147, 125, 1.5, false, '2023-09-20 13:20:12.073051', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '871710199', 2023, 2, 739, 4354.20436588059, 125, 1.5, false, '2023-09-20 13:20:12.073051', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '893562928', 2023, 2, 940, 2152.05192649047, 125, 1.5, false, '2023-09-20 13:20:12.073051', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '814580797', 2023, 2, 149, 6547.46947730429, 125, 1.5, false, '2023-09-20 13:20:12.073051', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '824227622', 2023, 2, 117, 1199.35477458497, 125, 1.5, false, '2023-09-20 13:20:12.073051', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '822739956', 2023, 2, 264, 3776.58848651886, 125, 1.5, false, '2023-09-20 13:20:12.078693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '899082690', 2023, 2, 446, 3161.23542562038, 125, 1.5, false, '2023-09-20 13:20:12.078693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '814303355', 2023, 2, 53, 9376.63836433717, 125, 1.5, false, '2023-09-20 13:20:12.078693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '817770567', 2023, 2, 426, 6472.17644091775, 125, 1.5, false, '2023-09-20 13:20:12.078693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '826919947', 2023, 2, 56, 9022.62808949094, 125, 1.5, false, '2023-09-20 13:20:12.078693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '896286002', 2023, 2, 444, 7004.23613632362, 125, 1.5, false, '2023-09-20 13:20:12.085479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '816324996', 2023, 2, 925, 2956.29826888585, 125, 1.5, false, '2023-09-20 13:20:12.085479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '870202885', 2023, 2, 704, 8236.74691602866, 125, 1.5, false, '2023-09-20 13:20:12.085479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '801626988', 2023, 2, 315, 5886.22462354796, 125, 1.5, false, '2023-09-20 13:20:12.085479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '835614882', 2023, 2, 936, 9931.06154559057, 125, 1.5, false, '2023-09-20 13:20:12.085479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '811717230', 2023, 2, 659, 9484.31573606528, 125, 1.5, false, '2023-09-20 13:20:12.092026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '814085446', 2023, 2, 629, 2237.06592992572, 125, 1.5, false, '2023-09-20 13:20:12.092026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '840940814', 2023, 2, 86, 2748.22174086208, 125, 1.5, false, '2023-09-20 13:20:12.092026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '803138536', 2023, 2, 183, 9342.59079492328, 125, 1.5, false, '2023-09-20 13:20:12.092026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '830490901', 2023, 2, 77, 4244.52980536153, 125, 1.5, false, '2023-09-20 13:20:12.092026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '871858419', 2023, 2, 606, 4212.51759381699, 125, 1.5, false, '2023-09-20 13:20:12.092026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '861589487', 2023, 2, 286, 2037.09863049577, 125, 1.5, false, '2023-09-20 13:20:12.092026', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '889952963', 2023, 2, 377, 7645.20977031712, 125, 1.5, false, '2023-09-20 13:20:12.097536', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '874207259', 2023, 2, 508, 8290.16118696357, 125, 1.5, false, '2023-09-20 13:20:12.097536', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '821677085', 2023, 2, 379, 5030.37004543332, 125, 1.5, false, '2023-09-20 13:20:12.097536', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '800345488', 2023, 2, 378, 2048.91694358815, 125, 1.5, false, '2023-09-20 13:20:12.097536', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '871270191', 2023, 2, 911, 5942.32033574317, 125, 1.5, false, '2023-09-20 13:20:12.097536', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '854804194', 2023, 2, 391, 3603.62133796317, 125, 1.5, false, '2023-09-20 13:20:12.103534', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '858484692', 2023, 2, 734, 5093.31287253969, 125, 1.5, false, '2023-09-20 13:20:12.103534', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '808244298', 2023, 2, 277, 6210.39268759599, 125, 1.5, false, '2023-09-20 13:20:12.103534', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '832434824', 2023, 2, 809, 1584.51786691139, 125, 1.5, false, '2023-09-20 13:20:12.103534', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '868719518', 2023, 2, 839, 9998.30089080607, 125, 1.5, false, '2023-09-20 13:20:12.108241', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '802326218', 2023, 2, 509, 4417.33884064731, 125, 1.5, false, '2023-09-20 13:20:12.108241', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '808957122', 2023, 2, 763, 3214.66753405768, 125, 1.5, false, '2023-09-20 13:20:12.108241', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '803905378', 2023, 2, 80, 5686.95017491194, 125, 1.5, false, '2023-09-20 13:20:12.108241', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '828096369', 2023, 2, 569, 3879.25254705154, 125, 1.5, false, '2023-09-20 13:20:12.108241', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '873520346', 2023, 2, 147, 7219.57061914664, 125, 1.5, false, '2023-09-20 13:20:12.113263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '890711444', 2023, 2, 565, 3343.9902728086, 125, 1.5, false, '2023-09-20 13:20:12.113263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '822749114', 2023, 2, 641, 6097.04600518005, 125, 1.5, false, '2023-09-20 13:20:12.113263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '865757268', 2023, 2, 993, 891.730563111467, 125, 1.5, false, '2023-09-20 13:20:12.113263', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '841423972', 2023, 2, 867, 7294.12471409719, 125, 1.5, false, '2023-09-20 13:20:12.119245', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '838241984', 2023, 2, 426, 4730.85330101684, 125, 1.5, false, '2023-09-20 13:20:12.119245', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '836230691', 2023, 2, 153, 1639.62047737836, 125, 1.5, false, '2023-09-20 13:20:12.119245', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '882462835', 2023, 2, 833, 5504.67991356404, 125, 1.5, false, '2023-09-20 13:20:12.119245', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '806009183', 2023, 2, 539, 4286.00527693526, 125, 1.5, false, '2023-09-20 13:20:12.119245', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '806086437', 2023, 2, 602, 2224.03999705904, 125, 1.5, false, '2023-09-20 13:20:12.123107', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '874040892', 2023, 2, 573, 2919.53702339548, 125, 1.5, false, '2023-09-20 13:20:12.123107', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '864804244', 2023, 2, 883, 1030.05546035864, 125, 1.5, false, '2023-09-20 13:20:12.123107', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '878780302', 2023, 2, 738, 1028.75270957483, 125, 1.5, false, '2023-09-20 13:20:12.123107', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '855713657', 2023, 2, 139, 2199.01456635986, 125, 1.5, false, '2023-09-20 13:20:12.123107', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '820690355', 2023, 2, 288, 5840.6798911507, 125, 1.5, false, '2023-09-20 13:20:12.127696', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '842125759', 2023, 2, 153, 5567.84558706476, 125, 1.5, false, '2023-09-20 13:20:12.127696', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '881056064', 2023, 2, 64, 817.406352859718, 125, 1.5, false, '2023-09-20 13:20:12.127696', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '840478098', 2023, 2, 640, 7148.03893595409, 125, 1.5, false, '2023-09-20 13:20:12.127696', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '833295256', 2023, 2, 452, 9750.82591067869, 125, 1.5, false, '2023-09-20 13:20:12.127696', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '837623542', 2023, 2, 571, 9916.34005606263, 125, 1.5, false, '2023-09-20 13:20:12.132952', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '810026055', 2023, 2, 654, 9367.08006958104, 125, 1.5, false, '2023-09-20 13:20:12.132952', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '833500107', 2023, 2, 637, 9895.95031515172, 125, 1.5, false, '2023-09-20 13:20:12.132952', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '825843723', 2023, 2, 696, 6176.75316908395, 125, 1.5, false, '2023-09-20 13:20:12.132952', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '844557328', 2023, 2, 412, 9359.97043498384, 125, 1.5, false, '2023-09-20 13:20:12.132952', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '843577057', 2023, 2, 512, 5871.48996265861, 125, 1.5, false, '2023-09-20 13:20:12.141591', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '867713258', 2023, 2, 411, 3317.04477188241, 125, 1.5, false, '2023-09-20 13:20:12.141591', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '824884019', 2023, 2, 473, 8552.32039166393, 125, 1.5, false, '2023-09-20 13:20:12.141591', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '821905784', 2023, 2, 326, 2675.33660370681, 125, 1.5, false, '2023-09-20 13:20:12.141591', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '848644922', 2023, 2, 357, 9820.37648666173, 125, 1.5, false, '2023-09-20 13:20:12.146461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '850035701', 2023, 2, 352, 9217.94447491964, 125, 1.5, false, '2023-09-20 13:20:12.146461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '843568000', 2023, 2, 215, 8169.11610696993, 125, 1.5, false, '2023-09-20 13:20:12.146461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '805022936', 2023, 2, 98, 3477.94612406713, 125, 1.5, false, '2023-09-20 13:20:12.146461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '873536341', 2023, 2, 528, 7821.70050191726, 125, 1.5, false, '2023-09-20 13:20:12.146461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '816606992', 2023, 2, 346, 725.740456198003, 125, 1.5, false, '2023-09-20 13:20:12.150999', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '833828890', 2023, 2, 578, 8140.84739170123, 125, 1.5, false, '2023-09-20 13:20:12.150999', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '829382061', 2023, 2, 130, 129.308493988564, 125, 1.5, false, '2023-09-20 13:20:12.150999', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '855062916', 2023, 2, 241, 8444.60758760408, 125, 1.5, false, '2023-09-20 13:20:12.150999', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '861013607', 2023, 2, 341, 426.285745244435, 125, 1.5, false, '2023-09-20 13:20:12.156031', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '838752844', 2023, 2, 247, 6122.4148021767, 125, 1.5, false, '2023-09-20 13:20:12.156031', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '871862482', 2023, 2, 829, 806.110445362757, 125, 1.5, false, '2023-09-20 13:20:12.156031', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '852249416', 2023, 2, 198, 7584.39836411461, 125, 1.5, false, '2023-09-20 13:20:12.156031', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '821530057', 2023, 2, 181, 7881.62971817809, 125, 1.5, false, '2023-09-20 13:20:12.156031', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '877538496', 2023, 2, 907, 2760.35534857607, 125, 1.5, false, '2023-09-20 13:20:12.161603', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '859955431', 2023, 2, 777, 5077.86758766197, 125, 1.5, false, '2023-09-20 13:20:12.161603', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '894138918', 2023, 2, 99, 4188.77977990941, 125, 1.5, false, '2023-09-20 13:20:12.161603', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '878866284', 2023, 2, 771, 7544.90467600605, 125, 1.5, false, '2023-09-20 13:20:12.161603', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '885569388', 2023, 2, 631, 1588.87556235948, 125, 1.5, false, '2023-09-20 13:20:12.166822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '893295490', 2023, 2, 210, 9857.88157127107, 125, 1.5, false, '2023-09-20 13:20:12.166822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '835640066', 2023, 2, 362, 2687.18783741648, 125, 1.5, false, '2023-09-20 13:20:12.166822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '869885794', 2023, 2, 394, 7531.50001599993, 125, 1.5, false, '2023-09-20 13:20:12.166822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '829496837', 2023, 2, 726, 2856.44401020936, 125, 1.5, false, '2023-09-20 13:20:12.166822', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '810778729', 2023, 2, 61, 6067.32643613436, 125, 1.5, false, '2023-09-20 13:20:12.171367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '858365705', 2023, 2, 975, 5533.88780340322, 125, 1.5, false, '2023-09-20 13:20:12.171367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '835755322', 2023, 2, 303, 2676.24038145365, 125, 1.5, false, '2023-09-20 13:20:12.171367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '853552534', 2023, 2, 175, 9736.35827825292, 125, 1.5, false, '2023-09-20 13:20:12.171367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '824211301', 2023, 2, 92, 4341.2751114353, 125, 1.5, false, '2023-09-20 13:20:12.171367', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '835144476', 2023, 2, 470, 546.936154026918, 125, 1.5, false, '2023-09-20 13:20:12.176687', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '810672024', 2023, 2, 38, 4691.83912182842, 125, 1.5, false, '2023-09-20 13:20:12.176687', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '816786037', 2023, 2, 249, 9170.48271684904, 125, 1.5, false, '2023-09-20 13:20:12.176687', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '806094817', 2023, 2, 372, 2060.26694628778, 125, 1.5, false, '2023-09-20 13:20:12.176687', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '866639021', 2023, 2, 971, 5283.55259968858, 125, 1.5, false, '2023-09-20 13:20:12.176687', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '893274716', 2023, 2, 614, 8953.53207276679, 125, 1.5, false, '2023-09-20 13:20:12.176687', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '848244360', 2023, 2, 670, 708.170971794405, 125, 1.5, false, '2023-09-20 13:20:12.181626', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '835895151', 2023, 2, 810, 9487.06913995975, 125, 1.5, false, '2023-09-20 13:20:12.181626', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '827603549', 2023, 2, 314, 3409.65339641839, 125, 1.5, false, '2023-09-20 13:20:12.181626', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '874876623', 2023, 2, 33, 6341.41804769042, 125, 1.5, false, '2023-09-20 13:20:12.186057', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '820496671', 2023, 2, 293, 9796.48387942636, 125, 1.5, false, '2023-09-20 13:20:12.186057', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '847391810', 2023, 2, 782, 8405.78717620655, 125, 1.5, false, '2023-09-20 13:20:12.186057', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '886545684', 2023, 2, 571, 1935.22171981685, 125, 1.5, false, '2023-09-20 13:20:12.186057', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '837545167', 2023, 2, 390, 1466.51468168488, 125, 1.5, false, '2023-09-20 13:20:12.186057', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '865865936', 2023, 2, 466, 9942.88703569995, 125, 1.5, false, '2023-09-20 13:20:12.191262', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '846771706', 2023, 2, 59, 6952.0880255778, 125, 1.5, false, '2023-09-20 13:20:12.191262', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '889704521', 2023, 2, 463, 2072.53832299704, 125, 1.5, false, '2023-09-20 13:20:12.191262', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '869094041', 2023, 2, 358, 7372.96550043967, 125, 1.5, false, '2023-09-20 13:20:12.191262', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '812609372', 2023, 2, 933, 4778.354732644, 125, 1.5, false, '2023-09-20 13:20:12.196401', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '832769643', 2023, 2, 340, 7487.68136546808, 125, 1.5, false, '2023-09-20 13:20:12.196401', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '805214502', 2023, 2, 65, 1329.51611153644, 125, 1.5, false, '2023-09-20 13:20:12.196401', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '854920856', 2023, 2, 959, 1445.15247403843, 125, 1.5, false, '2023-09-20 13:20:12.196401', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '872231212', 2023, 2, 423, 4595.29513247535, 125, 1.5, false, '2023-09-20 13:20:12.196401', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '849173757', 2023, 2, 638, 5872.29934306516, 125, 1.5, false, '2023-09-20 13:20:12.201983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '880853139', 2023, 2, 697, 3118.77822973999, 125, 1.5, false, '2023-09-20 13:20:12.201983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '826530237', 2023, 2, 425, 7791.70194389362, 125, 1.5, false, '2023-09-20 13:20:12.201983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '831091213', 2023, 2, 956, 893.628220581417, 125, 1.5, false, '2023-09-20 13:20:12.201983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '881204972', 2023, 2, 173, 431.876716089144, 125, 1.5, false, '2023-09-20 13:20:12.201983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '859080272', 2023, 2, 804, 4344.23621006005, 125, 1.5, false, '2023-09-20 13:20:12.207256', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '874695359', 2023, 2, 871, 6290.85175264596, 125, 1.5, false, '2023-09-20 13:20:12.207256', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '880050718', 2023, 2, 51, 9781.90779330599, 125, 1.5, false, '2023-09-20 13:20:12.207256', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '810571093', 2023, 2, 48, 2358.58612787828, 125, 1.5, false, '2023-09-20 13:20:12.207256', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '836608565', 2023, 2, 513, 2431.87793310983, 125, 1.5, false, '2023-09-20 13:20:12.207256', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '883252672', 2023, 2, 260, 8513.24280431316, 125, 1.5, false, '2023-09-20 13:20:12.212663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '856635490', 2023, 2, 111, 9282.54731221132, 125, 1.5, false, '2023-09-20 13:20:12.212663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '862713535', 2023, 2, 449, 7218.60474303228, 125, 1.5, false, '2023-09-20 13:20:12.212663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '851002327', 2023, 2, 19, 6584.96741117407, 125, 1.5, false, '2023-09-20 13:20:12.212663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '833924226', 2023, 2, 922, 5367.59159859672, 125, 1.5, false, '2023-09-20 13:20:12.212663', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '895508306', 2023, 2, 14, 5595.14872800649, 125, 1.5, false, '2023-09-20 13:20:12.218125', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '868914223', 2023, 2, 160, 6306.42540195213, 125, 1.5, false, '2023-09-20 13:20:12.218125', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '882774535', 2023, 2, 982, 1261.49099478209, 125, 1.5, false, '2023-09-20 13:20:12.218125', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '815099898', 2023, 2, 362, 967.61558480928, 125, 1.5, false, '2023-09-20 13:20:12.218125', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '891870734', 2023, 2, 269, 3734.52448115084, 125, 1.5, false, '2023-09-20 13:20:12.223521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '845737922', 2023, 2, 896, 5966.95975046521, 125, 1.5, false, '2023-09-20 13:20:12.223521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '818122526', 2023, 2, 864, 3498.02208323439, 125, 1.5, false, '2023-09-20 13:20:12.223521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '839472854', 2023, 2, 235, 6956.07075543255, 125, 1.5, false, '2023-09-20 13:20:12.223521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '819847541', 2023, 2, 260, 8958.84414246376, 125, 1.5, false, '2023-09-20 13:20:12.223521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '895933710', 2023, 2, 164, 1476.23333983857, 125, 1.5, false, '2023-09-20 13:20:12.223521', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '897679772', 2023, 2, 455, 3326.79890063905, 125, 1.5, false, '2023-09-20 13:20:12.228936', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '804089308', 2023, 2, 774, 704.129184040674, 125, 1.5, false, '2023-09-20 13:20:12.228936', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '856569141', 2023, 2, 574, 1661.36359070741, 125, 1.5, false, '2023-09-20 13:20:12.228936', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '895205411', 2023, 2, 747, 5968.77526060964, 125, 1.5, false, '2023-09-20 13:20:12.228936', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '833299978', 2023, 2, 653, 6152.89971387691, 125, 1.5, false, '2023-09-20 13:20:12.234128', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '829450455', 2023, 2, 479, 5452.34415961902, 125, 1.5, false, '2023-09-20 13:20:12.234128', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '844925941', 2023, 2, 596, 6312.74155323253, 125, 1.5, false, '2023-09-20 13:20:12.234128', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '847173183', 2023, 2, 247, 3282.51957466109, 125, 1.5, false, '2023-09-20 13:20:12.234128', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '869194708', 2023, 2, 776, 8080.93672223464, 125, 1.5, false, '2023-09-20 13:20:12.234128', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '860600885', 2023, 2, 716, 9497.96145677767, 125, 1.5, false, '2023-09-20 13:20:12.234128', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '846166025', 2023, 2, 262, 167.20641996318, 125, 1.5, false, '2023-09-20 13:20:12.241167', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '850284626', 2023, 2, 537, 868.733346698548, 125, 1.5, false, '2023-09-20 13:20:12.241167', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '842045486', 2023, 2, 207, 2056.84701261349, 125, 1.5, false, '2023-09-20 13:20:12.241167', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '800914575', 2023, 2, 389, 3767.48152835002, 125, 1.5, false, '2023-09-20 13:20:12.241167', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '878948878', 2023, 2, 275, 2022.50614214027, 125, 1.5, false, '2023-09-20 13:20:12.241167', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '861720398', 2023, 2, 732, 4155.96005741148, 125, 1.5, false, '2023-09-20 13:20:12.247294', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '813406508', 2023, 2, 519, 4560.50898345906, 125, 1.5, false, '2023-09-20 13:20:12.247294', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '883254689', 2023, 2, 590, 3944.72323383158, 125, 1.5, false, '2023-09-20 13:20:12.247294', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '813082125', 2023, 2, 370, 7393.44634235802, 125, 1.5, false, '2023-09-20 13:20:12.247294', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '805981764', 2023, 2, 546, 1063.14067754905, 125, 1.5, false, '2023-09-20 13:20:12.247294', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '822539424', 2023, 2, 466, 8504.020800743, 125, 1.5, false, '2023-09-20 13:20:12.247294', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '864608813', 2023, 2, 503, 2417.75889447293, 125, 1.5, false, '2023-09-20 13:20:12.253338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '814671042', 2023, 2, 339, 254.437301317261, 125, 1.5, false, '2023-09-20 13:20:12.253338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '805298977', 2023, 2, 329, 5844.46300375434, 125, 1.5, false, '2023-09-20 13:20:12.253338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '806503523', 2023, 2, 629, 1106.32573085477, 125, 1.5, false, '2023-09-20 13:20:12.253338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '813090036', 2023, 2, 240, 5585.19677110215, 125, 1.5, false, '2023-09-20 13:20:12.253338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '825232538', 2023, 2, 28, 4778.29197071048, 125, 1.5, false, '2023-09-20 13:20:12.253338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '896717340', 2023, 2, 819, 170.606788178886, 125, 1.5, false, '2023-09-20 13:20:12.258986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '867730555', 2023, 2, 958, 3524.68448318711, 125, 1.5, false, '2023-09-20 13:20:12.258986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '860709886', 2023, 2, 573, 7284.02373211338, 125, 1.5, false, '2023-09-20 13:20:12.258986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '826144732', 2023, 2, 457, 3738.94603467838, 125, 1.5, false, '2023-09-20 13:20:12.264246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '855380684', 2023, 2, 818, 7871.06689483916, 125, 1.5, false, '2023-09-20 13:20:12.264246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '802409008', 2023, 2, 653, 2048.75751099745, 125, 1.5, false, '2023-09-20 13:20:12.264246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '846073756', 2023, 2, 670, 3027.41508302794, 125, 1.5, false, '2023-09-20 13:20:12.264246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '832339971', 2023, 2, 716, 7999.25754590063, 125, 1.5, false, '2023-09-20 13:20:12.264246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '812642972', 2023, 2, 349, 1641.00235562423, 125, 1.5, false, '2023-09-20 13:20:12.264246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '890359561', 2023, 2, 57, 1183.43286969304, 125, 1.5, false, '2023-09-20 13:20:12.269099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '823269861', 2023, 2, 299, 6353.44171942393, 125, 1.5, false, '2023-09-20 13:20:12.269099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '871247901', 2023, 2, 280, 8481.06781526126, 125, 1.5, false, '2023-09-20 13:20:12.269099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '820322919', 2023, 2, 181, 8840.64615095878, 125, 1.5, false, '2023-09-20 13:20:12.269099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '830223615', 2023, 2, 253, 4612.0037208831, 125, 1.5, false, '2023-09-20 13:20:12.269099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '848901065', 2023, 2, 561, 303.505684352917, 125, 1.5, false, '2023-09-20 13:20:12.274168', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '858618364', 2023, 2, 150, 1884.60268606907, 125, 1.5, false, '2023-09-20 13:20:12.274168', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '846046929', 2023, 2, 985, 111.046734938007, 125, 1.5, false, '2023-09-20 13:20:12.274168', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '810907776', 2023, 2, 576, 22.8699549492465, 125, 1.5, false, '2023-09-20 13:20:12.274168', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '828839903', 2023, 2, 559, 9211.49676548583, 125, 1.5, false, '2023-09-20 13:20:12.274168', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '853938553', 2023, 2, 550, 9856.52942906311, 125, 1.5, false, '2023-09-20 13:20:12.279437', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '824825569', 2023, 2, 801, 9534.81724326618, 125, 1.5, false, '2023-09-20 13:20:12.279437', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '879703311', 2023, 2, 393, 9387.96277297528, 125, 1.5, false, '2023-09-20 13:20:12.279437', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '857535758', 2023, 2, 408, 9564.90530808278, 125, 1.5, false, '2023-09-20 13:20:12.279437', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '886348164', 2023, 2, 31, 2106.20329770161, 125, 1.5, false, '2023-09-20 13:20:12.279437', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '816619122', 2023, 2, 425, 3507.97467598232, 125, 1.5, false, '2023-09-20 13:20:12.284255', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '898232963', 2023, 2, 921, 7109.21277911327, 125, 1.5, false, '2023-09-20 13:20:12.284255', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '853154335', 2023, 2, 417, 1166.51784743557, 125, 1.5, false, '2023-09-20 13:20:12.284255', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '802281305', 2023, 2, 727, 8458.80214429142, 125, 1.5, false, '2023-09-20 13:20:12.284255', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '873891689', 2023, 2, 51, 9257.14743306529, 125, 1.5, false, '2023-09-20 13:20:12.289912', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '859936907', 2023, 2, 789, 8383.7801150753, 125, 1.5, false, '2023-09-20 13:20:12.289912', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '885511157', 2023, 2, 910, 7143.45501680866, 125, 1.5, false, '2023-09-20 13:20:12.289912', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '810915087', 2023, 2, 384, 726.150885330699, 125, 1.5, false, '2023-09-20 13:20:12.289912', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '813557180', 2023, 2, 122, 9079.94928062553, 125, 1.5, false, '2023-09-20 13:20:12.289912', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '848628023', 2023, 2, 285, 2794.18190353613, 125, 1.5, false, '2023-09-20 13:20:12.294931', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '805980144', 2023, 2, 113, 8887.44246081197, 125, 1.5, false, '2023-09-20 13:20:12.294931', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '838450728', 2023, 2, 743, 5951.51013287801, 125, 1.5, false, '2023-09-20 13:20:12.294931', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '899304828', 2023, 2, 147, 2563.52209583337, 125, 1.5, false, '2023-09-20 13:20:12.294931', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '813906933', 2023, 2, 34, 5614.16513124954, 125, 1.5, false, '2023-09-20 13:20:12.294931', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '876070192', 2023, 2, 179, 2498.53821494011, 125, 1.5, false, '2023-09-20 13:20:12.29965', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '824131068', 2023, 2, 285, 5075.55595512785, 125, 1.5, false, '2023-09-20 13:20:12.29965', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '861754913', 2023, 2, 843, 3619.61974979888, 125, 1.5, false, '2023-09-20 13:20:12.29965', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '827715003', 2023, 2, 232, 1135.12439173934, 125, 1.5, false, '2023-09-20 13:20:12.29965', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '834715468', 2023, 2, 638, 2913.84823560267, 125, 1.5, false, '2023-09-20 13:20:12.304462', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '868943348', 2023, 2, 226, 6755.80688322441, 125, 1.5, false, '2023-09-20 13:20:12.304462', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '842913833', 2023, 2, 985, 7824.99468710214, 125, 1.5, false, '2023-09-20 13:20:12.304462', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '894993206', 2023, 2, 916, 9252.1570593122, 125, 1.5, false, '2023-09-20 13:20:12.304462', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '801129590', 2023, 2, 890, 7395.5957968366, 125, 1.5, false, '2023-09-20 13:20:12.304462', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '899994755', 2023, 2, 819, 2081.48931145063, 125, 1.5, false, '2023-09-20 13:20:12.309447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '860859451', 2023, 2, 806, 329.35838463448, 125, 1.5, false, '2023-09-20 13:20:12.309447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '859246854', 2023, 2, 846, 4571.23541716426, 125, 1.5, false, '2023-09-20 13:20:12.309447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '892123638', 2023, 2, 692, 8359.05848635522, 125, 1.5, false, '2023-09-20 13:20:12.309447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '818264002', 2023, 2, 777, 3756.31274944319, 125, 1.5, false, '2023-09-20 13:20:12.309447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '890405244', 2023, 2, 703, 1507.20933284997, 125, 1.5, false, '2023-09-20 13:20:12.314617', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '812894112', 2023, 2, 29, 5073.215123076, 125, 1.5, false, '2023-09-20 13:20:12.314617', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '814808060', 2023, 2, 223, 3532.07487094655, 125, 1.5, false, '2023-09-20 13:20:12.314617', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '897037401', 2023, 2, 542, 6491.25748490953, 125, 1.5, false, '2023-09-20 13:20:12.314617', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '851305604', 2023, 2, 197, 9199.84355629046, 125, 1.5, false, '2023-09-20 13:20:12.314617', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '891720600', 2023, 2, 13, 7686.98279686703, 125, 1.5, false, '2023-09-20 13:20:12.319379', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '872816596', 2023, 2, 499, 4587.45581807132, 125, 1.5, false, '2023-09-20 13:20:12.319379', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '882181144', 2023, 2, 800, 8637.21324562364, 125, 1.5, false, '2023-09-20 13:20:12.319379', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '820199495', 2023, 2, 979, 745.559454650528, 125, 1.5, false, '2023-09-20 13:20:12.319379', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '824807396', 2023, 2, 916, 9575.0796767366, 125, 1.5, false, '2023-09-20 13:20:12.319379', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '866863678', 2023, 2, 393, 3287.22787519159, 125, 1.5, false, '2023-09-20 13:20:12.319379', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '877779639', 2023, 2, 47, 3727.05455366655, 125, 1.5, false, '2023-09-20 13:20:12.324104', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '864447069', 2023, 2, 584, 1532.05979317993, 125, 1.5, false, '2023-09-20 13:20:12.324104', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '885784250', 2023, 2, 406, 1147.1883489623, 125, 1.5, false, '2023-09-20 13:20:12.324104', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '862689086', 2023, 2, 600, 322.573403115569, 125, 1.5, false, '2023-09-20 13:20:12.324104', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '877580718', 2023, 2, 616, 1583.35020417986, 125, 1.5, false, '2023-09-20 13:20:12.324104', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '829517871', 2023, 2, 901, 9803.52310680538, 125, 1.5, false, '2023-09-20 13:20:12.329392', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '891687765', 2023, 2, 554, 9605.13282901283, 125, 1.5, false, '2023-09-20 13:20:12.329392', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '844574378', 2023, 2, 786, 6637.90064093916, 125, 1.5, false, '2023-09-20 13:20:12.329392', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '869521283', 2023, 2, 581, 1583.59660146327, 125, 1.5, false, '2023-09-20 13:20:12.329392', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '873364248', 2023, 2, 820, 3377.88723438435, 125, 1.5, false, '2023-09-20 13:20:12.329392', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '882696545', 2023, 2, 975, 5096.20518238938, 125, 1.5, false, '2023-09-20 13:20:12.329392', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '851855465', 2023, 2, 648, 1685.64589728144, 125, 1.5, false, '2023-09-20 13:20:12.334402', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '886467616', 2023, 2, 198, 466.054965161859, 125, 1.5, false, '2023-09-20 13:20:12.334402', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '863969848', 2023, 2, 127, 6123.23810330813, 125, 1.5, false, '2023-09-20 13:20:12.334402', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '818058331', 2023, 2, 633, 1277.96582046031, 125, 1.5, false, '2023-09-20 13:20:12.334402', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '823612750', 2023, 2, 81, 1614.65904330705, 125, 1.5, false, '2023-09-20 13:20:12.334402', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '858372645', 2023, 2, 360, 7627.44922275369, 125, 1.5, false, '2023-09-20 13:20:12.339631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '878838998', 2023, 2, 598, 7403.08495917239, 125, 1.5, false, '2023-09-20 13:20:12.339631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '809603600', 2023, 2, 613, 2858.71658248191, 125, 1.5, false, '2023-09-20 13:20:12.339631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '811456573', 2023, 2, 285, 6712.04631961744, 125, 1.5, false, '2023-09-20 13:20:12.339631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '876241838', 2023, 2, 349, 2876.35236556251, 125, 1.5, false, '2023-09-20 13:20:12.339631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '823349197', 2023, 2, 84, 9282.07169126968, 125, 1.5, false, '2023-09-20 13:20:12.339631', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '802065158', 2023, 2, 766, 655.664476794591, 125, 1.5, false, '2023-09-20 13:20:12.344446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '888535415', 2023, 2, 464, 6848.96002640721, 125, 1.5, false, '2023-09-20 13:20:12.344446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '865263765', 2023, 2, 655, 3549.71011690198, 125, 1.5, false, '2023-09-20 13:20:12.344446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '872799429', 2023, 2, 455, 6312.86454859435, 125, 1.5, false, '2023-09-20 13:20:12.344446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '883091871', 2023, 2, 757, 4827.57258826498, 125, 1.5, false, '2023-09-20 13:20:12.344446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '813071138', 2023, 2, 44, 9753.99968707081, 125, 1.5, false, '2023-09-20 13:20:12.349484', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '814396800', 2023, 2, 580, 627.510507498107, 125, 1.5, false, '2023-09-20 13:20:12.349484', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '880948108', 2023, 2, 899, 1640.68092072295, 125, 1.5, false, '2023-09-20 13:20:12.349484', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '875685681', 2023, 2, 905, 9516.86877341843, 125, 1.5, false, '2023-09-20 13:20:12.349484', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '825623598', 2023, 2, 200, 8001.77972274543, 125, 1.5, false, '2023-09-20 13:20:12.349484', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '899020077', 2023, 2, 670, 4535.33592432337, 125, 1.5, false, '2023-09-20 13:20:12.349484', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '834963803', 2023, 2, 997, 9520.25077756096, 125, 1.5, false, '2023-09-20 13:20:12.354587', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '893219391', 2023, 2, 370, 5286.06045863383, 125, 1.5, false, '2023-09-20 13:20:12.354587', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '886989131', 2023, 2, 512, 8044.45781848312, 125, 1.5, false, '2023-09-20 13:20:12.354587', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '800414105', 2023, 2, 436, 4766.15757477131, 125, 1.5, false, '2023-09-20 13:20:12.354587', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '800776209', 2023, 2, 304, 7826.72100272127, 125, 1.5, false, '2023-09-20 13:20:12.354587', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '870889685', 2023, 2, 764, 6629.01792625885, 125, 1.5, false, '2023-09-20 13:20:12.360237', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '857471550', 2023, 2, 469, 8607.02104736634, 125, 1.5, false, '2023-09-20 13:20:12.360237', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '801971876', 2023, 2, 96, 1557.28340382262, 125, 1.5, false, '2023-09-20 13:20:12.360237', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '887833300', 2023, 2, 230, 1944.62879931403, 125, 1.5, false, '2023-09-20 13:20:12.360237', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '884466337', 2023, 2, 859, 8605.72624027053, 125, 1.5, false, '2023-09-20 13:20:12.360237', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '822487729', 2023, 2, 770, 7433.86083429211, 125, 1.5, false, '2023-09-20 13:20:12.365111', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '875804067', 2023, 2, 203, 6307.83088615726, 125, 1.5, false, '2023-09-20 13:20:12.365111', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '871908613', 2023, 2, 427, 1699.65345024586, 125, 1.5, false, '2023-09-20 13:20:12.365111', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '880023337', 2023, 2, 686, 6420.06534996178, 125, 1.5, false, '2023-09-20 13:20:12.365111', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '820589754', 2023, 2, 985, 2961.00262798151, 125, 1.5, false, '2023-09-20 13:20:12.365111', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '890506842', 2023, 2, 564, 9659.19669135064, 125, 1.5, false, '2023-09-20 13:20:12.370071', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '890222780', 2023, 2, 545, 6148.71434560678, 125, 1.5, false, '2023-09-20 13:20:12.370071', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '806520934', 2023, 2, 880, 6451.91564659787, 125, 1.5, false, '2023-09-20 13:20:12.370071', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '820427752', 2023, 2, 815, 8366.28568344047, 125, 1.5, false, '2023-09-20 13:20:12.370071', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '854038331', 2023, 2, 634, 1796.34586164076, 125, 1.5, false, '2023-09-20 13:20:12.370071', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '881460629', 2023, 2, 371, 3381.025844455, 125, 1.5, false, '2023-09-20 13:20:12.370071', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '807833245', 2023, 2, 69, 442.203586160187, 125, 1.5, false, '2023-09-20 13:20:12.374495', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '858347671', 2023, 2, 504, 8043.52326964556, 125, 1.5, false, '2023-09-20 13:20:12.374495', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '845518266', 2023, 2, 469, 5902.35411462559, 125, 1.5, false, '2023-09-20 13:20:12.374495', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '846889775', 2023, 2, 499, 4994.86105698034, 125, 1.5, false, '2023-09-20 13:20:12.374495', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '807839893', 2023, 2, 268, 1710.92792337984, 125, 1.5, false, '2023-09-20 13:20:12.380093', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '871664285', 2023, 2, 766, 6880.2427783909, 125, 1.5, false, '2023-09-20 13:20:12.380093', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '888742907', 2023, 2, 726, 5115.06245344209, 125, 1.5, false, '2023-09-20 13:20:12.380093', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '849737517', 2023, 2, 211, 3652.72140727843, 125, 1.5, false, '2023-09-20 13:20:12.380093', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '859483557', 2023, 2, 437, 8648.72612150268, 125, 1.5, false, '2023-09-20 13:20:12.380093', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '800181497', 2023, 2, 573, 3452.19572427784, 125, 1.5, false, '2023-09-20 13:20:12.386003', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '881651167', 2023, 2, 144, 5482.00538290984, 125, 1.5, false, '2023-09-20 13:20:12.386003', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '815418627', 2023, 2, 888, 9300.88390737503, 125, 1.5, false, '2023-09-20 13:20:12.386003', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '832002465', 2023, 2, 273, 3935.62481596983, 125, 1.5, false, '2023-09-20 13:20:12.386003', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '817157884', 2023, 2, 366, 7530.94048382544, 125, 1.5, false, '2023-09-20 13:20:12.391977', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '859963954', 2023, 2, 429, 7594.93028954385, 125, 1.5, false, '2023-09-20 13:20:12.391977', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '828257776', 2023, 2, 729, 3165.33271187209, 125, 1.5, false, '2023-09-20 13:20:12.391977', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '814916395', 2023, 2, 833, 1023.38106469747, 125, 1.5, false, '2023-09-20 13:20:12.391977', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '830331208', 2023, 2, 312, 2617.68587605436, 125, 1.5, false, '2023-09-20 13:20:12.391977', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '888695203', 2023, 2, 853, 1223.16554691824, 125, 1.5, false, '2023-09-20 13:20:12.391977', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '876502363', 2023, 2, 188, 1704.68177795304, 125, 1.5, false, '2023-09-20 13:20:12.3983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '827890157', 2023, 2, 548, 2230.79152438737, 125, 1.5, false, '2023-09-20 13:20:12.3983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '838001870', 2023, 2, 534, 9616.17134348407, 125, 1.5, false, '2023-09-20 13:20:12.3983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '825152796', 2023, 2, 758, 1378.21487248269, 125, 1.5, false, '2023-09-20 13:20:12.3983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '869762191', 2023, 2, 124, 1069.14375622263, 125, 1.5, false, '2023-09-20 13:20:12.3983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '833822203', 2023, 2, 246, 9722.52202166826, 125, 1.5, false, '2023-09-20 13:20:12.3983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '828948946', 2023, 2, 539, 4905.95226655616, 125, 1.5, false, '2023-09-20 13:20:12.403458', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '817186434', 2023, 2, 390, 8567.76948038595, 125, 1.5, false, '2023-09-20 13:20:12.403458', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '840659024', 2023, 2, 560, 7721.76242865355, 125, 1.5, false, '2023-09-20 13:20:12.403458', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '846453027', 2023, 2, 358, 1690.76652279348, 125, 1.5, false, '2023-09-20 13:20:12.403458', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '804300620', 2023, 2, 293, 2140.45875367712, 125, 1.5, false, '2023-09-20 13:20:12.408886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '808292440', 2023, 2, 739, 3128.74216837353, 125, 1.5, false, '2023-09-20 13:20:12.408886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '879023146', 2023, 2, 673, 6601.13760794813, 125, 1.5, false, '2023-09-20 13:20:12.408886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '861390542', 2023, 2, 319, 6803.09210646937, 125, 1.5, false, '2023-09-20 13:20:12.408886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '803387738', 2023, 2, 605, 6586.48776484952, 125, 1.5, false, '2023-09-20 13:20:12.408886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '803844864', 2023, 2, 733, 2590.98748035982, 125, 1.5, false, '2023-09-20 13:20:12.408886', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '864725756', 2023, 2, 666, 633.667032709073, 125, 1.5, false, '2023-09-20 13:20:12.414589', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '883139685', 2023, 2, 293, 9729.55274193919, 125, 1.5, false, '2023-09-20 13:20:12.414589', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '867282851', 2023, 2, 961, 4474.81823030431, 125, 1.5, false, '2023-09-20 13:20:12.414589', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '811689225', 2023, 2, 254, 5507.23865135539, 125, 1.5, false, '2023-09-20 13:20:12.414589', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '809582812', 2023, 2, 958, 4099.45685803654, 125, 1.5, false, '2023-09-20 13:20:12.420648', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '839305987', 2023, 2, 688, 3976.85935507744, 125, 1.5, false, '2023-09-20 13:20:12.420648', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '864192376', 2023, 2, 904, 9821.84800657368, 125, 1.5, false, '2023-09-20 13:20:12.420648', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '852148023', 2023, 2, 476, 5611.47033541863, 125, 1.5, false, '2023-09-20 13:20:12.420648', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '841398189', 2023, 2, 283, 9252.88202722311, 125, 1.5, false, '2023-09-20 13:20:12.420648', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '805383943', 2023, 2, 714, 6887.36782353852, 125, 1.5, false, '2023-09-20 13:20:12.420648', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '848882011', 2023, 2, 200, 2184.52335488804, 125, 1.5, false, '2023-09-20 13:20:12.426533', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '838704760', 2023, 2, 172, 2271.90595235637, 125, 1.5, false, '2023-09-20 13:20:12.426533', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '802798289', 2023, 2, 844, 7356.56812617628, 125, 1.5, false, '2023-09-20 13:20:12.426533', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '817998975', 2023, 2, 145, 7862.66940176936, 125, 1.5, false, '2023-09-20 13:20:12.426533', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '812235712', 2023, 2, 325, 9351.43393571998, 125, 1.5, false, '2023-09-20 13:20:12.426533', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '874242317', 2023, 2, 738, 2295.03398523699, 125, 1.5, false, '2023-09-20 13:20:12.433518', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '830334365', 2023, 2, 556, 2081.1029611108, 125, 1.5, false, '2023-09-20 13:20:12.433518', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '813876916', 2023, 2, 271, 1612.36503087495, 125, 1.5, false, '2023-09-20 13:20:12.433518', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '856861246', 2023, 2, 694, 6604.78302185003, 125, 1.5, false, '2023-09-20 13:20:12.433518', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '825253279', 2023, 2, 420, 7064.99477140034, 125, 1.5, false, '2023-09-20 13:20:12.433518', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '862232820', 2023, 2, 444, 9947.54443490525, 125, 1.5, false, '2023-09-20 13:20:12.433518', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '829955165', 2023, 2, 747, 4658.22091511745, 125, 1.5, false, '2023-09-20 13:20:12.440212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '892129974', 2023, 2, 233, 2532.44444214832, 125, 1.5, false, '2023-09-20 13:20:12.440212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '837180015', 2023, 2, 795, 6941.97407644431, 125, 1.5, false, '2023-09-20 13:20:12.440212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '844238330', 2023, 2, 981, 8419.92106061633, 125, 1.5, false, '2023-09-20 13:20:12.440212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '876653097', 2023, 2, 840, 2110.18616457071, 125, 1.5, false, '2023-09-20 13:20:12.440212', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '886290642', 2023, 2, 177, 4545.46976171218, 125, 1.5, false, '2023-09-20 13:20:12.445723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '892588971', 2023, 2, 648, 7908.93593942328, 125, 1.5, false, '2023-09-20 13:20:12.445723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '873788685', 2023, 2, 312, 4033.4784565004, 125, 1.5, false, '2023-09-20 13:20:12.445723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '848177872', 2023, 2, 285, 6325.86584251118, 125, 1.5, false, '2023-09-20 13:20:12.445723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '842951610', 2023, 2, 710, 5993.14158400455, 125, 1.5, false, '2023-09-20 13:20:12.445723', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '887524559', 2023, 2, 413, 2806.76810260147, 125, 1.5, false, '2023-09-20 13:20:12.45113', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '898606269', 2023, 2, 977, 4917.58264014936, 125, 1.5, false, '2023-09-20 13:20:12.45113', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '882700408', 2023, 2, 559, 6472.19107861834, 125, 1.5, false, '2023-09-20 13:20:12.45113', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '804675096', 2023, 2, 428, 6291.44912355528, 125, 1.5, false, '2023-09-20 13:20:12.45113', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '833137928', 2023, 2, 481, 4309.14230642299, 125, 1.5, false, '2023-09-20 13:20:12.45113', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '847143733', 2023, 2, 653, 8667.12223052442, 125, 1.5, false, '2023-09-20 13:20:12.456203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '880270128', 2023, 2, 999, 7445.32214231107, 125, 1.5, false, '2023-09-20 13:20:12.456203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '876908783', 2023, 2, 618, 8492.00536276506, 125, 1.5, false, '2023-09-20 13:20:12.456203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '847816292', 2023, 2, 399, 1070.28894830609, 125, 1.5, false, '2023-09-20 13:20:12.456203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '800454934', 2023, 2, 524, 1896.00635462074, 125, 1.5, false, '2023-09-20 13:20:12.456203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '875580850', 2023, 2, 732, 5377.89452743067, 125, 1.5, false, '2023-09-20 13:20:12.456203', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '872253338', 2023, 2, 837, 3997.63162619453, 125, 1.5, false, '2023-09-20 13:20:12.461557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '849867639', 2023, 2, 97, 2453.54016543414, 125, 1.5, false, '2023-09-20 13:20:12.461557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '854107024', 2023, 2, 49, 6029.60822640217, 125, 1.5, false, '2023-09-20 13:20:12.461557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '878251627', 2023, 2, 363, 5789.16902432421, 125, 1.5, false, '2023-09-20 13:20:12.461557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '898116069', 2023, 2, 787, 5757.66182735868, 125, 1.5, false, '2023-09-20 13:20:12.461557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '846090567', 2023, 2, 637, 8365.04471261432, 125, 1.5, false, '2023-09-20 13:20:12.466537', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '864592196', 2023, 2, 166, 601.110081538294, 125, 1.5, false, '2023-09-20 13:20:12.466537', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '855303240', 2023, 2, 438, 8531.68996327893, 125, 1.5, false, '2023-09-20 13:20:12.466537', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '897230637', 2023, 2, 110, 9966.41520684477, 125, 1.5, false, '2023-09-20 13:20:12.466537', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '899928561', 2023, 2, 280, 3041.48632629794, 125, 1.5, false, '2023-09-20 13:20:12.466537', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '830072613', 2023, 2, 494, 5505.47616965733, 125, 1.5, false, '2023-09-20 13:20:12.466537', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '821059938', 2023, 2, 894, 3485.40989488043, 125, 1.5, false, '2023-09-20 13:20:12.471153', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '846729601', 2023, 2, 513, 7330.62094823542, 125, 1.5, false, '2023-09-20 13:20:12.471153', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '800795308', 2023, 2, 586, 3714.95950322167, 125, 1.5, false, '2023-09-20 13:20:12.471153', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '885895732', 2023, 2, 755, 513.087797462474, 125, 1.5, false, '2023-09-20 13:20:13.171803', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '888926367', 2023, 2, 436, 1406.362291475, 125, 1.5, false, '2023-09-20 13:20:13.175278', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '858343080', 2023, 2, 638, 4685.64244530561, 125, 1.5, false, '2023-09-20 13:20:13.179878', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '892377219', 2023, 2, 28, 7840.56214454564, 125, 1.5, false, '2023-09-20 13:20:13.179878', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '870010381', 2023, 2, 93, 1674.8451354803, 125, 1.5, false, '2023-09-20 13:20:13.184076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '893430686', 2023, 2, 276, 8300.28282780607, 125, 1.5, false, '2023-09-20 13:20:13.184076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '828247932', 2023, 2, 296, 8711.86068321848, 125, 1.5, false, '2023-09-20 13:20:13.184076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '843668858', 2023, 2, 198, 1800.88659273188, 125, 1.5, false, '2023-09-20 13:20:13.184076', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '810824719', 2023, 2, 194, 6552.10757915391, 125, 1.5, false, '2023-09-20 13:20:13.188812', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '876496878', 2023, 2, 959, 7380.97065109342, 125, 1.5, false, '2023-09-20 13:20:13.188812', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '874998757', 2023, 2, 302, 9776.09510940153, 125, 1.5, false, '2023-09-20 13:20:13.188812', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '895211720', 2023, 2, 607, 2676.79114743206, 125, 1.5, false, '2023-09-20 13:20:13.188812', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '837329833', 2023, 2, 312, 2563.6966158701, 125, 1.5, false, '2023-09-20 13:20:13.193557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '872199612', 2023, 2, 189, 216.956665546431, 125, 1.5, false, '2023-09-20 13:20:13.193557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '857424051', 2023, 2, 222, 3533.26494670223, 125, 1.5, false, '2023-09-20 13:20:13.193557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '829793291', 2023, 2, 880, 8230.72535446754, 125, 1.5, false, '2023-09-20 13:20:13.193557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '865238543', 2023, 2, 196, 4531.20802058909, 125, 1.5, false, '2023-09-20 13:20:13.193557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '899416996', 2023, 2, 334, 170.466857741955, 125, 1.5, false, '2023-09-20 13:20:13.198003', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 38502.7970332672, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.893077', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (2, '987654321', 38502.7970332672, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.899434', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 17533.6902135226, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.903481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (4, '123456789', 17533.6902135226, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.903481', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '555555555', 16407.3433491653, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.903481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '835690072', 38437.4026057478, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.903481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (7, '835690072', 38437.4026057478, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.903481', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '851259006', 1430.50244861381, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.903481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (9, '851259006', 1430.50244861381, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.91055', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '891657310', 16777.7003679496, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.91055', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (11, '891657310', 16777.7003679496, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.91055', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '890069516', 565.609042444673, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.91055', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (13, '890069516', 565.609042444673, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.916611', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '818227880', 21006.9455194073, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.916611', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '887929660', 270.988583397303, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.916611', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '833098223', 12088.1180066803, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.916611', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '810132798', 1890.7047418587, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.916611', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '865287159', 39351.6867097226, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.921976', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '812325861', 32150.3837721416, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.921976', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '854678052', 14323.0440675666, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.921976', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '826529622', 36232.8851455055, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.921976', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '896593666', 3798.72545879686, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.921976', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '898415442', 22463.1142600882, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.921976', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '847120809', 27519.0974220479, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.92834', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '830931807', 5100.30753919647, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.92834', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '812705354', 4118.51981572555, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.92834', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '876999418', 4925.32013134098, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.92834', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '883094378', 6813.78729680346, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.92834', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '826578249', 34823.3515280763, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.933517', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '821779748', 6637.32557458654, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.933517', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '898304073', 7099.00565813822, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.933517', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '806055367', 19049.2212253479, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.933517', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '849267670', 39961.9665555068, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.933517', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '814067491', 32110.1178253877, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.93905', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '827223911', 36404.8027446429, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.93905', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '852060664', 18718.6179813777, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.93905', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '828472924', 23932.6125775513, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.93905', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '802034315', 18981.9148867774, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.93905', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '821364109', 27049.9300735146, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.944874', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '840899793', 13226.9818403619, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.944874', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '835831981', 32894.5303186461, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.944874', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '834110433', 16129.6217920912, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.944874', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '871024289', 25460.1537806886, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.950007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '825209846', 21342.0038000655, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.950007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '881202253', 26871.7071063978, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.950007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '812103300', 33426.3453016869, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.950007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '826806454', 24023.4997488682, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.950007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '836563069', 15934.4694085719, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.950007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '883569645', 25253.220861134, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.955424', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '864282766', 30241.7854224444, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.955424', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '853470204', 29750.2718992179, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.955424', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '892154043', 38906.9945223038, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.960292', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '884553531', 37940.3774924648, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.960292', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '837702175', 13220.5486890076, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.960292', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '848135730', 7763.96219440261, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.960292', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '843069529', 34054.6157033977, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.965622', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '841202354', 22264.6554470823, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.965622', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '800661351', 37082.8183347108, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.965622', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '852377976', 29465.3993571862, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.965622', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '821899473', 36059.5338432621, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.975988', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '848304798', 37466.8320019858, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.975988', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '827048656', 32696.1797277996, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.975988', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '825165311', 8712.75434191144, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.975988', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '889921082', 33515.1459362042, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.975988', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '834786168', 24011.0465705123, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.981992', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '889648932', 14893.1331011386, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.981992', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '846081284', 23743.8708511553, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.981992', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '899521020', 18298.6238357112, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.981992', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '897984578', 34419.7445430878, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.987141', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '815452764', 14178.0943640346, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.987141', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '845306307', 4880.76418226956, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.987141', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '862266403', 34495.0415477531, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.987141', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '859743159', 11780.7478789338, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.987141', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '836953790', 28384.6137971629, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.992575', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '809615855', 19696.2350042915, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.992575', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '882106339', 7297.8259234994, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.992575', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '847671651', 612.017991812919, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.992575', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '838086404', 3468.46786490618, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.992575', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '875335169', 8154.22095180404, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.997948', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '885654025', 17289.2037311064, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.997948', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '847026988', 20066.0553628802, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.997948', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '816378418', 11506.3874074363, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:11.997948', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '897996553', 9282.35026741623, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.002809', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '800055701', 2643.40770149815, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.002809', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '814989456', 7941.11816436427, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.002809', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '813772256', 22329.4211264976, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.002809', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '897580139', 21648.6968976495, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.002809', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '857663926', 39098.340000675, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.00785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '820181951', 39478.478265591, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.00785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '818792472', 6468.05104855336, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.00785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '849137527', 20223.7369791166, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.00785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '888437122', 12791.5819453018, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.01305', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '847199028', 37682.2268014315, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.01305', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '802475208', 26166.5688635227, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.01305', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '873799686', 10408.1454596008, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.018273', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '879062037', 29131.684033072, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.018273', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '814256657', 14295.4740754227, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.018273', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '891092944', 12410.0701645372, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.018273', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '832958392', 3847.25375059054, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.018273', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '824528008', 135.260388569632, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.023876', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '833648500', 16964.8312876937, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.023876', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '837119021', 6591.20298195922, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.023876', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '859036595', 29438.6384389632, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.023876', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '818754298', 11487.6959955642, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.029071', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '812704644', 38711.5202606549, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.029071', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '819173366', 27977.516314905, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.029071', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '850862665', 20201.8967264501, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.029071', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '848077518', 32282.0641481809, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.029071', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '878236994', 5710.07987551204, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.033758', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '877412476', 16138.7566585358, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.033758', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '856276748', 17468.7594824532, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.033758', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '831572234', 9708.15181055509, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.033758', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '889067758', 6061.993359937, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.033758', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '804216935', 9445.86535693239, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.039581', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '806865325', 29779.16005956, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.039581', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '815297831', 38957.1626052146, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.039581', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '857456187', 907.627258154437, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.039581', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '853108988', 13071.4135227126, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.045151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '879916784', 1388.10267350045, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.045151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '823976938', 33571.2684507164, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.045151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '853659393', 32428.5214934981, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.045151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '831217959', 22680.4401252479, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.045151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '882165409', 9517.80423577518, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.045151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '815785458', 9678.19893958596, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.050754', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '846634644', 25476.710584953, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.050754', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '855681292', 12870.183762837, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.050754', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '830105110', 26611.4406381191, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.05524', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '880754152', 39263.0385833145, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.05524', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '884104027', 38130.8409327092, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.05524', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '841084572', 27808.6791214249, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.05524', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '845226813', 11941.7936212698, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.061158', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '800169782', 39498.8715081606, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.061158', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '829826155', 6351.67569633996, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.061158', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '827151822', 26256.455568168, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.065977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '800490092', 14315.3228956468, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.065977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '814741356', 30702.0787255551, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.065977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '844621127', 13885.3541825242, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.065977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '867032125', 7550.07197376165, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.065977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '821385573', 23807.961817529, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.065977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '851245090', 6144.67692096586, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.071977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '871710199', 17416.8174635224, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.071977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '893562928', 8608.20770596188, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.071977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '814580797', 26189.8779092172, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.071977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '824227622', 4797.4190983399, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.071977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '822739956', 15106.3539460754, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.077362', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '899082690', 12644.9417024815, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.077362', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '814303355', 37506.5534573487, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.077362', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '817770567', 25888.705763671, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.077362', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '826919947', 36090.5123579637, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.077362', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '896286002', 28016.9445452945, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.084209', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '816324996', 11825.1930755434, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.084209', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '870202885', 32946.9876641146, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.084209', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '801626988', 23544.8984941918, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.084209', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '835614882', 39724.2461823623, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.084209', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '811717230', 37937.2629442611, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.089725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '814085446', 8948.26371970289, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.089725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '840940814', 10992.8869634483, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.089725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '803138536', 37370.3631796931, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.089725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '830490901', 16978.1192214461, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.089725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '871858419', 16850.0703752679, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.089725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '861589487', 8148.39452198309, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.089725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '889952963', 30580.8390812685, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.096736', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '874207259', 33160.6447478543, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.096736', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '821677085', 20121.4801817333, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.096736', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '800345488', 8195.66777435261, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.096736', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '871270191', 23769.2813429727, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.096736', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '854804194', 14414.4853518527, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.102764', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '858484692', 20373.2514901588, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.102764', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '808244298', 24841.570750384, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.102764', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '832434824', 6338.07146764556, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.102764', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '868719518', 39993.2035632243, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.107062', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '802326218', 17669.3553625893, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.107062', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '808957122', 12858.6701362307, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.107062', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '803905378', 22747.8006996478, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.107062', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '828096369', 15517.0101882062, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.107062', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '873520346', 28878.2824765866, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.112559', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '890711444', 13375.9610912344, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.112559', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '822749114', 24388.1840207202, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.112559', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '865757268', 3566.92225244587, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.112559', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '841423972', 29176.4988563887, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.118029', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '838241984', 18923.4132040674, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.118029', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '836230691', 6558.48190951345, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.118029', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '882462835', 22018.7196542562, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.118029', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '806009183', 17144.0211077411, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.118029', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '806086437', 8896.15998823615, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.122521', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '874040892', 11678.1480935819, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.122521', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '864804244', 4120.22184143458, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.122521', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '878780302', 4115.01083829932, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.122521', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '855713657', 8796.05826543944, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.122521', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '820690355', 23362.7195646028, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.126956', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '842125759', 22271.3823482591, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.126956', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '881056064', 3269.62541143887, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.126956', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '840478098', 28592.1557438163, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.126956', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '833295256', 39003.3036427148, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.126956', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '837623542', 39665.3602242505, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.131904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '810026055', 37468.3202783242, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.131904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '833500107', 39583.8012606069, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.131904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '825843723', 24707.0126763358, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.131904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '844557328', 37439.8817399353, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.131904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '843577057', 23485.9598506344, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.140203', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '867713258', 13268.1790875296, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.140203', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '824884019', 34209.2815666557, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.140203', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '821905784', 10701.3464148273, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.140203', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '848644922', 39281.5059466469, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.145703', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '850035701', 36871.7778996785, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.145703', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '843568000', 32676.4644278797, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.145703', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '805022936', 13911.7844962685, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.145703', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '873536341', 31286.802007669, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.145703', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '816606992', 2902.96182479201, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.150284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '833828890', 32563.3895668049, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.150284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '829382061', 517.233975954257, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.150284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '855062916', 33778.4303504163, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.150284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '861013607', 1705.14298097774, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.154526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '838752844', 24489.6592087068, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.154526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '871862482', 3224.44178145103, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.154526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '852249416', 30337.5934564584, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.154526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '821530057', 31526.5188727123, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.154526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '877538496', 11041.4213943043, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.160557', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '859955431', 20311.4703506479, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.160557', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '894138918', 16755.1191196377, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.160557', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '878866284', 30179.6187040242, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.160557', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '885569388', 6355.50224943794, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.165481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '893295490', 39431.5262850843, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.165481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '835640066', 10748.7513496659, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.165481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '869885794', 30126.0000639997, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.165481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '829496837', 11425.7760408375, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.165481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '810778729', 24269.3057445375, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.1707', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '858365705', 22135.5512136129, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.1707', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '835755322', 10704.9615258146, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.1707', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '853552534', 38945.4331130117, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.1707', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '824211301', 17365.1004457412, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.1707', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '835144476', 2187.74461610767, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.174973', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '810672024', 18767.3564873137, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.174973', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '816786037', 36681.9308673962, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.174973', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '806094817', 8241.0677851511, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.174973', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '866639021', 21134.2103987543, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.174973', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '893274716', 35814.1282910672, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.174973', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '848244360', 2832.68388717762, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.180869', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '835895151', 37948.276559839, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.180869', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '827603549', 13638.6135856736, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.180869', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '874876623', 25365.6721907617, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.18474', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '820496671', 39185.9355177055, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.18474', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '847391810', 33623.1487048262, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.18474', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '886545684', 7740.8868792674, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.18474', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '837545167', 5866.05872673951, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.18474', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '865865936', 39771.5481427998, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.189976', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '846771706', 27808.3521023112, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.189976', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '889704521', 8290.15329198814, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.189976', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '869094041', 29491.8620017587, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.189976', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '812609372', 19113.418930576, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.195408', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '832769643', 29950.7254618723, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.195408', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '805214502', 5318.06444614576, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.195408', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '854920856', 5780.60989615372, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.195408', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '872231212', 18381.1805299014, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.195408', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '849173757', 23489.1973722606, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.200488', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '880853139', 12475.11291896, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.200488', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '826530237', 31166.8077755745, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.200488', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '831091213', 3574.51288232567, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.200488', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '881204972', 1727.50686435657, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.200488', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '859080272', 17376.9448402402, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.205847', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '874695359', 25163.4070105838, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.205847', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '880050718', 39127.631173224, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.205847', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '810571093', 9434.34451151311, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.205847', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '836608565', 9727.51173243931, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.205847', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '883252672', 34052.9712172526, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.211367', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '856635490', 37130.1892488453, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.211367', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '862713535', 28874.4189721291, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.211367', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '851002327', 26339.8696446963, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.211367', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '833924226', 21470.3663943869, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.211367', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '895508306', 22380.594912026, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.217108', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '868914223', 25225.7016078085, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.217108', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '882774535', 5045.96397912835, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.217108', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '815099898', 3870.46233923712, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.217108', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '891870734', 14938.0979246034, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.221931', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '845737922', 23867.8390018608, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.221931', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '818122526', 13992.0883329376, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.221931', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '839472854', 27824.2830217302, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.221931', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '819847541', 35835.3765698551, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.221931', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '895933710', 5904.93335935427, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.221931', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '897679772', 13307.1956025562, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.22775', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '804089308', 2816.5167361627, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.22775', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '856569141', 6645.45436282962, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.22775', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '895205411', 23875.1010424386, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.22775', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '833299978', 24611.5988555076, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.232595', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '829450455', 21809.3766384761, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.232595', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '844925941', 25250.9662129301, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.232595', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '847173183', 13130.0782986443, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.232595', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '869194708', 32323.7468889386, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.232595', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '860600885', 37991.8458271107, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.232595', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '846166025', 668.825679852721, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.239511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '850284626', 3474.93338679419, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.239511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '842045486', 8227.38805045398, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.239511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '800914575', 15069.9261134001, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.239511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '878948878', 8090.02456856107, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.239511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '861720398', 16623.8402296459, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.245816', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '813406508', 18242.0359338362, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.245816', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '883254689', 15778.8929353263, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.245816', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '813082125', 29573.7853694321, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.245816', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '805981764', 4252.56271019622, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.245816', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '822539424', 34016.083202972, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.245816', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '864608813', 9671.03557789173, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.251558', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '814671042', 1017.74920526904, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.251558', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '805298977', 23377.8520150174, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.251558', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '806503523', 4425.30292341909, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.251558', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '813090036', 22340.7870844086, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.251558', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '825232538', 19113.1678828419, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.251558', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '896717340', 682.427152715545, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.258169', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '867730555', 14098.7379327485, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.258169', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '860709886', 29136.0949284535, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.258169', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '826144732', 14955.7841387135, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.262971', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '855380684', 31484.2675793566, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.262971', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '802409008', 8195.03004398981, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.262971', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '846073756', 12109.6603321118, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.262971', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '832339971', 31997.0301836025, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.262971', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '812642972', 6564.0094224969, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.262971', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '890359561', 4733.73147877217, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.268013', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '823269861', 25413.7668776957, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.268013', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '871247901', 33924.2712610451, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.268013', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '820322919', 35362.5846038351, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.268013', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '830223615', 18448.0148835324, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.268013', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '848901065', 1214.02273741167, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.272823', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '858618364', 7538.4107442763, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.272823', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '846046929', 444.186939752029, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.272823', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '810907776', 91.4798197969861, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.272823', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '828839903', 36845.9870619433, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.272823', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '853938553', 39426.1177162524, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.278201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '824825569', 38139.2689730647, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.278201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '879703311', 37551.8510919011, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.278201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '857535758', 38259.6212323311, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.278201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '886348164', 8424.81319080644, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.278201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '816619122', 14031.8987039293, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.283319', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '898232963', 28436.8511164531, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.283319', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '853154335', 4666.07138974228, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.283319', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '802281305', 33835.2085771657, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.283319', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '873891689', 37028.5897322612, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.287889', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '859936907', 33535.1204603012, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.287889', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '885511157', 28573.8200672346, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.287889', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '810915087', 2904.6035413228, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.287889', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '813557180', 36319.7971225021, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.287889', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '848628023', 11176.7276141445, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.294007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '805980144', 35549.7698432479, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.294007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '838450728', 23806.0405315121, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.294007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '899304828', 10254.0883833335, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.294007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '813906933', 22456.6605249982, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.294007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '876070192', 9994.15285976044, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.298595', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '824131068', 20302.2238205114, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.298595', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '861754913', 14478.4789991955, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.298595', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '827715003', 4540.49756695738, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.298595', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '834715468', 11655.3929424107, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.303349', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '868943348', 27023.2275328976, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.303349', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '842913833', 31299.9787484086, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.303349', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '894993206', 37008.6282372488, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.303349', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '801129590', 29582.3831873464, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.303349', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '899994755', 8325.95724580253, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.30799', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '860859451', 1317.43353853792, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.30799', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '859246854', 18284.941668657, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.30799', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '892123638', 33436.2339454209, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.30799', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '818264002', 15025.2509977727, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.30799', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '890405244', 6028.83733139989, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.313355', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '812894112', 20292.860492304, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.313355', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '814808060', 14128.2994837862, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.313355', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '897037401', 25965.0299396381, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.313355', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '851305604', 36799.3742251618, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.313355', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '891720600', 30747.9311874681, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.318097', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '872816596', 18349.8232722853, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.318097', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '882181144', 34548.8529824945, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.318097', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '820199495', 2982.23781860211, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.318097', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '824807396', 38300.3187069464, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.318097', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '866863678', 13148.9115007663, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.318097', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '877779639', 14908.2182146662, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.32311', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '864447069', 6128.23917271972, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.32311', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '885784250', 4588.75339584919, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.32311', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '862689086', 1290.29361246227, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.32311', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '877580718', 6333.40081671944, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.32311', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '829517871', 39214.0924272215, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.328024', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '891687765', 38420.5313160513, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.328024', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '844574378', 26551.6025637566, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.328024', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '869521283', 6334.38640585307, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.328024', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '873364248', 13511.5489375374, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.328024', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '882696545', 20384.8207295575, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.328024', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '851855465', 6742.58358912575, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.333014', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '886467616', 1864.21986064744, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.333014', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '863969848', 24492.9524132325, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.333014', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '818058331', 5111.86328184126, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.333014', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '823612750', 6458.63617322822, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.333014', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '858372645', 30509.7968910147, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.338193', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '878838998', 29612.3398366896, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.338193', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '809603600', 11434.8663299276, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.338193', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '811456573', 26848.1852784697, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.338193', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '876241838', 11505.4094622501, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.338193', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '823349197', 37128.2867650787, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.338193', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '802065158', 2622.65790717836, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.343338', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '888535415', 27395.8401056289, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.343338', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '865263765', 14198.8404676079, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.343338', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '872799429', 25251.4581943774, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.343338', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '883091871', 19310.2903530599, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.343338', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '813071138', 39015.9987482833, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.348101', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '814396800', 2510.04202999243, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.348101', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '880948108', 6562.7236828918, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.348101', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '875685681', 38067.4750936737, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.348101', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '825623598', 32007.1188909817, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.348101', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '899020077', 18141.3436972935, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.348101', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '834963803', 38081.0031102439, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.353226', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '893219391', 21144.2418345353, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.353226', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '886989131', 32177.8312739325, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.353226', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '800414105', 19064.6302990852, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.353226', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '800776209', 31306.8840108851, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.353226', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '870889685', 26516.0717050354, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.358763', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '857471550', 34428.0841894654, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.358763', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '801971876', 6229.13361529046, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.358763', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '887833300', 7778.51519725614, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.358763', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '884466337', 34422.9049610821, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.358763', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '822487729', 29735.4433371684, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.363899', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '875804067', 25231.323544629, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.363899', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '871908613', 6798.61380098343, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.363899', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '880023337', 25680.2613998471, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.363899', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '820589754', 11844.0105119261, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.363899', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '890506842', 38636.7867654026, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.368836', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '890222780', 24594.8573824271, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.368836', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '806520934', 25807.6625863915, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.368836', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '820427752', 33465.1427337619, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.368836', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '854038331', 7185.38344656302, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.368836', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '881460629', 13524.10337782, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.368836', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '807833245', 1768.81434464075, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.373554', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '858347671', 32174.0930785823, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.373554', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '845518266', 23609.4164585024, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.373554', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '846889775', 19979.4442279213, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.373554', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '807839893', 6843.71169351934, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.378572', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '871664285', 27520.9711135636, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.378572', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '888742907', 20460.2498137684, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.378572', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '849737517', 14610.8856291137, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.378572', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '859483557', 34594.9044860107, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.378572', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '800181497', 13808.7828971114, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.384817', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '881651167', 21928.0215316393, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.384817', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '815418627', 37203.5356295001, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.384817', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '832002465', 15742.4992638793, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.384817', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '817157884', 30123.7619353017, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.389958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '859963954', 30379.7211581754, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.389958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '828257776', 12661.3308474884, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.389958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '814916395', 4093.52425878987, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.389958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '830331208', 10470.7435042175, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.389958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '888695203', 4892.66218767297, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.389958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '876502363', 6818.72711181215, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.396659', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '827890157', 8923.16609754946, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.396659', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '838001870', 38464.6853739363, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.396659', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '825152796', 5512.85948993075, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.396659', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '869762191', 4276.57502489053, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.396659', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '833822203', 38890.088086673, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.396659', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '828948946', 19623.8090662247, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.402272', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '817186434', 34271.0779215438, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.402272', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '840659024', 30887.0497146142, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.402272', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '846453027', 6763.06609117393, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.402272', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '804300620', 8561.83501470849, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.406905', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '808292440', 12514.9686734941, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.406905', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '879023146', 26404.5504317925, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.406905', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '861390542', 27212.3684258775, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.406905', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '803387738', 26345.9510593981, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.406905', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '803844864', 10363.9499214393, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.406905', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '864725756', 2534.66813083629, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.413327', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '883139685', 38918.2109677567, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.413327', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '867282851', 17899.2729212172, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.413327', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '811689225', 22028.9546054216, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.413327', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '809582812', 16397.8274321462, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.418939', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '839305987', 15907.4374203098, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.418939', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '864192376', 39287.3920262947, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.418939', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '852148023', 22445.8813416745, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.418939', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '841398189', 37011.5281088925, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.418939', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '805383943', 27549.4712941541, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.418939', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '848882011', 8738.09341955215, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.425003', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '838704760', 9087.62380942549, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.425003', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '802798289', 29426.2725047051, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.425003', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '817998975', 31450.6776070774, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.425003', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '812235712', 37405.7357428799, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.425003', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '874242317', 9180.13594094797, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.431642', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '830334365', 8324.41184444322, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.431642', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '813876916', 6449.46012349979, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.431642', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '856861246', 26419.1320874001, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.431642', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '825253279', 28259.9790856014, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.431642', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '862232820', 39790.177739621, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.431642', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '829955165', 18632.8836604698, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.438864', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '892129974', 10129.7777685933, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.438864', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '837180015', 27767.8963057772, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.438864', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '844238330', 33679.6842424653, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.438864', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '876653097', 8440.74465828282, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.438864', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '886290642', 18181.8790468487, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.444487', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '892588971', 31635.7437576931, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.444487', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '873788685', 16133.9138260016, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.444487', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '848177872', 25303.4633700447, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.444487', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '842951610', 23972.5663360182, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.444487', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '887524559', 11227.0724104059, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.449799', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '898606269', 19670.3305605974, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.449799', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '882700408', 25888.7643144734, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.449799', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '804675096', 25165.7964942211, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.449799', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '833137928', 17236.569225692, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.449799', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '847143733', 34668.4889220977, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.454993', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '880270128', 29781.2885692443, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.454993', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '876908783', 33968.0214510602, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.454993', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '847816292', 4281.15579322436, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.454993', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '800454934', 7584.02541848296, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.454993', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '875580850', 21511.5781097227, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.454993', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '872253338', 15990.5265047781, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.459958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '849867639', 9814.16066173658, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.459958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '854107024', 24118.4329056087, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.459958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '878251627', 23156.6760972968, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.459958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '898116069', 23030.6473094347, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.459958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '846090567', 33460.1788504573, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.465324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '864592196', 2404.44032615318, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.465324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '855303240', 34126.7598531157, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.465324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '897230637', 39865.6608273791, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.465324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '899928561', 12165.9453051918, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.465324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '830072613', 22021.9046786293, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.465324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '821059938', 13941.6395795217, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.470324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '846729601', 29322.4837929417, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.470324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '800795308', 14859.8380128867, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:12.470324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '885895732', 2052.3511898499, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.171177', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '888926367', 5625.4491659, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.174701', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '858343080', 18742.5697812225, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.178961', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '892377219', 31362.2485781825, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.178961', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '870010381', 6699.38054192122, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.182892', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '893430686', 33201.1313112243, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.182892', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '828247932', 34847.4427328739, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.182892', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '843668858', 7203.54637092754, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.182892', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '810824719', 26208.4303166156, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.187806', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '876496878', 29523.8826043737, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.187806', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '874998757', 39104.3804376061, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.187806', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '895211720', 10707.1645897282, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.187806', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '837329833', 10254.7864634804, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.192422', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '872199612', 867.826662185722, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.192422', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '857424051', 14133.0597868089, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.192422', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '829793291', 32922.9014178701, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.192422', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '865238543', 18124.8320823564, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.192422', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '899416996', 681.867430967819, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 13:20:13.197534', 2, 2023);


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.629473', '2023-09-20 13:20:06.629473');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.638409', '2023-09-20 13:20:06.638409');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.64909', '2023-09-20 13:20:06.64909');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.661004', '2023-09-20 13:20:06.661004');
INSERT INTO public.virksomhet VALUES (5, '898360724', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898360724', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.69661', '2023-09-20 13:20:06.69661');
INSERT INTO public.virksomhet VALUES (6, '835690072', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835690072', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.706545', '2023-09-20 13:20:06.706545');
INSERT INTO public.virksomhet VALUES (7, '851259006', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851259006', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.716971', '2023-09-20 13:20:06.716971');
INSERT INTO public.virksomhet VALUES (8, '891657310', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891657310', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.728088', '2023-09-20 13:20:06.728088');
INSERT INTO public.virksomhet VALUES (9, '890069516', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890069516', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.74', '2023-09-20 13:20:06.74');
INSERT INTO public.virksomhet VALUES (10, '818227880', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818227880', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.749487', '2023-09-20 13:20:06.749487');
INSERT INTO public.virksomhet VALUES (11, '887929660', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887929660', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.760239', '2023-09-20 13:20:06.760239');
INSERT INTO public.virksomhet VALUES (12, '833098223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833098223', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.77241', '2023-09-20 13:20:06.77241');
INSERT INTO public.virksomhet VALUES (13, '810132798', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810132798', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.794859', '2023-09-20 13:20:06.794859');
INSERT INTO public.virksomhet VALUES (14, '865287159', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865287159', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.804859', '2023-09-20 13:20:06.804859');
INSERT INTO public.virksomhet VALUES (15, '812325861', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812325861', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.816741', '2023-09-20 13:20:06.816741');
INSERT INTO public.virksomhet VALUES (16, '854678052', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854678052', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.827805', '2023-09-20 13:20:06.827805');
INSERT INTO public.virksomhet VALUES (17, '826529622', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826529622', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.842317', '2023-09-20 13:20:06.842317');
INSERT INTO public.virksomhet VALUES (18, '896593666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896593666', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.851994', '2023-09-20 13:20:06.851994');
INSERT INTO public.virksomhet VALUES (19, '898415442', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898415442', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.86333', '2023-09-20 13:20:06.86333');
INSERT INTO public.virksomhet VALUES (20, '847120809', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847120809', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.874382', '2023-09-20 13:20:06.874382');
INSERT INTO public.virksomhet VALUES (21, '830931807', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830931807', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.884206', '2023-09-20 13:20:06.884206');
INSERT INTO public.virksomhet VALUES (22, '812705354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812705354', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.895493', '2023-09-20 13:20:06.895493');
INSERT INTO public.virksomhet VALUES (23, '876999418', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876999418', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.905851', '2023-09-20 13:20:06.905851');
INSERT INTO public.virksomhet VALUES (24, '883094378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883094378', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.915903', '2023-09-20 13:20:06.915903');
INSERT INTO public.virksomhet VALUES (25, '826578249', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826578249', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.926482', '2023-09-20 13:20:06.926482');
INSERT INTO public.virksomhet VALUES (26, '821779748', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821779748', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.937033', '2023-09-20 13:20:06.937033');
INSERT INTO public.virksomhet VALUES (27, '898304073', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898304073', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.947814', '2023-09-20 13:20:06.947814');
INSERT INTO public.virksomhet VALUES (28, '806055367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806055367', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.959394', '2023-09-20 13:20:06.959394');
INSERT INTO public.virksomhet VALUES (29, '849267670', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849267670', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.968321', '2023-09-20 13:20:06.968321');
INSERT INTO public.virksomhet VALUES (30, '814067491', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814067491', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.977953', '2023-09-20 13:20:06.977953');
INSERT INTO public.virksomhet VALUES (31, '827223911', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827223911', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.988158', '2023-09-20 13:20:06.988158');
INSERT INTO public.virksomhet VALUES (32, '852060664', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852060664', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:06.998071', '2023-09-20 13:20:06.998071');
INSERT INTO public.virksomhet VALUES (33, '828472924', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828472924', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.009017', '2023-09-20 13:20:07.009017');
INSERT INTO public.virksomhet VALUES (34, '802034315', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802034315', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.018444', '2023-09-20 13:20:07.018444');
INSERT INTO public.virksomhet VALUES (35, '821364109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821364109', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.029976', '2023-09-20 13:20:07.029976');
INSERT INTO public.virksomhet VALUES (36, '840899793', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840899793', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.041174', '2023-09-20 13:20:07.041174');
INSERT INTO public.virksomhet VALUES (37, '835831981', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835831981', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.052757', '2023-09-20 13:20:07.052757');
INSERT INTO public.virksomhet VALUES (38, '834110433', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834110433', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.064539', '2023-09-20 13:20:07.064539');
INSERT INTO public.virksomhet VALUES (39, '871024289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871024289', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.076253', '2023-09-20 13:20:07.076253');
INSERT INTO public.virksomhet VALUES (40, '825209846', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825209846', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.088864', '2023-09-20 13:20:07.088864');
INSERT INTO public.virksomhet VALUES (41, '881202253', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881202253', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.101153', '2023-09-20 13:20:07.101153');
INSERT INTO public.virksomhet VALUES (42, '812103300', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812103300', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.117025', '2023-09-20 13:20:07.117025');
INSERT INTO public.virksomhet VALUES (43, '826806454', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826806454', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.128024', '2023-09-20 13:20:07.128024');
INSERT INTO public.virksomhet VALUES (44, '836563069', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836563069', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.140563', '2023-09-20 13:20:07.140563');
INSERT INTO public.virksomhet VALUES (45, '883569645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883569645', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.151163', '2023-09-20 13:20:07.151163');
INSERT INTO public.virksomhet VALUES (46, '864282766', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864282766', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.164689', '2023-09-20 13:20:07.164689');
INSERT INTO public.virksomhet VALUES (47, '853470204', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853470204', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.176798', '2023-09-20 13:20:07.176798');
INSERT INTO public.virksomhet VALUES (48, '892154043', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892154043', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.189976', '2023-09-20 13:20:07.189976');
INSERT INTO public.virksomhet VALUES (49, '884553531', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884553531', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.200495', '2023-09-20 13:20:07.200495');
INSERT INTO public.virksomhet VALUES (50, '837702175', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837702175', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.212919', '2023-09-20 13:20:07.212919');
INSERT INTO public.virksomhet VALUES (51, '848135730', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848135730', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.2263', '2023-09-20 13:20:07.2263');
INSERT INTO public.virksomhet VALUES (52, '843069529', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843069529', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.23886', '2023-09-20 13:20:07.23886');
INSERT INTO public.virksomhet VALUES (53, '841202354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841202354', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.251463', '2023-09-20 13:20:07.251463');
INSERT INTO public.virksomhet VALUES (54, '800661351', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800661351', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.265001', '2023-09-20 13:20:07.265001');
INSERT INTO public.virksomhet VALUES (55, '852377976', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852377976', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.275893', '2023-09-20 13:20:07.275893');
INSERT INTO public.virksomhet VALUES (56, '821899473', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821899473', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.290396', '2023-09-20 13:20:07.290396');
INSERT INTO public.virksomhet VALUES (57, '848304798', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848304798', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.30111', '2023-09-20 13:20:07.30111');
INSERT INTO public.virksomhet VALUES (58, '827048656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827048656', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.313777', '2023-09-20 13:20:07.313777');
INSERT INTO public.virksomhet VALUES (59, '825165311', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825165311', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.32592', '2023-09-20 13:20:07.32592');
INSERT INTO public.virksomhet VALUES (60, '889921082', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889921082', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.33519', '2023-09-20 13:20:07.33519');
INSERT INTO public.virksomhet VALUES (61, '834786168', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834786168', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.347098', '2023-09-20 13:20:07.347098');
INSERT INTO public.virksomhet VALUES (62, '889648932', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889648932', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.361327', '2023-09-20 13:20:07.361327');
INSERT INTO public.virksomhet VALUES (63, '846081284', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846081284', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.374603', '2023-09-20 13:20:07.374603');
INSERT INTO public.virksomhet VALUES (64, '899521020', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899521020', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.387826', '2023-09-20 13:20:07.387826');
INSERT INTO public.virksomhet VALUES (65, '897984578', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897984578', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.398006', '2023-09-20 13:20:07.398006');
INSERT INTO public.virksomhet VALUES (66, '815452764', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815452764', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.409569', '2023-09-20 13:20:07.409569');
INSERT INTO public.virksomhet VALUES (67, '845306307', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845306307', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.422213', '2023-09-20 13:20:07.422213');
INSERT INTO public.virksomhet VALUES (68, '862266403', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862266403', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.43207', '2023-09-20 13:20:07.43207');
INSERT INTO public.virksomhet VALUES (69, '859743159', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859743159', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.44595', '2023-09-20 13:20:07.44595');
INSERT INTO public.virksomhet VALUES (70, '836953790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836953790', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.461137', '2023-09-20 13:20:07.461137');
INSERT INTO public.virksomhet VALUES (71, '809615855', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809615855', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.471187', '2023-09-20 13:20:07.471187');
INSERT INTO public.virksomhet VALUES (72, '882106339', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882106339', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.481784', '2023-09-20 13:20:07.481784');
INSERT INTO public.virksomhet VALUES (73, '847671651', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847671651', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.496937', '2023-09-20 13:20:07.496937');
INSERT INTO public.virksomhet VALUES (74, '838086404', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838086404', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.507565', '2023-09-20 13:20:07.507565');
INSERT INTO public.virksomhet VALUES (75, '875335169', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875335169', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.519629', '2023-09-20 13:20:07.519629');
INSERT INTO public.virksomhet VALUES (76, '885654025', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885654025', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.530034', '2023-09-20 13:20:07.530034');
INSERT INTO public.virksomhet VALUES (77, '847026988', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847026988', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.543965', '2023-09-20 13:20:07.543965');
INSERT INTO public.virksomhet VALUES (78, '816378418', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816378418', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.559491', '2023-09-20 13:20:07.559491');
INSERT INTO public.virksomhet VALUES (79, '897996553', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897996553', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.571665', '2023-09-20 13:20:07.571665');
INSERT INTO public.virksomhet VALUES (80, '800055701', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800055701', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.582783', '2023-09-20 13:20:07.582783');
INSERT INTO public.virksomhet VALUES (81, '814989456', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814989456', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.59495', '2023-09-20 13:20:07.59495');
INSERT INTO public.virksomhet VALUES (82, '813772256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813772256', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.606869', '2023-09-20 13:20:07.606869');
INSERT INTO public.virksomhet VALUES (83, '897580139', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897580139', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.616904', '2023-09-20 13:20:07.616904');
INSERT INTO public.virksomhet VALUES (84, '857663926', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857663926', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.631823', '2023-09-20 13:20:07.631823');
INSERT INTO public.virksomhet VALUES (85, '820181951', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820181951', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.645011', '2023-09-20 13:20:07.645011');
INSERT INTO public.virksomhet VALUES (86, '818792472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818792472', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.655465', '2023-09-20 13:20:07.655465');
INSERT INTO public.virksomhet VALUES (87, '849137527', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849137527', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.667419', '2023-09-20 13:20:07.667419');
INSERT INTO public.virksomhet VALUES (88, '888437122', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888437122', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.679704', '2023-09-20 13:20:07.679704');
INSERT INTO public.virksomhet VALUES (89, '847199028', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847199028', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.691691', '2023-09-20 13:20:07.691691');
INSERT INTO public.virksomhet VALUES (90, '802475208', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802475208', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.703022', '2023-09-20 13:20:07.703022');
INSERT INTO public.virksomhet VALUES (91, '873799686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873799686', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.714775', '2023-09-20 13:20:07.714775');
INSERT INTO public.virksomhet VALUES (92, '879062037', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879062037', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.727147', '2023-09-20 13:20:07.727147');
INSERT INTO public.virksomhet VALUES (93, '814256657', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814256657', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.738833', '2023-09-20 13:20:07.738833');
INSERT INTO public.virksomhet VALUES (94, '891092944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891092944', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.749607', '2023-09-20 13:20:07.749607');
INSERT INTO public.virksomhet VALUES (95, '832958392', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832958392', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.761507', '2023-09-20 13:20:07.761507');
INSERT INTO public.virksomhet VALUES (96, '824528008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824528008', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.773173', '2023-09-20 13:20:07.773173');
INSERT INTO public.virksomhet VALUES (97, '833648500', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833648500', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.787074', '2023-09-20 13:20:07.787074');
INSERT INTO public.virksomhet VALUES (98, '837119021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837119021', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.799496', '2023-09-20 13:20:07.799496');
INSERT INTO public.virksomhet VALUES (99, '859036595', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859036595', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.809323', '2023-09-20 13:20:07.809323');
INSERT INTO public.virksomhet VALUES (100, '818754298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818754298', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.819574', '2023-09-20 13:20:07.819574');
INSERT INTO public.virksomhet VALUES (101, '812704644', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812704644', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.830956', '2023-09-20 13:20:07.830956');
INSERT INTO public.virksomhet VALUES (102, '819173366', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819173366', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.842087', '2023-09-20 13:20:07.842087');
INSERT INTO public.virksomhet VALUES (103, '850862665', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850862665', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.853153', '2023-09-20 13:20:07.853153');
INSERT INTO public.virksomhet VALUES (104, '848077518', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848077518', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.865373', '2023-09-20 13:20:07.865373');
INSERT INTO public.virksomhet VALUES (105, '878236994', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878236994', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.877204', '2023-09-20 13:20:07.877204');
INSERT INTO public.virksomhet VALUES (106, '877412476', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877412476', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.888535', '2023-09-20 13:20:07.888535');
INSERT INTO public.virksomhet VALUES (107, '856276748', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856276748', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.898699', '2023-09-20 13:20:07.898699');
INSERT INTO public.virksomhet VALUES (108, '831572234', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831572234', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.909561', '2023-09-20 13:20:07.909561');
INSERT INTO public.virksomhet VALUES (109, '889067758', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889067758', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.920588', '2023-09-20 13:20:07.920588');
INSERT INTO public.virksomhet VALUES (110, '804216935', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804216935', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.933988', '2023-09-20 13:20:07.933988');
INSERT INTO public.virksomhet VALUES (111, '806865325', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806865325', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.945898', '2023-09-20 13:20:07.945898');
INSERT INTO public.virksomhet VALUES (112, '815297831', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815297831', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.958572', '2023-09-20 13:20:07.958572');
INSERT INTO public.virksomhet VALUES (113, '857456187', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857456187', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.970305', '2023-09-20 13:20:07.970305');
INSERT INTO public.virksomhet VALUES (114, '853108988', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853108988', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.981256', '2023-09-20 13:20:07.981256');
INSERT INTO public.virksomhet VALUES (115, '879916784', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879916784', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:07.992461', '2023-09-20 13:20:07.992461');
INSERT INTO public.virksomhet VALUES (116, '823976938', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823976938', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.004511', '2023-09-20 13:20:08.004511');
INSERT INTO public.virksomhet VALUES (117, '853659393', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853659393', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.015001', '2023-09-20 13:20:08.015001');
INSERT INTO public.virksomhet VALUES (118, '831217959', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831217959', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.025864', '2023-09-20 13:20:08.025864');
INSERT INTO public.virksomhet VALUES (119, '882165409', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882165409', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.037946', '2023-09-20 13:20:08.037946');
INSERT INTO public.virksomhet VALUES (120, '815785458', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815785458', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.048889', '2023-09-20 13:20:08.048889');
INSERT INTO public.virksomhet VALUES (121, '846634644', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846634644', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.060331', '2023-09-20 13:20:08.060331');
INSERT INTO public.virksomhet VALUES (122, '855681292', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855681292', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.072719', '2023-09-20 13:20:08.072719');
INSERT INTO public.virksomhet VALUES (123, '830105110', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830105110', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.085005', '2023-09-20 13:20:08.085005');
INSERT INTO public.virksomhet VALUES (124, '880754152', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880754152', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.096519', '2023-09-20 13:20:08.096519');
INSERT INTO public.virksomhet VALUES (125, '884104027', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884104027', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.113533', '2023-09-20 13:20:08.113533');
INSERT INTO public.virksomhet VALUES (126, '841084572', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841084572', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.123866', '2023-09-20 13:20:08.123866');
INSERT INTO public.virksomhet VALUES (127, '845226813', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845226813', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.144728', '2023-09-20 13:20:08.144728');
INSERT INTO public.virksomhet VALUES (128, '800169782', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800169782', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.158861', '2023-09-20 13:20:08.158861');
INSERT INTO public.virksomhet VALUES (129, '829826155', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829826155', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.171152', '2023-09-20 13:20:08.171152');
INSERT INTO public.virksomhet VALUES (130, '827151822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827151822', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.183097', '2023-09-20 13:20:08.183097');
INSERT INTO public.virksomhet VALUES (131, '800490092', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800490092', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.194911', '2023-09-20 13:20:08.194911');
INSERT INTO public.virksomhet VALUES (132, '814741356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814741356', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.207135', '2023-09-20 13:20:08.207135');
INSERT INTO public.virksomhet VALUES (133, '844621127', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844621127', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.218775', '2023-09-20 13:20:08.218775');
INSERT INTO public.virksomhet VALUES (134, '867032125', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867032125', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.228888', '2023-09-20 13:20:08.228888');
INSERT INTO public.virksomhet VALUES (135, '821385573', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821385573', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.24065', '2023-09-20 13:20:08.24065');
INSERT INTO public.virksomhet VALUES (136, '851245090', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851245090', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.251305', '2023-09-20 13:20:08.251305');
INSERT INTO public.virksomhet VALUES (137, '871710199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871710199', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.262757', '2023-09-20 13:20:08.262757');
INSERT INTO public.virksomhet VALUES (138, '893562928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893562928', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.273485', '2023-09-20 13:20:08.273485');
INSERT INTO public.virksomhet VALUES (139, '814580797', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814580797', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.284991', '2023-09-20 13:20:08.284991');
INSERT INTO public.virksomhet VALUES (140, '824227622', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824227622', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.296039', '2023-09-20 13:20:08.296039');
INSERT INTO public.virksomhet VALUES (141, '822739956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822739956', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.308513', '2023-09-20 13:20:08.308513');
INSERT INTO public.virksomhet VALUES (142, '899082690', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899082690', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.319074', '2023-09-20 13:20:08.319074');
INSERT INTO public.virksomhet VALUES (143, '814303355', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814303355', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.330453', '2023-09-20 13:20:08.330453');
INSERT INTO public.virksomhet VALUES (144, '817770567', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817770567', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.342607', '2023-09-20 13:20:08.342607');
INSERT INTO public.virksomhet VALUES (145, '826919947', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826919947', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.353242', '2023-09-20 13:20:08.353242');
INSERT INTO public.virksomhet VALUES (146, '896286002', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896286002', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.364223', '2023-09-20 13:20:08.364223');
INSERT INTO public.virksomhet VALUES (147, '816324996', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816324996', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.376328', '2023-09-20 13:20:08.376328');
INSERT INTO public.virksomhet VALUES (148, '870202885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870202885', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.386464', '2023-09-20 13:20:08.386464');
INSERT INTO public.virksomhet VALUES (149, '801626988', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801626988', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.397448', '2023-09-20 13:20:08.397448');
INSERT INTO public.virksomhet VALUES (150, '835614882', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835614882', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.408751', '2023-09-20 13:20:08.408751');
INSERT INTO public.virksomhet VALUES (151, '811717230', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811717230', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.418965', '2023-09-20 13:20:08.418965');
INSERT INTO public.virksomhet VALUES (152, '814085446', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814085446', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.430169', '2023-09-20 13:20:08.430169');
INSERT INTO public.virksomhet VALUES (153, '840940814', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840940814', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.440982', '2023-09-20 13:20:08.440982');
INSERT INTO public.virksomhet VALUES (154, '803138536', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803138536', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.450912', '2023-09-20 13:20:08.450912');
INSERT INTO public.virksomhet VALUES (155, '830490901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830490901', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.461265', '2023-09-20 13:20:08.461265');
INSERT INTO public.virksomhet VALUES (156, '871858419', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871858419', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.473435', '2023-09-20 13:20:08.473435');
INSERT INTO public.virksomhet VALUES (157, '861589487', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861589487', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.483779', '2023-09-20 13:20:08.483779');
INSERT INTO public.virksomhet VALUES (158, '889952963', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889952963', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.494991', '2023-09-20 13:20:08.494991');
INSERT INTO public.virksomhet VALUES (159, '874207259', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874207259', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.505134', '2023-09-20 13:20:08.505134');
INSERT INTO public.virksomhet VALUES (160, '821677085', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821677085', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.514104', '2023-09-20 13:20:08.514104');
INSERT INTO public.virksomhet VALUES (161, '800345488', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800345488', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.524761', '2023-09-20 13:20:08.524761');
INSERT INTO public.virksomhet VALUES (162, '871270191', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871270191', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.534729', '2023-09-20 13:20:08.534729');
INSERT INTO public.virksomhet VALUES (163, '854804194', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854804194', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.545649', '2023-09-20 13:20:08.545649');
INSERT INTO public.virksomhet VALUES (164, '858484692', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858484692', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.554367', '2023-09-20 13:20:08.554367');
INSERT INTO public.virksomhet VALUES (165, '808244298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808244298', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.563621', '2023-09-20 13:20:08.563621');
INSERT INTO public.virksomhet VALUES (166, '832434824', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832434824', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.573749', '2023-09-20 13:20:08.573749');
INSERT INTO public.virksomhet VALUES (167, '868719518', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868719518', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.583046', '2023-09-20 13:20:08.583046');
INSERT INTO public.virksomhet VALUES (168, '802326218', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802326218', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.592432', '2023-09-20 13:20:08.592432');
INSERT INTO public.virksomhet VALUES (169, '808957122', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808957122', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.602144', '2023-09-20 13:20:08.602144');
INSERT INTO public.virksomhet VALUES (170, '803905378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803905378', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.61193', '2023-09-20 13:20:08.61193');
INSERT INTO public.virksomhet VALUES (171, '828096369', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828096369', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.62144', '2023-09-20 13:20:08.62144');
INSERT INTO public.virksomhet VALUES (172, '873520346', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873520346', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.631796', '2023-09-20 13:20:08.631796');
INSERT INTO public.virksomhet VALUES (173, '890711444', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890711444', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.640813', '2023-09-20 13:20:08.640813');
INSERT INTO public.virksomhet VALUES (174, '822749114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822749114', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.650039', '2023-09-20 13:20:08.650039');
INSERT INTO public.virksomhet VALUES (175, '865757268', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865757268', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.659034', '2023-09-20 13:20:08.659034');
INSERT INTO public.virksomhet VALUES (176, '841423972', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841423972', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.6692', '2023-09-20 13:20:08.6692');
INSERT INTO public.virksomhet VALUES (177, '838241984', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838241984', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.679962', '2023-09-20 13:20:08.679962');
INSERT INTO public.virksomhet VALUES (178, '836230691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836230691', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.689092', '2023-09-20 13:20:08.689092');
INSERT INTO public.virksomhet VALUES (179, '882462835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882462835', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.699042', '2023-09-20 13:20:08.699042');
INSERT INTO public.virksomhet VALUES (180, '806009183', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806009183', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.709632', '2023-09-20 13:20:08.709632');
INSERT INTO public.virksomhet VALUES (181, '806086437', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806086437', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.719484', '2023-09-20 13:20:08.719484');
INSERT INTO public.virksomhet VALUES (182, '874040892', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874040892', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.729351', '2023-09-20 13:20:08.729351');
INSERT INTO public.virksomhet VALUES (183, '864804244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864804244', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.739479', '2023-09-20 13:20:08.739479');
INSERT INTO public.virksomhet VALUES (184, '878780302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878780302', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.749188', '2023-09-20 13:20:08.749188');
INSERT INTO public.virksomhet VALUES (185, '855713657', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855713657', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.758737', '2023-09-20 13:20:08.758737');
INSERT INTO public.virksomhet VALUES (186, '820690355', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820690355', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.768369', '2023-09-20 13:20:08.768369');
INSERT INTO public.virksomhet VALUES (187, '842125759', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842125759', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.778172', '2023-09-20 13:20:08.778172');
INSERT INTO public.virksomhet VALUES (188, '881056064', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881056064', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.788345', '2023-09-20 13:20:08.788345');
INSERT INTO public.virksomhet VALUES (189, '840478098', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840478098', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.798142', '2023-09-20 13:20:08.798142');
INSERT INTO public.virksomhet VALUES (190, '833295256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833295256', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.80831', '2023-09-20 13:20:08.80831');
INSERT INTO public.virksomhet VALUES (191, '837623542', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837623542', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.81833', '2023-09-20 13:20:08.81833');
INSERT INTO public.virksomhet VALUES (192, '810026055', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810026055', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.828291', '2023-09-20 13:20:08.828291');
INSERT INTO public.virksomhet VALUES (193, '833500107', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833500107', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.837007', '2023-09-20 13:20:08.837007');
INSERT INTO public.virksomhet VALUES (194, '825843723', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825843723', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.847036', '2023-09-20 13:20:08.847036');
INSERT INTO public.virksomhet VALUES (195, '844557328', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844557328', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.857633', '2023-09-20 13:20:08.857633');
INSERT INTO public.virksomhet VALUES (196, '843577057', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843577057', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.867228', '2023-09-20 13:20:08.867228');
INSERT INTO public.virksomhet VALUES (197, '867713258', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867713258', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.876934', '2023-09-20 13:20:08.876934');
INSERT INTO public.virksomhet VALUES (198, '824884019', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824884019', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.887372', '2023-09-20 13:20:08.887372');
INSERT INTO public.virksomhet VALUES (199, '821905784', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821905784', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.897954', '2023-09-20 13:20:08.897954');
INSERT INTO public.virksomhet VALUES (200, '848644922', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848644922', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.907797', '2023-09-20 13:20:08.907797');
INSERT INTO public.virksomhet VALUES (201, '850035701', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850035701', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.91692', '2023-09-20 13:20:08.91692');
INSERT INTO public.virksomhet VALUES (202, '843568000', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843568000', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.926693', '2023-09-20 13:20:08.926693');
INSERT INTO public.virksomhet VALUES (203, '805022936', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805022936', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.936143', '2023-09-20 13:20:08.936143');
INSERT INTO public.virksomhet VALUES (204, '873536341', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873536341', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.946178', '2023-09-20 13:20:08.946178');
INSERT INTO public.virksomhet VALUES (205, '816606992', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816606992', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.956478', '2023-09-20 13:20:08.956478');
INSERT INTO public.virksomhet VALUES (206, '833828890', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833828890', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.966106', '2023-09-20 13:20:08.966106');
INSERT INTO public.virksomhet VALUES (207, '829382061', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829382061', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.976032', '2023-09-20 13:20:08.976032');
INSERT INTO public.virksomhet VALUES (208, '855062916', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855062916', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.985403', '2023-09-20 13:20:08.985403');
INSERT INTO public.virksomhet VALUES (209, '861013607', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861013607', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:08.995566', '2023-09-20 13:20:08.995566');
INSERT INTO public.virksomhet VALUES (210, '838752844', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838752844', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.004982', '2023-09-20 13:20:09.004982');
INSERT INTO public.virksomhet VALUES (211, '871862482', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871862482', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.015017', '2023-09-20 13:20:09.015017');
INSERT INTO public.virksomhet VALUES (212, '852249416', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852249416', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.02336', '2023-09-20 13:20:09.02336');
INSERT INTO public.virksomhet VALUES (213, '821530057', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821530057', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.032866', '2023-09-20 13:20:09.032866');
INSERT INTO public.virksomhet VALUES (214, '877538496', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877538496', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.041431', '2023-09-20 13:20:09.041431');
INSERT INTO public.virksomhet VALUES (215, '859955431', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859955431', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.051428', '2023-09-20 13:20:09.051428');
INSERT INTO public.virksomhet VALUES (216, '894138918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894138918', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.060792', '2023-09-20 13:20:09.060792');
INSERT INTO public.virksomhet VALUES (217, '878866284', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878866284', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.07027', '2023-09-20 13:20:09.07027');
INSERT INTO public.virksomhet VALUES (218, '885569388', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885569388', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.079821', '2023-09-20 13:20:09.079821');
INSERT INTO public.virksomhet VALUES (219, '893295490', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893295490', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.089939', '2023-09-20 13:20:09.089939');
INSERT INTO public.virksomhet VALUES (220, '835640066', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835640066', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.100022', '2023-09-20 13:20:09.100022');
INSERT INTO public.virksomhet VALUES (221, '869885794', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869885794', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.11063', '2023-09-20 13:20:09.11063');
INSERT INTO public.virksomhet VALUES (222, '829496837', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829496837', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.120169', '2023-09-20 13:20:09.120169');
INSERT INTO public.virksomhet VALUES (223, '810778729', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810778729', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.130289', '2023-09-20 13:20:09.130289');
INSERT INTO public.virksomhet VALUES (224, '858365705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858365705', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.140589', '2023-09-20 13:20:09.140589');
INSERT INTO public.virksomhet VALUES (225, '835755322', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835755322', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.149332', '2023-09-20 13:20:09.149332');
INSERT INTO public.virksomhet VALUES (226, '853552534', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853552534', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.158227', '2023-09-20 13:20:09.158227');
INSERT INTO public.virksomhet VALUES (227, '824211301', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824211301', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.169403', '2023-09-20 13:20:09.169403');
INSERT INTO public.virksomhet VALUES (228, '835144476', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835144476', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.179258', '2023-09-20 13:20:09.179258');
INSERT INTO public.virksomhet VALUES (229, '810672024', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810672024', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.189377', '2023-09-20 13:20:09.189377');
INSERT INTO public.virksomhet VALUES (230, '816786037', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816786037', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.198777', '2023-09-20 13:20:09.198777');
INSERT INTO public.virksomhet VALUES (231, '806094817', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806094817', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.208537', '2023-09-20 13:20:09.208537');
INSERT INTO public.virksomhet VALUES (232, '866639021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866639021', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.217263', '2023-09-20 13:20:09.217263');
INSERT INTO public.virksomhet VALUES (233, '893274716', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893274716', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.227258', '2023-09-20 13:20:09.227258');
INSERT INTO public.virksomhet VALUES (234, '848244360', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848244360', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.236426', '2023-09-20 13:20:09.236426');
INSERT INTO public.virksomhet VALUES (235, '835895151', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835895151', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.246429', '2023-09-20 13:20:09.246429');
INSERT INTO public.virksomhet VALUES (236, '827603549', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827603549', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.25617', '2023-09-20 13:20:09.25617');
INSERT INTO public.virksomhet VALUES (237, '874876623', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874876623', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.265578', '2023-09-20 13:20:09.265578');
INSERT INTO public.virksomhet VALUES (238, '820496671', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820496671', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.275519', '2023-09-20 13:20:09.275519');
INSERT INTO public.virksomhet VALUES (239, '847391810', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847391810', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.284384', '2023-09-20 13:20:09.284384');
INSERT INTO public.virksomhet VALUES (240, '886545684', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886545684', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.294916', '2023-09-20 13:20:09.294916');
INSERT INTO public.virksomhet VALUES (241, '837545167', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837545167', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.304367', '2023-09-20 13:20:09.304367');
INSERT INTO public.virksomhet VALUES (242, '865865936', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865865936', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.31467', '2023-09-20 13:20:09.31467');
INSERT INTO public.virksomhet VALUES (243, '846771706', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846771706', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.324428', '2023-09-20 13:20:09.324428');
INSERT INTO public.virksomhet VALUES (244, '889704521', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889704521', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.334214', '2023-09-20 13:20:09.334214');
INSERT INTO public.virksomhet VALUES (245, '869094041', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869094041', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.344501', '2023-09-20 13:20:09.344501');
INSERT INTO public.virksomhet VALUES (246, '812609372', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812609372', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.354571', '2023-09-20 13:20:09.354571');
INSERT INTO public.virksomhet VALUES (247, '832769643', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832769643', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.364231', '2023-09-20 13:20:09.364231');
INSERT INTO public.virksomhet VALUES (248, '805214502', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805214502', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.374098', '2023-09-20 13:20:09.374098');
INSERT INTO public.virksomhet VALUES (249, '854920856', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854920856', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.383032', '2023-09-20 13:20:09.383032');
INSERT INTO public.virksomhet VALUES (250, '872231212', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872231212', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.393765', '2023-09-20 13:20:09.393765');
INSERT INTO public.virksomhet VALUES (251, '849173757', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849173757', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.402714', '2023-09-20 13:20:09.402714');
INSERT INTO public.virksomhet VALUES (252, '880853139', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880853139', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.412132', '2023-09-20 13:20:09.412132');
INSERT INTO public.virksomhet VALUES (253, '826530237', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826530237', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.421875', '2023-09-20 13:20:09.421875');
INSERT INTO public.virksomhet VALUES (254, '831091213', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831091213', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.431897', '2023-09-20 13:20:09.431897');
INSERT INTO public.virksomhet VALUES (255, '881204972', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881204972', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.442262', '2023-09-20 13:20:09.442262');
INSERT INTO public.virksomhet VALUES (256, '859080272', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859080272', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.450799', '2023-09-20 13:20:09.450799');
INSERT INTO public.virksomhet VALUES (257, '874695359', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874695359', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.459696', '2023-09-20 13:20:09.459696');
INSERT INTO public.virksomhet VALUES (258, '880050718', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880050718', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.468612', '2023-09-20 13:20:09.468612');
INSERT INTO public.virksomhet VALUES (259, '810571093', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810571093', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.476802', '2023-09-20 13:20:09.476802');
INSERT INTO public.virksomhet VALUES (260, '836608565', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836608565', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.486459', '2023-09-20 13:20:09.486459');
INSERT INTO public.virksomhet VALUES (261, '883252672', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883252672', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.496842', '2023-09-20 13:20:09.496842');
INSERT INTO public.virksomhet VALUES (262, '856635490', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856635490', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.505793', '2023-09-20 13:20:09.505793');
INSERT INTO public.virksomhet VALUES (263, '862713535', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862713535', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.514612', '2023-09-20 13:20:09.514612');
INSERT INTO public.virksomhet VALUES (264, '851002327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851002327', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.524999', '2023-09-20 13:20:09.524999');
INSERT INTO public.virksomhet VALUES (265, '833924226', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833924226', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.534644', '2023-09-20 13:20:09.534644');
INSERT INTO public.virksomhet VALUES (266, '895508306', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895508306', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.544196', '2023-09-20 13:20:09.544196');
INSERT INTO public.virksomhet VALUES (267, '868914223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868914223', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.55429', '2023-09-20 13:20:09.55429');
INSERT INTO public.virksomhet VALUES (268, '882774535', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882774535', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.564698', '2023-09-20 13:20:09.564698');
INSERT INTO public.virksomhet VALUES (269, '815099898', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815099898', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.574519', '2023-09-20 13:20:09.574519');
INSERT INTO public.virksomhet VALUES (270, '891870734', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891870734', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.584016', '2023-09-20 13:20:09.584016');
INSERT INTO public.virksomhet VALUES (271, '845737922', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845737922', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.593401', '2023-09-20 13:20:09.593401');
INSERT INTO public.virksomhet VALUES (272, '818122526', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818122526', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.602461', '2023-09-20 13:20:09.602461');
INSERT INTO public.virksomhet VALUES (273, '839472854', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839472854', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.612127', '2023-09-20 13:20:09.612127');
INSERT INTO public.virksomhet VALUES (274, '819847541', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819847541', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.621784', '2023-09-20 13:20:09.621784');
INSERT INTO public.virksomhet VALUES (275, '895933710', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895933710', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.630798', '2023-09-20 13:20:09.630798');
INSERT INTO public.virksomhet VALUES (276, '897679772', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897679772', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.64028', '2023-09-20 13:20:09.64028');
INSERT INTO public.virksomhet VALUES (277, '804089308', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804089308', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.649252', '2023-09-20 13:20:09.649252');
INSERT INTO public.virksomhet VALUES (278, '856569141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856569141', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.658929', '2023-09-20 13:20:09.658929');
INSERT INTO public.virksomhet VALUES (279, '895205411', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895205411', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.669285', '2023-09-20 13:20:09.669285');
INSERT INTO public.virksomhet VALUES (280, '833299978', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833299978', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.679124', '2023-09-20 13:20:09.679124');
INSERT INTO public.virksomhet VALUES (281, '829450455', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829450455', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.687147', '2023-09-20 13:20:09.687147');
INSERT INTO public.virksomhet VALUES (282, '844925941', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844925941', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.69725', '2023-09-20 13:20:09.69725');
INSERT INTO public.virksomhet VALUES (283, '847173183', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847173183', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.707892', '2023-09-20 13:20:09.707892');
INSERT INTO public.virksomhet VALUES (284, '869194708', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869194708', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.718131', '2023-09-20 13:20:09.718131');
INSERT INTO public.virksomhet VALUES (285, '860600885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860600885', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.72848', '2023-09-20 13:20:09.72848');
INSERT INTO public.virksomhet VALUES (286, '846166025', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846166025', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.738192', '2023-09-20 13:20:09.738192');
INSERT INTO public.virksomhet VALUES (287, '850284626', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850284626', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.74837', '2023-09-20 13:20:09.74837');
INSERT INTO public.virksomhet VALUES (288, '842045486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842045486', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.758134', '2023-09-20 13:20:09.758134');
INSERT INTO public.virksomhet VALUES (289, '800914575', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800914575', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.767671', '2023-09-20 13:20:09.767671');
INSERT INTO public.virksomhet VALUES (290, '878948878', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878948878', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.777165', '2023-09-20 13:20:09.777165');
INSERT INTO public.virksomhet VALUES (291, '861720398', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861720398', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.787004', '2023-09-20 13:20:09.787004');
INSERT INTO public.virksomhet VALUES (292, '813406508', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813406508', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.79674', '2023-09-20 13:20:09.79674');
INSERT INTO public.virksomhet VALUES (293, '883254689', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883254689', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.805693', '2023-09-20 13:20:09.805693');
INSERT INTO public.virksomhet VALUES (294, '813082125', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813082125', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.814942', '2023-09-20 13:20:09.814942');
INSERT INTO public.virksomhet VALUES (295, '805981764', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805981764', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.82441', '2023-09-20 13:20:09.82441');
INSERT INTO public.virksomhet VALUES (296, '822539424', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822539424', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.834166', '2023-09-20 13:20:09.834166');
INSERT INTO public.virksomhet VALUES (297, '864608813', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864608813', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.844212', '2023-09-20 13:20:09.844212');
INSERT INTO public.virksomhet VALUES (298, '814671042', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814671042', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.85387', '2023-09-20 13:20:09.85387');
INSERT INTO public.virksomhet VALUES (299, '805298977', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805298977', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.863856', '2023-09-20 13:20:09.863856');
INSERT INTO public.virksomhet VALUES (300, '806503523', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806503523', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.872261', '2023-09-20 13:20:09.872261');
INSERT INTO public.virksomhet VALUES (301, '813090036', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813090036', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.882055', '2023-09-20 13:20:09.882055');
INSERT INTO public.virksomhet VALUES (302, '825232538', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825232538', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.891228', '2023-09-20 13:20:09.891228');
INSERT INTO public.virksomhet VALUES (303, '896717340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896717340', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.90086', '2023-09-20 13:20:09.90086');
INSERT INTO public.virksomhet VALUES (304, '867730555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867730555', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.910282', '2023-09-20 13:20:09.910282');
INSERT INTO public.virksomhet VALUES (305, '860709886', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860709886', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.919991', '2023-09-20 13:20:09.919991');
INSERT INTO public.virksomhet VALUES (306, '826144732', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826144732', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.932414', '2023-09-20 13:20:09.932414');
INSERT INTO public.virksomhet VALUES (307, '855380684', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855380684', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.941882', '2023-09-20 13:20:09.941882');
INSERT INTO public.virksomhet VALUES (308, '802409008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802409008', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.951301', '2023-09-20 13:20:09.951301');
INSERT INTO public.virksomhet VALUES (309, '846073756', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846073756', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.961136', '2023-09-20 13:20:09.961136');
INSERT INTO public.virksomhet VALUES (310, '832339971', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832339971', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.970192', '2023-09-20 13:20:09.970192');
INSERT INTO public.virksomhet VALUES (311, '812642972', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812642972', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.980212', '2023-09-20 13:20:09.980212');
INSERT INTO public.virksomhet VALUES (312, '890359561', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890359561', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.990567', '2023-09-20 13:20:09.990567');
INSERT INTO public.virksomhet VALUES (313, '823269861', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823269861', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:09.999215', '2023-09-20 13:20:09.999215');
INSERT INTO public.virksomhet VALUES (314, '871247901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871247901', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.008522', '2023-09-20 13:20:10.008522');
INSERT INTO public.virksomhet VALUES (315, '820322919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820322919', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.017565', '2023-09-20 13:20:10.017565');
INSERT INTO public.virksomhet VALUES (316, '830223615', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830223615', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.02742', '2023-09-20 13:20:10.02742');
INSERT INTO public.virksomhet VALUES (317, '848901065', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848901065', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.036372', '2023-09-20 13:20:10.036372');
INSERT INTO public.virksomhet VALUES (318, '858618364', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858618364', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.046551', '2023-09-20 13:20:10.046551');
INSERT INTO public.virksomhet VALUES (319, '846046929', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846046929', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.056522', '2023-09-20 13:20:10.056522');
INSERT INTO public.virksomhet VALUES (320, '810907776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810907776', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.064817', '2023-09-20 13:20:10.064817');
INSERT INTO public.virksomhet VALUES (321, '828839903', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828839903', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.074895', '2023-09-20 13:20:10.074895');
INSERT INTO public.virksomhet VALUES (322, '853938553', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853938553', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.083255', '2023-09-20 13:20:10.083255');
INSERT INTO public.virksomhet VALUES (323, '824825569', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824825569', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.092842', '2023-09-20 13:20:10.092842');
INSERT INTO public.virksomhet VALUES (324, '879703311', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879703311', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.102373', '2023-09-20 13:20:10.102373');
INSERT INTO public.virksomhet VALUES (325, '857535758', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857535758', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.111785', '2023-09-20 13:20:10.111785');
INSERT INTO public.virksomhet VALUES (326, '886348164', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886348164', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.120053', '2023-09-20 13:20:10.120053');
INSERT INTO public.virksomhet VALUES (327, '816619122', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816619122', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.130143', '2023-09-20 13:20:10.130143');
INSERT INTO public.virksomhet VALUES (328, '898232963', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898232963', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.140603', '2023-09-20 13:20:10.140603');
INSERT INTO public.virksomhet VALUES (329, '853154335', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853154335', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.149404', '2023-09-20 13:20:10.149404');
INSERT INTO public.virksomhet VALUES (330, '802281305', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802281305', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.159705', '2023-09-20 13:20:10.159705');
INSERT INTO public.virksomhet VALUES (331, '873891689', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873891689', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.170385', '2023-09-20 13:20:10.170385');
INSERT INTO public.virksomhet VALUES (332, '859936907', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859936907', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.180443', '2023-09-20 13:20:10.180443');
INSERT INTO public.virksomhet VALUES (333, '885511157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885511157', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.190242', '2023-09-20 13:20:10.190242');
INSERT INTO public.virksomhet VALUES (334, '810915087', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810915087', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.199253', '2023-09-20 13:20:10.199253');
INSERT INTO public.virksomhet VALUES (335, '813557180', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813557180', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.209033', '2023-09-20 13:20:10.209033');
INSERT INTO public.virksomhet VALUES (336, '848628023', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848628023', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.21874', '2023-09-20 13:20:10.21874');
INSERT INTO public.virksomhet VALUES (337, '805980144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805980144', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.228767', '2023-09-20 13:20:10.228767');
INSERT INTO public.virksomhet VALUES (338, '838450728', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838450728', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.237688', '2023-09-20 13:20:10.237688');
INSERT INTO public.virksomhet VALUES (339, '899304828', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899304828', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.247151', '2023-09-20 13:20:10.247151');
INSERT INTO public.virksomhet VALUES (340, '813906933', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813906933', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.256593', '2023-09-20 13:20:10.256593');
INSERT INTO public.virksomhet VALUES (341, '876070192', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876070192', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.266199', '2023-09-20 13:20:10.266199');
INSERT INTO public.virksomhet VALUES (342, '824131068', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824131068', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.27599', '2023-09-20 13:20:10.27599');
INSERT INTO public.virksomhet VALUES (343, '861754913', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861754913', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.285392', '2023-09-20 13:20:10.285392');
INSERT INTO public.virksomhet VALUES (344, '827715003', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827715003', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.295075', '2023-09-20 13:20:10.295075');
INSERT INTO public.virksomhet VALUES (345, '834715468', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834715468', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.304893', '2023-09-20 13:20:10.304893');
INSERT INTO public.virksomhet VALUES (346, '868943348', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868943348', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.313693', '2023-09-20 13:20:10.313693');
INSERT INTO public.virksomhet VALUES (347, '842913833', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842913833', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.323106', '2023-09-20 13:20:10.323106');
INSERT INTO public.virksomhet VALUES (348, '894993206', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894993206', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.332986', '2023-09-20 13:20:10.332986');
INSERT INTO public.virksomhet VALUES (349, '801129590', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801129590', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.343026', '2023-09-20 13:20:10.343026');
INSERT INTO public.virksomhet VALUES (350, '899994755', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899994755', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.351783', '2023-09-20 13:20:10.351783');
INSERT INTO public.virksomhet VALUES (351, '860859451', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860859451', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.362126', '2023-09-20 13:20:10.362126');
INSERT INTO public.virksomhet VALUES (352, '859246854', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859246854', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.372217', '2023-09-20 13:20:10.372217');
INSERT INTO public.virksomhet VALUES (353, '892123638', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892123638', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.382405', '2023-09-20 13:20:10.382405');
INSERT INTO public.virksomhet VALUES (354, '818264002', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818264002', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.392549', '2023-09-20 13:20:10.392549');
INSERT INTO public.virksomhet VALUES (355, '890405244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890405244', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.402048', '2023-09-20 13:20:10.402048');
INSERT INTO public.virksomhet VALUES (356, '812894112', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812894112', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.411804', '2023-09-20 13:20:10.411804');
INSERT INTO public.virksomhet VALUES (357, '814808060', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814808060', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.420382', '2023-09-20 13:20:10.420382');
INSERT INTO public.virksomhet VALUES (358, '897037401', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897037401', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.43004', '2023-09-20 13:20:10.43004');
INSERT INTO public.virksomhet VALUES (359, '851305604', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851305604', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.438779', '2023-09-20 13:20:10.438779');
INSERT INTO public.virksomhet VALUES (360, '891720600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891720600', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.448309', '2023-09-20 13:20:10.448309');
INSERT INTO public.virksomhet VALUES (361, '872816596', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872816596', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.457702', '2023-09-20 13:20:10.457702');
INSERT INTO public.virksomhet VALUES (362, '882181144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882181144', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.46727', '2023-09-20 13:20:10.46727');
INSERT INTO public.virksomhet VALUES (363, '820199495', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820199495', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.476549', '2023-09-20 13:20:10.476549');
INSERT INTO public.virksomhet VALUES (364, '824807396', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824807396', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.486296', '2023-09-20 13:20:10.486296');
INSERT INTO public.virksomhet VALUES (365, '866863678', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866863678', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.495138', '2023-09-20 13:20:10.495138');
INSERT INTO public.virksomhet VALUES (366, '877779639', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877779639', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.504992', '2023-09-20 13:20:10.504992');
INSERT INTO public.virksomhet VALUES (367, '864447069', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864447069', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.515381', '2023-09-20 13:20:10.515381');
INSERT INTO public.virksomhet VALUES (368, '885784250', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885784250', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.524089', '2023-09-20 13:20:10.524089');
INSERT INTO public.virksomhet VALUES (369, '862689086', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862689086', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.534107', '2023-09-20 13:20:10.534107');
INSERT INTO public.virksomhet VALUES (370, '877580718', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877580718', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.54446', '2023-09-20 13:20:10.54446');
INSERT INTO public.virksomhet VALUES (371, '829517871', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829517871', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.554375', '2023-09-20 13:20:10.554375');
INSERT INTO public.virksomhet VALUES (372, '891687765', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891687765', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.564355', '2023-09-20 13:20:10.564355');
INSERT INTO public.virksomhet VALUES (373, '844574378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844574378', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.572994', '2023-09-20 13:20:10.572994');
INSERT INTO public.virksomhet VALUES (374, '869521283', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869521283', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.58407', '2023-09-20 13:20:10.58407');
INSERT INTO public.virksomhet VALUES (375, '873364248', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873364248', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.59564', '2023-09-20 13:20:10.59564');
INSERT INTO public.virksomhet VALUES (376, '882696545', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882696545', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.604958', '2023-09-20 13:20:10.604958');
INSERT INTO public.virksomhet VALUES (377, '851855465', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851855465', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.615668', '2023-09-20 13:20:10.615668');
INSERT INTO public.virksomhet VALUES (378, '886467616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886467616', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.625378', '2023-09-20 13:20:10.625378');
INSERT INTO public.virksomhet VALUES (379, '863969848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863969848', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.635099', '2023-09-20 13:20:10.635099');
INSERT INTO public.virksomhet VALUES (380, '818058331', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818058331', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.645532', '2023-09-20 13:20:10.645532');
INSERT INTO public.virksomhet VALUES (381, '823612750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823612750', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.654484', '2023-09-20 13:20:10.654484');
INSERT INTO public.virksomhet VALUES (382, '858372645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858372645', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.665095', '2023-09-20 13:20:10.665095');
INSERT INTO public.virksomhet VALUES (383, '878838998', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878838998', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.673876', '2023-09-20 13:20:10.673876');
INSERT INTO public.virksomhet VALUES (384, '809603600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809603600', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.683595', '2023-09-20 13:20:10.683595');
INSERT INTO public.virksomhet VALUES (385, '811456573', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811456573', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.692642', '2023-09-20 13:20:10.692642');
INSERT INTO public.virksomhet VALUES (386, '876241838', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876241838', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.701812', '2023-09-20 13:20:10.701812');
INSERT INTO public.virksomhet VALUES (387, '823349197', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823349197', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.711558', '2023-09-20 13:20:10.711558');
INSERT INTO public.virksomhet VALUES (388, '802065158', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802065158', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.720656', '2023-09-20 13:20:10.720656');
INSERT INTO public.virksomhet VALUES (389, '888535415', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888535415', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.730648', '2023-09-20 13:20:10.730648');
INSERT INTO public.virksomhet VALUES (390, '865263765', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865263765', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.741345', '2023-09-20 13:20:10.741345');
INSERT INTO public.virksomhet VALUES (391, '872799429', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872799429', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.751747', '2023-09-20 13:20:10.751747');
INSERT INTO public.virksomhet VALUES (392, '883091871', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883091871', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.762342', '2023-09-20 13:20:10.762342');
INSERT INTO public.virksomhet VALUES (393, '813071138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813071138', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.773068', '2023-09-20 13:20:10.773068');
INSERT INTO public.virksomhet VALUES (394, '814396800', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814396800', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.783956', '2023-09-20 13:20:10.783956');
INSERT INTO public.virksomhet VALUES (395, '880948108', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880948108', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.793859', '2023-09-20 13:20:10.793859');
INSERT INTO public.virksomhet VALUES (396, '875685681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875685681', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.803766', '2023-09-20 13:20:10.803766');
INSERT INTO public.virksomhet VALUES (397, '825623598', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825623598', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.814357', '2023-09-20 13:20:10.814357');
INSERT INTO public.virksomhet VALUES (398, '899020077', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899020077', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.824751', '2023-09-20 13:20:10.824751');
INSERT INTO public.virksomhet VALUES (399, '834963803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834963803', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.834745', '2023-09-20 13:20:10.834745');
INSERT INTO public.virksomhet VALUES (400, '893219391', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893219391', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.844595', '2023-09-20 13:20:10.844595');
INSERT INTO public.virksomhet VALUES (401, '886989131', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886989131', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.85293', '2023-09-20 13:20:10.85293');
INSERT INTO public.virksomhet VALUES (402, '800414105', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800414105', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.861957', '2023-09-20 13:20:10.861957');
INSERT INTO public.virksomhet VALUES (403, '800776209', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800776209', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.871659', '2023-09-20 13:20:10.871659');
INSERT INTO public.virksomhet VALUES (404, '870889685', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870889685', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.881464', '2023-09-20 13:20:10.881464');
INSERT INTO public.virksomhet VALUES (405, '857471550', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857471550', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.891332', '2023-09-20 13:20:10.891332');
INSERT INTO public.virksomhet VALUES (406, '801971876', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801971876', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.901623', '2023-09-20 13:20:10.901623');
INSERT INTO public.virksomhet VALUES (407, '887833300', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887833300', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.912953', '2023-09-20 13:20:10.912953');
INSERT INTO public.virksomhet VALUES (408, '884466337', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884466337', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.923664', '2023-09-20 13:20:10.923664');
INSERT INTO public.virksomhet VALUES (409, '822487729', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822487729', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.9339', '2023-09-20 13:20:10.9339');
INSERT INTO public.virksomhet VALUES (410, '875804067', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875804067', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.944398', '2023-09-20 13:20:10.944398');
INSERT INTO public.virksomhet VALUES (411, '871908613', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871908613', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.953906', '2023-09-20 13:20:10.953906');
INSERT INTO public.virksomhet VALUES (412, '880023337', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880023337', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.963583', '2023-09-20 13:20:10.963583');
INSERT INTO public.virksomhet VALUES (413, '820589754', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820589754', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.974099', '2023-09-20 13:20:10.974099');
INSERT INTO public.virksomhet VALUES (414, '890506842', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890506842', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.983642', '2023-09-20 13:20:10.983642');
INSERT INTO public.virksomhet VALUES (415, '890222780', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890222780', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:10.99357', '2023-09-20 13:20:10.99357');
INSERT INTO public.virksomhet VALUES (416, '806520934', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806520934', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.003223', '2023-09-20 13:20:11.003223');
INSERT INTO public.virksomhet VALUES (417, '820427752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820427752', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.012945', '2023-09-20 13:20:11.012945');
INSERT INTO public.virksomhet VALUES (418, '854038331', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854038331', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.022742', '2023-09-20 13:20:11.022742');
INSERT INTO public.virksomhet VALUES (419, '881460629', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881460629', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.032687', '2023-09-20 13:20:11.032687');
INSERT INTO public.virksomhet VALUES (420, '807833245', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807833245', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.042853', '2023-09-20 13:20:11.042853');
INSERT INTO public.virksomhet VALUES (421, '858347671', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858347671', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.051955', '2023-09-20 13:20:11.051955');
INSERT INTO public.virksomhet VALUES (422, '845518266', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845518266', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.062589', '2023-09-20 13:20:11.062589');
INSERT INTO public.virksomhet VALUES (423, '846889775', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846889775', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.072067', '2023-09-20 13:20:11.072067');
INSERT INTO public.virksomhet VALUES (424, '807839893', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807839893', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.082354', '2023-09-20 13:20:11.082354');
INSERT INTO public.virksomhet VALUES (425, '871664285', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871664285', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.091989', '2023-09-20 13:20:11.091989');
INSERT INTO public.virksomhet VALUES (426, '888742907', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888742907', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.101513', '2023-09-20 13:20:11.101513');
INSERT INTO public.virksomhet VALUES (427, '849737517', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849737517', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.110146', '2023-09-20 13:20:11.110146');
INSERT INTO public.virksomhet VALUES (428, '859483557', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859483557', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.119279', '2023-09-20 13:20:11.119279');
INSERT INTO public.virksomhet VALUES (429, '800181497', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800181497', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.128084', '2023-09-20 13:20:11.128084');
INSERT INTO public.virksomhet VALUES (430, '881651167', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881651167', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.137684', '2023-09-20 13:20:11.137684');
INSERT INTO public.virksomhet VALUES (431, '815418627', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815418627', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.146996', '2023-09-20 13:20:11.146996');
INSERT INTO public.virksomhet VALUES (432, '832002465', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832002465', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.156459', '2023-09-20 13:20:11.156459');
INSERT INTO public.virksomhet VALUES (433, '817157884', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817157884', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.165891', '2023-09-20 13:20:11.165891');
INSERT INTO public.virksomhet VALUES (434, '859963954', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859963954', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.176878', '2023-09-20 13:20:11.176878');
INSERT INTO public.virksomhet VALUES (435, '828257776', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828257776', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.187542', '2023-09-20 13:20:11.187542');
INSERT INTO public.virksomhet VALUES (436, '814916395', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814916395', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.197356', '2023-09-20 13:20:11.197356');
INSERT INTO public.virksomhet VALUES (437, '830331208', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830331208', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.207564', '2023-09-20 13:20:11.207564');
INSERT INTO public.virksomhet VALUES (438, '888695203', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888695203', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.218034', '2023-09-20 13:20:11.218034');
INSERT INTO public.virksomhet VALUES (439, '876502363', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876502363', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.226737', '2023-09-20 13:20:11.226737');
INSERT INTO public.virksomhet VALUES (440, '827890157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827890157', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.235547', '2023-09-20 13:20:11.235547');
INSERT INTO public.virksomhet VALUES (441, '838001870', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838001870', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.244983', '2023-09-20 13:20:11.244983');
INSERT INTO public.virksomhet VALUES (442, '825152796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825152796', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.25445', '2023-09-20 13:20:11.25445');
INSERT INTO public.virksomhet VALUES (443, '869762191', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869762191', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.263605', '2023-09-20 13:20:11.263605');
INSERT INTO public.virksomhet VALUES (444, '833822203', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833822203', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.271538', '2023-09-20 13:20:11.271538');
INSERT INTO public.virksomhet VALUES (445, '828948946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828948946', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.280396', '2023-09-20 13:20:11.280396');
INSERT INTO public.virksomhet VALUES (446, '817186434', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817186434', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.289467', '2023-09-20 13:20:11.289467');
INSERT INTO public.virksomhet VALUES (447, '840659024', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840659024', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.298487', '2023-09-20 13:20:11.298487');
INSERT INTO public.virksomhet VALUES (448, '846453027', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846453027', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.306714', '2023-09-20 13:20:11.306714');
INSERT INTO public.virksomhet VALUES (449, '804300620', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804300620', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.315148', '2023-09-20 13:20:11.315148');
INSERT INTO public.virksomhet VALUES (450, '808292440', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808292440', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.32361', '2023-09-20 13:20:11.32361');
INSERT INTO public.virksomhet VALUES (451, '879023146', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879023146', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.333792', '2023-09-20 13:20:11.333792');
INSERT INTO public.virksomhet VALUES (452, '861390542', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861390542', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.343639', '2023-09-20 13:20:11.343639');
INSERT INTO public.virksomhet VALUES (453, '803387738', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803387738', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.352135', '2023-09-20 13:20:11.352135');
INSERT INTO public.virksomhet VALUES (454, '803844864', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803844864', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.360164', '2023-09-20 13:20:11.360164');
INSERT INTO public.virksomhet VALUES (455, '864725756', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864725756', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.369079', '2023-09-20 13:20:11.369079');
INSERT INTO public.virksomhet VALUES (456, '883139685', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883139685', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.37858', '2023-09-20 13:20:11.37858');
INSERT INTO public.virksomhet VALUES (457, '867282851', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867282851', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.388187', '2023-09-20 13:20:11.388187');
INSERT INTO public.virksomhet VALUES (458, '811689225', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811689225', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.397844', '2023-09-20 13:20:11.397844');
INSERT INTO public.virksomhet VALUES (459, '809582812', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809582812', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.406708', '2023-09-20 13:20:11.406708');
INSERT INTO public.virksomhet VALUES (460, '839305987', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839305987', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.415788', '2023-09-20 13:20:11.415788');
INSERT INTO public.virksomhet VALUES (461, '864192376', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864192376', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.425544', '2023-09-20 13:20:11.425544');
INSERT INTO public.virksomhet VALUES (462, '852148023', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852148023', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.433416', '2023-09-20 13:20:11.433416');
INSERT INTO public.virksomhet VALUES (463, '841398189', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841398189', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.442355', '2023-09-20 13:20:11.442355');
INSERT INTO public.virksomhet VALUES (464, '805383943', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805383943', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.451421', '2023-09-20 13:20:11.451421');
INSERT INTO public.virksomhet VALUES (465, '848882011', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848882011', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.460105', '2023-09-20 13:20:11.460105');
INSERT INTO public.virksomhet VALUES (466, '838704760', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838704760', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.469465', '2023-09-20 13:20:11.469465');
INSERT INTO public.virksomhet VALUES (467, '802798289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802798289', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.478946', '2023-09-20 13:20:11.478946');
INSERT INTO public.virksomhet VALUES (468, '817998975', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817998975', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.486695', '2023-09-20 13:20:11.486695');
INSERT INTO public.virksomhet VALUES (469, '812235712', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812235712', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.496175', '2023-09-20 13:20:11.496175');
INSERT INTO public.virksomhet VALUES (470, '874242317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874242317', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.505039', '2023-09-20 13:20:11.505039');
INSERT INTO public.virksomhet VALUES (471, '830334365', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830334365', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.514722', '2023-09-20 13:20:11.514722');
INSERT INTO public.virksomhet VALUES (472, '813876916', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813876916', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.522981', '2023-09-20 13:20:11.522981');
INSERT INTO public.virksomhet VALUES (473, '856861246', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856861246', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.532808', '2023-09-20 13:20:11.532808');
INSERT INTO public.virksomhet VALUES (474, '825253279', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825253279', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.542519', '2023-09-20 13:20:11.542519');
INSERT INTO public.virksomhet VALUES (475, '862232820', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862232820', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.552246', '2023-09-20 13:20:11.552246');
INSERT INTO public.virksomhet VALUES (476, '829955165', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829955165', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.562024', '2023-09-20 13:20:11.562024');
INSERT INTO public.virksomhet VALUES (477, '892129974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892129974', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.570308', '2023-09-20 13:20:11.570308');
INSERT INTO public.virksomhet VALUES (478, '837180015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837180015', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.580329', '2023-09-20 13:20:11.580329');
INSERT INTO public.virksomhet VALUES (479, '844238330', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844238330', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.59', '2023-09-20 13:20:11.59');
INSERT INTO public.virksomhet VALUES (480, '876653097', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876653097', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.599803', '2023-09-20 13:20:11.599803');
INSERT INTO public.virksomhet VALUES (481, '886290642', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886290642', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.608736', '2023-09-20 13:20:11.608736');
INSERT INTO public.virksomhet VALUES (482, '892588971', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892588971', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.618345', '2023-09-20 13:20:11.618345');
INSERT INTO public.virksomhet VALUES (483, '873788685', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873788685', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.628018', '2023-09-20 13:20:11.628018');
INSERT INTO public.virksomhet VALUES (484, '848177872', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848177872', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.637001', '2023-09-20 13:20:11.637001');
INSERT INTO public.virksomhet VALUES (485, '842951610', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842951610', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.645764', '2023-09-20 13:20:11.645764');
INSERT INTO public.virksomhet VALUES (486, '887524559', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887524559', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.653183', '2023-09-20 13:20:11.653183');
INSERT INTO public.virksomhet VALUES (487, '898606269', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898606269', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.662328', '2023-09-20 13:20:11.662328');
INSERT INTO public.virksomhet VALUES (488, '882700408', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882700408', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.671855', '2023-09-20 13:20:11.671855');
INSERT INTO public.virksomhet VALUES (489, '804675096', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804675096', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.681677', '2023-09-20 13:20:11.681677');
INSERT INTO public.virksomhet VALUES (490, '833137928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833137928', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.691001', '2023-09-20 13:20:11.691001');
INSERT INTO public.virksomhet VALUES (491, '847143733', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847143733', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.700701', '2023-09-20 13:20:11.700701');
INSERT INTO public.virksomhet VALUES (492, '880270128', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880270128', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.709579', '2023-09-20 13:20:11.709579');
INSERT INTO public.virksomhet VALUES (493, '876908783', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876908783', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.718918', '2023-09-20 13:20:11.718918');
INSERT INTO public.virksomhet VALUES (494, '847816292', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847816292', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.728368', '2023-09-20 13:20:11.728368');
INSERT INTO public.virksomhet VALUES (495, '800454934', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800454934', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.737079', '2023-09-20 13:20:11.737079');
INSERT INTO public.virksomhet VALUES (496, '875580850', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875580850', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.746197', '2023-09-20 13:20:11.746197');
INSERT INTO public.virksomhet VALUES (497, '872253338', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872253338', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.755519', '2023-09-20 13:20:11.755519');
INSERT INTO public.virksomhet VALUES (498, '849867639', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849867639', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.765833', '2023-09-20 13:20:11.765833');
INSERT INTO public.virksomhet VALUES (499, '854107024', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854107024', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.775661', '2023-09-20 13:20:11.775661');
INSERT INTO public.virksomhet VALUES (500, '878251627', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878251627', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.784562', '2023-09-20 13:20:11.784562');
INSERT INTO public.virksomhet VALUES (501, '898116069', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898116069', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.793188', '2023-09-20 13:20:11.793188');
INSERT INTO public.virksomhet VALUES (502, '846090567', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846090567', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.802875', '2023-09-20 13:20:11.802875');
INSERT INTO public.virksomhet VALUES (503, '864592196', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864592196', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.812891', '2023-09-20 13:20:11.812891');
INSERT INTO public.virksomhet VALUES (504, '855303240', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855303240', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.822423', '2023-09-20 13:20:11.822423');
INSERT INTO public.virksomhet VALUES (505, '897230637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897230637', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.832567', '2023-09-20 13:20:11.832567');
INSERT INTO public.virksomhet VALUES (506, '899928561', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899928561', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.841932', '2023-09-20 13:20:11.841932');
INSERT INTO public.virksomhet VALUES (507, '830072613', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830072613', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.851325', '2023-09-20 13:20:11.851325');
INSERT INTO public.virksomhet VALUES (508, '821059938', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821059938', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.86024', '2023-09-20 13:20:11.86024');
INSERT INTO public.virksomhet VALUES (509, '846729601', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846729601', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.869418', '2023-09-20 13:20:11.869418');
INSERT INTO public.virksomhet VALUES (510, '800795308', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800795308', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:11.879849', '2023-09-20 13:20:11.879849');
INSERT INTO public.virksomhet VALUES (511, '885895732', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885895732', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 13:20:13.004924', '2023-09-20 13:20:13.004924');
INSERT INTO public.virksomhet VALUES (512, '888926367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '763629888 nvaN', '{adresse}', 'AKTIV', '2010-07-01', 888926368, '2023-09-20 13:20:13.01445', '2023-09-20 13:20:14.147496');
INSERT INTO public.virksomhet VALUES (513, '858343080', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '080343858 nvaN', '{adresse}', 'AKTIV', '2010-07-01', 858343081, '2023-09-20 13:20:13.023829', '2023-09-20 13:20:14.152289');
INSERT INTO public.virksomhet VALUES (514, '892377219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '912773298 nvaN', '{adresse}', 'AKTIV', '2010-07-01', 892377220, '2023-09-20 13:20:13.033709', '2023-09-20 13:20:14.153266');
INSERT INTO public.virksomhet VALUES (515, '870010381', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '183010078 nvaN', '{adresse}', 'AKTIV', '2010-07-01', 870010382, '2023-09-20 13:20:13.043297', '2023-09-20 13:20:14.153568');
INSERT INTO public.virksomhet VALUES (516, '893430686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '686034398 nvaN', '{adresse}', 'AKTIV', '2010-07-01', 893430687, '2023-09-20 13:20:13.052925', '2023-09-20 13:20:14.153846');
INSERT INTO public.virksomhet VALUES (527, '865238543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '345832568 nvaN', '{adresse}', 'AKTIV', '2010-07-01', 865238544, '2023-09-20 13:20:13.153025', '2023-09-20 13:20:14.154198');
INSERT INTO public.virksomhet VALUES (517, '828247932', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828247932', '{adresse}', 'FJERNET', '2023-01-01', 828247933, '2023-09-20 13:20:13.062341', '2023-09-20 13:20:14.154621');
INSERT INTO public.virksomhet VALUES (518, '843668858', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843668858', '{adresse}', 'FJERNET', '2023-01-01', 843668859, '2023-09-20 13:20:13.070725', '2023-09-20 13:20:14.154975');
INSERT INTO public.virksomhet VALUES (519, '810824719', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810824719', '{adresse}', 'FJERNET', '2023-01-01', 810824720, '2023-09-20 13:20:13.081573', '2023-09-20 13:20:14.155164');
INSERT INTO public.virksomhet VALUES (520, '876496878', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876496878', '{adresse}', 'FJERNET', '2023-01-01', 876496879, '2023-09-20 13:20:13.090855', '2023-09-20 13:20:14.155314');
INSERT INTO public.virksomhet VALUES (521, '874998757', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874998757', '{adresse}', 'FJERNET', '2023-01-01', 874998758, '2023-09-20 13:20:13.100364', '2023-09-20 13:20:14.155424');
INSERT INTO public.virksomhet VALUES (522, '895211720', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895211720', '{adresse}', 'SLETTET', '2023-01-01', 895211721, '2023-09-20 13:20:13.108424', '2023-09-20 13:20:14.155521');
INSERT INTO public.virksomhet VALUES (523, '837329833', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837329833', '{adresse}', 'SLETTET', '2023-01-01', 837329834, '2023-09-20 13:20:13.116754', '2023-09-20 13:20:14.155601');
INSERT INTO public.virksomhet VALUES (524, '872199612', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872199612', '{adresse}', 'SLETTET', '2023-01-01', 872199613, '2023-09-20 13:20:13.126199', '2023-09-20 13:20:14.15568');
INSERT INTO public.virksomhet VALUES (525, '857424051', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857424051', '{adresse}', 'SLETTET', '2023-01-01', 857424052, '2023-09-20 13:20:13.134747', '2023-09-20 13:20:14.155756');
INSERT INTO public.virksomhet VALUES (526, '829793291', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829793291', '{adresse}', 'SLETTET', '2023-01-01', 829793292, '2023-09-20 13:20:13.144449', '2023-09-20 13:20:14.155832');
INSERT INTO public.virksomhet VALUES (534, '864624615', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864624615', '{adresse}', 'AKTIV', '2010-07-01', 864624616, '2023-09-20 13:20:14.158695', '2023-09-20 13:20:14.158695');
INSERT INTO public.virksomhet VALUES (535, '846411852', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846411852', '{adresse}', 'AKTIV', '2010-07-01', 846411853, '2023-09-20 13:20:14.172769', '2023-09-20 13:20:14.172769');
INSERT INTO public.virksomhet VALUES (536, '885071694', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885071694', '{adresse}', 'AKTIV', '2010-07-01', 885071695, '2023-09-20 13:20:14.173439', '2023-09-20 13:20:14.173439');
INSERT INTO public.virksomhet VALUES (537, '862267780', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862267780', '{adresse}', 'AKTIV', '2010-07-01', 862267781, '2023-09-20 13:20:14.173792', '2023-09-20 13:20:14.173792');
INSERT INTO public.virksomhet VALUES (538, '843130826', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843130826', '{adresse}', 'AKTIV', '2010-07-01', 843130827, '2023-09-20 13:20:14.174242', '2023-09-20 13:20:14.174242');


--
-- Data for Name: virksomhet_naringsundergrupper; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_naringsundergrupper VALUES (1, 1, '90.012', NULL, NULL, '2023-09-20 13:20:06.630946', '2023-09-20 13:20:06.630946');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (2, 2, '70.220', '90.012', NULL, '2023-09-20 13:20:06.639143', '2023-09-20 13:20:06.639143');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (3, 3, '90.012', '70.220', NULL, '2023-09-20 13:20:06.649699', '2023-09-20 13:20:06.649699');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (4, 4, '90.012', NULL, NULL, '2023-09-20 13:20:06.661832', '2023-09-20 13:20:06.661832');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (5, 5, '01.120', NULL, NULL, '2023-09-20 13:20:06.697283', '2023-09-20 13:20:06.697283');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (6, 6, '01.120', NULL, NULL, '2023-09-20 13:20:06.70713', '2023-09-20 13:20:06.70713');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (7, 7, '01.120', '90.012', NULL, '2023-09-20 13:20:06.717465', '2023-09-20 13:20:06.717465');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (8, 8, '01.120', NULL, NULL, '2023-09-20 13:20:06.728607', '2023-09-20 13:20:06.728607');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (9, 9, '01.120', '90.012', '70.220', '2023-09-20 13:20:06.740569', '2023-09-20 13:20:06.740569');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (10, 10, '01.120', '90.012', NULL, '2023-09-20 13:20:06.749972', '2023-09-20 13:20:06.749972');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (11, 11, '01.120', '90.012', NULL, '2023-09-20 13:20:06.760846', '2023-09-20 13:20:06.760846');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (12, 12, '01.120', '90.012', '70.220', '2023-09-20 13:20:06.772989', '2023-09-20 13:20:06.772989');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (13, 13, '01.120', '90.012', NULL, '2023-09-20 13:20:06.795411', '2023-09-20 13:20:06.795411');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (14, 14, '01.120', '90.012', '70.220', '2023-09-20 13:20:06.80544', '2023-09-20 13:20:06.80544');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (15, 15, '01.120', NULL, NULL, '2023-09-20 13:20:06.817583', '2023-09-20 13:20:06.817583');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (16, 16, '01.120', NULL, NULL, '2023-09-20 13:20:06.828465', '2023-09-20 13:20:06.828465');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (17, 17, '01.120', NULL, NULL, '2023-09-20 13:20:06.843068', '2023-09-20 13:20:06.843068');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (18, 18, '01.120', '90.012', NULL, '2023-09-20 13:20:06.85378', '2023-09-20 13:20:06.85378');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (19, 19, '01.120', '90.012', NULL, '2023-09-20 13:20:06.863772', '2023-09-20 13:20:06.863772');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (20, 20, '01.120', '90.012', NULL, '2023-09-20 13:20:06.874866', '2023-09-20 13:20:06.874866');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (21, 21, '01.120', '90.012', NULL, '2023-09-20 13:20:06.884715', '2023-09-20 13:20:06.884715');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (22, 22, '01.120', NULL, NULL, '2023-09-20 13:20:06.895992', '2023-09-20 13:20:06.895992');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (23, 23, '01.120', '90.012', NULL, '2023-09-20 13:20:06.906469', '2023-09-20 13:20:06.906469');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (24, 24, '01.120', '90.012', '70.220', '2023-09-20 13:20:06.916377', '2023-09-20 13:20:06.916377');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (25, 25, '01.120', '90.012', NULL, '2023-09-20 13:20:06.927091', '2023-09-20 13:20:06.927091');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (26, 26, '01.120', '90.012', NULL, '2023-09-20 13:20:06.937774', '2023-09-20 13:20:06.937774');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (27, 27, '01.120', NULL, NULL, '2023-09-20 13:20:06.948575', '2023-09-20 13:20:06.948575');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (28, 28, '01.120', '90.012', '70.220', '2023-09-20 13:20:06.960006', '2023-09-20 13:20:06.960006');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (29, 29, '01.120', NULL, NULL, '2023-09-20 13:20:06.968919', '2023-09-20 13:20:06.968919');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (30, 30, '01.120', NULL, NULL, '2023-09-20 13:20:06.978698', '2023-09-20 13:20:06.978698');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (31, 31, '01.120', NULL, NULL, '2023-09-20 13:20:06.988881', '2023-09-20 13:20:06.988881');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (32, 32, '01.120', '90.012', NULL, '2023-09-20 13:20:06.998596', '2023-09-20 13:20:06.998596');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (33, 33, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.009541', '2023-09-20 13:20:07.009541');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (34, 34, '01.120', NULL, NULL, '2023-09-20 13:20:07.018913', '2023-09-20 13:20:07.018913');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (35, 35, '01.120', '90.012', NULL, '2023-09-20 13:20:07.030525', '2023-09-20 13:20:07.030525');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (36, 36, '01.120', '90.012', NULL, '2023-09-20 13:20:07.041772', '2023-09-20 13:20:07.041772');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (37, 37, '01.120', '90.012', NULL, '2023-09-20 13:20:07.053239', '2023-09-20 13:20:07.053239');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (38, 38, '01.120', NULL, NULL, '2023-09-20 13:20:07.065148', '2023-09-20 13:20:07.065148');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (39, 39, '01.120', NULL, NULL, '2023-09-20 13:20:07.077028', '2023-09-20 13:20:07.077028');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (40, 40, '01.120', NULL, NULL, '2023-09-20 13:20:07.089614', '2023-09-20 13:20:07.089614');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (41, 41, '01.120', NULL, NULL, '2023-09-20 13:20:07.10196', '2023-09-20 13:20:07.10196');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (42, 42, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.117716', '2023-09-20 13:20:07.117716');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (43, 43, '01.120', NULL, NULL, '2023-09-20 13:20:07.128733', '2023-09-20 13:20:07.128733');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (44, 44, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.141757', '2023-09-20 13:20:07.141757');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (45, 45, '01.120', NULL, NULL, '2023-09-20 13:20:07.15182', '2023-09-20 13:20:07.15182');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (46, 46, '01.120', NULL, NULL, '2023-09-20 13:20:07.170073', '2023-09-20 13:20:07.170073');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (47, 47, '01.120', '90.012', NULL, '2023-09-20 13:20:07.177461', '2023-09-20 13:20:07.177461');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (48, 48, '01.120', NULL, NULL, '2023-09-20 13:20:07.190681', '2023-09-20 13:20:07.190681');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (49, 49, '01.120', NULL, NULL, '2023-09-20 13:20:07.201274', '2023-09-20 13:20:07.201274');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (50, 50, '01.120', NULL, NULL, '2023-09-20 13:20:07.21413', '2023-09-20 13:20:07.21413');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (51, 51, '01.120', NULL, NULL, '2023-09-20 13:20:07.226824', '2023-09-20 13:20:07.226824');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (52, 52, '01.120', '90.012', NULL, '2023-09-20 13:20:07.239584', '2023-09-20 13:20:07.239584');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (53, 53, '01.120', '90.012', NULL, '2023-09-20 13:20:07.252137', '2023-09-20 13:20:07.252137');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (54, 54, '01.120', NULL, NULL, '2023-09-20 13:20:07.265906', '2023-09-20 13:20:07.265906');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (55, 55, '01.120', NULL, NULL, '2023-09-20 13:20:07.276684', '2023-09-20 13:20:07.276684');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (56, 56, '01.120', '90.012', NULL, '2023-09-20 13:20:07.291104', '2023-09-20 13:20:07.291104');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (57, 57, '01.120', NULL, NULL, '2023-09-20 13:20:07.301812', '2023-09-20 13:20:07.301812');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (58, 58, '01.120', NULL, NULL, '2023-09-20 13:20:07.314359', '2023-09-20 13:20:07.314359');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (59, 59, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.326747', '2023-09-20 13:20:07.326747');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (60, 60, '01.120', NULL, NULL, '2023-09-20 13:20:07.336254', '2023-09-20 13:20:07.336254');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (61, 61, '01.120', NULL, NULL, '2023-09-20 13:20:07.347946', '2023-09-20 13:20:07.347946');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (62, 62, '01.120', NULL, NULL, '2023-09-20 13:20:07.362483', '2023-09-20 13:20:07.362483');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (63, 63, '01.120', NULL, NULL, '2023-09-20 13:20:07.37543', '2023-09-20 13:20:07.37543');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (64, 64, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.388601', '2023-09-20 13:20:07.388601');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (65, 65, '01.120', '90.012', NULL, '2023-09-20 13:20:07.398657', '2023-09-20 13:20:07.398657');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (66, 66, '01.120', NULL, NULL, '2023-09-20 13:20:07.410187', '2023-09-20 13:20:07.410187');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (67, 67, '01.120', '90.012', NULL, '2023-09-20 13:20:07.422967', '2023-09-20 13:20:07.422967');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (68, 68, '01.120', NULL, NULL, '2023-09-20 13:20:07.43284', '2023-09-20 13:20:07.43284');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (69, 69, '01.120', NULL, NULL, '2023-09-20 13:20:07.446566', '2023-09-20 13:20:07.446566');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (70, 70, '01.120', NULL, NULL, '2023-09-20 13:20:07.462094', '2023-09-20 13:20:07.462094');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (71, 71, '01.120', '90.012', NULL, '2023-09-20 13:20:07.471908', '2023-09-20 13:20:07.471908');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (72, 72, '01.120', '90.012', NULL, '2023-09-20 13:20:07.482438', '2023-09-20 13:20:07.482438');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (73, 73, '01.120', NULL, NULL, '2023-09-20 13:20:07.49765', '2023-09-20 13:20:07.49765');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (74, 74, '01.120', NULL, NULL, '2023-09-20 13:20:07.508348', '2023-09-20 13:20:07.508348');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (75, 75, '01.120', NULL, NULL, '2023-09-20 13:20:07.520357', '2023-09-20 13:20:07.520357');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (76, 76, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.530686', '2023-09-20 13:20:07.530686');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (77, 77, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.544644', '2023-09-20 13:20:07.544644');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (78, 78, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.559968', '2023-09-20 13:20:07.559968');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (79, 79, '01.120', NULL, NULL, '2023-09-20 13:20:07.57245', '2023-09-20 13:20:07.57245');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (80, 80, '01.120', '90.012', NULL, '2023-09-20 13:20:07.583403', '2023-09-20 13:20:07.583403');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (81, 81, '01.120', '90.012', NULL, '2023-09-20 13:20:07.595651', '2023-09-20 13:20:07.595651');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (82, 82, '01.120', '90.012', NULL, '2023-09-20 13:20:07.607419', '2023-09-20 13:20:07.607419');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (83, 83, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.617503', '2023-09-20 13:20:07.617503');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (84, 84, '01.120', '90.012', NULL, '2023-09-20 13:20:07.632677', '2023-09-20 13:20:07.632677');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (85, 85, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.646039', '2023-09-20 13:20:07.646039');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (86, 86, '01.120', '90.012', NULL, '2023-09-20 13:20:07.656084', '2023-09-20 13:20:07.656084');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (87, 87, '01.120', NULL, NULL, '2023-09-20 13:20:07.66809', '2023-09-20 13:20:07.66809');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (88, 88, '01.120', NULL, NULL, '2023-09-20 13:20:07.680318', '2023-09-20 13:20:07.680318');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (89, 89, '01.120', '90.012', NULL, '2023-09-20 13:20:07.692551', '2023-09-20 13:20:07.692551');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (90, 90, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.703599', '2023-09-20 13:20:07.703599');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (91, 91, '01.120', '90.012', NULL, '2023-09-20 13:20:07.715222', '2023-09-20 13:20:07.715222');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (92, 92, '01.120', NULL, NULL, '2023-09-20 13:20:07.727676', '2023-09-20 13:20:07.727676');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (93, 93, '01.120', '90.012', NULL, '2023-09-20 13:20:07.739371', '2023-09-20 13:20:07.739371');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (94, 94, '01.120', '90.012', NULL, '2023-09-20 13:20:07.750236', '2023-09-20 13:20:07.750236');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (95, 95, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.762075', '2023-09-20 13:20:07.762075');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (96, 96, '01.120', NULL, NULL, '2023-09-20 13:20:07.773626', '2023-09-20 13:20:07.773626');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (97, 97, '01.120', NULL, NULL, '2023-09-20 13:20:07.787796', '2023-09-20 13:20:07.787796');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (98, 98, '01.120', NULL, NULL, '2023-09-20 13:20:07.800144', '2023-09-20 13:20:07.800144');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (99, 99, '01.120', '90.012', NULL, '2023-09-20 13:20:07.810041', '2023-09-20 13:20:07.810041');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (100, 100, '01.120', NULL, NULL, '2023-09-20 13:20:07.820279', '2023-09-20 13:20:07.820279');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (101, 101, '01.120', '90.012', NULL, '2023-09-20 13:20:07.831575', '2023-09-20 13:20:07.831575');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (102, 102, '01.120', '90.012', NULL, '2023-09-20 13:20:07.842668', '2023-09-20 13:20:07.842668');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (103, 103, '01.120', '90.012', NULL, '2023-09-20 13:20:07.854057', '2023-09-20 13:20:07.854057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (104, 104, '01.120', NULL, NULL, '2023-09-20 13:20:07.865929', '2023-09-20 13:20:07.865929');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (105, 105, '01.120', NULL, NULL, '2023-09-20 13:20:07.877914', '2023-09-20 13:20:07.877914');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (106, 106, '01.120', NULL, NULL, '2023-09-20 13:20:07.889236', '2023-09-20 13:20:07.889236');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (107, 107, '01.120', '90.012', '70.220', '2023-09-20 13:20:07.899346', '2023-09-20 13:20:07.899346');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (108, 108, '01.120', NULL, NULL, '2023-09-20 13:20:07.910317', '2023-09-20 13:20:07.910317');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (109, 109, '01.120', NULL, NULL, '2023-09-20 13:20:07.92128', '2023-09-20 13:20:07.92128');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (110, 110, '01.120', NULL, NULL, '2023-09-20 13:20:07.934608', '2023-09-20 13:20:07.934608');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (111, 111, '01.120', NULL, NULL, '2023-09-20 13:20:07.946444', '2023-09-20 13:20:07.946444');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (112, 112, '01.120', '90.012', NULL, '2023-09-20 13:20:07.958961', '2023-09-20 13:20:07.958961');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (113, 113, '01.120', NULL, NULL, '2023-09-20 13:20:07.971038', '2023-09-20 13:20:07.971038');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (114, 114, '01.120', '90.012', NULL, '2023-09-20 13:20:07.98254', '2023-09-20 13:20:07.98254');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (115, 115, '01.120', NULL, NULL, '2023-09-20 13:20:07.993188', '2023-09-20 13:20:07.993188');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (116, 116, '01.120', '90.012', NULL, '2023-09-20 13:20:08.005178', '2023-09-20 13:20:08.005178');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (117, 117, '01.120', NULL, NULL, '2023-09-20 13:20:08.015779', '2023-09-20 13:20:08.015779');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (118, 118, '01.120', NULL, NULL, '2023-09-20 13:20:08.026529', '2023-09-20 13:20:08.026529');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (119, 119, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.038547', '2023-09-20 13:20:08.038547');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (120, 120, '01.120', NULL, NULL, '2023-09-20 13:20:08.049477', '2023-09-20 13:20:08.049477');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (121, 121, '01.120', '90.012', NULL, '2023-09-20 13:20:08.060851', '2023-09-20 13:20:08.060851');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (122, 122, '01.120', NULL, NULL, '2023-09-20 13:20:08.073259', '2023-09-20 13:20:08.073259');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (123, 123, '01.120', '90.012', NULL, '2023-09-20 13:20:08.085517', '2023-09-20 13:20:08.085517');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (124, 124, '01.120', '90.012', NULL, '2023-09-20 13:20:08.097302', '2023-09-20 13:20:08.097302');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (125, 125, '01.120', NULL, NULL, '2023-09-20 13:20:08.114129', '2023-09-20 13:20:08.114129');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (126, 126, '01.120', '90.012', NULL, '2023-09-20 13:20:08.124433', '2023-09-20 13:20:08.124433');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (127, 127, '01.120', NULL, NULL, '2023-09-20 13:20:08.145268', '2023-09-20 13:20:08.145268');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (128, 128, '01.120', '90.012', NULL, '2023-09-20 13:20:08.159329', '2023-09-20 13:20:08.159329');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (129, 129, '01.120', NULL, NULL, '2023-09-20 13:20:08.172011', '2023-09-20 13:20:08.172011');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (130, 130, '01.120', '90.012', NULL, '2023-09-20 13:20:08.183635', '2023-09-20 13:20:08.183635');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (131, 131, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.195567', '2023-09-20 13:20:08.195567');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (132, 132, '01.120', NULL, NULL, '2023-09-20 13:20:08.20773', '2023-09-20 13:20:08.20773');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (133, 133, '01.120', '90.012', NULL, '2023-09-20 13:20:08.219361', '2023-09-20 13:20:08.219361');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (134, 134, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.229593', '2023-09-20 13:20:08.229593');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (135, 135, '01.120', NULL, NULL, '2023-09-20 13:20:08.241269', '2023-09-20 13:20:08.241269');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (136, 136, '01.120', NULL, NULL, '2023-09-20 13:20:08.252062', '2023-09-20 13:20:08.252062');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (137, 137, '01.120', NULL, NULL, '2023-09-20 13:20:08.26357', '2023-09-20 13:20:08.26357');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (138, 138, '01.120', NULL, NULL, '2023-09-20 13:20:08.274337', '2023-09-20 13:20:08.274337');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (139, 139, '01.120', NULL, NULL, '2023-09-20 13:20:08.285662', '2023-09-20 13:20:08.285662');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (140, 140, '01.120', '90.012', NULL, '2023-09-20 13:20:08.296764', '2023-09-20 13:20:08.296764');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (141, 141, '01.120', NULL, NULL, '2023-09-20 13:20:08.309128', '2023-09-20 13:20:08.309128');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (142, 142, '01.120', NULL, NULL, '2023-09-20 13:20:08.319769', '2023-09-20 13:20:08.319769');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (143, 143, '01.120', NULL, NULL, '2023-09-20 13:20:08.331003', '2023-09-20 13:20:08.331003');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (144, 144, '01.120', '90.012', NULL, '2023-09-20 13:20:08.343205', '2023-09-20 13:20:08.343205');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (145, 145, '01.120', '90.012', NULL, '2023-09-20 13:20:08.35426', '2023-09-20 13:20:08.35426');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (146, 146, '01.120', '90.012', NULL, '2023-09-20 13:20:08.364845', '2023-09-20 13:20:08.364845');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (147, 147, '01.120', '90.012', NULL, '2023-09-20 13:20:08.376952', '2023-09-20 13:20:08.376952');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (148, 148, '01.120', '90.012', NULL, '2023-09-20 13:20:08.387213', '2023-09-20 13:20:08.387213');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (149, 149, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.398027', '2023-09-20 13:20:08.398027');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (150, 150, '01.120', NULL, NULL, '2023-09-20 13:20:08.409202', '2023-09-20 13:20:08.409202');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (151, 151, '01.120', '90.012', NULL, '2023-09-20 13:20:08.419588', '2023-09-20 13:20:08.419588');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (152, 152, '01.120', NULL, NULL, '2023-09-20 13:20:08.430639', '2023-09-20 13:20:08.430639');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (153, 153, '01.120', NULL, NULL, '2023-09-20 13:20:08.441844', '2023-09-20 13:20:08.441844');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (154, 154, '01.120', NULL, NULL, '2023-09-20 13:20:08.451482', '2023-09-20 13:20:08.451482');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (155, 155, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.461968', '2023-09-20 13:20:08.461968');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (156, 156, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.473819', '2023-09-20 13:20:08.473819');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (157, 157, '01.120', '90.012', NULL, '2023-09-20 13:20:08.484505', '2023-09-20 13:20:08.484505');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (158, 158, '01.120', NULL, NULL, '2023-09-20 13:20:08.49553', '2023-09-20 13:20:08.49553');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (159, 159, '01.120', '90.012', NULL, '2023-09-20 13:20:08.505648', '2023-09-20 13:20:08.505648');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (160, 160, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.514554', '2023-09-20 13:20:08.514554');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (161, 161, '01.120', NULL, NULL, '2023-09-20 13:20:08.525274', '2023-09-20 13:20:08.525274');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (162, 162, '01.120', NULL, NULL, '2023-09-20 13:20:08.535489', '2023-09-20 13:20:08.535489');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (163, 163, '01.120', '90.012', NULL, '2023-09-20 13:20:08.546043', '2023-09-20 13:20:08.546043');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (164, 164, '01.120', '90.012', NULL, '2023-09-20 13:20:08.554875', '2023-09-20 13:20:08.554875');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (165, 165, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.564188', '2023-09-20 13:20:08.564188');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (166, 166, '01.120', '90.012', NULL, '2023-09-20 13:20:08.574259', '2023-09-20 13:20:08.574259');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (167, 167, '01.120', '90.012', NULL, '2023-09-20 13:20:08.583593', '2023-09-20 13:20:08.583593');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (168, 168, '01.120', NULL, NULL, '2023-09-20 13:20:08.592954', '2023-09-20 13:20:08.592954');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (169, 169, '01.120', '90.012', NULL, '2023-09-20 13:20:08.602522', '2023-09-20 13:20:08.602522');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (170, 170, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.612391', '2023-09-20 13:20:08.612391');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (171, 171, '01.120', NULL, NULL, '2023-09-20 13:20:08.622005', '2023-09-20 13:20:08.622005');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (172, 172, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.632262', '2023-09-20 13:20:08.632262');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (173, 173, '01.120', '90.012', NULL, '2023-09-20 13:20:08.641417', '2023-09-20 13:20:08.641417');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (174, 174, '01.120', '90.012', NULL, '2023-09-20 13:20:08.650478', '2023-09-20 13:20:08.650478');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (175, 175, '01.120', NULL, NULL, '2023-09-20 13:20:08.659501', '2023-09-20 13:20:08.659501');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (176, 176, '01.120', '90.012', NULL, '2023-09-20 13:20:08.669792', '2023-09-20 13:20:08.669792');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (177, 177, '01.120', '90.012', NULL, '2023-09-20 13:20:08.680396', '2023-09-20 13:20:08.680396');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (178, 178, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.689616', '2023-09-20 13:20:08.689616');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (179, 179, '01.120', NULL, NULL, '2023-09-20 13:20:08.699424', '2023-09-20 13:20:08.699424');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (180, 180, '01.120', NULL, NULL, '2023-09-20 13:20:08.710093', '2023-09-20 13:20:08.710093');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (181, 181, '01.120', NULL, NULL, '2023-09-20 13:20:08.719928', '2023-09-20 13:20:08.719928');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (182, 182, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.72987', '2023-09-20 13:20:08.72987');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (183, 183, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.740002', '2023-09-20 13:20:08.740002');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (184, 184, '01.120', NULL, NULL, '2023-09-20 13:20:08.749594', '2023-09-20 13:20:08.749594');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (185, 185, '01.120', '90.012', '70.220', '2023-09-20 13:20:08.759279', '2023-09-20 13:20:08.759279');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (186, 186, '01.120', NULL, NULL, '2023-09-20 13:20:08.768811', '2023-09-20 13:20:08.768811');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (187, 187, '01.120', NULL, NULL, '2023-09-20 13:20:08.778712', '2023-09-20 13:20:08.778712');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (188, 188, '01.120', '90.012', NULL, '2023-09-20 13:20:08.788727', '2023-09-20 13:20:08.788727');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (189, 189, '01.120', NULL, NULL, '2023-09-20 13:20:08.798545', '2023-09-20 13:20:08.798545');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (190, 190, '01.120', '90.012', NULL, '2023-09-20 13:20:08.808723', '2023-09-20 13:20:08.808723');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (191, 191, '01.120', '90.012', NULL, '2023-09-20 13:20:08.818864', '2023-09-20 13:20:08.818864');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (192, 192, '01.120', '90.012', NULL, '2023-09-20 13:20:08.828944', '2023-09-20 13:20:08.828944');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (193, 193, '01.120', NULL, NULL, '2023-09-20 13:20:08.837393', '2023-09-20 13:20:08.837393');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (194, 194, '01.120', NULL, NULL, '2023-09-20 13:20:08.847572', '2023-09-20 13:20:08.847572');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (195, 195, '01.120', '90.012', NULL, '2023-09-20 13:20:08.858101', '2023-09-20 13:20:08.858101');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (196, 196, '01.120', NULL, NULL, '2023-09-20 13:20:08.867606', '2023-09-20 13:20:08.867606');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (197, 197, '01.120', '90.012', NULL, '2023-09-20 13:20:08.877439', '2023-09-20 13:20:08.877439');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (198, 198, '01.120', NULL, NULL, '2023-09-20 13:20:08.887894', '2023-09-20 13:20:08.887894');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (199, 199, '01.120', '90.012', NULL, '2023-09-20 13:20:08.898451', '2023-09-20 13:20:08.898451');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (200, 200, '01.120', NULL, NULL, '2023-09-20 13:20:08.908203', '2023-09-20 13:20:08.908203');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (201, 201, '01.120', '90.012', NULL, '2023-09-20 13:20:08.917504', '2023-09-20 13:20:08.917504');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (202, 202, '01.120', '90.012', NULL, '2023-09-20 13:20:08.927272', '2023-09-20 13:20:08.927272');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (203, 203, '01.120', NULL, NULL, '2023-09-20 13:20:08.936545', '2023-09-20 13:20:08.936545');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (204, 204, '01.120', NULL, NULL, '2023-09-20 13:20:08.946532', '2023-09-20 13:20:08.946532');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (205, 205, '01.120', '90.012', NULL, '2023-09-20 13:20:08.956949', '2023-09-20 13:20:08.956949');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (206, 206, '01.120', NULL, NULL, '2023-09-20 13:20:08.966627', '2023-09-20 13:20:08.966627');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (207, 207, '01.120', '90.012', NULL, '2023-09-20 13:20:08.976491', '2023-09-20 13:20:08.976491');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (208, 208, '01.120', '90.012', NULL, '2023-09-20 13:20:08.985819', '2023-09-20 13:20:08.985819');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (209, 209, '01.120', '90.012', NULL, '2023-09-20 13:20:08.99609', '2023-09-20 13:20:08.99609');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (210, 210, '01.120', '90.012', NULL, '2023-09-20 13:20:09.0054', '2023-09-20 13:20:09.0054');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (211, 211, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.015493', '2023-09-20 13:20:09.015493');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (212, 212, '01.120', NULL, NULL, '2023-09-20 13:20:09.023831', '2023-09-20 13:20:09.023831');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (213, 213, '01.120', NULL, NULL, '2023-09-20 13:20:09.033312', '2023-09-20 13:20:09.033312');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (214, 214, '01.120', NULL, NULL, '2023-09-20 13:20:09.041874', '2023-09-20 13:20:09.041874');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (215, 215, '01.120', '90.012', NULL, '2023-09-20 13:20:09.051897', '2023-09-20 13:20:09.051897');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (216, 216, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.06129', '2023-09-20 13:20:09.06129');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (217, 217, '01.120', NULL, NULL, '2023-09-20 13:20:09.070714', '2023-09-20 13:20:09.070714');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (218, 218, '01.120', '90.012', NULL, '2023-09-20 13:20:09.080214', '2023-09-20 13:20:09.080214');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (219, 219, '01.120', NULL, NULL, '2023-09-20 13:20:09.090409', '2023-09-20 13:20:09.090409');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (220, 220, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.100538', '2023-09-20 13:20:09.100538');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (221, 221, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.111129', '2023-09-20 13:20:09.111129');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (222, 222, '01.120', NULL, NULL, '2023-09-20 13:20:09.120571', '2023-09-20 13:20:09.120571');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (223, 223, '01.120', NULL, NULL, '2023-09-20 13:20:09.130833', '2023-09-20 13:20:09.130833');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (224, 224, '01.120', NULL, NULL, '2023-09-20 13:20:09.141026', '2023-09-20 13:20:09.141026');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (225, 225, '01.120', '90.012', NULL, '2023-09-20 13:20:09.14966', '2023-09-20 13:20:09.14966');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (226, 226, '01.120', NULL, NULL, '2023-09-20 13:20:09.158721', '2023-09-20 13:20:09.158721');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (227, 227, '01.120', '90.012', NULL, '2023-09-20 13:20:09.169977', '2023-09-20 13:20:09.169977');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (228, 228, '01.120', '90.012', NULL, '2023-09-20 13:20:09.179795', '2023-09-20 13:20:09.179795');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (229, 229, '01.120', '90.012', NULL, '2023-09-20 13:20:09.189926', '2023-09-20 13:20:09.189926');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (230, 230, '01.120', NULL, NULL, '2023-09-20 13:20:09.199263', '2023-09-20 13:20:09.199263');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (231, 231, '01.120', NULL, NULL, '2023-09-20 13:20:09.208948', '2023-09-20 13:20:09.208948');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (232, 232, '01.120', '90.012', NULL, '2023-09-20 13:20:09.21771', '2023-09-20 13:20:09.21771');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (233, 233, '01.120', NULL, NULL, '2023-09-20 13:20:09.227793', '2023-09-20 13:20:09.227793');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (234, 234, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.236807', '2023-09-20 13:20:09.236807');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (235, 235, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.246902', '2023-09-20 13:20:09.246902');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (236, 236, '01.120', NULL, NULL, '2023-09-20 13:20:09.256677', '2023-09-20 13:20:09.256677');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (237, 237, '01.120', NULL, NULL, '2023-09-20 13:20:09.265999', '2023-09-20 13:20:09.265999');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (238, 238, '01.120', NULL, NULL, '2023-09-20 13:20:09.275984', '2023-09-20 13:20:09.275984');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (239, 239, '01.120', NULL, NULL, '2023-09-20 13:20:09.284875', '2023-09-20 13:20:09.284875');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (240, 240, '01.120', '90.012', NULL, '2023-09-20 13:20:09.295292', '2023-09-20 13:20:09.295292');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (241, 241, '01.120', '90.012', NULL, '2023-09-20 13:20:09.30489', '2023-09-20 13:20:09.30489');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (242, 242, '01.120', '90.012', NULL, '2023-09-20 13:20:09.315086', '2023-09-20 13:20:09.315086');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (243, 243, '01.120', '90.012', NULL, '2023-09-20 13:20:09.324889', '2023-09-20 13:20:09.324889');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (244, 244, '01.120', '90.012', NULL, '2023-09-20 13:20:09.334707', '2023-09-20 13:20:09.334707');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (245, 245, '01.120', '90.012', NULL, '2023-09-20 13:20:09.345044', '2023-09-20 13:20:09.345044');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (246, 246, '01.120', '90.012', NULL, '2023-09-20 13:20:09.355077', '2023-09-20 13:20:09.355077');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (247, 247, '01.120', NULL, NULL, '2023-09-20 13:20:09.36478', '2023-09-20 13:20:09.36478');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (248, 248, '01.120', NULL, NULL, '2023-09-20 13:20:09.37455', '2023-09-20 13:20:09.37455');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (249, 249, '01.120', NULL, NULL, '2023-09-20 13:20:09.38351', '2023-09-20 13:20:09.38351');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (250, 250, '01.120', '90.012', NULL, '2023-09-20 13:20:09.394329', '2023-09-20 13:20:09.394329');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (251, 251, '01.120', NULL, NULL, '2023-09-20 13:20:09.403245', '2023-09-20 13:20:09.403245');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (252, 252, '01.120', NULL, NULL, '2023-09-20 13:20:09.412615', '2023-09-20 13:20:09.412615');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (253, 253, '01.120', NULL, NULL, '2023-09-20 13:20:09.422256', '2023-09-20 13:20:09.422256');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (254, 254, '01.120', NULL, NULL, '2023-09-20 13:20:09.432432', '2023-09-20 13:20:09.432432');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (255, 255, '01.120', '90.012', NULL, '2023-09-20 13:20:09.442655', '2023-09-20 13:20:09.442655');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (256, 256, '01.120', NULL, NULL, '2023-09-20 13:20:09.451212', '2023-09-20 13:20:09.451212');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (257, 257, '01.120', NULL, NULL, '2023-09-20 13:20:09.46011', '2023-09-20 13:20:09.46011');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (258, 258, '01.120', '90.012', NULL, '2023-09-20 13:20:09.469088', '2023-09-20 13:20:09.469088');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (259, 259, '01.120', NULL, NULL, '2023-09-20 13:20:09.477182', '2023-09-20 13:20:09.477182');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (260, 260, '01.120', '90.012', NULL, '2023-09-20 13:20:09.486846', '2023-09-20 13:20:09.486846');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (261, 261, '01.120', '90.012', NULL, '2023-09-20 13:20:09.49734', '2023-09-20 13:20:09.49734');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (262, 262, '01.120', NULL, NULL, '2023-09-20 13:20:09.506279', '2023-09-20 13:20:09.506279');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (263, 263, '01.120', NULL, NULL, '2023-09-20 13:20:09.515096', '2023-09-20 13:20:09.515096');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (264, 264, '01.120', '90.012', NULL, '2023-09-20 13:20:09.525673', '2023-09-20 13:20:09.525673');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (265, 265, '01.120', NULL, NULL, '2023-09-20 13:20:09.535145', '2023-09-20 13:20:09.535145');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (266, 266, '01.120', NULL, NULL, '2023-09-20 13:20:09.544673', '2023-09-20 13:20:09.544673');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (267, 267, '01.120', NULL, NULL, '2023-09-20 13:20:09.554827', '2023-09-20 13:20:09.554827');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (268, 268, '01.120', NULL, NULL, '2023-09-20 13:20:09.565227', '2023-09-20 13:20:09.565227');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (269, 269, '01.120', NULL, NULL, '2023-09-20 13:20:09.574919', '2023-09-20 13:20:09.574919');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (270, 270, '01.120', NULL, NULL, '2023-09-20 13:20:09.584474', '2023-09-20 13:20:09.584474');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (271, 271, '01.120', NULL, NULL, '2023-09-20 13:20:09.5938', '2023-09-20 13:20:09.5938');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (272, 272, '01.120', '90.012', NULL, '2023-09-20 13:20:09.602952', '2023-09-20 13:20:09.602952');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (273, 273, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.612596', '2023-09-20 13:20:09.612596');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (274, 274, '01.120', '90.012', NULL, '2023-09-20 13:20:09.622196', '2023-09-20 13:20:09.622196');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (275, 275, '01.120', NULL, NULL, '2023-09-20 13:20:09.631227', '2023-09-20 13:20:09.631227');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (276, 276, '01.120', '90.012', NULL, '2023-09-20 13:20:09.640756', '2023-09-20 13:20:09.640756');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (277, 277, '01.120', NULL, NULL, '2023-09-20 13:20:09.649608', '2023-09-20 13:20:09.649608');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (278, 278, '01.120', '90.012', NULL, '2023-09-20 13:20:09.65944', '2023-09-20 13:20:09.65944');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (279, 279, '01.120', NULL, NULL, '2023-09-20 13:20:09.669741', '2023-09-20 13:20:09.669741');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (280, 280, '01.120', '90.012', NULL, '2023-09-20 13:20:09.679616', '2023-09-20 13:20:09.679616');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (281, 281, '01.120', NULL, NULL, '2023-09-20 13:20:09.687615', '2023-09-20 13:20:09.687615');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (282, 282, '01.120', NULL, NULL, '2023-09-20 13:20:09.697679', '2023-09-20 13:20:09.697679');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (283, 283, '01.120', NULL, NULL, '2023-09-20 13:20:09.708341', '2023-09-20 13:20:09.708341');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (284, 284, '01.120', NULL, NULL, '2023-09-20 13:20:09.718516', '2023-09-20 13:20:09.718516');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (285, 285, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.728878', '2023-09-20 13:20:09.728878');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (286, 286, '01.120', '90.012', NULL, '2023-09-20 13:20:09.738718', '2023-09-20 13:20:09.738718');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (287, 287, '01.120', '90.012', NULL, '2023-09-20 13:20:09.748871', '2023-09-20 13:20:09.748871');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (288, 288, '01.120', NULL, NULL, '2023-09-20 13:20:09.758525', '2023-09-20 13:20:09.758525');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (289, 289, '01.120', NULL, NULL, '2023-09-20 13:20:09.768097', '2023-09-20 13:20:09.768097');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (290, 290, '01.120', NULL, NULL, '2023-09-20 13:20:09.777581', '2023-09-20 13:20:09.777581');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (291, 291, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.78755', '2023-09-20 13:20:09.78755');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (292, 292, '01.120', NULL, NULL, '2023-09-20 13:20:09.797294', '2023-09-20 13:20:09.797294');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (293, 293, '01.120', '90.012', NULL, '2023-09-20 13:20:09.806188', '2023-09-20 13:20:09.806188');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (294, 294, '01.120', NULL, NULL, '2023-09-20 13:20:09.815372', '2023-09-20 13:20:09.815372');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (295, 295, '01.120', NULL, NULL, '2023-09-20 13:20:09.824937', '2023-09-20 13:20:09.824937');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (296, 296, '01.120', '90.012', NULL, '2023-09-20 13:20:09.834579', '2023-09-20 13:20:09.834579');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (297, 297, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.844641', '2023-09-20 13:20:09.844641');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (298, 298, '01.120', '90.012', NULL, '2023-09-20 13:20:09.854435', '2023-09-20 13:20:09.854435');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (299, 299, '01.120', NULL, NULL, '2023-09-20 13:20:09.864257', '2023-09-20 13:20:09.864257');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (300, 300, '01.120', NULL, NULL, '2023-09-20 13:20:09.872677', '2023-09-20 13:20:09.872677');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (301, 301, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.882582', '2023-09-20 13:20:09.882582');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (302, 302, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.891693', '2023-09-20 13:20:09.891693');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (303, 303, '01.120', NULL, NULL, '2023-09-20 13:20:09.901398', '2023-09-20 13:20:09.901398');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (304, 304, '01.120', '90.012', NULL, '2023-09-20 13:20:09.910794', '2023-09-20 13:20:09.910794');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (305, 305, '01.120', '90.012', NULL, '2023-09-20 13:20:09.920953', '2023-09-20 13:20:09.920953');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (306, 306, '01.120', '90.012', NULL, '2023-09-20 13:20:09.932816', '2023-09-20 13:20:09.932816');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (307, 307, '01.120', NULL, NULL, '2023-09-20 13:20:09.942313', '2023-09-20 13:20:09.942313');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (308, 308, '01.120', '90.012', '70.220', '2023-09-20 13:20:09.951692', '2023-09-20 13:20:09.951692');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (309, 309, '01.120', NULL, NULL, '2023-09-20 13:20:09.96162', '2023-09-20 13:20:09.96162');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (310, 310, '01.120', NULL, NULL, '2023-09-20 13:20:09.970672', '2023-09-20 13:20:09.970672');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (311, 311, '01.120', NULL, NULL, '2023-09-20 13:20:09.980683', '2023-09-20 13:20:09.980683');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (312, 312, '01.120', NULL, NULL, '2023-09-20 13:20:09.991085', '2023-09-20 13:20:09.991085');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (313, 313, '01.120', NULL, NULL, '2023-09-20 13:20:09.999648', '2023-09-20 13:20:09.999648');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (314, 314, '01.120', NULL, NULL, '2023-09-20 13:20:10.009038', '2023-09-20 13:20:10.009038');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (315, 315, '01.120', '90.012', NULL, '2023-09-20 13:20:10.018048', '2023-09-20 13:20:10.018048');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (316, 316, '01.120', NULL, NULL, '2023-09-20 13:20:10.027914', '2023-09-20 13:20:10.027914');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (317, 317, '01.120', '90.012', NULL, '2023-09-20 13:20:10.03674', '2023-09-20 13:20:10.03674');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (318, 318, '01.120', NULL, NULL, '2023-09-20 13:20:10.047215', '2023-09-20 13:20:10.047215');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (319, 319, '01.120', '90.012', NULL, '2023-09-20 13:20:10.057071', '2023-09-20 13:20:10.057071');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (320, 320, '01.120', NULL, NULL, '2023-09-20 13:20:10.065199', '2023-09-20 13:20:10.065199');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (321, 321, '01.120', NULL, NULL, '2023-09-20 13:20:10.075313', '2023-09-20 13:20:10.075313');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (322, 322, '01.120', NULL, NULL, '2023-09-20 13:20:10.083727', '2023-09-20 13:20:10.083727');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (323, 323, '01.120', '90.012', NULL, '2023-09-20 13:20:10.093342', '2023-09-20 13:20:10.093342');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (324, 324, '01.120', NULL, NULL, '2023-09-20 13:20:10.102905', '2023-09-20 13:20:10.102905');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (325, 325, '01.120', '90.012', NULL, '2023-09-20 13:20:10.112176', '2023-09-20 13:20:10.112176');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (326, 326, '01.120', NULL, NULL, '2023-09-20 13:20:10.12049', '2023-09-20 13:20:10.12049');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (327, 327, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.130693', '2023-09-20 13:20:10.130693');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (328, 328, '01.120', NULL, NULL, '2023-09-20 13:20:10.141142', '2023-09-20 13:20:10.141142');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (329, 329, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.149755', '2023-09-20 13:20:10.149755');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (330, 330, '01.120', NULL, NULL, '2023-09-20 13:20:10.160254', '2023-09-20 13:20:10.160254');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (331, 331, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.170826', '2023-09-20 13:20:10.170826');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (332, 332, '01.120', '90.012', NULL, '2023-09-20 13:20:10.180847', '2023-09-20 13:20:10.180847');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (333, 333, '01.120', '90.012', NULL, '2023-09-20 13:20:10.190721', '2023-09-20 13:20:10.190721');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (334, 334, '01.120', NULL, NULL, '2023-09-20 13:20:10.199765', '2023-09-20 13:20:10.199765');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (335, 335, '01.120', NULL, NULL, '2023-09-20 13:20:10.209572', '2023-09-20 13:20:10.209572');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (336, 336, '01.120', '90.012', NULL, '2023-09-20 13:20:10.219301', '2023-09-20 13:20:10.219301');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (337, 337, '01.120', '90.012', NULL, '2023-09-20 13:20:10.229165', '2023-09-20 13:20:10.229165');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (338, 338, '01.120', NULL, NULL, '2023-09-20 13:20:10.238154', '2023-09-20 13:20:10.238154');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (339, 339, '01.120', NULL, NULL, '2023-09-20 13:20:10.247588', '2023-09-20 13:20:10.247588');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (340, 340, '01.120', NULL, NULL, '2023-09-20 13:20:10.257089', '2023-09-20 13:20:10.257089');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (341, 341, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.266655', '2023-09-20 13:20:10.266655');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (342, 342, '01.120', NULL, NULL, '2023-09-20 13:20:10.276373', '2023-09-20 13:20:10.276373');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (343, 343, '01.120', '90.012', NULL, '2023-09-20 13:20:10.285815', '2023-09-20 13:20:10.285815');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (344, 344, '01.120', NULL, NULL, '2023-09-20 13:20:10.295563', '2023-09-20 13:20:10.295563');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (345, 345, '01.120', '90.012', NULL, '2023-09-20 13:20:10.305441', '2023-09-20 13:20:10.305441');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (346, 346, '01.120', '90.012', NULL, '2023-09-20 13:20:10.314194', '2023-09-20 13:20:10.314194');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (347, 347, '01.120', NULL, NULL, '2023-09-20 13:20:10.323718', '2023-09-20 13:20:10.323718');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (348, 348, '01.120', NULL, NULL, '2023-09-20 13:20:10.333428', '2023-09-20 13:20:10.333428');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (349, 349, '01.120', '90.012', NULL, '2023-09-20 13:20:10.343473', '2023-09-20 13:20:10.343473');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (350, 350, '01.120', NULL, NULL, '2023-09-20 13:20:10.35223', '2023-09-20 13:20:10.35223');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (351, 351, '01.120', '90.012', NULL, '2023-09-20 13:20:10.362743', '2023-09-20 13:20:10.362743');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (352, 352, '01.120', '90.012', NULL, '2023-09-20 13:20:10.372763', '2023-09-20 13:20:10.372763');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (353, 353, '01.120', NULL, NULL, '2023-09-20 13:20:10.382915', '2023-09-20 13:20:10.382915');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (354, 354, '01.120', NULL, NULL, '2023-09-20 13:20:10.392964', '2023-09-20 13:20:10.392964');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (355, 355, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.402585', '2023-09-20 13:20:10.402585');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (356, 356, '01.120', '90.012', NULL, '2023-09-20 13:20:10.412283', '2023-09-20 13:20:10.412283');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (357, 357, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.420737', '2023-09-20 13:20:10.420737');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (358, 358, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.430452', '2023-09-20 13:20:10.430452');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (359, 359, '01.120', '90.012', NULL, '2023-09-20 13:20:10.439165', '2023-09-20 13:20:10.439165');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (360, 360, '01.120', NULL, NULL, '2023-09-20 13:20:10.448794', '2023-09-20 13:20:10.448794');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (361, 361, '01.120', NULL, NULL, '2023-09-20 13:20:10.458148', '2023-09-20 13:20:10.458148');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (362, 362, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.46775', '2023-09-20 13:20:10.46775');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (363, 363, '01.120', NULL, NULL, '2023-09-20 13:20:10.476997', '2023-09-20 13:20:10.476997');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (364, 364, '01.120', '90.012', NULL, '2023-09-20 13:20:10.486714', '2023-09-20 13:20:10.486714');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (365, 365, '01.120', NULL, NULL, '2023-09-20 13:20:10.495502', '2023-09-20 13:20:10.495502');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (366, 366, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.505486', '2023-09-20 13:20:10.505486');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (367, 367, '01.120', NULL, NULL, '2023-09-20 13:20:10.515905', '2023-09-20 13:20:10.515905');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (368, 368, '01.120', NULL, NULL, '2023-09-20 13:20:10.52455', '2023-09-20 13:20:10.52455');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (369, 369, '01.120', '90.012', NULL, '2023-09-20 13:20:10.534625', '2023-09-20 13:20:10.534625');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (370, 370, '01.120', NULL, NULL, '2023-09-20 13:20:10.544991', '2023-09-20 13:20:10.544991');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (371, 371, '01.120', '90.012', NULL, '2023-09-20 13:20:10.554859', '2023-09-20 13:20:10.554859');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (372, 372, '01.120', '90.012', NULL, '2023-09-20 13:20:10.564721', '2023-09-20 13:20:10.564721');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (373, 373, '01.120', NULL, NULL, '2023-09-20 13:20:10.57353', '2023-09-20 13:20:10.57353');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (374, 374, '01.120', '90.012', NULL, '2023-09-20 13:20:10.584783', '2023-09-20 13:20:10.584783');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (375, 375, '01.120', '90.012', NULL, '2023-09-20 13:20:10.596263', '2023-09-20 13:20:10.596263');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (376, 376, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.605381', '2023-09-20 13:20:10.605381');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (377, 377, '01.120', NULL, NULL, '2023-09-20 13:20:10.616052', '2023-09-20 13:20:10.616052');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (378, 378, '01.120', '90.012', NULL, '2023-09-20 13:20:10.625905', '2023-09-20 13:20:10.625905');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (379, 379, '01.120', NULL, NULL, '2023-09-20 13:20:10.635533', '2023-09-20 13:20:10.635533');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (380, 380, '01.120', NULL, NULL, '2023-09-20 13:20:10.645938', '2023-09-20 13:20:10.645938');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (381, 381, '01.120', '90.012', NULL, '2023-09-20 13:20:10.654899', '2023-09-20 13:20:10.654899');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (382, 382, '01.120', '90.012', NULL, '2023-09-20 13:20:10.66598', '2023-09-20 13:20:10.66598');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (383, 383, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.674521', '2023-09-20 13:20:10.674521');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (384, 384, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.684063', '2023-09-20 13:20:10.684063');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (385, 385, '01.120', NULL, NULL, '2023-09-20 13:20:10.693074', '2023-09-20 13:20:10.693074');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (386, 386, '01.120', NULL, NULL, '2023-09-20 13:20:10.702301', '2023-09-20 13:20:10.702301');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (387, 387, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.712018', '2023-09-20 13:20:10.712018');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (388, 388, '01.120', NULL, NULL, '2023-09-20 13:20:10.721126', '2023-09-20 13:20:10.721126');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (389, 389, '01.120', '90.012', NULL, '2023-09-20 13:20:10.731171', '2023-09-20 13:20:10.731171');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (390, 390, '01.120', '90.012', NULL, '2023-09-20 13:20:10.741863', '2023-09-20 13:20:10.741863');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (391, 391, '01.120', NULL, NULL, '2023-09-20 13:20:10.752355', '2023-09-20 13:20:10.752355');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (392, 392, '01.120', '90.012', NULL, '2023-09-20 13:20:10.762863', '2023-09-20 13:20:10.762863');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (393, 393, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.773695', '2023-09-20 13:20:10.773695');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (394, 394, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.78467', '2023-09-20 13:20:10.78467');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (395, 395, '01.120', NULL, NULL, '2023-09-20 13:20:10.794481', '2023-09-20 13:20:10.794481');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (396, 396, '01.120', NULL, NULL, '2023-09-20 13:20:10.804377', '2023-09-20 13:20:10.804377');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (397, 397, '01.120', NULL, NULL, '2023-09-20 13:20:10.81484', '2023-09-20 13:20:10.81484');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (398, 398, '01.120', '90.012', NULL, '2023-09-20 13:20:10.825245', '2023-09-20 13:20:10.825245');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (399, 399, '01.120', NULL, NULL, '2023-09-20 13:20:10.835324', '2023-09-20 13:20:10.835324');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (400, 400, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.844995', '2023-09-20 13:20:10.844995');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (401, 401, '01.120', '90.012', NULL, '2023-09-20 13:20:10.853606', '2023-09-20 13:20:10.853606');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (402, 402, '01.120', '90.012', NULL, '2023-09-20 13:20:10.862374', '2023-09-20 13:20:10.862374');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (403, 403, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.872035', '2023-09-20 13:20:10.872035');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (404, 404, '01.120', NULL, NULL, '2023-09-20 13:20:10.881983', '2023-09-20 13:20:10.881983');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (405, 405, '01.120', NULL, NULL, '2023-09-20 13:20:10.891912', '2023-09-20 13:20:10.891912');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (406, 406, '01.120', NULL, NULL, '2023-09-20 13:20:10.902129', '2023-09-20 13:20:10.902129');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (407, 407, '01.120', NULL, NULL, '2023-09-20 13:20:10.913503', '2023-09-20 13:20:10.913503');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (408, 408, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.924466', '2023-09-20 13:20:10.924466');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (409, 409, '01.120', '90.012', '70.220', '2023-09-20 13:20:10.934506', '2023-09-20 13:20:10.934506');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (410, 410, '01.120', NULL, NULL, '2023-09-20 13:20:10.944962', '2023-09-20 13:20:10.944962');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (411, 411, '01.120', NULL, NULL, '2023-09-20 13:20:10.954673', '2023-09-20 13:20:10.954673');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (412, 412, '01.120', NULL, NULL, '2023-09-20 13:20:10.964187', '2023-09-20 13:20:10.964187');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (413, 413, '01.120', NULL, NULL, '2023-09-20 13:20:10.974554', '2023-09-20 13:20:10.974554');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (414, 414, '01.120', '90.012', NULL, '2023-09-20 13:20:10.984057', '2023-09-20 13:20:10.984057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (415, 415, '01.120', NULL, NULL, '2023-09-20 13:20:10.993989', '2023-09-20 13:20:10.993989');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (416, 416, '01.120', NULL, NULL, '2023-09-20 13:20:11.0037', '2023-09-20 13:20:11.0037');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (417, 417, '01.120', '90.012', NULL, '2023-09-20 13:20:11.013429', '2023-09-20 13:20:11.013429');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (418, 418, '01.120', NULL, NULL, '2023-09-20 13:20:11.023294', '2023-09-20 13:20:11.023294');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (419, 419, '01.120', NULL, NULL, '2023-09-20 13:20:11.0331', '2023-09-20 13:20:11.0331');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (420, 420, '01.120', '90.012', NULL, '2023-09-20 13:20:11.043372', '2023-09-20 13:20:11.043372');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (421, 421, '01.120', '90.012', NULL, '2023-09-20 13:20:11.052397', '2023-09-20 13:20:11.052397');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (422, 422, '01.120', NULL, NULL, '2023-09-20 13:20:11.062988', '2023-09-20 13:20:11.062988');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (423, 423, '01.120', NULL, NULL, '2023-09-20 13:20:11.072595', '2023-09-20 13:20:11.072595');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (424, 424, '01.120', NULL, NULL, '2023-09-20 13:20:11.082842', '2023-09-20 13:20:11.082842');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (425, 425, '01.120', '90.012', NULL, '2023-09-20 13:20:11.092469', '2023-09-20 13:20:11.092469');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (426, 426, '01.120', NULL, NULL, '2023-09-20 13:20:11.102005', '2023-09-20 13:20:11.102005');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (427, 427, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.110494', '2023-09-20 13:20:11.110494');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (428, 428, '01.120', '90.012', NULL, '2023-09-20 13:20:11.119696', '2023-09-20 13:20:11.119696');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (429, 429, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.128614', '2023-09-20 13:20:11.128614');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (430, 430, '01.120', '90.012', NULL, '2023-09-20 13:20:11.138208', '2023-09-20 13:20:11.138208');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (431, 431, '01.120', NULL, NULL, '2023-09-20 13:20:11.147506', '2023-09-20 13:20:11.147506');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (432, 432, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.156938', '2023-09-20 13:20:11.156938');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (433, 433, '01.120', NULL, NULL, '2023-09-20 13:20:11.166496', '2023-09-20 13:20:11.166496');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (434, 434, '01.120', '90.012', NULL, '2023-09-20 13:20:11.177443', '2023-09-20 13:20:11.177443');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (435, 435, '01.120', '90.012', NULL, '2023-09-20 13:20:11.188195', '2023-09-20 13:20:11.188195');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (436, 436, '01.120', '90.012', NULL, '2023-09-20 13:20:11.197732', '2023-09-20 13:20:11.197732');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (437, 437, '01.120', '90.012', NULL, '2023-09-20 13:20:11.208022', '2023-09-20 13:20:11.208022');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (438, 438, '01.120', NULL, NULL, '2023-09-20 13:20:11.218767', '2023-09-20 13:20:11.218767');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (439, 439, '01.120', NULL, NULL, '2023-09-20 13:20:11.227188', '2023-09-20 13:20:11.227188');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (440, 440, '01.120', '90.012', NULL, '2023-09-20 13:20:11.235947', '2023-09-20 13:20:11.235947');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (441, 441, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.245442', '2023-09-20 13:20:11.245442');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (442, 442, '01.120', '90.012', NULL, '2023-09-20 13:20:11.254935', '2023-09-20 13:20:11.254935');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (443, 443, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.264004', '2023-09-20 13:20:11.264004');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (444, 444, '01.120', NULL, NULL, '2023-09-20 13:20:11.271933', '2023-09-20 13:20:11.271933');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (445, 445, '01.120', NULL, NULL, '2023-09-20 13:20:11.280764', '2023-09-20 13:20:11.280764');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (446, 446, '01.120', NULL, NULL, '2023-09-20 13:20:11.289783', '2023-09-20 13:20:11.289783');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (447, 447, '01.120', '90.012', NULL, '2023-09-20 13:20:11.298926', '2023-09-20 13:20:11.298926');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (448, 448, '01.120', NULL, NULL, '2023-09-20 13:20:11.307053', '2023-09-20 13:20:11.307053');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (449, 449, '01.120', NULL, NULL, '2023-09-20 13:20:11.315566', '2023-09-20 13:20:11.315566');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (450, 450, '01.120', NULL, NULL, '2023-09-20 13:20:11.323977', '2023-09-20 13:20:11.323977');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (451, 451, '01.120', '90.012', NULL, '2023-09-20 13:20:11.334222', '2023-09-20 13:20:11.334222');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (452, 452, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.344198', '2023-09-20 13:20:11.344198');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (453, 453, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.352585', '2023-09-20 13:20:11.352585');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (454, 454, '01.120', NULL, NULL, '2023-09-20 13:20:11.360556', '2023-09-20 13:20:11.360556');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (455, 455, '01.120', NULL, NULL, '2023-09-20 13:20:11.369515', '2023-09-20 13:20:11.369515');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (456, 456, '01.120', NULL, NULL, '2023-09-20 13:20:11.379094', '2023-09-20 13:20:11.379094');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (457, 457, '01.120', NULL, NULL, '2023-09-20 13:20:11.388729', '2023-09-20 13:20:11.388729');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (458, 458, '01.120', '90.012', NULL, '2023-09-20 13:20:11.39834', '2023-09-20 13:20:11.39834');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (459, 459, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.407088', '2023-09-20 13:20:11.407088');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (460, 460, '01.120', NULL, NULL, '2023-09-20 13:20:11.416221', '2023-09-20 13:20:11.416221');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (461, 461, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.425999', '2023-09-20 13:20:11.425999');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (462, 462, '01.120', '90.012', NULL, '2023-09-20 13:20:11.433771', '2023-09-20 13:20:11.433771');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (463, 463, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.442852', '2023-09-20 13:20:11.442852');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (464, 464, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.451857', '2023-09-20 13:20:11.451857');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (465, 465, '01.120', NULL, NULL, '2023-09-20 13:20:11.460494', '2023-09-20 13:20:11.460494');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (466, 466, '01.120', '90.012', NULL, '2023-09-20 13:20:11.469798', '2023-09-20 13:20:11.469798');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (467, 467, '01.120', '90.012', NULL, '2023-09-20 13:20:11.479359', '2023-09-20 13:20:11.479359');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (468, 468, '01.120', NULL, NULL, '2023-09-20 13:20:11.487046', '2023-09-20 13:20:11.487046');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (469, 469, '01.120', '90.012', NULL, '2023-09-20 13:20:11.496536', '2023-09-20 13:20:11.496536');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (470, 470, '01.120', NULL, NULL, '2023-09-20 13:20:11.505454', '2023-09-20 13:20:11.505454');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (471, 471, '01.120', NULL, NULL, '2023-09-20 13:20:11.515202', '2023-09-20 13:20:11.515202');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (472, 472, '01.120', '90.012', NULL, '2023-09-20 13:20:11.523361', '2023-09-20 13:20:11.523361');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (473, 473, '01.120', '90.012', NULL, '2023-09-20 13:20:11.533302', '2023-09-20 13:20:11.533302');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (474, 474, '01.120', NULL, NULL, '2023-09-20 13:20:11.543053', '2023-09-20 13:20:11.543053');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (475, 475, '01.120', NULL, NULL, '2023-09-20 13:20:11.552756', '2023-09-20 13:20:11.552756');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (476, 476, '01.120', NULL, NULL, '2023-09-20 13:20:11.562532', '2023-09-20 13:20:11.562532');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (477, 477, '01.120', NULL, NULL, '2023-09-20 13:20:11.570704', '2023-09-20 13:20:11.570704');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (478, 478, '01.120', NULL, NULL, '2023-09-20 13:20:11.580728', '2023-09-20 13:20:11.580728');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (479, 479, '01.120', '90.012', NULL, '2023-09-20 13:20:11.590418', '2023-09-20 13:20:11.590418');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (480, 480, '01.120', NULL, NULL, '2023-09-20 13:20:11.600254', '2023-09-20 13:20:11.600254');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (481, 481, '01.120', '90.012', NULL, '2023-09-20 13:20:11.609131', '2023-09-20 13:20:11.609131');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (482, 482, '01.120', NULL, NULL, '2023-09-20 13:20:11.618795', '2023-09-20 13:20:11.618795');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (483, 483, '01.120', NULL, NULL, '2023-09-20 13:20:11.628479', '2023-09-20 13:20:11.628479');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (484, 484, '01.120', '90.012', NULL, '2023-09-20 13:20:11.637499', '2023-09-20 13:20:11.637499');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (485, 485, '01.120', NULL, NULL, '2023-09-20 13:20:11.646159', '2023-09-20 13:20:11.646159');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (486, 486, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.653551', '2023-09-20 13:20:11.653551');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (487, 487, '01.120', NULL, NULL, '2023-09-20 13:20:11.662807', '2023-09-20 13:20:11.662807');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (488, 488, '01.120', NULL, NULL, '2023-09-20 13:20:11.672287', '2023-09-20 13:20:11.672287');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (489, 489, '01.120', NULL, NULL, '2023-09-20 13:20:11.682154', '2023-09-20 13:20:11.682154');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (490, 490, '01.120', '90.012', NULL, '2023-09-20 13:20:11.691413', '2023-09-20 13:20:11.691413');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (491, 491, '01.120', NULL, NULL, '2023-09-20 13:20:11.701133', '2023-09-20 13:20:11.701133');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (492, 492, '01.120', NULL, NULL, '2023-09-20 13:20:11.710073', '2023-09-20 13:20:11.710073');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (493, 493, '01.120', '90.012', NULL, '2023-09-20 13:20:11.71934', '2023-09-20 13:20:11.71934');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (494, 494, '01.120', NULL, NULL, '2023-09-20 13:20:11.728818', '2023-09-20 13:20:11.728818');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (495, 495, '01.120', NULL, NULL, '2023-09-20 13:20:11.737452', '2023-09-20 13:20:11.737452');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (496, 496, '01.120', NULL, NULL, '2023-09-20 13:20:11.746771', '2023-09-20 13:20:11.746771');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (497, 497, '01.120', NULL, NULL, '2023-09-20 13:20:11.756046', '2023-09-20 13:20:11.756046');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (498, 498, '01.120', NULL, NULL, '2023-09-20 13:20:11.766365', '2023-09-20 13:20:11.766365');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (499, 499, '01.120', NULL, NULL, '2023-09-20 13:20:11.776106', '2023-09-20 13:20:11.776106');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (500, 500, '01.120', '90.012', NULL, '2023-09-20 13:20:11.784951', '2023-09-20 13:20:11.784951');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (501, 501, '01.120', '90.012', NULL, '2023-09-20 13:20:11.793562', '2023-09-20 13:20:11.793562');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (502, 502, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.803281', '2023-09-20 13:20:11.803281');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (503, 503, '01.120', NULL, NULL, '2023-09-20 13:20:11.813402', '2023-09-20 13:20:11.813402');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (504, 504, '01.120', NULL, NULL, '2023-09-20 13:20:11.822902', '2023-09-20 13:20:11.822902');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (505, 505, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.832961', '2023-09-20 13:20:11.832961');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (506, 506, '01.120', NULL, NULL, '2023-09-20 13:20:11.842359', '2023-09-20 13:20:11.842359');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (507, 507, '01.120', NULL, NULL, '2023-09-20 13:20:11.85177', '2023-09-20 13:20:11.85177');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (508, 508, '01.120', NULL, NULL, '2023-09-20 13:20:11.86062', '2023-09-20 13:20:11.86062');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (509, 509, '01.120', '90.012', '70.220', '2023-09-20 13:20:11.869766', '2023-09-20 13:20:11.869766');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (510, 510, '01.120', '90.012', NULL, '2023-09-20 13:20:11.880359', '2023-09-20 13:20:11.880359');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (511, 511, '01.120', NULL, NULL, '2023-09-20 13:20:13.005448', '2023-09-20 13:20:13.005448');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (517, 517, '01.120', '90.012', NULL, '2023-09-20 13:20:13.06291', '2023-09-20 13:20:13.06291');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (518, 518, '01.120', NULL, NULL, '2023-09-20 13:20:13.071148', '2023-09-20 13:20:13.071148');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (519, 519, '01.120', '90.012', NULL, '2023-09-20 13:20:13.081974', '2023-09-20 13:20:13.081974');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (520, 520, '01.120', '90.012', '70.220', '2023-09-20 13:20:13.091237', '2023-09-20 13:20:13.091237');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (521, 521, '01.120', '90.012', '70.220', '2023-09-20 13:20:13.100816', '2023-09-20 13:20:13.100816');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (522, 522, '01.120', NULL, NULL, '2023-09-20 13:20:13.108848', '2023-09-20 13:20:13.108848');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (523, 523, '01.120', NULL, NULL, '2023-09-20 13:20:13.117331', '2023-09-20 13:20:13.117331');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (524, 524, '01.120', '90.012', '70.220', '2023-09-20 13:20:13.126648', '2023-09-20 13:20:13.126648');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (525, 525, '01.120', '90.012', NULL, '2023-09-20 13:20:13.135198', '2023-09-20 13:20:13.135198');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (526, 526, '01.120', NULL, NULL, '2023-09-20 13:20:13.144925', '2023-09-20 13:20:13.144925');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (512, 512, '01.120', NULL, NULL, '2023-09-20 13:20:14.147778', '2023-09-20 13:20:13.014816');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (513, 513, '01.120', '90.012', NULL, '2023-09-20 13:20:14.152844', '2023-09-20 13:20:13.024215');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (514, 514, '01.120', '90.012', '70.220', '2023-09-20 13:20:14.153401', '2023-09-20 13:20:13.03419');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (515, 515, '01.120', NULL, NULL, '2023-09-20 13:20:14.153666', '2023-09-20 13:20:13.043734');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (516, 516, '01.120', '90.012', NULL, '2023-09-20 13:20:14.153946', '2023-09-20 13:20:13.053377');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (527, 527, '01.120', '01.110', '70.220', '2023-09-20 13:20:14.154312', '2023-09-20 13:20:13.153407');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (534, 534, '01.120', NULL, NULL, '2023-09-20 13:20:14.159331', '2023-09-20 13:20:14.159331');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (535, 535, '01.120', NULL, NULL, '2023-09-20 13:20:14.173111', '2023-09-20 13:20:14.173111');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (536, 536, '01.120', '90.012', NULL, '2023-09-20 13:20:14.173573', '2023-09-20 13:20:14.173573');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (537, 537, '01.120', NULL, NULL, '2023-09-20 13:20:14.173902', '2023-09-20 13:20:14.173902');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (538, 538, '01.120', '90.012', NULL, '2023-09-20 13:20:14.174448', '2023-09-20 13:20:14.174448');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.487899');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.494503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '555555555', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.494503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (6, '835690072', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.494503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '851259006', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.494503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '891657310', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.498569');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '890069516', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.501492');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '818227880', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.501492');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (15, '887929660', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.501492');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (16, '833098223', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.501492');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (17, '810132798', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.5049');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (18, '865287159', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.507527');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (19, '812325861', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.507527');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (20, '854678052', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.507527');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (21, '826529622', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.507527');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (22, '896593666', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.511163');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '898415442', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.511163');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '847120809', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.518174');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (25, '830931807', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.518174');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '812705354', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.518174');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (27, '876999418', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.518174');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '883094378', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.521744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (29, '826578249', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.521744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '821779748', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.521744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (31, '898304073', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.521744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '806055367', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.521744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '849267670', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.521744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '814067491', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.521744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '827223911', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.521744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '852060664', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.526005');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '828472924', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.526005');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '802034315', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.526005');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '821364109', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.526005');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '840899793', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.529557');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '835831981', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.529557');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '834110433', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.529557');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '871024289', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.532911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '825209846', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.532911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '881202253', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.532911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '812103300', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.532911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '826806454', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.536263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '836563069', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.536263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '883569645', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.536263');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '864282766', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.539136');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '853470204', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.539136');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '892154043', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.539136');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '884553531', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.539136');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '837702175', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.542207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '848135730', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.542207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '843069529', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.542207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '841202354', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.542207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '800661351', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.545491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '852377976', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.545491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '821899473', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.545491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '848304798', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.545491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '827048656', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.5495');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '825165311', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.5495');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '889921082', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.5495');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '834786168', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.554876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '889648932', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.554876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '846081284', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.554876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '899521020', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.554876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '897984578', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.558164');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '815452764', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.558164');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '845306307', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.558164');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '862266403', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.558164');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '859743159', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.558164');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '836953790', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.558164');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '809615855', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.56239');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '882106339', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.56239');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '847671651', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.56239');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '838086404', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.565366');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '875335169', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.565366');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '885654025', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.565366');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '847026988', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.565366');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '816378418', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.568612');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '897996553', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.568612');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '800055701', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.571434');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '814989456', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.571434');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '813772256', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.571434');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '897580139', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.571434');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '857663926', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.574538');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '820181951', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.574538');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '818792472', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.574538');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '849137527', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.577427');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '888437122', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.577427');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '847199028', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.577427');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '802475208', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.580479');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '873799686', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.580479');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '879062037', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.583297');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '814256657', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.583297');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '891092944', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.583297');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '832958392', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.583297');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '824528008', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.586531');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '833648500', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.586531');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '837119021', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.586531');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '859036595', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.589638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '818754298', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.589638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '812704644', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.589638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '819173366', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.592687');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '850862665', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.592687');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '848077518', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.592687');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '878236994', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.592687');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '877412476', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.596078');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '856276748', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.596078');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '831572234', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.596078');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '889067758', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.598978');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '804216935', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.598978');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '806865325', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.598978');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '815297831', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.598978');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '857456187', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.601875');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '853108988', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.601875');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '879916784', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.601875');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '823976938', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.605412');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '853659393', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.605412');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '831217959', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.605412');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '882165409', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.605412');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '815785458', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.608673');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '846634644', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.608673');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '855681292', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.608673');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '830105110', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.611935');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '880754152', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.611935');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '884104027', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.611935');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '841084572', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.611935');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '845226813', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.614976');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '800169782', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.614976');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '829826155', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.614976');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '827151822', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.618272');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '800490092', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.618272');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '814741356', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.621018');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '844621127', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.621018');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '867032125', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.621018');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '821385573', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.624057');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '851245090', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.624057');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '871710199', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.624057');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '893562928', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.624057');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '814580797', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.627611');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '824227622', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.627611');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '822739956', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.627611');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '899082690', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.627611');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '814303355', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.630679');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '817770567', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.630679');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '826919947', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.630679');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '896286002', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.630679');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '816324996', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.633963');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '870202885', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.633963');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '801626988', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.633963');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '835614882', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.637243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '811717230', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.637243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '814085446', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.637243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '840940814', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.640432');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '803138536', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.640432');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '830490901', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.640432');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '871858419', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.64392');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '861589487', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.64392');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '889952963', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.64392');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '874207259', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.647142');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '821677085', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.647142');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '800345488', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.647142');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '871270191', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.649973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '854804194', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.649973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '858484692', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.649973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '808244298', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.649973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '832434824', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.653086');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '868719518', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.653086');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '802326218', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.653086');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '808957122', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.653086');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '803905378', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.65636');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '828096369', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.65636');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '873520346', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.65636');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '890711444', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.65636');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '822749114', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.660093');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '865757268', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.660093');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '841423972', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.660093');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '838241984', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.663305');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '836230691', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.663305');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '882462835', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.663305');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '806009183', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.663305');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '806086437', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.666668');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '874040892', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.666668');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '864804244', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.666668');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '878780302', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.666668');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '855713657', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.670576');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '820690355', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.670576');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '842125759', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.670576');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '881056064', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.67375');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '840478098', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.67375');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '833295256', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.67375');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '837623542', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.67375');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '810026055', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.677084');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '833500107', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.677084');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '825843723', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.677084');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '844557328', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.680354');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '843577057', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.680354');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '867713258', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.680354');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '824884019', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.683206');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '821905784', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.683206');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '848644922', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.683206');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '850035701', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.683206');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '843568000', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.686432');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '805022936', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.686432');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '873536341', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.686432');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '816606992', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.689243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '833828890', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.689243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '829382061', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.689243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '855062916', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.689243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '861013607', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.692216');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '838752844', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.692216');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '871862482', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.692216');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '852249416', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.695617');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '821530057', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.695617');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '877538496', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.695617');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '859955431', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.695617');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '894138918', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.6989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '878866284', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.6989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '885569388', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.6989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '893295490', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.6989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '835640066', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.702174');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '869885794', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.702174');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '829496837', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.702174');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '810778729', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.705269');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '858365705', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.705269');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '835755322', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.705269');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '853552534', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.705269');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '824211301', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.708291');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '835144476', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.708291');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '810672024', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.708291');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '816786037', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.71125');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '806094817', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.71125');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '866639021', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.71125');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '893274716', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.71125');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '848244360', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.714349');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '835895151', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.714349');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '827603549', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.714349');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '874876623', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.717264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '820496671', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.717264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '847391810', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.717264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '886545684', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.717264');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '837545167', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.720374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '865865936', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.720374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '846771706', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.720374');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '889704521', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.723482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '869094041', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.723482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '812609372', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.723482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '832769643', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.723482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '805214502', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.72666');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '854920856', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.72666');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '872231212', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.72666');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '849173757', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.72666');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '880853139', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.730141');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '826530237', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.730141');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '831091213', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.730141');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '881204972', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.733104');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '859080272', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.733104');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '874695359', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.733104');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '880050718', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.736147');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '810571093', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.736147');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '836608565', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.736147');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '883252672', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.739237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '856635490', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.739237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '862713535', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.739237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '851002327', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.739237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '833924226', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.742221');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '895508306', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.742221');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '868914223', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.742221');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '882774535', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.745452');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '815099898', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.745452');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '891870734', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.745452');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '845737922', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.745452');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '818122526', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.748551');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '839472854', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.748551');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '819847541', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.751316');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '895933710', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.751316');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '897679772', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.751316');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '804089308', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.75413');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '856569141', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.75413');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '895205411', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.75413');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '833299978', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.756985');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '829450455', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.756985');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '844925941', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.756985');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '847173183', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.756985');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '869194708', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.760231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '860600885', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.760231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '846166025', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.760231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '850284626', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.763149');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '842045486', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.763149');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '800914575', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.763149');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '878948878', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.765891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '861720398', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.765891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '813406508', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.765891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '883254689', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.765891');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '813082125', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.76897');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '805981764', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.76897');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '822539424', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.76897');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '864608813', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.772096');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '814671042', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.772096');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '805298977', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.772096');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '806503523', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.775787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '813090036', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.775787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '825232538', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.775787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '896717340', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.775787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '867730555', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.779132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '860709886', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.779132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '826144732', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.779132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '855380684', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.779132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '802409008', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.782154');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '846073756', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.782154');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '832339971', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.782154');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '812642972', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.782154');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '890359561', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.78511');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '823269861', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.78511');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '871247901', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.78511');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '820322919', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.78511');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '830223615', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.788491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '848901065', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.788491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '858618364', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.788491');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '846046929', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.791626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '810907776', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.791626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '828839903', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.791626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '853938553', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.791626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '824825569', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.794887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '879703311', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.794887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '857535758', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.794887');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '886348164', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.798024');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '816619122', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.798024');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '898232963', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.798024');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '853154335', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.801228');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '802281305', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.801228');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '873891689', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.801228');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '859936907', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.801228');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '885511157', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.804431');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '810915087', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.804431');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '813557180', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.804431');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '848628023', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.804431');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '805980144', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.807407');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '838450728', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.807407');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '899304828', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.807407');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '813906933', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.810604');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '876070192', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.810604');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '824131068', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.810604');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '861754913', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.810604');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '827715003', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.813846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '834715468', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.813846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '868943348', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.813846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '842913833', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.813846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '894993206', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.817069');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '801129590', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.817069');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '899994755', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.817069');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '860859451', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.820456');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '859246854', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.820456');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '892123638', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.820456');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '818264002', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.820456');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '890405244', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.826541');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '812894112', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.826541');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '814808060', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.826541');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '897037401', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.829994');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '851305604', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.829994');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '891720600', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.829994');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '872816596', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.829994');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '882181144', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.829994');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '820199495', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.829994');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '824807396', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.833211');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '866863678', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.833211');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '877779639', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.833211');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '864447069', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.836482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '885784250', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.836482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '862689086', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.836482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '877580718', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.836482');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '829517871', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.839984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '891687765', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.839984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '844574378', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.839984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '869521283', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.843528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '873364248', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.843528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '882696545', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.843528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '851855465', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.843528');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '886467616', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.846872');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '863969848', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.846872');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '818058331', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.846872');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '823612750', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.850068');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '858372645', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.850068');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '878838998', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.850068');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '809603600', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.853711');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '811456573', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.853711');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '876241838', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.853711');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '823349197', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.853711');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '802065158', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.85721');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '888535415', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.85721');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '865263765', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.85721');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '872799429', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.85721');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '883091871', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.860628');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '813071138', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.860628');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '814396800', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.860628');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '880948108', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.863497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '875685681', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.863497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '825623598', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.863497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '899020077', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.863497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '834963803', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.866481');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '893219391', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.866481');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '886989131', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.869244');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '800414105', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.869244');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '800776209', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.869244');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '870889685', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.869244');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '857471550', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.872281');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '801971876', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.872281');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '887833300', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.872281');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '884466337', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.875739');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '822487729', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.875739');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '875804067', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.875739');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '871908613', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.875739');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '880023337', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.879174');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '820589754', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.879174');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '890506842', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.879174');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '890222780', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.882322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '806520934', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.882322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '820427752', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.882322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '854038331', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.882322');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '881460629', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.885544');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '807833245', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.885544');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '858347671', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.885544');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '845518266', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.885544');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '846889775', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.888652');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '807839893', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.888652');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '871664285', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.888652');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '888742907', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.891538');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '849737517', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.891538');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '859483557', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.891538');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '800181497', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.891538');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '881651167', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.894964');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '815418627', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.894964');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '832002465', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.897808');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '817157884', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.897808');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '859963954', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.897808');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '828257776', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.897808');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '814916395', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.902073');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '830331208', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.902073');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '888695203', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.902073');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '876502363', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.907006');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '827890157', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.907006');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '838001870', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.907006');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '825152796', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.910953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '869762191', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.910953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '833822203', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.910953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '828948946', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.910953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '817186434', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.914246');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '840659024', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.914246');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '846453027', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.914246');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '804300620', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.914246');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '808292440', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.917179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '879023146', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.917179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '861390542', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.917179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '803387738', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.917179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '803844864', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.920271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '864725756', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.920271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '883139685', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.920271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '867282851', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.923026');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '811689225', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.923026');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '809582812', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.923026');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '839305987', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.926008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '864192376', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.926008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '852148023', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.926008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '841398189', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.926008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '805383943', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.929622');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '848882011', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.929622');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '838704760', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.929622');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '802798289', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.93254');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '817998975', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.93254');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '812235712', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.93254');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '874242317', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.935751');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '830334365', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.935751');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '813876916', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.935751');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '856861246', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.938572');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '825253279', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.938572');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '862232820', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.941207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '829955165', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.941207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '892129974', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.944207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '837180015', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.944207');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '844238330', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.947257');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '876653097', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.947257');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '886290642', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.947257');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '892588971', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.949901');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '873788685', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.949901');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '848177872', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.949901');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '842951610', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.953199');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '887524559', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.953199');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '898606269', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.953199');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '882700408', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.956023');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '804675096', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.956023');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '833137928', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.956023');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '847143733', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.963072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '880270128', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.963072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '876908783', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.963072');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '847816292', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.966388');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '800454934', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.966388');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '875580850', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.966388');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '872253338', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.966388');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '849867639', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.966388');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '854107024', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.966388');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '878251627', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.966388');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '898116069', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.970555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '846090567', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.970555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '864592196', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.970555');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '855303240', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.97346');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '897230637', 'VIRKSOMHET', '9', '2023-09-20 13:20:12.97346');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '899928561', 'VIRKSOMHET', '2', '2023-09-20 13:20:12.97346');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '830072613', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.97346');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '821059938', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.97346');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '846729601', 'VIRKSOMHET', '1', '2023-09-20 13:20:12.976862');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '800795308', 'VIRKSOMHET', '3', '2023-09-20 13:20:12.976862');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '885895732', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.207143');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '888926367', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.210057');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '858343080', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.212896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '892377219', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.212896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '870010381', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.215866');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '893430686', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.215866');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '828247932', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.215866');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '843668858', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.21875');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '810824719', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.21875');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '876496878', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.222089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '874998757', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.222089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '895211720', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.222089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '837329833', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.225026');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '872199612', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.225026');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '857424051', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.228155');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '829793291', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.228155');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '865238543', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.228155');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '899416996', 'VIRKSOMHET', '1', '2023-09-20 13:20:13.231149');


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

SELECT pg_catalog.setval('public.sykefravar_statistikk_kategori_siste_4_kvartal_id_seq', 88, true);


--
-- Name: sykefravar_statistikk_land_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_land_id_seq', 1, false);


--
-- Name: sykefravar_statistikk_naring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_naring_id_seq', 88, true);


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
-- Name: naringsundergrupper_per_bransje naringsundergrupper_per_bransje_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.naringsundergrupper_per_bransje
    ADD CONSTRAINT naringsundergrupper_per_bransje_pkey PRIMARY KEY (naringsundergruppe);


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
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal sykefravar_statistikk_kategor_kategori_kode_publisert_kvart_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_kategori_siste_4_kvartal
    ADD CONSTRAINT sykefravar_statistikk_kategor_kategori_kode_publisert_kvart_key UNIQUE (kategori, kode, publisert_kvartal, publisert_arstall);


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
-- Name: sykefravar_statistikk_virksomhet_siste_4_kvartal sykefravar_statistikk_virksom_orgnr_publisert_kvartal_publi_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_virksomhet_siste_4_kvartal
    ADD CONSTRAINT sykefravar_statistikk_virksom_orgnr_publisert_kvartal_publi_key UNIQUE (orgnr, publisert_kvartal, publisert_arstall);


--
-- Name: sykefravar_statistikk_virksomhet sykefravar_statistikk_virksomhet_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.sykefravar_statistikk_virksomhet
    ADD CONSTRAINT sykefravar_statistikk_virksomhet_pkey PRIMARY KEY (id);


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
-- Name: idx_bransje_naringsundergrupper_per_bransje; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_bransje_naringsundergrupper_per_bransje ON public.naringsundergrupper_per_bransje USING btree (bransje);


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
-- Name: TABLE naringsundergrupper_per_bransje; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.naringsundergrupper_per_bransje TO cloudsqliamuser;


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

