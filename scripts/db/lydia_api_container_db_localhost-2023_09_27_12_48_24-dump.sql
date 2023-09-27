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
DROP MATERIALIZED VIEW IF EXISTS public.virksomhetsstatistikk_for_prioritering;
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
-- Name: virksomhetsstatistikk_for_prioritering; Type: MATERIALIZED VIEW; Schema: public; Owner: test
--

CREATE MATERIALIZED VIEW public.virksomhetsstatistikk_for_prioritering AS
 SELECT virksomhet.orgnr,
    virksomhet.navn,
    virksomhet.kommunenummer,
    virksomhet_statistikk_metadata.sektor,
    vn.naringsundergruppe1,
    vn.naringsundergruppe2,
    vn.naringsundergruppe3,
    statistikk_siste_kvartal.arstall,
    statistikk_siste_kvartal.kvartal,
    statistikk_siste_kvartal.antall_personer AS antall_personer_siste_kvartal,
    statistikk.tapte_dagsverk,
    statistikk.mulige_dagsverk,
    statistikk.prosent,
    statistikk.maskert,
    statistikk.sist_endret AS statistikk_sist_endret,
    bransje.kode AS bransje_kode,
    bransje.prosent AS bransje_prosent,
    naring.kode AS naring_kode,
    naring.prosent AS naring_prosent
   FROM (((((((public.sykefravar_statistikk_virksomhet statistikk_siste_kvartal
     JOIN public.virksomhet USING (orgnr))
     JOIN public.sykefravar_statistikk_virksomhet_siste_4_kvartal statistikk ON ((((statistikk_siste_kvartal.orgnr)::text = (statistikk.orgnr)::text) AND (statistikk_siste_kvartal.kvartal = statistikk.publisert_kvartal) AND (statistikk_siste_kvartal.arstall = statistikk.publisert_arstall))))
     JOIN public.virksomhet_naringsundergrupper vn ON ((virksomhet.id = vn.virksomhet)))
     LEFT JOIN public.virksomhet_statistikk_metadata ON (((virksomhet.orgnr)::text = (virksomhet_statistikk_metadata.orgnr)::text)))
     LEFT JOIN public.naringsundergrupper_per_bransje bransjeprogram ON (((vn.naringsundergruppe1)::text = (bransjeprogram.naringsundergruppe)::text)))
     LEFT JOIN public.sykefravar_statistikk_kategori_siste_4_kvartal bransje ON ((((bransjeprogram.bransje)::text = (bransje.kode)::text) AND ((bransje.kategori)::text = 'BRANSJE'::text) AND (bransje.publisert_kvartal = statistikk_siste_kvartal.kvartal) AND (bransje.publisert_arstall = statistikk_siste_kvartal.arstall))))
     JOIN public.sykefravar_statistikk_kategori_siste_4_kvartal naring ON (((substr((vn.naringsundergruppe1)::text, 1, 2) = (naring.kode)::text) AND ((naring.kategori)::text = 'NÆRING'::text) AND (naring.publisert_kvartal = statistikk_siste_kvartal.kvartal) AND (naring.publisert_arstall = statistikk_siste_kvartal.arstall))))
  WHERE ((statistikk_siste_kvartal.arstall = ( SELECT siste_publiseringsinfo.gjeldende_arstall
           FROM public.siste_publiseringsinfo
          ORDER BY siste_publiseringsinfo.gjeldende_arstall DESC, siste_publiseringsinfo.gjeldende_kvartal DESC
         LIMIT 1)) AND (statistikk_siste_kvartal.kvartal = ( SELECT siste_publiseringsinfo.gjeldende_kvartal
           FROM public.siste_publiseringsinfo
          ORDER BY siste_publiseringsinfo.gjeldende_arstall DESC, siste_publiseringsinfo.gjeldende_kvartal DESC
         LIMIT 1)) AND ((virksomhet.status)::text = 'AKTIV'::text))
  WITH NO DATA;


ALTER TABLE public.virksomhetsstatistikk_for_prioritering OWNER TO test;

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

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', '2022/V1__init.sql', 1782034767, 'test', '2023-09-27 12:47:29.73057', 10, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', '2022/V2__create_virksomhet_adresse.sql', -64248919, 'test', '2023-09-27 12:47:29.756537', 12, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', '2022/V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2023-09-27 12:47:29.784487', 4, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', '2022/V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2023-09-27 12:47:29.798351', 5, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', '2022/V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2023-09-27 12:47:29.814003', 5, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', '2022/V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2023-09-27 12:47:29.832528', 4, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', '2022/V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2023-09-27 12:47:29.846384', 7, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', '2022/V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2023-09-27 12:47:29.862649', 4, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', '2022/V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2023-09-27 12:47:29.875445', 8, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', '2022/V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2023-09-27 12:47:29.895425', 4, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', '2022/V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2023-09-27 12:47:29.907446', 3, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', '2022/V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2023-09-27 12:47:29.918499', 3, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', '2022/V13__ia_prosess.sql', -1755516749, 'test', '2023-09-27 12:47:29.92971', 4, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', '2022/V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2023-09-27 12:47:29.942875', 6, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', '2022/V15__endre_saknummer.sql', -1379621340, 'test', '2023-09-27 12:47:29.956643', 3, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', '2022/V16__ia_sak_hendelse.sql', 586872662, 'test', '2023-09-27 12:47:29.967938', 6, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', '2022/V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2023-09-27 12:47:29.983315', 3, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', '2022/V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2023-09-27 12:47:29.994017', 5, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', '2022/V19__legg_til_begrunnelser.sql', 779259005, 'test', '2023-09-27 12:47:30.006675', 4, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', '2022/V20__legg_til_flere_indekser.sql', -843857404, 'test', '2023-09-27 12:47:30.019506', 6, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', '2022/V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2023-09-27 12:47:30.033941', 3, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', '2022/V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2023-09-27 12:47:30.044815', 4, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', '2022/V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2023-09-27 12:47:30.056877', 4, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', '2022/V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2023-09-27 12:47:30.069217', 7, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', '2022/V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2023-09-27 12:47:30.084979', 11, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', '2022/V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2023-09-27 12:47:30.103923', 4, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', '2022/V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2023-09-27 12:47:30.115876', 3, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', '2022/V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2023-09-27 12:47:30.12621', 2, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', '2022/V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2023-09-27 12:47:30.134858', 3, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', '2022/V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2023-09-27 12:47:30.145116', 3, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', '2022/V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2023-09-27 12:47:30.157375', 4, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', '2022/V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2023-09-27 12:47:30.168692', 4, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', '2022/V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2023-09-27 12:47:30.179769', 3, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', '2022/V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2023-09-27 12:47:30.189155', 5, true);
INSERT INTO public.flyway_schema_history VALUES (35, '35', 'drop sykefravar statistikk grunnlag', 'SQL', '2022/V35__drop_sykefravar_statistikk_grunnlag.sql', 461103825, 'test', '2023-09-27 12:47:30.20015', 4, true);
INSERT INTO public.flyway_schema_history VALUES (36, '36', 'registrere bistand', 'SQL', '2023/V36__registrere_bistand.sql', -1365283904, 'test', '2023-09-27 12:47:30.210692', 9, true);
INSERT INTO public.flyway_schema_history VALUES (37, '37', 'fullfoert dato leveranse', 'SQL', '2023/V37__fullfoert_dato_leveranse.sql', 1621470787, 'test', '2023-09-27 12:47:30.227441', 3, true);
INSERT INTO public.flyway_schema_history VALUES (38, '38', 'oppdatere moduler', 'SQL', '2023/V38__oppdatere_moduler.sql', -246234034, 'test', '2023-09-27 12:47:30.237958', 4, true);
INSERT INTO public.flyway_schema_history VALUES (39, '39', 'rette iatjeneste på modul', 'SQL', '2023/V39__rette_iatjeneste_på_modul.sql', -1034067650, 'test', '2023-09-27 12:47:30.25014', 3, true);
INSERT INTO public.flyway_schema_history VALUES (40, '40', 'legg til rolle ia sak hendelse', 'SQL', '2023/V40__legg_til_rolle_ia_sak_hendelse.sql', -82283870, 'test', '2023-09-27 12:47:30.260841', 3, true);
INSERT INTO public.flyway_schema_history VALUES (41, '41', 'legg til rolle ia sak leveranse', 'SQL', '2023/V41__legg_til_rolle_ia_sak_leveranse.sql', -2029318456, 'test', '2023-09-27 12:47:30.271293', 3, true);
INSERT INTO public.flyway_schema_history VALUES (42, '42', 'legg til deaktivert', 'SQL', '2023/V42__legg_til_deaktivert.sql', 1170357332, 'test', '2023-09-27 12:47:30.281032', 4, true);
INSERT INTO public.flyway_schema_history VALUES (43, '43', 'siste publiseringsinfo tabell', 'SQL', '2023/V43__siste_publiseringsinfo_tabell.sql', -1555520829, 'test', '2023-09-27 12:47:30.292756', 5, true);
INSERT INTO public.flyway_schema_history VALUES (44, '44', 'hendelse nav enhet', 'SQL', '2023/V44__hendelse_nav_enhet.sql', -1118774222, 'test', '2023-09-27 12:47:30.306161', 4, true);
INSERT INTO public.flyway_schema_history VALUES (45, '45', 'oppdatere siste publiseringsinfo', 'SQL', '2023/V45__oppdatere_siste_publiseringsinfo.sql', -1919960111, 'test', '2023-09-27 12:47:30.319027', 3, true);
INSERT INTO public.flyway_schema_history VALUES (46, '46', 'populer siste publiseringsdato', 'SQL', '2023/V46__populer_siste_publiseringsdato.sql', 21300723, 'test', '2023-09-27 12:47:30.330099', 6, true);
INSERT INTO public.flyway_schema_history VALUES (47, '47', 'virksomhet naringsundergrupper tabell', 'SQL', '2023/V47__virksomhet_naringsundergrupper_tabell.sql', 581614507, 'test', '2023-09-27 12:47:30.343982', 4, true);
INSERT INTO public.flyway_schema_history VALUES (48, '48', 'endre oppdateringsdato', 'SQL', '2023/V48__endre_oppdateringsdato.sql', 855334580, 'test', '2023-09-27 12:47:30.356794', 4, true);
INSERT INTO public.flyway_schema_history VALUES (49, '49', 'sykefravar statistikk bransje tabell', 'SQL', '2023/V49__sykefravar_statistikk_bransje_tabell.sql', 1439525146, 'test', '2023-09-27 12:47:30.368195', 5, true);
INSERT INTO public.flyway_schema_history VALUES (50, '50', 'endre kode lengde siste 4 kvartal', 'SQL', '2023/V50__endre_kode_lengde_siste_4_kvartal.sql', 218855534, 'test', '2023-09-27 12:47:30.381269', 3, true);
INSERT INTO public.flyway_schema_history VALUES (51, '51', 'endre navn fra naeringskode til naringsundergruppe', 'SQL', '2023/V51__endre_navn_fra_naeringskode_til_naringsundergruppe.sql', 498551672, 'test', '2023-09-27 12:47:30.390469', 4, true);
INSERT INTO public.flyway_schema_history VALUES (52, '52', 'slett virksomhet naring tabell', 'SQL', '2023/V52__slett_virksomhet_naring_tabell.sql', 1210783708, 'test', '2023-09-27 12:47:30.401861', 5, true);
INSERT INTO public.flyway_schema_history VALUES (53, '53', 'oppdatere siste publiseringsinfo Q2 2023', 'SQL', '2023/V53__oppdatere_siste_publiseringsinfo_Q2_2023.sql', -100876903, 'test', '2023-09-27 12:47:30.414976', 3, true);
INSERT INTO public.flyway_schema_history VALUES (54, '54', 'naringsundergrupper per bransje tabell', 'SQL', '2023/V54__naringsundergrupper_per_bransje_tabell.sql', -885609844, 'test', '2023-09-27 12:47:30.426194', 39, true);
INSERT INTO public.flyway_schema_history VALUES (55, '55', 'legg til opprettet tidspunkt iasak leveranse', 'SQL', '2023/V55__legg_til_opprettet_tidspunkt_iasak_leveranse.sql', -1334142016, 'test', '2023-09-27 12:47:30.474958', 3, true);
INSERT INTO public.flyway_schema_history VALUES (56, '56', 'legg til endret statistikk tabeller', 'SQL', '2023/V56__legg_til_endret_statistikk_tabeller.sql', 1995700472, 'test', '2023-09-27 12:47:30.486307', 6, true);
INSERT INTO public.flyway_schema_history VALUES (57, '57', 'legg til publiseringskvartal', 'SQL', '2023/V57__legg_til_publiseringskvartal.sql', -1125206576, 'test', '2023-09-27 12:47:30.50106', 8, true);
INSERT INTO public.flyway_schema_history VALUES (58, '58', 'legg til materialized statistikk view', 'SQL', '2023/V58__legg_til_materialized_statistikk_view.sql', -31127815, 'test', '2023-09-27 12:47:30.517477', 8, true);
INSERT INTO public.flyway_schema_history VALUES (59, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -337313167, 'test', '2023-09-27 12:47:30.533684', 5, true);
INSERT INTO public.flyway_schema_history VALUES (60, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 1017393928, 'test', '2023-09-27 12:47:38.923918', 8, true);


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

INSERT INTO public.naringsundergrupper_per_bransje VALUES ('88.911', 'BARNEHAGER', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.110', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.120', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.130', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.201', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.202', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.203', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.209', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.310', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.320', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.390', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.411', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.412', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.413', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.420', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.510', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.520', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.610', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.620', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.710', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.720', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.730', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.810', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.820', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.830', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.840', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.850', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.860', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.890', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.910', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.920', 'NÆRINGSMIDDELINDUSTRI', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.101', 'SYKEHUS', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.102', 'SYKEHUS', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.104', 'SYKEHUS', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.105', 'SYKEHUS', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.106', 'SYKEHUS', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.107', 'SYKEHUS', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('87.101', 'SYKEHJEM', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('87.102', 'SYKEHJEM', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.100', 'TRANSPORT', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.311', 'TRANSPORT', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.391', 'TRANSPORT', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.392', 'TRANSPORT', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.101', 'BYGG', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.109', 'BYGG', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.200', 'BYGG', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.110', 'ANLEGG', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.120', 'ANLEGG', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.130', 'ANLEGG', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.210', 'ANLEGG', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.220', 'ANLEGG', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.910', 'ANLEGG', '2023-09-27 12:47:30.431233');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.990', 'ANLEGG', '2023-09-27 12:47:30.431233');


--
-- Data for Name: sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: siste_publiseringsinfo; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.siste_publiseringsinfo VALUES (1, 2022, 4, '2023-03-02 00:00:00', '2023-06-01 00:00:00', '2023-09-27 12:47:30.296214');
INSERT INTO public.siste_publiseringsinfo VALUES (2, 2023, 1, '2023-06-01 00:00:00', '2023-09-07 00:00:00', '2023-09-27 12:47:30.322132');
INSERT INTO public.siste_publiseringsinfo VALUES (3, 2022, 3, '2022-12-01 00:00:00', '2023-03-02 00:00:00', '2023-09-27 12:47:30.333284');
INSERT INTO public.siste_publiseringsinfo VALUES (4, 2022, 2, '2022-09-08 00:00:00', '2022-12-01 00:00:00', '2023-09-27 12:47:30.333284');
INSERT INTO public.siste_publiseringsinfo VALUES (5, 2022, 1, '2022-06-02 00:00:00', '2022-09-08 00:00:00', '2023-09-27 12:47:30.333284');
INSERT INTO public.siste_publiseringsinfo VALUES (6, 2021, 4, '2022-03-03 00:00:00', '2022-06-02 00:00:00', '2023-09-27 12:47:30.333284');
INSERT INTO public.siste_publiseringsinfo VALUES (7, 2021, 3, '2021-12-02 00:00:00', '2022-03-03 00:00:00', '2023-09-27 12:47:30.333284');
INSERT INTO public.siste_publiseringsinfo VALUES (8, 2023, 2, '2023-09-07 00:00:00', '2023-11-30 00:00:00', '2023-09-27 12:47:30.417985');


--
-- Data for Name: sykefravar_statistikk_bransje; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_bransje VALUES (1, 2023, 2, 'BARNEHAGER', 1000, 25000, 250000, 10, false, '2023-09-27 12:47:42.287285', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (2, 2023, 2, 'NÆRINGSMIDDELINDUSTRI', 1000, 25000, 250000, 10, false, '2023-09-27 12:47:42.296839', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (3, 2023, 2, 'SYKEHUS', 1000, 25000, 250000, 10, false, '2023-09-27 12:47:42.304166', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (4, 2023, 2, 'SYKEHJEM', 1000, 25000, 250000, 10, false, '2023-09-27 12:47:42.304166', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (5, 2023, 2, 'TRANSPORT', 1000, 25000, 250000, 10, false, '2023-09-27 12:47:42.304166', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (6, 2023, 2, 'BYGG', 1000, 25000, 250000, 10, false, '2023-09-27 12:47:42.304166', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (7, 2023, 2, 'ANLEGG', 1000, 25000, 250000, 10, false, '2023-09-27 12:47:42.310697', NULL);


--
-- Data for Name: sykefravar_statistikk_kategori_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (1, 'NÆRING', '00', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.039314', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (2, 'NÆRING', '01', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.067082', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (3, 'NÆRING', '02', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.067082', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (4, 'NÆRING', '03', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (5, 'NÆRING', '05', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (6, 'NÆRING', '06', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (7, 'NÆRING', '07', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (8, 'NÆRING', '08', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (9, 'NÆRING', '09', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (10, 'NÆRING', '10', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (11, 'NÆRING', '11', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (12, 'NÆRING', '12', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (13, 'NÆRING', '13', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (14, 'NÆRING', '14', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (15, 'NÆRING', '15', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (16, 'NÆRING', '16', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (17, 'NÆRING', '17', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (18, 'NÆRING', '18', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.081918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (19, 'NÆRING', '19', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.111201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (20, 'NÆRING', '20', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.111201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (21, 'NÆRING', '21', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.111201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (22, 'NÆRING', '22', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.111201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (23, 'NÆRING', '23', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (24, 'NÆRING', '24', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (25, 'NÆRING', '25', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (26, 'NÆRING', '26', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (27, 'NÆRING', '27', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (28, 'NÆRING', '28', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (29, 'NÆRING', '29', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (30, 'NÆRING', '30', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (31, 'NÆRING', '31', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (32, 'NÆRING', '32', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (33, 'NÆRING', '33', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (34, 'NÆRING', '35', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (35, 'NÆRING', '36', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (36, 'NÆRING', '37', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (37, 'NÆRING', '38', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (38, 'NÆRING', '39', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (39, 'NÆRING', '41', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.12594', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (40, 'NÆRING', '42', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.14685', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (41, 'NÆRING', '43', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.14685', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (42, 'NÆRING', '45', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.14685', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (43, 'NÆRING', '46', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.14685', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (44, 'NÆRING', '47', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.167476', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (45, 'NÆRING', '49', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.167476', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (46, 'NÆRING', '50', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.167476', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (47, 'NÆRING', '51', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.167476', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (48, 'NÆRING', '52', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.167476', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (49, 'NÆRING', '53', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.167476', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (50, 'NÆRING', '55', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.189183', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (51, 'NÆRING', '56', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.189183', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (52, 'NÆRING', '58', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.189183', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (53, 'NÆRING', '59', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.189183', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (54, 'NÆRING', '60', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.189183', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (55, 'NÆRING', '61', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.204914', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (56, 'NÆRING', '62', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.204914', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (57, 'NÆRING', '63', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.204914', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (58, 'NÆRING', '64', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.204914', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (59, 'NÆRING', '65', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.204914', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (60, 'NÆRING', '66', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.204914', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (61, 'NÆRING', '68', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.204914', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (62, 'NÆRING', '69', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.204914', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (63, 'NÆRING', '70', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.204914', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (64, 'NÆRING', '71', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.204914', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (65, 'NÆRING', '72', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.204914', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (66, 'NÆRING', '73', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.227759', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (67, 'NÆRING', '74', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.227759', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (68, 'NÆRING', '75', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.227759', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (69, 'NÆRING', '77', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.227759', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (70, 'NÆRING', '78', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.227759', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (71, 'NÆRING', '79', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.227759', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (72, 'NÆRING', '80', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.227759', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (73, 'NÆRING', '81', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.227759', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (74, 'NÆRING', '82', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.227759', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (75, 'NÆRING', '84', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.227759', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (76, 'NÆRING', '85', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.249153', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (77, 'NÆRING', '86', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.249153', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (78, 'NÆRING', '87', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.249153', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (79, 'NÆRING', '88', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.249153', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (80, 'NÆRING', '90', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.249153', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (81, 'NÆRING', '91', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.249153', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (82, 'NÆRING', '92', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.249153', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (83, 'NÆRING', '93', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.265148', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (84, 'NÆRING', '94', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.265148', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (85, 'NÆRING', '95', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.265148', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (86, 'NÆRING', '96', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.265148', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (87, 'NÆRING', '97', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.265148', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (88, 'NÆRING', '99', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.265148', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (89, 'BRANSJE', 'BARNEHAGER', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.285635', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (90, 'BRANSJE', 'NÆRINGSMIDDELINDUSTRI', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.295981', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (91, 'BRANSJE', 'SYKEHUS', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.301637', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (92, 'BRANSJE', 'SYKEHJEM', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.301637', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (93, 'BRANSJE', 'TRANSPORT', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.301637', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (94, 'BRANSJE', 'BYGG', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.301637', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (95, 'BRANSJE', 'ANLEGG', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:42.309981', 2, 2023);


--
-- Data for Name: sykefravar_statistikk_land; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naring VALUES (1, 2023, 2, '00', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.046258', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (2, 2023, 2, '01', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.068984', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (3, 2023, 2, '02', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.068984', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (4, 2023, 2, '03', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (5, 2023, 2, '05', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (6, 2023, 2, '06', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (7, 2023, 2, '07', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (8, 2023, 2, '08', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (9, 2023, 2, '09', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (10, 2023, 2, '10', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (11, 2023, 2, '11', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (12, 2023, 2, '12', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (13, 2023, 2, '13', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (14, 2023, 2, '14', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (15, 2023, 2, '15', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (16, 2023, 2, '16', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (17, 2023, 2, '17', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (18, 2023, 2, '18', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.094926', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (19, 2023, 2, '19', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.113621', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (20, 2023, 2, '20', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.113621', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (21, 2023, 2, '21', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.113621', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (22, 2023, 2, '22', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.113621', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (23, 2023, 2, '23', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (24, 2023, 2, '24', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (25, 2023, 2, '25', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (26, 2023, 2, '26', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (27, 2023, 2, '27', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (28, 2023, 2, '28', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (29, 2023, 2, '29', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (30, 2023, 2, '30', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (31, 2023, 2, '31', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (32, 2023, 2, '32', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (33, 2023, 2, '33', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (34, 2023, 2, '35', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (35, 2023, 2, '36', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (36, 2023, 2, '37', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (37, 2023, 2, '38', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (38, 2023, 2, '39', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (39, 2023, 2, '41', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.130876', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (40, 2023, 2, '42', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.152735', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (41, 2023, 2, '43', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.152735', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (42, 2023, 2, '45', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.152735', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (43, 2023, 2, '46', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.152735', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (44, 2023, 2, '47', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.171989', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (45, 2023, 2, '49', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.171989', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (46, 2023, 2, '50', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.171989', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (47, 2023, 2, '51', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.171989', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (48, 2023, 2, '52', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.171989', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (49, 2023, 2, '53', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.171989', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (50, 2023, 2, '55', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.193732', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (51, 2023, 2, '56', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.193732', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (52, 2023, 2, '58', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.193732', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (53, 2023, 2, '59', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.193732', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (54, 2023, 2, '60', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.193732', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (55, 2023, 2, '61', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.212558', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (56, 2023, 2, '62', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.212558', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (57, 2023, 2, '63', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.212558', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (58, 2023, 2, '64', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.212558', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (59, 2023, 2, '65', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.212558', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (60, 2023, 2, '66', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.212558', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (61, 2023, 2, '68', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.212558', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (62, 2023, 2, '69', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.212558', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (63, 2023, 2, '70', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.212558', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (64, 2023, 2, '71', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.212558', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (65, 2023, 2, '72', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.212558', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (66, 2023, 2, '73', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.232272', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (67, 2023, 2, '74', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.232272', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (68, 2023, 2, '75', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.232272', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (69, 2023, 2, '77', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.232272', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (70, 2023, 2, '78', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.232272', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (71, 2023, 2, '79', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.232272', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (72, 2023, 2, '80', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.232272', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (73, 2023, 2, '81', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.232272', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (74, 2023, 2, '82', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.232272', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (75, 2023, 2, '84', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.232272', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (76, 2023, 2, '85', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.252626', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (77, 2023, 2, '86', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.252626', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (78, 2023, 2, '87', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.252626', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (79, 2023, 2, '88', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.252626', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (80, 2023, 2, '90', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.252626', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (81, 2023, 2, '91', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.252626', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (82, 2023, 2, '92', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.252626', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (83, 2023, 2, '93', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.267895', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (84, 2023, 2, '94', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.267895', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (85, 2023, 2, '95', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.267895', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (86, 2023, 2, '96', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.267895', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (87, 2023, 2, '97', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.267895', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (88, 2023, 2, '99', 1000, 12500, 250000, 5, false, '2023-09-27 12:47:42.267895', NULL);


--
-- Data for Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2023, 2, 6, 935.844389661831, 125, 5, false, '2023-09-27 12:47:43.716323', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2023, 1, 6, 935.844389661831, 125, 3, false, '2023-09-27 12:47:43.72342', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2023, 2, 630, 3128.8572381922, 125, 7, false, '2023-09-27 12:47:43.7297', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2023, 1, 630, 3128.8572381922, 125, 7, false, '2023-09-27 12:47:43.742875', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '555555555', 2023, 2, 662, 314.357493717785, 125, 2, false, '2023-09-27 12:47:43.742875', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '811182048', 2023, 2, 232, 7655.33290395221, 125, 6, false, '2023-09-27 12:47:43.742875', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '811182048', 2023, 1, 232, 7655.33290395221, 125, 6, false, '2023-09-27 12:47:43.751165', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '840722400', 2023, 2, 42, 492.093716541479, 125, 6, false, '2023-09-27 12:47:43.751165', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '840722400', 2023, 1, 42, 492.093716541479, 125, 6, false, '2023-09-27 12:47:43.759272', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '850055501', 2023, 2, 42, 2042.60715723842, 125, 6, false, '2023-09-27 12:47:43.759272', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '850055501', 2023, 1, 42, 2042.60715723842, 125, 6, false, '2023-09-27 12:47:43.759272', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '849969854', 2023, 2, 744, 3748.26800242683, 125, 5, false, '2023-09-27 12:47:43.759272', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '849969854', 2023, 1, 744, 3748.26800242683, 125, 16, false, '2023-09-27 12:47:43.759272', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '314159265', 2023, 2, 792, 1000000, 125, 9, false, '2023-09-27 12:47:43.769305', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '314159265', 2023, 1, 792, 1000000, 125, 1, false, '2023-09-27 12:47:43.769305', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '314159265', 2022, 4, 792, 1000000, 125, 18, false, '2023-09-27 12:47:43.776706', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '314159265', 2022, 3, 792, 1000000, 125, 17, false, '2023-09-27 12:47:43.776706', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '314159265', 2022, 2, 792, 1000000, 125, 8, false, '2023-09-27 12:47:43.776706', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '314159265', 2022, 1, 792, 1000000, 125, 10, false, '2023-09-27 12:47:43.776706', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '314159265', 2021, 4, 792, 1000000, 125, 15, false, '2023-09-27 12:47:43.783741', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '314159265', 2021, 3, 792, 1000000, 125, 3, false, '2023-09-27 12:47:43.783741', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '314159265', 2021, 2, 792, 1000000, 125, 12, false, '2023-09-27 12:47:43.788528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '314159265', 2021, 1, 792, 1000000, 125, 1, false, '2023-09-27 12:47:43.788528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '314159265', 2020, 4, 792, 1000000, 125, 2, false, '2023-09-27 12:47:43.788528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '314159265', 2020, 3, 792, 1000000, 125, 12, false, '2023-09-27 12:47:43.793733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '314159265', 2020, 2, 792, 1000000, 125, 14, false, '2023-09-27 12:47:43.793733', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '314159265', 2020, 1, 792, 1000000, 125, 8, false, '2023-09-27 12:47:43.800084', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '314159265', 2019, 4, 792, 1000000, 125, 18, false, '2023-09-27 12:47:43.800084', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '314159265', 2019, 3, 792, 1000000, 125, 7, false, '2023-09-27 12:47:43.800084', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '314159265', 2019, 2, 792, 1000000, 125, 17, false, '2023-09-27 12:47:43.807479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '314159265', 2019, 1, 792, 1000000, 125, 16, false, '2023-09-27 12:47:43.807479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '314159265', 2018, 4, 792, 1000000, 125, 4, false, '2023-09-27 12:47:43.807479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '314159265', 2018, 3, 792, 1000000, 125, 19, false, '2023-09-27 12:47:43.8158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '898568539', 2023, 2, 359, 2469.56246311934, 125, 16, false, '2023-09-27 12:47:43.8158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '866372238', 2023, 2, 608, 3280.21653581334, 125, 20, false, '2023-09-27 12:47:43.8158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '859120802', 2023, 2, 944, 9837.54690141146, 125, 6, false, '2023-09-27 12:47:43.82343', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '889775768', 2023, 2, 623, 9140.75976201448, 125, 5, false, '2023-09-27 12:47:43.82343', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '876874244', 2023, 2, 193, 5778.16036427468, 125, 3, false, '2023-09-27 12:47:43.82343', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '801893521', 2023, 2, 646, 4673.70426701138, 125, 18, false, '2023-09-27 12:47:43.82343', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '863680164', 2023, 2, 160, 5044.22394513075, 125, 2, false, '2023-09-27 12:47:43.831132', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '819118552', 2023, 2, 921, 8543.30002147865, 125, 14, false, '2023-09-27 12:47:43.831132', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '874703007', 2023, 2, 944, 6968.36272211771, 125, 18, false, '2023-09-27 12:47:43.831132', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '874032760', 2023, 2, 130, 2529.21125040514, 125, 3, false, '2023-09-27 12:47:43.831132', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '889640472', 2023, 2, 899, 5290.82032412293, 125, 1, false, '2023-09-27 12:47:43.837843', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '812445451', 2023, 2, 679, 887.790962015198, 125, 5, false, '2023-09-27 12:47:43.837843', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '881652601', 2023, 2, 419, 2731.43790153574, 125, 3, false, '2023-09-27 12:47:43.837843', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '840294166', 2023, 2, 825, 4264.95248257408, 125, 11, false, '2023-09-27 12:47:43.837843', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '831005379', 2023, 2, 398, 9364.86756746288, 125, 18, false, '2023-09-27 12:47:43.845797', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '859475383', 2023, 2, 912, 405.572021277129, 125, 11, false, '2023-09-27 12:47:43.845797', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '859968102', 2023, 2, 514, 8516.64568669236, 125, 2, false, '2023-09-27 12:47:43.845797', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '892271961', 2023, 2, 723, 4570.20230021635, 125, 1, false, '2023-09-27 12:47:43.851645', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '815902884', 2023, 2, 488, 4271.13230631816, 125, 11, false, '2023-09-27 12:47:43.851645', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '893844214', 2023, 2, 213, 4044.9701471771, 125, 6, false, '2023-09-27 12:47:43.851645', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '888955021', 2023, 2, 65, 5650.00300560755, 125, 4, false, '2023-09-27 12:47:43.851645', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '899964365', 2023, 2, 643, 7266.375468606, 125, 2, false, '2023-09-27 12:47:43.857991', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '891511936', 2023, 2, 79, 7618.6340083343, 125, 4, false, '2023-09-27 12:47:43.857991', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '856069557', 2023, 2, 6, 6389.87707373611, 125, 13, false, '2023-09-27 12:47:43.857991', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '841089736', 2023, 2, 576, 7488.91241144355, 125, 9, false, '2023-09-27 12:47:43.864164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '849316102', 2023, 2, 162, 7494.31342605842, 125, 8, false, '2023-09-27 12:47:43.864164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '807178210', 2023, 2, 42, 8121.75737571768, 125, 1, false, '2023-09-27 12:47:43.87095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '894005613', 2023, 2, 266, 4191.06625655905, 125, 4, false, '2023-09-27 12:47:43.87095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '800354007', 2023, 2, 132, 3880.11884811161, 125, 19, false, '2023-09-27 12:47:43.87095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '873447217', 2023, 2, 828, 8887.76158655731, 125, 10, false, '2023-09-27 12:47:43.877153', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '827719376', 2023, 2, 965, 9469.44513493926, 125, 4, false, '2023-09-27 12:47:43.877153', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '801899164', 2023, 2, 179, 7176.0210823947, 125, 5, false, '2023-09-27 12:47:43.877153', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '803680044', 2023, 2, 540, 7953.23248879129, 125, 6, false, '2023-09-27 12:47:43.884', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '873219231', 2023, 2, 549, 8231.19215328913, 125, 14, false, '2023-09-27 12:47:43.884', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '849116035', 2023, 2, 695, 613.655182422273, 125, 16, false, '2023-09-27 12:47:43.884', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '809268073', 2023, 2, 233, 5398.99885684855, 125, 17, false, '2023-09-27 12:47:43.884', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '845364138', 2023, 2, 853, 5943.43897785813, 125, 4, false, '2023-09-27 12:47:43.890846', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '864517784', 2023, 2, 6, 7889.0959920574, 125, 4, false, '2023-09-27 12:47:43.890846', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '865104598', 2023, 2, 590, 482.091190200961, 125, 14, false, '2023-09-27 12:47:43.89737', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '885532801', 2023, 2, 121, 5178.40824779323, 125, 14, false, '2023-09-27 12:47:43.89737', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '805316453', 2023, 2, 876, 6756.54793915142, 125, 6, false, '2023-09-27 12:47:43.904199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '864854816', 2023, 2, 791, 5516.24357194675, 125, 11, false, '2023-09-27 12:47:43.904199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '843327651', 2023, 2, 339, 9456.91992409101, 125, 16, false, '2023-09-27 12:47:43.910765', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '899360493', 2023, 2, 975, 2989.245882867, 125, 5, false, '2023-09-27 12:47:43.910765', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '874033135', 2023, 2, 113, 5724.54033773262, 125, 12, false, '2023-09-27 12:47:43.916434', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '814749111', 2023, 2, 708, 9002.54031468304, 125, 16, false, '2023-09-27 12:47:43.916434', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '830385063', 2023, 2, 381, 7640.58691119993, 125, 18, false, '2023-09-27 12:47:43.923875', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '878971159', 2023, 2, 382, 6091.60008892978, 125, 15, false, '2023-09-27 12:47:43.923875', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '860901626', 2023, 2, 170, 1803.68003285084, 125, 19, false, '2023-09-27 12:47:43.930798', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '831397838', 2023, 2, 434, 9215.41425874997, 125, 10, false, '2023-09-27 12:47:43.930798', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '847244539', 2023, 2, 150, 8711.5542311445, 125, 13, false, '2023-09-27 12:47:43.93541', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '840661567', 2023, 2, 755, 3765.05811142347, 125, 5, false, '2023-09-27 12:47:43.93541', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '894138262', 2023, 2, 731, 2063.83872322553, 125, 2, false, '2023-09-27 12:47:43.940948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '899951745', 2023, 2, 747, 321.392782894977, 125, 19, false, '2023-09-27 12:47:43.940948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '804978457', 2023, 2, 665, 6978.81387032285, 125, 7, false, '2023-09-27 12:47:43.940948', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '863449910', 2023, 2, 164, 471.858821466231, 125, 13, false, '2023-09-27 12:47:43.946572', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '817066902', 2023, 2, 520, 3797.43325608742, 125, 3, false, '2023-09-27 12:47:43.952357', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '853507323', 2023, 2, 216, 6187.53367636702, 125, 20, false, '2023-09-27 12:47:43.952357', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '807861681', 2023, 2, 422, 1944.64856507965, 125, 5, false, '2023-09-27 12:47:43.952357', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '835520579', 2023, 2, 778, 1408.21783400462, 125, 4, false, '2023-09-27 12:47:43.952357', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '880044215', 2023, 2, 298, 1808.66269440599, 125, 2, false, '2023-09-27 12:47:43.959808', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '887813790', 2023, 2, 183, 719.510430047377, 125, 8, false, '2023-09-27 12:47:43.959808', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '879629361', 2023, 2, 283, 337.219831913074, 125, 18, false, '2023-09-27 12:47:43.959808', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '834856071', 2023, 2, 913, 4974.27130892325, 125, 19, false, '2023-09-27 12:47:43.959808', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '839737952', 2023, 2, 605, 6577.01341815366, 125, 12, false, '2023-09-27 12:47:43.966887', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '879454278', 2023, 2, 179, 3928.80373477472, 125, 6, false, '2023-09-27 12:47:43.966887', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '869375251', 2023, 2, 753, 5374.95396788138, 125, 2, false, '2023-09-27 12:47:43.966887', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '891737001', 2023, 2, 409, 3043.29226501803, 125, 5, false, '2023-09-27 12:47:43.973391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '859548768', 2023, 2, 381, 6547.98423400231, 125, 14, false, '2023-09-27 12:47:43.973391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '815557877', 2023, 2, 480, 5414.2577805319, 125, 1, false, '2023-09-27 12:47:43.973391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '823964468', 2023, 2, 328, 8734.26270035656, 125, 4, false, '2023-09-27 12:47:43.973391', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '801260955', 2023, 2, 650, 7226.94371632585, 125, 11, false, '2023-09-27 12:47:43.97956', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '853901628', 2023, 2, 775, 4054.35187550501, 125, 7, false, '2023-09-27 12:47:43.97956', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '818012422', 2023, 2, 689, 4269.14454031087, 125, 5, false, '2023-09-27 12:47:43.97956', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '886701339', 2023, 2, 909, 3396.48753110789, 125, 11, false, '2023-09-27 12:47:43.97956', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '890766677', 2023, 2, 826, 5822.06602788439, 125, 13, false, '2023-09-27 12:47:43.97956', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '885562121', 2023, 2, 160, 78.6831321189925, 125, 14, false, '2023-09-27 12:47:43.986064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '883179502', 2023, 2, 333, 5159.33714092523, 125, 14, false, '2023-09-27 12:47:43.986064', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '889252671', 2023, 2, 466, 5071.75861014486, 125, 6, false, '2023-09-27 12:47:43.991433', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '891631136', 2023, 2, 413, 8221.43838539948, 125, 13, false, '2023-09-27 12:47:43.991433', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '834133138', 2023, 2, 57, 3060.87948678658, 125, 15, false, '2023-09-27 12:47:43.991433', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '865105026', 2023, 2, 883, 8149.26312713357, 125, 8, false, '2023-09-27 12:47:43.991433', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '852802807', 2023, 2, 450, 1919.34536179464, 125, 4, false, '2023-09-27 12:47:43.997762', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '895455206', 2023, 2, 918, 2014.37649426367, 125, 20, false, '2023-09-27 12:47:43.997762', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '811687458', 2023, 2, 731, 3090.87220495137, 125, 5, false, '2023-09-27 12:47:44.005292', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '886254610', 2023, 2, 907, 85.8916139910132, 125, 1, false, '2023-09-27 12:47:44.005292', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '809987579', 2023, 2, 798, 5389.67819322008, 125, 3, false, '2023-09-27 12:47:44.005292', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '813975560', 2023, 2, 50, 6014.69520389385, 125, 5, false, '2023-09-27 12:47:44.015648', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '811878131', 2023, 2, 819, 2860.46787932652, 125, 6, false, '2023-09-27 12:47:44.015648', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '834633239', 2023, 2, 568, 5952.34080286009, 125, 13, false, '2023-09-27 12:47:44.015648', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '807088266', 2023, 2, 374, 8246.74420083152, 125, 5, false, '2023-09-27 12:47:44.022314', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '868616982', 2023, 2, 474, 5025.79328797182, 125, 19, false, '2023-09-27 12:47:44.022314', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '800980006', 2023, 2, 679, 7392.00059698482, 125, 18, false, '2023-09-27 12:47:44.022314', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '833729664', 2023, 2, 72, 3211.39762892892, 125, 6, false, '2023-09-27 12:47:44.022314', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '896185369', 2023, 2, 109, 1223.61758316022, 125, 6, false, '2023-09-27 12:47:44.022314', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '821487814', 2023, 2, 346, 7996.91163335433, 125, 14, false, '2023-09-27 12:47:44.032513', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '843937221', 2023, 2, 305, 3415.40778240732, 125, 5, false, '2023-09-27 12:47:44.032513', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '891365018', 2023, 2, 376, 369.47059939104, 125, 18, false, '2023-09-27 12:47:44.040902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '802562418', 2023, 2, 238, 1500.12581735467, 125, 11, false, '2023-09-27 12:47:44.040902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '813482591', 2023, 2, 487, 6120.2827324052, 125, 15, false, '2023-09-27 12:47:44.040902', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '882864445', 2023, 2, 791, 9805.28994188691, 125, 11, false, '2023-09-27 12:47:44.048811', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '805723557', 2023, 2, 287, 9396.86711152515, 125, 14, false, '2023-09-27 12:47:44.048811', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '848182062', 2023, 2, 843, 6295.76040897709, 125, 12, false, '2023-09-27 12:47:44.048811', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '846089389', 2023, 2, 136, 5108.37179263607, 125, 2, false, '2023-09-27 12:47:44.05584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '823333463', 2023, 2, 383, 9062.34042915772, 125, 4, false, '2023-09-27 12:47:44.05584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '884296653', 2023, 2, 199, 9906.12537277551, 125, 17, false, '2023-09-27 12:47:44.05584', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '852903645', 2023, 2, 241, 4429.46156059381, 125, 2, false, '2023-09-27 12:47:44.061847', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '855109592', 2023, 2, 239, 7059.02047889849, 125, 7, false, '2023-09-27 12:47:44.061847', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '854029304', 2023, 2, 662, 5601.47305533169, 125, 1, false, '2023-09-27 12:47:44.061847', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '886855095', 2023, 2, 697, 6878.2995203223, 125, 9, false, '2023-09-27 12:47:44.068123', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '841216202', 2023, 2, 654, 3671.74724281395, 125, 13, false, '2023-09-27 12:47:44.068123', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '877836474', 2023, 2, 601, 2461.3824251522, 125, 19, false, '2023-09-27 12:47:44.07445', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '872323946', 2023, 2, 683, 6352.26344286189, 125, 4, false, '2023-09-27 12:47:44.07445', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '884669989', 2023, 2, 893, 2605.68836724248, 125, 8, false, '2023-09-27 12:47:44.080221', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '810175795', 2023, 2, 204, 6354.18618548386, 125, 6, false, '2023-09-27 12:47:44.080221', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '818541433', 2023, 2, 959, 613.454021510732, 125, 14, false, '2023-09-27 12:47:44.080221', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '844733792', 2023, 2, 333, 5625.48766567957, 125, 19, false, '2023-09-27 12:47:44.080221', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '894287440', 2023, 2, 469, 7429.23982712593, 125, 10, false, '2023-09-27 12:47:44.080221', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '823854289', 2023, 2, 258, 7499.50190348148, 125, 6, false, '2023-09-27 12:47:44.085199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '890614908', 2023, 2, 70, 8768.59183965973, 125, 17, false, '2023-09-27 12:47:44.085199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '883449489', 2023, 2, 942, 5445.92702937632, 125, 13, false, '2023-09-27 12:47:44.085199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '868953993', 2023, 2, 330, 4152.81056755698, 125, 11, false, '2023-09-27 12:47:44.085199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '833164615', 2023, 2, 966, 5984.27942582357, 125, 13, false, '2023-09-27 12:47:44.085199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '800638435', 2023, 2, 433, 9900.27638615557, 125, 1, false, '2023-09-27 12:47:44.090939', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '877683292', 2023, 2, 544, 7658.97325638643, 125, 1, false, '2023-09-27 12:47:44.090939', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '844806430', 2023, 2, 182, 8953.33740563285, 125, 4, false, '2023-09-27 12:47:44.090939', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '856883898', 2023, 2, 32, 800.505676010385, 125, 10, false, '2023-09-27 12:47:44.090939', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '834146586', 2023, 2, 85, 3890.46444044776, 125, 20, false, '2023-09-27 12:47:44.099637', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '827963000', 2023, 2, 19, 2685.77039418824, 125, 4, false, '2023-09-27 12:47:44.099637', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '858766933', 2023, 2, 368, 1839.56580266547, 125, 7, false, '2023-09-27 12:47:44.099637', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '894120846', 2023, 2, 833, 1812.50884019842, 125, 12, false, '2023-09-27 12:47:44.105479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '830813886', 2023, 2, 275, 1879.89133539743, 125, 20, false, '2023-09-27 12:47:44.105479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '826165178', 2023, 2, 436, 2902.30390028275, 125, 3, false, '2023-09-27 12:47:44.105479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '860614631', 2023, 2, 401, 1844.1574447871, 125, 18, false, '2023-09-27 12:47:44.105479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '843914504', 2023, 2, 588, 1768.7964225214, 125, 10, false, '2023-09-27 12:47:44.105479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '841947707', 2023, 2, 792, 1151.94670102495, 125, 12, false, '2023-09-27 12:47:44.105479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '805615372', 2023, 2, 791, 400.038170999667, 125, 20, false, '2023-09-27 12:47:44.112326', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '855472907', 2023, 2, 27, 3651.15713856438, 125, 8, false, '2023-09-27 12:47:44.112326', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '868639863', 2023, 2, 842, 5569.76765082056, 125, 19, false, '2023-09-27 12:47:44.112326', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '834233785', 2023, 2, 428, 828.177583072419, 125, 16, false, '2023-09-27 12:47:44.112326', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '879831802', 2023, 2, 921, 2912.88905830138, 125, 7, false, '2023-09-27 12:47:44.112326', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '898624492', 2023, 2, 340, 473.129663394591, 125, 15, false, '2023-09-27 12:47:44.112326', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '814314954', 2023, 2, 678, 4303.89956430492, 125, 2, false, '2023-09-27 12:47:44.119586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '896667526', 2023, 2, 649, 7816.0359623686, 125, 6, false, '2023-09-27 12:47:44.119586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '852100041', 2023, 2, 7, 7345.76407821052, 125, 2, false, '2023-09-27 12:47:44.119586', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '846329059', 2023, 2, 593, 3147.15258031125, 125, 14, false, '2023-09-27 12:47:44.12783', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '800659646', 2023, 2, 965, 6517.0439230045, 125, 19, false, '2023-09-27 12:47:44.12783', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '805635075', 2023, 2, 298, 2224.74331038025, 125, 15, false, '2023-09-27 12:47:44.12783', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '886851700', 2023, 2, 923, 2423.4287480422, 125, 11, false, '2023-09-27 12:47:44.12783', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '819215747', 2023, 2, 409, 3669.78927679661, 125, 1, false, '2023-09-27 12:47:44.133628', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '889934227', 2023, 2, 266, 3765.61909470685, 125, 19, false, '2023-09-27 12:47:44.133628', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '809175925', 2023, 2, 882, 6936.47655024252, 125, 15, false, '2023-09-27 12:47:44.133628', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '864642931', 2023, 2, 838, 9875.50365486248, 125, 19, false, '2023-09-27 12:47:44.133628', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '824353904', 2023, 2, 861, 4890.06167644989, 125, 6, false, '2023-09-27 12:47:44.133628', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '843768332', 2023, 2, 399, 5377.03837755057, 125, 1, false, '2023-09-27 12:47:44.133628', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '885079195', 2023, 2, 496, 6017.87185089178, 125, 19, false, '2023-09-27 12:47:44.133628', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '832026215', 2023, 2, 169, 4257.34024230336, 125, 10, false, '2023-09-27 12:47:44.139237', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '853841661', 2023, 2, 809, 3152.87729807712, 125, 9, false, '2023-09-27 12:47:44.139237', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '899112450', 2023, 2, 909, 787.288212580962, 125, 2, false, '2023-09-27 12:47:44.139237', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '859728672', 2023, 2, 900, 2242.4037793175, 125, 3, false, '2023-09-27 12:47:44.143486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '853818812', 2023, 2, 498, 3227.30595202216, 125, 7, false, '2023-09-27 12:47:44.143486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '854847475', 2023, 2, 561, 5121.47465338514, 125, 2, false, '2023-09-27 12:47:44.143486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '837305547', 2023, 2, 524, 4687.6456491959, 125, 3, false, '2023-09-27 12:47:44.143486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '840094865', 2023, 2, 290, 8134.12621779367, 125, 14, false, '2023-09-27 12:47:44.14917', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '811106611', 2023, 2, 737, 2238.23917993123, 125, 8, false, '2023-09-27 12:47:44.14917', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '837617427', 2023, 2, 625, 7946.3413590638, 125, 15, false, '2023-09-27 12:47:44.153785', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '858954736', 2023, 2, 128, 5245.18306488815, 125, 15, false, '2023-09-27 12:47:44.153785', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '816700668', 2023, 2, 6, 3234.43420740159, 125, 19, false, '2023-09-27 12:47:44.160045', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '808873241', 2023, 2, 678, 9606.05914064768, 125, 6, false, '2023-09-27 12:47:44.160045', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '866010559', 2023, 2, 202, 9765.42647812637, 125, 11, false, '2023-09-27 12:47:44.160045', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '865998380', 2023, 2, 790, 3277.4243585707, 125, 5, false, '2023-09-27 12:47:44.160045', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '854928401', 2023, 2, 637, 338.856472175249, 125, 17, false, '2023-09-27 12:47:44.160045', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '838426366', 2023, 2, 913, 1216.10234285322, 125, 4, false, '2023-09-27 12:47:44.165424', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '856053536', 2023, 2, 915, 3182.28014998463, 125, 17, false, '2023-09-27 12:47:44.165424', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '824710122', 2023, 2, 895, 6647.57550951635, 125, 15, false, '2023-09-27 12:47:44.165424', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '800262179', 2023, 2, 936, 3116.05352695961, 125, 15, false, '2023-09-27 12:47:44.173795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '847111097', 2023, 2, 612, 318.218054219173, 125, 15, false, '2023-09-27 12:47:44.173795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '844866931', 2023, 2, 950, 4309.46418772323, 125, 6, false, '2023-09-27 12:47:44.173795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '840864548', 2023, 2, 285, 3647.52092956663, 125, 4, false, '2023-09-27 12:47:44.173795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '853833870', 2023, 2, 943, 3901.56974311868, 125, 13, false, '2023-09-27 12:47:44.173795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '863704750', 2023, 2, 766, 4541.22182071475, 125, 17, false, '2023-09-27 12:47:44.173795', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '850178064', 2023, 2, 98, 447.306756628778, 125, 13, false, '2023-09-27 12:47:44.180147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '899217988', 2023, 2, 13, 9600.62080783776, 125, 18, false, '2023-09-27 12:47:44.180147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '835011792', 2023, 2, 508, 9532.69137845048, 125, 6, false, '2023-09-27 12:47:44.180147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '820364254', 2023, 2, 924, 5613.51797710415, 125, 10, false, '2023-09-27 12:47:44.180147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '842192029', 2023, 2, 587, 8947.53329657832, 125, 10, false, '2023-09-27 12:47:44.180147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '819466878', 2023, 2, 281, 1842.52546776789, 125, 6, false, '2023-09-27 12:47:44.180147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '873475613', 2023, 2, 163, 8842.31149491569, 125, 7, false, '2023-09-27 12:47:44.180147', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '858314589', 2023, 2, 665, 7781.66722968973, 125, 10, false, '2023-09-27 12:47:44.186417', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '895875589', 2023, 2, 569, 3917.53403952094, 125, 18, false, '2023-09-27 12:47:44.186417', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '805387170', 2023, 2, 604, 6690.04222682785, 125, 14, false, '2023-09-27 12:47:44.186417', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '815068004', 2023, 2, 894, 7084.80040861023, 125, 20, false, '2023-09-27 12:47:44.186417', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '830053040', 2023, 2, 789, 6317.2360061481, 125, 17, false, '2023-09-27 12:47:44.192311', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '808340802', 2023, 2, 826, 2802.79445149615, 125, 11, false, '2023-09-27 12:47:44.192311', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '881022152', 2023, 2, 256, 3926.85533179837, 125, 20, false, '2023-09-27 12:47:44.192311', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '827674772', 2023, 2, 910, 1586.96059541634, 125, 18, false, '2023-09-27 12:47:44.192311', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '846054241', 2023, 2, 933, 8982.75528037615, 125, 2, false, '2023-09-27 12:47:44.192311', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '806691308', 2023, 2, 594, 3734.38697179332, 125, 15, false, '2023-09-27 12:47:44.192311', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '865320028', 2023, 2, 859, 7098.22264537576, 125, 14, false, '2023-09-27 12:47:44.197816', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '846023615', 2023, 2, 363, 7131.38150164171, 125, 5, false, '2023-09-27 12:47:44.197816', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '822824963', 2023, 2, 29, 462.170553176167, 125, 13, false, '2023-09-27 12:47:44.197816', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '889997531', 2023, 2, 612, 5881.38794194466, 125, 4, false, '2023-09-27 12:47:44.197816', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '848189078', 2023, 2, 607, 9340.45530645446, 125, 11, false, '2023-09-27 12:47:44.197816', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '876267524', 2023, 2, 318, 5182.83803246706, 125, 2, false, '2023-09-27 12:47:44.203144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '833510033', 2023, 2, 828, 5129.66755309315, 125, 20, false, '2023-09-27 12:47:44.203144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '819898599', 2023, 2, 836, 1584.15935237105, 125, 6, false, '2023-09-27 12:47:44.203144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '889987138', 2023, 2, 515, 545.858408343989, 125, 9, false, '2023-09-27 12:47:44.203144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '853001877', 2023, 2, 962, 8973.77836748522, 125, 10, false, '2023-09-27 12:47:44.203144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '814999762', 2023, 2, 787, 7654.46290097284, 125, 16, false, '2023-09-27 12:47:44.203144', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '891298662', 2023, 2, 166, 5427.55029849703, 125, 15, false, '2023-09-27 12:47:44.207729', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '817529789', 2023, 2, 847, 637.65332812111, 125, 13, false, '2023-09-27 12:47:44.207729', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '803984268', 2023, 2, 440, 5729.61004606332, 125, 10, false, '2023-09-27 12:47:44.207729', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '820592381', 2023, 2, 340, 1284.01203805677, 125, 19, false, '2023-09-27 12:47:44.207729', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '897972546', 2023, 2, 636, 389.465992802392, 125, 19, false, '2023-09-27 12:47:44.212355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '875062733', 2023, 2, 936, 7464.08314937601, 125, 19, false, '2023-09-27 12:47:44.212355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '852700091', 2023, 2, 436, 4775.00242125156, 125, 20, false, '2023-09-27 12:47:44.212355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '815185914', 2023, 2, 148, 3556.19145151716, 125, 3, false, '2023-09-27 12:47:44.212355', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '834693586', 2023, 2, 736, 3977.96843838385, 125, 10, false, '2023-09-27 12:47:44.217313', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '855109755', 2023, 2, 163, 5794.94534676445, 125, 5, false, '2023-09-27 12:47:44.217313', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '849276543', 2023, 2, 817, 5954.53515214517, 125, 11, false, '2023-09-27 12:47:44.217313', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '820510385', 2023, 2, 173, 5418.57866523649, 125, 17, false, '2023-09-27 12:47:44.217313', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '832442866', 2023, 2, 37, 6900.53192028903, 125, 1, false, '2023-09-27 12:47:44.217313', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '868527173', 2023, 2, 674, 5657.81491041864, 125, 13, false, '2023-09-27 12:47:44.223289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '896537965', 2023, 2, 512, 140.155384850368, 125, 14, false, '2023-09-27 12:47:44.223289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '869765393', 2023, 2, 31, 5190.30677494924, 125, 11, false, '2023-09-27 12:47:44.223289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '878631146', 2023, 2, 267, 5760.72803225845, 125, 19, false, '2023-09-27 12:47:44.223289', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '893022828', 2023, 2, 226, 9341.75975883233, 125, 8, false, '2023-09-27 12:47:44.228835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '870488667', 2023, 2, 497, 3393.07707100216, 125, 7, false, '2023-09-27 12:47:44.228835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '885693391', 2023, 2, 318, 7181.60023845925, 125, 16, false, '2023-09-27 12:47:44.228835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '877588354', 2023, 2, 592, 4096.31730822955, 125, 6, false, '2023-09-27 12:47:44.228835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '835353921', 2023, 2, 551, 8405.39263866113, 125, 11, false, '2023-09-27 12:47:44.228835', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '862576386', 2023, 2, 204, 9472.47736198194, 125, 18, false, '2023-09-27 12:47:44.233983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '855839558', 2023, 2, 87, 5425.52754292156, 125, 13, false, '2023-09-27 12:47:44.233983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '877306625', 2023, 2, 791, 7192.04310737936, 125, 14, false, '2023-09-27 12:47:44.233983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '857990940', 2023, 2, 409, 9712.93966474592, 125, 15, false, '2023-09-27 12:47:44.233983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '855059723', 2023, 2, 728, 8594.89024184907, 125, 13, false, '2023-09-27 12:47:44.233983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '832427770', 2023, 2, 942, 7545.79173994687, 125, 9, false, '2023-09-27 12:47:44.233983', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '832190627', 2023, 2, 530, 5396.86449013474, 125, 17, false, '2023-09-27 12:47:44.239352', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '892239323', 2023, 2, 213, 2153.11268936351, 125, 20, false, '2023-09-27 12:47:44.239352', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '899413636', 2023, 2, 550, 3802.4528876492, 125, 17, false, '2023-09-27 12:47:44.239352', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '804944614', 2023, 2, 172, 4535.2521933503, 125, 18, false, '2023-09-27 12:47:44.239352', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '890674385', 2023, 2, 986, 6117.62488575264, 125, 16, false, '2023-09-27 12:47:44.244725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '803393633', 2023, 2, 635, 9994.8606399298, 125, 12, false, '2023-09-27 12:47:44.244725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '824106789', 2023, 2, 529, 500.677465422664, 125, 5, false, '2023-09-27 12:47:44.244725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '882122217', 2023, 2, 907, 1438.59002086628, 125, 11, false, '2023-09-27 12:47:44.244725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '859439629', 2023, 2, 696, 7635.8659892978, 125, 8, false, '2023-09-27 12:47:44.244725', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '816467453', 2023, 2, 40, 953.479680641802, 125, 6, false, '2023-09-27 12:47:44.250054', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '895579410', 2023, 2, 121, 7014.94991633805, 125, 17, false, '2023-09-27 12:47:44.250054', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '816662201', 2023, 2, 955, 2953.50487622922, 125, 8, false, '2023-09-27 12:47:44.250054', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '852642017', 2023, 2, 224, 8192.11110393963, 125, 3, false, '2023-09-27 12:47:44.250054', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '856716152', 2023, 2, 625, 3795.61248913327, 125, 2, false, '2023-09-27 12:47:44.250054', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '855383952', 2023, 2, 544, 4836.34914409251, 125, 19, false, '2023-09-27 12:47:44.256293', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '802584307', 2023, 2, 683, 5408.66268482724, 125, 4, false, '2023-09-27 12:47:44.256293', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '827140608', 2023, 2, 568, 4997.8033117911, 125, 9, false, '2023-09-27 12:47:44.256293', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '882331842', 2023, 2, 404, 4722.06600853743, 125, 13, false, '2023-09-27 12:47:44.256293', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '801619866', 2023, 2, 683, 4877.58807774244, 125, 16, false, '2023-09-27 12:47:44.261683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '825030543', 2023, 2, 114, 6832.38389877554, 125, 12, false, '2023-09-27 12:47:44.261683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '861837698', 2023, 2, 810, 6965.92083685378, 125, 1, false, '2023-09-27 12:47:44.261683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '829811962', 2023, 2, 883, 9527.31571932662, 125, 4, false, '2023-09-27 12:47:44.261683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '822242899', 2023, 2, 423, 9847.17643972577, 125, 2, false, '2023-09-27 12:47:44.267095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '855141426', 2023, 2, 917, 7336.57503604056, 125, 13, false, '2023-09-27 12:47:44.267095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '864311384', 2023, 2, 277, 7687.62594585183, 125, 20, false, '2023-09-27 12:47:44.267095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '830236604', 2023, 2, 328, 632.742957204917, 125, 2, false, '2023-09-27 12:47:44.267095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '836452543', 2023, 2, 68, 6014.07398979567, 125, 13, false, '2023-09-27 12:47:44.267095', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '892225109', 2023, 2, 575, 6320.14182977587, 125, 11, false, '2023-09-27 12:47:44.273246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '810762223', 2023, 2, 235, 6984.15834968013, 125, 13, false, '2023-09-27 12:47:44.273246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '837437935', 2023, 2, 9, 3804.15526197556, 125, 20, false, '2023-09-27 12:47:44.273246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '815177890', 2023, 2, 166, 8596.70870947544, 125, 16, false, '2023-09-27 12:47:44.273246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '802444869', 2023, 2, 535, 3992.08098687952, 125, 13, false, '2023-09-27 12:47:44.273246', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '846357403', 2023, 2, 833, 9446.63003588927, 125, 3, false, '2023-09-27 12:47:44.278775', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '894125644', 2023, 2, 54, 77.1006466519973, 125, 3, false, '2023-09-27 12:47:44.278775', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '860079548', 2023, 2, 964, 2737.66872701966, 125, 12, false, '2023-09-27 12:47:44.278775', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '850727134', 2023, 2, 720, 7474.23463705234, 125, 1, false, '2023-09-27 12:47:44.284208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '897600352', 2023, 2, 773, 7628.08075210235, 125, 11, false, '2023-09-27 12:47:44.284208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '865176224', 2023, 2, 166, 3964.62511319043, 125, 3, false, '2023-09-27 12:47:44.284208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '841023274', 2023, 2, 780, 8246.52971627939, 125, 16, false, '2023-09-27 12:47:44.284208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '858767970', 2023, 2, 277, 3005.4846242225, 125, 20, false, '2023-09-27 12:47:44.284208', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '815013773', 2023, 2, 465, 1314.6994455156, 125, 17, false, '2023-09-27 12:47:44.293185', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '806551335', 2023, 2, 10, 8474.28312367753, 125, 12, false, '2023-09-27 12:47:44.293185', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '862063648', 2023, 2, 892, 7761.6041384775, 125, 12, false, '2023-09-27 12:47:44.293185', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '829511190', 2023, 2, 801, 8056.86279095768, 125, 12, false, '2023-09-27 12:47:44.293185', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '890504212', 2023, 2, 785, 9894.94450946204, 125, 6, false, '2023-09-27 12:47:44.299405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '839750510', 2023, 2, 277, 6794.08565002715, 125, 11, false, '2023-09-27 12:47:44.299405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '859077713', 2023, 2, 176, 4027.47106430739, 125, 4, false, '2023-09-27 12:47:44.299405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '807085015', 2023, 2, 45, 6744.76566192688, 125, 7, false, '2023-09-27 12:47:44.299405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '820154219', 2023, 2, 468, 428.328489098917, 125, 6, false, '2023-09-27 12:47:44.299405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '854770517', 2023, 2, 498, 2943.8384675579, 125, 2, false, '2023-09-27 12:47:44.299405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '855050206', 2023, 2, 656, 6771.92354216419, 125, 2, false, '2023-09-27 12:47:44.299405', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '889128185', 2023, 2, 601, 7666.58208982473, 125, 6, false, '2023-09-27 12:47:44.305686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '806386500', 2023, 2, 660, 7100.66818454203, 125, 18, false, '2023-09-27 12:47:44.305686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '866865790', 2023, 2, 778, 2138.4300232856, 125, 7, false, '2023-09-27 12:47:44.305686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '823546398', 2023, 2, 438, 9161.26169849189, 125, 17, false, '2023-09-27 12:47:44.305686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '809817182', 2023, 2, 755, 6720.68509746748, 125, 1, false, '2023-09-27 12:47:44.305686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '886965332', 2023, 2, 81, 2675.29832557188, 125, 17, false, '2023-09-27 12:47:44.312169', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '837006317', 2023, 2, 332, 3031.14798060336, 125, 15, false, '2023-09-27 12:47:44.312169', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '859791871', 2023, 2, 410, 6724.47045778522, 125, 13, false, '2023-09-27 12:47:44.312169', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '839648076', 2023, 2, 355, 8793.74035924757, 125, 2, false, '2023-09-27 12:47:44.312169', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '886374702', 2023, 2, 399, 5247.60068258693, 125, 9, false, '2023-09-27 12:47:44.312169', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '801018012', 2023, 2, 85, 8953.72169287297, 125, 14, false, '2023-09-27 12:47:44.318748', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '874911010', 2023, 2, 940, 7324.58624704175, 125, 10, false, '2023-09-27 12:47:44.318748', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '879283512', 2023, 2, 615, 8594.85535816574, 125, 19, false, '2023-09-27 12:47:44.318748', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '811427024', 2023, 2, 427, 1102.62041123454, 125, 2, false, '2023-09-27 12:47:44.318748', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '866768166', 2023, 2, 342, 4183.76402928144, 125, 9, false, '2023-09-27 12:47:44.318748', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '808374138', 2023, 2, 285, 3404.03743995508, 125, 18, false, '2023-09-27 12:47:44.318748', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '892584778', 2023, 2, 112, 2714.19414206314, 125, 18, false, '2023-09-27 12:47:44.325296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '890289304', 2023, 2, 754, 4826.04258265684, 125, 17, false, '2023-09-27 12:47:44.325296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '897993099', 2023, 2, 821, 1613.04162707147, 125, 19, false, '2023-09-27 12:47:44.325296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '838203900', 2023, 2, 805, 4285.77944457516, 125, 15, false, '2023-09-27 12:47:44.325296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '820357215', 2023, 2, 146, 3460.83387424053, 125, 8, false, '2023-09-27 12:47:44.325296', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '825011425', 2023, 2, 461, 9900.52923957981, 125, 5, false, '2023-09-27 12:47:44.330976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '858637744', 2023, 2, 87, 1193.68927964635, 125, 1, false, '2023-09-27 12:47:44.330976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '807877858', 2023, 2, 568, 917.150042862164, 125, 3, false, '2023-09-27 12:47:44.330976', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '856450848', 2023, 2, 148, 257.957584467306, 125, 1, false, '2023-09-27 12:47:44.336432', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '899941610', 2023, 2, 644, 4183.68988017699, 125, 18, false, '2023-09-27 12:47:44.336432', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '811875102', 2023, 2, 921, 2614.29568241523, 125, 16, false, '2023-09-27 12:47:44.336432', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '879885713', 2023, 2, 220, 2869.90614222043, 125, 11, false, '2023-09-27 12:47:44.336432', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '885482062', 2023, 2, 918, 2761.31079223491, 125, 10, false, '2023-09-27 12:47:44.336432', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '866886570', 2023, 2, 333, 4918.97386629678, 125, 4, false, '2023-09-27 12:47:44.343108', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '890616652', 2023, 2, 203, 9502.2310136487, 125, 15, false, '2023-09-27 12:47:44.343108', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '862722287', 2023, 2, 869, 1094.08668688084, 125, 11, false, '2023-09-27 12:47:44.343108', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '886375261', 2023, 2, 439, 3653.57835191552, 125, 7, false, '2023-09-27 12:47:44.343108', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '896357373', 2023, 2, 409, 8945.43305264485, 125, 8, false, '2023-09-27 12:47:44.343108', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '866677637', 2023, 2, 272, 8360.39509545253, 125, 11, false, '2023-09-27 12:47:44.348867', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '850099558', 2023, 2, 537, 3354.48184699174, 125, 14, false, '2023-09-27 12:47:44.348867', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '859820298', 2023, 2, 468, 8936.49727396348, 125, 12, false, '2023-09-27 12:47:44.348867', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '888812048', 2023, 2, 494, 2397.44175063637, 125, 7, false, '2023-09-27 12:47:44.348867', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '821080096', 2023, 2, 362, 946.755339741295, 125, 17, false, '2023-09-27 12:47:44.354249', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '898108054', 2023, 2, 585, 3571.75130561323, 125, 13, false, '2023-09-27 12:47:44.354249', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '842021484', 2023, 2, 406, 6236.3434131974, 125, 8, false, '2023-09-27 12:47:44.354249', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '880853424', 2023, 2, 374, 8556.90201002993, 125, 20, false, '2023-09-27 12:47:44.354249', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '833088737', 2023, 2, 111, 1758.90227620644, 125, 17, false, '2023-09-27 12:47:44.354249', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '824370623', 2023, 2, 429, 7756.34155313756, 125, 7, false, '2023-09-27 12:47:44.360338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '859886502', 2023, 2, 77, 9923.96969026883, 125, 20, false, '2023-09-27 12:47:44.360338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '881709672', 2023, 2, 69, 3552.04703647978, 125, 9, false, '2023-09-27 12:47:44.366314', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '878183875', 2023, 2, 194, 542.451491968886, 125, 6, false, '2023-09-27 12:47:44.366314', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '871061073', 2023, 2, 255, 6869.72445635672, 125, 14, false, '2023-09-27 12:47:44.366314', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '834151829', 2023, 2, 298, 3436.70149901471, 125, 4, false, '2023-09-27 12:47:44.366314', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '895917367', 2023, 2, 512, 3827.87038402407, 125, 7, false, '2023-09-27 12:47:44.366314', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '884414162', 2023, 2, 494, 8487.53149735856, 125, 19, false, '2023-09-27 12:47:44.371869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '859150008', 2023, 2, 229, 445.133597566584, 125, 11, false, '2023-09-27 12:47:44.371869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '896355742', 2023, 2, 706, 761.160576380746, 125, 15, false, '2023-09-27 12:47:44.371869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '800747683', 2023, 2, 405, 4967.59919830089, 125, 9, false, '2023-09-27 12:47:44.371869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '857037705', 2023, 2, 879, 7958.78847140176, 125, 11, false, '2023-09-27 12:47:44.377472', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '897975138', 2023, 2, 141, 7123.17812614949, 125, 7, false, '2023-09-27 12:47:44.377472', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '807173400', 2023, 2, 345, 4368.72641114976, 125, 6, false, '2023-09-27 12:47:44.377472', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '853864887', 2023, 2, 895, 7214.25713264044, 125, 3, false, '2023-09-27 12:47:44.384431', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '844632422', 2023, 2, 72, 7971.7653683869, 125, 1, false, '2023-09-27 12:47:44.384431', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '844666006', 2023, 2, 89, 3753.78813758468, 125, 12, false, '2023-09-27 12:47:44.384431', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '802555928', 2023, 2, 985, 9224.49288805298, 125, 10, false, '2023-09-27 12:47:44.384431', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '816641469', 2023, 2, 671, 99.9362890779031, 125, 15, false, '2023-09-27 12:47:44.390214', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '878284938', 2023, 2, 302, 506.490249621897, 125, 1, false, '2023-09-27 12:47:44.390214', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '833167762', 2023, 2, 536, 1512.50730356025, 125, 7, false, '2023-09-27 12:47:44.390214', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '852738491', 2023, 2, 337, 8416.09886506935, 125, 14, false, '2023-09-27 12:47:44.390214', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '854600919', 2023, 2, 925, 5684.56293730092, 125, 4, false, '2023-09-27 12:47:44.390214', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '891686706', 2023, 2, 111, 6039.11611688113, 125, 2, false, '2023-09-27 12:47:44.390214', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '800994018', 2023, 2, 421, 713.968777099991, 125, 19, false, '2023-09-27 12:47:44.390214', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '885343199', 2023, 2, 923, 6043.35149409985, 125, 19, false, '2023-09-27 12:47:44.390214', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '814097367', 2023, 2, 509, 4736.94177961043, 125, 8, false, '2023-09-27 12:47:44.395868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '855405477', 2023, 2, 356, 3533.30360023267, 125, 12, false, '2023-09-27 12:47:44.395868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '871110892', 2023, 2, 809, 7594.38833935545, 125, 18, false, '2023-09-27 12:47:44.395868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '889302409', 2023, 2, 334, 9563.38227441835, 125, 8, false, '2023-09-27 12:47:44.395868', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '862650554', 2023, 2, 844, 7054.34099208226, 125, 11, false, '2023-09-27 12:47:44.402044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '856323024', 2023, 2, 361, 3126.3527354938, 125, 5, false, '2023-09-27 12:47:44.402044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '865957763', 2023, 2, 489, 1531.73688038499, 125, 13, false, '2023-09-27 12:47:44.402044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '809997464', 2023, 2, 126, 9700.60547671808, 125, 6, false, '2023-09-27 12:47:44.402044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '892037204', 2023, 2, 143, 8140.69700137857, 125, 1, false, '2023-09-27 12:47:44.402044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '855209391', 2023, 2, 389, 9317.61016540031, 125, 4, false, '2023-09-27 12:47:44.402044', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '852675187', 2023, 2, 402, 8916.13249522709, 125, 14, false, '2023-09-27 12:47:44.407702', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '875190936', 2023, 2, 250, 649.442761735009, 125, 14, false, '2023-09-27 12:47:44.407702', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '878772022', 2023, 2, 430, 3972.74062310577, 125, 4, false, '2023-09-27 12:47:44.407702', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '875906777', 2023, 2, 362, 9967.69872471854, 125, 12, false, '2023-09-27 12:47:44.407702', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '867050630', 2023, 2, 280, 2911.88027589226, 125, 17, false, '2023-09-27 12:47:44.412972', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '899626977', 2023, 2, 37, 2073.7802805475, 125, 1, false, '2023-09-27 12:47:44.412972', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '847716706', 2023, 2, 740, 2527.88490838999, 125, 11, false, '2023-09-27 12:47:44.412972', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '819302627', 2023, 2, 70, 9990.32268373924, 125, 8, false, '2023-09-27 12:47:44.418323', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '886536405', 2023, 2, 41, 7599.88294959464, 125, 4, false, '2023-09-27 12:47:44.418323', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '861719015', 2023, 2, 874, 7243.73597131053, 125, 1, false, '2023-09-27 12:47:44.418323', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '858181803', 2023, 2, 247, 2524.78882341061, 125, 13, false, '2023-09-27 12:47:44.418323', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '896147751', 2023, 2, 744, 2845.83487868196, 125, 3, false, '2023-09-27 12:47:44.418323', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '825362503', 2023, 2, 88, 875.357448938907, 125, 16, false, '2023-09-27 12:47:44.423219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '873037031', 2023, 2, 405, 5840.45315275098, 125, 18, false, '2023-09-27 12:47:44.423219', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '808933296', 2023, 2, 825, 5088.10101721953, 125, 9, false, '2023-09-27 12:47:44.427619', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '856311115', 2023, 2, 473, 9871.52750137536, 125, 1, false, '2023-09-27 12:47:44.427619', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '841062282', 2023, 2, 515, 4989.85349771421, 125, 3, false, '2023-09-27 12:47:44.432096', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '839896151', 2023, 2, 910, 7101.54554263004, 125, 5, false, '2023-09-27 12:47:44.438799', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '808119254', 2023, 2, 921, 6427.3360022652, 125, 8, false, '2023-09-27 12:47:44.44358', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '868411463', 2023, 2, 135, 950.631659169817, 125, 13, false, '2023-09-27 12:47:44.44358', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '845923614', 2023, 2, 192, 1646.88669768723, 125, 11, false, '2023-09-27 12:47:44.44731', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '879136681', 2023, 2, 624, 8005.22753220658, 125, 15, false, '2023-09-27 12:47:44.44731', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '849262935', 2023, 2, 505, 6209.20501476563, 125, 6, false, '2023-09-27 12:47:44.452658', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '806920595', 2023, 2, 726, 6709.65862816389, 125, 11, false, '2023-09-27 12:47:44.452658', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '880756394', 2023, 2, 934, 646.922819636665, 125, 11, false, '2023-09-27 12:47:44.452658', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '880104024', 2023, 2, 397, 64.6126307827114, 125, 19, false, '2023-09-27 12:47:44.452658', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '801556211', 2023, 2, 167, 4484.46578132992, 125, 18, false, '2023-09-27 12:47:44.452658', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '819264022', 2023, 2, 366, 9816.52873720962, 125, 7, false, '2023-09-27 12:47:44.458397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '848716349', 2023, 2, 842, 6650.5724012205, 125, 13, false, '2023-09-27 12:47:44.458397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '825277344', 2023, 2, 680, 6534.18518751509, 125, 5, false, '2023-09-27 12:47:44.458397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '819827494', 2023, 2, 558, 6105.78615830064, 125, 3, false, '2023-09-27 12:47:44.458397', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '846662600', 2023, 2, 454, 1746.3493475213, 125, 18, false, '2023-09-27 12:47:44.462731', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '874024359', 2023, 2, 137, 3089.5328630986, 125, 20, false, '2023-09-27 12:47:44.462731', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '821366281', 2023, 2, 336, 2444.35636254796, 125, 4, false, '2023-09-27 12:47:44.462731', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '808210382', 2023, 2, 193, 5517.65619351289, 125, 17, false, '2023-09-27 12:47:44.467747', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '826428237', 2023, 2, 494, 7657.72274062812, 125, 8, false, '2023-09-27 12:47:44.467747', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '815054956', 2023, 2, 947, 4688.73845492443, 125, 9, false, '2023-09-27 12:47:44.472171', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '818328814', 2023, 2, 202, 6395.24183875064, 125, 14, false, '2023-09-27 12:47:44.472171', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '807556210', 2023, 2, 84, 6300.87441412099, 125, 3, false, '2023-09-27 12:47:44.472171', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '871418690', 2023, 2, 586, 5876.22273146718, 125, 15, false, '2023-09-27 12:47:44.476777', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '813082052', 2023, 2, 161, 1212.72749214255, 125, 16, false, '2023-09-27 12:47:44.481676', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '806846003', 2023, 2, 403, 6926.51403697319, 125, 5, false, '2023-09-27 12:47:44.481676', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '824330847', 2023, 2, 391, 8750.12159720762, 125, 17, false, '2023-09-27 12:47:44.481676', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '826690138', 2023, 2, 5, 4404.92625719258, 125, 19, false, '2023-09-27 12:47:44.481676', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '856403693', 2023, 2, 163, 4958.74141767509, 125, 18, false, '2023-09-27 12:47:44.486722', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '816621697', 2023, 2, 215, 4089.65636758458, 125, 18, false, '2023-09-27 12:47:44.486722', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '816554758', 2023, 2, 515, 2083.08882860084, 125, 8, false, '2023-09-27 12:47:44.486722', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '857535371', 2023, 2, 263, 6157.2126613346, 125, 18, false, '2023-09-27 12:47:44.486722', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '823784313', 2023, 2, 967, 364.486634833169, 125, 6, false, '2023-09-27 12:47:44.491975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '891396939', 2023, 2, 879, 4521.64004513536, 125, 4, false, '2023-09-27 12:47:44.491975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '890803412', 2023, 2, 422, 2635.54335801202, 125, 16, false, '2023-09-27 12:47:44.491975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '864310341', 2023, 2, 511, 5366.42416644475, 125, 10, false, '2023-09-27 12:47:44.491975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '852154283', 2023, 2, 76, 269.910513816881, 125, 17, false, '2023-09-27 12:47:44.491975', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '845274259', 2023, 2, 587, 4453.64849466164, 125, 14, false, '2023-09-27 12:47:44.496957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '845587063', 2023, 2, 355, 5824.04272081786, 125, 1, false, '2023-09-27 12:47:44.496957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '827331930', 2023, 2, 688, 337.645593218853, 125, 20, false, '2023-09-27 12:47:44.496957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '869238003', 2023, 2, 485, 8738.35571047366, 125, 18, false, '2023-09-27 12:47:44.496957', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '852723183', 2023, 2, 494, 1751.14610788964, 125, 20, false, '2023-09-27 12:47:44.504637', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '815069674', 2023, 2, 157, 6990.37316825918, 125, 5, false, '2023-09-27 12:47:44.504637', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '824320547', 2023, 2, 49, 441.994333838897, 125, 15, false, '2023-09-27 12:47:44.504637', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '858685635', 2023, 2, 678, 2351.80585247588, 125, 1, false, '2023-09-27 12:47:44.504637', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '829626868', 2023, 2, 146, 6180.52427056834, 125, 7, false, '2023-09-27 12:47:44.510433', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '869197746', 2023, 2, 70, 11.6019898677067, 125, 15, false, '2023-09-27 12:47:44.510433', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '896311843', 2023, 2, 583, 6041.08517546011, 125, 11, false, '2023-09-27 12:47:44.510433', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '872643712', 2023, 2, 937, 1087.26633490856, 125, 9, false, '2023-09-27 12:47:44.510433', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '829662663', 2023, 2, 988, 4827.53968946026, 125, 11, false, '2023-09-27 12:47:44.510433', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '845972124', 2023, 2, 908, 7244.83317603244, 125, 19, false, '2023-09-27 12:47:44.51531', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '848464680', 2023, 2, 732, 4781.37445207554, 125, 1, false, '2023-09-27 12:47:44.520452', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '820268569', 2023, 2, 705, 4047.53387634577, 125, 14, false, '2023-09-27 12:47:44.520452', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '820015256', 2023, 2, 226, 8243.07573650373, 125, 11, false, '2023-09-27 12:47:44.520452', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '844573903', 2023, 2, 150, 9437.59127828641, 125, 14, false, '2023-09-27 12:47:44.520452', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '882085748', 2023, 2, 116, 1406.96683994299, 125, 7, false, '2023-09-27 12:47:44.520452', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '867428946', 2023, 2, 126, 2632.38549968211, 125, 14, false, '2023-09-27 12:47:44.525174', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '871031437', 2023, 2, 552, 4859.09380967459, 125, 17, false, '2023-09-27 12:47:44.525174', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '843532169', 2023, 2, 393, 7925.73194773556, 125, 1, false, '2023-09-27 12:47:44.52967', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '857146415', 2023, 2, 697, 5094.9341200785, 125, 1, false, '2023-09-27 12:47:44.52967', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '858809768', 2023, 2, 890, 1689.96788164606, 125, 6, false, '2023-09-27 12:47:44.52967', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '876716164', 2023, 2, 987, 3940.67405299991, 125, 9, false, '2023-09-27 12:47:44.52967', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '819492088', 2023, 2, 72, 6444.83137937355, 125, 9, false, '2023-09-27 12:47:44.52967', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '838239624', 2023, 2, 807, 6189.97249114108, 125, 16, false, '2023-09-27 12:47:44.52967', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '885945837', 2023, 2, 733, 736.213330982562, 125, 7, false, '2023-09-27 12:47:44.536047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '861498828', 2023, 2, 411, 9184.04354649473, 125, 17, false, '2023-09-27 12:47:44.536047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '801804711', 2023, 2, 922, 2184.38036784211, 125, 11, false, '2023-09-27 12:47:44.536047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '833509017', 2023, 2, 869, 6069.2727027193, 125, 5, false, '2023-09-27 12:47:44.541871', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '827952461', 2023, 2, 841, 9703.76523358917, 125, 11, false, '2023-09-27 12:47:44.541871', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '899971016', 2023, 2, 119, 9501.36170614444, 125, 19, false, '2023-09-27 12:47:44.541871', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '851522918', 2023, 2, 260, 6471.45341666083, 125, 11, false, '2023-09-27 12:47:44.541871', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '876958842', 2023, 2, 335, 74.8844914742225, 125, 14, false, '2023-09-27 12:47:44.541871', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '800056603', 2023, 2, 434, 3842.84177504523, 125, 7, false, '2023-09-27 12:47:44.541871', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '843586867', 2023, 2, 194, 1680.76307065097, 125, 12, false, '2023-09-27 12:47:44.548037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '823345513', 2023, 2, 833, 5600.62492842608, 125, 9, false, '2023-09-27 12:47:44.548037', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '848090389', 2023, 2, 699, 9761.89559872665, 125, 6, false, '2023-09-27 12:47:44.553463', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '813124156', 2023, 2, 901, 9408.58319419023, 125, 20, false, '2023-09-27 12:47:44.553463', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '806937760', 2023, 2, 66, 8448.39918202327, 125, 14, false, '2023-09-27 12:47:44.553463', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '804492254', 2023, 2, 836, 9251.81741464416, 125, 8, false, '2023-09-27 12:47:44.553463', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '850961994', 2023, 2, 442, 4746.13609576178, 125, 1, false, '2023-09-27 12:47:44.553463', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '811452235', 2023, 2, 688, 1982.35146905975, 125, 9, false, '2023-09-27 12:47:44.558669', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '800196588', 2023, 2, 908, 5920.31342449564, 125, 17, false, '2023-09-27 12:47:44.558669', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '824251872', 2023, 2, 680, 3839.49848992901, 125, 3, false, '2023-09-27 12:47:44.558669', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '805680022', 2023, 2, 817, 5196.32833507573, 125, 14, false, '2023-09-27 12:47:44.558669', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '802238763', 2023, 2, 460, 6675.41556649413, 125, 11, false, '2023-09-27 12:47:44.558669', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '897656556', 2023, 2, 31, 2673.4902996073, 125, 2, false, '2023-09-27 12:47:44.563485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '888995913', 2023, 2, 695, 1638.17439708044, 125, 20, false, '2023-09-27 12:47:44.563485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '867259951', 2023, 2, 325, 3756.87705855146, 125, 14, false, '2023-09-27 12:47:44.563485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '820227377', 2023, 2, 715, 5071.46122399162, 125, 4, false, '2023-09-27 12:47:44.563485', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '882903192', 2023, 2, 603, 4666.01488122982, 125, 6, false, '2023-09-27 12:47:44.567811', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '879854654', 2023, 2, 151, 4203.77580072082, 125, 12, false, '2023-09-27 12:47:44.567811', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '873775499', 2023, 2, 191, 9734.93896404307, 125, 19, false, '2023-09-27 12:47:44.567811', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '875055030', 2023, 2, 935, 9246.03299485943, 125, 16, false, '2023-09-27 12:47:44.571817', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '815969576', 2023, 2, 597, 9129.55845270543, 125, 6, false, '2023-09-27 12:47:44.571817', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '881921956', 2023, 2, 932, 6470.89379366874, 125, 4, false, '2023-09-27 12:47:44.571817', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '849890085', 2023, 2, 341, 883.383250174664, 125, 2, false, '2023-09-27 12:47:44.575923', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '826229102', 2023, 2, 581, 2683.98637525003, 125, 12, false, '2023-09-27 12:47:44.575923', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '836656384', 2023, 2, 217, 7421.29933741096, 125, 19, false, '2023-09-27 12:47:44.575923', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '888666767', 2023, 2, 938, 5173.34291509013, 125, 1, false, '2023-09-27 12:47:44.580075', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '876273225', 2023, 2, 870, 9204.98312438181, 125, 17, false, '2023-09-27 12:47:44.580075', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '828273134', 2023, 2, 778, 8799.77291744896, 125, 9, false, '2023-09-27 12:47:44.580075', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '875963341', 2023, 2, 356, 4304.89710983402, 125, 7, false, '2023-09-27 12:47:44.584786', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '868652293', 2023, 2, 218, 8973.61574168529, 125, 2, false, '2023-09-27 12:47:44.584786', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '883630024', 2023, 2, 818, 2016.46856221354, 125, 3, false, '2023-09-27 12:47:44.584786', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '840784333', 2023, 2, 49, 2734.68652656527, 125, 3, false, '2023-09-27 12:47:44.584786', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '808962472', 2023, 2, 362, 9366.98349555823, 125, 16, false, '2023-09-27 12:47:44.589865', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '814148414', 2023, 2, 245, 7812.32005487307, 125, 12, false, '2023-09-27 12:47:44.589865', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '831273899', 2023, 2, 370, 791.002958655918, 125, 17, false, '2023-09-27 12:47:44.589865', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '891530477', 2023, 2, 283, 6782.00932229304, 125, 6, false, '2023-09-27 12:47:44.589865', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '828050340', 2023, 2, 548, 3599.95085041006, 125, 1, false, '2023-09-27 12:47:44.594855', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '852320416', 2023, 2, 56, 6060.67141192803, 125, 2, false, '2023-09-27 12:47:44.594855', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '888715453', 2023, 2, 374, 6067.43999249505, 125, 20, false, '2023-09-27 12:47:44.594855', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '851324073', 2023, 2, 161, 5241.56814969452, 125, 16, false, '2023-09-27 12:47:44.594855', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '860093107', 2023, 2, 242, 4257.43313557519, 125, 13, false, '2023-09-27 12:47:44.600236', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '871363593', 2023, 2, 458, 3763.90468557074, 125, 5, false, '2023-09-27 12:47:44.600236', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '871257202', 2023, 2, 882, 9134.15321347897, 125, 13, false, '2023-09-27 12:47:44.600236', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (533, '897037627', 2023, 2, 250, 6802.27291107083, 125, 4, false, '2023-09-27 12:47:44.600236', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (534, '880765618', 2023, 2, 250, 1304.64451578277, 125, 14, false, '2023-09-27 12:47:44.600236', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 3743.37755864732, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.713878', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (2, '987654321', 3743.37755864732, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.722448', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 12515.4289527688, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.728118', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (4, '123456789', 12515.4289527688, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.736709', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '555555555', 1257.42997487114, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.736709', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '811182048', 30621.3316158088, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.736709', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (7, '811182048', 30621.3316158088, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.749653', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '840722400', 1968.37486616591, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.749653', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (9, '840722400', 1968.37486616591, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.757445', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '850055501', 8170.42862895368, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.757445', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (11, '850055501', 8170.42862895368, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.757445', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '849969854', 14993.0720097073, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.757445', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (13, '849969854', 14993.0720097073, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.757445', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '314159265', 4000000, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.767812', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '314159265', 4000000, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.767812', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '314159265', 4000000, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.775048', 4, 2022);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '314159265', 4000000, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.775048', 3, 2022);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '314159265', 4000000, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.775048', 2, 2022);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '314159265', 4000000, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.775048', 1, 2022);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '314159265', 4000000, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.782959', 4, 2021);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '314159265', 4000000, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.782959', 3, 2021);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '314159265', 4000000, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.787727', 2, 2021);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '314159265', 4000000, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.787727', 1, 2021);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '314159265', 4000000, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.787727', 4, 2020);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '314159265', 4000000, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.792762', 3, 2020);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '314159265', 4000000, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.792762', 2, 2020);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '314159265', 4000000, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.798701', 1, 2020);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '314159265', 4000000, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.798701', 4, 2019);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '314159265', 4000000, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.798701', 3, 2019);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '314159265', 4000000, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.806036', 2, 2019);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '314159265', 4000000, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.806036', 1, 2019);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '314159265', 4000000, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.806036', 4, 2018);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '314159265', 4000000, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.814436', 3, 2018);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '898568539', 9878.24985247735, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.814436', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '866372238', 13120.8661432534, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.814436', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '859120802', 39350.1876056458, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.821583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '889775768', 36563.0390480579, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.821583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '876874244', 23112.6414570987, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.821583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '801893521', 18694.8170680455, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.821583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '863680164', 20176.895780523, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.829842', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '819118552', 34173.2000859146, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.829842', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '874703007', 27873.4508884708, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.829842', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '874032760', 10116.8450016205, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.829842', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '889640472', 21163.2812964917, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.8362', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '812445451', 3551.16384806079, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.8362', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '881652601', 10925.7516061429, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.8362', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '840294166', 17059.8099302963, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.8362', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '831005379', 37459.4702698515, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.845142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '859475383', 1622.28808510852, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.845142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '859968102', 34066.5827467694, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.845142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '892271961', 18280.8092008654, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.850864', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '815902884', 17084.5292252726, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.850864', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '893844214', 16179.8805887084, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.850864', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '888955021', 22600.0120224302, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.850864', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '899964365', 29065.501874424, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.856738', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '891511936', 30474.5360333372, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.856738', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '856069557', 25559.5082949444, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.856738', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '841089736', 29955.6496457742, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.862835', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '849316102', 29977.2537042337, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.862835', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '807178210', 32487.0295028707, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.869628', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '894005613', 16764.2650262362, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.869628', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '800354007', 15520.4753924464, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.869628', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '873447217', 35551.0463462293, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.875887', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '827719376', 37877.780539757, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.875887', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '801899164', 28704.0843295788, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.875887', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '803680044', 31812.9299551652, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.881776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '873219231', 32924.7686131565, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.881776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '849116035', 2454.62072968909, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.881776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '809268073', 21595.9954273942, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.881776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '845364138', 23773.7559114325, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.889846', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '864517784', 31556.3839682296, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.889846', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '865104598', 1928.36476080384, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.896277', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '885532801', 20713.6329911729, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.896277', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '805316453', 27026.1917566057, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.902777', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '864854816', 22064.974287787, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.902777', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '843327651', 37827.679696364, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.909663', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '899360493', 11956.983531468, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.909663', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '874033135', 22898.1613509305, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.915129', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '814749111', 36010.1612587322, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.915129', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '830385063', 30562.3476447997, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.922947', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '878971159', 24366.4003557191, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.922947', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '860901626', 7214.72013140337, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.929776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '831397838', 36861.6570349999, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.929776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '847244539', 34846.216924578, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.934829', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '840661567', 15060.2324456939, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.934829', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '894138262', 8255.35489290211, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.939968', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '899951745', 1285.57113157991, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.939968', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '804978457', 27915.2554812914, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.939968', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '863449910', 1887.43528586492, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.945841', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '817066902', 15189.7330243497, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.950926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '853507323', 24750.1347054681, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.950926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '807861681', 7778.59426031861, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.950926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '835520579', 5632.87133601846, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.950926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '880044215', 7234.65077762398, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.958278', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '887813790', 2878.04172018951, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.958278', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '879629361', 1348.8793276523, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.958278', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '834856071', 19897.085235693, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.958278', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '839737952', 26308.0536726147, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.965135', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '879454278', 15715.2149390989, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.965135', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '869375251', 21499.8158715255, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.965135', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '891737001', 12173.1690600721, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.972286', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '859548768', 26191.9369360092, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.972286', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '815557877', 21657.0311221276, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.972286', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '823964468', 34937.0508014262, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.972286', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '801260955', 28907.7748653034, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.977899', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '853901628', 16217.4075020201, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.977899', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '818012422', 17076.5781612435, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.977899', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '886701339', 13585.9501244316, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.977899', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '890766677', 23288.2641115375, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.977899', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '885562121', 314.73252847597, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.985369', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '883179502', 20637.3485637009, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.985369', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '889252671', 20287.0344405795, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.99054', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '891631136', 32885.7535415979, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.99054', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '834133138', 12243.5179471463, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.99054', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '865105026', 32597.0525085343, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.99054', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '852802807', 7677.38144717857, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.996353', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '895455206', 8057.5059770547, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:43.996353', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '811687458', 12363.4888198055, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.003117', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '886254610', 343.566455964053, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.003117', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '809987579', 21558.7127728803, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.003117', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '813975560', 24058.7808155754, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.014393', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '811878131', 11441.8715173061, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.014393', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '834633239', 23809.3632114403, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.014393', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '807088266', 32986.9768033261, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.020806', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '868616982', 20103.1731518873, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.020806', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '800980006', 29568.0023879393, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.020806', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '833729664', 12845.5905157157, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.020806', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '896185369', 4894.47033264086, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.020806', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '821487814', 31987.6465334173, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.031013', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '843937221', 13661.6311296293, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.031013', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '891365018', 1477.88239756416, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.038851', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '802562418', 6000.50326941869, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.038851', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '813482591', 24481.1309296208, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.038851', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '882864445', 39221.1597675476, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.047141', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '805723557', 37587.4684461006, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.047141', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '848182062', 25183.0416359084, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.047141', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '846089389', 20433.4871705443, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.054723', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '823333463', 36249.3617166309, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.054723', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '884296653', 39624.5014911021, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.054723', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '852903645', 17717.8462423752, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.06128', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '855109592', 28236.081915594, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.06128', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '854029304', 22405.8922213267, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.06128', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '886855095', 27513.1980812892, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.067185', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '841216202', 14686.9889712558, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.067185', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '877836474', 9845.52970060878, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.072869', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '872323946', 25409.0537714475, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.072869', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '884669989', 10422.7534689699, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.079377', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '810175795', 25416.7447419354, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.079377', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '818541433', 2453.81608604293, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.079377', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '844733792', 22501.9506627183, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.079377', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '894287440', 29716.9593085037, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.079377', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '823854289', 29998.0076139259, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.084446', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '890614908', 35074.3673586389, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.084446', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '883449489', 21783.7081175053, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.084446', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '868953993', 16611.2422702279, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.084446', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '833164615', 23937.1177032943, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.084446', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '800638435', 39601.1055446223, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.089481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '877683292', 30635.8930255457, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.089481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '844806430', 35813.3496225314, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.089481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '856883898', 3202.02270404154, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.089481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '834146586', 15561.857761791, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.098007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '827963000', 10743.081576753, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.098007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '858766933', 7358.2632106619, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.098007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '894120846', 7250.03536079367, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.104579', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '830813886', 7519.56534158974, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.104579', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '826165178', 11609.215601131, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.104579', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '860614631', 7376.6297791484, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.104579', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '843914504', 7075.18569008561, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.104579', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '841947707', 4607.78680409982, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.104579', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '805615372', 1600.15268399867, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.111277', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '855472907', 14604.6285542575, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.111277', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '868639863', 22279.0706032823, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.111277', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '834233785', 3312.71033228968, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.111277', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '879831802', 11651.5562332055, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.111277', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '898624492', 1892.51865357837, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.111277', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '814314954', 17215.5982572197, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.11892', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '896667526', 31264.1438494744, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.11892', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '852100041', 29383.0563128421, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.11892', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '846329059', 12588.610321245, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.12708', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '800659646', 26068.175692018, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.12708', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '805635075', 8898.973241521, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.12708', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '886851700', 9693.71499216881, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.12708', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '819215747', 14679.1571071864, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.131884', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '889934227', 15062.4763788274, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.131884', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '809175925', 27745.9062009701, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.131884', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '864642931', 39502.0146194499, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.131884', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '824353904', 19560.2467057996, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.131884', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '843768332', 21508.1535102023, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.131884', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '885079195', 24071.4874035671, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.131884', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '832026215', 17029.3609692134, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.138604', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '853841661', 12611.5091923085, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.138604', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '899112450', 3149.15285032385, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.138604', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '859728672', 8969.61511727001, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.142818', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '853818812', 12909.2238080887, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.142818', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '854847475', 20485.8986135406, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.142818', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '837305547', 18750.5825967836, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.142818', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '840094865', 32536.5048711747, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.14841', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '811106611', 8952.95671972493, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.14841', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '837617427', 31785.3654362552, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.153187', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '858954736', 20980.7322595526, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.153187', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '816700668', 12937.7368296064, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.158181', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '808873241', 38424.2365625907, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.158181', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '866010559', 39061.7059125055, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.158181', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '865998380', 13109.6974342828, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.158181', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '854928401', 1355.425888701, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.158181', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '838426366', 4864.40937141289, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.164456', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '856053536', 12729.1205999385, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.164456', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '824710122', 26590.3020380654, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.164456', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '800262179', 12464.2141078385, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.172591', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '847111097', 1272.87221687669, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.172591', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '844866931', 17237.8567508929, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.172591', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '840864548', 14590.0837182665, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.172591', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '853833870', 15606.2789724747, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.172591', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '863704750', 18164.887282859, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.172591', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '850178064', 1789.22702651511, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.178691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '899217988', 38402.483231351, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.178691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '835011792', 38130.7655138019, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.178691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '820364254', 22454.0719084166, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.178691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '842192029', 35790.1331863133, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.178691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '819466878', 7370.10187107157, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.178691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '873475613', 35369.2459796628, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.178691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '858314589', 31126.6689187589, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.185395', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '895875589', 15670.1361580838, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.185395', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '805387170', 26760.1689073114, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.185395', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '815068004', 28339.2016344409, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.185395', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '830053040', 25268.9440245924, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.190904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '808340802', 11211.1778059846, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.190904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '881022152', 15707.4213271935, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.190904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '827674772', 6347.84238166537, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.190904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '846054241', 35931.0211215046, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.190904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '806691308', 14937.5478871733, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.190904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '865320028', 28392.8905815031, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.196845', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '846023615', 28525.5260065668, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.196845', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '822824963', 1848.68221270467, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.196845', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '889997531', 23525.5517677786, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.196845', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '848189078', 37361.8212258178, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.196845', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '876267524', 20731.3521298682, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.202217', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '833510033', 20518.6702123726, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.202217', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '819898599', 6336.63740948418, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.202217', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '889987138', 2183.43363337596, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.202217', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '853001877', 35895.1134699409, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.202217', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '814999762', 30617.8516038914, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.202217', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '891298662', 21710.2011939881, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.206602', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '817529789', 2550.61331248444, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.206602', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '803984268', 22918.4401842533, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.206602', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '820592381', 5136.04815222707, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.206602', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '897972546', 1557.86397120957, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.211598', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '875062733', 29856.332597504, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.211598', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '852700091', 19100.0096850062, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.211598', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '815185914', 14224.7658060686, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.211598', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '834693586', 15911.8737535354, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.216041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '855109755', 23179.7813870578, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.216041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '849276543', 23818.1406085807, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.216041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '820510385', 21674.314660946, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.216041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '832442866', 27602.1276811561, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.216041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '868527173', 22631.2596416745, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.221407', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '896537965', 560.62153940147, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.221407', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '869765393', 20761.227099797, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.221407', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '878631146', 23042.9121290338, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.221407', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '893022828', 37367.0390353293, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.227549', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '870488667', 13572.3082840086, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.227549', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '885693391', 28726.400953837, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.227549', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '877588354', 16385.2692329182, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.227549', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '835353921', 33621.5705546445, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.227549', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '862576386', 37889.9094479277, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.232672', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '855839558', 21702.1101716862, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.232672', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '877306625', 28768.1724295174, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.232672', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '857990940', 38851.7586589837, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.232672', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '855059723', 34379.5609673963, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.232672', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '832427770', 30183.1669597875, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.232672', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '832190627', 21587.457960539, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.238162', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '892239323', 8612.45075745405, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.238162', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '899413636', 15209.8115505968, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.238162', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '804944614', 18141.0087734012, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.238162', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '890674385', 24470.4995430106, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.243538', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '803393633', 39979.4425597192, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.243538', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '824106789', 2002.70986169065, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.243538', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '882122217', 5754.36008346513, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.243538', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '859439629', 30543.4639571912, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.243538', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '816467453', 3813.91872256721, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.249197', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '895579410', 28059.7996653522, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.249197', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '816662201', 11814.0195049169, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.249197', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '852642017', 32768.4444157585, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.249197', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '856716152', 15182.4499565331, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.249197', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '855383952', 19345.3965763701, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.254867', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '802584307', 21634.650739309, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.254867', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '827140608', 19991.2132471644, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.254867', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '882331842', 18888.2640341497, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.254867', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '801619866', 19510.3523109698, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.260544', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '825030543', 27329.5355951021, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.260544', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '861837698', 27863.6833474151, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.260544', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '829811962', 38109.2628773065, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.260544', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '822242899', 39388.7057589031, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.265766', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '855141426', 29346.3001441622, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.265766', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '864311384', 30750.5037834073, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.265766', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '830236604', 2530.97182881967, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.265766', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '836452543', 24056.2959591827, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.265766', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '892225109', 25280.5673191035, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.271768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '810762223', 27936.6333987205, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.271768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '837437935', 15216.6210479022, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.271768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '815177890', 34386.8348379018, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.271768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '802444869', 15968.3239475181, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.271768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '846357403', 37786.5201435571, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.277479', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '894125644', 308.402586607989, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.277479', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '860079548', 10950.6749080786, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.277479', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '850727134', 29896.9385482094, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.282936', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '897600352', 30512.3230084094, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.282936', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '865176224', 15858.5004527617, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.282936', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '841023274', 32986.1188651176, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.282936', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '858767970', 12021.93849689, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.282936', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '815013773', 5258.79778206239, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.29201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '806551335', 33897.1324947101, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.29201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '862063648', 31046.41655391, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.29201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '829511190', 32227.4511638307, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.29201', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '890504212', 39579.7780378481, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.297514', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '839750510', 27176.3426001086, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.297514', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '859077713', 16109.8842572296, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.297514', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '807085015', 26979.0626477075, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.297514', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '820154219', 1713.31395639567, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.297514', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '854770517', 11775.3538702316, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.297514', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '855050206', 27087.6941686568, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.297514', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '889128185', 30666.3283592989, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.30427', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '806386500', 28402.6727381681, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.30427', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '866865790', 8553.7200931424, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.30427', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '823546398', 36645.0467939676, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.30427', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '809817182', 26882.7403898699, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.30427', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '886965332', 10701.1933022875, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.310624', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '837006317', 12124.5919224134, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.310624', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '859791871', 26897.8818311409, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.310624', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '839648076', 35174.9614369903, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.310624', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '886374702', 20990.4027303477, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.310624', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '801018012', 35814.8867714919, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.317373', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '874911010', 29298.344988167, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.317373', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '879283512', 34379.421432663, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.317373', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '811427024', 4410.48164493815, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.317373', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '866768166', 16735.0561171258, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.317373', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '808374138', 13616.1497598203, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.317373', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '892584778', 10856.7765682525, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.324021', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '890289304', 19304.1703306274, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.324021', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '897993099', 6452.16650828589, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.324021', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '838203900', 17143.1177783006, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.324021', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '820357215', 13843.3354969621, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.324021', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '825011425', 39602.1169583192, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.329906', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '858637744', 4774.75711858539, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.329906', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '807877858', 3668.60017144866, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.329906', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '856450848', 1031.83033786923, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.335058', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '899941610', 16734.759520708, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.335058', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '811875102', 10457.1827296609, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.335058', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '879885713', 11479.6245688817, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.335058', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '885482062', 11045.2431689396, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.335058', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '866886570', 19675.8954651871, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.341646', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '890616652', 38008.9240545948, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.341646', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '862722287', 4376.34674752335, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.341646', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '886375261', 14614.3134076621, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.341646', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '896357373', 35781.7322105794, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.341646', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '866677637', 33441.5803818101, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.347916', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '850099558', 13417.927387967, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.347916', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '859820298', 35745.9890958539, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.347916', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '888812048', 9589.76700254549, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.347916', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '821080096', 3787.02135896518, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.353067', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '898108054', 14287.0052224529, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.353067', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '842021484', 24945.3736527896, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.353067', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '880853424', 34227.6080401197, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.353067', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '833088737', 7035.60910482577, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.353067', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '824370623', 31025.3662125502, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.359631', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '859886502', 39695.8787610753, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.359631', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '881709672', 14208.1881459191, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.365133', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '878183875', 2169.80596787554, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.365133', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '871061073', 27478.8978254269, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.365133', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '834151829', 13746.8059960588, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.365133', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '895917367', 15311.4815360963, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.365133', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '884414162', 33950.1259894342, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.370807', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '859150008', 1780.53439026634, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.370807', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '896355742', 3044.64230552299, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.370807', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '800747683', 19870.3967932036, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.370807', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '857037705', 31835.153885607, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.376034', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '897975138', 28492.7125045979, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.376034', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '807173400', 17474.9056445991, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.376034', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '853864887', 28857.0285305618, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.383202', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '844632422', 31887.0614735476, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.383202', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '844666006', 15015.1525503387, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.383202', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '802555928', 36897.9715522119, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.383202', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '816641469', 399.745156311613, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.388416', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '878284938', 2025.96099848759, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.388416', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '833167762', 6050.02921424099, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.388416', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '852738491', 33664.3954602774, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.388416', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '854600919', 22738.2517492037, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.388416', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '891686706', 24156.4644675245, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.388416', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '800994018', 2855.87510839996, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.388416', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '885343199', 24173.4059763994, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.388416', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '814097367', 18947.7671184417, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.395262', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '855405477', 14133.2144009307, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.395262', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '871110892', 30377.5533574218, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.395262', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '889302409', 38253.5290976734, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.395262', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '862650554', 28217.363968329, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.400606', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '856323024', 12505.4109419752, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.400606', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '865957763', 6126.94752153996, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.400606', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '809997464', 38802.4219068723, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.400606', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '892037204', 32562.7880055143, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.400606', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '855209391', 37270.4406616012, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.400606', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '852675187', 35664.5299809084, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.40653', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '875190936', 2597.77104694003, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.40653', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '878772022', 15890.9624924231, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.40653', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '875906777', 39870.7948988742, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.40653', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '867050630', 11647.521103569, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.412473', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '899626977', 8295.12112219001, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.412473', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '847716706', 10111.53963356, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.412473', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '819302627', 39961.290734957, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.417364', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '886536405', 30399.5317983786, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.417364', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '861719015', 28974.9438852421, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.417364', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '858181803', 10099.1552936425, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.417364', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '896147751', 11383.3395147278, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.417364', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '825362503', 3501.42979575563, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.422737', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '873037031', 23361.8126110039, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.422737', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '808933296', 20352.4040688781, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.426837', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '856311115', 39486.1100055014, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.426837', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '841062282', 19959.4139908568, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.43103', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '839896151', 28406.1821705202, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.438407', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '808119254', 25709.3440090608, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.443027', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '868411463', 3802.52663667927, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.443027', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '845923614', 6587.54679074892, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.446743', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '879136681', 32020.9101288263, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.446743', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '849262935', 24836.8200590625, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.451511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '806920595', 26838.6345126556, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.451511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '880756394', 2587.69127854666, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.451511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '880104024', 258.450523130846, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.451511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '801556211', 17937.8631253197, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.451511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '819264022', 39266.1149488385, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.457004', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '848716349', 26602.289604882, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.457004', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '825277344', 26136.7407500604, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.457004', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '819827494', 24423.1446332026, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.457004', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '846662600', 6985.39739008521, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.462221', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '874024359', 12358.1314523944, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.462221', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '821366281', 9777.42545019184, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.462221', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '808210382', 22070.6247740516, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.466803', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '826428237', 30630.8909625125, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.466803', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '815054956', 18754.9538196977, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.471396', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '818328814', 25580.9673550025, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.471396', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '807556210', 25203.497656484, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.471396', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '871418690', 23504.8909258687, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.476063', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '813082052', 4850.90996857021, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.480525', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '806846003', 27706.0561478928, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.480525', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '824330847', 35000.4863888305, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.480525', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '826690138', 17619.7050287703, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.480525', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '856403693', 19834.9656707004, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.485819', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '816621697', 16358.6254703383, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.485819', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '816554758', 8332.35531440334, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.485819', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '857535371', 24628.8506453384, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.485819', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '823784313', 1457.94653933268, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.490727', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '891396939', 18086.5601805415, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.490727', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '890803412', 10542.1734320481, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.490727', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '864310341', 21465.696665779, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.490727', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '852154283', 1079.64205526752, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.490727', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '845274259', 17814.5939786466, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.496054', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '845587063', 23296.1708832714, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.496054', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '827331930', 1350.58237287541, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.496054', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '869238003', 34953.4228418946, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.496054', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '852723183', 7004.58443155857, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.503583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '815069674', 27961.4926730367, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.503583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '824320547', 1767.97733535559, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.503583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '858685635', 9407.22340990353, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.503583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '829626868', 24722.0970822734, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.508923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '869197746', 46.4079594708268, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.508923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '896311843', 24164.3407018404, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.508923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '872643712', 4349.06533963422, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.508923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '829662663', 19310.1587578411, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.508923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '845972124', 28979.3327041298, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.51481', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '848464680', 19125.4978083022, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.519139', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '820268569', 16190.1355053831, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.519139', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '820015256', 32972.3029460149, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.519139', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '844573903', 37750.3651131456, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.519139', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '882085748', 5627.86735977196, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.519139', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '867428946', 10529.5419987284, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.524477', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '871031437', 19436.3752386984, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.524477', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '843532169', 31702.9277909423, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.528695', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '857146415', 20379.736480314, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.528695', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '858809768', 6759.87152658423, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.528695', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '876716164', 15762.6962119996, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.528695', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '819492088', 25779.3255174942, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.528695', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '838239624', 24759.8899645643, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.528695', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '885945837', 2944.85332393025, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.534985', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '861498828', 36736.1741859789, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.534985', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '801804711', 8737.52147136842, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.534985', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '833509017', 24277.0908108772, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.540243', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '827952461', 38815.0609343567, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.540243', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '899971016', 38005.4468245778, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.540243', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '851522918', 25885.8136666433, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.540243', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '876958842', 299.53796589689, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.540243', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '800056603', 15371.3671001809, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.540243', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '843586867', 6723.0522826039, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.547013', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '823345513', 22402.4997137043, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.547013', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '848090389', 39047.5823949066, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.552155', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '813124156', 37634.3327767609, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.552155', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '806937760', 33793.5967280931, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.552155', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '804492254', 37007.2696585766, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.552155', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '850961994', 18984.5443830471, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.552155', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '811452235', 7929.40587623901, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.557958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '800196588', 23681.2536979825, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.557958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '824251872', 15357.993959716, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.557958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '805680022', 20785.3133403029, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.557958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '802238763', 26701.6622659765, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.557958', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '897656556', 10693.9611984292, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.562826', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '888995913', 6552.69758832176, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.562826', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '867259951', 15027.5082342059, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.562826', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '820227377', 20285.8448959665, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.562826', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '882903192', 18664.0595249193, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.567308', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '879854654', 16815.1032028833, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.567308', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '873775499', 38939.7558561723, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.567308', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '875055030', 36984.1319794377, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.57129', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '815969576', 36518.2338108217, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.57129', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '881921956', 25883.575174675, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.57129', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '849890085', 3533.53300069865, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.575159', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '826229102', 10735.9455010001, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.575159', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '836656384', 29685.1973496439, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.575159', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '888666767', 20693.3716603605, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.579429', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '876273225', 36819.9324975272, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.579429', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '828273134', 35199.0916697958, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.579429', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '875963341', 17219.5884393361, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.584007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '868652293', 35894.4629667411, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.584007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '883630024', 8065.87424885416, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.584007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '840784333', 10938.7461062611, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.584007', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '808962472', 37467.9339822329, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.588581', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '814148414', 31249.2802194923, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.588581', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '831273899', 3164.01183462367, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.588581', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '891530477', 27128.0372891722, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.588581', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '828050340', 14399.8034016402, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.593839', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '852320416', 24242.6856477121, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.593839', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '888715453', 24269.7599699802, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.593839', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '851324073', 20966.2725987781, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.593839', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '860093107', 17029.7325423007, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.598987', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '871363593', 15055.6187422829, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.598987', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '871257202', 36536.6128539159, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.598987', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (533, '897037627', 27209.0916442833, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.598987', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (534, '880765618', 5218.57806313109, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-27 12:47:44.598987', 2, 2023);


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2023-01-01', 987654322, '2023-09-27 12:47:42.393532', '2023-09-27 12:47:42.393532');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2023-01-01', 123456790, '2023-09-27 12:47:42.403244', '2023-09-27 12:47:42.403244');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2023-01-01', 555555556, '2023-09-27 12:47:42.409879', '2023-09-27 12:47:42.409879');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2023-01-01', 666666667, '2023-09-27 12:47:42.411667', '2023-09-27 12:47:42.411667');
INSERT INTO public.virksomhet VALUES (5, '842976714', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842976714', '{adresse}', 'AKTIV', '2023-01-01', 842976715, '2023-09-27 12:47:42.422345', '2023-09-27 12:47:42.422345');
INSERT INTO public.virksomhet VALUES (6, '811182048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811182048', '{adresse}', 'AKTIV', '2023-01-01', 811182049, '2023-09-27 12:47:42.424048', '2023-09-27 12:47:42.424048');
INSERT INTO public.virksomhet VALUES (7, '840722400', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840722400', '{adresse}', 'AKTIV', '2023-01-01', 840722401, '2023-09-27 12:47:42.42512', '2023-09-27 12:47:42.42512');
INSERT INTO public.virksomhet VALUES (8, '850055501', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850055501', '{adresse}', 'AKTIV', '2023-01-01', 850055502, '2023-09-27 12:47:42.426157', '2023-09-27 12:47:42.426157');
INSERT INTO public.virksomhet VALUES (9, '849969854', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849969854', '{adresse}', 'AKTIV', '2023-01-01', 849969855, '2023-09-27 12:47:42.427122', '2023-09-27 12:47:42.427122');
INSERT INTO public.virksomhet VALUES (10, '314159265', 'Norge', 'NO', '1234', 'POSTSTED', 'Sandnes', '1108', 'Virksomhet med historisk statistikk', '{"Langgata 1"}', 'AKTIV', '2023-01-01', 314159266, '2023-09-27 12:47:42.428835', '2023-09-27 12:47:42.428835');
INSERT INTO public.virksomhet VALUES (11, '898568539', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898568539', '{adresse}', 'AKTIV', '2023-01-01', 898568540, '2023-09-27 12:47:42.429795', '2023-09-27 12:47:42.429795');
INSERT INTO public.virksomhet VALUES (12, '866372238', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866372238', '{adresse}', 'AKTIV', '2023-01-01', 866372239, '2023-09-27 12:47:42.430727', '2023-09-27 12:47:42.430727');
INSERT INTO public.virksomhet VALUES (13, '859120802', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859120802', '{adresse}', 'AKTIV', '2023-01-01', 859120803, '2023-09-27 12:47:42.431445', '2023-09-27 12:47:42.431445');
INSERT INTO public.virksomhet VALUES (14, '889775768', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889775768', '{adresse}', 'AKTIV', '2023-01-01', 889775769, '2023-09-27 12:47:42.437433', '2023-09-27 12:47:42.437433');
INSERT INTO public.virksomhet VALUES (15, '876874244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876874244', '{adresse}', 'AKTIV', '2023-01-01', 876874245, '2023-09-27 12:47:42.438771', '2023-09-27 12:47:42.438771');
INSERT INTO public.virksomhet VALUES (16, '801893521', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801893521', '{adresse}', 'AKTIV', '2023-01-01', 801893522, '2023-09-27 12:47:42.439557', '2023-09-27 12:47:42.439557');
INSERT INTO public.virksomhet VALUES (17, '863680164', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863680164', '{adresse}', 'AKTIV', '2023-01-01', 863680165, '2023-09-27 12:47:42.445176', '2023-09-27 12:47:42.445176');
INSERT INTO public.virksomhet VALUES (18, '819118552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819118552', '{adresse}', 'AKTIV', '2023-01-01', 819118553, '2023-09-27 12:47:42.446626', '2023-09-27 12:47:42.446626');
INSERT INTO public.virksomhet VALUES (19, '874703007', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874703007', '{adresse}', 'AKTIV', '2023-01-01', 874703008, '2023-09-27 12:47:42.448239', '2023-09-27 12:47:42.448239');
INSERT INTO public.virksomhet VALUES (20, '874032760', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874032760', '{adresse}', 'AKTIV', '2023-01-01', 874032761, '2023-09-27 12:47:42.449499', '2023-09-27 12:47:42.449499');
INSERT INTO public.virksomhet VALUES (21, '889640472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889640472', '{adresse}', 'AKTIV', '2023-01-01', 889640473, '2023-09-27 12:47:42.450738', '2023-09-27 12:47:42.450738');
INSERT INTO public.virksomhet VALUES (22, '812445451', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812445451', '{adresse}', 'AKTIV', '2023-01-01', 812445452, '2023-09-27 12:47:42.45195', '2023-09-27 12:47:42.45195');
INSERT INTO public.virksomhet VALUES (23, '881652601', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881652601', '{adresse}', 'AKTIV', '2023-01-01', 881652602, '2023-09-27 12:47:42.453045', '2023-09-27 12:47:42.453045');
INSERT INTO public.virksomhet VALUES (24, '840294166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840294166', '{adresse}', 'AKTIV', '2023-01-01', 840294167, '2023-09-27 12:47:42.453926', '2023-09-27 12:47:42.453926');
INSERT INTO public.virksomhet VALUES (25, '831005379', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831005379', '{adresse}', 'AKTIV', '2023-01-01', 831005380, '2023-09-27 12:47:42.454926', '2023-09-27 12:47:42.454926');
INSERT INTO public.virksomhet VALUES (26, '859475383', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859475383', '{adresse}', 'AKTIV', '2023-01-01', 859475384, '2023-09-27 12:47:42.455994', '2023-09-27 12:47:42.455994');
INSERT INTO public.virksomhet VALUES (27, '859968102', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859968102', '{adresse}', 'AKTIV', '2023-01-01', 859968103, '2023-09-27 12:47:42.463865', '2023-09-27 12:47:42.463865');
INSERT INTO public.virksomhet VALUES (28, '892271961', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892271961', '{adresse}', 'AKTIV', '2023-01-01', 892271962, '2023-09-27 12:47:42.465569', '2023-09-27 12:47:42.465569');
INSERT INTO public.virksomhet VALUES (29, '815902884', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815902884', '{adresse}', 'AKTIV', '2023-01-01', 815902885, '2023-09-27 12:47:42.466727', '2023-09-27 12:47:42.466727');
INSERT INTO public.virksomhet VALUES (30, '893844214', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893844214', '{adresse}', 'AKTIV', '2023-01-01', 893844215, '2023-09-27 12:47:42.467677', '2023-09-27 12:47:42.467677');
INSERT INTO public.virksomhet VALUES (31, '888955021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888955021', '{adresse}', 'AKTIV', '2023-01-01', 888955022, '2023-09-27 12:47:42.473858', '2023-09-27 12:47:42.473858');
INSERT INTO public.virksomhet VALUES (32, '899964365', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899964365', '{adresse}', 'AKTIV', '2023-01-01', 899964366, '2023-09-27 12:47:42.475143', '2023-09-27 12:47:42.475143');
INSERT INTO public.virksomhet VALUES (33, '891511936', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891511936', '{adresse}', 'AKTIV', '2023-01-01', 891511937, '2023-09-27 12:47:42.475928', '2023-09-27 12:47:42.475928');
INSERT INTO public.virksomhet VALUES (34, '856069557', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856069557', '{adresse}', 'AKTIV', '2023-01-01', 856069558, '2023-09-27 12:47:42.478596', '2023-09-27 12:47:42.478596');
INSERT INTO public.virksomhet VALUES (35, '841089736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841089736', '{adresse}', 'AKTIV', '2023-01-01', 841089737, '2023-09-27 12:47:42.480556', '2023-09-27 12:47:42.480556');
INSERT INTO public.virksomhet VALUES (36, '849316102', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849316102', '{adresse}', 'AKTIV', '2023-01-01', 849316103, '2023-09-27 12:47:42.49191', '2023-09-27 12:47:42.49191');
INSERT INTO public.virksomhet VALUES (37, '807178210', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807178210', '{adresse}', 'AKTIV', '2023-01-01', 807178211, '2023-09-27 12:47:42.493892', '2023-09-27 12:47:42.493892');
INSERT INTO public.virksomhet VALUES (38, '894005613', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894005613', '{adresse}', 'AKTIV', '2023-01-01', 894005614, '2023-09-27 12:47:42.496274', '2023-09-27 12:47:42.496274');
INSERT INTO public.virksomhet VALUES (39, '800354007', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800354007', '{adresse}', 'AKTIV', '2023-01-01', 800354008, '2023-09-27 12:47:42.498025', '2023-09-27 12:47:42.498025');
INSERT INTO public.virksomhet VALUES (40, '873447217', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873447217', '{adresse}', 'AKTIV', '2023-01-01', 873447218, '2023-09-27 12:47:42.503896', '2023-09-27 12:47:42.503896');
INSERT INTO public.virksomhet VALUES (41, '827719376', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827719376', '{adresse}', 'AKTIV', '2023-01-01', 827719377, '2023-09-27 12:47:42.505176', '2023-09-27 12:47:42.505176');
INSERT INTO public.virksomhet VALUES (42, '801899164', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801899164', '{adresse}', 'AKTIV', '2023-01-01', 801899165, '2023-09-27 12:47:42.506159', '2023-09-27 12:47:42.506159');
INSERT INTO public.virksomhet VALUES (43, '803680044', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803680044', '{adresse}', 'AKTIV', '2023-01-01', 803680045, '2023-09-27 12:47:42.513014', '2023-09-27 12:47:42.513014');
INSERT INTO public.virksomhet VALUES (44, '873219231', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873219231', '{adresse}', 'AKTIV', '2023-01-01', 873219232, '2023-09-27 12:47:42.514507', '2023-09-27 12:47:42.514507');
INSERT INTO public.virksomhet VALUES (45, '849116035', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849116035', '{adresse}', 'AKTIV', '2023-01-01', 849116036, '2023-09-27 12:47:42.515703', '2023-09-27 12:47:42.515703');
INSERT INTO public.virksomhet VALUES (46, '809268073', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809268073', '{adresse}', 'AKTIV', '2023-01-01', 809268074, '2023-09-27 12:47:42.51672', '2023-09-27 12:47:42.51672');
INSERT INTO public.virksomhet VALUES (47, '845364138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845364138', '{adresse}', 'AKTIV', '2023-01-01', 845364139, '2023-09-27 12:47:42.519147', '2023-09-27 12:47:42.519147');
INSERT INTO public.virksomhet VALUES (48, '864517784', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864517784', '{adresse}', 'AKTIV', '2023-01-01', 864517785, '2023-09-27 12:47:42.521546', '2023-09-27 12:47:42.521546');
INSERT INTO public.virksomhet VALUES (49, '865104598', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865104598', '{adresse}', 'AKTIV', '2023-01-01', 865104599, '2023-09-27 12:47:42.523561', '2023-09-27 12:47:42.523561');
INSERT INTO public.virksomhet VALUES (50, '885532801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885532801', '{adresse}', 'AKTIV', '2023-01-01', 885532802, '2023-09-27 12:47:42.525054', '2023-09-27 12:47:42.525054');
INSERT INTO public.virksomhet VALUES (51, '805316453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805316453', '{adresse}', 'AKTIV', '2023-01-01', 805316454, '2023-09-27 12:47:42.526794', '2023-09-27 12:47:42.526794');
INSERT INTO public.virksomhet VALUES (52, '864854816', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864854816', '{adresse}', 'AKTIV', '2023-01-01', 864854817, '2023-09-27 12:47:42.533914', '2023-09-27 12:47:42.533914');
INSERT INTO public.virksomhet VALUES (53, '843327651', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843327651', '{adresse}', 'AKTIV', '2023-01-01', 843327652, '2023-09-27 12:47:42.536693', '2023-09-27 12:47:42.536693');
INSERT INTO public.virksomhet VALUES (54, '899360493', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899360493', '{adresse}', 'AKTIV', '2023-01-01', 899360494, '2023-09-27 12:47:42.5442', '2023-09-27 12:47:42.5442');
INSERT INTO public.virksomhet VALUES (55, '874033135', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874033135', '{adresse}', 'AKTIV', '2023-01-01', 874033136, '2023-09-27 12:47:42.54881', '2023-09-27 12:47:42.54881');
INSERT INTO public.virksomhet VALUES (56, '814749111', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814749111', '{adresse}', 'AKTIV', '2023-01-01', 814749112, '2023-09-27 12:47:42.550659', '2023-09-27 12:47:42.550659');
INSERT INTO public.virksomhet VALUES (57, '830385063', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830385063', '{adresse}', 'AKTIV', '2023-01-01', 830385064, '2023-09-27 12:47:42.552659', '2023-09-27 12:47:42.552659');
INSERT INTO public.virksomhet VALUES (58, '878971159', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878971159', '{adresse}', 'AKTIV', '2023-01-01', 878971160, '2023-09-27 12:47:42.554833', '2023-09-27 12:47:42.554833');
INSERT INTO public.virksomhet VALUES (59, '860901626', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860901626', '{adresse}', 'AKTIV', '2023-01-01', 860901627, '2023-09-27 12:47:42.557403', '2023-09-27 12:47:42.557403');
INSERT INTO public.virksomhet VALUES (60, '831397838', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831397838', '{adresse}', 'AKTIV', '2023-01-01', 831397839, '2023-09-27 12:47:42.559261', '2023-09-27 12:47:42.559261');
INSERT INTO public.virksomhet VALUES (61, '847244539', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847244539', '{adresse}', 'AKTIV', '2023-01-01', 847244540, '2023-09-27 12:47:42.561371', '2023-09-27 12:47:42.561371');
INSERT INTO public.virksomhet VALUES (62, '840661567', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840661567', '{adresse}', 'AKTIV', '2023-01-01', 840661568, '2023-09-27 12:47:42.563792', '2023-09-27 12:47:42.563792');
INSERT INTO public.virksomhet VALUES (63, '894138262', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894138262', '{adresse}', 'AKTIV', '2023-01-01', 894138263, '2023-09-27 12:47:42.573033', '2023-09-27 12:47:42.573033');
INSERT INTO public.virksomhet VALUES (64, '899951745', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899951745', '{adresse}', 'AKTIV', '2023-01-01', 899951746, '2023-09-27 12:47:42.57483', '2023-09-27 12:47:42.57483');
INSERT INTO public.virksomhet VALUES (65, '804978457', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804978457', '{adresse}', 'AKTIV', '2023-01-01', 804978458, '2023-09-27 12:47:42.576195', '2023-09-27 12:47:42.576195');
INSERT INTO public.virksomhet VALUES (66, '863449910', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863449910', '{adresse}', 'AKTIV', '2023-01-01', 863449911, '2023-09-27 12:47:42.577741', '2023-09-27 12:47:42.577741');
INSERT INTO public.virksomhet VALUES (67, '817066902', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817066902', '{adresse}', 'AKTIV', '2023-01-01', 817066903, '2023-09-27 12:47:42.585151', '2023-09-27 12:47:42.585151');
INSERT INTO public.virksomhet VALUES (68, '853507323', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853507323', '{adresse}', 'AKTIV', '2023-01-01', 853507324, '2023-09-27 12:47:42.587496', '2023-09-27 12:47:42.587496');
INSERT INTO public.virksomhet VALUES (69, '807861681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807861681', '{adresse}', 'AKTIV', '2023-01-01', 807861682, '2023-09-27 12:47:42.588878', '2023-09-27 12:47:42.588878');
INSERT INTO public.virksomhet VALUES (70, '835520579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835520579', '{adresse}', 'AKTIV', '2023-01-01', 835520580, '2023-09-27 12:47:42.590541', '2023-09-27 12:47:42.590541');
INSERT INTO public.virksomhet VALUES (71, '880044215', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880044215', '{adresse}', 'AKTIV', '2023-01-01', 880044216, '2023-09-27 12:47:42.592397', '2023-09-27 12:47:42.592397');
INSERT INTO public.virksomhet VALUES (72, '887813790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887813790', '{adresse}', 'AKTIV', '2023-01-01', 887813791, '2023-09-27 12:47:42.594039', '2023-09-27 12:47:42.594039');
INSERT INTO public.virksomhet VALUES (73, '879629361', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879629361', '{adresse}', 'AKTIV', '2023-01-01', 879629362, '2023-09-27 12:47:42.59536', '2023-09-27 12:47:42.59536');
INSERT INTO public.virksomhet VALUES (74, '834856071', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834856071', '{adresse}', 'AKTIV', '2023-01-01', 834856072, '2023-09-27 12:47:42.597192', '2023-09-27 12:47:42.597192');
INSERT INTO public.virksomhet VALUES (75, '839737952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839737952', '{adresse}', 'AKTIV', '2023-01-01', 839737953, '2023-09-27 12:47:42.598732', '2023-09-27 12:47:42.598732');
INSERT INTO public.virksomhet VALUES (76, '879454278', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879454278', '{adresse}', 'AKTIV', '2023-01-01', 879454279, '2023-09-27 12:47:42.604615', '2023-09-27 12:47:42.604615');
INSERT INTO public.virksomhet VALUES (77, '869375251', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869375251', '{adresse}', 'AKTIV', '2023-01-01', 869375252, '2023-09-27 12:47:42.606402', '2023-09-27 12:47:42.606402');
INSERT INTO public.virksomhet VALUES (78, '891737001', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891737001', '{adresse}', 'AKTIV', '2023-01-01', 891737002, '2023-09-27 12:47:42.607935', '2023-09-27 12:47:42.607935');
INSERT INTO public.virksomhet VALUES (79, '859548768', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859548768', '{adresse}', 'AKTIV', '2023-01-01', 859548769, '2023-09-27 12:47:42.609336', '2023-09-27 12:47:42.609336');
INSERT INTO public.virksomhet VALUES (80, '815557877', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815557877', '{adresse}', 'AKTIV', '2023-01-01', 815557878, '2023-09-27 12:47:42.615709', '2023-09-27 12:47:42.615709');
INSERT INTO public.virksomhet VALUES (81, '823964468', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823964468', '{adresse}', 'AKTIV', '2023-01-01', 823964469, '2023-09-27 12:47:42.621485', '2023-09-27 12:47:42.621485');
INSERT INTO public.virksomhet VALUES (82, '801260955', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801260955', '{adresse}', 'AKTIV', '2023-01-01', 801260956, '2023-09-27 12:47:42.62244', '2023-09-27 12:47:42.62244');
INSERT INTO public.virksomhet VALUES (83, '853901628', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853901628', '{adresse}', 'AKTIV', '2023-01-01', 853901629, '2023-09-27 12:47:42.623961', '2023-09-27 12:47:42.623961');
INSERT INTO public.virksomhet VALUES (84, '818012422', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818012422', '{adresse}', 'AKTIV', '2023-01-01', 818012423, '2023-09-27 12:47:42.625247', '2023-09-27 12:47:42.625247');
INSERT INTO public.virksomhet VALUES (85, '886701339', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886701339', '{adresse}', 'AKTIV', '2023-01-01', 886701340, '2023-09-27 12:47:42.627356', '2023-09-27 12:47:42.627356');
INSERT INTO public.virksomhet VALUES (86, '890766677', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890766677', '{adresse}', 'AKTIV', '2023-01-01', 890766678, '2023-09-27 12:47:42.630761', '2023-09-27 12:47:42.630761');
INSERT INTO public.virksomhet VALUES (87, '885562121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885562121', '{adresse}', 'AKTIV', '2023-01-01', 885562122, '2023-09-27 12:47:42.640322', '2023-09-27 12:47:42.640322');
INSERT INTO public.virksomhet VALUES (88, '883179502', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883179502', '{adresse}', 'AKTIV', '2023-01-01', 883179503, '2023-09-27 12:47:42.6425', '2023-09-27 12:47:42.6425');
INSERT INTO public.virksomhet VALUES (89, '889252671', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889252671', '{adresse}', 'AKTIV', '2023-01-01', 889252672, '2023-09-27 12:47:42.643382', '2023-09-27 12:47:42.643382');
INSERT INTO public.virksomhet VALUES (90, '891631136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891631136', '{adresse}', 'AKTIV', '2023-01-01', 891631137, '2023-09-27 12:47:42.645192', '2023-09-27 12:47:42.645192');
INSERT INTO public.virksomhet VALUES (91, '834133138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834133138', '{adresse}', 'AKTIV', '2023-01-01', 834133139, '2023-09-27 12:47:42.65147', '2023-09-27 12:47:42.65147');
INSERT INTO public.virksomhet VALUES (92, '865105026', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865105026', '{adresse}', 'AKTIV', '2023-01-01', 865105027, '2023-09-27 12:47:42.65396', '2023-09-27 12:47:42.65396');
INSERT INTO public.virksomhet VALUES (93, '852802807', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852802807', '{adresse}', 'AKTIV', '2023-01-01', 852802808, '2023-09-27 12:47:42.65542', '2023-09-27 12:47:42.65542');
INSERT INTO public.virksomhet VALUES (94, '895455206', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895455206', '{adresse}', 'AKTIV', '2023-01-01', 895455207, '2023-09-27 12:47:42.662941', '2023-09-27 12:47:42.662941');
INSERT INTO public.virksomhet VALUES (95, '811687458', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811687458', '{adresse}', 'AKTIV', '2023-01-01', 811687459, '2023-09-27 12:47:42.665024', '2023-09-27 12:47:42.665024');
INSERT INTO public.virksomhet VALUES (96, '886254610', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886254610', '{adresse}', 'AKTIV', '2023-01-01', 886254611, '2023-09-27 12:47:42.666801', '2023-09-27 12:47:42.666801');
INSERT INTO public.virksomhet VALUES (97, '809987579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809987579', '{adresse}', 'AKTIV', '2023-01-01', 809987580, '2023-09-27 12:47:42.668151', '2023-09-27 12:47:42.668151');
INSERT INTO public.virksomhet VALUES (98, '813975560', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813975560', '{adresse}', 'AKTIV', '2023-01-01', 813975561, '2023-09-27 12:47:42.675739', '2023-09-27 12:47:42.675739');
INSERT INTO public.virksomhet VALUES (99, '811878131', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811878131', '{adresse}', 'AKTIV', '2023-01-01', 811878132, '2023-09-27 12:47:42.677543', '2023-09-27 12:47:42.677543');
INSERT INTO public.virksomhet VALUES (100, '834633239', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834633239', '{adresse}', 'AKTIV', '2023-01-01', 834633240, '2023-09-27 12:47:42.678915', '2023-09-27 12:47:42.678915');
INSERT INTO public.virksomhet VALUES (101, '807088266', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807088266', '{adresse}', 'AKTIV', '2023-01-01', 807088267, '2023-09-27 12:47:42.680204', '2023-09-27 12:47:42.680204');
INSERT INTO public.virksomhet VALUES (102, '868616982', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868616982', '{adresse}', 'AKTIV', '2023-01-01', 868616983, '2023-09-27 12:47:42.682047', '2023-09-27 12:47:42.682047');
INSERT INTO public.virksomhet VALUES (103, '800980006', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800980006', '{adresse}', 'AKTIV', '2023-01-01', 800980007, '2023-09-27 12:47:42.691606', '2023-09-27 12:47:42.691606');
INSERT INTO public.virksomhet VALUES (104, '833729664', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833729664', '{adresse}', 'AKTIV', '2023-01-01', 833729665, '2023-09-27 12:47:42.693', '2023-09-27 12:47:42.693');
INSERT INTO public.virksomhet VALUES (105, '896185369', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896185369', '{adresse}', 'AKTIV', '2023-01-01', 896185370, '2023-09-27 12:47:42.694359', '2023-09-27 12:47:42.694359');
INSERT INTO public.virksomhet VALUES (106, '821487814', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821487814', '{adresse}', 'AKTIV', '2023-01-01', 821487815, '2023-09-27 12:47:42.695998', '2023-09-27 12:47:42.695998');
INSERT INTO public.virksomhet VALUES (107, '843937221', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843937221', '{adresse}', 'AKTIV', '2023-01-01', 843937222, '2023-09-27 12:47:42.697186', '2023-09-27 12:47:42.697186');
INSERT INTO public.virksomhet VALUES (108, '891365018', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891365018', '{adresse}', 'AKTIV', '2023-01-01', 891365019, '2023-09-27 12:47:42.705244', '2023-09-27 12:47:42.705244');
INSERT INTO public.virksomhet VALUES (109, '802562418', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802562418', '{adresse}', 'AKTIV', '2023-01-01', 802562419, '2023-09-27 12:47:42.707473', '2023-09-27 12:47:42.707473');
INSERT INTO public.virksomhet VALUES (110, '813482591', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813482591', '{adresse}', 'AKTIV', '2023-01-01', 813482592, '2023-09-27 12:47:42.708741', '2023-09-27 12:47:42.708741');
INSERT INTO public.virksomhet VALUES (111, '882864445', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882864445', '{adresse}', 'AKTIV', '2023-01-01', 882864446, '2023-09-27 12:47:42.710508', '2023-09-27 12:47:42.710508');
INSERT INTO public.virksomhet VALUES (112, '805723557', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805723557', '{adresse}', 'AKTIV', '2023-01-01', 805723558, '2023-09-27 12:47:42.71201', '2023-09-27 12:47:42.71201');
INSERT INTO public.virksomhet VALUES (113, '848182062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848182062', '{adresse}', 'AKTIV', '2023-01-01', 848182063, '2023-09-27 12:47:42.718957', '2023-09-27 12:47:42.718957');
INSERT INTO public.virksomhet VALUES (114, '846089389', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846089389', '{adresse}', 'AKTIV', '2023-01-01', 846089390, '2023-09-27 12:47:42.721826', '2023-09-27 12:47:42.721826');
INSERT INTO public.virksomhet VALUES (115, '823333463', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823333463', '{adresse}', 'AKTIV', '2023-01-01', 823333464, '2023-09-27 12:47:42.724981', '2023-09-27 12:47:42.724981');
INSERT INTO public.virksomhet VALUES (116, '884296653', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884296653', '{adresse}', 'AKTIV', '2023-01-01', 884296654, '2023-09-27 12:47:42.725911', '2023-09-27 12:47:42.725911');
INSERT INTO public.virksomhet VALUES (117, '852903645', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852903645', '{adresse}', 'AKTIV', '2023-01-01', 852903646, '2023-09-27 12:47:42.727717', '2023-09-27 12:47:42.727717');
INSERT INTO public.virksomhet VALUES (118, '855109592', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855109592', '{adresse}', 'AKTIV', '2023-01-01', 855109593, '2023-09-27 12:47:42.735449', '2023-09-27 12:47:42.735449');
INSERT INTO public.virksomhet VALUES (119, '854029304', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854029304', '{adresse}', 'AKTIV', '2023-01-01', 854029305, '2023-09-27 12:47:42.738207', '2023-09-27 12:47:42.738207');
INSERT INTO public.virksomhet VALUES (120, '886855095', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886855095', '{adresse}', 'AKTIV', '2023-01-01', 886855096, '2023-09-27 12:47:42.740836', '2023-09-27 12:47:42.740836');
INSERT INTO public.virksomhet VALUES (121, '841216202', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841216202', '{adresse}', 'AKTIV', '2023-01-01', 841216203, '2023-09-27 12:47:42.742467', '2023-09-27 12:47:42.742467');
INSERT INTO public.virksomhet VALUES (122, '877836474', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877836474', '{adresse}', 'AKTIV', '2023-01-01', 877836475, '2023-09-27 12:47:42.750834', '2023-09-27 12:47:42.750834');
INSERT INTO public.virksomhet VALUES (123, '872323946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872323946', '{adresse}', 'AKTIV', '2023-01-01', 872323947, '2023-09-27 12:47:42.753197', '2023-09-27 12:47:42.753197');
INSERT INTO public.virksomhet VALUES (124, '884669989', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884669989', '{adresse}', 'AKTIV', '2023-01-01', 884669990, '2023-09-27 12:47:42.755082', '2023-09-27 12:47:42.755082');
INSERT INTO public.virksomhet VALUES (125, '810175795', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810175795', '{adresse}', 'AKTIV', '2023-01-01', 810175796, '2023-09-27 12:47:42.757979', '2023-09-27 12:47:42.757979');
INSERT INTO public.virksomhet VALUES (126, '818541433', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818541433', '{adresse}', 'AKTIV', '2023-01-01', 818541434, '2023-09-27 12:47:42.759953', '2023-09-27 12:47:42.759953');
INSERT INTO public.virksomhet VALUES (127, '844733792', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844733792', '{adresse}', 'AKTIV', '2023-01-01', 844733793, '2023-09-27 12:47:42.769507', '2023-09-27 12:47:42.769507');
INSERT INTO public.virksomhet VALUES (128, '894287440', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894287440', '{adresse}', 'AKTIV', '2023-01-01', 894287441, '2023-09-27 12:47:42.773146', '2023-09-27 12:47:42.773146');
INSERT INTO public.virksomhet VALUES (129, '823854289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823854289', '{adresse}', 'AKTIV', '2023-01-01', 823854290, '2023-09-27 12:47:42.775239', '2023-09-27 12:47:42.775239');
INSERT INTO public.virksomhet VALUES (130, '890614908', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890614908', '{adresse}', 'AKTIV', '2023-01-01', 890614909, '2023-09-27 12:47:42.781495', '2023-09-27 12:47:42.781495');
INSERT INTO public.virksomhet VALUES (131, '883449489', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883449489', '{adresse}', 'AKTIV', '2023-01-01', 883449490, '2023-09-27 12:47:42.783319', '2023-09-27 12:47:42.783319');
INSERT INTO public.virksomhet VALUES (132, '868953993', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868953993', '{adresse}', 'AKTIV', '2023-01-01', 868953994, '2023-09-27 12:47:42.785002', '2023-09-27 12:47:42.785002');
INSERT INTO public.virksomhet VALUES (133, '833164615', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833164615', '{adresse}', 'AKTIV', '2023-01-01', 833164616, '2023-09-27 12:47:42.787282', '2023-09-27 12:47:42.787282');
INSERT INTO public.virksomhet VALUES (134, '800638435', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800638435', '{adresse}', 'AKTIV', '2023-01-01', 800638436, '2023-09-27 12:47:42.789115', '2023-09-27 12:47:42.789115');
INSERT INTO public.virksomhet VALUES (135, '877683292', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877683292', '{adresse}', 'AKTIV', '2023-01-01', 877683293, '2023-09-27 12:47:42.79053', '2023-09-27 12:47:42.79053');
INSERT INTO public.virksomhet VALUES (136, '844806430', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844806430', '{adresse}', 'AKTIV', '2023-01-01', 844806431, '2023-09-27 12:47:42.79758', '2023-09-27 12:47:42.79758');
INSERT INTO public.virksomhet VALUES (137, '856883898', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856883898', '{adresse}', 'AKTIV', '2023-01-01', 856883899, '2023-09-27 12:47:42.799364', '2023-09-27 12:47:42.799364');
INSERT INTO public.virksomhet VALUES (138, '834146586', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834146586', '{adresse}', 'AKTIV', '2023-01-01', 834146587, '2023-09-27 12:47:42.800683', '2023-09-27 12:47:42.800683');
INSERT INTO public.virksomhet VALUES (139, '827963000', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827963000', '{adresse}', 'AKTIV', '2023-01-01', 827963001, '2023-09-27 12:47:42.802426', '2023-09-27 12:47:42.802426');
INSERT INTO public.virksomhet VALUES (140, '858766933', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858766933', '{adresse}', 'AKTIV', '2023-01-01', 858766934, '2023-09-27 12:47:42.803586', '2023-09-27 12:47:42.803586');
INSERT INTO public.virksomhet VALUES (141, '894120846', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894120846', '{adresse}', 'AKTIV', '2023-01-01', 894120847, '2023-09-27 12:47:42.804748', '2023-09-27 12:47:42.804748');
INSERT INTO public.virksomhet VALUES (142, '830813886', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830813886', '{adresse}', 'AKTIV', '2023-01-01', 830813887, '2023-09-27 12:47:42.812691', '2023-09-27 12:47:42.812691');
INSERT INTO public.virksomhet VALUES (143, '826165178', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826165178', '{adresse}', 'AKTIV', '2023-01-01', 826165179, '2023-09-27 12:47:42.816529', '2023-09-27 12:47:42.816529');
INSERT INTO public.virksomhet VALUES (144, '860614631', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860614631', '{adresse}', 'AKTIV', '2023-01-01', 860614632, '2023-09-27 12:47:42.819768', '2023-09-27 12:47:42.819768');
INSERT INTO public.virksomhet VALUES (145, '843914504', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843914504', '{adresse}', 'AKTIV', '2023-01-01', 843914505, '2023-09-27 12:47:42.821085', '2023-09-27 12:47:42.821085');
INSERT INTO public.virksomhet VALUES (146, '841947707', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841947707', '{adresse}', 'AKTIV', '2023-01-01', 841947708, '2023-09-27 12:47:42.822508', '2023-09-27 12:47:42.822508');
INSERT INTO public.virksomhet VALUES (147, '805615372', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805615372', '{adresse}', 'AKTIV', '2023-01-01', 805615373, '2023-09-27 12:47:42.8235', '2023-09-27 12:47:42.8235');
INSERT INTO public.virksomhet VALUES (148, '855472907', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855472907', '{adresse}', 'AKTIV', '2023-01-01', 855472908, '2023-09-27 12:47:42.829749', '2023-09-27 12:47:42.829749');
INSERT INTO public.virksomhet VALUES (149, '868639863', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868639863', '{adresse}', 'AKTIV', '2023-01-01', 868639864, '2023-09-27 12:47:42.831059', '2023-09-27 12:47:42.831059');
INSERT INTO public.virksomhet VALUES (150, '834233785', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834233785', '{adresse}', 'AKTIV', '2023-01-01', 834233786, '2023-09-27 12:47:42.834305', '2023-09-27 12:47:42.834305');
INSERT INTO public.virksomhet VALUES (151, '879831802', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879831802', '{adresse}', 'AKTIV', '2023-01-01', 879831803, '2023-09-27 12:47:42.83599', '2023-09-27 12:47:42.83599');
INSERT INTO public.virksomhet VALUES (152, '898624492', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898624492', '{adresse}', 'AKTIV', '2023-01-01', 898624493, '2023-09-27 12:47:42.83832', '2023-09-27 12:47:42.83832');
INSERT INTO public.virksomhet VALUES (153, '814314954', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814314954', '{adresse}', 'AKTIV', '2023-01-01', 814314955, '2023-09-27 12:47:42.848298', '2023-09-27 12:47:42.848298');
INSERT INTO public.virksomhet VALUES (154, '896667526', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896667526', '{adresse}', 'AKTIV', '2023-01-01', 896667527, '2023-09-27 12:47:42.851061', '2023-09-27 12:47:42.851061');
INSERT INTO public.virksomhet VALUES (155, '852100041', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852100041', '{adresse}', 'AKTIV', '2023-01-01', 852100042, '2023-09-27 12:47:42.853546', '2023-09-27 12:47:42.853546');
INSERT INTO public.virksomhet VALUES (156, '846329059', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846329059', '{adresse}', 'AKTIV', '2023-01-01', 846329060, '2023-09-27 12:47:42.855385', '2023-09-27 12:47:42.855385');
INSERT INTO public.virksomhet VALUES (157, '800659646', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800659646', '{adresse}', 'AKTIV', '2023-01-01', 800659647, '2023-09-27 12:47:42.856786', '2023-09-27 12:47:42.856786');
INSERT INTO public.virksomhet VALUES (158, '805635075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805635075', '{adresse}', 'AKTIV', '2023-01-01', 805635076, '2023-09-27 12:47:42.85812', '2023-09-27 12:47:42.85812');
INSERT INTO public.virksomhet VALUES (159, '886851700', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886851700', '{adresse}', 'AKTIV', '2023-01-01', 886851701, '2023-09-27 12:47:42.865772', '2023-09-27 12:47:42.865772');
INSERT INTO public.virksomhet VALUES (160, '819215747', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819215747', '{adresse}', 'AKTIV', '2023-01-01', 819215748, '2023-09-27 12:47:42.867718', '2023-09-27 12:47:42.867718');
INSERT INTO public.virksomhet VALUES (161, '889934227', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889934227', '{adresse}', 'AKTIV', '2023-01-01', 889934228, '2023-09-27 12:47:42.869567', '2023-09-27 12:47:42.869567');
INSERT INTO public.virksomhet VALUES (162, '809175925', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809175925', '{adresse}', 'AKTIV', '2023-01-01', 809175926, '2023-09-27 12:47:42.871409', '2023-09-27 12:47:42.871409');
INSERT INTO public.virksomhet VALUES (163, '864642931', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864642931', '{adresse}', 'AKTIV', '2023-01-01', 864642932, '2023-09-27 12:47:42.873153', '2023-09-27 12:47:42.873153');
INSERT INTO public.virksomhet VALUES (164, '824353904', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824353904', '{adresse}', 'AKTIV', '2023-01-01', 824353905, '2023-09-27 12:47:42.874403', '2023-09-27 12:47:42.874403');
INSERT INTO public.virksomhet VALUES (165, '843768332', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843768332', '{adresse}', 'AKTIV', '2023-01-01', 843768333, '2023-09-27 12:47:42.875656', '2023-09-27 12:47:42.875656');
INSERT INTO public.virksomhet VALUES (166, '885079195', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885079195', '{adresse}', 'AKTIV', '2023-01-01', 885079196, '2023-09-27 12:47:42.876757', '2023-09-27 12:47:42.876757');
INSERT INTO public.virksomhet VALUES (167, '832026215', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832026215', '{adresse}', 'AKTIV', '2023-01-01', 832026216, '2023-09-27 12:47:42.882754', '2023-09-27 12:47:42.882754');
INSERT INTO public.virksomhet VALUES (168, '853841661', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853841661', '{adresse}', 'AKTIV', '2023-01-01', 853841662, '2023-09-27 12:47:42.884204', '2023-09-27 12:47:42.884204');
INSERT INTO public.virksomhet VALUES (169, '899112450', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899112450', '{adresse}', 'AKTIV', '2023-01-01', 899112451, '2023-09-27 12:47:42.885443', '2023-09-27 12:47:42.885443');
INSERT INTO public.virksomhet VALUES (170, '859728672', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859728672', '{adresse}', 'AKTIV', '2023-01-01', 859728673, '2023-09-27 12:47:42.886841', '2023-09-27 12:47:42.886841');
INSERT INTO public.virksomhet VALUES (171, '853818812', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853818812', '{adresse}', 'AKTIV', '2023-01-01', 853818813, '2023-09-27 12:47:42.888505', '2023-09-27 12:47:42.888505');
INSERT INTO public.virksomhet VALUES (172, '854847475', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854847475', '{adresse}', 'AKTIV', '2023-01-01', 854847476, '2023-09-27 12:47:42.890454', '2023-09-27 12:47:42.890454');
INSERT INTO public.virksomhet VALUES (173, '837305547', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837305547', '{adresse}', 'AKTIV', '2023-01-01', 837305548, '2023-09-27 12:47:42.896433', '2023-09-27 12:47:42.896433');
INSERT INTO public.virksomhet VALUES (174, '840094865', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840094865', '{adresse}', 'AKTIV', '2023-01-01', 840094866, '2023-09-27 12:47:42.898921', '2023-09-27 12:47:42.898921');
INSERT INTO public.virksomhet VALUES (175, '811106611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811106611', '{adresse}', 'AKTIV', '2023-01-01', 811106612, '2023-09-27 12:47:42.900437', '2023-09-27 12:47:42.900437');
INSERT INTO public.virksomhet VALUES (176, '837617427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837617427', '{adresse}', 'AKTIV', '2023-01-01', 837617428, '2023-09-27 12:47:42.90159', '2023-09-27 12:47:42.90159');
INSERT INTO public.virksomhet VALUES (177, '858954736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858954736', '{adresse}', 'AKTIV', '2023-01-01', 858954737, '2023-09-27 12:47:42.904154', '2023-09-27 12:47:42.904154');
INSERT INTO public.virksomhet VALUES (178, '816700668', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816700668', '{adresse}', 'AKTIV', '2023-01-01', 816700669, '2023-09-27 12:47:42.905539', '2023-09-27 12:47:42.905539');
INSERT INTO public.virksomhet VALUES (179, '808873241', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808873241', '{adresse}', 'AKTIV', '2023-01-01', 808873242, '2023-09-27 12:47:42.906647', '2023-09-27 12:47:42.906647');
INSERT INTO public.virksomhet VALUES (180, '866010559', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866010559', '{adresse}', 'AKTIV', '2023-01-01', 866010560, '2023-09-27 12:47:42.915671', '2023-09-27 12:47:42.915671');
INSERT INTO public.virksomhet VALUES (181, '865998380', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865998380', '{adresse}', 'AKTIV', '2023-01-01', 865998381, '2023-09-27 12:47:42.917493', '2023-09-27 12:47:42.917493');
INSERT INTO public.virksomhet VALUES (182, '854928401', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854928401', '{adresse}', 'AKTIV', '2023-01-01', 854928402, '2023-09-27 12:47:42.9188', '2023-09-27 12:47:42.9188');
INSERT INTO public.virksomhet VALUES (183, '838426366', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838426366', '{adresse}', 'AKTIV', '2023-01-01', 838426367, '2023-09-27 12:47:42.920763', '2023-09-27 12:47:42.920763');
INSERT INTO public.virksomhet VALUES (184, '856053536', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856053536', '{adresse}', 'AKTIV', '2023-01-01', 856053537, '2023-09-27 12:47:42.922503', '2023-09-27 12:47:42.922503');
INSERT INTO public.virksomhet VALUES (185, '824710122', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824710122', '{adresse}', 'AKTIV', '2023-01-01', 824710123, '2023-09-27 12:47:42.923828', '2023-09-27 12:47:42.923828');
INSERT INTO public.virksomhet VALUES (186, '800262179', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800262179', '{adresse}', 'AKTIV', '2023-01-01', 800262180, '2023-09-27 12:47:42.931602', '2023-09-27 12:47:42.931602');
INSERT INTO public.virksomhet VALUES (187, '847111097', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847111097', '{adresse}', 'AKTIV', '2023-01-01', 847111098, '2023-09-27 12:47:42.932968', '2023-09-27 12:47:42.932968');
INSERT INTO public.virksomhet VALUES (188, '844866931', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844866931', '{adresse}', 'AKTIV', '2023-01-01', 844866932, '2023-09-27 12:47:42.934603', '2023-09-27 12:47:42.934603');
INSERT INTO public.virksomhet VALUES (189, '840864548', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840864548', '{adresse}', 'AKTIV', '2023-01-01', 840864549, '2023-09-27 12:47:42.935941', '2023-09-27 12:47:42.935941');
INSERT INTO public.virksomhet VALUES (190, '853833870', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853833870', '{adresse}', 'AKTIV', '2023-01-01', 853833871, '2023-09-27 12:47:42.937517', '2023-09-27 12:47:42.937517');
INSERT INTO public.virksomhet VALUES (191, '863704750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863704750', '{adresse}', 'AKTIV', '2023-01-01', 863704751, '2023-09-27 12:47:42.939011', '2023-09-27 12:47:42.939011');
INSERT INTO public.virksomhet VALUES (192, '850178064', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850178064', '{adresse}', 'AKTIV', '2023-01-01', 850178065, '2023-09-27 12:47:42.940328', '2023-09-27 12:47:42.940328');
INSERT INTO public.virksomhet VALUES (193, '899217988', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899217988', '{adresse}', 'AKTIV', '2023-01-01', 899217989, '2023-09-27 12:47:42.942968', '2023-09-27 12:47:42.942968');
INSERT INTO public.virksomhet VALUES (194, '835011792', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835011792', '{adresse}', 'AKTIV', '2023-01-01', 835011793, '2023-09-27 12:47:42.949844', '2023-09-27 12:47:42.949844');
INSERT INTO public.virksomhet VALUES (195, '820364254', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820364254', '{adresse}', 'AKTIV', '2023-01-01', 820364255, '2023-09-27 12:47:42.951777', '2023-09-27 12:47:42.951777');
INSERT INTO public.virksomhet VALUES (196, '842192029', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842192029', '{adresse}', 'AKTIV', '2023-01-01', 842192030, '2023-09-27 12:47:42.953372', '2023-09-27 12:47:42.953372');
INSERT INTO public.virksomhet VALUES (197, '819466878', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819466878', '{adresse}', 'AKTIV', '2023-01-01', 819466879, '2023-09-27 12:47:42.954758', '2023-09-27 12:47:42.954758');
INSERT INTO public.virksomhet VALUES (198, '873475613', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873475613', '{adresse}', 'AKTIV', '2023-01-01', 873475614, '2023-09-27 12:47:42.956444', '2023-09-27 12:47:42.956444');
INSERT INTO public.virksomhet VALUES (199, '858314589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858314589', '{adresse}', 'AKTIV', '2023-01-01', 858314590, '2023-09-27 12:47:42.96321', '2023-09-27 12:47:42.96321');
INSERT INTO public.virksomhet VALUES (200, '895875589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895875589', '{adresse}', 'AKTIV', '2023-01-01', 895875590, '2023-09-27 12:47:42.964722', '2023-09-27 12:47:42.964722');
INSERT INTO public.virksomhet VALUES (201, '805387170', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805387170', '{adresse}', 'AKTIV', '2023-01-01', 805387171, '2023-09-27 12:47:42.966221', '2023-09-27 12:47:42.966221');
INSERT INTO public.virksomhet VALUES (202, '815068004', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815068004', '{adresse}', 'AKTIV', '2023-01-01', 815068005, '2023-09-27 12:47:42.967689', '2023-09-27 12:47:42.967689');
INSERT INTO public.virksomhet VALUES (203, '830053040', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830053040', '{adresse}', 'AKTIV', '2023-01-01', 830053041, '2023-09-27 12:47:42.968875', '2023-09-27 12:47:42.968875');
INSERT INTO public.virksomhet VALUES (204, '808340802', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808340802', '{adresse}', 'AKTIV', '2023-01-01', 808340803, '2023-09-27 12:47:42.970673', '2023-09-27 12:47:42.970673');
INSERT INTO public.virksomhet VALUES (205, '881022152', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881022152', '{adresse}', 'AKTIV', '2023-01-01', 881022153, '2023-09-27 12:47:42.972227', '2023-09-27 12:47:42.972227');
INSERT INTO public.virksomhet VALUES (206, '827674772', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827674772', '{adresse}', 'AKTIV', '2023-01-01', 827674773, '2023-09-27 12:47:42.978196', '2023-09-27 12:47:42.978196');
INSERT INTO public.virksomhet VALUES (207, '846054241', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846054241', '{adresse}', 'AKTIV', '2023-01-01', 846054242, '2023-09-27 12:47:42.979297', '2023-09-27 12:47:42.979297');
INSERT INTO public.virksomhet VALUES (208, '806691308', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806691308', '{adresse}', 'AKTIV', '2023-01-01', 806691309, '2023-09-27 12:47:42.979735', '2023-09-27 12:47:42.979735');
INSERT INTO public.virksomhet VALUES (209, '865320028', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865320028', '{adresse}', 'AKTIV', '2023-01-01', 865320029, '2023-09-27 12:47:42.980107', '2023-09-27 12:47:42.980107');
INSERT INTO public.virksomhet VALUES (210, '846023615', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846023615', '{adresse}', 'AKTIV', '2023-01-01', 846023616, '2023-09-27 12:47:42.980459', '2023-09-27 12:47:42.980459');
INSERT INTO public.virksomhet VALUES (211, '822824963', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822824963', '{adresse}', 'AKTIV', '2023-01-01', 822824964, '2023-09-27 12:47:42.992311', '2023-09-27 12:47:42.992311');
INSERT INTO public.virksomhet VALUES (212, '889997531', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889997531', '{adresse}', 'AKTIV', '2023-01-01', 889997532, '2023-09-27 12:47:42.993424', '2023-09-27 12:47:42.993424');
INSERT INTO public.virksomhet VALUES (213, '848189078', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848189078', '{adresse}', 'AKTIV', '2023-01-01', 848189079, '2023-09-27 12:47:42.994549', '2023-09-27 12:47:42.994549');
INSERT INTO public.virksomhet VALUES (214, '876267524', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876267524', '{adresse}', 'AKTIV', '2023-01-01', 876267525, '2023-09-27 12:47:42.996068', '2023-09-27 12:47:42.996068');
INSERT INTO public.virksomhet VALUES (215, '833510033', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833510033', '{adresse}', 'AKTIV', '2023-01-01', 833510034, '2023-09-27 12:47:42.997502', '2023-09-27 12:47:42.997502');
INSERT INTO public.virksomhet VALUES (216, '819898599', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819898599', '{adresse}', 'AKTIV', '2023-01-01', 819898600, '2023-09-27 12:47:42.998992', '2023-09-27 12:47:42.998992');
INSERT INTO public.virksomhet VALUES (217, '889987138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889987138', '{adresse}', 'AKTIV', '2023-01-01', 889987139, '2023-09-27 12:47:43.000715', '2023-09-27 12:47:43.000715');
INSERT INTO public.virksomhet VALUES (218, '853001877', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853001877', '{adresse}', 'AKTIV', '2023-01-01', 853001878, '2023-09-27 12:47:43.006482', '2023-09-27 12:47:43.006482');
INSERT INTO public.virksomhet VALUES (219, '814999762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814999762', '{adresse}', 'AKTIV', '2023-01-01', 814999763, '2023-09-27 12:47:43.015428', '2023-09-27 12:47:43.015428');
INSERT INTO public.virksomhet VALUES (220, '891298662', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891298662', '{adresse}', 'AKTIV', '2023-01-01', 891298663, '2023-09-27 12:47:43.017027', '2023-09-27 12:47:43.017027');
INSERT INTO public.virksomhet VALUES (221, '817529789', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817529789', '{adresse}', 'AKTIV', '2023-01-01', 817529790, '2023-09-27 12:47:43.018278', '2023-09-27 12:47:43.018278');
INSERT INTO public.virksomhet VALUES (222, '803984268', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803984268', '{adresse}', 'AKTIV', '2023-01-01', 803984269, '2023-09-27 12:47:43.019634', '2023-09-27 12:47:43.019634');
INSERT INTO public.virksomhet VALUES (223, '820592381', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820592381', '{adresse}', 'AKTIV', '2023-01-01', 820592382, '2023-09-27 12:47:43.02082', '2023-09-27 12:47:43.02082');
INSERT INTO public.virksomhet VALUES (224, '897972546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897972546', '{adresse}', 'AKTIV', '2023-01-01', 897972547, '2023-09-27 12:47:43.022029', '2023-09-27 12:47:43.022029');
INSERT INTO public.virksomhet VALUES (225, '875062733', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875062733', '{adresse}', 'AKTIV', '2023-01-01', 875062734, '2023-09-27 12:47:43.027216', '2023-09-27 12:47:43.027216');
INSERT INTO public.virksomhet VALUES (226, '852700091', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852700091', '{adresse}', 'AKTIV', '2023-01-01', 852700092, '2023-09-27 12:47:43.029001', '2023-09-27 12:47:43.029001');
INSERT INTO public.virksomhet VALUES (227, '815185914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815185914', '{adresse}', 'AKTIV', '2023-01-01', 815185915, '2023-09-27 12:47:43.030642', '2023-09-27 12:47:43.030642');
INSERT INTO public.virksomhet VALUES (228, '834693586', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834693586', '{adresse}', 'AKTIV', '2023-01-01', 834693587, '2023-09-27 12:47:43.036149', '2023-09-27 12:47:43.036149');
INSERT INTO public.virksomhet VALUES (229, '855109755', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855109755', '{adresse}', 'AKTIV', '2023-01-01', 855109756, '2023-09-27 12:47:43.03794', '2023-09-27 12:47:43.03794');
INSERT INTO public.virksomhet VALUES (230, '849276543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849276543', '{adresse}', 'AKTIV', '2023-01-01', 849276544, '2023-09-27 12:47:43.039335', '2023-09-27 12:47:43.039335');
INSERT INTO public.virksomhet VALUES (231, '820510385', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820510385', '{adresse}', 'AKTIV', '2023-01-01', 820510386, '2023-09-27 12:47:43.040501', '2023-09-27 12:47:43.040501');
INSERT INTO public.virksomhet VALUES (232, '832442866', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832442866', '{adresse}', 'AKTIV', '2023-01-01', 832442867, '2023-09-27 12:47:43.041653', '2023-09-27 12:47:43.041653');
INSERT INTO public.virksomhet VALUES (233, '868527173', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868527173', '{adresse}', 'AKTIV', '2023-01-01', 868527174, '2023-09-27 12:47:43.042717', '2023-09-27 12:47:43.042717');
INSERT INTO public.virksomhet VALUES (234, '896537965', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896537965', '{adresse}', 'AKTIV', '2023-01-01', 896537966, '2023-09-27 12:47:43.048403', '2023-09-27 12:47:43.048403');
INSERT INTO public.virksomhet VALUES (235, '869765393', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869765393', '{adresse}', 'AKTIV', '2023-01-01', 869765394, '2023-09-27 12:47:43.050656', '2023-09-27 12:47:43.050656');
INSERT INTO public.virksomhet VALUES (236, '878631146', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878631146', '{adresse}', 'AKTIV', '2023-01-01', 878631147, '2023-09-27 12:47:43.052356', '2023-09-27 12:47:43.052356');
INSERT INTO public.virksomhet VALUES (237, '893022828', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893022828', '{adresse}', 'AKTIV', '2023-01-01', 893022829, '2023-09-27 12:47:43.053906', '2023-09-27 12:47:43.053906');
INSERT INTO public.virksomhet VALUES (238, '870488667', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870488667', '{adresse}', 'AKTIV', '2023-01-01', 870488668, '2023-09-27 12:47:43.061187', '2023-09-27 12:47:43.061187');
INSERT INTO public.virksomhet VALUES (239, '885693391', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885693391', '{adresse}', 'AKTIV', '2023-01-01', 885693392, '2023-09-27 12:47:43.06279', '2023-09-27 12:47:43.06279');
INSERT INTO public.virksomhet VALUES (240, '877588354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877588354', '{adresse}', 'AKTIV', '2023-01-01', 877588355, '2023-09-27 12:47:43.065586', '2023-09-27 12:47:43.065586');
INSERT INTO public.virksomhet VALUES (241, '835353921', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835353921', '{adresse}', 'AKTIV', '2023-01-01', 835353922, '2023-09-27 12:47:43.066834', '2023-09-27 12:47:43.066834');
INSERT INTO public.virksomhet VALUES (242, '862576386', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862576386', '{adresse}', 'AKTIV', '2023-01-01', 862576387, '2023-09-27 12:47:43.074496', '2023-09-27 12:47:43.074496');
INSERT INTO public.virksomhet VALUES (243, '855839558', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855839558', '{adresse}', 'AKTIV', '2023-01-01', 855839559, '2023-09-27 12:47:43.077225', '2023-09-27 12:47:43.077225');
INSERT INTO public.virksomhet VALUES (244, '877306625', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877306625', '{adresse}', 'AKTIV', '2023-01-01', 877306626, '2023-09-27 12:47:43.078693', '2023-09-27 12:47:43.078693');
INSERT INTO public.virksomhet VALUES (245, '857990940', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857990940', '{adresse}', 'AKTIV', '2023-01-01', 857990941, '2023-09-27 12:47:43.079828', '2023-09-27 12:47:43.079828');
INSERT INTO public.virksomhet VALUES (246, '855059723', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855059723', '{adresse}', 'AKTIV', '2023-01-01', 855059724, '2023-09-27 12:47:43.084956', '2023-09-27 12:47:43.084956');
INSERT INTO public.virksomhet VALUES (247, '832427770', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832427770', '{adresse}', 'AKTIV', '2023-01-01', 832427771, '2023-09-27 12:47:43.087352', '2023-09-27 12:47:43.087352');
INSERT INTO public.virksomhet VALUES (248, '832190627', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832190627', '{adresse}', 'AKTIV', '2023-01-01', 832190628, '2023-09-27 12:47:43.088333', '2023-09-27 12:47:43.088333');
INSERT INTO public.virksomhet VALUES (249, '892239323', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892239323', '{adresse}', 'AKTIV', '2023-01-01', 892239324, '2023-09-27 12:47:43.089735', '2023-09-27 12:47:43.089735');
INSERT INTO public.virksomhet VALUES (250, '899413636', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899413636', '{adresse}', 'AKTIV', '2023-01-01', 899413637, '2023-09-27 12:47:43.090958', '2023-09-27 12:47:43.090958');
INSERT INTO public.virksomhet VALUES (251, '804944614', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804944614', '{adresse}', 'AKTIV', '2023-01-01', 804944615, '2023-09-27 12:47:43.097417', '2023-09-27 12:47:43.097417');
INSERT INTO public.virksomhet VALUES (252, '890674385', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890674385', '{adresse}', 'AKTIV', '2023-01-01', 890674386, '2023-09-27 12:47:43.099359', '2023-09-27 12:47:43.099359');
INSERT INTO public.virksomhet VALUES (253, '803393633', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803393633', '{adresse}', 'AKTIV', '2023-01-01', 803393634, '2023-09-27 12:47:43.100876', '2023-09-27 12:47:43.100876');
INSERT INTO public.virksomhet VALUES (254, '824106789', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824106789', '{adresse}', 'AKTIV', '2023-01-01', 824106790, '2023-09-27 12:47:43.1095', '2023-09-27 12:47:43.1095');
INSERT INTO public.virksomhet VALUES (255, '882122217', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882122217', '{adresse}', 'AKTIV', '2023-01-01', 882122218, '2023-09-27 12:47:43.110792', '2023-09-27 12:47:43.110792');
INSERT INTO public.virksomhet VALUES (256, '859439629', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859439629', '{adresse}', 'AKTIV', '2023-01-01', 859439630, '2023-09-27 12:47:43.111903', '2023-09-27 12:47:43.111903');
INSERT INTO public.virksomhet VALUES (257, '816467453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816467453', '{adresse}', 'AKTIV', '2023-01-01', 816467454, '2023-09-27 12:47:43.112722', '2023-09-27 12:47:43.112722');
INSERT INTO public.virksomhet VALUES (258, '895579410', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895579410', '{adresse}', 'AKTIV', '2023-01-01', 895579411, '2023-09-27 12:47:43.113462', '2023-09-27 12:47:43.113462');
INSERT INTO public.virksomhet VALUES (259, '816662201', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816662201', '{adresse}', 'AKTIV', '2023-01-01', 816662202, '2023-09-27 12:47:43.113838', '2023-09-27 12:47:43.113838');
INSERT INTO public.virksomhet VALUES (260, '852642017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852642017', '{adresse}', 'AKTIV', '2023-01-01', 852642018, '2023-09-27 12:47:43.119292', '2023-09-27 12:47:43.119292');
INSERT INTO public.virksomhet VALUES (261, '856716152', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856716152', '{adresse}', 'AKTIV', '2023-01-01', 856716153, '2023-09-27 12:47:43.127979', '2023-09-27 12:47:43.127979');
INSERT INTO public.virksomhet VALUES (262, '855383952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855383952', '{adresse}', 'AKTIV', '2023-01-01', 855383953, '2023-09-27 12:47:43.129065', '2023-09-27 12:47:43.129065');
INSERT INTO public.virksomhet VALUES (263, '802584307', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802584307', '{adresse}', 'AKTIV', '2023-01-01', 802584308, '2023-09-27 12:47:43.130215', '2023-09-27 12:47:43.130215');
INSERT INTO public.virksomhet VALUES (264, '827140608', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827140608', '{adresse}', 'AKTIV', '2023-01-01', 827140609, '2023-09-27 12:47:43.13107', '2023-09-27 12:47:43.13107');
INSERT INTO public.virksomhet VALUES (265, '882331842', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882331842', '{adresse}', 'AKTIV', '2023-01-01', 882331843, '2023-09-27 12:47:43.132083', '2023-09-27 12:47:43.132083');
INSERT INTO public.virksomhet VALUES (266, '801619866', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801619866', '{adresse}', 'AKTIV', '2023-01-01', 801619867, '2023-09-27 12:47:43.141382', '2023-09-27 12:47:43.141382');
INSERT INTO public.virksomhet VALUES (267, '825030543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825030543', '{adresse}', 'AKTIV', '2023-01-01', 825030544, '2023-09-27 12:47:43.143436', '2023-09-27 12:47:43.143436');
INSERT INTO public.virksomhet VALUES (268, '861837698', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861837698', '{adresse}', 'AKTIV', '2023-01-01', 861837699, '2023-09-27 12:47:43.148852', '2023-09-27 12:47:43.148852');
INSERT INTO public.virksomhet VALUES (269, '829811962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829811962', '{adresse}', 'AKTIV', '2023-01-01', 829811963, '2023-09-27 12:47:43.150196', '2023-09-27 12:47:43.150196');
INSERT INTO public.virksomhet VALUES (270, '822242899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822242899', '{adresse}', 'AKTIV', '2023-01-01', 822242900, '2023-09-27 12:47:43.15138', '2023-09-27 12:47:43.15138');
INSERT INTO public.virksomhet VALUES (271, '855141426', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855141426', '{adresse}', 'AKTIV', '2023-01-01', 855141427, '2023-09-27 12:47:43.15234', '2023-09-27 12:47:43.15234');
INSERT INTO public.virksomhet VALUES (272, '864311384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864311384', '{adresse}', 'AKTIV', '2023-01-01', 864311385, '2023-09-27 12:47:43.158615', '2023-09-27 12:47:43.158615');
INSERT INTO public.virksomhet VALUES (273, '830236604', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830236604', '{adresse}', 'AKTIV', '2023-01-01', 830236605, '2023-09-27 12:47:43.159829', '2023-09-27 12:47:43.159829');
INSERT INTO public.virksomhet VALUES (274, '836452543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836452543', '{adresse}', 'AKTIV', '2023-01-01', 836452544, '2023-09-27 12:47:43.16073', '2023-09-27 12:47:43.16073');
INSERT INTO public.virksomhet VALUES (275, '892225109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892225109', '{adresse}', 'AKTIV', '2023-01-01', 892225110, '2023-09-27 12:47:43.162155', '2023-09-27 12:47:43.162155');
INSERT INTO public.virksomhet VALUES (276, '810762223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810762223', '{adresse}', 'AKTIV', '2023-01-01', 810762224, '2023-09-27 12:47:43.168372', '2023-09-27 12:47:43.168372');
INSERT INTO public.virksomhet VALUES (277, '837437935', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837437935', '{adresse}', 'AKTIV', '2023-01-01', 837437936, '2023-09-27 12:47:43.170266', '2023-09-27 12:47:43.170266');
INSERT INTO public.virksomhet VALUES (278, '815177890', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815177890', '{adresse}', 'AKTIV', '2023-01-01', 815177891, '2023-09-27 12:47:43.171797', '2023-09-27 12:47:43.171797');
INSERT INTO public.virksomhet VALUES (279, '802444869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802444869', '{adresse}', 'AKTIV', '2023-01-01', 802444870, '2023-09-27 12:47:43.172949', '2023-09-27 12:47:43.172949');
INSERT INTO public.virksomhet VALUES (280, '846357403', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846357403', '{adresse}', 'AKTIV', '2023-01-01', 846357404, '2023-09-27 12:47:43.179803', '2023-09-27 12:47:43.179803');
INSERT INTO public.virksomhet VALUES (281, '894125644', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894125644', '{adresse}', 'AKTIV', '2023-01-01', 894125645, '2023-09-27 12:47:43.181217', '2023-09-27 12:47:43.181217');
INSERT INTO public.virksomhet VALUES (282, '860079548', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860079548', '{adresse}', 'AKTIV', '2023-01-01', 860079549, '2023-09-27 12:47:43.182215', '2023-09-27 12:47:43.182215');
INSERT INTO public.virksomhet VALUES (283, '850727134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850727134', '{adresse}', 'AKTIV', '2023-01-01', 850727135, '2023-09-27 12:47:43.183313', '2023-09-27 12:47:43.183313');
INSERT INTO public.virksomhet VALUES (284, '897600352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897600352', '{adresse}', 'AKTIV', '2023-01-01', 897600353, '2023-09-27 12:47:43.188731', '2023-09-27 12:47:43.188731');
INSERT INTO public.virksomhet VALUES (285, '865176224', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865176224', '{adresse}', 'AKTIV', '2023-01-01', 865176225, '2023-09-27 12:47:43.190042', '2023-09-27 12:47:43.190042');
INSERT INTO public.virksomhet VALUES (286, '841023274', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841023274', '{adresse}', 'AKTIV', '2023-01-01', 841023275, '2023-09-27 12:47:43.191482', '2023-09-27 12:47:43.191482');
INSERT INTO public.virksomhet VALUES (287, '858767970', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858767970', '{adresse}', 'AKTIV', '2023-01-01', 858767971, '2023-09-27 12:47:43.192497', '2023-09-27 12:47:43.192497');
INSERT INTO public.virksomhet VALUES (288, '815013773', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815013773', '{adresse}', 'AKTIV', '2023-01-01', 815013774, '2023-09-27 12:47:43.1936', '2023-09-27 12:47:43.1936');
INSERT INTO public.virksomhet VALUES (289, '806551335', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806551335', '{adresse}', 'AKTIV', '2023-01-01', 806551336, '2023-09-27 12:47:43.199202', '2023-09-27 12:47:43.199202');
INSERT INTO public.virksomhet VALUES (290, '862063648', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862063648', '{adresse}', 'AKTIV', '2023-01-01', 862063649, '2023-09-27 12:47:43.200677', '2023-09-27 12:47:43.200677');
INSERT INTO public.virksomhet VALUES (291, '829511190', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829511190', '{adresse}', 'AKTIV', '2023-01-01', 829511191, '2023-09-27 12:47:43.201872', '2023-09-27 12:47:43.201872');
INSERT INTO public.virksomhet VALUES (292, '890504212', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890504212', '{adresse}', 'AKTIV', '2023-01-01', 890504213, '2023-09-27 12:47:43.202461', '2023-09-27 12:47:43.202461');
INSERT INTO public.virksomhet VALUES (293, '839750510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839750510', '{adresse}', 'AKTIV', '2023-01-01', 839750511, '2023-09-27 12:47:43.203076', '2023-09-27 12:47:43.203076');
INSERT INTO public.virksomhet VALUES (294, '859077713', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859077713', '{adresse}', 'AKTIV', '2023-01-01', 859077714, '2023-09-27 12:47:43.207611', '2023-09-27 12:47:43.207611');
INSERT INTO public.virksomhet VALUES (295, '807085015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807085015', '{adresse}', 'AKTIV', '2023-01-01', 807085016, '2023-09-27 12:47:43.20925', '2023-09-27 12:47:43.20925');
INSERT INTO public.virksomhet VALUES (296, '820154219', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820154219', '{adresse}', 'AKTIV', '2023-01-01', 820154220, '2023-09-27 12:47:43.210291', '2023-09-27 12:47:43.210291');
INSERT INTO public.virksomhet VALUES (297, '854770517', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854770517', '{adresse}', 'AKTIV', '2023-01-01', 854770518, '2023-09-27 12:47:43.211703', '2023-09-27 12:47:43.211703');
INSERT INTO public.virksomhet VALUES (298, '855050206', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855050206', '{adresse}', 'AKTIV', '2023-01-01', 855050207, '2023-09-27 12:47:43.217062', '2023-09-27 12:47:43.217062');
INSERT INTO public.virksomhet VALUES (299, '889128185', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889128185', '{adresse}', 'AKTIV', '2023-01-01', 889128186, '2023-09-27 12:47:43.218471', '2023-09-27 12:47:43.218471');
INSERT INTO public.virksomhet VALUES (300, '806386500', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806386500', '{adresse}', 'AKTIV', '2023-01-01', 806386501, '2023-09-27 12:47:43.219046', '2023-09-27 12:47:43.219046');
INSERT INTO public.virksomhet VALUES (301, '866865790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866865790', '{adresse}', 'AKTIV', '2023-01-01', 866865791, '2023-09-27 12:47:43.223527', '2023-09-27 12:47:43.223527');
INSERT INTO public.virksomhet VALUES (302, '823546398', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823546398', '{adresse}', 'AKTIV', '2023-01-01', 823546399, '2023-09-27 12:47:43.225435', '2023-09-27 12:47:43.225435');
INSERT INTO public.virksomhet VALUES (303, '809817182', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809817182', '{adresse}', 'AKTIV', '2023-01-01', 809817183, '2023-09-27 12:47:43.226234', '2023-09-27 12:47:43.226234');
INSERT INTO public.virksomhet VALUES (304, '886965332', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886965332', '{adresse}', 'AKTIV', '2023-01-01', 886965333, '2023-09-27 12:47:43.226753', '2023-09-27 12:47:43.226753');
INSERT INTO public.virksomhet VALUES (305, '837006317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837006317', '{adresse}', 'AKTIV', '2023-01-01', 837006318, '2023-09-27 12:47:43.2315', '2023-09-27 12:47:43.2315');
INSERT INTO public.virksomhet VALUES (306, '859791871', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859791871', '{adresse}', 'AKTIV', '2023-01-01', 859791872, '2023-09-27 12:47:43.234731', '2023-09-27 12:47:43.234731');
INSERT INTO public.virksomhet VALUES (307, '839648076', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839648076', '{adresse}', 'AKTIV', '2023-01-01', 839648077, '2023-09-27 12:47:43.235793', '2023-09-27 12:47:43.235793');
INSERT INTO public.virksomhet VALUES (308, '886374702', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886374702', '{adresse}', 'AKTIV', '2023-01-01', 886374703, '2023-09-27 12:47:43.236938', '2023-09-27 12:47:43.236938');
INSERT INTO public.virksomhet VALUES (309, '801018012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801018012', '{adresse}', 'AKTIV', '2023-01-01', 801018013, '2023-09-27 12:47:43.242566', '2023-09-27 12:47:43.242566');
INSERT INTO public.virksomhet VALUES (310, '874911010', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874911010', '{adresse}', 'AKTIV', '2023-01-01', 874911011, '2023-09-27 12:47:43.244683', '2023-09-27 12:47:43.244683');
INSERT INTO public.virksomhet VALUES (311, '879283512', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879283512', '{adresse}', 'AKTIV', '2023-01-01', 879283513, '2023-09-27 12:47:43.24557', '2023-09-27 12:47:43.24557');
INSERT INTO public.virksomhet VALUES (312, '811427024', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811427024', '{adresse}', 'AKTIV', '2023-01-01', 811427025, '2023-09-27 12:47:43.25189', '2023-09-27 12:47:43.25189');
INSERT INTO public.virksomhet VALUES (313, '866768166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866768166', '{adresse}', 'AKTIV', '2023-01-01', 866768167, '2023-09-27 12:47:43.253251', '2023-09-27 12:47:43.253251');
INSERT INTO public.virksomhet VALUES (314, '808374138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808374138', '{adresse}', 'AKTIV', '2023-01-01', 808374139, '2023-09-27 12:47:43.254619', '2023-09-27 12:47:43.254619');
INSERT INTO public.virksomhet VALUES (315, '892584778', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892584778', '{adresse}', 'AKTIV', '2023-01-01', 892584779, '2023-09-27 12:47:43.256003', '2023-09-27 12:47:43.256003');
INSERT INTO public.virksomhet VALUES (316, '890289304', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890289304', '{adresse}', 'AKTIV', '2023-01-01', 890289305, '2023-09-27 12:47:43.257054', '2023-09-27 12:47:43.257054');
INSERT INTO public.virksomhet VALUES (317, '897993099', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897993099', '{adresse}', 'AKTIV', '2023-01-01', 897993100, '2023-09-27 12:47:43.262273', '2023-09-27 12:47:43.262273');
INSERT INTO public.virksomhet VALUES (318, '838203900', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838203900', '{adresse}', 'AKTIV', '2023-01-01', 838203901, '2023-09-27 12:47:43.263481', '2023-09-27 12:47:43.263481');
INSERT INTO public.virksomhet VALUES (319, '820357215', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820357215', '{adresse}', 'AKTIV', '2023-01-01', 820357216, '2023-09-27 12:47:43.264255', '2023-09-27 12:47:43.264255');
INSERT INTO public.virksomhet VALUES (320, '825011425', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825011425', '{adresse}', 'AKTIV', '2023-01-01', 825011426, '2023-09-27 12:47:43.264696', '2023-09-27 12:47:43.264696');
INSERT INTO public.virksomhet VALUES (321, '858637744', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858637744', '{adresse}', 'AKTIV', '2023-01-01', 858637745, '2023-09-27 12:47:43.269501', '2023-09-27 12:47:43.269501');
INSERT INTO public.virksomhet VALUES (322, '807877858', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807877858', '{adresse}', 'AKTIV', '2023-01-01', 807877859, '2023-09-27 12:47:43.271779', '2023-09-27 12:47:43.271779');
INSERT INTO public.virksomhet VALUES (323, '856450848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856450848', '{adresse}', 'AKTIV', '2023-01-01', 856450849, '2023-09-27 12:47:43.272867', '2023-09-27 12:47:43.272867');
INSERT INTO public.virksomhet VALUES (324, '899941610', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899941610', '{adresse}', 'AKTIV', '2023-01-01', 899941611, '2023-09-27 12:47:43.274163', '2023-09-27 12:47:43.274163');
INSERT INTO public.virksomhet VALUES (325, '811875102', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811875102', '{adresse}', 'AKTIV', '2023-01-01', 811875103, '2023-09-27 12:47:43.274798', '2023-09-27 12:47:43.274798');
INSERT INTO public.virksomhet VALUES (326, '879885713', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879885713', '{adresse}', 'AKTIV', '2023-01-01', 879885714, '2023-09-27 12:47:43.280478', '2023-09-27 12:47:43.280478');
INSERT INTO public.virksomhet VALUES (327, '885482062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885482062', '{adresse}', 'AKTIV', '2023-01-01', 885482063, '2023-09-27 12:47:43.282045', '2023-09-27 12:47:43.282045');
INSERT INTO public.virksomhet VALUES (328, '866886570', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866886570', '{adresse}', 'AKTIV', '2023-01-01', 866886571, '2023-09-27 12:47:43.282656', '2023-09-27 12:47:43.282656');
INSERT INTO public.virksomhet VALUES (329, '890616652', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890616652', '{adresse}', 'AKTIV', '2023-01-01', 890616653, '2023-09-27 12:47:43.288527', '2023-09-27 12:47:43.288527');
INSERT INTO public.virksomhet VALUES (330, '862722287', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862722287', '{adresse}', 'AKTIV', '2023-01-01', 862722288, '2023-09-27 12:47:43.289688', '2023-09-27 12:47:43.289688');
INSERT INTO public.virksomhet VALUES (331, '886375261', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886375261', '{adresse}', 'AKTIV', '2023-01-01', 886375262, '2023-09-27 12:47:43.290855', '2023-09-27 12:47:43.290855');
INSERT INTO public.virksomhet VALUES (332, '896357373', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896357373', '{adresse}', 'AKTIV', '2023-01-01', 896357374, '2023-09-27 12:47:43.291983', '2023-09-27 12:47:43.291983');
INSERT INTO public.virksomhet VALUES (333, '866677637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866677637', '{adresse}', 'AKTIV', '2023-01-01', 866677638, '2023-09-27 12:47:43.293116', '2023-09-27 12:47:43.293116');
INSERT INTO public.virksomhet VALUES (334, '850099558', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850099558', '{adresse}', 'AKTIV', '2023-01-01', 850099559, '2023-09-27 12:47:43.297811', '2023-09-27 12:47:43.297811');
INSERT INTO public.virksomhet VALUES (335, '859820298', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859820298', '{adresse}', 'AKTIV', '2023-01-01', 859820299, '2023-09-27 12:47:43.299257', '2023-09-27 12:47:43.299257');
INSERT INTO public.virksomhet VALUES (336, '888812048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888812048', '{adresse}', 'AKTIV', '2023-01-01', 888812049, '2023-09-27 12:47:43.300567', '2023-09-27 12:47:43.300567');
INSERT INTO public.virksomhet VALUES (337, '821080096', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821080096', '{adresse}', 'AKTIV', '2023-01-01', 821080097, '2023-09-27 12:47:43.302152', '2023-09-27 12:47:43.302152');
INSERT INTO public.virksomhet VALUES (338, '898108054', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898108054', '{adresse}', 'AKTIV', '2023-01-01', 898108055, '2023-09-27 12:47:43.307321', '2023-09-27 12:47:43.307321');
INSERT INTO public.virksomhet VALUES (339, '842021484', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842021484', '{adresse}', 'AKTIV', '2023-01-01', 842021485, '2023-09-27 12:47:43.308838', '2023-09-27 12:47:43.308838');
INSERT INTO public.virksomhet VALUES (340, '880853424', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880853424', '{adresse}', 'AKTIV', '2023-01-01', 880853425, '2023-09-27 12:47:43.31005', '2023-09-27 12:47:43.31005');
INSERT INTO public.virksomhet VALUES (341, '833088737', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833088737', '{adresse}', 'AKTIV', '2023-01-01', 833088738, '2023-09-27 12:47:43.31147', '2023-09-27 12:47:43.31147');
INSERT INTO public.virksomhet VALUES (342, '824370623', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824370623', '{adresse}', 'AKTIV', '2023-01-01', 824370624, '2023-09-27 12:47:43.312315', '2023-09-27 12:47:43.312315');
INSERT INTO public.virksomhet VALUES (343, '859886502', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859886502', '{adresse}', 'AKTIV', '2023-01-01', 859886503, '2023-09-27 12:47:43.317741', '2023-09-27 12:47:43.317741');
INSERT INTO public.virksomhet VALUES (344, '881709672', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881709672', '{adresse}', 'AKTIV', '2023-01-01', 881709673, '2023-09-27 12:47:43.318978', '2023-09-27 12:47:43.318978');
INSERT INTO public.virksomhet VALUES (345, '878183875', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878183875', '{adresse}', 'AKTIV', '2023-01-01', 878183876, '2023-09-27 12:47:43.320053', '2023-09-27 12:47:43.320053');
INSERT INTO public.virksomhet VALUES (346, '871061073', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871061073', '{adresse}', 'AKTIV', '2023-01-01', 871061074, '2023-09-27 12:47:43.321112', '2023-09-27 12:47:43.321112');
INSERT INTO public.virksomhet VALUES (347, '834151829', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834151829', '{adresse}', 'AKTIV', '2023-01-01', 834151830, '2023-09-27 12:47:43.326932', '2023-09-27 12:47:43.326932');
INSERT INTO public.virksomhet VALUES (348, '895917367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895917367', '{adresse}', 'AKTIV', '2023-01-01', 895917368, '2023-09-27 12:47:43.328166', '2023-09-27 12:47:43.328166');
INSERT INTO public.virksomhet VALUES (349, '884414162', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884414162', '{adresse}', 'AKTIV', '2023-01-01', 884414163, '2023-09-27 12:47:43.32863', '2023-09-27 12:47:43.32863');
INSERT INTO public.virksomhet VALUES (350, '859150008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859150008', '{adresse}', 'AKTIV', '2023-01-01', 859150009, '2023-09-27 12:47:43.329041', '2023-09-27 12:47:43.329041');
INSERT INTO public.virksomhet VALUES (351, '896355742', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896355742', '{adresse}', 'AKTIV', '2023-01-01', 896355743, '2023-09-27 12:47:43.329462', '2023-09-27 12:47:43.329462');
INSERT INTO public.virksomhet VALUES (352, '800747683', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800747683', '{adresse}', 'AKTIV', '2023-01-01', 800747684, '2023-09-27 12:47:43.335542', '2023-09-27 12:47:43.335542');
INSERT INTO public.virksomhet VALUES (353, '857037705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857037705', '{adresse}', 'AKTIV', '2023-01-01', 857037706, '2023-09-27 12:47:43.336331', '2023-09-27 12:47:43.336331');
INSERT INTO public.virksomhet VALUES (354, '897975138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897975138', '{adresse}', 'AKTIV', '2023-01-01', 897975139, '2023-09-27 12:47:43.337429', '2023-09-27 12:47:43.337429');
INSERT INTO public.virksomhet VALUES (355, '807173400', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807173400', '{adresse}', 'AKTIV', '2023-01-01', 807173401, '2023-09-27 12:47:43.34199', '2023-09-27 12:47:43.34199');
INSERT INTO public.virksomhet VALUES (356, '853864887', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853864887', '{adresse}', 'AKTIV', '2023-01-01', 853864888, '2023-09-27 12:47:43.342699', '2023-09-27 12:47:43.342699');
INSERT INTO public.virksomhet VALUES (357, '844632422', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844632422', '{adresse}', 'AKTIV', '2023-01-01', 844632423, '2023-09-27 12:47:43.343199', '2023-09-27 12:47:43.343199');
INSERT INTO public.virksomhet VALUES (358, '844666006', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844666006', '{adresse}', 'AKTIV', '2023-01-01', 844666007, '2023-09-27 12:47:43.343703', '2023-09-27 12:47:43.343703');
INSERT INTO public.virksomhet VALUES (359, '802555928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802555928', '{adresse}', 'AKTIV', '2023-01-01', 802555929, '2023-09-27 12:47:43.348614', '2023-09-27 12:47:43.348614');
INSERT INTO public.virksomhet VALUES (360, '816641469', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816641469', '{adresse}', 'AKTIV', '2023-01-01', 816641470, '2023-09-27 12:47:43.3505', '2023-09-27 12:47:43.3505');
INSERT INTO public.virksomhet VALUES (361, '878284938', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878284938', '{adresse}', 'AKTIV', '2023-01-01', 878284939, '2023-09-27 12:47:43.352057', '2023-09-27 12:47:43.352057');
INSERT INTO public.virksomhet VALUES (362, '833167762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833167762', '{adresse}', 'AKTIV', '2023-01-01', 833167763, '2023-09-27 12:47:43.357641', '2023-09-27 12:47:43.357641');
INSERT INTO public.virksomhet VALUES (363, '852738491', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852738491', '{adresse}', 'AKTIV', '2023-01-01', 852738492, '2023-09-27 12:47:43.359142', '2023-09-27 12:47:43.359142');
INSERT INTO public.virksomhet VALUES (364, '854600919', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854600919', '{adresse}', 'AKTIV', '2023-01-01', 854600920, '2023-09-27 12:47:43.364209', '2023-09-27 12:47:43.364209');
INSERT INTO public.virksomhet VALUES (365, '891686706', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891686706', '{adresse}', 'AKTIV', '2023-01-01', 891686707, '2023-09-27 12:47:43.365467', '2023-09-27 12:47:43.365467');
INSERT INTO public.virksomhet VALUES (366, '800994018', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800994018', '{adresse}', 'AKTIV', '2023-01-01', 800994019, '2023-09-27 12:47:43.366357', '2023-09-27 12:47:43.366357');
INSERT INTO public.virksomhet VALUES (367, '885343199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885343199', '{adresse}', 'AKTIV', '2023-01-01', 885343200, '2023-09-27 12:47:43.371684', '2023-09-27 12:47:43.371684');
INSERT INTO public.virksomhet VALUES (368, '814097367', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814097367', '{adresse}', 'AKTIV', '2023-01-01', 814097368, '2023-09-27 12:47:43.372822', '2023-09-27 12:47:43.372822');
INSERT INTO public.virksomhet VALUES (369, '855405477', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855405477', '{adresse}', 'AKTIV', '2023-01-01', 855405478, '2023-09-27 12:47:43.377329', '2023-09-27 12:47:43.377329');
INSERT INTO public.virksomhet VALUES (370, '871110892', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871110892', '{adresse}', 'AKTIV', '2023-01-01', 871110893, '2023-09-27 12:47:43.378506', '2023-09-27 12:47:43.378506');
INSERT INTO public.virksomhet VALUES (371, '889302409', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889302409', '{adresse}', 'AKTIV', '2023-01-01', 889302410, '2023-09-27 12:47:43.381084', '2023-09-27 12:47:43.381084');
INSERT INTO public.virksomhet VALUES (372, '862650554', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862650554', '{adresse}', 'AKTIV', '2023-01-01', 862650555, '2023-09-27 12:47:43.382425', '2023-09-27 12:47:43.382425');
INSERT INTO public.virksomhet VALUES (373, '856323024', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856323024', '{adresse}', 'AKTIV', '2023-01-01', 856323025, '2023-09-27 12:47:43.387074', '2023-09-27 12:47:43.387074');
INSERT INTO public.virksomhet VALUES (374, '865957763', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865957763', '{adresse}', 'AKTIV', '2023-01-01', 865957764, '2023-09-27 12:47:43.388108', '2023-09-27 12:47:43.388108');
INSERT INTO public.virksomhet VALUES (375, '809997464', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809997464', '{adresse}', 'AKTIV', '2023-01-01', 809997465, '2023-09-27 12:47:43.39295', '2023-09-27 12:47:43.39295');
INSERT INTO public.virksomhet VALUES (376, '892037204', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892037204', '{adresse}', 'AKTIV', '2023-01-01', 892037205, '2023-09-27 12:47:43.394477', '2023-09-27 12:47:43.394477');
INSERT INTO public.virksomhet VALUES (377, '855209391', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855209391', '{adresse}', 'AKTIV', '2023-01-01', 855209392, '2023-09-27 12:47:43.395774', '2023-09-27 12:47:43.395774');
INSERT INTO public.virksomhet VALUES (378, '852675187', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852675187', '{adresse}', 'AKTIV', '2023-01-01', 852675188, '2023-09-27 12:47:43.400575', '2023-09-27 12:47:43.400575');
INSERT INTO public.virksomhet VALUES (379, '875190936', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875190936', '{adresse}', 'AKTIV', '2023-01-01', 875190937, '2023-09-27 12:47:43.401774', '2023-09-27 12:47:43.401774');
INSERT INTO public.virksomhet VALUES (380, '878772022', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878772022', '{adresse}', 'AKTIV', '2023-01-01', 878772023, '2023-09-27 12:47:43.402725', '2023-09-27 12:47:43.402725');
INSERT INTO public.virksomhet VALUES (381, '875906777', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875906777', '{adresse}', 'AKTIV', '2023-01-01', 875906778, '2023-09-27 12:47:43.407905', '2023-09-27 12:47:43.407905');
INSERT INTO public.virksomhet VALUES (382, '867050630', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867050630', '{adresse}', 'AKTIV', '2023-01-01', 867050631, '2023-09-27 12:47:43.409902', '2023-09-27 12:47:43.409902');
INSERT INTO public.virksomhet VALUES (383, '899626977', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899626977', '{adresse}', 'AKTIV', '2023-01-01', 899626978, '2023-09-27 12:47:43.411008', '2023-09-27 12:47:43.411008');
INSERT INTO public.virksomhet VALUES (384, '847716706', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847716706', '{adresse}', 'AKTIV', '2023-01-01', 847716707, '2023-09-27 12:47:43.417105', '2023-09-27 12:47:43.417105');
INSERT INTO public.virksomhet VALUES (385, '819302627', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819302627', '{adresse}', 'AKTIV', '2023-01-01', 819302628, '2023-09-27 12:47:43.418837', '2023-09-27 12:47:43.418837');
INSERT INTO public.virksomhet VALUES (386, '886536405', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886536405', '{adresse}', 'AKTIV', '2023-01-01', 886536406, '2023-09-27 12:47:43.420783', '2023-09-27 12:47:43.420783');
INSERT INTO public.virksomhet VALUES (387, '861719015', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861719015', '{adresse}', 'AKTIV', '2023-01-01', 861719016, '2023-09-27 12:47:43.422286', '2023-09-27 12:47:43.422286');
INSERT INTO public.virksomhet VALUES (388, '858181803', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858181803', '{adresse}', 'AKTIV', '2023-01-01', 858181804, '2023-09-27 12:47:43.423526', '2023-09-27 12:47:43.423526');
INSERT INTO public.virksomhet VALUES (389, '896147751', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896147751', '{adresse}', 'AKTIV', '2023-01-01', 896147752, '2023-09-27 12:47:43.428967', '2023-09-27 12:47:43.428967');
INSERT INTO public.virksomhet VALUES (390, '825362503', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825362503', '{adresse}', 'AKTIV', '2023-01-01', 825362504, '2023-09-27 12:47:43.430921', '2023-09-27 12:47:43.430921');
INSERT INTO public.virksomhet VALUES (391, '873037031', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873037031', '{adresse}', 'AKTIV', '2023-01-01', 873037032, '2023-09-27 12:47:43.432432', '2023-09-27 12:47:43.432432');
INSERT INTO public.virksomhet VALUES (392, '808933296', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808933296', '{adresse}', 'AKTIV', '2023-01-01', 808933297, '2023-09-27 12:47:43.433431', '2023-09-27 12:47:43.433431');
INSERT INTO public.virksomhet VALUES (393, '856311115', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856311115', '{adresse}', 'AKTIV', '2023-01-01', 856311116, '2023-09-27 12:47:43.439493', '2023-09-27 12:47:43.439493');
INSERT INTO public.virksomhet VALUES (394, '841062282', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841062282', '{adresse}', 'AKTIV', '2023-01-01', 841062283, '2023-09-27 12:47:43.440912', '2023-09-27 12:47:43.440912');
INSERT INTO public.virksomhet VALUES (395, '839896151', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839896151', '{adresse}', 'AKTIV', '2023-01-01', 839896152, '2023-09-27 12:47:43.442002', '2023-09-27 12:47:43.442002');
INSERT INTO public.virksomhet VALUES (396, '808119254', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808119254', '{adresse}', 'AKTIV', '2023-01-01', 808119255, '2023-09-27 12:47:43.443253', '2023-09-27 12:47:43.443253');
INSERT INTO public.virksomhet VALUES (397, '868411463', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868411463', '{adresse}', 'AKTIV', '2023-01-01', 868411464, '2023-09-27 12:47:43.444299', '2023-09-27 12:47:43.444299');
INSERT INTO public.virksomhet VALUES (398, '845923614', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845923614', '{adresse}', 'AKTIV', '2023-01-01', 845923615, '2023-09-27 12:47:43.449395', '2023-09-27 12:47:43.449395');
INSERT INTO public.virksomhet VALUES (399, '879136681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879136681', '{adresse}', 'AKTIV', '2023-01-01', 879136682, '2023-09-27 12:47:43.450578', '2023-09-27 12:47:43.450578');
INSERT INTO public.virksomhet VALUES (400, '849262935', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849262935', '{adresse}', 'AKTIV', '2023-01-01', 849262936, '2023-09-27 12:47:43.451435', '2023-09-27 12:47:43.451435');
INSERT INTO public.virksomhet VALUES (401, '806920595', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806920595', '{adresse}', 'AKTIV', '2023-01-01', 806920596, '2023-09-27 12:47:43.456414', '2023-09-27 12:47:43.456414');
INSERT INTO public.virksomhet VALUES (402, '880756394', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880756394', '{adresse}', 'AKTIV', '2023-01-01', 880756395, '2023-09-27 12:47:43.457559', '2023-09-27 12:47:43.457559');
INSERT INTO public.virksomhet VALUES (403, '880104024', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880104024', '{adresse}', 'AKTIV', '2023-01-01', 880104025, '2023-09-27 12:47:43.458674', '2023-09-27 12:47:43.458674');
INSERT INTO public.virksomhet VALUES (404, '801556211', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801556211', '{adresse}', 'AKTIV', '2023-01-01', 801556212, '2023-09-27 12:47:43.459849', '2023-09-27 12:47:43.459849');
INSERT INTO public.virksomhet VALUES (405, '819264022', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819264022', '{adresse}', 'AKTIV', '2023-01-01', 819264023, '2023-09-27 12:47:43.460922', '2023-09-27 12:47:43.460922');
INSERT INTO public.virksomhet VALUES (406, '848716349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848716349', '{adresse}', 'AKTIV', '2023-01-01', 848716350, '2023-09-27 12:47:43.465066', '2023-09-27 12:47:43.465066');
INSERT INTO public.virksomhet VALUES (407, '825277344', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825277344', '{adresse}', 'AKTIV', '2023-01-01', 825277345, '2023-09-27 12:47:43.466714', '2023-09-27 12:47:43.466714');
INSERT INTO public.virksomhet VALUES (408, '819827494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819827494', '{adresse}', 'AKTIV', '2023-01-01', 819827495, '2023-09-27 12:47:43.467656', '2023-09-27 12:47:43.467656');
INSERT INTO public.virksomhet VALUES (409, '846662600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846662600', '{adresse}', 'AKTIV', '2023-01-01', 846662601, '2023-09-27 12:47:43.473477', '2023-09-27 12:47:43.473477');
INSERT INTO public.virksomhet VALUES (410, '874024359', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874024359', '{adresse}', 'AKTIV', '2023-01-01', 874024360, '2023-09-27 12:47:43.47443', '2023-09-27 12:47:43.47443');
INSERT INTO public.virksomhet VALUES (411, '821366281', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821366281', '{adresse}', 'AKTIV', '2023-01-01', 821366282, '2023-09-27 12:47:43.476324', '2023-09-27 12:47:43.476324');
INSERT INTO public.virksomhet VALUES (412, '808210382', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808210382', '{adresse}', 'AKTIV', '2023-01-01', 808210383, '2023-09-27 12:47:43.478118', '2023-09-27 12:47:43.478118');
INSERT INTO public.virksomhet VALUES (413, '826428237', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826428237', '{adresse}', 'AKTIV', '2023-01-01', 826428238, '2023-09-27 12:47:43.483113', '2023-09-27 12:47:43.483113');
INSERT INTO public.virksomhet VALUES (414, '815054956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815054956', '{adresse}', 'AKTIV', '2023-01-01', 815054957, '2023-09-27 12:47:43.484296', '2023-09-27 12:47:43.484296');
INSERT INTO public.virksomhet VALUES (415, '818328814', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818328814', '{adresse}', 'AKTIV', '2023-01-01', 818328815, '2023-09-27 12:47:43.485588', '2023-09-27 12:47:43.485588');
INSERT INTO public.virksomhet VALUES (416, '807556210', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807556210', '{adresse}', 'AKTIV', '2023-01-01', 807556211, '2023-09-27 12:47:43.486854', '2023-09-27 12:47:43.486854');
INSERT INTO public.virksomhet VALUES (417, '871418690', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871418690', '{adresse}', 'AKTIV', '2023-01-01', 871418691, '2023-09-27 12:47:43.492622', '2023-09-27 12:47:43.492622');
INSERT INTO public.virksomhet VALUES (418, '813082052', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813082052', '{adresse}', 'AKTIV', '2023-01-01', 813082053, '2023-09-27 12:47:43.494303', '2023-09-27 12:47:43.494303');
INSERT INTO public.virksomhet VALUES (419, '806846003', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806846003', '{adresse}', 'AKTIV', '2023-01-01', 806846004, '2023-09-27 12:47:43.495195', '2023-09-27 12:47:43.495195');
INSERT INTO public.virksomhet VALUES (420, '824330847', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824330847', '{adresse}', 'AKTIV', '2023-01-01', 824330848, '2023-09-27 12:47:43.496603', '2023-09-27 12:47:43.496603');
INSERT INTO public.virksomhet VALUES (421, '826690138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826690138', '{adresse}', 'AKTIV', '2023-01-01', 826690139, '2023-09-27 12:47:43.50162', '2023-09-27 12:47:43.50162');
INSERT INTO public.virksomhet VALUES (422, '856403693', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856403693', '{adresse}', 'AKTIV', '2023-01-01', 856403694, '2023-09-27 12:47:43.502919', '2023-09-27 12:47:43.502919');
INSERT INTO public.virksomhet VALUES (423, '816621697', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816621697', '{adresse}', 'AKTIV', '2023-01-01', 816621698, '2023-09-27 12:47:43.504479', '2023-09-27 12:47:43.504479');
INSERT INTO public.virksomhet VALUES (424, '816554758', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816554758', '{adresse}', 'AKTIV', '2023-01-01', 816554759, '2023-09-27 12:47:43.511468', '2023-09-27 12:47:43.511468');
INSERT INTO public.virksomhet VALUES (425, '857535371', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857535371', '{adresse}', 'AKTIV', '2023-01-01', 857535372, '2023-09-27 12:47:43.512581', '2023-09-27 12:47:43.512581');
INSERT INTO public.virksomhet VALUES (426, '823784313', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823784313', '{adresse}', 'AKTIV', '2023-01-01', 823784314, '2023-09-27 12:47:43.514396', '2023-09-27 12:47:43.514396');
INSERT INTO public.virksomhet VALUES (427, '891396939', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891396939', '{adresse}', 'AKTIV', '2023-01-01', 891396940, '2023-09-27 12:47:43.515579', '2023-09-27 12:47:43.515579');
INSERT INTO public.virksomhet VALUES (428, '890803412', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890803412', '{adresse}', 'AKTIV', '2023-01-01', 890803413, '2023-09-27 12:47:43.520566', '2023-09-27 12:47:43.520566');
INSERT INTO public.virksomhet VALUES (429, '864310341', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864310341', '{adresse}', 'AKTIV', '2023-01-01', 864310342, '2023-09-27 12:47:43.522125', '2023-09-27 12:47:43.522125');
INSERT INTO public.virksomhet VALUES (430, '852154283', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852154283', '{adresse}', 'AKTIV', '2023-01-01', 852154284, '2023-09-27 12:47:43.523104', '2023-09-27 12:47:43.523104');
INSERT INTO public.virksomhet VALUES (431, '845274259', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845274259', '{adresse}', 'AKTIV', '2023-01-01', 845274260, '2023-09-27 12:47:43.52417', '2023-09-27 12:47:43.52417');
INSERT INTO public.virksomhet VALUES (432, '845587063', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845587063', '{adresse}', 'AKTIV', '2023-01-01', 845587064, '2023-09-27 12:47:43.525646', '2023-09-27 12:47:43.525646');
INSERT INTO public.virksomhet VALUES (433, '827331930', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827331930', '{adresse}', 'AKTIV', '2023-01-01', 827331931, '2023-09-27 12:47:43.530878', '2023-09-27 12:47:43.530878');
INSERT INTO public.virksomhet VALUES (434, '869238003', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869238003', '{adresse}', 'AKTIV', '2023-01-01', 869238004, '2023-09-27 12:47:43.532075', '2023-09-27 12:47:43.532075');
INSERT INTO public.virksomhet VALUES (435, '852723183', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852723183', '{adresse}', 'AKTIV', '2023-01-01', 852723184, '2023-09-27 12:47:43.533481', '2023-09-27 12:47:43.533481');
INSERT INTO public.virksomhet VALUES (436, '815069674', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815069674', '{adresse}', 'AKTIV', '2023-01-01', 815069675, '2023-09-27 12:47:43.538738', '2023-09-27 12:47:43.538738');
INSERT INTO public.virksomhet VALUES (437, '824320547', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824320547', '{adresse}', 'AKTIV', '2023-01-01', 824320548, '2023-09-27 12:47:43.540269', '2023-09-27 12:47:43.540269');
INSERT INTO public.virksomhet VALUES (438, '858685635', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858685635', '{adresse}', 'AKTIV', '2023-01-01', 858685636, '2023-09-27 12:47:43.541654', '2023-09-27 12:47:43.541654');
INSERT INTO public.virksomhet VALUES (439, '829626868', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829626868', '{adresse}', 'AKTIV', '2023-01-01', 829626869, '2023-09-27 12:47:43.543015', '2023-09-27 12:47:43.543015');
INSERT INTO public.virksomhet VALUES (440, '869197746', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869197746', '{adresse}', 'AKTIV', '2023-01-01', 869197747, '2023-09-27 12:47:43.548488', '2023-09-27 12:47:43.548488');
INSERT INTO public.virksomhet VALUES (441, '896311843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896311843', '{adresse}', 'AKTIV', '2023-01-01', 896311844, '2023-09-27 12:47:43.549782', '2023-09-27 12:47:43.549782');
INSERT INTO public.virksomhet VALUES (442, '872643712', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872643712', '{adresse}', 'AKTIV', '2023-01-01', 872643713, '2023-09-27 12:47:43.551159', '2023-09-27 12:47:43.551159');
INSERT INTO public.virksomhet VALUES (443, '829662663', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829662663', '{adresse}', 'AKTIV', '2023-01-01', 829662664, '2023-09-27 12:47:43.5535', '2023-09-27 12:47:43.5535');
INSERT INTO public.virksomhet VALUES (444, '845972124', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845972124', '{adresse}', 'AKTIV', '2023-01-01', 845972125, '2023-09-27 12:47:43.56139', '2023-09-27 12:47:43.56139');
INSERT INTO public.virksomhet VALUES (445, '848464680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848464680', '{adresse}', 'AKTIV', '2023-01-01', 848464681, '2023-09-27 12:47:43.562773', '2023-09-27 12:47:43.562773');
INSERT INTO public.virksomhet VALUES (446, '820268569', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820268569', '{adresse}', 'AKTIV', '2023-01-01', 820268570, '2023-09-27 12:47:43.563677', '2023-09-27 12:47:43.563677');
INSERT INTO public.virksomhet VALUES (447, '820015256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820015256', '{adresse}', 'AKTIV', '2023-01-01', 820015257, '2023-09-27 12:47:43.564788', '2023-09-27 12:47:43.564788');
INSERT INTO public.virksomhet VALUES (448, '844573903', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844573903', '{adresse}', 'AKTIV', '2023-01-01', 844573904, '2023-09-27 12:47:43.569459', '2023-09-27 12:47:43.569459');
INSERT INTO public.virksomhet VALUES (449, '882085748', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882085748', '{adresse}', 'AKTIV', '2023-01-01', 882085749, '2023-09-27 12:47:43.571441', '2023-09-27 12:47:43.571441');
INSERT INTO public.virksomhet VALUES (450, '867428946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867428946', '{adresse}', 'AKTIV', '2023-01-01', 867428947, '2023-09-27 12:47:43.572777', '2023-09-27 12:47:43.572777');
INSERT INTO public.virksomhet VALUES (451, '871031437', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871031437', '{adresse}', 'AKTIV', '2023-01-01', 871031438, '2023-09-27 12:47:43.573805', '2023-09-27 12:47:43.573805');
INSERT INTO public.virksomhet VALUES (452, '843532169', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843532169', '{adresse}', 'AKTIV', '2023-01-01', 843532170, '2023-09-27 12:47:43.575538', '2023-09-27 12:47:43.575538');
INSERT INTO public.virksomhet VALUES (453, '857146415', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857146415', '{adresse}', 'AKTIV', '2023-01-01', 857146416, '2023-09-27 12:47:43.577077', '2023-09-27 12:47:43.577077');
INSERT INTO public.virksomhet VALUES (454, '858809768', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858809768', '{adresse}', 'AKTIV', '2023-01-01', 858809769, '2023-09-27 12:47:43.579051', '2023-09-27 12:47:43.579051');
INSERT INTO public.virksomhet VALUES (455, '876716164', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876716164', '{adresse}', 'AKTIV', '2023-01-01', 876716165, '2023-09-27 12:47:43.583662', '2023-09-27 12:47:43.583662');
INSERT INTO public.virksomhet VALUES (456, '819492088', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819492088', '{adresse}', 'AKTIV', '2023-01-01', 819492089, '2023-09-27 12:47:43.584885', '2023-09-27 12:47:43.584885');
INSERT INTO public.virksomhet VALUES (457, '838239624', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838239624', '{adresse}', 'AKTIV', '2023-01-01', 838239625, '2023-09-27 12:47:43.585919', '2023-09-27 12:47:43.585919');
INSERT INTO public.virksomhet VALUES (458, '885945837', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885945837', '{adresse}', 'AKTIV', '2023-01-01', 885945838, '2023-09-27 12:47:43.58677', '2023-09-27 12:47:43.58677');
INSERT INTO public.virksomhet VALUES (459, '861498828', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861498828', '{adresse}', 'AKTIV', '2023-01-01', 861498829, '2023-09-27 12:47:43.591571', '2023-09-27 12:47:43.591571');
INSERT INTO public.virksomhet VALUES (460, '801804711', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801804711', '{adresse}', 'AKTIV', '2023-01-01', 801804712, '2023-09-27 12:47:43.593047', '2023-09-27 12:47:43.593047');
INSERT INTO public.virksomhet VALUES (461, '833509017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833509017', '{adresse}', 'AKTIV', '2023-01-01', 833509018, '2023-09-27 12:47:43.594317', '2023-09-27 12:47:43.594317');
INSERT INTO public.virksomhet VALUES (462, '827952461', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827952461', '{adresse}', 'AKTIV', '2023-01-01', 827952462, '2023-09-27 12:47:43.595683', '2023-09-27 12:47:43.595683');
INSERT INTO public.virksomhet VALUES (463, '899971016', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899971016', '{adresse}', 'AKTIV', '2023-01-01', 899971017, '2023-09-27 12:47:43.599991', '2023-09-27 12:47:43.599991');
INSERT INTO public.virksomhet VALUES (464, '851522918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851522918', '{adresse}', 'AKTIV', '2023-01-01', 851522919, '2023-09-27 12:47:43.603307', '2023-09-27 12:47:43.603307');
INSERT INTO public.virksomhet VALUES (465, '876958842', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876958842', '{adresse}', 'AKTIV', '2023-01-01', 876958843, '2023-09-27 12:47:43.604359', '2023-09-27 12:47:43.604359');
INSERT INTO public.virksomhet VALUES (466, '800056603', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800056603', '{adresse}', 'AKTIV', '2023-01-01', 800056604, '2023-09-27 12:47:43.605545', '2023-09-27 12:47:43.605545');
INSERT INTO public.virksomhet VALUES (467, '843586867', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843586867', '{adresse}', 'AKTIV', '2023-01-01', 843586868, '2023-09-27 12:47:43.609964', '2023-09-27 12:47:43.609964');
INSERT INTO public.virksomhet VALUES (468, '823345513', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823345513', '{adresse}', 'AKTIV', '2023-01-01', 823345514, '2023-09-27 12:47:43.611384', '2023-09-27 12:47:43.611384');
INSERT INTO public.virksomhet VALUES (469, '848090389', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848090389', '{adresse}', 'AKTIV', '2023-01-01', 848090390, '2023-09-27 12:47:43.612461', '2023-09-27 12:47:43.612461');
INSERT INTO public.virksomhet VALUES (470, '813124156', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813124156', '{adresse}', 'AKTIV', '2023-01-01', 813124157, '2023-09-27 12:47:43.612942', '2023-09-27 12:47:43.612942');
INSERT INTO public.virksomhet VALUES (471, '806937760', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806937760', '{adresse}', 'AKTIV', '2023-01-01', 806937761, '2023-09-27 12:47:43.618544', '2023-09-27 12:47:43.618544');
INSERT INTO public.virksomhet VALUES (472, '804492254', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804492254', '{adresse}', 'AKTIV', '2023-01-01', 804492255, '2023-09-27 12:47:43.62059', '2023-09-27 12:47:43.62059');
INSERT INTO public.virksomhet VALUES (473, '850961994', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850961994', '{adresse}', 'AKTIV', '2023-01-01', 850961995, '2023-09-27 12:47:43.621573', '2023-09-27 12:47:43.621573');
INSERT INTO public.virksomhet VALUES (474, '811452235', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811452235', '{adresse}', 'AKTIV', '2023-01-01', 811452236, '2023-09-27 12:47:43.622433', '2023-09-27 12:47:43.622433');
INSERT INTO public.virksomhet VALUES (475, '800196588', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800196588', '{adresse}', 'AKTIV', '2023-01-01', 800196589, '2023-09-27 12:47:43.623249', '2023-09-27 12:47:43.623249');
INSERT INTO public.virksomhet VALUES (476, '824251872', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824251872', '{adresse}', 'AKTIV', '2023-01-01', 824251873, '2023-09-27 12:47:43.62817', '2023-09-27 12:47:43.62817');
INSERT INTO public.virksomhet VALUES (477, '805680022', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805680022', '{adresse}', 'AKTIV', '2023-01-01', 805680023, '2023-09-27 12:47:43.629441', '2023-09-27 12:47:43.629441');
INSERT INTO public.virksomhet VALUES (478, '802238763', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802238763', '{adresse}', 'AKTIV', '2023-01-01', 802238764, '2023-09-27 12:47:43.630469', '2023-09-27 12:47:43.630469');
INSERT INTO public.virksomhet VALUES (479, '897656556', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897656556', '{adresse}', 'AKTIV', '2023-01-01', 897656557, '2023-09-27 12:47:43.631431', '2023-09-27 12:47:43.631431');
INSERT INTO public.virksomhet VALUES (480, '888995913', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888995913', '{adresse}', 'AKTIV', '2023-01-01', 888995914, '2023-09-27 12:47:43.636823', '2023-09-27 12:47:43.636823');
INSERT INTO public.virksomhet VALUES (481, '867259951', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867259951', '{adresse}', 'AKTIV', '2023-01-01', 867259952, '2023-09-27 12:47:43.639337', '2023-09-27 12:47:43.639337');
INSERT INTO public.virksomhet VALUES (482, '820227377', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820227377', '{adresse}', 'AKTIV', '2023-01-01', 820227378, '2023-09-27 12:47:43.640501', '2023-09-27 12:47:43.640501');
INSERT INTO public.virksomhet VALUES (483, '882903192', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882903192', '{adresse}', 'AKTIV', '2023-01-01', 882903193, '2023-09-27 12:47:43.641418', '2023-09-27 12:47:43.641418');
INSERT INTO public.virksomhet VALUES (484, '879854654', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879854654', '{adresse}', 'AKTIV', '2023-01-01', 879854655, '2023-09-27 12:47:43.642503', '2023-09-27 12:47:43.642503');
INSERT INTO public.virksomhet VALUES (485, '873775499', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873775499', '{adresse}', 'AKTIV', '2023-01-01', 873775500, '2023-09-27 12:47:43.647029', '2023-09-27 12:47:43.647029');
INSERT INTO public.virksomhet VALUES (486, '875055030', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875055030', '{adresse}', 'AKTIV', '2023-01-01', 875055031, '2023-09-27 12:47:43.648566', '2023-09-27 12:47:43.648566');
INSERT INTO public.virksomhet VALUES (487, '815969576', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815969576', '{adresse}', 'AKTIV', '2023-01-01', 815969577, '2023-09-27 12:47:43.649407', '2023-09-27 12:47:43.649407');
INSERT INTO public.virksomhet VALUES (488, '881921956', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881921956', '{adresse}', 'AKTIV', '2023-01-01', 881921957, '2023-09-27 12:47:43.650227', '2023-09-27 12:47:43.650227');
INSERT INTO public.virksomhet VALUES (489, '849890085', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849890085', '{adresse}', 'AKTIV', '2023-01-01', 849890086, '2023-09-27 12:47:43.650976', '2023-09-27 12:47:43.650976');
INSERT INTO public.virksomhet VALUES (490, '826229102', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826229102', '{adresse}', 'AKTIV', '2023-01-01', 826229103, '2023-09-27 12:47:43.655616', '2023-09-27 12:47:43.655616');
INSERT INTO public.virksomhet VALUES (491, '836656384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836656384', '{adresse}', 'AKTIV', '2023-01-01', 836656385, '2023-09-27 12:47:43.656512', '2023-09-27 12:47:43.656512');
INSERT INTO public.virksomhet VALUES (492, '888666767', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888666767', '{adresse}', 'AKTIV', '2023-01-01', 888666768, '2023-09-27 12:47:43.657033', '2023-09-27 12:47:43.657033');
INSERT INTO public.virksomhet VALUES (493, '876273225', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876273225', '{adresse}', 'AKTIV', '2023-01-01', 876273226, '2023-09-27 12:47:43.658282', '2023-09-27 12:47:43.658282');
INSERT INTO public.virksomhet VALUES (494, '828273134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828273134', '{adresse}', 'AKTIV', '2023-01-01', 828273135, '2023-09-27 12:47:43.658883', '2023-09-27 12:47:43.658883');
INSERT INTO public.virksomhet VALUES (495, '875963341', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875963341', '{adresse}', 'AKTIV', '2023-01-01', 875963342, '2023-09-27 12:47:43.663451', '2023-09-27 12:47:43.663451');
INSERT INTO public.virksomhet VALUES (496, '868652293', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868652293', '{adresse}', 'AKTIV', '2023-01-01', 868652294, '2023-09-27 12:47:43.66456', '2023-09-27 12:47:43.66456');
INSERT INTO public.virksomhet VALUES (497, '883630024', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883630024', '{adresse}', 'AKTIV', '2023-01-01', 883630025, '2023-09-27 12:47:43.665364', '2023-09-27 12:47:43.665364');
INSERT INTO public.virksomhet VALUES (498, '840784333', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840784333', '{adresse}', 'AKTIV', '2023-01-01', 840784334, '2023-09-27 12:47:43.666637', '2023-09-27 12:47:43.666637');
INSERT INTO public.virksomhet VALUES (499, '808962472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808962472', '{adresse}', 'AKTIV', '2023-01-01', 808962473, '2023-09-27 12:47:43.667709', '2023-09-27 12:47:43.667709');
INSERT INTO public.virksomhet VALUES (500, '814148414', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814148414', '{adresse}', 'AKTIV', '2023-01-01', 814148415, '2023-09-27 12:47:43.672097', '2023-09-27 12:47:43.672097');
INSERT INTO public.virksomhet VALUES (501, '831273899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831273899', '{adresse}', 'AKTIV', '2023-01-01', 831273900, '2023-09-27 12:47:43.673303', '2023-09-27 12:47:43.673303');
INSERT INTO public.virksomhet VALUES (502, '891530477', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891530477', '{adresse}', 'AKTIV', '2023-01-01', 891530478, '2023-09-27 12:47:43.674524', '2023-09-27 12:47:43.674524');
INSERT INTO public.virksomhet VALUES (503, '828050340', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828050340', '{adresse}', 'AKTIV', '2023-01-01', 828050341, '2023-09-27 12:47:43.675343', '2023-09-27 12:47:43.675343');
INSERT INTO public.virksomhet VALUES (504, '852320416', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852320416', '{adresse}', 'AKTIV', '2023-01-01', 852320417, '2023-09-27 12:47:43.680018', '2023-09-27 12:47:43.680018');
INSERT INTO public.virksomhet VALUES (505, '888715453', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888715453', '{adresse}', 'AKTIV', '2023-01-01', 888715454, '2023-09-27 12:47:43.681173', '2023-09-27 12:47:43.681173');
INSERT INTO public.virksomhet VALUES (506, '851324073', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851324073', '{adresse}', 'AKTIV', '2023-01-01', 851324074, '2023-09-27 12:47:43.682265', '2023-09-27 12:47:43.682265');
INSERT INTO public.virksomhet VALUES (507, '860093107', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860093107', '{adresse}', 'AKTIV', '2023-01-01', 860093108, '2023-09-27 12:47:43.686577', '2023-09-27 12:47:43.686577');
INSERT INTO public.virksomhet VALUES (508, '871363593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871363593', '{adresse}', 'AKTIV', '2023-01-01', 871363594, '2023-09-27 12:47:43.688297', '2023-09-27 12:47:43.688297');
INSERT INTO public.virksomhet VALUES (509, '871257202', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871257202', '{adresse}', 'AKTIV', '2023-01-01', 871257203, '2023-09-27 12:47:43.689631', '2023-09-27 12:47:43.689631');
INSERT INTO public.virksomhet VALUES (510, '897037627', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897037627', '{adresse}', 'AKTIV', '2023-01-01', 897037628, '2023-09-27 12:47:43.690795', '2023-09-27 12:47:43.690795');
INSERT INTO public.virksomhet VALUES (511, '880765618', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880765618', '{adresse}', 'AKTIV', '2023-01-01', 880765619, '2023-09-27 12:47:43.695986', '2023-09-27 12:47:43.695986');


--
-- Data for Name: virksomhet_naringsundergrupper; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_naringsundergrupper VALUES (1, 1, '90.012', NULL, NULL, '2023-09-27 12:47:42.395402', '2023-09-27 12:47:42.395402');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (2, 2, '70.220', '90.012', NULL, '2023-09-27 12:47:42.40386', '2023-09-27 12:47:42.40386');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (3, 3, '90.012', '70.220', NULL, '2023-09-27 12:47:42.410456', '2023-09-27 12:47:42.410456');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (4, 4, '90.012', NULL, NULL, '2023-09-27 12:47:42.412053', '2023-09-27 12:47:42.412053');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (5, 5, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.423138', '2023-09-27 12:47:42.423138');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (6, 6, '01.120', NULL, NULL, '2023-09-27 12:47:42.424414', '2023-09-27 12:47:42.424414');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (7, 7, '01.120', NULL, NULL, '2023-09-27 12:47:42.425378', '2023-09-27 12:47:42.425378');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (8, 8, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.426563', '2023-09-27 12:47:42.426563');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (9, 9, '01.120', NULL, NULL, '2023-09-27 12:47:42.42777', '2023-09-27 12:47:42.42777');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (10, 10, '88.911', '90.012', NULL, '2023-09-27 12:47:42.429123', '2023-09-27 12:47:42.429123');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (11, 11, '01.120', NULL, NULL, '2023-09-27 12:47:42.430025', '2023-09-27 12:47:42.430025');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (12, 12, '01.120', NULL, NULL, '2023-09-27 12:47:42.430945', '2023-09-27 12:47:42.430945');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (13, 13, '01.120', NULL, NULL, '2023-09-27 12:47:42.431675', '2023-09-27 12:47:42.431675');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (14, 14, '01.120', NULL, NULL, '2023-09-27 12:47:42.437886', '2023-09-27 12:47:42.437886');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (15, 15, '01.120', '90.012', NULL, '2023-09-27 12:47:42.439043', '2023-09-27 12:47:42.439043');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (16, 16, '01.120', NULL, NULL, '2023-09-27 12:47:42.439732', '2023-09-27 12:47:42.439732');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (17, 17, '01.120', '90.012', NULL, '2023-09-27 12:47:42.445772', '2023-09-27 12:47:42.445772');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (18, 18, '01.120', NULL, NULL, '2023-09-27 12:47:42.44698', '2023-09-27 12:47:42.44698');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (19, 19, '01.120', '90.012', NULL, '2023-09-27 12:47:42.448705', '2023-09-27 12:47:42.448705');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (20, 20, '01.120', '90.012', NULL, '2023-09-27 12:47:42.449882', '2023-09-27 12:47:42.449882');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (21, 21, '01.120', NULL, NULL, '2023-09-27 12:47:42.451084', '2023-09-27 12:47:42.451084');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (22, 22, '01.120', '90.012', NULL, '2023-09-27 12:47:42.452414', '2023-09-27 12:47:42.452414');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (23, 23, '01.120', '90.012', NULL, '2023-09-27 12:47:42.453364', '2023-09-27 12:47:42.453364');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (24, 24, '01.120', NULL, NULL, '2023-09-27 12:47:42.454159', '2023-09-27 12:47:42.454159');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (25, 25, '01.120', NULL, NULL, '2023-09-27 12:47:42.455378', '2023-09-27 12:47:42.455378');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (26, 26, '01.120', '90.012', NULL, '2023-09-27 12:47:42.456221', '2023-09-27 12:47:42.456221');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (27, 27, '01.120', NULL, NULL, '2023-09-27 12:47:42.464649', '2023-09-27 12:47:42.464649');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (28, 28, '01.120', '90.012', NULL, '2023-09-27 12:47:42.465953', '2023-09-27 12:47:42.465953');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (29, 29, '01.120', NULL, NULL, '2023-09-27 12:47:42.467109', '2023-09-27 12:47:42.467109');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (30, 30, '01.120', '90.012', NULL, '2023-09-27 12:47:42.467916', '2023-09-27 12:47:42.467916');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (31, 31, '01.120', NULL, NULL, '2023-09-27 12:47:42.474392', '2023-09-27 12:47:42.474392');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (32, 32, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.475399', '2023-09-27 12:47:42.475399');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (33, 33, '01.120', '90.012', NULL, '2023-09-27 12:47:42.476253', '2023-09-27 12:47:42.476253');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (34, 34, '01.120', '90.012', NULL, '2023-09-27 12:47:42.479033', '2023-09-27 12:47:42.479033');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (35, 35, '01.120', '90.012', NULL, '2023-09-27 12:47:42.490305', '2023-09-27 12:47:42.490305');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (36, 36, '01.120', NULL, NULL, '2023-09-27 12:47:42.492782', '2023-09-27 12:47:42.492782');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (37, 37, '01.120', '90.012', NULL, '2023-09-27 12:47:42.494701', '2023-09-27 12:47:42.494701');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (38, 38, '01.120', '90.012', NULL, '2023-09-27 12:47:42.496984', '2023-09-27 12:47:42.496984');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (39, 39, '01.120', NULL, NULL, '2023-09-27 12:47:42.498605', '2023-09-27 12:47:42.498605');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (40, 40, '01.120', '90.012', NULL, '2023-09-27 12:47:42.504442', '2023-09-27 12:47:42.504442');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (41, 41, '01.120', NULL, NULL, '2023-09-27 12:47:42.505498', '2023-09-27 12:47:42.505498');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (42, 42, '01.120', NULL, NULL, '2023-09-27 12:47:42.506484', '2023-09-27 12:47:42.506484');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (43, 43, '01.120', '90.012', NULL, '2023-09-27 12:47:42.513676', '2023-09-27 12:47:42.513676');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (44, 44, '01.120', NULL, NULL, '2023-09-27 12:47:42.514957', '2023-09-27 12:47:42.514957');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (45, 45, '01.120', NULL, NULL, '2023-09-27 12:47:42.516052', '2023-09-27 12:47:42.516052');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (46, 46, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.517509', '2023-09-27 12:47:42.517509');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (47, 47, '01.120', NULL, NULL, '2023-09-27 12:47:42.519823', '2023-09-27 12:47:42.519823');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (48, 48, '01.120', '90.012', NULL, '2023-09-27 12:47:42.522134', '2023-09-27 12:47:42.522134');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (49, 49, '01.120', '90.012', NULL, '2023-09-27 12:47:42.524186', '2023-09-27 12:47:42.524186');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (50, 50, '01.120', '90.012', NULL, '2023-09-27 12:47:42.52591', '2023-09-27 12:47:42.52591');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (51, 51, '01.120', NULL, NULL, '2023-09-27 12:47:42.527352', '2023-09-27 12:47:42.527352');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (52, 52, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.535392', '2023-09-27 12:47:42.535392');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (53, 53, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.537366', '2023-09-27 12:47:42.537366');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (54, 54, '01.120', NULL, NULL, '2023-09-27 12:47:42.545899', '2023-09-27 12:47:42.545899');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (55, 55, '01.120', '90.012', NULL, '2023-09-27 12:47:42.549409', '2023-09-27 12:47:42.549409');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (56, 56, '01.120', NULL, NULL, '2023-09-27 12:47:42.551707', '2023-09-27 12:47:42.551707');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (57, 57, '01.120', '90.012', NULL, '2023-09-27 12:47:42.553503', '2023-09-27 12:47:42.553503');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (58, 58, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.555559', '2023-09-27 12:47:42.555559');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (59, 59, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.558144', '2023-09-27 12:47:42.558144');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (60, 60, '01.120', NULL, NULL, '2023-09-27 12:47:42.55984', '2023-09-27 12:47:42.55984');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (61, 61, '01.120', NULL, NULL, '2023-09-27 12:47:42.562212', '2023-09-27 12:47:42.562212');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (62, 62, '01.120', NULL, NULL, '2023-09-27 12:47:42.565', '2023-09-27 12:47:42.565');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (63, 63, '01.120', '90.012', NULL, '2023-09-27 12:47:42.57375', '2023-09-27 12:47:42.57375');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (64, 64, '01.120', '90.012', NULL, '2023-09-27 12:47:42.575359', '2023-09-27 12:47:42.575359');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (65, 65, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.57689', '2023-09-27 12:47:42.57689');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (66, 66, '01.120', NULL, NULL, '2023-09-27 12:47:42.578427', '2023-09-27 12:47:42.578427');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (67, 67, '01.120', NULL, NULL, '2023-09-27 12:47:42.58662', '2023-09-27 12:47:42.58662');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (68, 68, '01.120', NULL, NULL, '2023-09-27 12:47:42.588026', '2023-09-27 12:47:42.588026');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (69, 69, '01.120', NULL, NULL, '2023-09-27 12:47:42.589465', '2023-09-27 12:47:42.589465');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (70, 70, '01.120', NULL, NULL, '2023-09-27 12:47:42.591275', '2023-09-27 12:47:42.591275');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (71, 71, '01.120', NULL, NULL, '2023-09-27 12:47:42.593049', '2023-09-27 12:47:42.593049');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (72, 72, '01.120', '90.012', NULL, '2023-09-27 12:47:42.594749', '2023-09-27 12:47:42.594749');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (73, 73, '01.120', '90.012', NULL, '2023-09-27 12:47:42.595921', '2023-09-27 12:47:42.595921');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (74, 74, '01.120', NULL, NULL, '2023-09-27 12:47:42.597904', '2023-09-27 12:47:42.597904');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (75, 75, '01.120', NULL, NULL, '2023-09-27 12:47:42.599214', '2023-09-27 12:47:42.599214');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (76, 76, '01.120', NULL, NULL, '2023-09-27 12:47:42.605316', '2023-09-27 12:47:42.605316');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (77, 77, '01.120', '90.012', NULL, '2023-09-27 12:47:42.606938', '2023-09-27 12:47:42.606938');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (78, 78, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.608601', '2023-09-27 12:47:42.608601');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (79, 79, '01.120', NULL, NULL, '2023-09-27 12:47:42.609802', '2023-09-27 12:47:42.609802');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (80, 80, '01.120', NULL, NULL, '2023-09-27 12:47:42.620488', '2023-09-27 12:47:42.620488');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (81, 81, '01.120', '90.012', NULL, '2023-09-27 12:47:42.621812', '2023-09-27 12:47:42.621812');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (82, 82, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.623059', '2023-09-27 12:47:42.623059');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (83, 83, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.624591', '2023-09-27 12:47:42.624591');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (84, 84, '01.120', '90.012', NULL, '2023-09-27 12:47:42.626574', '2023-09-27 12:47:42.626574');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (85, 85, '01.120', NULL, NULL, '2023-09-27 12:47:42.628749', '2023-09-27 12:47:42.628749');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (86, 86, '01.120', NULL, NULL, '2023-09-27 12:47:42.633506', '2023-09-27 12:47:42.633506');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (87, 87, '01.120', NULL, NULL, '2023-09-27 12:47:42.641081', '2023-09-27 12:47:42.641081');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (88, 88, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.64277', '2023-09-27 12:47:42.64277');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (89, 89, '01.120', NULL, NULL, '2023-09-27 12:47:42.64442', '2023-09-27 12:47:42.64442');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (90, 90, '01.120', NULL, NULL, '2023-09-27 12:47:42.645605', '2023-09-27 12:47:42.645605');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (91, 91, '01.120', NULL, NULL, '2023-09-27 12:47:42.652854', '2023-09-27 12:47:42.652854');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (92, 92, '01.120', NULL, NULL, '2023-09-27 12:47:42.654663', '2023-09-27 12:47:42.654663');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (93, 93, '01.120', NULL, NULL, '2023-09-27 12:47:42.655918', '2023-09-27 12:47:42.655918');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (94, 94, '01.120', '90.012', NULL, '2023-09-27 12:47:42.664014', '2023-09-27 12:47:42.664014');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (95, 95, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.66582', '2023-09-27 12:47:42.66582');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (96, 96, '01.120', NULL, NULL, '2023-09-27 12:47:42.667365', '2023-09-27 12:47:42.667365');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (97, 97, '01.120', NULL, NULL, '2023-09-27 12:47:42.668694', '2023-09-27 12:47:42.668694');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (98, 98, '01.120', '90.012', NULL, '2023-09-27 12:47:42.676659', '2023-09-27 12:47:42.676659');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (99, 99, '01.120', '90.012', NULL, '2023-09-27 12:47:42.678029', '2023-09-27 12:47:42.678029');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (100, 100, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.679412', '2023-09-27 12:47:42.679412');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (101, 101, '01.120', '90.012', NULL, '2023-09-27 12:47:42.681047', '2023-09-27 12:47:42.681047');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (102, 102, '01.120', '90.012', NULL, '2023-09-27 12:47:42.682814', '2023-09-27 12:47:42.682814');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (103, 103, '01.120', NULL, NULL, '2023-09-27 12:47:42.692245', '2023-09-27 12:47:42.692245');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (104, 104, '01.120', NULL, NULL, '2023-09-27 12:47:42.693592', '2023-09-27 12:47:42.693592');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (105, 105, '01.120', '90.012', NULL, '2023-09-27 12:47:42.694949', '2023-09-27 12:47:42.694949');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (106, 106, '01.120', NULL, NULL, '2023-09-27 12:47:42.696481', '2023-09-27 12:47:42.696481');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (107, 107, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.697828', '2023-09-27 12:47:42.697828');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (108, 108, '01.120', NULL, NULL, '2023-09-27 12:47:42.706453', '2023-09-27 12:47:42.706453');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (109, 109, '01.120', '90.012', NULL, '2023-09-27 12:47:42.70795', '2023-09-27 12:47:42.70795');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (110, 110, '01.120', '90.012', NULL, '2023-09-27 12:47:42.709189', '2023-09-27 12:47:42.709189');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (111, 111, '01.120', NULL, NULL, '2023-09-27 12:47:42.711167', '2023-09-27 12:47:42.711167');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (112, 112, '01.120', NULL, NULL, '2023-09-27 12:47:42.712496', '2023-09-27 12:47:42.712496');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (113, 113, '01.120', '90.012', NULL, '2023-09-27 12:47:42.720354', '2023-09-27 12:47:42.720354');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (114, 114, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.723245', '2023-09-27 12:47:42.723245');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (115, 115, '01.120', NULL, NULL, '2023-09-27 12:47:42.725368', '2023-09-27 12:47:42.725368');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (116, 116, '01.120', NULL, NULL, '2023-09-27 12:47:42.726574', '2023-09-27 12:47:42.726574');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (117, 117, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.728417', '2023-09-27 12:47:42.728417');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (118, 118, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.736058', '2023-09-27 12:47:42.736058');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (119, 119, '01.120', NULL, NULL, '2023-09-27 12:47:42.738832', '2023-09-27 12:47:42.738832');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (120, 120, '01.120', NULL, NULL, '2023-09-27 12:47:42.741677', '2023-09-27 12:47:42.741677');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (121, 121, '01.120', NULL, NULL, '2023-09-27 12:47:42.743563', '2023-09-27 12:47:42.743563');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (122, 122, '01.120', NULL, NULL, '2023-09-27 12:47:42.751636', '2023-09-27 12:47:42.751636');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (123, 123, '01.120', '90.012', NULL, '2023-09-27 12:47:42.753717', '2023-09-27 12:47:42.753717');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (124, 124, '01.120', '90.012', NULL, '2023-09-27 12:47:42.756581', '2023-09-27 12:47:42.756581');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (125, 125, '01.120', NULL, NULL, '2023-09-27 12:47:42.75864', '2023-09-27 12:47:42.75864');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (126, 126, '01.120', NULL, NULL, '2023-09-27 12:47:42.761136', '2023-09-27 12:47:42.761136');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (127, 127, '01.120', NULL, NULL, '2023-09-27 12:47:42.770912', '2023-09-27 12:47:42.770912');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (128, 128, '01.120', '90.012', NULL, '2023-09-27 12:47:42.773934', '2023-09-27 12:47:42.773934');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (129, 129, '01.120', '90.012', NULL, '2023-09-27 12:47:42.775955', '2023-09-27 12:47:42.775955');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (130, 130, '01.120', '90.012', NULL, '2023-09-27 12:47:42.782194', '2023-09-27 12:47:42.782194');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (131, 131, '01.120', NULL, NULL, '2023-09-27 12:47:42.783856', '2023-09-27 12:47:42.783856');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (132, 132, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.785952', '2023-09-27 12:47:42.785952');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (133, 133, '01.120', NULL, NULL, '2023-09-27 12:47:42.788303', '2023-09-27 12:47:42.788303');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (134, 134, '01.120', NULL, NULL, '2023-09-27 12:47:42.789549', '2023-09-27 12:47:42.789549');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (135, 135, '01.120', '90.012', NULL, '2023-09-27 12:47:42.791428', '2023-09-27 12:47:42.791428');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (136, 136, '01.120', NULL, NULL, '2023-09-27 12:47:42.798122', '2023-09-27 12:47:42.798122');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (137, 137, '01.120', NULL, NULL, '2023-09-27 12:47:42.799742', '2023-09-27 12:47:42.799742');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (138, 138, '01.120', '90.012', NULL, '2023-09-27 12:47:42.801645', '2023-09-27 12:47:42.801645');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (139, 139, '01.120', '90.012', NULL, '2023-09-27 12:47:42.802858', '2023-09-27 12:47:42.802858');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (140, 140, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.803995', '2023-09-27 12:47:42.803995');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (141, 141, '01.120', NULL, NULL, '2023-09-27 12:47:42.805325', '2023-09-27 12:47:42.805325');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (142, 142, '01.120', NULL, NULL, '2023-09-27 12:47:42.814781', '2023-09-27 12:47:42.814781');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (143, 143, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.817043', '2023-09-27 12:47:42.817043');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (144, 144, '01.120', NULL, NULL, '2023-09-27 12:47:42.820402', '2023-09-27 12:47:42.820402');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (145, 145, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.821593', '2023-09-27 12:47:42.821593');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (146, 146, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.822912', '2023-09-27 12:47:42.822912');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (147, 147, '01.120', NULL, NULL, '2023-09-27 12:47:42.824117', '2023-09-27 12:47:42.824117');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (148, 148, '01.120', NULL, NULL, '2023-09-27 12:47:42.830291', '2023-09-27 12:47:42.830291');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (149, 149, '01.120', NULL, NULL, '2023-09-27 12:47:42.831804', '2023-09-27 12:47:42.831804');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (150, 150, '01.120', NULL, NULL, '2023-09-27 12:47:42.834861', '2023-09-27 12:47:42.834861');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (151, 151, '01.120', NULL, NULL, '2023-09-27 12:47:42.836631', '2023-09-27 12:47:42.836631');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (152, 152, '01.120', NULL, NULL, '2023-09-27 12:47:42.839262', '2023-09-27 12:47:42.839262');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (153, 153, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.849061', '2023-09-27 12:47:42.849061');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (154, 154, '01.120', '90.012', NULL, '2023-09-27 12:47:42.851743', '2023-09-27 12:47:42.851743');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (155, 155, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.854398', '2023-09-27 12:47:42.854398');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (156, 156, '01.120', NULL, NULL, '2023-09-27 12:47:42.855994', '2023-09-27 12:47:42.855994');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (157, 157, '01.120', NULL, NULL, '2023-09-27 12:47:42.857423', '2023-09-27 12:47:42.857423');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (158, 158, '01.120', NULL, NULL, '2023-09-27 12:47:42.858569', '2023-09-27 12:47:42.858569');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (159, 159, '01.120', NULL, NULL, '2023-09-27 12:47:42.866274', '2023-09-27 12:47:42.866274');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (160, 160, '01.120', NULL, NULL, '2023-09-27 12:47:42.868476', '2023-09-27 12:47:42.868476');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (161, 161, '01.120', NULL, NULL, '2023-09-27 12:47:42.870283', '2023-09-27 12:47:42.870283');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (162, 162, '01.120', NULL, NULL, '2023-09-27 12:47:42.872459', '2023-09-27 12:47:42.872459');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (163, 163, '01.120', NULL, NULL, '2023-09-27 12:47:42.873596', '2023-09-27 12:47:42.873596');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (164, 164, '01.120', '90.012', NULL, '2023-09-27 12:47:42.874826', '2023-09-27 12:47:42.874826');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (165, 165, '01.120', '90.012', NULL, '2023-09-27 12:47:42.876014', '2023-09-27 12:47:42.876014');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (166, 166, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.877205', '2023-09-27 12:47:42.877205');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (167, 167, '01.120', '90.012', NULL, '2023-09-27 12:47:42.883394', '2023-09-27 12:47:42.883394');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (168, 168, '01.120', NULL, NULL, '2023-09-27 12:47:42.884718', '2023-09-27 12:47:42.884718');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (169, 169, '01.120', NULL, NULL, '2023-09-27 12:47:42.885724', '2023-09-27 12:47:42.885724');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (170, 170, '01.120', '90.012', NULL, '2023-09-27 12:47:42.887275', '2023-09-27 12:47:42.887275');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (171, 171, '01.120', NULL, NULL, '2023-09-27 12:47:42.889108', '2023-09-27 12:47:42.889108');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (172, 172, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.890827', '2023-09-27 12:47:42.890827');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (173, 173, '01.120', '90.012', NULL, '2023-09-27 12:47:42.897018', '2023-09-27 12:47:42.897018');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (174, 174, '01.120', '90.012', NULL, '2023-09-27 12:47:42.899716', '2023-09-27 12:47:42.899716');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (175, 175, '01.120', NULL, NULL, '2023-09-27 12:47:42.900871', '2023-09-27 12:47:42.900871');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (176, 176, '01.120', NULL, NULL, '2023-09-27 12:47:42.902006', '2023-09-27 12:47:42.902006');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (177, 177, '01.120', NULL, NULL, '2023-09-27 12:47:42.904748', '2023-09-27 12:47:42.904748');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (178, 178, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.905959', '2023-09-27 12:47:42.905959');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (179, 179, '01.120', '90.012', NULL, '2023-09-27 12:47:42.907106', '2023-09-27 12:47:42.907106');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (180, 180, '01.120', NULL, NULL, '2023-09-27 12:47:42.916378', '2023-09-27 12:47:42.916378');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (181, 181, '01.120', NULL, NULL, '2023-09-27 12:47:42.918011', '2023-09-27 12:47:42.918011');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (182, 182, '01.120', NULL, NULL, '2023-09-27 12:47:42.919558', '2023-09-27 12:47:42.919558');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (183, 183, '01.120', NULL, NULL, '2023-09-27 12:47:42.921283', '2023-09-27 12:47:42.921283');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (184, 184, '01.120', NULL, NULL, '2023-09-27 12:47:42.922958', '2023-09-27 12:47:42.922958');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (185, 185, '01.120', '90.012', NULL, '2023-09-27 12:47:42.924401', '2023-09-27 12:47:42.924401');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (186, 186, '01.120', '90.012', NULL, '2023-09-27 12:47:42.932141', '2023-09-27 12:47:42.932141');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (187, 187, '01.120', NULL, NULL, '2023-09-27 12:47:42.933647', '2023-09-27 12:47:42.933647');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (188, 188, '01.120', NULL, NULL, '2023-09-27 12:47:42.935185', '2023-09-27 12:47:42.935185');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (189, 189, '01.120', NULL, NULL, '2023-09-27 12:47:42.936592', '2023-09-27 12:47:42.936592');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (190, 190, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.938109', '2023-09-27 12:47:42.938109');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (191, 191, '01.120', '90.012', NULL, '2023-09-27 12:47:42.939444', '2023-09-27 12:47:42.939444');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (192, 192, '01.120', NULL, NULL, '2023-09-27 12:47:42.941037', '2023-09-27 12:47:42.941037');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (193, 193, '01.120', NULL, NULL, '2023-09-27 12:47:42.943632', '2023-09-27 12:47:42.943632');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (194, 194, '01.120', '90.012', NULL, '2023-09-27 12:47:42.950682', '2023-09-27 12:47:42.950682');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (195, 195, '01.120', NULL, NULL, '2023-09-27 12:47:42.952323', '2023-09-27 12:47:42.952323');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (196, 196, '01.120', '90.012', NULL, '2023-09-27 12:47:42.953844', '2023-09-27 12:47:42.953844');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (197, 197, '01.120', NULL, NULL, '2023-09-27 12:47:42.955285', '2023-09-27 12:47:42.955285');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (198, 198, '01.120', NULL, NULL, '2023-09-27 12:47:42.956999', '2023-09-27 12:47:42.956999');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (199, 199, '01.120', NULL, NULL, '2023-09-27 12:47:42.963899', '2023-09-27 12:47:42.963899');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (200, 200, '01.120', NULL, NULL, '2023-09-27 12:47:42.965384', '2023-09-27 12:47:42.965384');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (201, 201, '01.120', '90.012', NULL, '2023-09-27 12:47:42.966928', '2023-09-27 12:47:42.966928');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (202, 202, '01.120', '90.012', NULL, '2023-09-27 12:47:42.96813', '2023-09-27 12:47:42.96813');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (203, 203, '01.120', NULL, NULL, '2023-09-27 12:47:42.969247', '2023-09-27 12:47:42.969247');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (204, 204, '01.120', NULL, NULL, '2023-09-27 12:47:42.971286', '2023-09-27 12:47:42.971286');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (205, 205, '01.120', '90.012', NULL, '2023-09-27 12:47:42.972614', '2023-09-27 12:47:42.972614');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (206, 206, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.978628', '2023-09-27 12:47:42.978628');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (207, 207, '01.120', NULL, NULL, '2023-09-27 12:47:42.979442', '2023-09-27 12:47:42.979442');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (208, 208, '01.120', NULL, NULL, '2023-09-27 12:47:42.97985', '2023-09-27 12:47:42.97985');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (209, 209, '01.120', '90.012', NULL, '2023-09-27 12:47:42.980222', '2023-09-27 12:47:42.980222');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (210, 210, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.98057', '2023-09-27 12:47:42.98057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (211, 211, '01.120', '90.012', NULL, '2023-09-27 12:47:42.992806', '2023-09-27 12:47:42.992806');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (212, 212, '01.120', '90.012', '70.220', '2023-09-27 12:47:42.993857', '2023-09-27 12:47:42.993857');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (213, 213, '01.120', NULL, NULL, '2023-09-27 12:47:42.995172', '2023-09-27 12:47:42.995172');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (214, 214, '01.120', NULL, NULL, '2023-09-27 12:47:42.996637', '2023-09-27 12:47:42.996637');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (215, 215, '01.120', '90.012', NULL, '2023-09-27 12:47:42.998238', '2023-09-27 12:47:42.998238');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (216, 216, '01.120', NULL, NULL, '2023-09-27 12:47:42.999718', '2023-09-27 12:47:42.999718');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (217, 217, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.001156', '2023-09-27 12:47:43.001156');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (218, 218, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.007446', '2023-09-27 12:47:43.007446');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (219, 219, '01.120', NULL, NULL, '2023-09-27 12:47:43.015968', '2023-09-27 12:47:43.015968');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (220, 220, '01.120', '90.012', NULL, '2023-09-27 12:47:43.017503', '2023-09-27 12:47:43.017503');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (221, 221, '01.120', '90.012', NULL, '2023-09-27 12:47:43.018824', '2023-09-27 12:47:43.018824');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (222, 222, '01.120', NULL, NULL, '2023-09-27 12:47:43.020169', '2023-09-27 12:47:43.020169');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (223, 223, '01.120', NULL, NULL, '2023-09-27 12:47:43.021277', '2023-09-27 12:47:43.021277');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (224, 224, '01.120', '90.012', NULL, '2023-09-27 12:47:43.022695', '2023-09-27 12:47:43.022695');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (225, 225, '01.120', NULL, NULL, '2023-09-27 12:47:43.028181', '2023-09-27 12:47:43.028181');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (226, 226, '01.120', '90.012', NULL, '2023-09-27 12:47:43.029752', '2023-09-27 12:47:43.029752');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (227, 227, '01.120', NULL, NULL, '2023-09-27 12:47:43.030921', '2023-09-27 12:47:43.030921');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (228, 228, '01.120', '90.012', NULL, '2023-09-27 12:47:43.036922', '2023-09-27 12:47:43.036922');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (229, 229, '01.120', '90.012', NULL, '2023-09-27 12:47:43.038716', '2023-09-27 12:47:43.038716');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (230, 230, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.039779', '2023-09-27 12:47:43.039779');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (231, 231, '01.120', '90.012', NULL, '2023-09-27 12:47:43.040945', '2023-09-27 12:47:43.040945');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (232, 232, '01.120', NULL, NULL, '2023-09-27 12:47:43.042085', '2023-09-27 12:47:43.042085');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (233, 233, '01.120', NULL, NULL, '2023-09-27 12:47:43.043248', '2023-09-27 12:47:43.043248');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (234, 234, '01.120', NULL, NULL, '2023-09-27 12:47:43.049504', '2023-09-27 12:47:43.049504');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (235, 235, '01.120', '90.012', NULL, '2023-09-27 12:47:43.05139', '2023-09-27 12:47:43.05139');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (236, 236, '01.120', NULL, NULL, '2023-09-27 12:47:43.052994', '2023-09-27 12:47:43.052994');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (237, 237, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.054569', '2023-09-27 12:47:43.054569');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (238, 238, '01.120', NULL, NULL, '2023-09-27 12:47:43.061739', '2023-09-27 12:47:43.061739');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (239, 239, '01.120', NULL, NULL, '2023-09-27 12:47:43.063539', '2023-09-27 12:47:43.063539');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (240, 240, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.065912', '2023-09-27 12:47:43.065912');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (241, 241, '01.120', NULL, NULL, '2023-09-27 12:47:43.067635', '2023-09-27 12:47:43.067635');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (242, 242, '01.120', NULL, NULL, '2023-09-27 12:47:43.075922', '2023-09-27 12:47:43.075922');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (243, 243, '01.120', NULL, NULL, '2023-09-27 12:47:43.077779', '2023-09-27 12:47:43.077779');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (244, 244, '01.120', '90.012', NULL, '2023-09-27 12:47:43.079232', '2023-09-27 12:47:43.079232');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (245, 245, '01.120', '90.012', NULL, '2023-09-27 12:47:43.080085', '2023-09-27 12:47:43.080085');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (246, 246, '01.120', NULL, NULL, '2023-09-27 12:47:43.08644', '2023-09-27 12:47:43.08644');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (247, 247, '01.120', NULL, NULL, '2023-09-27 12:47:43.087777', '2023-09-27 12:47:43.087777');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (248, 248, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.088765', '2023-09-27 12:47:43.088765');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (249, 249, '01.120', NULL, NULL, '2023-09-27 12:47:43.090157', '2023-09-27 12:47:43.090157');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (250, 250, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.091332', '2023-09-27 12:47:43.091332');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (251, 251, '01.120', NULL, NULL, '2023-09-27 12:47:43.098519', '2023-09-27 12:47:43.098519');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (252, 252, '01.120', NULL, NULL, '2023-09-27 12:47:43.099765', '2023-09-27 12:47:43.099765');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (253, 253, '01.120', NULL, NULL, '2023-09-27 12:47:43.101646', '2023-09-27 12:47:43.101646');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (254, 254, '01.120', NULL, NULL, '2023-09-27 12:47:43.110098', '2023-09-27 12:47:43.110098');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (255, 255, '01.120', NULL, NULL, '2023-09-27 12:47:43.111159', '2023-09-27 12:47:43.111159');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (256, 256, '01.120', NULL, NULL, '2023-09-27 12:47:43.112129', '2023-09-27 12:47:43.112129');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (257, 257, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.113071', '2023-09-27 12:47:43.113071');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (258, 258, '01.120', NULL, NULL, '2023-09-27 12:47:43.113592', '2023-09-27 12:47:43.113592');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (259, 259, '01.120', NULL, NULL, '2023-09-27 12:47:43.113944', '2023-09-27 12:47:43.113944');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (260, 260, '01.120', NULL, NULL, '2023-09-27 12:47:43.119585', '2023-09-27 12:47:43.119585');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (261, 261, '01.120', '90.012', NULL, '2023-09-27 12:47:43.12836', '2023-09-27 12:47:43.12836');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (262, 262, '01.120', NULL, NULL, '2023-09-27 12:47:43.12959', '2023-09-27 12:47:43.12959');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (263, 263, '01.120', NULL, NULL, '2023-09-27 12:47:43.130436', '2023-09-27 12:47:43.130436');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (264, 264, '01.120', NULL, NULL, '2023-09-27 12:47:43.13159', '2023-09-27 12:47:43.13159');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (265, 265, '01.120', NULL, NULL, '2023-09-27 12:47:43.133262', '2023-09-27 12:47:43.133262');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (266, 266, '01.120', NULL, NULL, '2023-09-27 12:47:43.141712', '2023-09-27 12:47:43.141712');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (267, 267, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.143819', '2023-09-27 12:47:43.143819');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (268, 268, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.149412', '2023-09-27 12:47:43.149412');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (269, 269, '01.120', '90.012', NULL, '2023-09-27 12:47:43.150638', '2023-09-27 12:47:43.150638');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (270, 270, '01.120', NULL, NULL, '2023-09-27 12:47:43.151629', '2023-09-27 12:47:43.151629');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (271, 271, '01.120', '90.012', NULL, '2023-09-27 12:47:43.152778', '2023-09-27 12:47:43.152778');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (272, 272, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.159129', '2023-09-27 12:47:43.159129');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (273, 273, '01.120', '90.012', NULL, '2023-09-27 12:47:43.160207', '2023-09-27 12:47:43.160207');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (274, 274, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.1612', '2023-09-27 12:47:43.1612');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (275, 275, '01.120', NULL, NULL, '2023-09-27 12:47:43.163057', '2023-09-27 12:47:43.163057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (276, 276, '01.120', '90.012', NULL, '2023-09-27 12:47:43.169408', '2023-09-27 12:47:43.169408');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (277, 277, '01.120', NULL, NULL, '2023-09-27 12:47:43.170809', '2023-09-27 12:47:43.170809');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (278, 278, '01.120', NULL, NULL, '2023-09-27 12:47:43.172175', '2023-09-27 12:47:43.172175');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (279, 279, '01.120', NULL, NULL, '2023-09-27 12:47:43.173328', '2023-09-27 12:47:43.173328');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (280, 280, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.180472', '2023-09-27 12:47:43.180472');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (281, 281, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.181515', '2023-09-27 12:47:43.181515');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (282, 282, '01.120', NULL, NULL, '2023-09-27 12:47:43.182621', '2023-09-27 12:47:43.182621');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (283, 283, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.183712', '2023-09-27 12:47:43.183712');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (284, 284, '01.120', NULL, NULL, '2023-09-27 12:47:43.189154', '2023-09-27 12:47:43.189154');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (285, 285, '01.120', NULL, NULL, '2023-09-27 12:47:43.190688', '2023-09-27 12:47:43.190688');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (286, 286, '01.120', NULL, NULL, '2023-09-27 12:47:43.191882', '2023-09-27 12:47:43.191882');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (287, 287, '01.120', NULL, NULL, '2023-09-27 12:47:43.192863', '2023-09-27 12:47:43.192863');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (288, 288, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.193968', '2023-09-27 12:47:43.193968');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (289, 289, '01.120', NULL, NULL, '2023-09-27 12:47:43.199843', '2023-09-27 12:47:43.199843');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (290, 290, '01.120', NULL, NULL, '2023-09-27 12:47:43.201328', '2023-09-27 12:47:43.201328');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (291, 291, '01.120', NULL, NULL, '2023-09-27 12:47:43.202038', '2023-09-27 12:47:43.202038');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (292, 292, '01.120', NULL, NULL, '2023-09-27 12:47:43.20279', '2023-09-27 12:47:43.20279');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (293, 293, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.20323', '2023-09-27 12:47:43.20323');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (294, 294, '01.120', NULL, NULL, '2023-09-27 12:47:43.208115', '2023-09-27 12:47:43.208115');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (295, 295, '01.120', NULL, NULL, '2023-09-27 12:47:43.209692', '2023-09-27 12:47:43.209692');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (296, 296, '01.120', '90.012', NULL, '2023-09-27 12:47:43.210882', '2023-09-27 12:47:43.210882');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (297, 297, '01.120', NULL, NULL, '2023-09-27 12:47:43.212072', '2023-09-27 12:47:43.212072');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (298, 298, '01.120', NULL, NULL, '2023-09-27 12:47:43.217813', '2023-09-27 12:47:43.217813');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (299, 299, '01.120', NULL, NULL, '2023-09-27 12:47:43.218705', '2023-09-27 12:47:43.218705');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (300, 300, '01.120', '90.012', NULL, '2023-09-27 12:47:43.2192', '2023-09-27 12:47:43.2192');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (301, 301, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.224543', '2023-09-27 12:47:43.224543');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (302, 302, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.225692', '2023-09-27 12:47:43.225692');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (303, 303, '01.120', NULL, NULL, '2023-09-27 12:47:43.22638', '2023-09-27 12:47:43.22638');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (304, 304, '01.120', '90.012', NULL, '2023-09-27 12:47:43.227042', '2023-09-27 12:47:43.227042');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (305, 305, '01.120', NULL, NULL, '2023-09-27 12:47:43.234015', '2023-09-27 12:47:43.234015');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (306, 306, '01.120', NULL, NULL, '2023-09-27 12:47:43.235173', '2023-09-27 12:47:43.235173');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (307, 307, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.236239', '2023-09-27 12:47:43.236239');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (308, 308, '01.120', '90.012', NULL, '2023-09-27 12:47:43.237371', '2023-09-27 12:47:43.237371');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (309, 309, '01.120', NULL, NULL, '2023-09-27 12:47:43.243158', '2023-09-27 12:47:43.243158');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (310, 310, '01.120', '90.012', NULL, '2023-09-27 12:47:43.24512', '2023-09-27 12:47:43.24512');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (311, 311, '01.120', '90.012', NULL, '2023-09-27 12:47:43.246184', '2023-09-27 12:47:43.246184');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (312, 312, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.252388', '2023-09-27 12:47:43.252388');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (313, 313, '01.120', NULL, NULL, '2023-09-27 12:47:43.253766', '2023-09-27 12:47:43.253766');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (314, 314, '01.120', NULL, NULL, '2023-09-27 12:47:43.254954', '2023-09-27 12:47:43.254954');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (315, 315, '01.120', NULL, NULL, '2023-09-27 12:47:43.256426', '2023-09-27 12:47:43.256426');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (316, 316, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.257459', '2023-09-27 12:47:43.257459');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (317, 317, '01.120', NULL, NULL, '2023-09-27 12:47:43.262712', '2023-09-27 12:47:43.262712');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (318, 318, '01.120', '90.012', NULL, '2023-09-27 12:47:43.263781', '2023-09-27 12:47:43.263781');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (319, 319, '01.120', NULL, NULL, '2023-09-27 12:47:43.264396', '2023-09-27 12:47:43.264396');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (320, 320, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.264814', '2023-09-27 12:47:43.264814');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (321, 321, '01.120', '90.012', NULL, '2023-09-27 12:47:43.270499', '2023-09-27 12:47:43.270499');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (322, 322, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.272283', '2023-09-27 12:47:43.272283');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (323, 323, '01.120', NULL, NULL, '2023-09-27 12:47:43.273446', '2023-09-27 12:47:43.273446');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (324, 324, '01.120', '90.012', NULL, '2023-09-27 12:47:43.27439', '2023-09-27 12:47:43.27439');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (325, 325, '01.120', '90.012', NULL, '2023-09-27 12:47:43.275513', '2023-09-27 12:47:43.275513');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (326, 326, '01.120', '90.012', NULL, '2023-09-27 12:47:43.281106', '2023-09-27 12:47:43.281106');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (327, 327, '01.120', NULL, NULL, '2023-09-27 12:47:43.282297', '2023-09-27 12:47:43.282297');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (328, 328, '01.120', NULL, NULL, '2023-09-27 12:47:43.282793', '2023-09-27 12:47:43.282793');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (329, 329, '01.120', NULL, NULL, '2023-09-27 12:47:43.28891', '2023-09-27 12:47:43.28891');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (330, 330, '01.120', NULL, NULL, '2023-09-27 12:47:43.290164', '2023-09-27 12:47:43.290164');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (331, 331, '01.120', NULL, NULL, '2023-09-27 12:47:43.291301', '2023-09-27 12:47:43.291301');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (332, 332, '01.120', NULL, NULL, '2023-09-27 12:47:43.292422', '2023-09-27 12:47:43.292422');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (333, 333, '01.120', NULL, NULL, '2023-09-27 12:47:43.293286', '2023-09-27 12:47:43.293286');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (334, 334, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.29821', '2023-09-27 12:47:43.29821');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (335, 335, '01.120', '90.012', NULL, '2023-09-27 12:47:43.299647', '2023-09-27 12:47:43.299647');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (336, 336, '01.120', '90.012', NULL, '2023-09-27 12:47:43.301415', '2023-09-27 12:47:43.301415');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (337, 337, '01.120', NULL, NULL, '2023-09-27 12:47:43.302361', '2023-09-27 12:47:43.302361');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (338, 338, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.30806', '2023-09-27 12:47:43.30806');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (339, 339, '01.120', NULL, NULL, '2023-09-27 12:47:43.309341', '2023-09-27 12:47:43.309341');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (340, 340, '01.120', NULL, NULL, '2023-09-27 12:47:43.310505', '2023-09-27 12:47:43.310505');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (341, 341, '01.120', NULL, NULL, '2023-09-27 12:47:43.311786', '2023-09-27 12:47:43.311786');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (342, 342, '01.120', NULL, NULL, '2023-09-27 12:47:43.312546', '2023-09-27 12:47:43.312546');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (343, 343, '01.120', NULL, NULL, '2023-09-27 12:47:43.318298', '2023-09-27 12:47:43.318298');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (344, 344, '01.120', NULL, NULL, '2023-09-27 12:47:43.319488', '2023-09-27 12:47:43.319488');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (345, 345, '01.120', NULL, NULL, '2023-09-27 12:47:43.320631', '2023-09-27 12:47:43.320631');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (346, 346, '01.120', NULL, NULL, '2023-09-27 12:47:43.321403', '2023-09-27 12:47:43.321403');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (347, 347, '01.120', '90.012', NULL, '2023-09-27 12:47:43.327682', '2023-09-27 12:47:43.327682');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (348, 348, '01.120', '90.012', NULL, '2023-09-27 12:47:43.328338', '2023-09-27 12:47:43.328338');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (349, 349, '01.120', NULL, NULL, '2023-09-27 12:47:43.32876', '2023-09-27 12:47:43.32876');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (350, 350, '01.120', '90.012', NULL, '2023-09-27 12:47:43.329208', '2023-09-27 12:47:43.329208');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (351, 351, '01.120', '90.012', NULL, '2023-09-27 12:47:43.329603', '2023-09-27 12:47:43.329603');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (352, 352, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.335886', '2023-09-27 12:47:43.335886');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (353, 353, '01.120', '90.012', NULL, '2023-09-27 12:47:43.336759', '2023-09-27 12:47:43.336759');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (354, 354, '01.120', NULL, NULL, '2023-09-27 12:47:43.337798', '2023-09-27 12:47:43.337798');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (355, 355, '01.120', NULL, NULL, '2023-09-27 12:47:43.3423', '2023-09-27 12:47:43.3423');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (356, 356, '01.120', NULL, NULL, '2023-09-27 12:47:43.342865', '2023-09-27 12:47:43.342865');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (357, 357, '01.120', '90.012', NULL, '2023-09-27 12:47:43.343323', '2023-09-27 12:47:43.343323');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (358, 358, '01.120', '90.012', NULL, '2023-09-27 12:47:43.343882', '2023-09-27 12:47:43.343882');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (359, 359, '01.120', '90.012', NULL, '2023-09-27 12:47:43.349485', '2023-09-27 12:47:43.349485');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (360, 360, '01.120', '90.012', NULL, '2023-09-27 12:47:43.351166', '2023-09-27 12:47:43.351166');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (361, 361, '01.120', NULL, NULL, '2023-09-27 12:47:43.352539', '2023-09-27 12:47:43.352539');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (362, 362, '01.120', '90.012', NULL, '2023-09-27 12:47:43.358283', '2023-09-27 12:47:43.358283');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (363, 363, '01.120', '90.012', NULL, '2023-09-27 12:47:43.359453', '2023-09-27 12:47:43.359453');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (364, 364, '01.120', NULL, NULL, '2023-09-27 12:47:43.364756', '2023-09-27 12:47:43.364756');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (365, 365, '01.120', '90.012', NULL, '2023-09-27 12:47:43.365667', '2023-09-27 12:47:43.365667');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (366, 366, '01.120', '90.012', NULL, '2023-09-27 12:47:43.366677', '2023-09-27 12:47:43.366677');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (367, 367, '01.120', NULL, NULL, '2023-09-27 12:47:43.372148', '2023-09-27 12:47:43.372148');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (368, 368, '01.120', NULL, NULL, '2023-09-27 12:47:43.373018', '2023-09-27 12:47:43.373018');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (369, 369, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.377603', '2023-09-27 12:47:43.377603');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (370, 370, '01.120', '90.012', NULL, '2023-09-27 12:47:43.379055', '2023-09-27 12:47:43.379055');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (371, 371, '01.120', '90.012', NULL, '2023-09-27 12:47:43.381725', '2023-09-27 12:47:43.381725');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (372, 372, '01.120', '90.012', NULL, '2023-09-27 12:47:43.382758', '2023-09-27 12:47:43.382758');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (373, 373, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.387475', '2023-09-27 12:47:43.387475');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (374, 374, '01.120', NULL, NULL, '2023-09-27 12:47:43.388546', '2023-09-27 12:47:43.388546');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (375, 375, '01.120', NULL, NULL, '2023-09-27 12:47:43.393614', '2023-09-27 12:47:43.393614');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (376, 376, '01.120', NULL, NULL, '2023-09-27 12:47:43.394931', '2023-09-27 12:47:43.394931');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (377, 377, '01.120', '90.012', NULL, '2023-09-27 12:47:43.396043', '2023-09-27 12:47:43.396043');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (378, 378, '01.120', '90.012', NULL, '2023-09-27 12:47:43.401085', '2023-09-27 12:47:43.401085');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (379, 379, '01.120', NULL, NULL, '2023-09-27 12:47:43.40213', '2023-09-27 12:47:43.40213');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (380, 380, '01.120', '90.012', NULL, '2023-09-27 12:47:43.403077', '2023-09-27 12:47:43.403077');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (381, 381, '01.120', NULL, NULL, '2023-09-27 12:47:43.40849', '2023-09-27 12:47:43.40849');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (382, 382, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.410299', '2023-09-27 12:47:43.410299');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (383, 383, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.411238', '2023-09-27 12:47:43.411238');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (384, 384, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.417625', '2023-09-27 12:47:43.417625');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (385, 385, '01.120', NULL, NULL, '2023-09-27 12:47:43.419793', '2023-09-27 12:47:43.419793');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (386, 386, '01.120', '90.012', NULL, '2023-09-27 12:47:43.42111', '2023-09-27 12:47:43.42111');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (387, 387, '01.120', NULL, NULL, '2023-09-27 12:47:43.42287', '2023-09-27 12:47:43.42287');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (388, 388, '01.120', '90.012', NULL, '2023-09-27 12:47:43.42395', '2023-09-27 12:47:43.42395');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (389, 389, '01.120', NULL, NULL, '2023-09-27 12:47:43.429655', '2023-09-27 12:47:43.429655');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (390, 390, '01.120', NULL, NULL, '2023-09-27 12:47:43.431538', '2023-09-27 12:47:43.431538');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (391, 391, '01.120', '90.012', NULL, '2023-09-27 12:47:43.432756', '2023-09-27 12:47:43.432756');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (392, 392, '01.120', NULL, NULL, '2023-09-27 12:47:43.433713', '2023-09-27 12:47:43.433713');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (393, 393, '01.120', NULL, NULL, '2023-09-27 12:47:43.440146', '2023-09-27 12:47:43.440146');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (394, 394, '01.120', NULL, NULL, '2023-09-27 12:47:43.441369', '2023-09-27 12:47:43.441369');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (395, 395, '01.120', NULL, NULL, '2023-09-27 12:47:43.442604', '2023-09-27 12:47:43.442604');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (396, 396, '01.120', '90.012', NULL, '2023-09-27 12:47:43.443793', '2023-09-27 12:47:43.443793');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (397, 397, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.444682', '2023-09-27 12:47:43.444682');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (398, 398, '01.120', NULL, NULL, '2023-09-27 12:47:43.449918', '2023-09-27 12:47:43.449918');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (399, 399, '01.120', NULL, NULL, '2023-09-27 12:47:43.450869', '2023-09-27 12:47:43.450869');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (400, 400, '01.120', '90.012', NULL, '2023-09-27 12:47:43.451719', '2023-09-27 12:47:43.451719');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (401, 401, '01.120', '90.012', NULL, '2023-09-27 12:47:43.45683', '2023-09-27 12:47:43.45683');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (402, 402, '01.120', NULL, NULL, '2023-09-27 12:47:43.457931', '2023-09-27 12:47:43.457931');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (403, 403, '01.120', NULL, NULL, '2023-09-27 12:47:43.459169', '2023-09-27 12:47:43.459169');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (404, 404, '01.120', '90.012', NULL, '2023-09-27 12:47:43.460265', '2023-09-27 12:47:43.460265');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (405, 405, '01.120', '90.012', NULL, '2023-09-27 12:47:43.461192', '2023-09-27 12:47:43.461192');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (406, 406, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.466047', '2023-09-27 12:47:43.466047');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (407, 407, '01.120', NULL, NULL, '2023-09-27 12:47:43.467109', '2023-09-27 12:47:43.467109');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (408, 408, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.467932', '2023-09-27 12:47:43.467932');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (409, 409, '01.120', NULL, NULL, '2023-09-27 12:47:43.473816', '2023-09-27 12:47:43.473816');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (410, 410, '01.120', NULL, NULL, '2023-09-27 12:47:43.474938', '2023-09-27 12:47:43.474938');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (411, 411, '01.120', '90.012', NULL, '2023-09-27 12:47:43.47727', '2023-09-27 12:47:43.47727');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (412, 412, '01.120', NULL, NULL, '2023-09-27 12:47:43.478538', '2023-09-27 12:47:43.478538');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (413, 413, '01.120', NULL, NULL, '2023-09-27 12:47:43.483597', '2023-09-27 12:47:43.483597');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (414, 414, '01.120', '90.012', NULL, '2023-09-27 12:47:43.484762', '2023-09-27 12:47:43.484762');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (415, 415, '01.120', NULL, NULL, '2023-09-27 12:47:43.486014', '2023-09-27 12:47:43.486014');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (416, 416, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.487182', '2023-09-27 12:47:43.487182');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (417, 417, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.493229', '2023-09-27 12:47:43.493229');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (418, 418, '01.120', NULL, NULL, '2023-09-27 12:47:43.494666', '2023-09-27 12:47:43.494666');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (419, 419, '01.120', '90.012', NULL, '2023-09-27 12:47:43.495745', '2023-09-27 12:47:43.495745');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (420, 420, '01.120', NULL, NULL, '2023-09-27 12:47:43.497015', '2023-09-27 12:47:43.497015');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (421, 421, '01.120', NULL, NULL, '2023-09-27 12:47:43.502077', '2023-09-27 12:47:43.502077');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (422, 422, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.503336', '2023-09-27 12:47:43.503336');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (423, 423, '01.120', '90.012', NULL, '2023-09-27 12:47:43.505001', '2023-09-27 12:47:43.505001');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (424, 424, '01.120', NULL, NULL, '2023-09-27 12:47:43.511831', '2023-09-27 12:47:43.511831');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (425, 425, '01.120', NULL, NULL, '2023-09-27 12:47:43.513484', '2023-09-27 12:47:43.513484');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (426, 426, '01.120', '90.012', NULL, '2023-09-27 12:47:43.514804', '2023-09-27 12:47:43.514804');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (427, 427, '01.120', NULL, NULL, '2023-09-27 12:47:43.516062', '2023-09-27 12:47:43.516062');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (428, 428, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.521215', '2023-09-27 12:47:43.521215');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (429, 429, '01.120', '90.012', NULL, '2023-09-27 12:47:43.522595', '2023-09-27 12:47:43.522595');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (430, 430, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.52334', '2023-09-27 12:47:43.52334');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (431, 431, '01.120', '90.012', NULL, '2023-09-27 12:47:43.524698', '2023-09-27 12:47:43.524698');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (432, 432, '01.120', NULL, NULL, '2023-09-27 12:47:43.526122', '2023-09-27 12:47:43.526122');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (433, 433, '01.120', '90.012', NULL, '2023-09-27 12:47:43.531358', '2023-09-27 12:47:43.531358');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (434, 434, '01.120', '90.012', NULL, '2023-09-27 12:47:43.532851', '2023-09-27 12:47:43.532851');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (435, 435, '01.120', '90.012', NULL, '2023-09-27 12:47:43.53364', '2023-09-27 12:47:43.53364');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (436, 436, '01.120', NULL, NULL, '2023-09-27 12:47:43.539431', '2023-09-27 12:47:43.539431');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (437, 437, '01.120', NULL, NULL, '2023-09-27 12:47:43.541018', '2023-09-27 12:47:43.541018');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (438, 438, '01.120', NULL, NULL, '2023-09-27 12:47:43.542131', '2023-09-27 12:47:43.542131');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (439, 439, '01.120', '90.012', NULL, '2023-09-27 12:47:43.543447', '2023-09-27 12:47:43.543447');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (440, 440, '01.120', NULL, NULL, '2023-09-27 12:47:43.549071', '2023-09-27 12:47:43.549071');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (441, 441, '01.120', NULL, NULL, '2023-09-27 12:47:43.550449', '2023-09-27 12:47:43.550449');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (442, 442, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.552128', '2023-09-27 12:47:43.552128');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (443, 443, '01.120', NULL, NULL, '2023-09-27 12:47:43.554014', '2023-09-27 12:47:43.554014');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (444, 444, '01.120', NULL, NULL, '2023-09-27 12:47:43.56202', '2023-09-27 12:47:43.56202');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (445, 445, '01.120', NULL, NULL, '2023-09-27 12:47:43.563101', '2023-09-27 12:47:43.563101');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (446, 446, '01.120', '90.012', NULL, '2023-09-27 12:47:43.564101', '2023-09-27 12:47:43.564101');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (447, 447, '01.120', '90.012', NULL, '2023-09-27 12:47:43.565288', '2023-09-27 12:47:43.565288');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (448, 448, '01.120', NULL, NULL, '2023-09-27 12:47:43.57029', '2023-09-27 12:47:43.57029');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (449, 449, '01.120', NULL, NULL, '2023-09-27 12:47:43.571844', '2023-09-27 12:47:43.571844');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (450, 450, '01.120', NULL, NULL, '2023-09-27 12:47:43.573151', '2023-09-27 12:47:43.573151');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (451, 451, '01.120', NULL, NULL, '2023-09-27 12:47:43.574265', '2023-09-27 12:47:43.574265');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (452, 452, '01.120', '90.012', NULL, '2023-09-27 12:47:43.575875', '2023-09-27 12:47:43.575875');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (453, 453, '01.120', '90.012', NULL, '2023-09-27 12:47:43.577798', '2023-09-27 12:47:43.577798');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (454, 454, '01.120', '90.012', NULL, '2023-09-27 12:47:43.579485', '2023-09-27 12:47:43.579485');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (455, 455, '01.120', NULL, NULL, '2023-09-27 12:47:43.58423', '2023-09-27 12:47:43.58423');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (456, 456, '01.120', '90.012', NULL, '2023-09-27 12:47:43.585281', '2023-09-27 12:47:43.585281');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (457, 457, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.586284', '2023-09-27 12:47:43.586284');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (458, 458, '01.120', NULL, NULL, '2023-09-27 12:47:43.587174', '2023-09-27 12:47:43.587174');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (459, 459, '01.120', NULL, NULL, '2023-09-27 12:47:43.592165', '2023-09-27 12:47:43.592165');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (460, 460, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.593469', '2023-09-27 12:47:43.593469');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (461, 461, '01.120', '90.012', NULL, '2023-09-27 12:47:43.59471', '2023-09-27 12:47:43.59471');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (462, 462, '01.120', '90.012', NULL, '2023-09-27 12:47:43.595933', '2023-09-27 12:47:43.595933');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (463, 463, '01.120', '90.012', NULL, '2023-09-27 12:47:43.602591', '2023-09-27 12:47:43.602591');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (464, 464, '01.120', NULL, NULL, '2023-09-27 12:47:43.603813', '2023-09-27 12:47:43.603813');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (465, 465, '01.120', NULL, NULL, '2023-09-27 12:47:43.604733', '2023-09-27 12:47:43.604733');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (466, 466, '01.120', NULL, NULL, '2023-09-27 12:47:43.605879', '2023-09-27 12:47:43.605879');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (467, 467, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.610571', '2023-09-27 12:47:43.610571');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (468, 468, '01.120', '90.012', NULL, '2023-09-27 12:47:43.61195', '2023-09-27 12:47:43.61195');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (469, 469, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.612625', '2023-09-27 12:47:43.612625');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (470, 470, '01.120', NULL, NULL, '2023-09-27 12:47:43.613669', '2023-09-27 12:47:43.613669');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (471, 471, '01.120', NULL, NULL, '2023-09-27 12:47:43.619935', '2023-09-27 12:47:43.619935');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (472, 472, '01.120', NULL, NULL, '2023-09-27 12:47:43.620984', '2023-09-27 12:47:43.620984');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (473, 473, '01.120', NULL, NULL, '2023-09-27 12:47:43.621858', '2023-09-27 12:47:43.621858');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (474, 474, '01.120', '90.012', NULL, '2023-09-27 12:47:43.622727', '2023-09-27 12:47:43.622727');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (475, 475, '01.120', NULL, NULL, '2023-09-27 12:47:43.62356', '2023-09-27 12:47:43.62356');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (476, 476, '01.120', NULL, NULL, '2023-09-27 12:47:43.628735', '2023-09-27 12:47:43.628735');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (477, 477, '01.120', NULL, NULL, '2023-09-27 12:47:43.629842', '2023-09-27 12:47:43.629842');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (478, 478, '01.120', NULL, NULL, '2023-09-27 12:47:43.630842', '2023-09-27 12:47:43.630842');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (479, 479, '01.120', NULL, NULL, '2023-09-27 12:47:43.631806', '2023-09-27 12:47:43.631806');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (480, 480, '01.120', '90.012', NULL, '2023-09-27 12:47:43.638676', '2023-09-27 12:47:43.638676');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (481, 481, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.639749', '2023-09-27 12:47:43.639749');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (482, 482, '01.120', NULL, NULL, '2023-09-27 12:47:43.640763', '2023-09-27 12:47:43.640763');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (483, 483, '01.120', '90.012', NULL, '2023-09-27 12:47:43.641866', '2023-09-27 12:47:43.641866');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (484, 484, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.642813', '2023-09-27 12:47:43.642813');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (485, 485, '01.120', NULL, NULL, '2023-09-27 12:47:43.648042', '2023-09-27 12:47:43.648042');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (486, 486, '01.120', '90.012', NULL, '2023-09-27 12:47:43.648789', '2023-09-27 12:47:43.648789');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (487, 487, '01.120', '90.012', NULL, '2023-09-27 12:47:43.649693', '2023-09-27 12:47:43.649693');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (488, 488, '01.120', NULL, NULL, '2023-09-27 12:47:43.650578', '2023-09-27 12:47:43.650578');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (489, 489, '01.120', NULL, NULL, '2023-09-27 12:47:43.651234', '2023-09-27 12:47:43.651234');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (490, 490, '01.120', '90.012', NULL, '2023-09-27 12:47:43.655996', '2023-09-27 12:47:43.655996');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (491, 491, '01.120', NULL, NULL, '2023-09-27 12:47:43.656732', '2023-09-27 12:47:43.656732');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (492, 492, '01.120', '90.012', NULL, '2023-09-27 12:47:43.657686', '2023-09-27 12:47:43.657686');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (493, 493, '01.120', NULL, NULL, '2023-09-27 12:47:43.658526', '2023-09-27 12:47:43.658526');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (494, 494, '01.120', '90.012', NULL, '2023-09-27 12:47:43.659252', '2023-09-27 12:47:43.659252');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (495, 495, '01.120', NULL, NULL, '2023-09-27 12:47:43.663739', '2023-09-27 12:47:43.663739');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (496, 496, '01.120', NULL, NULL, '2023-09-27 12:47:43.664833', '2023-09-27 12:47:43.664833');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (497, 497, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.665808', '2023-09-27 12:47:43.665808');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (498, 498, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.667077', '2023-09-27 12:47:43.667077');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (499, 499, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.668054', '2023-09-27 12:47:43.668054');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (500, 500, '01.120', NULL, NULL, '2023-09-27 12:47:43.672571', '2023-09-27 12:47:43.672571');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (501, 501, '01.120', NULL, NULL, '2023-09-27 12:47:43.673669', '2023-09-27 12:47:43.673669');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (502, 502, '01.120', NULL, NULL, '2023-09-27 12:47:43.674721', '2023-09-27 12:47:43.674721');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (503, 503, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.675667', '2023-09-27 12:47:43.675667');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (504, 504, '01.120', '90.012', NULL, '2023-09-27 12:47:43.680483', '2023-09-27 12:47:43.680483');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (505, 505, '01.120', NULL, NULL, '2023-09-27 12:47:43.681623', '2023-09-27 12:47:43.681623');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (506, 506, '01.120', '90.012', NULL, '2023-09-27 12:47:43.682674', '2023-09-27 12:47:43.682674');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (507, 507, '01.120', NULL, NULL, '2023-09-27 12:47:43.687195', '2023-09-27 12:47:43.687195');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (508, 508, '01.120', '90.012', NULL, '2023-09-27 12:47:43.688929', '2023-09-27 12:47:43.688929');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (509, 509, '01.120', '90.012', '70.220', '2023-09-27 12:47:43.689926', '2023-09-27 12:47:43.689926');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (510, 510, '01.120', NULL, NULL, '2023-09-27 12:47:43.690982', '2023-09-27 12:47:43.690982');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (511, 511, '01.120', '90.012', NULL, '2023-09-27 12:47:43.696588', '2023-09-27 12:47:43.696588');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.611832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.619517');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '555555555', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.619517');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (6, '811182048', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.619517');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '840722400', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.619517');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '850055501', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.623922');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '849969854', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.627064');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '314159265', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.627064');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '898568539', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.652751');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '866372238', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.652751');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '859120802', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.652751');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '889775768', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.656503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '876874244', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.656503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '801893521', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.656503');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '863680164', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.659599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '819118552', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.659599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '874703007', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.659599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '874032760', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.659599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '889640472', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.664061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '812445451', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.664061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '881652601', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.664061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '840294166', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.667231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '831005379', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.667231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '859475383', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.667231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '859968102', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.667231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '892271961', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.667231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '815902884', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.667231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '893844214', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.671143');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '888955021', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.671143');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '899964365', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.674335');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '891511936', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.674335');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '856069557', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.674335');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '841089736', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.674335');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '849316102', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.674335');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '807178210', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.677858');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '894005613', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.677858');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '800354007', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.677858');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '873447217', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.681773');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '827719376', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.681773');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '801899164', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.681773');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '803680044', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.681773');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '873219231', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.686102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '849116035', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.686102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '809268073', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.686102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '845364138', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.690358');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '864517784', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.690358');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '865104598', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.690358');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '885532801', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.690358');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '805316453', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.690358');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '864854816', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.693732');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '843327651', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.693732');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '899360493', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.693732');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '874033135', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.693732');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '814749111', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.697698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '830385063', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.697698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '878971159', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.697698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '860901626', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.697698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '831397838', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.704259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '847244539', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.704259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '840661567', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.704259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '894138262', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.704259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '899951745', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.709183');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '804978457', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.71379');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '863449910', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.71379');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '817066902', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.71379');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '853507323', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.71379');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '807861681', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.719501');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '835520579', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.719501');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '880044215', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.719501');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '887813790', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.719501');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '879629361', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.719501');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '834856071', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.723275');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '839737952', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.726312');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '879454278', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.726312');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '869375251', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.726312');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '891737001', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.729659');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '859548768', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.729659');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '815557877', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.729659');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '823964468', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.733106');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '801260955', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.733106');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '853901628', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.733106');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '818012422', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.736565');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '886701339', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.736565');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '890766677', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.736565');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '885562121', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.739907');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '883179502', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.739907');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '889252671', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.739907');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '891631136', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.739907');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '834133138', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.743399');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '865105026', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.743399');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '852802807', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.743399');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '895455206', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.743399');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '811687458', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.747143');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '886254610', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.747143');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '809987579', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.747143');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '813975560', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.747143');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '811878131', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.751018');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '834633239', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.751018');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '807088266', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.751018');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '868616982', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.754543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '800980006', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.754543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '833729664', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.754543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '896185369', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.754543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '821487814', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.758305');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '843937221', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.758305');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '891365018', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.758305');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '802562418', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.762191');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '813482591', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.762191');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '882864445', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.762191');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '805723557', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.762191');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '848182062', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.76605');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '846089389', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.76605');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '823333463', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.76605');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '884296653', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.769984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '852903645', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.769984');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '855109592', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.773654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '854029304', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.773654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '886855095', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.777582');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '841216202', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.777582');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '877836474', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.777582');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '872323946', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.781795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '884669989', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.781795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '810175795', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.781795');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '818541433', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.785333');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '844733792', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.785333');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '894287440', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.790124');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '823854289', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.790124');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '890614908', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.790124');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '883449489', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.790124');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '868953993', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.793778');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '833164615', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.793778');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '800638435', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.796879');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '877683292', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.796879');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '844806430', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.796879');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '856883898', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.796879');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '834146586', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.800476');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '827963000', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.800476');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '858766933', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.800476');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '894120846', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.80394');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '830813886', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.80394');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '826165178', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.80394');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '860614631', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.807521');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '843914504', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.807521');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '841947707', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.807521');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '805615372', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.811237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '855472907', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.811237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '868639863', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.811237');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '834233785', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.814911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '879831802', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.814911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '898624492', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.814911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '814314954', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.814911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '896667526', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.819128');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '852100041', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.819128');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '846329059', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.819128');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '800659646', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.819128');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '805635075', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.822706');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '886851700', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.822706');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '819215747', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.822706');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '889934227', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.826291');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '809175925', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.826291');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '864642931', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.826291');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '824353904', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.826291');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '843768332', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.829848');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '885079195', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.829848');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '832026215', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.829848');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '853841661', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.829848');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '899112450', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.829848');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '859728672', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.833957');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '853818812', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.833957');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '854847475', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.833957');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '837305547', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.839716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '840094865', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.839716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '811106611', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.839716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '837617427', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.839716');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '858954736', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.843953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '816700668', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.843953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '808873241', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.847975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '866010559', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.847975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '865998380', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.847975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '854928401', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.847975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '838426366', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.847975');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '856053536', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.851718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '824710122', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.851718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '800262179', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.851718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '847111097', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.851718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '844866931', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.8579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '840864548', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.8579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '853833870', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.8579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '863704750', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.8579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '850178064', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.867718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '899217988', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.867718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '835011792', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.867718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '820364254', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.867718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '842192029', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.867718');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '819466878', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.871573');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '873475613', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.871573');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '858314589', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.871573');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '895875589', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.871573');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '805387170', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.871573');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '815068004', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.871573');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '830053040', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.876249');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '808340802', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.876249');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '881022152', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.876249');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '827674772', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.876249');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '846054241', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.879848');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '806691308', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.879848');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '865320028', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.883497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '846023615', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.883497');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '822824963', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.887559');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '889997531', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.887559');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '848189078', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.891218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '876267524', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.891218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '833510033', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.891218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '819898599', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.894941');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '889987138', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.894941');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '853001877', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.898469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '814999762', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.898469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '891298662', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.898469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '817529789', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.898469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '803984268', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.902597');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '820592381', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.90585');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '897972546', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.90585');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '875062733', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.90585');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '852700091', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.90585');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '815185914', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.909917');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '834693586', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.914874');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '855109755', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.914874');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '849276543', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.918915');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '820510385', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.918915');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '832442866', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.922828');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '868527173', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.922828');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '896537965', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.922828');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '869765393', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.926704');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '878631146', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.930568');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '893022828', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.930568');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '870488667', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.930568');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '885693391', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.93358');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '877588354', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.93358');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '835353921', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.937185');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '862576386', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.937185');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '855839558', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.937185');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '877306625', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.941041');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '857990940', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.941041');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '855059723', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.944698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '832427770', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.944698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '832190627', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.944698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '892239323', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.948532');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '899413636', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.948532');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '804944614', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.948532');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '890674385', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.951762');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '803393633', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.951762');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '824106789', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.951762');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '882122217', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.951762');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '859439629', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.95543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '816467453', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.95543');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '895579410', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.958692');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '816662201', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.958692');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '852642017', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.958692');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '856716152', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.958692');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '855383952', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.962905');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '802584307', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.962905');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '827140608', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.966796');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '882331842', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.966796');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '801619866', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.966796');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '825030543', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.966796');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '861837698', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.971343');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '829811962', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.971343');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '822242899', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.971343');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '855141426', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.975256');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '864311384', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.975256');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '830236604', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.975256');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '836452543', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.975256');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '892225109', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.97931');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '810762223', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.97931');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '837437935', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.983432');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '815177890', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.983432');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '802444869', 'VIRKSOMHET', '1', '2023-09-27 12:47:44.983432');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '846357403', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.987484');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '894125644', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.987484');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '860079548', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.990699');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '850727134', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.990699');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '897600352', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.990699');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '865176224', 'VIRKSOMHET', '2', '2023-09-27 12:47:44.995125');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '841023274', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.995125');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '858767970', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.995125');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '815013773', 'VIRKSOMHET', '3', '2023-09-27 12:47:44.995125');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '806551335', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.000261');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '862063648', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.000261');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '829511190', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.005061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '890504212', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.005061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '839750510', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.005061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '859077713', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.005061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '807085015', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.008885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '820154219', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.008885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '854770517', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.008885');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '855050206', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.013445');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '889128185', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.013445');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '806386500', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.01679');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '866865790', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.01679');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '823546398', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.01679');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '809817182', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.01679');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '886965332', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.020637');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '837006317', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.020637');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '859791871', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.020637');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '839648076', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.024187');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '886374702', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.024187');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '801018012', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.024187');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '874911010', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.027603');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '879283512', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.027603');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '811427024', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.027603');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '866768166', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.031106');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '808374138', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.031106');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '892584778', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.031106');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '890289304', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.034118');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '897993099', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.034118');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '838203900', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.034118');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '820357215', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.037982');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '825011425', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.037982');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '858637744', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.037982');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '807877858', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.041669');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '856450848', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.041669');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '899941610', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.041669');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '811875102', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.045535');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '879885713', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.045535');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '885482062', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.045535');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '866886570', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.049184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '890616652', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.049184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '862722287', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.049184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '886375261', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.049184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '896357373', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.052537');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '866677637', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.052537');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '850099558', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.052537');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '859820298', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.052537');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '888812048', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.056085');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '821080096', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.056085');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '898108054', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.059201');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '842021484', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.059201');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '880853424', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.059201');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '833088737', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.063006');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '824370623', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.063006');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '859886502', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.063006');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '881709672', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.068883');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '878183875', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.068883');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '871061073', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.068883');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '834151829', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.068883');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '895917367', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.068883');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '884414162', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.072729');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '859150008', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.072729');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '896355742', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.072729');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '800747683', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.075846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '857037705', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.075846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '897975138', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.075846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '807173400', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.075846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '853864887', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.079868');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '844632422', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.079868');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '844666006', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.079868');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '802555928', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.079868');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '816641469', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.083185');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '878284938', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.083185');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '833167762', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.083185');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '852738491', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.083185');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '854600919', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.08815');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '891686706', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.08815');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '800994018', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.08815');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '885343199', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.091775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '814097367', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.091775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '855405477', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.091775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '871110892', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.095519');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '889302409', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.095519');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '862650554', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.095519');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '856323024', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.099246');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '865957763', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.099246');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '809997464', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.099246');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '892037204', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.099246');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '855209391', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.102733');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '852675187', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.102733');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '875190936', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.102733');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '878772022', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.102733');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '875906777', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.10584');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '867050630', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.10584');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '899626977', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.10584');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '847716706', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.110256');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '819302627', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.110256');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '886536405', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.110256');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '861719015', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.113743');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '858181803', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.113743');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '896147751', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.113743');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '825362503', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.117955');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '873037031', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.117955');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '808933296', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.117955');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '856311115', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.117955');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '841062282', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.12163');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '839896151', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.12546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '808119254', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.12546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '868411463', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.12546');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '845923614', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.129027');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '879136681', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.129027');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '849262935', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.129027');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '806920595', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.129027');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '880756394', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.132253');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '880104024', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.132253');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '801556211', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.132253');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '819264022', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.137618');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '848716349', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.137618');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '825277344', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.142835');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '819827494', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.142835');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '846662600', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.142835');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '874024359', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.142835');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '821366281', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.146276');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '808210382', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.146276');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '826428237', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.146276');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '815054956', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.146276');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '818328814', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.149018');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '807556210', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.149018');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '871418690', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.149018');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '813082052', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.152014');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '806846003', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.152014');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '824330847', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.155208');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '826690138', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.159375');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '856403693', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.159375');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '816621697', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.159375');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '816554758', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.163326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '857535371', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.163326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '823784313', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.166301');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '891396939', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.166301');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '890803412', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.166301');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '864310341', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.169507');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '852154283', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.169507');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '845274259', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.169507');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '845587063', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.173163');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '827331930', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.173163');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '869238003', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.173163');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '852723183', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.173163');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '815069674', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.176492');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '824320547', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.176492');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '858685635', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.176492');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '829626868', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.180125');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '869197746', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.180125');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '896311843', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.180125');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '872643712', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.183778');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '829662663', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.183778');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '845972124', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.183778');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '848464680', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.183778');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '820268569', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.189468');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '820015256', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.189468');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '844573903', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.192896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '882085748', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.192896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '867428946', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.192896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '871031437', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.192896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '843532169', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.192896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '857146415', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.192896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '858809768', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.196956');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '876716164', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.196956');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '819492088', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.200033');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '838239624', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.200033');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '885945837', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.200033');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '861498828', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.200033');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '801804711', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.204184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '833509017', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.204184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '827952461', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.204184');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '899971016', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.207823');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '851522918', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.207823');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '876958842', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.207823');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '800056603', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.211251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '843586867', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.211251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '823345513', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.211251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '848090389', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.211251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '813124156', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.21473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '806937760', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.21473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '804492254', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.217638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '850961994', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.217638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '811452235', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.217638');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '800196588', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.221469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '824251872', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.221469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '805680022', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.221469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '802238763', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.221469');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '897656556', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.225166');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '888995913', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.225166');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '867259951', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.228816');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '820227377', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.228816');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '882903192', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.228816');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '879854654', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.232077');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '873775499', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.232077');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '875055030', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.235409');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '815969576', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.235409');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '881921956', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.238275');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '849890085', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.238275');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '826229102', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.241262');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '836656384', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.241262');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '888666767', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.25085');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '876273225', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.254941');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '828273134', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.258114');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '875963341', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.258114');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '868652293', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.258114');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '883630024', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.26537');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '840784333', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.26537');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '808962472', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.26537');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '814148414', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.268959');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '831273899', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.271698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '891530477', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.271698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '828050340', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.271698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '852320416', 'VIRKSOMHET', '2', '2023-09-27 12:47:45.274917');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '888715453', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.274917');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '851324073', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.274917');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '860093107', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.274917');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '871363593', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.278118');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '871257202', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.278118');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (533, '897037627', 'VIRKSOMHET', '1', '2023-09-27 12:47:45.281262');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (534, '880765618', 'VIRKSOMHET', '3', '2023-09-27 12:47:45.281262');


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

SELECT pg_catalog.setval('public.sykefravar_statistikk_bransje_id_seq', 7, true);


--
-- Name: sykefravar_statistikk_kategori_siste_4_kvartal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_kategori_siste_4_kvartal_id_seq', 95, true);


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

SELECT pg_catalog.setval('public.sykefravar_statistikk_virksomhet_id_seq', 534, true);


--
-- Name: sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq', 534, true);


--
-- Name: virksomhet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_id_seq', 511, true);


--
-- Name: virksomhet_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_metadata_id_seq', 534, true);


--
-- Name: virksomhet_naringsundergrupper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_naringsundergrupper_id_seq', 511, true);


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
-- Name: TABLE virksomhetsstatistikk_for_prioritering; Type: ACL; Schema: public; Owner: test
--

GRANT ALL ON TABLE public.virksomhetsstatistikk_for_prioritering TO cloudsqliamuser;


--
-- Name: virksomhetsstatistikk_for_prioritering; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: test
--

REFRESH MATERIALIZED VIEW public.virksomhetsstatistikk_for_prioritering;


--
-- PostgreSQL database dump complete
--

